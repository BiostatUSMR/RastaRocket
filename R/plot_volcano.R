#' Volcano Plot for Adverse Event Analysis
#'
#' Generates a volcano plot to visualize the association between adverse events and patient groups.
#'
#' @param df_soc_pt A data frame mapping system organ classes (SOC) to preferred terms (PT). 
#'   Must contain columns:
#'   \itemize{
#'     \item \code{soc} (character): System Organ Class.
#'     \item \code{pt} (character): Preferred Term.
#'   }
#' @param df_pat_grp A data frame with patient IDs and their assigned group.
#'   Must contain columns:
#'   \itemize{
#'     \item \code{id_pat} (character): Patient ID.
#'     \item \code{grp} (character): Group assignment (e.g., treatment arms).
#'   }
#' @param df_pat_pt A data frame linking patients to reported PT.
#'   Must contain columns:
#'   \itemize{
#'     \item \code{id_pat} (character): Patient ID.
#'     \item \code{pt} (character): Preferred Term.
#'   }
#' @param colors_arm A character vector of length two specifying the colors for the two patient groups in the plot. 
#'   Default is \code{c("#1b9e77", "#7570b3")}.
#' @param size A character string specifying the metric used for point sizes in the plot. 
#'   Options are:
#'   \itemize{
#'     \item \code{"nb_pat"}: Number of patients (default).
#'     \item \code{"nb_ei"}: Number of adverse events.
#'   }
#'
#' @return A ggplot2 object representing the volcano plot.
#'
#' @details 
#' The function first processes input data using `df_builder_ae()`, then calculates relevant statistics 
#' such as risk difference (\code{RD}) and p-values. The volcano plot displays:
#' \itemize{
#'   \item \code{RD} on the x-axis (risk difference between groups).
#'   \item \code{-log10(p-value)} on the y-axis (significance level).
#'   \item Point colors indicating which group has an increased risk.
#'   \item Point sizes reflecting either the number of patients or events.
#'   \item A horizontal dashed line at p = 0.05 for significance threshold.
#' }
#'
#' @examples
#' df_soc_pt <- data.frame(
#'   pt = c("Arrhythmia", "Myocardial Infarction", "Pneumonia", "Sepsis"),
#'   soc = c("Cardiac Disorders", "Cardiac Disorders", "Infections", "Infections")
#' )
#'
#' df_pat_grp <- data.frame(id_pat = paste0("ID_", 1:10),
#'                          grp = c(rep("A", 5), rep("B", 5)))
#'
#' df_pat_pt <- data.frame(id_pat = c("ID_1", "ID_1", "ID_2", "ID_4", "ID_9"),
#'                          pt = c("Arrhythmia", "Myocardial Infarction",
#'                          "Arrhythmia", "Pneumonia", "Pneumonia"))
#'
#' plot_volcano(df_soc_pt, df_pat_grp, df_pat_pt)
#'
#' @importFrom ggplot2 ggplot aes geom_point geom_hline geom_label scale_color_manual theme_bw labs
#' @importFrom dplyr group_by summarise mutate
#' @importFrom ggrepel geom_text_repel
#' @importFrom glue glue
#' @export
plot_volcano <- function(df_soc_pt,
                         df_pat_grp,
                         df_pat_pt,
                         colors_arm = c("#1b9e77", "#7570b3"),
                         size = "nb_pat") {
  
  vec_label_point_size = list(nb_pat = "Nb of patients",
                              nb_ei = "Nb of AE")
  
  df_all <- df_builder_ae(df_soc_pt = df_soc_pt,
                          df_pat_grp = df_pat_grp,
                          df_pat_pt = df_pat_pt)
  
  grp_levels <- levels(df_all$grp)
  
  df_volcano <- df_all |> 
    group_by(pt, soc) |> 
    summarise(p_val = na.omit(p_val),
              RD = na.omit(RD),
              nb_pat = sum(nb_pat, na.rm = TRUE),
              nb_ei = sum(nb_ei, na.rm = TRUE),
              .groups = "drop") |> 
    mutate(increased_risk = if_else(RD > 0,
                                    glue::glue("Increased risk in group {grp_levels[1]}"),
                                    glue::glue("Increased risk in group {grp_levels[2]}")),
           minus_log10_pval = -log10(p_val))
  
  p <- df_volcano |> 
    ggplot(mapping = aes(x = RD, y = minus_log10_pval,
                         color = increased_risk,
                         size = .data[[size]],
                         label = pt)) +
    geom_point(alpha = 0.4) +
    ggrepel::geom_text_repel(size = 3,
                             color = "black",
                             min.segment.length = 0.1,
                             force = 5,
                             max.overlaps = 30,
                             direction = "both") +
    geom_hline(yintercept = -log10(0.05),
               lty = 2,
               color = "red") +
    geom_label(x = 0,
               y = -log10(0.05),
               label = "p-value = 0.05",
               col = "red",
               size = 3,
               label.size = 0) +
    scale_color_manual(values = colors_arm) +
    theme_bw() +
    theme(legend.position = "bottom",
          legend.box = "vertical") +
    labs(x = "Risk difference", y = "-log10(p-value)",
         color = "",
         size = vec_label_point_size[[size]])
  
  return(p)
}
