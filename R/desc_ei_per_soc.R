# main function -----------------------------------------------------------

#' desc_ei_per_soc
#' 
#' A function to describe AE by soc and pt
#'
#' @param df_soc_pt A dataframe with two columns: pt and soc
#' @param df_pat_grp A dataframe with two columns: id_pat and grp (the rct arm)
#' @param df_pat_soc A dataframe with two columns: id_pat and soc
#'
#' @return A gt table
#' @export
#'
#' @examples
#' df_soc_pt <- data.frame(
#'   soc = c("Arrhythmia",
#'           "Myocardial Infarction",
#'           "Pneumonia",
#'           "Sepsis"),
#'   pt = c("Cardiac Disorders",
#'          "Cardiac Disorders",
#'          "Infections",
#'          "Infections")
#' )
#' 
#' df_pat_grp <- data.frame(id_pat = paste0("ID_", 1:10),
#'                          grp = c(rep("A", 3), rep("B", 3), rep("C", 4)))
#' 
#' df_pat_soc <- data.frame(id_pat = c("ID_1", "ID_1",
#'                                     "ID_2",
#'                                     "ID_4",
#'                                     "ID_9"),
#'                          soc = c("Arrhythmia", "Myocardial Infarction",
#'                                  "Arrhythmia", "Pneumonia",
#'                                  "Pneumonia"))
#' 
#' desc_ei_per_soc(df_soc_pt = df_soc_pt,
#'                 df_pat_grp = df_pat_grp,
#'                 df_pat_soc = df_pat_soc)
#' 
desc_ei_per_soc <- function(df_soc_pt,
                            df_pat_grp,
                            df_pat_soc){
  
  ##### Build augmented df, Total is a whole new group
  
  augmented_df_pat_grp <- dplyr::bind_rows(df_pat_grp,
                                           df_pat_grp |>
                                             dplyr::mutate(grp = "Total"))
  
  vec_grp <- unique(augmented_df_pat_grp$grp)
  
  augmented_df_pat_soc_grp <- df_pat_soc |> 
    dplyr::left_join(augmented_df_pat_grp,
                     by = "id_pat",
                     relationship = "many-to-many") |> 
    dplyr::left_join(df_soc_pt,
                     by = "soc")
  
  ##### Build wide dataframe
  
  df_wide <- desc_ei_per_soc_prepare_df(augmented_df_pat_grp = augmented_df_pat_grp,
                                        augmented_df_pat_soc_grp = augmented_df_pat_soc_grp)
  
  ##### gt part
  
  res <- desc_ei_per_soc_df_to_gt(df_wide = df_wide,
                                  vec_grp = vec_grp)
  
  return(res)
}


# desc_ei_per_soc_prepare_df ----------------------------------------------

#' Prepare Data for AE Description by SOC and PT
#'
#' This function processes patient and adverse event data to generate a wide-format summary dataframe,
#' including total counts and percentages of events and patients per SOC (System Organ Class) and PT (Preferred Term).
#'
#' @param augmented_df_pat_grp A dataframe containing patient IDs and group assignments, including a "Total" group.
#' @param augmented_df_pat_soc_grp A dataframe linking patient IDs to SOC and PT, with group assignments.
#'
#' @return A wide-format dataframe summarizing adverse event occurrences and patient counts across groups.
#' @importFrom purrr reduce
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' df_wide <- desc_ei_per_soc_prepare_df(augmented_df_pat_grp, augmented_df_pat_soc_grp)
#' }
desc_ei_per_soc_prepare_df <- function(augmented_df_pat_grp,
                                       augmented_df_pat_soc_grp){
  
  ##### compute summary statistics per group
  
  df_nb_pat_per_grp <- augmented_df_pat_grp |> 
    dplyr::group_by(grp) |> 
    dplyr::summarise(nb_pat_per_grp = n())
  
  df_ei_total <- augmented_df_pat_soc_grp |> 
    dplyr::group_by(grp) |> 
    dplyr::summarise(nb_ei = n(),
                     pct_ei = 100,
                     nb_pat = length(unique(id_pat)),
                     .groups = "drop") |> 
    dplyr::left_join(df_nb_pat_per_grp, by = "grp") |> 
    dplyr::mutate(pct_pat = nb_pat/nb_pat_per_grp*100,
                  pt = "Total",
                  soc = "Total") |> 
    dplyr::select(pt, soc, grp, nb_ei, pct_ei, nb_pat, pct_pat)
  
  ##### compute summary statisticsby SOC and PT
  df_wide <- list(soc = c("grp", "soc", "pt"),
                  pt = c("grp", "pt")) |> 
    lapply(function(vec_grp_by){
      temp <- augmented_df_pat_soc_grp |> 
        dplyr::group_by(across(all_of(vec_grp_by))) |> 
        dplyr::summarise(nb_ei = n(),
                         nb_pat = length(unique(id_pat)),
                         .groups = "drop") |> 
        dplyr::left_join(df_ei_total |> 
                           dplyr::select(grp, nb_ei_denom = nb_ei),
                         by = "grp") |> 
        dplyr::left_join(df_nb_pat_per_grp,
                         by = "grp") |> 
        dplyr::mutate(pct_pat = nb_pat/nb_pat_per_grp*100,
                      pct_ei = nb_ei/nb_ei_denom*100)
      
      if(!"soc" %in% colnames(temp)){
        temp$soc <- "Total"
      }
      
      res <- temp |> 
        dplyr::select(pt, soc, grp, nb_ei, pct_ei, nb_pat, pct_pat)
      
      return(res)
    }) |> 
    bind_rows() |> 
    ### add total ei dataset
    bind_rows(df_ei_total) |> 
    ### Arrange dataframe for visualization
    mutate(across(c("pt", "soc", "grp"), as.factor),
           across(c("pt", "soc", "grp"), function(x) forcats::fct_relevel(x, "Total"))) |> 
    dplyr::arrange(pt, soc, grp) |> 
    ### Go to wide format with correct names
    dplyr::group_by(grp) |> 
    dplyr::group_split() |> 
    lapply(function(df_i){
      grp_i <- df_i |> dplyr::pull(grp) |> unique()
      df_i |> 
        dplyr::select(-grp) |> 
        dplyr::rename_with(.cols = c("nb_ei", "pct_ei", "nb_pat", "pct_pat"),
                           .fn = function(x) paste0(grp_i, "_", x))
    }) |> 
    purrr::reduce(full_join, by = c("pt", "soc"))
  
  return(df_wide)
  
}


# desc_ei_per_soc_df_to_gt ------------------------------------------------

#' Convert AE Summary Data to GT Table
#'
#' This function takes a prepared wide-format dataframe summarizing adverse events and patients
#' and converts it into a formatted `gt` table for easy visualization.
#'
#' @param df_wide A wide-format dataframe containing summarized AE data.
#' @param vec_grp A character vector of group names for which AE data is presented.
#'
#' @return A `gt` table formatted with appropriate labels, spans, and styling.
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' gt_table <- desc_ei_per_soc_df_to_gt(df_wide, vec_grp)
#' }
desc_ei_per_soc_df_to_gt <- function(df_wide,
                                     vec_grp){
  ### Create the gt table and labels
  
  gt_temp <- df_wide |> 
    dplyr::group_by(pt) |> 
    gt::gt() |> 
    gt::cols_label(
      pt = "PT",
      soc = gt::md("**Ev\u00e9nements ind\u00e9sirables**"),
      dplyr::ends_with("nb_ei") ~ gt::md("**N**"),
      dplyr::ends_with("nb_pat") ~ gt::md("**N**"),
      dplyr::ends_with("pct_ei") ~ gt::md("**%**"),
      dplyr::ends_with("pct_pat") ~ gt::md("**%**")
    )
  
  gt_temp2 <- gt_temp
  for (grp in vec_grp) {
    gt_temp2 <- gt_temp2 |> 
      gt::tab_spanner(label = gt::md("**EI**"),
                      id = glue::glue("EI_{grp}"),
                      columns = c(glue::glue("{grp}_nb_ei"),
                                  glue::glue("{grp}_pct_ei"))) |> 
      gt::tab_spanner(label = gt::md("**Patients**"),
                      id = glue::glue("Patients_{grp}"),
                      columns = c(glue::glue("{grp}_nb_pat"),
                                  glue::glue("{grp}_pct_pat"))) |> 
      gt::tab_spanner(label = gt::md(glue::glue("**{grp}**")),
                      id = glue::glue("over_{grp}"),
                      columns = c(glue::glue("{grp}_nb_ei"),
                                  glue::glue("{grp}_pct_ei"),
                                  glue::glue("{grp}_nb_pat"),
                                  glue::glue("{grp}_pct_pat")))
  }
  
  ### color table
  
  res <- gt_temp2 |> 
    gt::fmt_number(decimals = 0, columns = dplyr::matches("pct_")) |> 
    gt::sub_missing(missing_text = "") |> 
    gt::cols_align(align = "left",
                   columns = dplyr::everything()) |> 
    gt::tab_style(
      locations = gt::cells_body(rows = soc == "Total"),
      style = gt::cell_fill(color = "lightblue" |>
                              gt::adjust_luminance(steps = +1))
    ) |> 
    gt::tab_style(
      locations = gt::cells_row_groups(),
      style = gt::cell_fill(color = "#c5c5c5" |>
                              gt::adjust_luminance(steps = +1))
    ) |> 
    gt::tab_style(
      locations = gt::cells_row_groups(),
      style = gt::cell_text(weight = "bold")
    )
  
  return(res)
}

