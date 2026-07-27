utils::globalVariables(c("nb_pat_per_group", "freq_ei"))

#' Butterfly Stacked Bar Plot for Adverse Event Grades
#'
#' Creates a butterfly stacked bar plot to visualize the frequency of adverse event (AE) grades
#' across patient groups, with system organ class (SOC) and preferred terms (PT) as labels.
#'
#' @param df_pat_llt A dataframe with columns: USUBJID (patient id), EINUM (AE id), llt (AE LLT), pt (AE PT), soc (AE SOC) and EIGRDM (severity grade)
#' @param id_col Name of the patient ID column (default: "USUBJID").
#' @param group_col Name of the randomization group column (default: "RDGRPNAME").
#' @param ei_num_col Name of the AE id column (default: "EINUM").
#' @param ei_llt_col Name of the AE LLT column (default: "EILLTN").
#' @param ei_soc_col Name of the AE SOC column (default: "EISOCPN").
#' @param ei_pt_col Name of the AE PT column (default: "EIPTN").
#' @param ei_grdm_col AE grade column (default: "EIGRDM").
#' @param df_pat_grp A dataframe with two columns: USUBJID (Patient id) and RDGRPNAME (the RCT arm).
#' @param ref_grp A character string specifying the reference group (used for alignment in the plot).
#'   If NULL (default), the first level of `df_pat_grp$grp` is used.
#' @param max_text_width An integer specifying the maximum width (in characters) for SOC labels
#'   before wrapping to the next line. Default is 9.
#' @param vec_fill_color A vector of colors used for filling the AE grade bars. Default is
#'   `viridis::viridis(n = 4)`.
#'
#' @return A ggplot2 object representing the butterfly stacked bar plot.
#'
#' @details
#' The function processes input data to calculate the frequency of adverse events per patient
#' group and AE grade. It then generates a stacked bar plot where:
#' \itemize{
#'   \item The x-axis represents the percentage of patients experiencing an AE.
#'   \item The y-axis represents PTs (with SOCs as facets).
#'   \item Bars are stacked by AE grade.
#'   \item Labels for PTs are displayed in the center.
#'   \item The left and right panels correspond to different patient groups.
#' }
#'
#' The function utilizes the `ggh4x` package to adjust panel sizes and axes for a symmetrical
#' butterfly plot.
#'
#' @examples
#'
#' df_pat_grp <- data.frame(
#'  USUBJID = paste0("ID_", 1:10),
#'  RDGRPNAME = c(rep("A", 5), rep("B", 5))
#' )
#'
#' df_pat_llt <- data.frame(
#'   USUBJID = c("ID_1", "ID_1", "ID_2", "ID_4", "ID_9"),
#'   EINUM = c(1, 2, 1, 1, 1),
#'   EILLTN = c("llt1", "llt2", "llt1", "llt3", "llt4"),
#'   EIPTN = c("Arrhythmia", "Myocardial Infarction", "Arrhythmia", "Pneumonia", "Pneumonia"),
#'   EISOCPN = c("Cardiac Disorders", "Cardiac Disorders", "Cardiac Disorders",
#'   "Infections", "Infections"),
#'   EIGRDM = c(1, 3, 4, 2, 4)
#' )
#'
#' plot_butterfly_stacked_barplot(df_pat_grp, df_pat_llt)
#'
#' @importFrom ggplot2 ggplot aes geom_bar geom_text scale_fill_manual theme_bw labs
#' @importFrom dplyr group_by summarise mutate filter distinct left_join bind_rows
#' @importFrom forcats fct_relevel
#' @importFrom ggh4x facetted_pos_scales force_panelsizes
#' @importFrom viridis viridis
#' @export

plot_butterfly_stacked_barplot <- function(df_pat_grp,
                                              df_pat_llt,
                                              id_col = "USUBJID",
                                              group_col = "RDGRPNAME",
                                              ei_num_col = "EINUM",
                                              ei_pt_col = "EIPTN",
                                              ei_soc_col = "EISOCPN",
                                              ei_grdm_col = "EIGRDM",
                                              ei_llt_col = "EILLTN",
                                              ref_grp = NULL,
                                              max_text_width = 9,
                                              vec_fill_color = viridis::viridis(n = 4)) {

  id_col <- rlang::ensym(id_col)
  group_col <- rlang::ensym(group_col)
  ei_num_col <- rlang::ensym(ei_num_col)
  ei_pt_col <- rlang::ensym(ei_pt_col)
  ei_soc_col <- rlang::ensym(ei_soc_col)
  ei_grdm_col <- rlang::ensym(ei_grdm_col)
  ei_llt_col <- rlang::ensym(ei_llt_col)

  if (is.null(ref_grp)) {
    ref_grp <- levels(df_pat_grp |> dplyr::pull(!!group_col))[1]
    if (is.null(ref_grp)) {
      ref_grp <- df_pat_grp |> dplyr::pull(!!group_col) |> dplyr::first()
    }
  }

  df_nb_pat_per_group <- df_pat_grp |>
    dplyr::group_by(!!group_col) |>
    dplyr::summarise(nb_pat_per_group = dplyr::n(), .groups = "drop")

  df_label_pt_pt <- df_pat_llt |>
    dplyr::distinct(!!ei_soc_col, !!ei_pt_col) |>
    dplyr::mutate(!!group_col := "PT")

  df_plot <- df_pat_llt |>
    dplyr::left_join(df_pat_grp, by = rlang::as_string(id_col)) |>
    dplyr::group_by(!!group_col, !!ei_pt_col, !!ei_soc_col, !!ei_grdm_col) |>
    dplyr::summarise(nb_ei = dplyr::n_distinct(!!id_col, !!ei_num_col), .groups = "drop") |>
    dplyr::left_join(df_nb_pat_per_group, by = rlang::as_string(group_col)) |>
    dplyr::bind_rows(df_label_pt_pt) |>
    dplyr::mutate(
      freq_ei = nb_ei / nb_pat_per_group,
      !!ei_grdm_col := as.factor(!!ei_grdm_col),
      !!group_col := as.factor(!!group_col),
      !!group_col := forcats::fct_relevel(!!group_col, ref_grp, "PT"),
      !!ei_pt_col := purrr::map_chr(!!ei_pt_col, ~ paste(strwrap(.x, width = max_text_width), collapse = "\n"))
    )

  p <- ggplot2::ggplot(
    data = df_plot |> dplyr::filter(!!group_col != "PT"),
    mapping = ggplot2::aes(x = freq_ei, y = !!ei_pt_col, fill = !!ei_grdm_col)
  ) +
    ggplot2::geom_bar(position = ggplot2::position_stack(), stat = "identity") +
    ggplot2::geom_text(
      data = df_plot |> dplyr::filter(!!group_col == "PT"),
      mapping = ggplot2::aes(x = 0, y = !!ei_pt_col, label = !!ei_pt_col),
      hjust = "center",
      inherit.aes = FALSE,
      size = 3
    ) +
    ggplot2::scale_fill_manual(values = vec_fill_color) +
    ggplot2::facet_grid(stats::as.formula(paste0(rlang::as_string(ei_soc_col), " ~ ", rlang::as_string(group_col))),
                        scales = "free", switch = "y", space = "free") +
    ggh4x::facetted_pos_scales(x = list(
      ggplot2::scale_x_continuous(labels = scales::label_percent(),
                                  trans = "reverse",
                                  limits = c(1, 0)),
      ggplot2::scale_x_continuous(labels = NULL, breaks = NULL),
      ggplot2::scale_x_continuous(labels = scales::label_percent(),
                                  limits = c(0, 1))
    )) +
    ggh4x::force_panelsizes(cols = c(2, 1, 2)) +
    ggplot2::theme_bw() +
    ggplot2::theme(
      legend.position = "bottom",
      legend.text = ggplot2::element_text(size = 10),
      axis.line.x = ggplot2::element_line(color = "black", linetype = 1),
      axis.line.y = ggplot2::element_line(color = "black", linetype = 1),
      axis.ticks.y = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_text(size = 10),
      axis.text.y = ggplot2::element_blank(),
      axis.title.x = ggplot2::element_text(size = 12),
      strip.text.y.left = ggplot2::element_text(angle = 0, size = 10, face = "bold"),
      strip.text.x.bottom = ggplot2::element_text(angle = 0, size = 10, face = "bold"),
      strip.placement = "outside",
      strip.background = ggplot2::element_rect(fill = "#F5F5F5", color = "white"),
      panel.spacing = grid::unit(10, "pt"),
      panel.border = ggplot2::element_rect(color = "lightgrey", fill = NA)
    ) +
    ggplot2::labs(x = "Percent of patients", y = "", fill = "Grade")

  p
}
