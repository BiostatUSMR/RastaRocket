#' Prepare a dataframe for creating AE plots
#' 
#' @param df_soc_pt A data frame mapping system organ classes (SOC) to preferred terms (PT). 
#' Must contain columns `soc` (System Organ Class) and `pt` (Preferred Term).
#' @param df_pat_grp A data frame of patient groups. Must contain columns `id_pat` (patient ID) 
#' and `grp` (group assignment).
#' @param df_pat_soc A data frame linking patients to adverse event system organ classes. 
#' Must contain columns `id_pat` (patient ID) and `soc` (System Organ Class).
#' @param ref_grp (Optional) A reference group for comparisons. Defaults to the first group in `df_pat_grp`.
#' 
#' @return A dataframe with all the info to build AE plots
#' 
#' @export
df_builder_ae <- function(df_soc_pt,
                          df_pat_grp,
                          df_pat_soc,
                          ref_grp = NULL){
  
  vec_soc <- unique(df_pat_soc$soc)
  vec_grp <- unique(df_pat_grp$grp)
  
  if(is.null(ref_grp)){
    ref_grp <- vec_grp[1]
  }
  
  ########## Data preparation
  
  grid_soc_grp <- expand.grid(grp = vec_grp,
                              soc = vec_soc)
  
  ##### Nb EI per arm
  
  df_nb_ei_per_arm <- df_pat_soc |> 
    left_join(df_pat_grp, by = "id_pat") |> 
    group_by(grp, soc) |> 
    summarise(nb_ei = n(),
              .groups = "drop") |> 
    full_join(grid_soc_grp, by = c("grp", "soc")) |> 
    left_join(df_soc_pt, by = "soc") |> 
    mutate(nb_ei = if_else(is.na(nb_ei), 0, nb_ei))
  
  ##### Proportion of patient with EI per arm
  
  df_nb_pat_per_grp <- df_pat_grp |> 
    group_by(grp) |> 
    summarise(nb_pat_per_grp = n(),
              .groups = "drop")
  
  df_freq_pat <- df_pat_soc |> 
    dplyr::select(id_pat, soc) |> 
    distinct() |> 
    left_join(df_pat_grp, by = "id_pat") |> 
    group_by(soc, grp) |> 
    summarise(nb_pat = n(),
              .groups = "drop") |> 
    full_join(grid_soc_grp, by = c("soc", "grp")) |> 
    left_join(df_nb_pat_per_grp, by = "grp") |> 
    dplyr::mutate(nb_pat = if_else(is.na(nb_pat), 0, nb_pat),
                  freq_pat = nb_pat/nb_pat_per_grp) |> 
    left_join(df_soc_pt, by = "soc")
  
  ##### Confidence interval
  
  df_confidence_interval <- lapply(vec_soc,
                                   function(soc_i){
                                     df_i <-  df_freq_pat |> filter(soc == soc_i)
                                     
                                     nb_disease_exposed <- df_i |> filter(grp == vec_grp[1]) |> pull(nb_pat)
                                     nb_disease_nonexposed <- df_i |> filter(grp == vec_grp[2]) |> pull(nb_pat)
                                     pop_at_risk_exposed <- df_i |> filter(grp == vec_grp[1]) |> pull(nb_pat_per_grp)
                                     pop_at_risk_nonexposed <- df_i |> filter(grp == vec_grp[2]) |> pull(nb_pat_per_grp)
                                     
                                     res <- riskdifference(a = nb_disease_exposed, N1 = pop_at_risk_exposed,
                                                           b = nb_disease_nonexposed, N0 = pop_at_risk_nonexposed)
                                     
                                     res <- data.frame(soc = soc_i,
                                                       RD = res$estimate,
                                                       CIinf = res$conf.int[1],
                                                       CIsup = res$conf.int[2],
                                                       p_val = res$p.value)
                                     
                                     return(res)
                                   }) |> 
    bind_rows() |> 
    left_join(df_soc_pt, by = "soc") |> 
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
           soc = forcats::fct_reorder(soc, RD, .na_rm = TRUE))
  
  return(df_all)
  
}
