#' Prepare a dataframe for creating AE plots
#'
#' @param df_pat_llt A dataframe with columns: USUBJID (patient id), EINUM (AE id), llt (AE LLT), pt (AE PT), soc (AE SOC)
#' @param df_pat_grp A dataframe with two columns: USUBJID (Patient id) and RDGRPNAME (the RCT arm).
#' @param id_col Patient id column (default: "USUBJID").
#' @param group_col group column, the rct arm (default: "RDGRPNAME").
#' @param ei_num_col AE id column (default: "EINUM").
#' @param ei_llt_col AE LLT column (default: "EILLTN").
#' @param ei_soc_col AE SOC column (default: "EISOCPN").
#' @param ei_pt_col AE PT column (default: "EIPTN")
#' @param ref_grp (Optional) A reference group for comparisons. Defaults to the first group in `df_pat_grp`.
#'
#' @return A dataframe with all the info to build AE plots
#'
#' @export
df_builder_ae <- function(df_pat_grp,
                          df_pat_llt,
                          id_col = "USUBJID",
                          group_col = "RDGRPNAME",
                          ei_num_col = "EINUM",
                          ei_llt_col = "EILLTN",
                          ei_soc_col = "EISOCPN",
                          ei_pt_col = "EIPTN",
                          ref_grp = NULL){

  # id_col <- rlang::ensym(id_col)
  # group_col <- rlang::ensym(group_col)
  # ei_num_col <- rlang::ensym(ei_num_col)
  # ei_llt_col <- rlang::ensym(ei_llt_col)
  # ei_soc_col <- rlang::ensym(ei_soc_col)
  # ei_pt_col <- rlang::ensym(ei_pt_col)

  .col_sym <- function(x) {
    if (rlang::is_string(x)) {
      rlang::sym(x)
    } else {
      rlang::ensym(x)
    }
  }

  id_col <- .col_sym(id_col)
  group_col <- .col_sym(group_col)
  ei_num_col <- .col_sym(ei_num_col)
  ei_llt_col <- .col_sym(ei_llt_col)
  ei_soc_col <- .col_sym(ei_soc_col)
  ei_pt_col <- .col_sym(ei_pt_col)


  ##### Check column names

  if(any(!c(rlang::as_string(id_col), rlang::as_string(group_col)) %in% colnames(df_pat_grp))){
    stop(glue::glue("df_pat_grp should contain '{rlang::as_string(id_col)}' = the patient id and '{rlang::as_string(group_col)}' = the randomization group"))
  }

  if(any(!c(rlang::as_string(id_col), rlang::as_string(ei_num_col), rlang::as_string(ei_llt_col),
            rlang::as_string(ei_soc_col), rlang::as_string(ei_pt_col)) %in% colnames(df_pat_llt))){
    stop(glue::glue("df_pat_llt should contain '{rlang::as_string(id_col)}' = the patient id, '{rlang::as_string(ei_num_col)}' = the AE event number, '{rlang::as_string(ei_llt_col)}' = the AE LLT, '{rlang::as_string(ei_soc_col)}' = the AE SOC, and '{rlang::as_string(ei_pt_col)}' = the AE PT"))
  }

  ##### reconstruction des df

  df_pat_grp <- df_pat_grp |>
    dplyr::mutate(id_pat = as.character(!!id_col),
                  grp = as.character(!!group_col)) |>
    dplyr::distinct(id_pat, grp)

  df_pat_llt <- df_pat_llt |>
    dplyr::distinct(!!id_col, !!ei_llt_col, !!ei_soc_col, !!ei_pt_col, !!ei_num_col) |>
    dplyr::select(id_pat = !!id_col,
                  ei_num = !!ei_num_col,
                  pt = !!ei_pt_col,
                  soc = !!ei_soc_col) |>
    dplyr::mutate(id_pat = as.character(id_pat))


  ################ check and replace missing data ##################
  if(anyNA(df_pat_llt)){
    warning("Missing data are replaced from df_pat_llt by `unknown` please be careful!")
    df_pat_llt[is.na(df_pat_llt)] = "unknown"

  }

  if(anyNA(df_pat_grp)){
    warning("Missing data are replaced from df_pat_grp by `unknown` please be careful!")
    df_pat_grp[is.na(df_pat_grp)] = "unknown"
  }

  # vec_pt <- unique(df_pat_llt$EIPTN)
  # vec_grp <- unique(df_pat_grp$RDGRPNAME)
  #
  # if(is.null(ref_grp)){
  #   ref_grp <- vec_grp[1]
  # }

  vec_pt <- unique(df_pat_llt$pt)
  vec_grp <- unique(df_pat_grp$grp)

  if(is.null(ref_grp)){
    ref_grp <- vec_grp[1]
  }



  ########## Data preparation
  # df_SOC_PT <- df_pat_llt |>
  #   dplyr::distinct(EIPTN, EISOCPN)
  #
  # df_SOC_PT_GRP <- lapply(vec_grp,
  #        function(grp_i) df_SOC_PT |>
  #          dplyr::mutate(RDGRPNAME = grp_i)) |>
  #   bind_rows()
  ########## Data preparation  ---> MS

  df_soc_pt <- df_pat_llt |>
    dplyr::distinct(pt, soc)

  df_soc_pt_grp <- lapply(vec_grp,
                          function(grp_i) df_soc_pt |>
                            dplyr::mutate(grp = grp_i)) |>
    dplyr::bind_rows()


  ##### Nb EI per arm

  # df_nb_ei_per_arm <- df_pat_llt |>
  #   left_join(df_pat_grp, by = "USUBJID") |>
  #   group_by(RDGRPNAME, EIPTN) |>
  #   summarise(nb_ei = n_distinct(EINUM, USUBJID),
  #             .groups = "drop") |>
  #   full_join(df_SOC_PT_GRP, by = c("RDGRPNAME", "EIPTN")) |>
  #   mutate(nb_ei = if_else(is.na(nb_ei), 0, nb_ei))

  df_nb_ei_per_arm <- df_pat_llt |>
    dplyr::left_join(df_pat_grp, by = "id_pat") |>
    dplyr::group_by(grp, pt) |>
    dplyr::summarise(nb_ei = dplyr::n_distinct(ei_num, id_pat),
                     .groups = "drop") |>
    dplyr::full_join(df_soc_pt_grp, by = c("grp", "pt")) |>
    dplyr::mutate(nb_ei = dplyr::if_else(is.na(nb_ei), 0, nb_ei))

  ##### Proportion of patient with EI per arm

  # df_nb_pat_per_grp <- df_pat_grp |>
  #   group_by(RDGRPNAME) |>
  #   summarise(nb_pat_per_grp = n(),
  #             .groups = "drop")
  #
  # df_freq_pat <- df_pat_llt |>
  #   dplyr::distinct(USUBJID, EIPTN) |>
  #   left_join(df_pat_grp, by = "USUBJID") |>
  #   group_by(EIPTN, RDGRPNAME) |>
  #   summarise(nb_pat = n(),
  #             .groups = "drop") |>
  #   full_join(df_SOC_PT_GRP, by = c("RDGRPNAME", "EIPTN")) |>
  #   left_join(df_nb_pat_per_grp, by = "RDGRPNAME") |>
  #   dplyr::mutate(nb_pat = if_else(is.na(nb_pat), 0, nb_pat),
  #                 freq_pat = nb_pat/nb_pat_per_grp,
  #                 freq_pat_txt = paste0(nb_pat, "/", nb_pat_per_grp))

  df_nb_pat_per_grp <- df_pat_grp |>
    dplyr::group_by(grp) |>
    dplyr::summarise(nb_pat_per_grp = dplyr::n(),
                     .groups = "drop")

  df_freq_pat <- df_pat_llt |>
    dplyr::distinct(id_pat, pt) |>
    dplyr::left_join(df_pat_grp, by = "id_pat") |>
    dplyr::group_by(pt, grp) |>
    dplyr::summarise(nb_pat = dplyr::n(),
                     .groups = "drop") |>
    dplyr::full_join(df_soc_pt_grp, by = c("grp", "pt")) |>
    dplyr::left_join(df_nb_pat_per_grp, by = "grp") |>
    dplyr::mutate(nb_pat = dplyr::if_else(is.na(nb_pat), 0, nb_pat),
                  freq_pat = nb_pat/nb_pat_per_grp,
                  freq_pat_txt = paste0(nb_pat, "/", nb_pat_per_grp))

  ##### Confidence interval

  # df_confidence_interval <- lapply(vec_pt,
  #                                  function(pt_i){
  #                                    df_i <-  df_freq_pat |> filter(EIPTN == pt_i)
  #
  #                                    nb_disease_exposed <- df_i |> filter(RDGRPNAME == vec_grp[1]) |> pull(nb_pat)
  #                                    nb_disease_nonexposed <- df_i |> filter(RDGRPNAME == vec_grp[2]) |> pull(nb_pat)
  #                                    pop_at_risk_exposed <- df_i |> filter(RDGRPNAME == vec_grp[1]) |> pull(nb_pat_per_grp)
  #                                    pop_at_risk_nonexposed <- df_i |> filter(RDGRPNAME == vec_grp[2]) |> pull(nb_pat_per_grp)
  #
  #                                    res <- riskdifference(a = nb_disease_exposed, N1 = pop_at_risk_exposed,
  #                                                          b = nb_disease_nonexposed, N0 = pop_at_risk_nonexposed)
  #
  #                                    res <- data.frame(EIPTN = pt_i,
  #                                                      RD = res$estimate,
  #                                                      CIinf = res$conf.int[1],
  #                                                      CIsup = res$conf.int[2],
  #                                                      p_val = res$p.value)
  #
  #                                    return(res)
  #                                  }) |>
  #   bind_rows() |>
  #   left_join(df_SOC_PT_GRP |>
  #               dplyr::select(-RDGRPNAME) |>
  #               distinct(),
  #             by = "EIPTN") |>
  #   mutate(significant_bool = p_val < 0.05,
  #          significant_label = factor(significant_bool, levels = c(T,F), labels = c("*", "")))

  df_confidence_interval <- lapply(vec_pt,
                                   function(pt_i){
                                     df_i <- df_freq_pat |> dplyr::filter(pt == pt_i)

                                     nb_disease_exposed <- df_i |> dplyr::filter(grp == vec_grp[1]) |> dplyr::pull(nb_pat)
                                     nb_disease_nonexposed <- df_i |> dplyr::filter(grp == vec_grp[2]) |> dplyr::pull(nb_pat)
                                     pop_at_risk_exposed <- df_i |> dplyr::filter(grp == vec_grp[1]) |> dplyr::pull(nb_pat_per_grp)
                                     pop_at_risk_nonexposed <- df_i |> dplyr::filter(grp == vec_grp[2]) |> dplyr::pull(nb_pat_per_grp)

                                     res <- riskdifference(a = nb_disease_exposed, N1 = pop_at_risk_exposed,
                                                           b = nb_disease_nonexposed, N0 = pop_at_risk_nonexposed)

                                     res <- data.frame(pt = pt_i,
                                                       RD = res$estimate,
                                                       CIinf = res$conf.int[1],
                                                       CIsup = res$conf.int[2],
                                                       p_val = res$p.value)

                                     return(res)
                                   }) |>
    dplyr::bind_rows() |>
    dplyr::left_join(df_soc_pt_grp |>
                       dplyr::select(-grp) |>
                       dplyr::distinct(),
                     by = "pt") |>
    dplyr::mutate(significant_bool = p_val < 0.05,
                  significant_label = factor(significant_bool, levels = c(TRUE, FALSE), labels = c("*", "")))


  ##### Combine df

  # df_all <- list(
  #   df_nb_ei_per_arm |>
  #     select(EIPTN, EISOCPN, RDGRPNAME, nb_ei) |>
  #     mutate(facet = "Total nb of AE"),
  #   df_freq_pat |>
  #     select(EIPTN, EISOCPN, RDGRPNAME, freq_pat, nb_pat) |>
  #     mutate(facet = "Prop. of patients"),
  #   df_confidence_interval |>
  #     select(EIPTN, EISOCPN, RD, CIinf, CIsup, significant_bool, significant_label, p_val) |>
  #     mutate(facet = "Risk difference with 95% CI")
  # ) |>
  #   bind_rows() |>
  #   mutate(RDGRPNAME = as.factor(RDGRPNAME),
  #          RDGRPNAME = forcats::fct_relevel(RDGRPNAME, ref_grp),
  #          grp_num = if_else(RDGRPNAME == ref_grp, 0, 1),
  #          EIPTN = forcats::fct_reorder(EIPTN, RD, .na_rm = TRUE))
  #
  # return(df_all)

  df_all <- list(
    df_nb_ei_per_arm |>
      dplyr::select(pt, soc, grp, nb_ei) |>
      dplyr::mutate(facet = "Total nb of AE"),
    df_freq_pat |>
      dplyr::select(pt, soc, grp, freq_pat, nb_pat) |>
      dplyr::mutate(facet = "Prop. of patients"),
    df_confidence_interval |>
      dplyr::select(pt, soc, RD, CIinf, CIsup, significant_bool, significant_label, p_val) |>
      dplyr::mutate(facet = "Risk difference with 95% CI")
  ) |>
    dplyr::bind_rows() |>
    dplyr::mutate(grp = as.factor(grp),
                  grp = forcats::fct_relevel(grp, ref_grp),
                  grp_num = dplyr::if_else(grp == ref_grp, 0, 1),
                  pt = forcats::fct_reorder(pt, RD, .na_rm = TRUE))

  return(df_all)


}
