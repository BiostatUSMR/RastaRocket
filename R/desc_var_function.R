
#' Generate Descriptive Tables for Variables
#'
#' This function creates descriptive tables for variables in a dataset. It can handle qualitative and quantitative variables, grouped or ungrouped, and supports multiple configurations for handling missing data (DM).
#'
#' @param data1 A data frame containing the dataset to be analyzed.
#' @param table_title A character string specifying the title of the table.
#' @param quali A vector of qualitative variables to be described. Defaults to `NULL`.
#' @param quanti A vector of quantitative variables to be described. Defaults to `NULL`.
#' @param group A logical value or character string indicating whether the variables should be grouped. Options:
#'   - `"ALL"`: Grouped by all levels of `var_group`.
#'   - `TRUE`: Grouped by `var_group`.
#'   - `FALSE`: Not grouped.
#' @param var_title A character string for the title of the variable column in the table. Defaults to `"Variable"`.
#' @param var_group A variable used for grouping (if applicable). Defaults to `NULL`.
#' @param group_title A character string specifying the title for the grouping variable.
#' @param round_quanti An integer vector specifying the number of decimal places for quantitative variables. Defaults to `c(1)`.
#' @param round_quali An integer vector specifying the number of decimal places for qualitative variables. Defaults to `c(0, 1)`.
#' @param DM A character string controlling the handling of missing data. Options:
#'   - `"tout"`: Keep all variables and drop unused levels of factors.
#'   - `"tri"`: Retain only variables with at least three levels.
#'   - `"remove"`: Remove missing levels from factors.
#'   - `"NULL"`: No special handling of missing data.
#' @param tests A value in order to add p value. Defaut to `FALSE` OPTION :
#'   - `FALSE`: No p-value add
#'   - `TRUE`: Add p-value made by default by gtsummary. See gtsummary add_p() options.
#'   - `list()`: To force tests. See gtsummary add_p() options.
#'
#' @details
#' The function processes the dataset according to the specified parameters and generates descriptive tables.
#' - It first uses the `ajouter_label_ndm()` function to append missing data statistics to variable labels.
#' - Depending on the `group` and `DM` arguments, it adjusts the dataset and creates tables using helper functions like `desc_group`, `desc_degroup`, and `desc_degroup_group`.
#' - Qualitative variables are reordered, and unused levels are dropped when necessary.
#'
#' @return A gtsummary table object containing the descriptive statistics.
#'
#' @examples
#' # Example usage:
#' library(dplyr)
#'
#' # Sample dataset
#' data1 <- data.frame(
#'   group = c("A", "B", "A", "C"),
#'   var1 = c(1, 2, 3, NA),
#'   var2 = c("X", "Y", "X", NA)
#' )
#'
#' # Generate descriptive table
#' table <- desc_var(
#'   data1 = data1,
#'   table_title = "Descriptive Table",
#'   group = FALSE,
#'   group_title = "Group",
#'   DM = "tout"
#' )
#'
#' @importFrom dplyr mutate across where
#' @importFrom forcats fct_drop
#' @importFrom tidyr drop_na
#' @importFrom gtsummary tbl_summary
#' @import cardx
#' @export

desc_var <- ## Les arugments de la fonction
  function(data1,
           ##  Jeux de données numéro 1.
           table_title = "",
           ## Titre de la table
           quali = NULL,
           ## Vecteur des variables quali ~tatives mal decrites
           quanti = NULL,
           ## Vecteur des variables quantitatives mal decrites
           group,
           var_title = "Variable",
           ## booléen pour préciser s'il faut degroupé ou pas les tables.
           var_group = NULL, ## Variable de groupe (dégroupée les tables)
           group_title = "",
           round_quanti = c(1),
           round_quali = c(0,1),
           DM = "NULL",
           tests = FALSE) {
    
    ### Add labels
    data1 <- data1 %>% Descusmr::ajouter_label_ndm()
    
    ### Apply DM option
    if(DM == "tout"){
      data1 <- ordonner_variables_qualitatives(data1) %>%
        dplyr::mutate(across(where(is.factor),~ forcats::fct_drop(.)))
    } else if(DM == "tri") {
      data1 <- ordonner_variables_qualitatives(data1)
    } else if (DM == "remove") {
      data1 <- data1 %>% dplyr::mutate(across(where(is.factor), ~ forcats::fct_drop(.)))
    }
    
    if(is.null(var_group)){
      col_1 <- NULL
    } else {
      col_1 <- rlang::ensym(var_group)
      
      if(group_title == ""){
        group_title <- var_group
      }
      
    }
    
    base_table <- data1 %>%
      gtsummary::tbl_summary(
        type = list(
          where(is.factor) ~ "categorical",
          ## type des var (qualitatives)
          gtsummary::all_continuous() ~ "continuous2",
          ## type des var (continus)
          quali ~ "categorical",
          quanti ~ "continuous2"
        ),
        by = !!col_1,
        ## Pour degrouper les tables
        missing = "no",
        ## Ne pas afficher les NA
        statistic = list(
          gtsummary::all_continuous2() ~ c("{mean} ({sd})", "{median} ({p25} ; {p75})","{min} ; {max}"),
          ## Stat à afficher pour les VAR (quantitatives)
          gtsummary::all_categorical() ~ "{n} ({p}%)" ## Stat à afficher pour les VAR (categorielles)
        ),
        digits = list(gtsummary::all_continuous() ~ round_quanti, gtsummary::all_categorical() ~ round_quali) ## le nbre de décimale pour les variables.
      ) %>%
      gtsummary::bold_labels()  ## Variables en gras.
    
    ### Add Overall column if specified
    if(!is.null(var_group) & group == "ALL"){
      base_table <- base_table %>%
        gtsummary::add_overall(col_label = "**Total**")
    }
    
    ### Add missing values
    base_table_missing <- base_table %>%
      gtsummary::add_n("{N_nonmiss} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)")
    
    if(!is.null(var_group)){
      base_table_missing <- base_table_missing %>%
        gtsummary::add_stat(fns = everything() ~ add_by_n) ## Stat en colonnes (Total et données manquantes)
    }
    
    base_table_missing <- base_table_missing %>%
      gtsummary::modify_header(
        list(
          label ~ paste0("**",var_title,"**"),
          ## Titre des variables du tableau.
          starts_with("add_n_stat") ~ "",
          gtsummary::all_stat_cols(stat_0 = FALSE) ~ "**{level}**",
          ## labels Stat des colonnes.
          n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
        )
      )  %>%
      gtsummary::modify_table_body(~ modify_table_body_func(.)) %>%  ## Appel de la fonction externe pour modifier le corps du tableau
      gtsummary::modify_footnote(everything() ~ NA) ## Note de page.
    
    if(!is.null(var_group)){
      base_table_missing <- base_table_missing %>%
        gtsummary::modify_spanning_header(c(gtsummary::all_stat_cols(F) ~ paste0("**",group_title,"**")))
    }
    
    res <- base_table_missing %>%
      gtsummary::modify_caption(paste0("**",table_title,"**")) %>%
      gtsummary::bold_labels() ## Titre pour la table.
    
    # Add tests tests 
    if (is.list(tests)) {
      res <- res %>%
        gtsummary::add_p(test = tests) %>%
        gtsummary::separate_p_footnotes()
    } else if (isTRUE(tests)) {
      res <- res %>%
        gtsummary::add_p() %>%
        gtsummary::separate_p_footnotes()
    }
    
    return(res)
    
  }

