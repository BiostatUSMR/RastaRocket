### 
library(tidyverse)
library(dplyr)
library(gtsummary)
library(labelled)
library(rlang)
library(tidyr)
library(tinytex)
library(lubridate)
library(rlang)
library(sjlabelled)
library(survival)
library(survminer, quietly = TRUE)
library(KMunicate)
library(kableExtra)
library(gtreg)
library(gt)
library(readxl)
library(haven)
library(openxlsx)

### Chargement des tables 

load("I:/Etudes/DENOST Quentin GRECCAR 17 2020-021/04 - Aspects data management/08_Base/8.2_Bases figées/20240326/GRECCAR17_tab_2024-03-26.rds")



### Theme gtsummary ----- 
theme_gtsummary_compact()
theme_gtsummary_language("fr", decimal.mark = ".", big.mark = " ")



#### sourcer la fonction desc_function 
# source("desc_fonction5.R")
# source("desc_fonction6.R")

source("desc_fonction7.R")

# source("N:/Activité/Activités biostatistiques/Fonctions standards R/Fonction_SMH/desc_fonction6.R")
       
       

hm_1 <- hm %>% dplyr::left_join( rd %>% select(1, rdgrp), by =  "usubjid")

ic_1 <- ic %>% dplyr::left_join( rd %>% select(1, rdgrp), by =  "usubjid")


###

source("code_test.R", encoding = 'UTF-8')

####  Chemins EI 











 



