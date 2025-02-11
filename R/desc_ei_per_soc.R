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


library(gt)
library(tidyverse)

df_soc_pt <- data.frame(soc = c("Arrhythmia", "Myocardial Infarction", "Pneumonia", "Sepsis"),
                        pt = c("Cardiac Disorders", "Cardiac Disorders", "Infections", "Infections"))

df_pat_grp <- data.frame(id_pat = paste0("ID_", 1:10),
                         grp = c(rep("A", 3), rep("B", 3), rep("C", 4)))

df_pat_soc <- data.frame(id_pat = c("ID_1", "ID_1",
                                    "ID_2",
                                    "ID_4",
                                    "ID_9"),
                         soc = c("Arrhythmia", "Myocardial Infarction",
                                 "Arrhythmia", "Pneumonia",
                                 "Pneumonia"))

desc_ei_per_soc(df_soc_pt = df_soc_pt,
                df_pat_grp = df_pat_grp,
                df_pat_soc = df_pat_soc)

desc_ei_per_soc <- function(df_soc_pt,
                            df_pat_grp,
                            df_pat_soc){
  
  ##### Total
  
  ### Build augmented df, Total is a whole new group
  
  df_pat_pt_soc_grp <- df_pat_soc |> 
    left_join(df_pat_grp, by = "id_pat") |> 
    left_join(df_soc_pt, by = "soc")
  
  augmented_df_pat_soc_grp <- bind_rows(df_pat_pt_soc_grp,
                                        df_pat_pt_soc_grp |>
                                          mutate(grp = "Total"))
  
  augmented_df_pat_grp <- bind_rows(df_pat_grp,
                                    df_pat_grp |>
                                      mutate(grp = "Total"))
  
  ### compute summary statistics per group
  
  df_nb_pat_per_grp <- augmented_df_pat_grp |> 
    group_by(grp) |> 
    summarise(nb_pat_per_grp = n())
  
  df_ei_total <- augmented_df_pat_soc_grp |> 
    group_by(grp) |> 
    summarise(nb_ei = n(),
              pct_ei = 100,
              nb_pat = length(unique(id_pat)),
              .groups = "drop") |> 
    left_join(df_nb_pat_per_grp, by = "grp") |> 
    mutate(pct_pat = nb_pat/nb_pat_per_grp*100,
           pt = "Total",
           soc = "Total") |> 
    select(pt, soc, grp, nb_ei, pct_ei, nb_pat, pct_pat)
  
  ##### SOC
  
  df_ei_pt <- augmented_df_pat_soc_grp |> 
    group_by(grp, pt) |> 
    summarise(nb_ei = n(),
              nb_pat = length(unique(id_pat)),
              .groups = "drop") |> 
    left_join(df_ei_total |> 
                select(grp, nb_ei_denom = nb_ei),
              by = "grp") |> 
    left_join(df_nb_pat_per_grp,
              by = "grp") |> 
    mutate(pct_pat = nb_pat/nb_pat_per_grp*100,
           pct_ei = nb_ei/nb_ei_denom*100,
           soc = "Total") |> 
    select(pt, soc, grp, nb_ei, pct_ei, nb_pat, pct_pat)
  
  df_ei_soc <- augmented_df_pat_soc_grp |> 
    group_by(grp, soc, pt) |> 
    summarise(nb_ei = n(),
              nb_pat = length(unique(id_pat)),
              .groups = "drop") |> 
    left_join(df_ei_total |> 
                select(grp, nb_ei_denom = nb_ei),
              by = "grp") |> 
    left_join(df_nb_pat_per_grp,
              by = "grp") |> 
    mutate(pct_pat = nb_pat/nb_pat_per_grp*100,
           pct_ei = nb_ei/nb_ei_denom*100) |> 
    select(pt, soc, grp, nb_ei, pct_ei, nb_pat, pct_pat)
  
  ##### Build dataframe for visualization
  
  list_all <- bind_rows(df_ei_total,
                        df_ei_pt,
                        df_ei_soc) |> 
    mutate(across(c("pt", "soc", "grp"), as.factor),
           across(c("pt", "soc", "grp"), function(x) forcats::fct_relevel(x, "Total"))) |> 
    arrange(pt, soc, grp) |> 
    group_by(grp) |> 
    group_split()
  
  df_wide <- lapply(list_all,
                    function(df_i){
                      grp_i <- df_i |> pull(grp) |> unique()
                      df_i |> 
                        select(-grp) |> 
                        rename_with(.cols = c("nb_ei", "pct_ei", "nb_pat", "pct_pat"),
                                    .fn = function(x) paste0(grp_i, "_", x))
                    }) |> 
    purrr::reduce(full_join, by = c("pt", "soc"))
  
  ##### gt part
  
  ### Create the gt table and labels
  
  gt_temp <- df_wide |> 
    group_by(pt) |> 
    gt::gt() |> 
    gt::cols_label(
      pt = "PT",
      soc = gt::md("**Evénements indésirables**"),
      dplyr::ends_with("nb_ei") ~ gt::md("**N**"),
      dplyr::ends_with("nb_pat") ~ gt::md("**N**"),
      dplyr::ends_with("pct_ei") ~ gt::md("**%**"),
      dplyr::ends_with("pct_pat") ~ gt::md("**%**")
    )
  
  gt_temp2 <- gt_temp
  for (grp in unique(augmented_df_pat_grp$grp)) {
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
