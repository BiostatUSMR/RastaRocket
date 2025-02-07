---
title: "DescusmrVignette"
date: "2025-02-07"
output:
  html_vignette:
    toc: true
    toc_depth: 2
    keep_md: true
vignette: >
  %\VignetteIndexEntry{DescusmrVignette}
  %\VignetteEncoding{UTF-8}
  %\VignetteEngine{knitr::rmarkdown}
---



\



``` r
library(Descusmr)
library(dplyr)
library(tidyr)
library(labelled)
library(rlang)
library(gtsummary)
library(forcats)
```


# Introduction

This vignette demonstrates the different options available for the `desc_var` function, accompanied by examples to illustrate its usage. 
 
# Toy dataset

We will generate a sample dataset to apply the `desc_var` function.



``` r
# Charger le package nécessaire
set.seed(123)  # Pour garantir la reproductibilité

# Création du data frame
data <- data.frame(
  Age = c(rnorm(45, mean = 50, sd = 10), rep(NA, 5)),  # Renommée Age
  sexe = sample(c(0, 1), 50, replace = TRUE, prob = c(0.6, 0.4)),  # Renommée sexe
  quatre_modalites = sample(c("A", "B", "C"), 50, replace = TRUE, prob = c(0.2, 0.5, 0.3)),  # Modalités sans "D"
  traitement = sample(c("BRAS-A", "BRAS-B"), 50, replace = TRUE, prob = c(0.55, 0.45)),  # Nouvelle variable traitement
  echelle = sample(0:5, 50, replace = TRUE)  # Nouvelle variable entière de 0 à 5
)

# Ajouter la modalité "D" comme niveau sans effectif
data$quatre_modalites <- factor(data$quatre_modalites, levels = c("A", "B", "C", "D"))

# Ajouter des labels à la variable sexe
data$sexe <- factor(data$sexe, levels = c(0, 1), labels = c("Femme", "Homme"))

# Aperçu des données



data <- data %>% labelled::set_variable_labels( Age = "Age",
                                                sexe = "sexe",
                                                traitement  = "traitement",
                                                quatre_modalites = "quatres niveaux",
                                                echelle = "Echelle")
```

# Basic usage
 
Below, we describe the options used in the example.

The dataset is passed to the `desc_var` function for analysis.

- `table_title`: Title of the descriptive table. Here, it is "test."
- `var_group`: The variable used for grouping the data. Here, it is "traitement."
- `group_title`: Title of the grouping variable column. Here, it is "traitement."
- `add_total`: Add a Total column when `var_group` is specified



``` r
data %>% Descusmr::desc_var(table_title = "test",
             var_group = "traitement",
             group_title = "Traitement",
             add_total = TRUE)
```


```{=html}
<div id="zuguzitfrq" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#zuguzitfrq table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#zuguzitfrq thead, #zuguzitfrq tbody, #zuguzitfrq tfoot, #zuguzitfrq tr, #zuguzitfrq td, #zuguzitfrq th {
  border-style: none;
}

#zuguzitfrq p {
  margin: 0;
  padding: 0;
}

#zuguzitfrq .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#zuguzitfrq .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#zuguzitfrq .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#zuguzitfrq .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#zuguzitfrq .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#zuguzitfrq .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zuguzitfrq .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#zuguzitfrq .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#zuguzitfrq .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#zuguzitfrq .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#zuguzitfrq .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#zuguzitfrq .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#zuguzitfrq .gt_spanner_row {
  border-bottom-style: hidden;
}

#zuguzitfrq .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#zuguzitfrq .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#zuguzitfrq .gt_from_md > :first-child {
  margin-top: 0;
}

#zuguzitfrq .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zuguzitfrq .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#zuguzitfrq .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#zuguzitfrq .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#zuguzitfrq .gt_row_group_first td {
  border-top-width: 2px;
}

#zuguzitfrq .gt_row_group_first th {
  border-top-width: 2px;
}

#zuguzitfrq .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zuguzitfrq .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#zuguzitfrq .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#zuguzitfrq .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zuguzitfrq .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zuguzitfrq .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#zuguzitfrq .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#zuguzitfrq .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#zuguzitfrq .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zuguzitfrq .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#zuguzitfrq .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#zuguzitfrq .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#zuguzitfrq .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#zuguzitfrq .gt_left {
  text-align: left;
}

#zuguzitfrq .gt_center {
  text-align: center;
}

#zuguzitfrq .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zuguzitfrq .gt_font_normal {
  font-weight: normal;
}

#zuguzitfrq .gt_font_bold {
  font-weight: bold;
}

#zuguzitfrq .gt_font_italic {
  font-style: italic;
}

#zuguzitfrq .gt_super {
  font-size: 65%;
}

#zuguzitfrq .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#zuguzitfrq .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#zuguzitfrq .gt_indent_1 {
  text-indent: 5px;
}

#zuguzitfrq .gt_indent_2 {
  text-indent: 10px;
}

#zuguzitfrq .gt_indent_3 {
  text-indent: 15px;
}

#zuguzitfrq .gt_indent_4 {
  text-indent: 20px;
}

#zuguzitfrq .gt_indent_5 {
  text-indent: 25px;
}

#zuguzitfrq .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#zuguzitfrq div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**Traitement**">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Traitement</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">45 (5 ; 10%)</td>
<td headers="stat_1" class="gt_row gt_center">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_center">19 (2 ; 4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (9.5)</td>
<td headers="stat_1" class="gt_row gt_center">51.0 (9.6)</td>
<td headers="stat_2" class="gt_row gt_center">50.2 (9.5)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (44.4 ; 57.0)</td>
<td headers="stat_1" class="gt_row gt_center">51.3 (44.4 ; 57.0)</td>
<td headers="stat_2" class="gt_row gt_center">49.4 (43.1 ; 58.8)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_1" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_2" class="gt_row gt_center">33.1 ; 67.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">13 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_center">15 (71.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_0" class="gt_row gt_center">22 (44.0%)</td>
<td headers="stat_1" class="gt_row gt_center">16 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_0" class="gt_row gt_center">7 (14.0%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">18 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_center">10 (47.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_0" class="gt_row gt_center">15 (30.0%)</td>
<td headers="stat_1" class="gt_row gt_center">9 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">13 (26.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">7 (33.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">11 (22.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_center">5 (10.0%)</td>
<td headers="stat_1" class="gt_row gt_center">4 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (4.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_0" class="gt_row gt_center">3 (6.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_0" class="gt_row gt_center">12 (24.0%)</td>
<td headers="stat_1" class="gt_row gt_center">7 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_0" class="gt_row gt_center">6 (12.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (14.3%)</td></tr>
  </tbody>
  
  
</table>
</div>
```


# Quantitative and qualitative feature

The package support the user specification of feature type as quantitative or qualitative features. For instance, you could chose to describe a quantitative features as a qualitative one if it has few values. For instance, we can do this for `Age` after we round it.


``` r
data %>%
  dplyr::select(Age, traitement) %>%
  dplyr::mutate(Age = round(Age)) %>%
  Descusmr::desc_var(table_title = "test",
                     var_group = "traitement",
                     group_title = "traitement",
                     quali = c("Age"))
```


```{=html}
<div id="umuhugtrqa" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#umuhugtrqa table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#umuhugtrqa thead, #umuhugtrqa tbody, #umuhugtrqa tfoot, #umuhugtrqa tr, #umuhugtrqa td, #umuhugtrqa th {
  border-style: none;
}

#umuhugtrqa p {
  margin: 0;
  padding: 0;
}

#umuhugtrqa .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#umuhugtrqa .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#umuhugtrqa .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#umuhugtrqa .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#umuhugtrqa .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#umuhugtrqa .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#umuhugtrqa .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#umuhugtrqa .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#umuhugtrqa .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#umuhugtrqa .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#umuhugtrqa .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#umuhugtrqa .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#umuhugtrqa .gt_spanner_row {
  border-bottom-style: hidden;
}

#umuhugtrqa .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#umuhugtrqa .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#umuhugtrqa .gt_from_md > :first-child {
  margin-top: 0;
}

#umuhugtrqa .gt_from_md > :last-child {
  margin-bottom: 0;
}

#umuhugtrqa .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#umuhugtrqa .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#umuhugtrqa .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#umuhugtrqa .gt_row_group_first td {
  border-top-width: 2px;
}

#umuhugtrqa .gt_row_group_first th {
  border-top-width: 2px;
}

#umuhugtrqa .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#umuhugtrqa .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#umuhugtrqa .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#umuhugtrqa .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#umuhugtrqa .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#umuhugtrqa .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#umuhugtrqa .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#umuhugtrqa .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#umuhugtrqa .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#umuhugtrqa .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#umuhugtrqa .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#umuhugtrqa .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#umuhugtrqa .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#umuhugtrqa .gt_left {
  text-align: left;
}

#umuhugtrqa .gt_center {
  text-align: center;
}

#umuhugtrqa .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#umuhugtrqa .gt_font_normal {
  font-weight: normal;
}

#umuhugtrqa .gt_font_bold {
  font-weight: bold;
}

#umuhugtrqa .gt_font_italic {
  font-style: italic;
}

#umuhugtrqa .gt_super {
  font-size: 65%;
}

#umuhugtrqa .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#umuhugtrqa .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#umuhugtrqa .gt_indent_1 {
  text-indent: 5px;
}

#umuhugtrqa .gt_indent_2 {
  text-indent: 10px;
}

#umuhugtrqa .gt_indent_3 {
  text-indent: 15px;
}

#umuhugtrqa .gt_indent_4 {
  text-indent: 20px;
}

#umuhugtrqa .gt_indent_5 {
  text-indent: 25px;
}

#umuhugtrqa .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#umuhugtrqa div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**traitement**">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>traitement</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">45 (5 ; 10%)</td>
<td headers="stat_1" class="gt_row gt_center">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_center">19 (2 ; 4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    30</td>
<td headers="stat_0" class="gt_row gt_center">1 (2.2%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (3.8%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    33</td>
<td headers="stat_0" class="gt_row gt_center">1 (2.2%)</td>
<td headers="stat_1" class="gt_row gt_center">0 (0.0%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (5.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    37</td>
<td headers="stat_0" class="gt_row gt_center">2 (4.4%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (3.8%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (5.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    39</td>
<td headers="stat_0" class="gt_row gt_center">2 (4.4%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (3.8%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (5.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    40</td>
<td headers="stat_0" class="gt_row gt_center">1 (2.2%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (3.8%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    43</td>
<td headers="stat_0" class="gt_row gt_center">3 (6.7%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (3.8%)</td>
<td headers="stat_2" class="gt_row gt_center">2 (10.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    44</td>
<td headers="stat_0" class="gt_row gt_center">3 (6.7%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (11.5%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    45</td>
<td headers="stat_0" class="gt_row gt_center">1 (2.2%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (3.8%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    46</td>
<td headers="stat_0" class="gt_row gt_center">2 (4.4%)</td>
<td headers="stat_1" class="gt_row gt_center">0 (0.0%)</td>
<td headers="stat_2" class="gt_row gt_center">2 (10.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    47</td>
<td headers="stat_0" class="gt_row gt_center">2 (4.4%)</td>
<td headers="stat_1" class="gt_row gt_center">0 (0.0%)</td>
<td headers="stat_2" class="gt_row gt_center">2 (10.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    48</td>
<td headers="stat_0" class="gt_row gt_center">3 (6.7%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (11.5%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    49</td>
<td headers="stat_0" class="gt_row gt_center">1 (2.2%)</td>
<td headers="stat_1" class="gt_row gt_center">0 (0.0%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (5.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    51</td>
<td headers="stat_0" class="gt_row gt_center">3 (6.7%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (3.8%)</td>
<td headers="stat_2" class="gt_row gt_center">2 (10.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    52</td>
<td headers="stat_0" class="gt_row gt_center">1 (2.2%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (3.8%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    54</td>
<td headers="stat_0" class="gt_row gt_center">3 (6.7%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (3.8%)</td>
<td headers="stat_2" class="gt_row gt_center">2 (10.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    55</td>
<td headers="stat_0" class="gt_row gt_center">2 (4.4%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (7.7%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    56</td>
<td headers="stat_0" class="gt_row gt_center">1 (2.2%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (3.8%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    57</td>
<td headers="stat_0" class="gt_row gt_center">2 (4.4%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (7.7%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    58</td>
<td headers="stat_0" class="gt_row gt_center">2 (4.4%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (7.7%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    59</td>
<td headers="stat_0" class="gt_row gt_center">2 (4.4%)</td>
<td headers="stat_1" class="gt_row gt_center">0 (0.0%)</td>
<td headers="stat_2" class="gt_row gt_center">2 (10.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    62</td>
<td headers="stat_0" class="gt_row gt_center">2 (4.4%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (7.7%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    63</td>
<td headers="stat_0" class="gt_row gt_center">1 (2.2%)</td>
<td headers="stat_1" class="gt_row gt_center">0 (0.0%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (5.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    66</td>
<td headers="stat_0" class="gt_row gt_center">1 (2.2%)</td>
<td headers="stat_1" class="gt_row gt_center">0 (0.0%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (5.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    67</td>
<td headers="stat_0" class="gt_row gt_center">1 (2.2%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (3.8%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    68</td>
<td headers="stat_0" class="gt_row gt_center">1 (2.2%)</td>
<td headers="stat_1" class="gt_row gt_center">0 (0.0%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (5.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    72</td>
<td headers="stat_0" class="gt_row gt_center">1 (2.2%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (3.8%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
  </tbody>
  
  
</table>
</div>
```



# Missing data

The display of missing data is controlled by the `show_missing_data` argument in the `Descusmr::desc_var` function. By default, if `anyNA(data1)` returns `TRUE`, missing data will be displayed. If no missing data is detected, it will be hidden. Users can override this behavior by explicitly setting `show_missing_data` to `TRUE` or `FALSE`.


``` r
iris %>% Descusmr::desc_var(table_title = "test",
                            var_group = "Species",
                            group_title = "Species",
                            show_missing_data = TRUE)
```


```{=html}
<div id="owcigidbvz" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#owcigidbvz table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#owcigidbvz thead, #owcigidbvz tbody, #owcigidbvz tfoot, #owcigidbvz tr, #owcigidbvz td, #owcigidbvz th {
  border-style: none;
}

#owcigidbvz p {
  margin: 0;
  padding: 0;
}

#owcigidbvz .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#owcigidbvz .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#owcigidbvz .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#owcigidbvz .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#owcigidbvz .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#owcigidbvz .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#owcigidbvz .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#owcigidbvz .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#owcigidbvz .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#owcigidbvz .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#owcigidbvz .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#owcigidbvz .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#owcigidbvz .gt_spanner_row {
  border-bottom-style: hidden;
}

#owcigidbvz .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#owcigidbvz .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#owcigidbvz .gt_from_md > :first-child {
  margin-top: 0;
}

#owcigidbvz .gt_from_md > :last-child {
  margin-bottom: 0;
}

#owcigidbvz .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#owcigidbvz .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#owcigidbvz .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#owcigidbvz .gt_row_group_first td {
  border-top-width: 2px;
}

#owcigidbvz .gt_row_group_first th {
  border-top-width: 2px;
}

#owcigidbvz .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#owcigidbvz .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#owcigidbvz .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#owcigidbvz .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#owcigidbvz .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#owcigidbvz .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#owcigidbvz .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#owcigidbvz .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#owcigidbvz .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#owcigidbvz .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#owcigidbvz .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#owcigidbvz .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#owcigidbvz .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#owcigidbvz .gt_left {
  text-align: left;
}

#owcigidbvz .gt_center {
  text-align: center;
}

#owcigidbvz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#owcigidbvz .gt_font_normal {
  font-weight: normal;
}

#owcigidbvz .gt_font_bold {
  font-weight: bold;
}

#owcigidbvz .gt_font_italic {
  font-style: italic;
}

#owcigidbvz .gt_super {
  font-size: 65%;
}

#owcigidbvz .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#owcigidbvz .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#owcigidbvz .gt_indent_1 {
  text-indent: 5px;
}

#owcigidbvz .gt_indent_2 {
  text-indent: 10px;
}

#owcigidbvz .gt_indent_3 {
  text-indent: 15px;
}

#owcigidbvz .gt_indent_4 {
  text-indent: 20px;
}

#owcigidbvz .gt_indent_5 {
  text-indent: 25px;
}

#owcigidbvz .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#owcigidbvz div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="3" scope="colgroup" id="**Species**">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Species</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>setosa</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>versicolor</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_3"><span class='gt_from_md'><strong>virginica</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Sepal.Length n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">150 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_3" class="gt_row gt_center">50 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">5.8 (0.8)</td>
<td headers="stat_1" class="gt_row gt_center">5.0 (0.4)</td>
<td headers="stat_2" class="gt_row gt_center">5.9 (0.5)</td>
<td headers="stat_3" class="gt_row gt_center">6.6 (0.6)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">5.8 (5.1 ; 6.4)</td>
<td headers="stat_1" class="gt_row gt_center">5.0 (4.8 ; 5.2)</td>
<td headers="stat_2" class="gt_row gt_center">5.9 (5.6 ; 6.3)</td>
<td headers="stat_3" class="gt_row gt_center">6.5 (6.2 ; 6.9)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">4.3 ; 7.9</td>
<td headers="stat_1" class="gt_row gt_center">4.3 ; 5.8</td>
<td headers="stat_2" class="gt_row gt_center">4.9 ; 7.0</td>
<td headers="stat_3" class="gt_row gt_center">4.9 ; 7.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Sepal.Width n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">150 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_3" class="gt_row gt_center">50 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">3.1 (0.4)</td>
<td headers="stat_1" class="gt_row gt_center">3.4 (0.4)</td>
<td headers="stat_2" class="gt_row gt_center">2.8 (0.3)</td>
<td headers="stat_3" class="gt_row gt_center">3.0 (0.3)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">3.0 (2.8 ; 3.3)</td>
<td headers="stat_1" class="gt_row gt_center">3.4 (3.2 ; 3.7)</td>
<td headers="stat_2" class="gt_row gt_center">2.8 (2.5 ; 3.0)</td>
<td headers="stat_3" class="gt_row gt_center">3.0 (2.8 ; 3.2)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">2.0 ; 4.4</td>
<td headers="stat_1" class="gt_row gt_center">2.3 ; 4.4</td>
<td headers="stat_2" class="gt_row gt_center">2.0 ; 3.4</td>
<td headers="stat_3" class="gt_row gt_center">2.2 ; 3.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Petal.Length n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">150 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_3" class="gt_row gt_center">50 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">3.8 (1.8)</td>
<td headers="stat_1" class="gt_row gt_center">1.5 (0.2)</td>
<td headers="stat_2" class="gt_row gt_center">4.3 (0.5)</td>
<td headers="stat_3" class="gt_row gt_center">5.6 (0.6)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">4.4 (1.6 ; 5.1)</td>
<td headers="stat_1" class="gt_row gt_center">1.5 (1.4 ; 1.6)</td>
<td headers="stat_2" class="gt_row gt_center">4.4 (4.0 ; 4.6)</td>
<td headers="stat_3" class="gt_row gt_center">5.6 (5.1 ; 5.9)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">1.0 ; 6.9</td>
<td headers="stat_1" class="gt_row gt_center">1.0 ; 1.9</td>
<td headers="stat_2" class="gt_row gt_center">3.0 ; 5.1</td>
<td headers="stat_3" class="gt_row gt_center">4.5 ; 6.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Petal.Width n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">150 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_3" class="gt_row gt_center">50 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">1.2 (0.8)</td>
<td headers="stat_1" class="gt_row gt_center">0.2 (0.1)</td>
<td headers="stat_2" class="gt_row gt_center">1.3 (0.2)</td>
<td headers="stat_3" class="gt_row gt_center">2.0 (0.3)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">1.3 (0.3 ; 1.8)</td>
<td headers="stat_1" class="gt_row gt_center">0.2 (0.2 ; 0.3)</td>
<td headers="stat_2" class="gt_row gt_center">1.3 (1.2 ; 1.5)</td>
<td headers="stat_3" class="gt_row gt_center">2.0 (1.8 ; 2.3)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">0.1 ; 2.5</td>
<td headers="stat_1" class="gt_row gt_center">0.1 ; 0.6</td>
<td headers="stat_2" class="gt_row gt_center">1.0 ; 1.8</td>
<td headers="stat_3" class="gt_row gt_center">1.4 ; 2.5</td></tr>
  </tbody>
  
  
</table>
</div>
```



``` r
iris %>% Descusmr::desc_var(table_title = "test",
                            var_group = "Species",
                            group_title = "Species",
                            show_missing_data = FALSE)
```


```{=html}
<div id="gjqrhsjwkq" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#gjqrhsjwkq table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#gjqrhsjwkq thead, #gjqrhsjwkq tbody, #gjqrhsjwkq tfoot, #gjqrhsjwkq tr, #gjqrhsjwkq td, #gjqrhsjwkq th {
  border-style: none;
}

#gjqrhsjwkq p {
  margin: 0;
  padding: 0;
}

#gjqrhsjwkq .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#gjqrhsjwkq .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#gjqrhsjwkq .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#gjqrhsjwkq .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#gjqrhsjwkq .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#gjqrhsjwkq .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gjqrhsjwkq .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#gjqrhsjwkq .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#gjqrhsjwkq .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#gjqrhsjwkq .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#gjqrhsjwkq .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#gjqrhsjwkq .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#gjqrhsjwkq .gt_spanner_row {
  border-bottom-style: hidden;
}

#gjqrhsjwkq .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#gjqrhsjwkq .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#gjqrhsjwkq .gt_from_md > :first-child {
  margin-top: 0;
}

#gjqrhsjwkq .gt_from_md > :last-child {
  margin-bottom: 0;
}

#gjqrhsjwkq .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#gjqrhsjwkq .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#gjqrhsjwkq .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#gjqrhsjwkq .gt_row_group_first td {
  border-top-width: 2px;
}

#gjqrhsjwkq .gt_row_group_first th {
  border-top-width: 2px;
}

#gjqrhsjwkq .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gjqrhsjwkq .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#gjqrhsjwkq .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#gjqrhsjwkq .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gjqrhsjwkq .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gjqrhsjwkq .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#gjqrhsjwkq .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#gjqrhsjwkq .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#gjqrhsjwkq .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gjqrhsjwkq .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#gjqrhsjwkq .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#gjqrhsjwkq .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#gjqrhsjwkq .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#gjqrhsjwkq .gt_left {
  text-align: left;
}

#gjqrhsjwkq .gt_center {
  text-align: center;
}

#gjqrhsjwkq .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#gjqrhsjwkq .gt_font_normal {
  font-weight: normal;
}

#gjqrhsjwkq .gt_font_bold {
  font-weight: bold;
}

#gjqrhsjwkq .gt_font_italic {
  font-style: italic;
}

#gjqrhsjwkq .gt_super {
  font-size: 65%;
}

#gjqrhsjwkq .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#gjqrhsjwkq .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#gjqrhsjwkq .gt_indent_1 {
  text-indent: 5px;
}

#gjqrhsjwkq .gt_indent_2 {
  text-indent: 10px;
}

#gjqrhsjwkq .gt_indent_3 {
  text-indent: 15px;
}

#gjqrhsjwkq .gt_indent_4 {
  text-indent: 20px;
}

#gjqrhsjwkq .gt_indent_5 {
  text-indent: 25px;
}

#gjqrhsjwkq .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#gjqrhsjwkq div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="3" scope="colgroup" id="**Species**">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Species</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>setosa</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>versicolor</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_3"><span class='gt_from_md'><strong>virginica</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Sepal.Length</td>
<td headers="stat_0" class="gt_row gt_center">150</td>
<td headers="stat_1" class="gt_row gt_center">50</td>
<td headers="stat_2" class="gt_row gt_center">50</td>
<td headers="stat_3" class="gt_row gt_center">50</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">5.8 (0.8)</td>
<td headers="stat_1" class="gt_row gt_center">5.0 (0.4)</td>
<td headers="stat_2" class="gt_row gt_center">5.9 (0.5)</td>
<td headers="stat_3" class="gt_row gt_center">6.6 (0.6)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">5.8 (5.1 ; 6.4)</td>
<td headers="stat_1" class="gt_row gt_center">5.0 (4.8 ; 5.2)</td>
<td headers="stat_2" class="gt_row gt_center">5.9 (5.6 ; 6.3)</td>
<td headers="stat_3" class="gt_row gt_center">6.5 (6.2 ; 6.9)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">4.3 ; 7.9</td>
<td headers="stat_1" class="gt_row gt_center">4.3 ; 5.8</td>
<td headers="stat_2" class="gt_row gt_center">4.9 ; 7.0</td>
<td headers="stat_3" class="gt_row gt_center">4.9 ; 7.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Sepal.Width</td>
<td headers="stat_0" class="gt_row gt_center">150</td>
<td headers="stat_1" class="gt_row gt_center">50</td>
<td headers="stat_2" class="gt_row gt_center">50</td>
<td headers="stat_3" class="gt_row gt_center">50</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">3.1 (0.4)</td>
<td headers="stat_1" class="gt_row gt_center">3.4 (0.4)</td>
<td headers="stat_2" class="gt_row gt_center">2.8 (0.3)</td>
<td headers="stat_3" class="gt_row gt_center">3.0 (0.3)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">3.0 (2.8 ; 3.3)</td>
<td headers="stat_1" class="gt_row gt_center">3.4 (3.2 ; 3.7)</td>
<td headers="stat_2" class="gt_row gt_center">2.8 (2.5 ; 3.0)</td>
<td headers="stat_3" class="gt_row gt_center">3.0 (2.8 ; 3.2)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">2.0 ; 4.4</td>
<td headers="stat_1" class="gt_row gt_center">2.3 ; 4.4</td>
<td headers="stat_2" class="gt_row gt_center">2.0 ; 3.4</td>
<td headers="stat_3" class="gt_row gt_center">2.2 ; 3.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Petal.Length</td>
<td headers="stat_0" class="gt_row gt_center">150</td>
<td headers="stat_1" class="gt_row gt_center">50</td>
<td headers="stat_2" class="gt_row gt_center">50</td>
<td headers="stat_3" class="gt_row gt_center">50</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">3.8 (1.8)</td>
<td headers="stat_1" class="gt_row gt_center">1.5 (0.2)</td>
<td headers="stat_2" class="gt_row gt_center">4.3 (0.5)</td>
<td headers="stat_3" class="gt_row gt_center">5.6 (0.6)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">4.4 (1.6 ; 5.1)</td>
<td headers="stat_1" class="gt_row gt_center">1.5 (1.4 ; 1.6)</td>
<td headers="stat_2" class="gt_row gt_center">4.4 (4.0 ; 4.6)</td>
<td headers="stat_3" class="gt_row gt_center">5.6 (5.1 ; 5.9)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">1.0 ; 6.9</td>
<td headers="stat_1" class="gt_row gt_center">1.0 ; 1.9</td>
<td headers="stat_2" class="gt_row gt_center">3.0 ; 5.1</td>
<td headers="stat_3" class="gt_row gt_center">4.5 ; 6.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Petal.Width</td>
<td headers="stat_0" class="gt_row gt_center">150</td>
<td headers="stat_1" class="gt_row gt_center">50</td>
<td headers="stat_2" class="gt_row gt_center">50</td>
<td headers="stat_3" class="gt_row gt_center">50</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">1.2 (0.8)</td>
<td headers="stat_1" class="gt_row gt_center">0.2 (0.1)</td>
<td headers="stat_2" class="gt_row gt_center">1.3 (0.2)</td>
<td headers="stat_3" class="gt_row gt_center">2.0 (0.3)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">1.3 (0.3 ; 1.8)</td>
<td headers="stat_1" class="gt_row gt_center">0.2 (0.2 ; 0.3)</td>
<td headers="stat_2" class="gt_row gt_center">1.3 (1.2 ; 1.5)</td>
<td headers="stat_3" class="gt_row gt_center">2.0 (1.8 ; 2.3)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">0.1 ; 2.5</td>
<td headers="stat_1" class="gt_row gt_center">0.1 ; 0.6</td>
<td headers="stat_2" class="gt_row gt_center">1.0 ; 1.8</td>
<td headers="stat_3" class="gt_row gt_center">1.4 ; 2.5</td></tr>
  </tbody>
  
  
</table>
</div>
```


# Feature Data Management

In the previous example, no specific data management operations were applied.

## Order of categorical features

### Order by frequency

In this example, we add `freq_relevel = TRUE`, which orders the categories of categorical variables in descending order based on their counts.


``` r
data %>% desc_var(table_title = "test",
             var_group = "traitement",
             group_title = "traitement",
             freq_relevel = TRUE)
```


```{=html}
<div id="scnaxapkdx" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#scnaxapkdx table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#scnaxapkdx thead, #scnaxapkdx tbody, #scnaxapkdx tfoot, #scnaxapkdx tr, #scnaxapkdx td, #scnaxapkdx th {
  border-style: none;
}

#scnaxapkdx p {
  margin: 0;
  padding: 0;
}

#scnaxapkdx .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#scnaxapkdx .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#scnaxapkdx .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#scnaxapkdx .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#scnaxapkdx .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#scnaxapkdx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#scnaxapkdx .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#scnaxapkdx .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#scnaxapkdx .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#scnaxapkdx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#scnaxapkdx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#scnaxapkdx .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#scnaxapkdx .gt_spanner_row {
  border-bottom-style: hidden;
}

#scnaxapkdx .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#scnaxapkdx .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#scnaxapkdx .gt_from_md > :first-child {
  margin-top: 0;
}

#scnaxapkdx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#scnaxapkdx .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#scnaxapkdx .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#scnaxapkdx .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#scnaxapkdx .gt_row_group_first td {
  border-top-width: 2px;
}

#scnaxapkdx .gt_row_group_first th {
  border-top-width: 2px;
}

#scnaxapkdx .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#scnaxapkdx .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#scnaxapkdx .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#scnaxapkdx .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#scnaxapkdx .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#scnaxapkdx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#scnaxapkdx .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#scnaxapkdx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#scnaxapkdx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#scnaxapkdx .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#scnaxapkdx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#scnaxapkdx .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#scnaxapkdx .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#scnaxapkdx .gt_left {
  text-align: left;
}

#scnaxapkdx .gt_center {
  text-align: center;
}

#scnaxapkdx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#scnaxapkdx .gt_font_normal {
  font-weight: normal;
}

#scnaxapkdx .gt_font_bold {
  font-weight: bold;
}

#scnaxapkdx .gt_font_italic {
  font-style: italic;
}

#scnaxapkdx .gt_super {
  font-size: 65%;
}

#scnaxapkdx .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#scnaxapkdx .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#scnaxapkdx .gt_indent_1 {
  text-indent: 5px;
}

#scnaxapkdx .gt_indent_2 {
  text-indent: 10px;
}

#scnaxapkdx .gt_indent_3 {
  text-indent: 15px;
}

#scnaxapkdx .gt_indent_4 {
  text-indent: 20px;
}

#scnaxapkdx .gt_indent_5 {
  text-indent: 25px;
}

#scnaxapkdx .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#scnaxapkdx div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**traitement**">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>traitement</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">45 (5 ; 10%)</td>
<td headers="stat_1" class="gt_row gt_center">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_center">19 (2 ; 4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (9.5)</td>
<td headers="stat_1" class="gt_row gt_center">51.0 (9.6)</td>
<td headers="stat_2" class="gt_row gt_center">50.2 (9.5)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (44.4 ; 57.0)</td>
<td headers="stat_1" class="gt_row gt_center">51.3 (44.4 ; 57.0)</td>
<td headers="stat_2" class="gt_row gt_center">49.4 (43.1 ; 58.8)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_1" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_2" class="gt_row gt_center">33.1 ; 67.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">13 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_center">15 (71.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_0" class="gt_row gt_center">22 (44.0%)</td>
<td headers="stat_1" class="gt_row gt_center">16 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">18 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_center">10 (47.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_0" class="gt_row gt_center">15 (30.0%)</td>
<td headers="stat_1" class="gt_row gt_center">9 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_0" class="gt_row gt_center">7 (14.0%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">13 (26.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">7 (33.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">11 (22.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_center">5 (10.0%)</td>
<td headers="stat_1" class="gt_row gt_center">4 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (4.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_0" class="gt_row gt_center">3 (6.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_0" class="gt_row gt_center">12 (24.0%)</td>
<td headers="stat_1" class="gt_row gt_center">7 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_0" class="gt_row gt_center">6 (12.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (14.3%)</td></tr>
  </tbody>
  
  
</table>
</div>
```


### Custom order

The default order of categorical features is determined by their levels. If you want to customize this order, you can modify the levels using a library such as `forcats`.


``` r
data %>%
  dplyr::mutate(quatre_modalites = forcats::fct_relevel(quatre_modalites,
                                                       "A", "C", "D", "B")) %>%
  desc_var(table_title = "test",
           var_group = "traitement",
           group_title = "traitement")
```


```{=html}
<div id="cnhfdwjpxp" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#cnhfdwjpxp table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#cnhfdwjpxp thead, #cnhfdwjpxp tbody, #cnhfdwjpxp tfoot, #cnhfdwjpxp tr, #cnhfdwjpxp td, #cnhfdwjpxp th {
  border-style: none;
}

#cnhfdwjpxp p {
  margin: 0;
  padding: 0;
}

#cnhfdwjpxp .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#cnhfdwjpxp .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#cnhfdwjpxp .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#cnhfdwjpxp .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#cnhfdwjpxp .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#cnhfdwjpxp .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cnhfdwjpxp .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#cnhfdwjpxp .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#cnhfdwjpxp .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#cnhfdwjpxp .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#cnhfdwjpxp .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#cnhfdwjpxp .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#cnhfdwjpxp .gt_spanner_row {
  border-bottom-style: hidden;
}

#cnhfdwjpxp .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#cnhfdwjpxp .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#cnhfdwjpxp .gt_from_md > :first-child {
  margin-top: 0;
}

#cnhfdwjpxp .gt_from_md > :last-child {
  margin-bottom: 0;
}

#cnhfdwjpxp .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#cnhfdwjpxp .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#cnhfdwjpxp .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#cnhfdwjpxp .gt_row_group_first td {
  border-top-width: 2px;
}

#cnhfdwjpxp .gt_row_group_first th {
  border-top-width: 2px;
}

#cnhfdwjpxp .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cnhfdwjpxp .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#cnhfdwjpxp .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#cnhfdwjpxp .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cnhfdwjpxp .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cnhfdwjpxp .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#cnhfdwjpxp .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#cnhfdwjpxp .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#cnhfdwjpxp .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cnhfdwjpxp .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#cnhfdwjpxp .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cnhfdwjpxp .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#cnhfdwjpxp .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cnhfdwjpxp .gt_left {
  text-align: left;
}

#cnhfdwjpxp .gt_center {
  text-align: center;
}

#cnhfdwjpxp .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#cnhfdwjpxp .gt_font_normal {
  font-weight: normal;
}

#cnhfdwjpxp .gt_font_bold {
  font-weight: bold;
}

#cnhfdwjpxp .gt_font_italic {
  font-style: italic;
}

#cnhfdwjpxp .gt_super {
  font-size: 65%;
}

#cnhfdwjpxp .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#cnhfdwjpxp .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#cnhfdwjpxp .gt_indent_1 {
  text-indent: 5px;
}

#cnhfdwjpxp .gt_indent_2 {
  text-indent: 10px;
}

#cnhfdwjpxp .gt_indent_3 {
  text-indent: 15px;
}

#cnhfdwjpxp .gt_indent_4 {
  text-indent: 20px;
}

#cnhfdwjpxp .gt_indent_5 {
  text-indent: 25px;
}

#cnhfdwjpxp .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#cnhfdwjpxp div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**traitement**">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>traitement</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">45 (5 ; 10%)</td>
<td headers="stat_1" class="gt_row gt_center">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_center">19 (2 ; 4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (9.5)</td>
<td headers="stat_1" class="gt_row gt_center">51.0 (9.6)</td>
<td headers="stat_2" class="gt_row gt_center">50.2 (9.5)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (44.4 ; 57.0)</td>
<td headers="stat_1" class="gt_row gt_center">51.3 (44.4 ; 57.0)</td>
<td headers="stat_2" class="gt_row gt_center">49.4 (43.1 ; 58.8)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_1" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_2" class="gt_row gt_center">33.1 ; 67.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">13 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_center">15 (71.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_0" class="gt_row gt_center">22 (44.0%)</td>
<td headers="stat_1" class="gt_row gt_center">16 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_0" class="gt_row gt_center">7 (14.0%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_0" class="gt_row gt_center">15 (30.0%)</td>
<td headers="stat_1" class="gt_row gt_center">9 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">18 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_center">10 (47.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">13 (26.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">7 (33.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">11 (22.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_center">5 (10.0%)</td>
<td headers="stat_1" class="gt_row gt_center">4 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (4.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_0" class="gt_row gt_center">3 (6.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_0" class="gt_row gt_center">12 (24.0%)</td>
<td headers="stat_1" class="gt_row gt_center">7 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_0" class="gt_row gt_center">6 (12.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (14.3%)</td></tr>
  </tbody>
  
  
</table>
</div>
```



## Remove zero-count levels


By default, zero-count levels are removed but we can explicitly specify we do not want to drop them.


``` r
data %>% desc_var(table_title = "test",
             var_group = "traitement",
             group_title = "traitement",
             drop_levels = FALSE)
```


```{=html}
<div id="gtppikksjw" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#gtppikksjw table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#gtppikksjw thead, #gtppikksjw tbody, #gtppikksjw tfoot, #gtppikksjw tr, #gtppikksjw td, #gtppikksjw th {
  border-style: none;
}

#gtppikksjw p {
  margin: 0;
  padding: 0;
}

#gtppikksjw .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#gtppikksjw .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#gtppikksjw .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#gtppikksjw .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#gtppikksjw .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#gtppikksjw .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gtppikksjw .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#gtppikksjw .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#gtppikksjw .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#gtppikksjw .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#gtppikksjw .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#gtppikksjw .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#gtppikksjw .gt_spanner_row {
  border-bottom-style: hidden;
}

#gtppikksjw .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#gtppikksjw .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#gtppikksjw .gt_from_md > :first-child {
  margin-top: 0;
}

#gtppikksjw .gt_from_md > :last-child {
  margin-bottom: 0;
}

#gtppikksjw .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#gtppikksjw .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#gtppikksjw .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#gtppikksjw .gt_row_group_first td {
  border-top-width: 2px;
}

#gtppikksjw .gt_row_group_first th {
  border-top-width: 2px;
}

#gtppikksjw .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gtppikksjw .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#gtppikksjw .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#gtppikksjw .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gtppikksjw .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gtppikksjw .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#gtppikksjw .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#gtppikksjw .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#gtppikksjw .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gtppikksjw .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#gtppikksjw .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#gtppikksjw .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#gtppikksjw .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#gtppikksjw .gt_left {
  text-align: left;
}

#gtppikksjw .gt_center {
  text-align: center;
}

#gtppikksjw .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#gtppikksjw .gt_font_normal {
  font-weight: normal;
}

#gtppikksjw .gt_font_bold {
  font-weight: bold;
}

#gtppikksjw .gt_font_italic {
  font-style: italic;
}

#gtppikksjw .gt_super {
  font-size: 65%;
}

#gtppikksjw .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#gtppikksjw .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#gtppikksjw .gt_indent_1 {
  text-indent: 5px;
}

#gtppikksjw .gt_indent_2 {
  text-indent: 10px;
}

#gtppikksjw .gt_indent_3 {
  text-indent: 15px;
}

#gtppikksjw .gt_indent_4 {
  text-indent: 20px;
}

#gtppikksjw .gt_indent_5 {
  text-indent: 25px;
}

#gtppikksjw .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#gtppikksjw div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**traitement**">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>traitement</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">45 (5 ; 10%)</td>
<td headers="stat_1" class="gt_row gt_center">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_center">19 (2 ; 4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (9.5)</td>
<td headers="stat_1" class="gt_row gt_center">51.0 (9.6)</td>
<td headers="stat_2" class="gt_row gt_center">50.2 (9.5)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (44.4 ; 57.0)</td>
<td headers="stat_1" class="gt_row gt_center">51.3 (44.4 ; 57.0)</td>
<td headers="stat_2" class="gt_row gt_center">49.4 (43.1 ; 58.8)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_1" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_2" class="gt_row gt_center">33.1 ; 67.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">13 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_center">15 (71.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_0" class="gt_row gt_center">22 (44.0%)</td>
<td headers="stat_1" class="gt_row gt_center">16 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_0" class="gt_row gt_center">7 (14.0%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">18 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_center">10 (47.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_0" class="gt_row gt_center">15 (30.0%)</td>
<td headers="stat_1" class="gt_row gt_center">9 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    D</td>
<td headers="stat_0" class="gt_row gt_center">0 (0.0%)</td>
<td headers="stat_1" class="gt_row gt_center">0 (0.0%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">13 (26.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">7 (33.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">11 (22.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_center">5 (10.0%)</td>
<td headers="stat_1" class="gt_row gt_center">4 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (4.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_0" class="gt_row gt_center">3 (6.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_0" class="gt_row gt_center">12 (24.0%)</td>
<td headers="stat_1" class="gt_row gt_center">7 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_0" class="gt_row gt_center">6 (12.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (14.3%)</td></tr>
  </tbody>
  
  
</table>
</div>
```


# Overall and Per-Group Descriptions

## Per-Group Description

Here, we use a per-group description for the variables.


``` r
data %>% desc_var(table_title = "test",
             var_group = "traitement",
             group_title = "traitement")
```


```{=html}
<div id="ekotbpwsjs" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ekotbpwsjs table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ekotbpwsjs thead, #ekotbpwsjs tbody, #ekotbpwsjs tfoot, #ekotbpwsjs tr, #ekotbpwsjs td, #ekotbpwsjs th {
  border-style: none;
}

#ekotbpwsjs p {
  margin: 0;
  padding: 0;
}

#ekotbpwsjs .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#ekotbpwsjs .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ekotbpwsjs .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ekotbpwsjs .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ekotbpwsjs .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ekotbpwsjs .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ekotbpwsjs .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ekotbpwsjs .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#ekotbpwsjs .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#ekotbpwsjs .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ekotbpwsjs .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ekotbpwsjs .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#ekotbpwsjs .gt_spanner_row {
  border-bottom-style: hidden;
}

#ekotbpwsjs .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#ekotbpwsjs .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#ekotbpwsjs .gt_from_md > :first-child {
  margin-top: 0;
}

#ekotbpwsjs .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ekotbpwsjs .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#ekotbpwsjs .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#ekotbpwsjs .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#ekotbpwsjs .gt_row_group_first td {
  border-top-width: 2px;
}

#ekotbpwsjs .gt_row_group_first th {
  border-top-width: 2px;
}

#ekotbpwsjs .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ekotbpwsjs .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ekotbpwsjs .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ekotbpwsjs .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ekotbpwsjs .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ekotbpwsjs .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ekotbpwsjs .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ekotbpwsjs .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ekotbpwsjs .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ekotbpwsjs .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#ekotbpwsjs .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ekotbpwsjs .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#ekotbpwsjs .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ekotbpwsjs .gt_left {
  text-align: left;
}

#ekotbpwsjs .gt_center {
  text-align: center;
}

#ekotbpwsjs .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ekotbpwsjs .gt_font_normal {
  font-weight: normal;
}

#ekotbpwsjs .gt_font_bold {
  font-weight: bold;
}

#ekotbpwsjs .gt_font_italic {
  font-style: italic;
}

#ekotbpwsjs .gt_super {
  font-size: 65%;
}

#ekotbpwsjs .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ekotbpwsjs .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ekotbpwsjs .gt_indent_1 {
  text-indent: 5px;
}

#ekotbpwsjs .gt_indent_2 {
  text-indent: 10px;
}

#ekotbpwsjs .gt_indent_3 {
  text-indent: 15px;
}

#ekotbpwsjs .gt_indent_4 {
  text-indent: 20px;
}

#ekotbpwsjs .gt_indent_5 {
  text-indent: 25px;
}

#ekotbpwsjs .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ekotbpwsjs div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**traitement**">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>traitement</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">45 (5 ; 10%)</td>
<td headers="stat_1" class="gt_row gt_center">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_center">19 (2 ; 4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (9.5)</td>
<td headers="stat_1" class="gt_row gt_center">51.0 (9.6)</td>
<td headers="stat_2" class="gt_row gt_center">50.2 (9.5)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (44.4 ; 57.0)</td>
<td headers="stat_1" class="gt_row gt_center">51.3 (44.4 ; 57.0)</td>
<td headers="stat_2" class="gt_row gt_center">49.4 (43.1 ; 58.8)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_1" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_2" class="gt_row gt_center">33.1 ; 67.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">13 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_center">15 (71.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_0" class="gt_row gt_center">22 (44.0%)</td>
<td headers="stat_1" class="gt_row gt_center">16 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_0" class="gt_row gt_center">7 (14.0%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">18 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_center">10 (47.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_0" class="gt_row gt_center">15 (30.0%)</td>
<td headers="stat_1" class="gt_row gt_center">9 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">13 (26.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">7 (33.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">11 (22.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_center">5 (10.0%)</td>
<td headers="stat_1" class="gt_row gt_center">4 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (4.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_0" class="gt_row gt_center">3 (6.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_0" class="gt_row gt_center">12 (24.0%)</td>
<td headers="stat_1" class="gt_row gt_center">7 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_0" class="gt_row gt_center">6 (12.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (14.3%)</td></tr>
  </tbody>
  
  
</table>
</div>
```


## Overall Description

In this example, we generate a global description of the variables.


``` r
data %>% Descusmr::desc_var(table_title = "test")
```


```{=html}
<div id="hztnymghcv" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#hztnymghcv table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#hztnymghcv thead, #hztnymghcv tbody, #hztnymghcv tfoot, #hztnymghcv tr, #hztnymghcv td, #hztnymghcv th {
  border-style: none;
}

#hztnymghcv p {
  margin: 0;
  padding: 0;
}

#hztnymghcv .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#hztnymghcv .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#hztnymghcv .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#hztnymghcv .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#hztnymghcv .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#hztnymghcv .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hztnymghcv .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#hztnymghcv .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#hztnymghcv .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#hztnymghcv .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#hztnymghcv .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#hztnymghcv .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#hztnymghcv .gt_spanner_row {
  border-bottom-style: hidden;
}

#hztnymghcv .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#hztnymghcv .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#hztnymghcv .gt_from_md > :first-child {
  margin-top: 0;
}

#hztnymghcv .gt_from_md > :last-child {
  margin-bottom: 0;
}

#hztnymghcv .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#hztnymghcv .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#hztnymghcv .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#hztnymghcv .gt_row_group_first td {
  border-top-width: 2px;
}

#hztnymghcv .gt_row_group_first th {
  border-top-width: 2px;
}

#hztnymghcv .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hztnymghcv .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#hztnymghcv .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#hztnymghcv .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hztnymghcv .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hztnymghcv .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#hztnymghcv .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#hztnymghcv .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#hztnymghcv .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hztnymghcv .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#hztnymghcv .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#hztnymghcv .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#hztnymghcv .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#hztnymghcv .gt_left {
  text-align: left;
}

#hztnymghcv .gt_center {
  text-align: center;
}

#hztnymghcv .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#hztnymghcv .gt_font_normal {
  font-weight: normal;
}

#hztnymghcv .gt_font_bold {
  font-weight: bold;
}

#hztnymghcv .gt_font_italic {
  font-style: italic;
}

#hztnymghcv .gt_super {
  font-size: 65%;
}

#hztnymghcv .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#hztnymghcv .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#hztnymghcv .gt_indent_1 {
  text-indent: 5px;
}

#hztnymghcv .gt_indent_2 {
  text-indent: 10px;
}

#hztnymghcv .gt_indent_3 {
  text-indent: 15px;
}

#hztnymghcv .gt_indent_4 {
  text-indent: 20px;
}

#hztnymghcv .gt_indent_5 {
  text-indent: 25px;
}

#hztnymghcv .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#hztnymghcv div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">45 (5 ; 10%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (9.5)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (44.4 ; 57.0)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">30.3 ; 71.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_0" class="gt_row gt_center">22 (44.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_0" class="gt_row gt_center">7 (14.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_0" class="gt_row gt_center">15 (30.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">traitement n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BRAS-A</td>
<td headers="stat_0" class="gt_row gt_center">29 (58.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    BRAS-B</td>
<td headers="stat_0" class="gt_row gt_center">21 (42.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">13 (26.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">11 (22.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_center">5 (10.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_0" class="gt_row gt_center">3 (6.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_0" class="gt_row gt_center">12 (24.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_0" class="gt_row gt_center">6 (12.0%)</td></tr>
  </tbody>
  
  
</table>
</div>
```


# Intermediate titles

To insert intermediate titles, you can use the `intermediate_header` function which takes a list of sub-tables generated by `desc_var` and a vector of titles.


``` r
tb1 <- data %>%
  dplyr::select(Age, sexe) %>%
  Descusmr::desc_var(table_title = "test")

tb2 <- data %>%
  dplyr::select(quatre_modalites) %>%
  Descusmr::desc_var(table_title = "test")

Descusmr::intermediate_header(tbls = list(tb1, tb2),
                              group_header = c("Title A", "Title B"))
```


```{=html}
<div id="wzdmhodmcg" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#wzdmhodmcg table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#wzdmhodmcg thead, #wzdmhodmcg tbody, #wzdmhodmcg tfoot, #wzdmhodmcg tr, #wzdmhodmcg td, #wzdmhodmcg th {
  border-style: none;
}

#wzdmhodmcg p {
  margin: 0;
  padding: 0;
}

#wzdmhodmcg .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#wzdmhodmcg .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#wzdmhodmcg .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#wzdmhodmcg .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#wzdmhodmcg .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#wzdmhodmcg .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wzdmhodmcg .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#wzdmhodmcg .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#wzdmhodmcg .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#wzdmhodmcg .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#wzdmhodmcg .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#wzdmhodmcg .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#wzdmhodmcg .gt_spanner_row {
  border-bottom-style: hidden;
}

#wzdmhodmcg .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#wzdmhodmcg .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#wzdmhodmcg .gt_from_md > :first-child {
  margin-top: 0;
}

#wzdmhodmcg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#wzdmhodmcg .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#wzdmhodmcg .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#wzdmhodmcg .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#wzdmhodmcg .gt_row_group_first td {
  border-top-width: 2px;
}

#wzdmhodmcg .gt_row_group_first th {
  border-top-width: 2px;
}

#wzdmhodmcg .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#wzdmhodmcg .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#wzdmhodmcg .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#wzdmhodmcg .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wzdmhodmcg .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#wzdmhodmcg .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#wzdmhodmcg .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#wzdmhodmcg .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#wzdmhodmcg .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wzdmhodmcg .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#wzdmhodmcg .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#wzdmhodmcg .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#wzdmhodmcg .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#wzdmhodmcg .gt_left {
  text-align: left;
}

#wzdmhodmcg .gt_center {
  text-align: center;
}

#wzdmhodmcg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#wzdmhodmcg .gt_font_normal {
  font-weight: normal;
}

#wzdmhodmcg .gt_font_bold {
  font-weight: bold;
}

#wzdmhodmcg .gt_font_italic {
  font-style: italic;
}

#wzdmhodmcg .gt_super {
  font-size: 65%;
}

#wzdmhodmcg .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#wzdmhodmcg .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#wzdmhodmcg .gt_indent_1 {
  text-indent: 5px;
}

#wzdmhodmcg .gt_indent_2 {
  text-indent: 10px;
}

#wzdmhodmcg .gt_indent_3 {
  text-indent: 15px;
}

#wzdmhodmcg .gt_indent_4 {
  text-indent: 20px;
}

#wzdmhodmcg .gt_indent_5 {
  text-indent: 25px;
}

#wzdmhodmcg .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#wzdmhodmcg div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr class="gt_group_heading_row">
      <th colspan="2" class="gt_group_heading" style="font-size: 16; text-align: center; font-weight: bold; background-color: #8ECAE6;" scope="colgroup" id="Title A">Title A</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Title A  label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="Title A  stat_0" class="gt_row gt_center">45 (5 ; 10%)</td></tr>
    <tr><td headers="Title A  label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="Title A  stat_0" class="gt_row gt_center">50.7 (9.5)</td></tr>
    <tr><td headers="Title A  label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="Title A  stat_0" class="gt_row gt_center">50.7 (44.4 ; 57.0)</td></tr>
    <tr><td headers="Title A  label" class="gt_row gt_left">    Min ; Max</td>
<td headers="Title A  stat_0" class="gt_row gt_center">30.3 ; 71.7</td></tr>
    <tr><td headers="Title A  label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="Title A  stat_0" class="gt_row gt_center">50 (0 ; 0%)</td></tr>
    <tr><td headers="Title A  label" class="gt_row gt_left">    Femme</td>
<td headers="Title A  stat_0" class="gt_row gt_center">28 (56.0%)</td></tr>
    <tr><td headers="Title A  label" class="gt_row gt_left">    Homme</td>
<td headers="Title A  stat_0" class="gt_row gt_center">22 (44.0%)</td></tr>
    <tr class="gt_group_heading_row">
      <th colspan="2" class="gt_group_heading" style="font-size: 16; text-align: center; font-weight: bold; background-color: #8ECAE6;" scope="colgroup" id="Title B">Title B</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Title B  label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux</td>
<td headers="Title B  stat_0" class="gt_row gt_center">50</td></tr>
    <tr><td headers="Title B  label" class="gt_row gt_left">    A</td>
<td headers="Title B  stat_0" class="gt_row gt_center">7 (14.0%)</td></tr>
    <tr><td headers="Title B  label" class="gt_row gt_left">    B</td>
<td headers="Title B  stat_0" class="gt_row gt_center">28 (56.0%)</td></tr>
    <tr><td headers="Title B  label" class="gt_row gt_left">    C</td>
<td headers="Title B  stat_0" class="gt_row gt_center">15 (30.0%)</td></tr>
  </tbody>
  
  
</table>
</div>
```


# Number of Digits in Quantitative and Qualitative Features

You can specify the number of digits for quantitative and qualitative features using the `round_quanti` and `round_quali` arguments, respectively.

## Specify Number of Digits

In the example below, quantitative values are rounded to 0 decimal places, while qualitative values are rounded to 1 decimal place.


``` r
data %>%
  Descusmr::desc_var(table_title = "test",
                     var_group = "traitement",
                     round_quanti = 0,
                     round_quali = 1)
```


```{=html}
<div id="iwgmtnpgdm" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#iwgmtnpgdm table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#iwgmtnpgdm thead, #iwgmtnpgdm tbody, #iwgmtnpgdm tfoot, #iwgmtnpgdm tr, #iwgmtnpgdm td, #iwgmtnpgdm th {
  border-style: none;
}

#iwgmtnpgdm p {
  margin: 0;
  padding: 0;
}

#iwgmtnpgdm .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#iwgmtnpgdm .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#iwgmtnpgdm .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#iwgmtnpgdm .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#iwgmtnpgdm .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#iwgmtnpgdm .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#iwgmtnpgdm .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#iwgmtnpgdm .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#iwgmtnpgdm .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#iwgmtnpgdm .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#iwgmtnpgdm .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#iwgmtnpgdm .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#iwgmtnpgdm .gt_spanner_row {
  border-bottom-style: hidden;
}

#iwgmtnpgdm .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#iwgmtnpgdm .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#iwgmtnpgdm .gt_from_md > :first-child {
  margin-top: 0;
}

#iwgmtnpgdm .gt_from_md > :last-child {
  margin-bottom: 0;
}

#iwgmtnpgdm .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#iwgmtnpgdm .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#iwgmtnpgdm .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#iwgmtnpgdm .gt_row_group_first td {
  border-top-width: 2px;
}

#iwgmtnpgdm .gt_row_group_first th {
  border-top-width: 2px;
}

#iwgmtnpgdm .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#iwgmtnpgdm .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#iwgmtnpgdm .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#iwgmtnpgdm .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#iwgmtnpgdm .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#iwgmtnpgdm .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#iwgmtnpgdm .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#iwgmtnpgdm .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#iwgmtnpgdm .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#iwgmtnpgdm .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#iwgmtnpgdm .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#iwgmtnpgdm .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#iwgmtnpgdm .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#iwgmtnpgdm .gt_left {
  text-align: left;
}

#iwgmtnpgdm .gt_center {
  text-align: center;
}

#iwgmtnpgdm .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#iwgmtnpgdm .gt_font_normal {
  font-weight: normal;
}

#iwgmtnpgdm .gt_font_bold {
  font-weight: bold;
}

#iwgmtnpgdm .gt_font_italic {
  font-style: italic;
}

#iwgmtnpgdm .gt_super {
  font-size: 65%;
}

#iwgmtnpgdm .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#iwgmtnpgdm .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#iwgmtnpgdm .gt_indent_1 {
  text-indent: 5px;
}

#iwgmtnpgdm .gt_indent_2 {
  text-indent: 10px;
}

#iwgmtnpgdm .gt_indent_3 {
  text-indent: 15px;
}

#iwgmtnpgdm .gt_indent_4 {
  text-indent: 20px;
}

#iwgmtnpgdm .gt_indent_5 {
  text-indent: 25px;
}

#iwgmtnpgdm .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#iwgmtnpgdm div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**traitement**">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>traitement</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">45 (5 ; 10%)</td>
<td headers="stat_1" class="gt_row gt_center">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_center">19 (2 ; 4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">51 (9)</td>
<td headers="stat_1" class="gt_row gt_center">51 (10)</td>
<td headers="stat_2" class="gt_row gt_center">50 (10)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">51 (44 ; 57)</td>
<td headers="stat_1" class="gt_row gt_center">51 (44 ; 57)</td>
<td headers="stat_2" class="gt_row gt_center">49 (43 ; 59)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">30 ; 72</td>
<td headers="stat_1" class="gt_row gt_center">30 ; 72</td>
<td headers="stat_2" class="gt_row gt_center">33 ; 68</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_0" class="gt_row gt_center">28.0 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">13.0 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_center">15.0 (71.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_0" class="gt_row gt_center">22.0 (44.0%)</td>
<td headers="stat_1" class="gt_row gt_center">16.0 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_center">6.0 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_0" class="gt_row gt_center">7.0 (14.0%)</td>
<td headers="stat_1" class="gt_row gt_center">2.0 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_center">5.0 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_0" class="gt_row gt_center">28.0 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">18.0 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_center">10.0 (47.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_0" class="gt_row gt_center">15.0 (30.0%)</td>
<td headers="stat_1" class="gt_row gt_center">9.0 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_center">6.0 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">13.0 (26.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6.0 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">7.0 (33.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">11.0 (22.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6.0 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">5.0 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_center">5.0 (10.0%)</td>
<td headers="stat_1" class="gt_row gt_center">4.0 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_center">1.0 (4.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_0" class="gt_row gt_center">3.0 (6.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3.0 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">0.0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_0" class="gt_row gt_center">12.0 (24.0%)</td>
<td headers="stat_1" class="gt_row gt_center">7.0 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_center">5.0 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_0" class="gt_row gt_center">6.0 (12.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3.0 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">3.0 (14.3%)</td></tr>
  </tbody>
  
  
</table>
</div>
```


## Combine Subtables with Different Rounding

To have more control over rounding, you can create subtables with different numbers of digits and combine them into a single table using `gtsummary::tbl_stack`.


``` r
tb1 <- data %>%
  dplyr::select(Age, sexe, traitement) %>%
  Descusmr::desc_var(table_title = "test",
                     var_group = "traitement",
                     round_quanti = 0,
                     round_quali = 0)

tb2 <- data %>%
  dplyr::select(quatre_modalites, traitement) %>%
  Descusmr::desc_var(table_title = "test",
                     var_group = "traitement",
                     round_quanti = 2,
                     round_quali = 2)

gtsummary::tbl_stack(list(tb1, tb2))
```


```{=html}
<div id="iatnsebatd" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#iatnsebatd table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#iatnsebatd thead, #iatnsebatd tbody, #iatnsebatd tfoot, #iatnsebatd tr, #iatnsebatd td, #iatnsebatd th {
  border-style: none;
}

#iatnsebatd p {
  margin: 0;
  padding: 0;
}

#iatnsebatd .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#iatnsebatd .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#iatnsebatd .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#iatnsebatd .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#iatnsebatd .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#iatnsebatd .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#iatnsebatd .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#iatnsebatd .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#iatnsebatd .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#iatnsebatd .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#iatnsebatd .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#iatnsebatd .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#iatnsebatd .gt_spanner_row {
  border-bottom-style: hidden;
}

#iatnsebatd .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#iatnsebatd .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#iatnsebatd .gt_from_md > :first-child {
  margin-top: 0;
}

#iatnsebatd .gt_from_md > :last-child {
  margin-bottom: 0;
}

#iatnsebatd .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#iatnsebatd .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#iatnsebatd .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#iatnsebatd .gt_row_group_first td {
  border-top-width: 2px;
}

#iatnsebatd .gt_row_group_first th {
  border-top-width: 2px;
}

#iatnsebatd .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#iatnsebatd .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#iatnsebatd .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#iatnsebatd .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#iatnsebatd .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#iatnsebatd .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#iatnsebatd .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#iatnsebatd .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#iatnsebatd .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#iatnsebatd .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#iatnsebatd .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#iatnsebatd .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#iatnsebatd .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#iatnsebatd .gt_left {
  text-align: left;
}

#iatnsebatd .gt_center {
  text-align: center;
}

#iatnsebatd .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#iatnsebatd .gt_font_normal {
  font-weight: normal;
}

#iatnsebatd .gt_font_bold {
  font-weight: bold;
}

#iatnsebatd .gt_font_italic {
  font-style: italic;
}

#iatnsebatd .gt_super {
  font-size: 65%;
}

#iatnsebatd .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#iatnsebatd .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#iatnsebatd .gt_indent_1 {
  text-indent: 5px;
}

#iatnsebatd .gt_indent_2 {
  text-indent: 10px;
}

#iatnsebatd .gt_indent_3 {
  text-indent: 15px;
}

#iatnsebatd .gt_indent_4 {
  text-indent: 20px;
}

#iatnsebatd .gt_indent_5 {
  text-indent: 25px;
}

#iatnsebatd .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#iatnsebatd div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**traitement**">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>traitement</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">45 (5 ; 10%)</td>
<td headers="stat_1" class="gt_row gt_center">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_center">19 (2 ; 4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">51 (9)</td>
<td headers="stat_1" class="gt_row gt_center">51 (10)</td>
<td headers="stat_2" class="gt_row gt_center">50 (10)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">51 (44 ; 57)</td>
<td headers="stat_1" class="gt_row gt_center">51 (44 ; 57)</td>
<td headers="stat_2" class="gt_row gt_center">49 (43 ; 59)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">30 ; 72</td>
<td headers="stat_1" class="gt_row gt_center">30 ; 72</td>
<td headers="stat_2" class="gt_row gt_center">33 ; 68</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_0" class="gt_row gt_center">28 (56%)</td>
<td headers="stat_1" class="gt_row gt_center">13 (45%)</td>
<td headers="stat_2" class="gt_row gt_center">15 (71%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_0" class="gt_row gt_center">22 (44%)</td>
<td headers="stat_1" class="gt_row gt_center">16 (55%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (29%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux</td>
<td headers="stat_0" class="gt_row gt_center">50</td>
<td headers="stat_1" class="gt_row gt_center">29</td>
<td headers="stat_2" class="gt_row gt_center">21</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_0" class="gt_row gt_center">7.00 (14.00%)</td>
<td headers="stat_1" class="gt_row gt_center">2.00 (6.90%)</td>
<td headers="stat_2" class="gt_row gt_center">5.00 (23.81%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_0" class="gt_row gt_center">28.00 (56.00%)</td>
<td headers="stat_1" class="gt_row gt_center">18.00 (62.07%)</td>
<td headers="stat_2" class="gt_row gt_center">10.00 (47.62%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_0" class="gt_row gt_center">15.00 (30.00%)</td>
<td headers="stat_1" class="gt_row gt_center">9.00 (31.03%)</td>
<td headers="stat_2" class="gt_row gt_center">6.00 (28.57%)</td></tr>
  </tbody>
  
  
</table>
</div>
```


# Statistical tests

## Add Default Statistical Tests

You can include statistical tests in your summary table using the `tests = TRUE` argument. This automatically applies default statistical tests for the grouped variables.

The following example adds statistical tests for all features, grouped by the `traitement` variable.


``` r
data %>%
  Descusmr::desc_var(table_title = "test",
                     var_group = "traitement",
                     tests = TRUE)
```


```{=html}
<div id="ydcgdxhuex" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ydcgdxhuex table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ydcgdxhuex thead, #ydcgdxhuex tbody, #ydcgdxhuex tfoot, #ydcgdxhuex tr, #ydcgdxhuex td, #ydcgdxhuex th {
  border-style: none;
}

#ydcgdxhuex p {
  margin: 0;
  padding: 0;
}

#ydcgdxhuex .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#ydcgdxhuex .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ydcgdxhuex .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ydcgdxhuex .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ydcgdxhuex .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ydcgdxhuex .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ydcgdxhuex .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ydcgdxhuex .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#ydcgdxhuex .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#ydcgdxhuex .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ydcgdxhuex .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ydcgdxhuex .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#ydcgdxhuex .gt_spanner_row {
  border-bottom-style: hidden;
}

#ydcgdxhuex .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#ydcgdxhuex .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#ydcgdxhuex .gt_from_md > :first-child {
  margin-top: 0;
}

#ydcgdxhuex .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ydcgdxhuex .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#ydcgdxhuex .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#ydcgdxhuex .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#ydcgdxhuex .gt_row_group_first td {
  border-top-width: 2px;
}

#ydcgdxhuex .gt_row_group_first th {
  border-top-width: 2px;
}

#ydcgdxhuex .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ydcgdxhuex .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ydcgdxhuex .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ydcgdxhuex .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ydcgdxhuex .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ydcgdxhuex .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ydcgdxhuex .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ydcgdxhuex .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ydcgdxhuex .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ydcgdxhuex .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#ydcgdxhuex .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ydcgdxhuex .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#ydcgdxhuex .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ydcgdxhuex .gt_left {
  text-align: left;
}

#ydcgdxhuex .gt_center {
  text-align: center;
}

#ydcgdxhuex .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ydcgdxhuex .gt_font_normal {
  font-weight: normal;
}

#ydcgdxhuex .gt_font_bold {
  font-weight: bold;
}

#ydcgdxhuex .gt_font_italic {
  font-style: italic;
}

#ydcgdxhuex .gt_super {
  font-size: 65%;
}

#ydcgdxhuex .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ydcgdxhuex .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ydcgdxhuex .gt_indent_1 {
  text-indent: 5px;
}

#ydcgdxhuex .gt_indent_2 {
  text-indent: 10px;
}

#ydcgdxhuex .gt_indent_3 {
  text-indent: 15px;
}

#ydcgdxhuex .gt_indent_4 {
  text-indent: 20px;
}

#ydcgdxhuex .gt_indent_5 {
  text-indent: 25px;
}

#ydcgdxhuex .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ydcgdxhuex div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**traitement**">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>traitement</strong></span></div>
      </th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="p.value"><span class='gt_from_md'><strong>p-value</strong></span></th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">45 (5 ; 10%)</td>
<td headers="stat_1" class="gt_row gt_center">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_center">19 (2 ; 4%)</td>
<td headers="p.value" class="gt_row gt_center">0.7<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (9.5)</td>
<td headers="stat_1" class="gt_row gt_center">51.0 (9.6)</td>
<td headers="stat_2" class="gt_row gt_center">50.2 (9.5)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (44.4 ; 57.0)</td>
<td headers="stat_1" class="gt_row gt_center">51.3 (44.4 ; 57.0)</td>
<td headers="stat_2" class="gt_row gt_center">49.4 (43.1 ; 58.8)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_1" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_2" class="gt_row gt_center">33.1 ; 67.9</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center">0.061<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">13 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_center">15 (71.4%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_0" class="gt_row gt_center">22 (44.0%)</td>
<td headers="stat_1" class="gt_row gt_center">16 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center">0.3<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_0" class="gt_row gt_center">7 (14.0%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">18 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_center">10 (47.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_0" class="gt_row gt_center">15 (30.0%)</td>
<td headers="stat_1" class="gt_row gt_center">9 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center">0.6<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">13 (26.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">7 (33.3%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">11 (22.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_center">5 (10.0%)</td>
<td headers="stat_1" class="gt_row gt_center">4 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (4.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_0" class="gt_row gt_center">3 (6.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_0" class="gt_row gt_center">12 (24.0%)</td>
<td headers="stat_1" class="gt_row gt_center">7 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_0" class="gt_row gt_center">6 (12.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (14.3%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Wilcoxon rank sum exact test</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span> <span class='gt_from_md'>Pearson’s Chi-squared test</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span> <span class='gt_from_md'>Fisher’s exact test</span></td>
    </tr>
  </tfoot>
</table>
</div>
```


## Specify Statistical Tests for Each Feature

For greater control, you can specify the test to use for each feature by passing a named list to the tests argument. The example below applies:

- t-test for Age,
- Chi-squared test for sexe, and
- Fisher's exact test for echelle.


``` r
data %>%
  Descusmr::desc_var(table_title = "test",
                     var_group = "traitement",
                     tests = list(Age = "t.test",
                                  sexe = "chisq.test",
                                  echelle = "fisher.test"))
```


```{=html}
<div id="cbzhmhbfwq" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#cbzhmhbfwq table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#cbzhmhbfwq thead, #cbzhmhbfwq tbody, #cbzhmhbfwq tfoot, #cbzhmhbfwq tr, #cbzhmhbfwq td, #cbzhmhbfwq th {
  border-style: none;
}

#cbzhmhbfwq p {
  margin: 0;
  padding: 0;
}

#cbzhmhbfwq .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#cbzhmhbfwq .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#cbzhmhbfwq .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#cbzhmhbfwq .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#cbzhmhbfwq .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#cbzhmhbfwq .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cbzhmhbfwq .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#cbzhmhbfwq .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#cbzhmhbfwq .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#cbzhmhbfwq .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#cbzhmhbfwq .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#cbzhmhbfwq .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#cbzhmhbfwq .gt_spanner_row {
  border-bottom-style: hidden;
}

#cbzhmhbfwq .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#cbzhmhbfwq .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#cbzhmhbfwq .gt_from_md > :first-child {
  margin-top: 0;
}

#cbzhmhbfwq .gt_from_md > :last-child {
  margin-bottom: 0;
}

#cbzhmhbfwq .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#cbzhmhbfwq .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#cbzhmhbfwq .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#cbzhmhbfwq .gt_row_group_first td {
  border-top-width: 2px;
}

#cbzhmhbfwq .gt_row_group_first th {
  border-top-width: 2px;
}

#cbzhmhbfwq .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cbzhmhbfwq .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#cbzhmhbfwq .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#cbzhmhbfwq .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cbzhmhbfwq .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cbzhmhbfwq .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#cbzhmhbfwq .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#cbzhmhbfwq .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#cbzhmhbfwq .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cbzhmhbfwq .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#cbzhmhbfwq .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cbzhmhbfwq .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#cbzhmhbfwq .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cbzhmhbfwq .gt_left {
  text-align: left;
}

#cbzhmhbfwq .gt_center {
  text-align: center;
}

#cbzhmhbfwq .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#cbzhmhbfwq .gt_font_normal {
  font-weight: normal;
}

#cbzhmhbfwq .gt_font_bold {
  font-weight: bold;
}

#cbzhmhbfwq .gt_font_italic {
  font-style: italic;
}

#cbzhmhbfwq .gt_super {
  font-size: 65%;
}

#cbzhmhbfwq .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#cbzhmhbfwq .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#cbzhmhbfwq .gt_indent_1 {
  text-indent: 5px;
}

#cbzhmhbfwq .gt_indent_2 {
  text-indent: 10px;
}

#cbzhmhbfwq .gt_indent_3 {
  text-indent: 15px;
}

#cbzhmhbfwq .gt_indent_4 {
  text-indent: 20px;
}

#cbzhmhbfwq .gt_indent_5 {
  text-indent: 25px;
}

#cbzhmhbfwq .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#cbzhmhbfwq div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**traitement**">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>traitement</strong></span></div>
      </th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="p.value"><span class='gt_from_md'><strong>p-value</strong></span></th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">45 (5 ; 10%)</td>
<td headers="stat_1" class="gt_row gt_center">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_center">19 (2 ; 4%)</td>
<td headers="p.value" class="gt_row gt_center">0.8<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (9.5)</td>
<td headers="stat_1" class="gt_row gt_center">51.0 (9.6)</td>
<td headers="stat_2" class="gt_row gt_center">50.2 (9.5)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">50.7 (44.4 ; 57.0)</td>
<td headers="stat_1" class="gt_row gt_center">51.3 (44.4 ; 57.0)</td>
<td headers="stat_2" class="gt_row gt_center">49.4 (43.1 ; 58.8)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_1" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_2" class="gt_row gt_center">33.1 ; 67.9</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center">0.11<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">13 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_center">15 (71.4%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_0" class="gt_row gt_center">22 (44.0%)</td>
<td headers="stat_1" class="gt_row gt_center">16 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center">0.3<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_0" class="gt_row gt_center">7 (14.0%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_0" class="gt_row gt_center">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_center">18 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_center">10 (47.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_0" class="gt_row gt_center">15 (30.0%)</td>
<td headers="stat_1" class="gt_row gt_center">9 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_center">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center">0.6<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">13 (26.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">7 (33.3%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">11 (22.0%)</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_center">5 (10.0%)</td>
<td headers="stat_1" class="gt_row gt_center">4 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (4.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_0" class="gt_row gt_center">3 (6.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_0" class="gt_row gt_center">12 (24.0%)</td>
<td headers="stat_1" class="gt_row gt_center">7 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_0" class="gt_row gt_center">6 (12.0%)</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (14.3%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Welch Two Sample t-test</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span> <span class='gt_from_md'>Pearson’s Chi-squared test</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span> <span class='gt_from_md'>Fisher’s exact test</span></td>
    </tr>
  </tfoot>
</table>
</div>
```


# Custom appearance

To have a nicer appearance of the table, it is possible to customize it as a `gt` table. A dedicated function is implemented: `custom_format`.


``` r
data %>%
  Descusmr::desc_var(table_title = "test",
                     var_group = "traitement",
                     tests = list(Age = "t.test",
                                  sexe = "chisq.test",
                                  echelle = "fisher.test")) %>%
  custom_format()
```


```{=html}
<div id="brrchnioqg" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#brrchnioqg table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#brrchnioqg thead, #brrchnioqg tbody, #brrchnioqg tfoot, #brrchnioqg tr, #brrchnioqg td, #brrchnioqg th {
  border-style: none;
}

#brrchnioqg p {
  margin: 0;
  padding: 0;
}

#brrchnioqg .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#brrchnioqg .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#brrchnioqg .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#brrchnioqg .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#brrchnioqg .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#brrchnioqg .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#brrchnioqg .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#brrchnioqg .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#brrchnioqg .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#brrchnioqg .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#brrchnioqg .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#brrchnioqg .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#brrchnioqg .gt_spanner_row {
  border-bottom-style: hidden;
}

#brrchnioqg .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#brrchnioqg .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#brrchnioqg .gt_from_md > :first-child {
  margin-top: 0;
}

#brrchnioqg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#brrchnioqg .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#brrchnioqg .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#brrchnioqg .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#brrchnioqg .gt_row_group_first td {
  border-top-width: 2px;
}

#brrchnioqg .gt_row_group_first th {
  border-top-width: 2px;
}

#brrchnioqg .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#brrchnioqg .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#brrchnioqg .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#brrchnioqg .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#brrchnioqg .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#brrchnioqg .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#brrchnioqg .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#brrchnioqg .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#brrchnioqg .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#brrchnioqg .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#brrchnioqg .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#brrchnioqg .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#brrchnioqg .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#brrchnioqg .gt_left {
  text-align: left;
}

#brrchnioqg .gt_center {
  text-align: center;
}

#brrchnioqg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#brrchnioqg .gt_font_normal {
  font-weight: normal;
}

#brrchnioqg .gt_font_bold {
  font-weight: bold;
}

#brrchnioqg .gt_font_italic {
  font-style: italic;
}

#brrchnioqg .gt_super {
  font-size: 65%;
}

#brrchnioqg .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#brrchnioqg .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#brrchnioqg .gt_indent_1 {
  text-indent: 5px;
}

#brrchnioqg .gt_indent_2 {
  text-indent: 10px;
}

#brrchnioqg .gt_indent_3 {
  text-indent: 15px;
}

#brrchnioqg .gt_indent_4 {
  text-indent: 20px;
}

#brrchnioqg .gt_indent_5 {
  text-indent: 25px;
}

#brrchnioqg .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#brrchnioqg div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**traitement**">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>traitement</strong></span></div>
      </th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="p.value"><span class='gt_from_md'><strong>p-value</strong></span></th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_right" style="font-weight: bold;">45 (5 ; 10%)</td>
<td headers="stat_1" class="gt_row gt_right" style="font-weight: bold;">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_right" style="font-weight: bold;">19 (2 ; 4%)</td>
<td headers="p.value" class="gt_row gt_center" style="font-weight: bold;">0.8<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_right">50.7 (9.5)</td>
<td headers="stat_1" class="gt_row gt_right">51.0 (9.6)</td>
<td headers="stat_2" class="gt_row gt_right">50.2 (9.5)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_right">50.7 (44.4 ; 57.0)</td>
<td headers="stat_1" class="gt_row gt_right">51.3 (44.4 ; 57.0)</td>
<td headers="stat_2" class="gt_row gt_right">49.4 (43.1 ; 58.8)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_right">30.3 ; 71.7</td>
<td headers="stat_1" class="gt_row gt_right">30.3 ; 71.7</td>
<td headers="stat_2" class="gt_row gt_right">33.1 ; 67.9</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_right" style="font-weight: bold;">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_right" style="font-weight: bold;">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_right" style="font-weight: bold;">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center" style="font-weight: bold;">0.11<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_0" class="gt_row gt_right">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_right">13 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_right">15 (71.4%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_0" class="gt_row gt_right">22 (44.0%)</td>
<td headers="stat_1" class="gt_row gt_right">16 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_right">6 (28.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_right" style="font-weight: bold;">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_right" style="font-weight: bold;">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_right" style="font-weight: bold;">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center" style="font-weight: bold;">0.3<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_0" class="gt_row gt_right">7 (14.0%)</td>
<td headers="stat_1" class="gt_row gt_right">2 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_right">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_0" class="gt_row gt_right">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_right">18 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_right">10 (47.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_0" class="gt_row gt_right">15 (30.0%)</td>
<td headers="stat_1" class="gt_row gt_right">9 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_right">6 (28.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_right" style="font-weight: bold;">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_right" style="font-weight: bold;">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_right" style="font-weight: bold;">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center" style="font-weight: bold;">0.6<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_right">13 (26.0%)</td>
<td headers="stat_1" class="gt_row gt_right">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_right">7 (33.3%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_right">11 (22.0%)</td>
<td headers="stat_1" class="gt_row gt_right">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_right">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_right">5 (10.0%)</td>
<td headers="stat_1" class="gt_row gt_right">4 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_right">1 (4.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_0" class="gt_row gt_right">3 (6.0%)</td>
<td headers="stat_1" class="gt_row gt_right">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_right">0 (0.0%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_0" class="gt_row gt_right">12 (24.0%)</td>
<td headers="stat_1" class="gt_row gt_right">7 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_right">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_0" class="gt_row gt_right">6 (12.0%)</td>
<td headers="stat_1" class="gt_row gt_right">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_right">3 (14.3%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Welch Two Sample t-test</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span> <span class='gt_from_md'>Pearson’s Chi-squared test</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span> <span class='gt_from_md'>Fisher’s exact test</span></td>
    </tr>
  </tfoot>
</table>
</div>
```


This also works when using stacked tables.


``` r
tb1 <- data %>%
  dplyr::select(Age, sexe, traitement) %>%
  Descusmr::desc_var(table_title = "test",
                     var_group = "traitement",
                     round_quanti = 0,
                     round_quali = 0)

tb2 <- data %>%
  dplyr::select(quatre_modalites, traitement) %>%
  Descusmr::desc_var(table_title = "test",
                     var_group = "traitement",
                     round_quanti = 2,
                     round_quali = 2)

gtsummary::tbl_stack(list(tb1, tb2)) %>%
  custom_format()
```


```{=html}
<div id="htxjvrqice" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#htxjvrqice table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#htxjvrqice thead, #htxjvrqice tbody, #htxjvrqice tfoot, #htxjvrqice tr, #htxjvrqice td, #htxjvrqice th {
  border-style: none;
}

#htxjvrqice p {
  margin: 0;
  padding: 0;
}

#htxjvrqice .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#htxjvrqice .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#htxjvrqice .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#htxjvrqice .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#htxjvrqice .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#htxjvrqice .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#htxjvrqice .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#htxjvrqice .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#htxjvrqice .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#htxjvrqice .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#htxjvrqice .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#htxjvrqice .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#htxjvrqice .gt_spanner_row {
  border-bottom-style: hidden;
}

#htxjvrqice .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#htxjvrqice .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#htxjvrqice .gt_from_md > :first-child {
  margin-top: 0;
}

#htxjvrqice .gt_from_md > :last-child {
  margin-bottom: 0;
}

#htxjvrqice .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#htxjvrqice .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#htxjvrqice .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#htxjvrqice .gt_row_group_first td {
  border-top-width: 2px;
}

#htxjvrqice .gt_row_group_first th {
  border-top-width: 2px;
}

#htxjvrqice .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#htxjvrqice .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#htxjvrqice .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#htxjvrqice .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#htxjvrqice .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#htxjvrqice .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#htxjvrqice .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#htxjvrqice .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#htxjvrqice .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#htxjvrqice .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#htxjvrqice .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#htxjvrqice .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#htxjvrqice .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#htxjvrqice .gt_left {
  text-align: left;
}

#htxjvrqice .gt_center {
  text-align: center;
}

#htxjvrqice .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#htxjvrqice .gt_font_normal {
  font-weight: normal;
}

#htxjvrqice .gt_font_bold {
  font-weight: bold;
}

#htxjvrqice .gt_font_italic {
  font-style: italic;
}

#htxjvrqice .gt_super {
  font-size: 65%;
}

#htxjvrqice .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#htxjvrqice .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#htxjvrqice .gt_indent_1 {
  text-indent: 5px;
}

#htxjvrqice .gt_indent_2 {
  text-indent: 10px;
}

#htxjvrqice .gt_indent_3 {
  text-indent: 15px;
}

#htxjvrqice .gt_indent_4 {
  text-indent: 20px;
}

#htxjvrqice .gt_indent_5 {
  text-indent: 25px;
}

#htxjvrqice .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#htxjvrqice div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**traitement**">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>traitement</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_right" style="font-weight: bold;">45 (5 ; 10%)</td>
<td headers="stat_1" class="gt_row gt_right" style="font-weight: bold;">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_right" style="font-weight: bold;">19 (2 ; 4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_right">51 (9)</td>
<td headers="stat_1" class="gt_row gt_right">51 (10)</td>
<td headers="stat_2" class="gt_row gt_right">50 (10)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_right">51 (44 ; 57)</td>
<td headers="stat_1" class="gt_row gt_right">51 (44 ; 57)</td>
<td headers="stat_2" class="gt_row gt_right">49 (43 ; 59)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_right">30 ; 72</td>
<td headers="stat_1" class="gt_row gt_right">30 ; 72</td>
<td headers="stat_2" class="gt_row gt_right">33 ; 68</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_right" style="font-weight: bold;">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_right" style="font-weight: bold;">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_right" style="font-weight: bold;">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_0" class="gt_row gt_right">28 (56%)</td>
<td headers="stat_1" class="gt_row gt_right">13 (45%)</td>
<td headers="stat_2" class="gt_row gt_right">15 (71%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_0" class="gt_row gt_right">22 (44%)</td>
<td headers="stat_1" class="gt_row gt_right">16 (55%)</td>
<td headers="stat_2" class="gt_row gt_right">6 (29%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux</td>
<td headers="stat_0" class="gt_row gt_right" style="font-weight: bold;">50</td>
<td headers="stat_1" class="gt_row gt_right" style="font-weight: bold;">29</td>
<td headers="stat_2" class="gt_row gt_right" style="font-weight: bold;">21</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_0" class="gt_row gt_right">7.00 (14.00%)</td>
<td headers="stat_1" class="gt_row gt_right">2.00 (6.90%)</td>
<td headers="stat_2" class="gt_row gt_right">5.00 (23.81%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_0" class="gt_row gt_right">28.00 (56.00%)</td>
<td headers="stat_1" class="gt_row gt_right">18.00 (62.07%)</td>
<td headers="stat_2" class="gt_row gt_right">10.00 (47.62%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_0" class="gt_row gt_right">15.00 (30.00%)</td>
<td headers="stat_1" class="gt_row gt_right">9.00 (31.03%)</td>
<td headers="stat_2" class="gt_row gt_right">6.00 (28.57%)</td></tr>
  </tbody>
  
  
</table>
</div>
```


You can customize the format by specifying the column size and the alignment.


``` r
data %>%
  Descusmr::desc_var(table_title = "test",
                     var_group = "traitement") %>%
  custom_format(align = "left",
                column_size = list(label ~ gt::pct(50),
                                   gt::starts_with("stat") ~ gt::pct(25)))
```


```{=html}
<div id="xmwlhfxpkw" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#xmwlhfxpkw table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#xmwlhfxpkw thead, #xmwlhfxpkw tbody, #xmwlhfxpkw tfoot, #xmwlhfxpkw tr, #xmwlhfxpkw td, #xmwlhfxpkw th {
  border-style: none;
}

#xmwlhfxpkw p {
  margin: 0;
  padding: 0;
}

#xmwlhfxpkw .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#xmwlhfxpkw .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#xmwlhfxpkw .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#xmwlhfxpkw .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#xmwlhfxpkw .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#xmwlhfxpkw .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xmwlhfxpkw .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#xmwlhfxpkw .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#xmwlhfxpkw .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#xmwlhfxpkw .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#xmwlhfxpkw .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#xmwlhfxpkw .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#xmwlhfxpkw .gt_spanner_row {
  border-bottom-style: hidden;
}

#xmwlhfxpkw .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#xmwlhfxpkw .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#xmwlhfxpkw .gt_from_md > :first-child {
  margin-top: 0;
}

#xmwlhfxpkw .gt_from_md > :last-child {
  margin-bottom: 0;
}

#xmwlhfxpkw .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#xmwlhfxpkw .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#xmwlhfxpkw .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#xmwlhfxpkw .gt_row_group_first td {
  border-top-width: 2px;
}

#xmwlhfxpkw .gt_row_group_first th {
  border-top-width: 2px;
}

#xmwlhfxpkw .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xmwlhfxpkw .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#xmwlhfxpkw .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#xmwlhfxpkw .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xmwlhfxpkw .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xmwlhfxpkw .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#xmwlhfxpkw .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#xmwlhfxpkw .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#xmwlhfxpkw .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xmwlhfxpkw .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#xmwlhfxpkw .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#xmwlhfxpkw .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#xmwlhfxpkw .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#xmwlhfxpkw .gt_left {
  text-align: left;
}

#xmwlhfxpkw .gt_center {
  text-align: center;
}

#xmwlhfxpkw .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#xmwlhfxpkw .gt_font_normal {
  font-weight: normal;
}

#xmwlhfxpkw .gt_font_bold {
  font-weight: bold;
}

#xmwlhfxpkw .gt_font_italic {
  font-style: italic;
}

#xmwlhfxpkw .gt_super {
  font-size: 65%;
}

#xmwlhfxpkw .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#xmwlhfxpkw .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#xmwlhfxpkw .gt_indent_1 {
  text-indent: 5px;
}

#xmwlhfxpkw .gt_indent_2 {
  text-indent: 10px;
}

#xmwlhfxpkw .gt_indent_3 {
  text-indent: 15px;
}

#xmwlhfxpkw .gt_indent_4 {
  text-indent: 20px;
}

#xmwlhfxpkw .gt_indent_5 {
  text-indent: 25px;
}

#xmwlhfxpkw .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#xmwlhfxpkw div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" style="table-layout:fixed;width:100%;" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <colgroup>
    <col style="width:50%;"/>
    <col style="width:25%;"/>
    <col style="width:25%;"/>
    <col style="width:25%;"/>
  </colgroup>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**traitement**">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>traitement</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_left" style="font-weight: bold;">45 (5 ; 10%)</td>
<td headers="stat_1" class="gt_row gt_left" style="font-weight: bold;">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_left" style="font-weight: bold;">19 (2 ; 4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_left">50.7 (9.5)</td>
<td headers="stat_1" class="gt_row gt_left">51.0 (9.6)</td>
<td headers="stat_2" class="gt_row gt_left">50.2 (9.5)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_left">50.7 (44.4 ; 57.0)</td>
<td headers="stat_1" class="gt_row gt_left">51.3 (44.4 ; 57.0)</td>
<td headers="stat_2" class="gt_row gt_left">49.4 (43.1 ; 58.8)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_left">30.3 ; 71.7</td>
<td headers="stat_1" class="gt_row gt_left">30.3 ; 71.7</td>
<td headers="stat_2" class="gt_row gt_left">33.1 ; 67.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_left" style="font-weight: bold;">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_left" style="font-weight: bold;">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_left" style="font-weight: bold;">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_0" class="gt_row gt_left">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_left">13 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_left">15 (71.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_0" class="gt_row gt_left">22 (44.0%)</td>
<td headers="stat_1" class="gt_row gt_left">16 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_left">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_left" style="font-weight: bold;">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_left" style="font-weight: bold;">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_left" style="font-weight: bold;">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_0" class="gt_row gt_left">7 (14.0%)</td>
<td headers="stat_1" class="gt_row gt_left">2 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_left">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_0" class="gt_row gt_left">28 (56.0%)</td>
<td headers="stat_1" class="gt_row gt_left">18 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_left">10 (47.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_0" class="gt_row gt_left">15 (30.0%)</td>
<td headers="stat_1" class="gt_row gt_left">9 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_left">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_0" class="gt_row gt_left" style="font-weight: bold;">50 (0 ; 0%)</td>
<td headers="stat_1" class="gt_row gt_left" style="font-weight: bold;">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_left" style="font-weight: bold;">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_left">13 (26.0%)</td>
<td headers="stat_1" class="gt_row gt_left">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_left">7 (33.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_left">11 (22.0%)</td>
<td headers="stat_1" class="gt_row gt_left">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_left">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_0" class="gt_row gt_left">5 (10.0%)</td>
<td headers="stat_1" class="gt_row gt_left">4 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_left">1 (4.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_0" class="gt_row gt_left">3 (6.0%)</td>
<td headers="stat_1" class="gt_row gt_left">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_left">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_0" class="gt_row gt_left">12 (24.0%)</td>
<td headers="stat_1" class="gt_row gt_left">7 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_left">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_0" class="gt_row gt_left">6 (12.0%)</td>
<td headers="stat_1" class="gt_row gt_left">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_left">3 (14.3%)</td></tr>
  </tbody>
  
  
</table>
</div>
```


# French format

You can customize the output format to french using the `gtsummary::theme_gtsummary_language` function. The `gtsummary::reset_gtsummary_theme()` reset the format to the default behavior (i.e English). You can set the format once at the beginning of the document, no need to specify it multiple times.



``` r
# reset theme to default
gtsummary::reset_gtsummary_theme()
# switch to French format
gtsummary::theme_gtsummary_language(language = "fr", decimal.mark = ",", big.mark = " ")

iris %>%
  Descusmr::desc_var(table_title = "test")
```


```{=html}
<div id="uajiigrlxw" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#uajiigrlxw table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#uajiigrlxw thead, #uajiigrlxw tbody, #uajiigrlxw tfoot, #uajiigrlxw tr, #uajiigrlxw td, #uajiigrlxw th {
  border-style: none;
}

#uajiigrlxw p {
  margin: 0;
  padding: 0;
}

#uajiigrlxw .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#uajiigrlxw .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#uajiigrlxw .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#uajiigrlxw .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#uajiigrlxw .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#uajiigrlxw .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uajiigrlxw .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#uajiigrlxw .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#uajiigrlxw .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#uajiigrlxw .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#uajiigrlxw .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#uajiigrlxw .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#uajiigrlxw .gt_spanner_row {
  border-bottom-style: hidden;
}

#uajiigrlxw .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#uajiigrlxw .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#uajiigrlxw .gt_from_md > :first-child {
  margin-top: 0;
}

#uajiigrlxw .gt_from_md > :last-child {
  margin-bottom: 0;
}

#uajiigrlxw .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#uajiigrlxw .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#uajiigrlxw .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#uajiigrlxw .gt_row_group_first td {
  border-top-width: 2px;
}

#uajiigrlxw .gt_row_group_first th {
  border-top-width: 2px;
}

#uajiigrlxw .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#uajiigrlxw .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#uajiigrlxw .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#uajiigrlxw .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uajiigrlxw .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#uajiigrlxw .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#uajiigrlxw .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#uajiigrlxw .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#uajiigrlxw .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uajiigrlxw .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#uajiigrlxw .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#uajiigrlxw .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#uajiigrlxw .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#uajiigrlxw .gt_left {
  text-align: left;
}

#uajiigrlxw .gt_center {
  text-align: center;
}

#uajiigrlxw .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#uajiigrlxw .gt_font_normal {
  font-weight: normal;
}

#uajiigrlxw .gt_font_bold {
  font-weight: bold;
}

#uajiigrlxw .gt_font_italic {
  font-style: italic;
}

#uajiigrlxw .gt_super {
  font-size: 65%;
}

#uajiigrlxw .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#uajiigrlxw .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#uajiigrlxw .gt_indent_1 {
  text-indent: 5px;
}

#uajiigrlxw .gt_indent_2 {
  text-indent: 10px;
}

#uajiigrlxw .gt_indent_3 {
  text-indent: 15px;
}

#uajiigrlxw .gt_indent_4 {
  text-indent: 20px;
}

#uajiigrlxw .gt_indent_5 {
  text-indent: 25px;
}

#uajiigrlxw .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#uajiigrlxw div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Total</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Sepal.Length</td>
<td headers="stat_0" class="gt_row gt_center">150</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Moyenne (ET)</td>
<td headers="stat_0" class="gt_row gt_center">5,8 (0,8)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Médiane (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">5,8 (5,1 ; 6,4)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">4,3 ; 7,9</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Sepal.Width</td>
<td headers="stat_0" class="gt_row gt_center">150</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Moyenne (ET)</td>
<td headers="stat_0" class="gt_row gt_center">3,1 (0,4)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Médiane (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">3,0 (2,8 ; 3,3)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">2,0 ; 4,4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Petal.Length</td>
<td headers="stat_0" class="gt_row gt_center">150</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Moyenne (ET)</td>
<td headers="stat_0" class="gt_row gt_center">3,8 (1,8)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Médiane (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">4,4 (1,6 ; 5,1)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">1,0 ; 6,9</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Petal.Width</td>
<td headers="stat_0" class="gt_row gt_center">150</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Moyenne (ET)</td>
<td headers="stat_0" class="gt_row gt_center">1,2 (0,8)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Médiane (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">1,3 (0,3 ; 1,8)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">0,1 ; 2,5</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Species</td>
<td headers="stat_0" class="gt_row gt_center">150</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    setosa</td>
<td headers="stat_0" class="gt_row gt_center">50 (33,3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    versicolor</td>
<td headers="stat_0" class="gt_row gt_center">50 (33,3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    virginica</td>
<td headers="stat_0" class="gt_row gt_center">50 (33,3%)</td></tr>
  </tbody>
  
  
</table>
</div>
```


``` r

# you can put several tables here, it will keep French format

# back to default format
gtsummary::reset_gtsummary_theme()
```

