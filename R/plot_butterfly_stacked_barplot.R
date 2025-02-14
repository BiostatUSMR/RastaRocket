#' Butterfly Stacked Bar Plot for Adverse Event Grades
#'
#' Creates a butterfly stacked bar plot to visualize the frequency of adverse event (AE) grades 
#' across patient groups, with system organ class (SOC) and preferred terms (PT) as labels.
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
#' @param df_pat_soc_grade A data frame linking patients to reported SOCs and AE grades.
#'   Must contain columns:
#'   \itemize{
#'     \item \code{id_pat} (character): Patient ID.
#'     \item \code{soc} (character): System Organ Class.
#'     \item \code{grade} (numeric or factor): Grade of the adverse event.
#'   }
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
#'   \item The y-axis represents SOCs (with PTs as facets).
#'   \item Bars are stacked by AE grade.
#'   \item Labels for SOCs are displayed in the center.
#'   \item The left and right panels correspond to different patient groups.
#' }
#'
#' The function utilizes the `ggh4x` package to adjust panel sizes and axes for a symmetrical 
#' butterfly plot.
#'
#' @examples
#' library(ggplot2)
#' library(dplyr)
#' library(forcats)
#' library(viridis)
#' library(ggh4x)
#' 
#' df_soc_pt <- data.frame(
#'   soc = c("Arrhythmia", "Myocardial Infarction", "Pneumonia", "Sepsis"),
#'   pt = c("Cardiac Disorders", "Cardiac Disorders", "Infections", "Infections")
#' )
#'
#' df_pat_grp <- data.frame(id_pat = paste0("ID_", 1:10),
#'                          grp = c(rep("A", 5), rep("B", 5)))
#'
#' df_pat_soc_grade <- data.frame(id_pat = c("ID_1", "ID_1", "ID_2", "ID_4", "ID_9"),
#'                          soc = c("Arrhythmia", "Myocardial Infarction", "Arrhythmia", 
#'                                  "Pneumonia", "Pneumonia"),
#'                          grade = c(4, 2, 1, 3, 4))
#'
#' plot_butterfly_stacked_barplot(df_soc_pt, df_pat_grp, df_pat_soc_grade)
#'
#' @importFrom ggplot2 ggplot aes geom_bar geom_text scale_fill_manual theme_bw labs
#' @importFrom dplyr group_by summarise mutate filter distinct left_join bind_rows
#' @importFrom forcats fct_relevel
#' @importFrom ggh4x facetted_pos_scales force_panelsizes
#' @importFrom viridis viridis
#' @export
plot_butterfly_stacked_barplot <- function(df_soc_pt,
                                           df_pat_grp,
                                           df_pat_soc_grade,
                                           ref_grp = NULL,
                                           max_text_width = 9,
                                           vec_fill_color = viridis::viridis(n = 4)) {
  
  if (is.null(ref_grp)) {
    ref_grp <- levels(df_pat_grp$grp)[1]
    if (is.null(ref_grp)) {
      ref_grp <- df_pat_grp$grp[1]
    }
  }
  
  df_nb_pat_per_group <- df_pat_grp |> 
    group_by(grp) |> 
    summarise(nb_pat_per_group = n())
  
  df_label_soc_pt <- df_soc_pt |> 
    filter(soc %in% df_pat_soc_grade$soc) |> 
    mutate(grp = "SOC")
  
  df_plot <- df_pat_soc_grade |> 
    distinct() |>
    left_join(df_pat_grp, by = "id_pat") |> 
    group_by(grp, soc, grade) |> 
    summarise(nb_ei = n(), .groups = "drop") |> 
    left_join(df_nb_pat_per_group, by = "grp") |> 
    left_join(df_soc_pt, by = "soc") |> 
    bind_rows(df_label_soc_pt) |> 
    mutate(freq_ei = nb_ei / nb_pat_per_group,
           grade = as.factor(grade),
           grp = as.factor(grp),
           grp = forcats::fct_relevel(grp, ref_grp, "SOC"),
           soc = purrr::map_chr(soc, ~ paste(strwrap(.x, width = max_text_width), collapse = "\n")))
  
  p <- ggplot(data = df_plot |> filter(grp != 'SOC'),
              mapping = aes(x = freq_ei, y = soc, fill = grade)) +
    geom_bar(position = position_stack(), stat = "identity") +
    geom_text(data = df_plot |> filter(grp == 'SOC'),
              mapping = aes(x = 0, y = soc, label = soc),
              hjust = "center",
              inherit.aes = FALSE,
              size = 3) +
    scale_fill_manual(values = vec_fill_color) +
    facet_grid(pt ~ grp, scales = "free", switch = "y", space = "free") +
    ggh4x::facetted_pos_scales(x = list(scale_x_continuous(labels = scales::label_percent(),
                                                           trans = "reverse",
                                                           limits = c(1, 0)),
                                        scale_x_continuous(labels = NULL,
                                                           breaks = NULL),
                                        scale_x_continuous(labels = scales::label_percent(),
                                                           limits = c(0, 1)))) +
    ggh4x::force_panelsizes(cols = c(2, 1, 2)) +
    theme_bw() +
    theme(legend.position = "bottom",
          legend.text = element_text(size = 10),
          axis.line.x = element_line(color = "black", linetype = 1),
          axis.line.y = element_line(color = "black", linetype = 1),
          axis.ticks.y = element_blank(),
          axis.text.x = element_text(size = 10),
          axis.text.y = element_blank(),
          axis.title.x = element_text(size = 12),
          strip.text.y.left = element_text(angle = 0, size = 10, face = "bold"),
          strip.text.x.bottom = element_text(angle = 0, size = 10, face = "bold"),
          strip.placement = "outside",
          strip.background = element_rect(fill = "#F5F5F5", color = "white"),
          panel.spacing = unit(10, "pt"),
          panel.border = element_rect(color = "lightgrey", fill = NA)) +
    labs(x = "Percent of patients", y = "", fill = "Grade")
  
  return(p)
}
