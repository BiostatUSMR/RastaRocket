
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
#'   quali = "var2",
#'   quanti = "var1",
#'   group = TRUE,
#'   var_group = "group",
#'   group_title = "Group",
#'   DM = "tout"
#' )
#'
#' @importFrom dplyr mutate across where
#' @importFrom forcats fct_drop
#' @importFrom tidyr drop_na
#' @importFrom gtsummary tbl_summary
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

    data1 <- data1 %>% ajouter_label_ndm()


    if(DM == "tout") {

      data1 <- ordonner_variables_qualitatives(data1) %>%
        dplyr::mutate(across(where(is.factor),~ forcats::fct_drop(.)))

      if (group == "ALL") {

        col_1 <- rlang::ensym(var_group)

        data1 <- data1 %>% tidyr::drop_na({{ var_group }}) %>%
          dplyr::mutate(!!col_1 := factor(!!col_1))

        desc_group_all <-  data1 %>% desc_degroup_group(
          table_title = table_title,
          quali = quali,
          quanti = quanti,
          round_quanti = round_quanti,
          round_quali = round_quali,
          var_title = var_title,
          var_group = var_group,
          group_title = group_title,
          tests = tests
        )

        }

      else if(group == TRUE) {

        col_1 <- rlang::ensym(var_group)

        data1 <- data1 %>% tidyr::drop_na({{ var_group }}) %>%
          dplyr::mutate(!!col_1 := factor(!!col_1))


        desc_group_all <-  data1 %>% desc_degroup(
          table_title = table_title,
          quali = quali,
          quanti = quanti,
          round_quanti = round_quanti,
          round_quali = round_quali,
          var_title = var_title,
          var_group = var_group,
          group_title = group_title,
          tests = tests
        )
        }

       else if(group == FALSE) {

         desc_group_all <-  data1 %>% desc_group(
           table_title = table_title,
           quali = quali,
           quanti = quanti,
           round_quanti = round_quanti,
           round_quali = round_quali,
           var_title = var_title
         )

      }
    }
    else if(DM == "tri") {

      data1 <- ordonner_variables_qualitatives(data1)

      if (group == "ALL") {

        col_1 <- rlang::ensym(var_group)

        data1 <- data1 %>% tidyr::drop_na({{ var_group }}) %>%
          dplyr::mutate(!!col_1 := factor(!!col_1))


        desc_group_all <-  data1 %>% desc_degroup_group(
          table_title = table_title,
          quali = quali,
          quanti = quanti,
          round_quanti = round_quanti,
          round_quali = round_quali,
          var_title = var_title,
          var_group = var_group,
          group_title = group_title,
          tests = tests)


       }

       else if(group == TRUE) {

         col_1 <- rlang::ensym(var_group)

         data1 <- data1 %>% tidyr::drop_na({{ var_group }}) %>%
           dplyr::mutate(!!col_1 := factor(!!col_1))


        desc_group_all <-  data1 %>% desc_degroup(
           table_title = table_title,
           quali = quali,
           quanti = quanti,
           round_quanti = round_quanti,
           round_quali = round_quali,
           var_title = var_title,
           var_group = var_group,
           group_title = group_title,
           tests = tests)


         }

        else if(group == FALSE) {

          desc_group_all <-  data1 %>% desc_group(
            table_title = table_title,
            quali = quali,
            quanti = quanti,
            round_quanti = round_quanti,
            round_quali = round_quali,
            var_title = var_title
          )



      }
    }

    else if (DM == "remove") {

      data1 <- data1 %>% dplyr::mutate(across(where(is.factor), ~ forcats::fct_drop(.)))

      if (group == "ALL") {

        col_1 <- rlang::ensym(var_group)

        data1 <- data1 %>% tidyr::drop_na({{ var_group }}) %>%
          dplyr::mutate(!!col_1 := factor(!!col_1))


       desc_group_all <-  data1 %>% desc_degroup_group(
          table_title = table_title,
          quali = quali,
          quanti = quanti,
          round_quanti = round_quanti,
          round_quali = round_quali,
          var_title = var_title,
          var_group = var_group,
          group_title = group_title,
          tests = tests)


        }


       else if(group == TRUE) {

         col_1 <- rlang::ensym(var_group)

         data1 <- data1 %>% tidyr::drop_na({{ var_group }}) %>%
           dplyr::mutate(!!col_1 := factor(!!col_1))


         desc_group_all <-  data1 %>% desc_degroup(
           table_title = table_title,
           quali = quali,
           quanti = quanti,
           round_quanti = round_quanti,
           round_quali = round_quali,
           var_title = var_title,
           var_group = var_group,
           group_title = group_title,
           tests = tests)



      } else if(group == FALSE) {


        desc_group_all <-  data1 %>% desc_group(
          table_title = table_title,
          quali = quali,
          quanti = quanti,
          round_quanti = round_quanti,
          round_quali = round_quali,
          var_title = var_title)



      }
    }
    else if (DM== "NULL") {
      if (group == "ALL") {


        desc_group_all <-  data1 %>% desc_degroup_group(
          table_title = table_title,
          quali = quali,
          quanti = quanti,
          round_quanti = round_quanti,
          round_quali = round_quali,
          var_title = var_title,
          var_group = var_group,
          group_title = group_title,
          tests = tests)


        }

    else if(group == TRUE) {


      desc_group_all <-  data1 %>% desc_degroup(
        table_title = table_title,
        quali = quali,
        quanti = quanti,
        round_quanti = round_quanti,
        round_quali = round_quali,
        var_title = var_title,
        var_group = var_group,
        group_title = group_title,
        tests = tests)


      }

     else if(group == FALSE) {


       desc_group_all <-  data1 %>% desc_group(
         table_title = table_title,
         quali = quali,
         quanti = quanti,
         round_quanti = round_quanti,
         round_quali = round_quali,
         var_title = var_title)



      }
    }

    return(desc_group_all)

  }

