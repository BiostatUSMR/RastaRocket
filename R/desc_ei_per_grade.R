# main function -----------------------------------------------------------

#' desc_ei_per_grade
#' 
#' A function to describe adverse events (AE) by grade.
#'
#' @param df_pat_grp A dataframe with two columns: id_pat and grp (the RCT arm).
#' @param df_pat_grade A dataframe with two columns: id_pat and grade.
#'
#' @return A gt table summarizing the AE by grade.
#' @export
#'
#' @examples
#' df_pat_grp <- data.frame(id_pat = paste0("ID_", 1:10),
#'                          grp = c(rep("A", 3), rep("B", 3), rep("C", 4)))
#' 
#' df_pat_grade <- data.frame(id_pat = c("ID_1", "ID_1",
#'                                       "ID_2",
#'                                       "ID_4",
#'                                       "ID_9"),
#'                            grade = c(1, 3,
#'                                      4,
#'                                      2,
#'                                      4))
#' 
#' desc_ei_per_grade(df_pat_grp = df_pat_grp,
#'                   df_pat_grade = df_pat_grade)
#' 
desc_ei_per_grade <- function(df_pat_grp,
                              df_pat_grade){
  
  ##### clean type and df
  
  df_pat_grp <- df_pat_grp |> 
    transmute(across(c(id_pat, grp),
                     as.character))
  
  df_pat_grade <- df_pat_grade |> 
    transmute(id_pat = as.character(id_pat),
              grade = as.numeric(grade))
  
  ##### Build augmented df, Total is a whole new group
  
  nb_grp <- length(unique(df_pat_grp$grp))
  
  if(nb_grp > 1){
    augmented_df_pat_grp <- dplyr::bind_rows(df_pat_grp,
                                             df_pat_grp |>
                                               dplyr::mutate(grp = "Total"))
  } else {
    augmented_df_pat_grp <- df_pat_grp |> dplyr::mutate(grp = "Total")
  }
  
  vec_grp <- unique(augmented_df_pat_grp$grp)
  
  augmented_df_pat_grade_grp <- df_pat_grade |> 
    dplyr::left_join(augmented_df_pat_grp,
                     by = "id_pat",
                     relationship = "many-to-many") |> 
    dplyr::mutate(grade = as.character(grade))
  
  
  ##### Prepare df_wide
  
  df_wide <- desc_ei_per_grade_prepare_df(augmented_df_pat_grp = augmented_df_pat_grp,
                                          augmented_df_pat_grade_grp = augmented_df_pat_grade_grp)
  
  ##### gt part
  
  res <- desc_ei_per_grade_df_to_gt(df_wide = df_wide,
                                    vec_grp = vec_grp)
  
  return(res)
}


# desc_ei_per_grade_prepare_df --------------------------------------------


#' desc_ei_per_grade_prepare_df
#' 
#' Prepares a wide-format dataframe summarizing AE by grade and group.
#'
#' @param augmented_df_pat_grp A dataframe with patient IDs and groups, including a "Total" group.
#' @param augmented_df_pat_grade_grp A dataframe with patient IDs, grades, and groups.
#'
#' @return A dataframe in wide format with AE counts and percentages by grade and group.
#' @keywords internal
desc_ei_per_grade_prepare_df <- function(augmented_df_pat_grp,
                                         augmented_df_pat_grade_grp){
  ##### Build wide dataframe
  
  df_nb_pat_per_grp <- augmented_df_pat_grp |> 
    dplyr::group_by(grp) |> 
    dplyr::summarise(nb_pat_per_grp = n())
  
  df_ei_total <- augmented_df_pat_grade_grp |> 
    dplyr::group_by(grp) |> 
    dplyr::summarise(nb_ei = n(),
                     pct_ei = 100,
                     nb_pat = length(unique(id_pat)),
                     .groups = "drop") |> 
    dplyr::left_join(df_nb_pat_per_grp, by = "grp") |> 
    dplyr::mutate(pct_pat = nb_pat/nb_pat_per_grp*100,
                  grade = "Total") |> 
    dplyr::select(grade, grp, nb_ei, pct_ei, nb_pat, pct_pat)
  
  ##### compute summary statisticsby SOC and PT
  df_wide <- augmented_df_pat_grade_grp |> 
    dplyr::group_by(grp, grade) |> 
    dplyr::summarise(nb_ei = n(),
                     nb_pat = length(unique(id_pat)),
                     .groups = "drop") |> 
    dplyr::left_join(df_ei_total |> 
                       dplyr::select(grp, nb_ei_denom = nb_ei),
                     by = "grp") |> 
    dplyr::left_join(df_nb_pat_per_grp,
                     by = "grp") |> 
    dplyr::mutate(pct_pat = nb_pat/nb_pat_per_grp*100,
                  pct_ei = nb_ei/nb_ei_denom*100) |> 
    dplyr::select(grade, grp, nb_ei, pct_ei, nb_pat, pct_pat) |> 
    ### add total ei dataset
    bind_rows(df_ei_total) |> 
    ### Arrange dataframe for visualization
    mutate(across(c("grade", "grp"), as.factor),
           across(c("grade", "grp"), function(x) forcats::fct_relevel(x, "Total"))) |> 
    dplyr::arrange(grade, grp) |> 
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
    purrr::reduce(full_join, by = c("grade"))
  
  return(df_wide)
  
}

# desc_ei_per_grade_df_to_gt ----------------------------------------------

#' desc_ei_per_grade_df_to_gt
#' 
#' Converts the processed AE grade dataframe into a gt table for visualization.
#'
#' @param df_wide A wide-format dataframe summarizing AE counts and percentages by grade and group.
#' @param vec_grp A vector of unique group names.
#'
#' @return A formatted gt table.
#' @keywords internal
desc_ei_per_grade_df_to_gt <- function(df_wide,
                                       vec_grp){
  
  ### Create the gt table and labels
  
  gt_temp <- df_wide |> 
    gt::gt() |> 
    gt::cols_label(
      grade = gt::md("**Grade**"),
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
      locations = gt::cells_body(rows = grade == "Total"),
      style = gt::cell_text(weight = "bold",
                            style = "italic")
    )
  
  return(res)
}