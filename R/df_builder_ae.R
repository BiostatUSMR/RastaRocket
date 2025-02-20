#' Prepare a dataframe for creating AE plots
#' 
#' @param df_soc_pt A data frame mapping system organ classes (SOC) to preferred terms (PT). 
#' Must contain columns `soc` (System Organ Class) and `pt` (Preferred Term).
#' @param df_pat_grp A data frame of patient groups. Must contain columns `id_pat` (patient ID) 
#' and `grp` (group assignment).
#' @param df_pat_pt A data frame linking patients to adverse event system organ classes. 
#' Must contain columns `id_pat` (patient ID) and `pt` (Preferred Term).
#' @param ref_grp (Optional) A reference group for comparisons. Defaults to the first group in `df_pat_grp`.
#' 
#' @return A dataframe with all the info to build AE plots
#' 
#' @export
df_builder_ae <- function(df_soc_pt,
                          df_pat_grp,
                          df_pat_pt,
                          ref_grp = NULL){
  
  vec_pt <- unique(df_pat_pt$pt)
  vec_grp <- unique(df_pat_grp$grp)
  
  if(is.null(ref_grp)){
    ref_grp <- vec_grp[1]
  }
  
  ########## Data preparation
  
  grid_pt_grp <- expand.grid(grp = vec_grp,
                              pt = vec_pt)
  
  ##### Nb EI per arm
  
  df_nb_ei_per_arm <- df_pat_pt |> 
    left_join(df_pat_grp, by = "id_pat") |> 
    group_by(grp, pt) |> 
    summarise(nb_ei = n(),
              .groups = "drop") |> 
    full_join(grid_pt_grp, by = c("grp", "pt")) |> 
    left_join(df_soc_pt, by = "pt") |> 
    mutate(nb_ei = if_else(is.na(nb_ei), 0, nb_ei))
  
  ##### Proportion of patient with EI per arm
  
  df_nb_pat_per_grp <- df_pat_grp |> 
    group_by(grp) |> 
    summarise(nb_pat_per_grp = n(),
              .groups = "drop")
  
  df_freq_pat <- df_pat_pt |> 
    dplyr::select(id_pat, pt) |> 
    distinct() |> 
    left_join(df_pat_grp, by = "id_pat") |> 
    group_by(pt, grp) |> 
    summarise(nb_pat = n(),
              .groups = "drop") |> 
    full_join(grid_pt_grp, by = c("pt", "grp")) |> 
    left_join(df_nb_pat_per_grp, by = "grp") |> 
    dplyr::mutate(nb_pat = if_else(is.na(nb_pat), 0, nb_pat),
                  freq_pat = nb_pat/nb_pat_per_grp) |> 
    left_join(df_soc_pt, by = "pt")
  
  ##### Confidence interval
  
  df_confidence_interval <- lapply(vec_pt,
                                   function(pt_i){
                                     df_i <-  df_freq_pat |> filter(pt == pt_i)
                                     
                                     nb_disease_exposed <- df_i |> filter(grp == vec_grp[1]) |> pull(nb_pat)
                                     nb_disease_nonexposed <- df_i |> filter(grp == vec_grp[2]) |> pull(nb_pat)
                                     pop_at_risk_exposed <- df_i |> filter(grp == vec_grp[1]) |> pull(nb_pat_per_grp)
                                     pop_at_risk_nonexposed <- df_i |> filter(grp == vec_grp[2]) |> pull(nb_pat_per_grp)
                                     
                                     res <- riskdifference(a = nb_disease_exposed, N1 = pop_at_risk_exposed,
                                                           b = nb_disease_nonexposed, N0 = pop_at_risk_nonexposed)
                                     
                                     res <- data.frame(pt = pt_i,
                                                       RD = res$estimate,
                                                       CIinf = res$conf.int[1],
                                                       CIsup = res$conf.int[2],
                                                       p_val = res$p.value)
                                     
                                     return(res)
                                   }) |> 
    bind_rows() |> 
    left_join(df_soc_pt, by = "pt") |> 
    mutate(significant_bool = p_val < 0.05,
           significant_label = factor(significant_bool, levels = c(T,F), labels = c("*", "")))
  
  ##### Combine df
  
  df_all <- list(
    df_nb_ei_per_arm |>
      select(pt, soc, grp, nb_ei) |> 
      mutate(facet = "Total nb of AE"),
    df_freq_pat |> 
      select(pt, soc, grp, freq_pat, nb_pat) |> 
      mutate(facet = "Prop. of patients"),
    df_confidence_interval |> 
      select(pt, soc, RD, CIinf, CIsup, significant_bool, significant_label, p_val) |> 
      mutate(facet = "Risk difference with 95% CI")
  ) |> 
    bind_rows() |> 
    mutate(grp = as.factor(grp),
           grp = forcats::fct_relevel(grp, ref_grp),
           grp_num = if_else(grp == ref_grp, 0, 1),
           pt = forcats::fct_reorder(pt, RD, .na_rm = TRUE))
  
  return(df_all)
  
}
