# look_for(hm_1)
#
# hm_hm <- hm_1 %>% select(hmirmn)
# str(hm_hm$hmirmn)
#
# group = "ALL"
#
# his_mal <- tbl_stack(
#   list(
#
#     ## Filtre sur l'IRM réalisée à la pré-inclusion
#
#     hm_1 %>% filter(hmirmbr == "Oui") %>% select( hmtrpamo,19:22) %>%
#       desc_var_6(table_title = "**Histoire de la maladie**",group = group,var_group =   hmtrpamo, group_title = "**Traitement**"),
#
#
#     hm_1 %>% filter(hmirm == "Oui") %>% select( hmtrpamo,24:28) %>%
#       desc_var_6(group = group,var_group = hmtrpamo),
#
#
#
#     hm_1 %>% filter(hmirm == "Oui") %>% select( hmtrpamo,hmirmga) %>%
#       desc_var_6(group = group,var_group = hmtrpamo)), quiet = TRUE)
#
#
# his_mal
#
