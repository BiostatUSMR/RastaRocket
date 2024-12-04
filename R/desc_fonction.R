
#### Fonction  descriptive (Reporting) Version 5.0 --------

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
           DM = "NULL") {

    data1 <- data1 %>% ajouter_label_ndm()


    if(DM == "tout") {

      data1 <- ordonner_variables_qualitatives(data1) %>%
        dplyr::mutate(across(where(is.factor),~ forcats::fct_drop(.)))

      if (group == "ALL") {

        col_1 <- rlang::ensym(var_group)

        data1 <- data1 %>% tidyr::drop_na({{ var_group }}) %>%
          dplyr::mutate(!!col_1 := factor(!!col_1))

        desc_group_all <-  data1 %>% desc_all(
          table_title = table_title,
          quali = quali,
          quanti = quanti,
          round_quanti = round_quanti,
          round_quali = round_quali,
          var_title = var_title,
          var_group = var_group,
          group_title = group_title
        )

        }

      else if(group == TRUE) {

        col_1 <- rlang::ensym(var_group)

        data1 <- data1 %>% tidyr::drop_na({{ var_group }}) %>%
          dplyr::mutate(!!col_1 := factor(!!col_1))


        desc_group_all <-  data1 %>% desc_true(
          table_title = table_title,
          quali = quali,
          quanti = quanti,
          round_quanti = round_quanti,
          round_quali = round_quali,
          var_title = var_title,
          var_group = var_group,
          group_title = group_title
        )
        }

       else if(group == FALSE) {

         desc_group_all <-  data1 %>% desc_false(
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


        desc_group_all <-  data1 %>% desc_all(
          table_title = table_title,
          quali = quali,
          quanti = quanti,
          round_quanti = round_quanti,
          round_quali = round_quali,
          var_title = var_title,
          var_group = var_group,
          group_title = group_title)


       }

       else if(group == TRUE) {

         col_1 <- rlang::ensym(var_group)

         data1 <- data1 %>% tidyr::drop_na({{ var_group }}) %>%
           dplyr::mutate(!!col_1 := factor(!!col_1))


        desc_group_all <-  data1 %>% desc_true(
           table_title = table_title,
           quali = quali,
           quanti = quanti,
           round_quanti = round_quanti,
           round_quali = round_quali,
           var_title = var_title,
           var_group = var_group,
           group_title = group_title)


         }

        else if(group == FALSE) {

          desc_group_all <-  data1 %>% desc_false(
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


       desc_group_all <-  data1 %>% desc_all(
          table_title = table_title,
          quali = quali,
          quanti = quanti,
          round_quanti = round_quanti,
          round_quali = round_quali,
          var_title = var_title,
          var_group = var_group,
          group_title = group_title)


        }


       else if(group == TRUE) {

         col_1 <- rlang::ensym(var_group)

         data1 <- data1 %>% tidyr::drop_na({{ var_group }}) %>%
           dplyr::mutate(!!col_1 := factor(!!col_1))


         desc_group_all <-  data1 %>% desc_true(
           table_title = table_title,
           quali = quali,
           quanti = quanti,
           round_quanti = round_quanti,
           round_quali = round_quali,
           var_title = var_title,
           var_group = var_group,
           group_title = group_title)



      } else if(group == FALSE) {


        desc_group_all <-  data1 %>% desc_false(
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


        desc_group_all <-  data1 %>% desc_all(
          table_title = table_title,
          quali = quali,
          quanti = quanti,
          round_quanti = round_quanti,
          round_quali = round_quali,
          var_title = var_title,
          var_group = var_group,
          group_title = group_title)


        }

    else if(group == TRUE) {


      desc_group_all <-  data1 %>% desc_true(
        table_title = table_title,
        quali = quali,
        quanti = quanti,
        round_quanti = round_quanti,
        round_quali = round_quali,
        var_title = var_title,
        var_group = var_group,
        group_title = group_title)


      }

     else if(group == FALSE) {


       desc_group_all <-  data1 %>% desc_false(
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

