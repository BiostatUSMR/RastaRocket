#' Plot a Dumbbell Chart for Adverse Events Analysis
#' 
#' This function creates a dumbbell plot comparing the occurrence of adverse events 
#' across different patient groups. The plot includes the total number of adverse events, 
#' the proportion of patients affected, and the risk difference with confidence intervals.
#' 
#' @param df_soc_pt A data frame mapping system organ classes (SOC) to preferred terms (PT). 
#' Must contain columns `soc` (System Organ Class) and `pt` (Preferred Term).
#' @param df_pat_grp A data frame of patient groups. Must contain columns `id_pat` (patient ID) 
#' and `grp` (group assignment).
#' @param df_pat_pt A data frame linking patients to adverse event system organ classes. 
#' Must contain columns `id_pat` (patient ID) and `pt` (System Organ Class).
#' @param ref_grp (Optional) A reference group for comparisons. Defaults to the first group in `df_pat_grp`.
#' @param colors_arm A vector of colors for the patient groups. Defaults to `c("#1b9e77", "#7570b3")`.
#' @param color_label A string specifying the legend label for the groups. Defaults to `"Arm"`.
#' 
#' @return A `ggplot` object displaying the dumbbell chart.
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
#' plot_dumbell(df_soc_pt, df_pat_grp, df_pat_pt)
#' 
#' @import ggplot2 dplyr forcats ggh4x scales
#' @export
plot_dumbell <- function(df_soc_pt,
                         df_pat_grp,
                         df_pat_pt,
                         ref_grp = NULL,
                         colors_arm = c("#1b9e77", "#7570b3"),
                         color_label = "Arm"){
  
  ########## Prepare dataframe
  
  df_all <- df_builder_ae(df_soc_pt = df_soc_pt,
                          df_pat_grp = df_pat_grp,
                          df_pat_pt = df_pat_pt,
                          ref_grp = ref_grp)
  
  df_vline <- data.frame(xintercept = 0,
                         facet = "Risk difference with 95% CI")
  
  ########## Plot
  
  p <- ggplot(mapping = aes(y = pt)) +
    geom_point(df_all |> filter(facet == "Prop. of patients"),
               mapping = aes(x = freq_pat, color = grp, shape = grp)) +
    geom_text(df_all |> filter(facet == "Total nb of AE"),
              mapping = aes(label = nb_ei, x = grp_num,
                            color = grp)) +
    geom_point(df_all |> filter(facet == "Risk difference with 95% CI"),
               mapping = aes(x = RD)) +
    geom_vline(data = df_vline, mapping = aes(xintercept = 0),
               color = "red", lty = 2) +
    geom_text(df_all |> filter(facet == "Risk difference with 95% CI"),
              mapping = aes(x = CIsup, label = significant_label),
              color = "red", nudge_x = 0.1) +
    geom_errorbarh(df_all |> filter(facet == "Risk difference with 95% CI"),
                   mapping = aes(xmin = CIinf, xmax = CIsup),
                   height = 0) +
    scale_color_manual(values = colors_arm) +
    facet_grid(soc ~ facet, scales = "free", space = "free", switch = "both") +
    theme_bw() +
    theme(legend.position="bottom",
          legend.text = element_text(size=10),
          axis.line.x = element_line(color = "black", linetype = 1),
          axis.line.y = element_line(color = "black", linetype = 1),
          axis.ticks.y = element_blank(),
          axis.text = element_text(size = 10),
          axis.title.x = element_text(size=12),
          strip.text.y.left = element_text(angle = 0, size = 10, face = "bold"),
          strip.text.x.bottom = element_text(angle = 0, size = 10, face = "bold"),
          strip.placement = "outside",
          strip.background = element_rect(fill = "#F5F5F5", color = "white"),
          panel.spacing = unit(10,"pt"),
          panel.border = element_rect(color = "lightgrey", fill = NA)) +
    ggh4x::facetted_pos_scales(x = list(scale_x_continuous(labels = scales::label_percent()),
                                        scale_x_continuous(),
                                        scale_x_continuous(limits = c(-0.5, 1.5),
                                                           minor_breaks = NULL,
                                                           breaks = c(0, 1),
                                                           labels = levels(df_all$grp)))) +
    ggh4x::force_panelsizes(rows = c(1, 1),
                            cols = c(2, 2, 1)) +
    labs(x = "", y = "", color = color_label, shape = color_label)
  
  return(p)
  
}
