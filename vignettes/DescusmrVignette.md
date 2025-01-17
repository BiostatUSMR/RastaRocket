---
title: "DescusmrVignette"
date: "2025-01-17"
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
- `group`: Indicates whether to create both grouped and ungrouped descriptions using the "ALL" option.



``` r
data %>% Descusmr::desc_var(table_title = "test",
             var_group = "traitement",
             group_title = "traitement",
             group = "ALL")
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



# Missing data

The display of missing data is controlled by the `show_missing_data` argument in the `Descusmr::desc_var` function. By default, if `anyNA(data1)` returns `TRUE`, missing data will be displayed. If no missing data is detected, it will be hidden. Users can override this behavior by explicitly setting `show_missing_data` to `TRUE` or `FALSE`.


``` r
iris %>% Descusmr::desc_var(table_title = "test",
                            var_group = "Species",
                            group_title = "Species",
                            group = "ALL",
                            show_missing_data = TRUE)
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
                            group = "ALL",
                            show_missing_data = FALSE)
```


```{=html}
<div id="igidbvzlik" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#igidbvzlik table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#igidbvzlik thead, #igidbvzlik tbody, #igidbvzlik tfoot, #igidbvzlik tr, #igidbvzlik td, #igidbvzlik th {
  border-style: none;
}

#igidbvzlik p {
  margin: 0;
  padding: 0;
}

#igidbvzlik .gt_table {
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

#igidbvzlik .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#igidbvzlik .gt_title {
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

#igidbvzlik .gt_subtitle {
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

#igidbvzlik .gt_heading {
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

#igidbvzlik .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#igidbvzlik .gt_col_headings {
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

#igidbvzlik .gt_col_heading {
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

#igidbvzlik .gt_column_spanner_outer {
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

#igidbvzlik .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#igidbvzlik .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#igidbvzlik .gt_column_spanner {
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

#igidbvzlik .gt_spanner_row {
  border-bottom-style: hidden;
}

#igidbvzlik .gt_group_heading {
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

#igidbvzlik .gt_empty_group_heading {
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

#igidbvzlik .gt_from_md > :first-child {
  margin-top: 0;
}

#igidbvzlik .gt_from_md > :last-child {
  margin-bottom: 0;
}

#igidbvzlik .gt_row {
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

#igidbvzlik .gt_stub {
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

#igidbvzlik .gt_stub_row_group {
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

#igidbvzlik .gt_row_group_first td {
  border-top-width: 2px;
}

#igidbvzlik .gt_row_group_first th {
  border-top-width: 2px;
}

#igidbvzlik .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#igidbvzlik .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#igidbvzlik .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#igidbvzlik .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#igidbvzlik .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#igidbvzlik .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#igidbvzlik .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#igidbvzlik .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#igidbvzlik .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#igidbvzlik .gt_footnotes {
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

#igidbvzlik .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#igidbvzlik .gt_sourcenotes {
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

#igidbvzlik .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#igidbvzlik .gt_left {
  text-align: left;
}

#igidbvzlik .gt_center {
  text-align: center;
}

#igidbvzlik .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#igidbvzlik .gt_font_normal {
  font-weight: normal;
}

#igidbvzlik .gt_font_bold {
  font-weight: bold;
}

#igidbvzlik .gt_font_italic {
  font-style: italic;
}

#igidbvzlik .gt_super {
  font-size: 65%;
}

#igidbvzlik .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#igidbvzlik .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#igidbvzlik .gt_indent_1 {
  text-indent: 5px;
}

#igidbvzlik .gt_indent_2 {
  text-indent: 10px;
}

#igidbvzlik .gt_indent_3 {
  text-indent: 15px;
}

#igidbvzlik .gt_indent_4 {
  text-indent: 20px;
}

#igidbvzlik .gt_indent_5 {
  text-indent: 25px;
}

#igidbvzlik .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#igidbvzlik div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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

In this example, we add `DM = "tri"`, which orders the categories of categorical variables in descending order based on their counts.


``` r
data %>% desc_var(table_title = "test",
             var_group = "traitement",
             group_title = "traitement",
             group = "ALL", 
             DM = "tri")
```


```{=html}
<div id="qlbsmmsvjp" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#qlbsmmsvjp table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#qlbsmmsvjp thead, #qlbsmmsvjp tbody, #qlbsmmsvjp tfoot, #qlbsmmsvjp tr, #qlbsmmsvjp td, #qlbsmmsvjp th {
  border-style: none;
}

#qlbsmmsvjp p {
  margin: 0;
  padding: 0;
}

#qlbsmmsvjp .gt_table {
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

#qlbsmmsvjp .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#qlbsmmsvjp .gt_title {
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

#qlbsmmsvjp .gt_subtitle {
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

#qlbsmmsvjp .gt_heading {
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

#qlbsmmsvjp .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qlbsmmsvjp .gt_col_headings {
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

#qlbsmmsvjp .gt_col_heading {
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

#qlbsmmsvjp .gt_column_spanner_outer {
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

#qlbsmmsvjp .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#qlbsmmsvjp .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#qlbsmmsvjp .gt_column_spanner {
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

#qlbsmmsvjp .gt_spanner_row {
  border-bottom-style: hidden;
}

#qlbsmmsvjp .gt_group_heading {
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

#qlbsmmsvjp .gt_empty_group_heading {
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

#qlbsmmsvjp .gt_from_md > :first-child {
  margin-top: 0;
}

#qlbsmmsvjp .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qlbsmmsvjp .gt_row {
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

#qlbsmmsvjp .gt_stub {
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

#qlbsmmsvjp .gt_stub_row_group {
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

#qlbsmmsvjp .gt_row_group_first td {
  border-top-width: 2px;
}

#qlbsmmsvjp .gt_row_group_first th {
  border-top-width: 2px;
}

#qlbsmmsvjp .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qlbsmmsvjp .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#qlbsmmsvjp .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#qlbsmmsvjp .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qlbsmmsvjp .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qlbsmmsvjp .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#qlbsmmsvjp .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#qlbsmmsvjp .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#qlbsmmsvjp .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qlbsmmsvjp .gt_footnotes {
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

#qlbsmmsvjp .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#qlbsmmsvjp .gt_sourcenotes {
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

#qlbsmmsvjp .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#qlbsmmsvjp .gt_left {
  text-align: left;
}

#qlbsmmsvjp .gt_center {
  text-align: center;
}

#qlbsmmsvjp .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#qlbsmmsvjp .gt_font_normal {
  font-weight: normal;
}

#qlbsmmsvjp .gt_font_bold {
  font-weight: bold;
}

#qlbsmmsvjp .gt_font_italic {
  font-style: italic;
}

#qlbsmmsvjp .gt_super {
  font-size: 65%;
}

#qlbsmmsvjp .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#qlbsmmsvjp .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#qlbsmmsvjp .gt_indent_1 {
  text-indent: 5px;
}

#qlbsmmsvjp .gt_indent_2 {
  text-indent: 10px;
}

#qlbsmmsvjp .gt_indent_3 {
  text-indent: 15px;
}

#qlbsmmsvjp .gt_indent_4 {
  text-indent: 20px;
}

#qlbsmmsvjp .gt_indent_5 {
  text-indent: 25px;
}

#qlbsmmsvjp .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#qlbsmmsvjp div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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


### Custom order

The default order of categorical features is determined by their levels. If you want to customize this order, you can modify the levels using a library such as `forcats`.


``` r
data %>%
  dplyr::mutate(quatre_modalites = forcats::fct_relevel(quatre_modalites,
                                                       "A", "C", "D", "B")) %>%
  desc_var(table_title = "test",
           var_group = "traitement",
           group_title = "traitement",
           group = "ALL")
```


```{=html}
<div id="kdxlmjjxgr" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#kdxlmjjxgr table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#kdxlmjjxgr thead, #kdxlmjjxgr tbody, #kdxlmjjxgr tfoot, #kdxlmjjxgr tr, #kdxlmjjxgr td, #kdxlmjjxgr th {
  border-style: none;
}

#kdxlmjjxgr p {
  margin: 0;
  padding: 0;
}

#kdxlmjjxgr .gt_table {
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

#kdxlmjjxgr .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#kdxlmjjxgr .gt_title {
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

#kdxlmjjxgr .gt_subtitle {
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

#kdxlmjjxgr .gt_heading {
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

#kdxlmjjxgr .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kdxlmjjxgr .gt_col_headings {
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

#kdxlmjjxgr .gt_col_heading {
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

#kdxlmjjxgr .gt_column_spanner_outer {
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

#kdxlmjjxgr .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#kdxlmjjxgr .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#kdxlmjjxgr .gt_column_spanner {
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

#kdxlmjjxgr .gt_spanner_row {
  border-bottom-style: hidden;
}

#kdxlmjjxgr .gt_group_heading {
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

#kdxlmjjxgr .gt_empty_group_heading {
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

#kdxlmjjxgr .gt_from_md > :first-child {
  margin-top: 0;
}

#kdxlmjjxgr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kdxlmjjxgr .gt_row {
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

#kdxlmjjxgr .gt_stub {
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

#kdxlmjjxgr .gt_stub_row_group {
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

#kdxlmjjxgr .gt_row_group_first td {
  border-top-width: 2px;
}

#kdxlmjjxgr .gt_row_group_first th {
  border-top-width: 2px;
}

#kdxlmjjxgr .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kdxlmjjxgr .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#kdxlmjjxgr .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#kdxlmjjxgr .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kdxlmjjxgr .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kdxlmjjxgr .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#kdxlmjjxgr .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#kdxlmjjxgr .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#kdxlmjjxgr .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kdxlmjjxgr .gt_footnotes {
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

#kdxlmjjxgr .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kdxlmjjxgr .gt_sourcenotes {
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

#kdxlmjjxgr .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kdxlmjjxgr .gt_left {
  text-align: left;
}

#kdxlmjjxgr .gt_center {
  text-align: center;
}

#kdxlmjjxgr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kdxlmjjxgr .gt_font_normal {
  font-weight: normal;
}

#kdxlmjjxgr .gt_font_bold {
  font-weight: bold;
}

#kdxlmjjxgr .gt_font_italic {
  font-style: italic;
}

#kdxlmjjxgr .gt_super {
  font-size: 65%;
}

#kdxlmjjxgr .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#kdxlmjjxgr .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#kdxlmjjxgr .gt_indent_1 {
  text-indent: 5px;
}

#kdxlmjjxgr .gt_indent_2 {
  text-indent: 10px;
}

#kdxlmjjxgr .gt_indent_3 {
  text-indent: 15px;
}

#kdxlmjjxgr .gt_indent_4 {
  text-indent: 20px;
}

#kdxlmjjxgr .gt_indent_5 {
  text-indent: 25px;
}

#kdxlmjjxgr .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#kdxlmjjxgr div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
    <tr><td headers="label" class="gt_row gt_left">    D</td>
<td headers="stat_0" class="gt_row gt_center">0 (0.0%)</td>
<td headers="stat_1" class="gt_row gt_center">0 (0.0%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
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


Here, we remove levels with a zero count.


``` r
data %>% desc_var(table_title = "test",
             var_group = "traitement",
             group_title = "traitement",
             group = "ALL", 
             DM = "remove")
```


```{=html}
<div id="jpxptjyfsd" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#jpxptjyfsd table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#jpxptjyfsd thead, #jpxptjyfsd tbody, #jpxptjyfsd tfoot, #jpxptjyfsd tr, #jpxptjyfsd td, #jpxptjyfsd th {
  border-style: none;
}

#jpxptjyfsd p {
  margin: 0;
  padding: 0;
}

#jpxptjyfsd .gt_table {
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

#jpxptjyfsd .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#jpxptjyfsd .gt_title {
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

#jpxptjyfsd .gt_subtitle {
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

#jpxptjyfsd .gt_heading {
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

#jpxptjyfsd .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jpxptjyfsd .gt_col_headings {
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

#jpxptjyfsd .gt_col_heading {
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

#jpxptjyfsd .gt_column_spanner_outer {
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

#jpxptjyfsd .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#jpxptjyfsd .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#jpxptjyfsd .gt_column_spanner {
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

#jpxptjyfsd .gt_spanner_row {
  border-bottom-style: hidden;
}

#jpxptjyfsd .gt_group_heading {
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

#jpxptjyfsd .gt_empty_group_heading {
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

#jpxptjyfsd .gt_from_md > :first-child {
  margin-top: 0;
}

#jpxptjyfsd .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jpxptjyfsd .gt_row {
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

#jpxptjyfsd .gt_stub {
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

#jpxptjyfsd .gt_stub_row_group {
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

#jpxptjyfsd .gt_row_group_first td {
  border-top-width: 2px;
}

#jpxptjyfsd .gt_row_group_first th {
  border-top-width: 2px;
}

#jpxptjyfsd .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jpxptjyfsd .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#jpxptjyfsd .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#jpxptjyfsd .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jpxptjyfsd .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jpxptjyfsd .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#jpxptjyfsd .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#jpxptjyfsd .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#jpxptjyfsd .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jpxptjyfsd .gt_footnotes {
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

#jpxptjyfsd .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jpxptjyfsd .gt_sourcenotes {
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

#jpxptjyfsd .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jpxptjyfsd .gt_left {
  text-align: left;
}

#jpxptjyfsd .gt_center {
  text-align: center;
}

#jpxptjyfsd .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jpxptjyfsd .gt_font_normal {
  font-weight: normal;
}

#jpxptjyfsd .gt_font_bold {
  font-weight: bold;
}

#jpxptjyfsd .gt_font_italic {
  font-style: italic;
}

#jpxptjyfsd .gt_super {
  font-size: 65%;
}

#jpxptjyfsd .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#jpxptjyfsd .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#jpxptjyfsd .gt_indent_1 {
  text-indent: 5px;
}

#jpxptjyfsd .gt_indent_2 {
  text-indent: 10px;
}

#jpxptjyfsd .gt_indent_3 {
  text-indent: 15px;
}

#jpxptjyfsd .gt_indent_4 {
  text-indent: 20px;
}

#jpxptjyfsd .gt_indent_5 {
  text-indent: 25px;
}

#jpxptjyfsd .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#jpxptjyfsd div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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


## Both


In this example, both previous data management operations are performed simultaneously using `DM = "ALL"`. Additionally, we specify the variable `echelle` as quantitative (even though it is treated as qualitative by default) using the `quanti` argument. If multiple variables are to be specified, they should be listed in a vector.


``` r

data %>% Descusmr::desc_var(table_title = "test",
             quanti = "echelle",
             var_group = "traitement",
             group_title = "traitement",
             group = "ALL", 
             DM = "tout")
```


```{=html}
<div id="pikksjwbyf" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#pikksjwbyf table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#pikksjwbyf thead, #pikksjwbyf tbody, #pikksjwbyf tfoot, #pikksjwbyf tr, #pikksjwbyf td, #pikksjwbyf th {
  border-style: none;
}

#pikksjwbyf p {
  margin: 0;
  padding: 0;
}

#pikksjwbyf .gt_table {
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

#pikksjwbyf .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#pikksjwbyf .gt_title {
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

#pikksjwbyf .gt_subtitle {
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

#pikksjwbyf .gt_heading {
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

#pikksjwbyf .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pikksjwbyf .gt_col_headings {
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

#pikksjwbyf .gt_col_heading {
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

#pikksjwbyf .gt_column_spanner_outer {
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

#pikksjwbyf .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#pikksjwbyf .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#pikksjwbyf .gt_column_spanner {
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

#pikksjwbyf .gt_spanner_row {
  border-bottom-style: hidden;
}

#pikksjwbyf .gt_group_heading {
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

#pikksjwbyf .gt_empty_group_heading {
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

#pikksjwbyf .gt_from_md > :first-child {
  margin-top: 0;
}

#pikksjwbyf .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pikksjwbyf .gt_row {
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

#pikksjwbyf .gt_stub {
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

#pikksjwbyf .gt_stub_row_group {
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

#pikksjwbyf .gt_row_group_first td {
  border-top-width: 2px;
}

#pikksjwbyf .gt_row_group_first th {
  border-top-width: 2px;
}

#pikksjwbyf .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pikksjwbyf .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#pikksjwbyf .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#pikksjwbyf .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pikksjwbyf .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pikksjwbyf .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#pikksjwbyf .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#pikksjwbyf .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#pikksjwbyf .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pikksjwbyf .gt_footnotes {
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

#pikksjwbyf .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pikksjwbyf .gt_sourcenotes {
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

#pikksjwbyf .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pikksjwbyf .gt_left {
  text-align: left;
}

#pikksjwbyf .gt_center {
  text-align: center;
}

#pikksjwbyf .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#pikksjwbyf .gt_font_normal {
  font-weight: normal;
}

#pikksjwbyf .gt_font_bold {
  font-weight: bold;
}

#pikksjwbyf .gt_font_italic {
  font-style: italic;
}

#pikksjwbyf .gt_super {
  font-size: 65%;
}

#pikksjwbyf .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#pikksjwbyf .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#pikksjwbyf .gt_indent_1 {
  text-indent: 5px;
}

#pikksjwbyf .gt_indent_2 {
  text-indent: 10px;
}

#pikksjwbyf .gt_indent_3 {
  text-indent: 15px;
}

#pikksjwbyf .gt_indent_4 {
  text-indent: 20px;
}

#pikksjwbyf .gt_indent_5 {
  text-indent: 25px;
}

#pikksjwbyf .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#pikksjwbyf div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_0" class="gt_row gt_center">2.2 (1.8)</td>
<td headers="stat_1" class="gt_row gt_center">2.3 (1.8)</td>
<td headers="stat_2" class="gt_row gt_center">2.0 (2.0)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_0" class="gt_row gt_center">2.0 (0.0 ; 4.0)</td>
<td headers="stat_1" class="gt_row gt_center">2.0 (1.0 ; 4.0)</td>
<td headers="stat_2" class="gt_row gt_center">1.0 (0.0 ; 4.0)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_0" class="gt_row gt_center">0.0 ; 5.0</td>
<td headers="stat_1" class="gt_row gt_center">0.0 ; 5.0</td>
<td headers="stat_2" class="gt_row gt_center">0.0 ; 5.0</td></tr>
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
             group_title = "traitement",
             group = TRUE, 
             DM = "tout")
```


```{=html}
<div id="pwsjsqgfld" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#pwsjsqgfld table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#pwsjsqgfld thead, #pwsjsqgfld tbody, #pwsjsqgfld tfoot, #pwsjsqgfld tr, #pwsjsqgfld td, #pwsjsqgfld th {
  border-style: none;
}

#pwsjsqgfld p {
  margin: 0;
  padding: 0;
}

#pwsjsqgfld .gt_table {
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

#pwsjsqgfld .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#pwsjsqgfld .gt_title {
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

#pwsjsqgfld .gt_subtitle {
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

#pwsjsqgfld .gt_heading {
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

#pwsjsqgfld .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pwsjsqgfld .gt_col_headings {
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

#pwsjsqgfld .gt_col_heading {
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

#pwsjsqgfld .gt_column_spanner_outer {
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

#pwsjsqgfld .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#pwsjsqgfld .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#pwsjsqgfld .gt_column_spanner {
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

#pwsjsqgfld .gt_spanner_row {
  border-bottom-style: hidden;
}

#pwsjsqgfld .gt_group_heading {
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

#pwsjsqgfld .gt_empty_group_heading {
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

#pwsjsqgfld .gt_from_md > :first-child {
  margin-top: 0;
}

#pwsjsqgfld .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pwsjsqgfld .gt_row {
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

#pwsjsqgfld .gt_stub {
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

#pwsjsqgfld .gt_stub_row_group {
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

#pwsjsqgfld .gt_row_group_first td {
  border-top-width: 2px;
}

#pwsjsqgfld .gt_row_group_first th {
  border-top-width: 2px;
}

#pwsjsqgfld .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pwsjsqgfld .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#pwsjsqgfld .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#pwsjsqgfld .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pwsjsqgfld .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pwsjsqgfld .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#pwsjsqgfld .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#pwsjsqgfld .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#pwsjsqgfld .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pwsjsqgfld .gt_footnotes {
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

#pwsjsqgfld .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pwsjsqgfld .gt_sourcenotes {
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

#pwsjsqgfld .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pwsjsqgfld .gt_left {
  text-align: left;
}

#pwsjsqgfld .gt_center {
  text-align: center;
}

#pwsjsqgfld .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#pwsjsqgfld .gt_font_normal {
  font-weight: normal;
}

#pwsjsqgfld .gt_font_bold {
  font-weight: bold;
}

#pwsjsqgfld .gt_font_italic {
  font-style: italic;
}

#pwsjsqgfld .gt_super {
  font-size: 65%;
}

#pwsjsqgfld .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#pwsjsqgfld .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#pwsjsqgfld .gt_indent_1 {
  text-indent: 5px;
}

#pwsjsqgfld .gt_indent_2 {
  text-indent: 10px;
}

#pwsjsqgfld .gt_indent_3 {
  text-indent: 15px;
}

#pwsjsqgfld .gt_indent_4 {
  text-indent: 20px;
}

#pwsjsqgfld .gt_indent_5 {
  text-indent: 25px;
}

#pwsjsqgfld .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#pwsjsqgfld div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
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
<td headers="stat_1" class="gt_row gt_center">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_center">19 (2 ; 4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_1" class="gt_row gt_center">51.0 (9.6)</td>
<td headers="stat_2" class="gt_row gt_center">50.2 (9.5)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_1" class="gt_row gt_center">51.3 (44.4 ; 57.0)</td>
<td headers="stat_2" class="gt_row gt_center">49.4 (43.1 ; 58.8)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_1" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_2" class="gt_row gt_center">33.1 ; 67.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_1" class="gt_row gt_center">13 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_center">15 (71.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_1" class="gt_row gt_center">16 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_1" class="gt_row gt_center">18 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_center">10 (47.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_1" class="gt_row gt_center">9 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_1" class="gt_row gt_center">2 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">7 (33.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_1" class="gt_row gt_center">4 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (4.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_1" class="gt_row gt_center">7 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (14.3%)</td></tr>
  </tbody>
  
  
</table>
</div>
```


## Overall Description

In this example, we generate a global description of the variables.


``` r
data %>% Descusmr::desc_var(table_title = "test", group = FALSE)
```


```{=html}
<div id="nymghcvpvx" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#nymghcvpvx table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#nymghcvpvx thead, #nymghcvpvx tbody, #nymghcvpvx tfoot, #nymghcvpvx tr, #nymghcvpvx td, #nymghcvpvx th {
  border-style: none;
}

#nymghcvpvx p {
  margin: 0;
  padding: 0;
}

#nymghcvpvx .gt_table {
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

#nymghcvpvx .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#nymghcvpvx .gt_title {
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

#nymghcvpvx .gt_subtitle {
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

#nymghcvpvx .gt_heading {
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

#nymghcvpvx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nymghcvpvx .gt_col_headings {
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

#nymghcvpvx .gt_col_heading {
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

#nymghcvpvx .gt_column_spanner_outer {
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

#nymghcvpvx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#nymghcvpvx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#nymghcvpvx .gt_column_spanner {
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

#nymghcvpvx .gt_spanner_row {
  border-bottom-style: hidden;
}

#nymghcvpvx .gt_group_heading {
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

#nymghcvpvx .gt_empty_group_heading {
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

#nymghcvpvx .gt_from_md > :first-child {
  margin-top: 0;
}

#nymghcvpvx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#nymghcvpvx .gt_row {
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

#nymghcvpvx .gt_stub {
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

#nymghcvpvx .gt_stub_row_group {
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

#nymghcvpvx .gt_row_group_first td {
  border-top-width: 2px;
}

#nymghcvpvx .gt_row_group_first th {
  border-top-width: 2px;
}

#nymghcvpvx .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nymghcvpvx .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#nymghcvpvx .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#nymghcvpvx .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nymghcvpvx .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nymghcvpvx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#nymghcvpvx .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#nymghcvpvx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#nymghcvpvx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nymghcvpvx .gt_footnotes {
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

#nymghcvpvx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nymghcvpvx .gt_sourcenotes {
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

#nymghcvpvx .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nymghcvpvx .gt_left {
  text-align: left;
}

#nymghcvpvx .gt_center {
  text-align: center;
}

#nymghcvpvx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#nymghcvpvx .gt_font_normal {
  font-weight: normal;
}

#nymghcvpvx .gt_font_bold {
  font-weight: bold;
}

#nymghcvpvx .gt_font_italic {
  font-style: italic;
}

#nymghcvpvx .gt_super {
  font-size: 65%;
}

#nymghcvpvx .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#nymghcvpvx .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#nymghcvpvx .gt_indent_1 {
  text-indent: 5px;
}

#nymghcvpvx .gt_indent_2 {
  text-indent: 10px;
}

#nymghcvpvx .gt_indent_3 {
  text-indent: 15px;
}

#nymghcvpvx .gt_indent_4 {
  text-indent: 20px;
}

#nymghcvpvx .gt_indent_5 {
  text-indent: 25px;
}

#nymghcvpvx .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#nymghcvpvx div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>N = 50</strong></span></th>
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
    <tr><td headers="label" class="gt_row gt_left">    D</td>
<td headers="stat_0" class="gt_row gt_center">0 (0.0%)</td></tr>
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
  Descusmr::desc_var(table_title = "test",
                     group = FALSE)

tb2 <- data %>%
  dplyr::select(quatre_modalites) %>%
  Descusmr::desc_var(table_title = "test",
                     group = FALSE)

Descusmr::intermediate_header(tbls = list(tb1, tb2),
                              group_header = c("Title A", "Title B"))
```


```{=html}
<div id="zdmhodmcga" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#zdmhodmcga table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#zdmhodmcga thead, #zdmhodmcga tbody, #zdmhodmcga tfoot, #zdmhodmcga tr, #zdmhodmcga td, #zdmhodmcga th {
  border-style: none;
}

#zdmhodmcga p {
  margin: 0;
  padding: 0;
}

#zdmhodmcga .gt_table {
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

#zdmhodmcga .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#zdmhodmcga .gt_title {
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

#zdmhodmcga .gt_subtitle {
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

#zdmhodmcga .gt_heading {
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

#zdmhodmcga .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zdmhodmcga .gt_col_headings {
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

#zdmhodmcga .gt_col_heading {
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

#zdmhodmcga .gt_column_spanner_outer {
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

#zdmhodmcga .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#zdmhodmcga .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#zdmhodmcga .gt_column_spanner {
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

#zdmhodmcga .gt_spanner_row {
  border-bottom-style: hidden;
}

#zdmhodmcga .gt_group_heading {
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

#zdmhodmcga .gt_empty_group_heading {
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

#zdmhodmcga .gt_from_md > :first-child {
  margin-top: 0;
}

#zdmhodmcga .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zdmhodmcga .gt_row {
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

#zdmhodmcga .gt_stub {
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

#zdmhodmcga .gt_stub_row_group {
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

#zdmhodmcga .gt_row_group_first td {
  border-top-width: 2px;
}

#zdmhodmcga .gt_row_group_first th {
  border-top-width: 2px;
}

#zdmhodmcga .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zdmhodmcga .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#zdmhodmcga .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#zdmhodmcga .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zdmhodmcga .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zdmhodmcga .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#zdmhodmcga .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#zdmhodmcga .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#zdmhodmcga .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zdmhodmcga .gt_footnotes {
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

#zdmhodmcga .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#zdmhodmcga .gt_sourcenotes {
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

#zdmhodmcga .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#zdmhodmcga .gt_left {
  text-align: left;
}

#zdmhodmcga .gt_center {
  text-align: center;
}

#zdmhodmcga .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zdmhodmcga .gt_font_normal {
  font-weight: normal;
}

#zdmhodmcga .gt_font_bold {
  font-weight: bold;
}

#zdmhodmcga .gt_font_italic {
  font-style: italic;
}

#zdmhodmcga .gt_super {
  font-size: 65%;
}

#zdmhodmcga .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#zdmhodmcga .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#zdmhodmcga .gt_indent_1 {
  text-indent: 5px;
}

#zdmhodmcga .gt_indent_2 {
  text-indent: 10px;
}

#zdmhodmcga .gt_indent_3 {
  text-indent: 15px;
}

#zdmhodmcga .gt_indent_4 {
  text-indent: 20px;
}

#zdmhodmcga .gt_indent_5 {
  text-indent: 25px;
}

#zdmhodmcga .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#zdmhodmcga div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>N = 50</strong></span></th>
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
    <tr><td headers="Title B  label" class="gt_row gt_left">    D</td>
<td headers="Title B  stat_0" class="gt_row gt_center">0 (0.0%)</td></tr>
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
                     group = TRUE,
                     var_group = "traitement",
                     round_quanti = 0,
                     round_quali = 1)
```


```{=html}
<div id="mtnpgdmlym" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#mtnpgdmlym table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#mtnpgdmlym thead, #mtnpgdmlym tbody, #mtnpgdmlym tfoot, #mtnpgdmlym tr, #mtnpgdmlym td, #mtnpgdmlym th {
  border-style: none;
}

#mtnpgdmlym p {
  margin: 0;
  padding: 0;
}

#mtnpgdmlym .gt_table {
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

#mtnpgdmlym .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#mtnpgdmlym .gt_title {
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

#mtnpgdmlym .gt_subtitle {
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

#mtnpgdmlym .gt_heading {
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

#mtnpgdmlym .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mtnpgdmlym .gt_col_headings {
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

#mtnpgdmlym .gt_col_heading {
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

#mtnpgdmlym .gt_column_spanner_outer {
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

#mtnpgdmlym .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#mtnpgdmlym .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#mtnpgdmlym .gt_column_spanner {
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

#mtnpgdmlym .gt_spanner_row {
  border-bottom-style: hidden;
}

#mtnpgdmlym .gt_group_heading {
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

#mtnpgdmlym .gt_empty_group_heading {
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

#mtnpgdmlym .gt_from_md > :first-child {
  margin-top: 0;
}

#mtnpgdmlym .gt_from_md > :last-child {
  margin-bottom: 0;
}

#mtnpgdmlym .gt_row {
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

#mtnpgdmlym .gt_stub {
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

#mtnpgdmlym .gt_stub_row_group {
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

#mtnpgdmlym .gt_row_group_first td {
  border-top-width: 2px;
}

#mtnpgdmlym .gt_row_group_first th {
  border-top-width: 2px;
}

#mtnpgdmlym .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mtnpgdmlym .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#mtnpgdmlym .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#mtnpgdmlym .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mtnpgdmlym .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mtnpgdmlym .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#mtnpgdmlym .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#mtnpgdmlym .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#mtnpgdmlym .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mtnpgdmlym .gt_footnotes {
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

#mtnpgdmlym .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#mtnpgdmlym .gt_sourcenotes {
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

#mtnpgdmlym .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#mtnpgdmlym .gt_left {
  text-align: left;
}

#mtnpgdmlym .gt_center {
  text-align: center;
}

#mtnpgdmlym .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#mtnpgdmlym .gt_font_normal {
  font-weight: normal;
}

#mtnpgdmlym .gt_font_bold {
  font-weight: bold;
}

#mtnpgdmlym .gt_font_italic {
  font-style: italic;
}

#mtnpgdmlym .gt_super {
  font-size: 65%;
}

#mtnpgdmlym .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#mtnpgdmlym .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#mtnpgdmlym .gt_indent_1 {
  text-indent: 5px;
}

#mtnpgdmlym .gt_indent_2 {
  text-indent: 10px;
}

#mtnpgdmlym .gt_indent_3 {
  text-indent: 15px;
}

#mtnpgdmlym .gt_indent_4 {
  text-indent: 20px;
}

#mtnpgdmlym .gt_indent_5 {
  text-indent: 25px;
}

#mtnpgdmlym .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#mtnpgdmlym div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="****">
        <div class="gt_column_spanner"><span class='gt_from_md'><hr />
</span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_center">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_center">19 (2 ; 4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_1" class="gt_row gt_center">51 (10)</td>
<td headers="stat_2" class="gt_row gt_center">50 (10)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_1" class="gt_row gt_center">51 (44 ; 57)</td>
<td headers="stat_2" class="gt_row gt_center">49 (43 ; 59)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_1" class="gt_row gt_center">30 ; 72</td>
<td headers="stat_2" class="gt_row gt_center">33 ; 68</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_1" class="gt_row gt_center">13.0 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_center">15.0 (71.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_1" class="gt_row gt_center">16.0 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_center">6.0 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_1" class="gt_row gt_center">2.0 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_center">5.0 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_1" class="gt_row gt_center">18.0 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_center">10.0 (47.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_1" class="gt_row gt_center">9.0 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_center">6.0 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    D</td>
<td headers="stat_1" class="gt_row gt_center">0.0 (0.0%)</td>
<td headers="stat_2" class="gt_row gt_center">0.0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_1" class="gt_row gt_center">6.0 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">7.0 (33.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_1" class="gt_row gt_center">6.0 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">5.0 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_1" class="gt_row gt_center">4.0 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_center">1.0 (4.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_1" class="gt_row gt_center">3.0 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">0.0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_1" class="gt_row gt_center">7.0 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_center">5.0 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
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
                     group = TRUE,
                     var_group = "traitement",
                     round_quanti = 0,
                     round_quali = 0)

tb2 <- data %>%
  dplyr::select(quatre_modalites, traitement) %>%
  Descusmr::desc_var(table_title = "test",
                     group = TRUE,
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
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="****">
        <div class="gt_column_spanner"><span class='gt_from_md'><hr />
</span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_center">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_center">19 (2 ; 4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_1" class="gt_row gt_center">51 (10)</td>
<td headers="stat_2" class="gt_row gt_center">50 (10)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_1" class="gt_row gt_center">51 (44 ; 57)</td>
<td headers="stat_2" class="gt_row gt_center">49 (43 ; 59)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_1" class="gt_row gt_center">30 ; 72</td>
<td headers="stat_2" class="gt_row gt_center">33 ; 68</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_1" class="gt_row gt_center">13 (45%)</td>
<td headers="stat_2" class="gt_row gt_center">15 (71%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_1" class="gt_row gt_center">16 (55%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (29%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux</td>
<td headers="stat_1" class="gt_row gt_center">29</td>
<td headers="stat_2" class="gt_row gt_center">21</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_1" class="gt_row gt_center">2.00 (6.90%)</td>
<td headers="stat_2" class="gt_row gt_center">5.00 (23.81%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_1" class="gt_row gt_center">18.00 (62.07%)</td>
<td headers="stat_2" class="gt_row gt_center">10.00 (47.62%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_1" class="gt_row gt_center">9.00 (31.03%)</td>
<td headers="stat_2" class="gt_row gt_center">6.00 (28.57%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    D</td>
<td headers="stat_1" class="gt_row gt_center">0.00 (0.00%)</td>
<td headers="stat_2" class="gt_row gt_center">0.00 (0.00%)</td></tr>
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
                     group = TRUE,
                     var_group = "traitement",
                     tests = TRUE)
```


```{=html}
<div id="otliydcgdx" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#otliydcgdx table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#otliydcgdx thead, #otliydcgdx tbody, #otliydcgdx tfoot, #otliydcgdx tr, #otliydcgdx td, #otliydcgdx th {
  border-style: none;
}

#otliydcgdx p {
  margin: 0;
  padding: 0;
}

#otliydcgdx .gt_table {
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

#otliydcgdx .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#otliydcgdx .gt_title {
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

#otliydcgdx .gt_subtitle {
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

#otliydcgdx .gt_heading {
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

#otliydcgdx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#otliydcgdx .gt_col_headings {
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

#otliydcgdx .gt_col_heading {
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

#otliydcgdx .gt_column_spanner_outer {
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

#otliydcgdx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#otliydcgdx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#otliydcgdx .gt_column_spanner {
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

#otliydcgdx .gt_spanner_row {
  border-bottom-style: hidden;
}

#otliydcgdx .gt_group_heading {
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

#otliydcgdx .gt_empty_group_heading {
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

#otliydcgdx .gt_from_md > :first-child {
  margin-top: 0;
}

#otliydcgdx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#otliydcgdx .gt_row {
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

#otliydcgdx .gt_stub {
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

#otliydcgdx .gt_stub_row_group {
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

#otliydcgdx .gt_row_group_first td {
  border-top-width: 2px;
}

#otliydcgdx .gt_row_group_first th {
  border-top-width: 2px;
}

#otliydcgdx .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#otliydcgdx .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#otliydcgdx .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#otliydcgdx .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#otliydcgdx .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#otliydcgdx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#otliydcgdx .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#otliydcgdx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#otliydcgdx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#otliydcgdx .gt_footnotes {
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

#otliydcgdx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#otliydcgdx .gt_sourcenotes {
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

#otliydcgdx .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#otliydcgdx .gt_left {
  text-align: left;
}

#otliydcgdx .gt_center {
  text-align: center;
}

#otliydcgdx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#otliydcgdx .gt_font_normal {
  font-weight: normal;
}

#otliydcgdx .gt_font_bold {
  font-weight: bold;
}

#otliydcgdx .gt_font_italic {
  font-style: italic;
}

#otliydcgdx .gt_super {
  font-size: 65%;
}

#otliydcgdx .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#otliydcgdx .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#otliydcgdx .gt_indent_1 {
  text-indent: 5px;
}

#otliydcgdx .gt_indent_2 {
  text-indent: 10px;
}

#otliydcgdx .gt_indent_3 {
  text-indent: 15px;
}

#otliydcgdx .gt_indent_4 {
  text-indent: 20px;
}

#otliydcgdx .gt_indent_5 {
  text-indent: 25px;
}

#otliydcgdx .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#otliydcgdx div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="****">
        <div class="gt_column_spanner"><span class='gt_from_md'><hr />
</span></div>
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
<td headers="stat_1" class="gt_row gt_center">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_center">19 (2 ; 4%)</td>
<td headers="p.value" class="gt_row gt_center">0.7<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_1" class="gt_row gt_center">51.0 (9.6)</td>
<td headers="stat_2" class="gt_row gt_center">50.2 (9.5)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_1" class="gt_row gt_center">51.3 (44.4 ; 57.0)</td>
<td headers="stat_2" class="gt_row gt_center">49.4 (43.1 ; 58.8)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_1" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_2" class="gt_row gt_center">33.1 ; 67.9</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center">0.061<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_1" class="gt_row gt_center">13 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_center">15 (71.4%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_1" class="gt_row gt_center">16 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center">0.3<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_1" class="gt_row gt_center">2 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_1" class="gt_row gt_center">18 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_center">10 (47.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_1" class="gt_row gt_center">9 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    D</td>
<td headers="stat_1" class="gt_row gt_center">0 (0.0%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center">0.6<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">7 (33.3%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_1" class="gt_row gt_center">4 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (4.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_1" class="gt_row gt_center">7 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (14.3%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="4"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Wilcoxon rank sum exact test</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="4"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span> <span class='gt_from_md'>Pearson’s Chi-squared test</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="4"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span> <span class='gt_from_md'>Fisher’s exact test</span></td>
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
                     group = TRUE,
                     var_group = "traitement",
                     tests = list(Age = "t.test",
                                  sexe = "chisq.test",
                                  echelle = "fisher.test"))
```


```{=html}
<div id="rkvakzfujy" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#rkvakzfujy table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#rkvakzfujy thead, #rkvakzfujy tbody, #rkvakzfujy tfoot, #rkvakzfujy tr, #rkvakzfujy td, #rkvakzfujy th {
  border-style: none;
}

#rkvakzfujy p {
  margin: 0;
  padding: 0;
}

#rkvakzfujy .gt_table {
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

#rkvakzfujy .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#rkvakzfujy .gt_title {
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

#rkvakzfujy .gt_subtitle {
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

#rkvakzfujy .gt_heading {
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

#rkvakzfujy .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rkvakzfujy .gt_col_headings {
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

#rkvakzfujy .gt_col_heading {
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

#rkvakzfujy .gt_column_spanner_outer {
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

#rkvakzfujy .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#rkvakzfujy .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#rkvakzfujy .gt_column_spanner {
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

#rkvakzfujy .gt_spanner_row {
  border-bottom-style: hidden;
}

#rkvakzfujy .gt_group_heading {
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

#rkvakzfujy .gt_empty_group_heading {
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

#rkvakzfujy .gt_from_md > :first-child {
  margin-top: 0;
}

#rkvakzfujy .gt_from_md > :last-child {
  margin-bottom: 0;
}

#rkvakzfujy .gt_row {
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

#rkvakzfujy .gt_stub {
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

#rkvakzfujy .gt_stub_row_group {
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

#rkvakzfujy .gt_row_group_first td {
  border-top-width: 2px;
}

#rkvakzfujy .gt_row_group_first th {
  border-top-width: 2px;
}

#rkvakzfujy .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rkvakzfujy .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#rkvakzfujy .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#rkvakzfujy .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rkvakzfujy .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rkvakzfujy .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#rkvakzfujy .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#rkvakzfujy .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#rkvakzfujy .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rkvakzfujy .gt_footnotes {
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

#rkvakzfujy .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rkvakzfujy .gt_sourcenotes {
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

#rkvakzfujy .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rkvakzfujy .gt_left {
  text-align: left;
}

#rkvakzfujy .gt_center {
  text-align: center;
}

#rkvakzfujy .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#rkvakzfujy .gt_font_normal {
  font-weight: normal;
}

#rkvakzfujy .gt_font_bold {
  font-weight: bold;
}

#rkvakzfujy .gt_font_italic {
  font-style: italic;
}

#rkvakzfujy .gt_super {
  font-size: 65%;
}

#rkvakzfujy .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#rkvakzfujy .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#rkvakzfujy .gt_indent_1 {
  text-indent: 5px;
}

#rkvakzfujy .gt_indent_2 {
  text-indent: 10px;
}

#rkvakzfujy .gt_indent_3 {
  text-indent: 15px;
}

#rkvakzfujy .gt_indent_4 {
  text-indent: 20px;
}

#rkvakzfujy .gt_indent_5 {
  text-indent: 25px;
}

#rkvakzfujy .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#rkvakzfujy div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="****">
        <div class="gt_column_spanner"><span class='gt_from_md'><hr />
</span></div>
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
<td headers="stat_1" class="gt_row gt_center">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_center">19 (2 ; 4%)</td>
<td headers="p.value" class="gt_row gt_center">0.8<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_1" class="gt_row gt_center">51.0 (9.6)</td>
<td headers="stat_2" class="gt_row gt_center">50.2 (9.5)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_1" class="gt_row gt_center">51.3 (44.4 ; 57.0)</td>
<td headers="stat_2" class="gt_row gt_center">49.4 (43.1 ; 58.8)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_1" class="gt_row gt_center">30.3 ; 71.7</td>
<td headers="stat_2" class="gt_row gt_center">33.1 ; 67.9</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center">0.11<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_1" class="gt_row gt_center">13 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_center">15 (71.4%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_1" class="gt_row gt_center">16 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center">0.3<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_1" class="gt_row gt_center">2 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_1" class="gt_row gt_center">18 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_center">10 (47.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_1" class="gt_row gt_center">9 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_center">6 (28.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    D</td>
<td headers="stat_1" class="gt_row gt_center">0 (0.0%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_center">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center">0.6<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">7 (33.3%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_1" class="gt_row gt_center">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_1" class="gt_row gt_center">4 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (4.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0.0%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_1" class="gt_row gt_center">7 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_center">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_1" class="gt_row gt_center">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (14.3%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="4"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Welch Two Sample t-test</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="4"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span> <span class='gt_from_md'>Pearson’s Chi-squared test</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="4"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span> <span class='gt_from_md'>Fisher’s exact test</span></td>
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
                     group = TRUE,
                     var_group = "traitement",
                     tests = list(Age = "t.test",
                                  sexe = "chisq.test",
                                  echelle = "fisher.test")) %>%
  custom_format()
```


```{=html}
<div id="jicvshmabk" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#jicvshmabk table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#jicvshmabk thead, #jicvshmabk tbody, #jicvshmabk tfoot, #jicvshmabk tr, #jicvshmabk td, #jicvshmabk th {
  border-style: none;
}

#jicvshmabk p {
  margin: 0;
  padding: 0;
}

#jicvshmabk .gt_table {
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

#jicvshmabk .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#jicvshmabk .gt_title {
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

#jicvshmabk .gt_subtitle {
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

#jicvshmabk .gt_heading {
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

#jicvshmabk .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jicvshmabk .gt_col_headings {
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

#jicvshmabk .gt_col_heading {
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

#jicvshmabk .gt_column_spanner_outer {
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

#jicvshmabk .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#jicvshmabk .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#jicvshmabk .gt_column_spanner {
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

#jicvshmabk .gt_spanner_row {
  border-bottom-style: hidden;
}

#jicvshmabk .gt_group_heading {
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

#jicvshmabk .gt_empty_group_heading {
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

#jicvshmabk .gt_from_md > :first-child {
  margin-top: 0;
}

#jicvshmabk .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jicvshmabk .gt_row {
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

#jicvshmabk .gt_stub {
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

#jicvshmabk .gt_stub_row_group {
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

#jicvshmabk .gt_row_group_first td {
  border-top-width: 2px;
}

#jicvshmabk .gt_row_group_first th {
  border-top-width: 2px;
}

#jicvshmabk .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jicvshmabk .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#jicvshmabk .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#jicvshmabk .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jicvshmabk .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jicvshmabk .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#jicvshmabk .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#jicvshmabk .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#jicvshmabk .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jicvshmabk .gt_footnotes {
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

#jicvshmabk .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jicvshmabk .gt_sourcenotes {
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

#jicvshmabk .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jicvshmabk .gt_left {
  text-align: left;
}

#jicvshmabk .gt_center {
  text-align: center;
}

#jicvshmabk .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jicvshmabk .gt_font_normal {
  font-weight: normal;
}

#jicvshmabk .gt_font_bold {
  font-weight: bold;
}

#jicvshmabk .gt_font_italic {
  font-style: italic;
}

#jicvshmabk .gt_super {
  font-size: 65%;
}

#jicvshmabk .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#jicvshmabk .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#jicvshmabk .gt_indent_1 {
  text-indent: 5px;
}

#jicvshmabk .gt_indent_2 {
  text-indent: 10px;
}

#jicvshmabk .gt_indent_3 {
  text-indent: 15px;
}

#jicvshmabk .gt_indent_4 {
  text-indent: 20px;
}

#jicvshmabk .gt_indent_5 {
  text-indent: 25px;
}

#jicvshmabk .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#jicvshmabk div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="****">
        <div class="gt_column_spanner"><span class='gt_from_md'><hr />
</span></div>
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
<td headers="stat_1" class="gt_row gt_right" style="font-weight: bold;">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_right" style="font-weight: bold;">19 (2 ; 4%)</td>
<td headers="p.value" class="gt_row gt_center" style="font-weight: bold;">0.8<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_1" class="gt_row gt_right">51.0 (9.6)</td>
<td headers="stat_2" class="gt_row gt_right">50.2 (9.5)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_1" class="gt_row gt_right">51.3 (44.4 ; 57.0)</td>
<td headers="stat_2" class="gt_row gt_right">49.4 (43.1 ; 58.8)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_1" class="gt_row gt_right">30.3 ; 71.7</td>
<td headers="stat_2" class="gt_row gt_right">33.1 ; 67.9</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_right" style="font-weight: bold;">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_right" style="font-weight: bold;">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center" style="font-weight: bold;">0.11<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_1" class="gt_row gt_right">13 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_right">15 (71.4%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_1" class="gt_row gt_right">16 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_right">6 (28.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_right" style="font-weight: bold;">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_right" style="font-weight: bold;">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center" style="font-weight: bold;">0.3<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_1" class="gt_row gt_right">2 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_right">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_1" class="gt_row gt_right">18 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_right">10 (47.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_1" class="gt_row gt_right">9 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_right">6 (28.6%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    D</td>
<td headers="stat_1" class="gt_row gt_right">0 (0.0%)</td>
<td headers="stat_2" class="gt_row gt_right">0 (0.0%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_right" style="font-weight: bold;">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_right" style="font-weight: bold;">21 (0 ; 0%)</td>
<td headers="p.value" class="gt_row gt_center" style="font-weight: bold;">0.6<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_1" class="gt_row gt_right">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_right">7 (33.3%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_1" class="gt_row gt_right">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_right">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_1" class="gt_row gt_right">4 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_right">1 (4.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_1" class="gt_row gt_right">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_right">0 (0.0%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_1" class="gt_row gt_right">7 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_right">5 (23.8%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_1" class="gt_row gt_right">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_right">3 (14.3%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="4"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Welch Two Sample t-test</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="4"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span> <span class='gt_from_md'>Pearson’s Chi-squared test</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="4"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span> <span class='gt_from_md'>Fisher’s exact test</span></td>
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
                     group = TRUE,
                     var_group = "traitement",
                     round_quanti = 0,
                     round_quali = 0)

tb2 <- data %>%
  dplyr::select(quatre_modalites, traitement) %>%
  Descusmr::desc_var(table_title = "test",
                     group = TRUE,
                     var_group = "traitement",
                     round_quanti = 2,
                     round_quali = 2)

gtsummary::tbl_stack(list(tb1, tb2)) %>%
  custom_format()
```


```{=html}
<div id="zxlhpggazy" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#zxlhpggazy table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#zxlhpggazy thead, #zxlhpggazy tbody, #zxlhpggazy tfoot, #zxlhpggazy tr, #zxlhpggazy td, #zxlhpggazy th {
  border-style: none;
}

#zxlhpggazy p {
  margin: 0;
  padding: 0;
}

#zxlhpggazy .gt_table {
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

#zxlhpggazy .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#zxlhpggazy .gt_title {
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

#zxlhpggazy .gt_subtitle {
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

#zxlhpggazy .gt_heading {
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

#zxlhpggazy .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zxlhpggazy .gt_col_headings {
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

#zxlhpggazy .gt_col_heading {
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

#zxlhpggazy .gt_column_spanner_outer {
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

#zxlhpggazy .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#zxlhpggazy .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#zxlhpggazy .gt_column_spanner {
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

#zxlhpggazy .gt_spanner_row {
  border-bottom-style: hidden;
}

#zxlhpggazy .gt_group_heading {
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

#zxlhpggazy .gt_empty_group_heading {
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

#zxlhpggazy .gt_from_md > :first-child {
  margin-top: 0;
}

#zxlhpggazy .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zxlhpggazy .gt_row {
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

#zxlhpggazy .gt_stub {
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

#zxlhpggazy .gt_stub_row_group {
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

#zxlhpggazy .gt_row_group_first td {
  border-top-width: 2px;
}

#zxlhpggazy .gt_row_group_first th {
  border-top-width: 2px;
}

#zxlhpggazy .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zxlhpggazy .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#zxlhpggazy .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#zxlhpggazy .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zxlhpggazy .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zxlhpggazy .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#zxlhpggazy .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#zxlhpggazy .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#zxlhpggazy .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zxlhpggazy .gt_footnotes {
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

#zxlhpggazy .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#zxlhpggazy .gt_sourcenotes {
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

#zxlhpggazy .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#zxlhpggazy .gt_left {
  text-align: left;
}

#zxlhpggazy .gt_center {
  text-align: center;
}

#zxlhpggazy .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zxlhpggazy .gt_font_normal {
  font-weight: normal;
}

#zxlhpggazy .gt_font_bold {
  font-weight: bold;
}

#zxlhpggazy .gt_font_italic {
  font-style: italic;
}

#zxlhpggazy .gt_super {
  font-size: 65%;
}

#zxlhpggazy .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#zxlhpggazy .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#zxlhpggazy .gt_indent_1 {
  text-indent: 5px;
}

#zxlhpggazy .gt_indent_2 {
  text-indent: 10px;
}

#zxlhpggazy .gt_indent_3 {
  text-indent: 15px;
}

#zxlhpggazy .gt_indent_4 {
  text-indent: 20px;
}

#zxlhpggazy .gt_indent_5 {
  text-indent: 25px;
}

#zxlhpggazy .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#zxlhpggazy div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="****">
        <div class="gt_column_spanner"><span class='gt_from_md'><hr />
</span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_right" style="font-weight: bold;">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_right" style="font-weight: bold;">19 (2 ; 4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_1" class="gt_row gt_right">51 (10)</td>
<td headers="stat_2" class="gt_row gt_right">50 (10)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_1" class="gt_row gt_right">51 (44 ; 57)</td>
<td headers="stat_2" class="gt_row gt_right">49 (43 ; 59)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_1" class="gt_row gt_right">30 ; 72</td>
<td headers="stat_2" class="gt_row gt_right">33 ; 68</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_right" style="font-weight: bold;">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_right" style="font-weight: bold;">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_1" class="gt_row gt_right">13 (45%)</td>
<td headers="stat_2" class="gt_row gt_right">15 (71%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_1" class="gt_row gt_right">16 (55%)</td>
<td headers="stat_2" class="gt_row gt_right">6 (29%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux</td>
<td headers="stat_1" class="gt_row gt_right" style="font-weight: bold;">29</td>
<td headers="stat_2" class="gt_row gt_right" style="font-weight: bold;">21</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_1" class="gt_row gt_right">2.00 (6.90%)</td>
<td headers="stat_2" class="gt_row gt_right">5.00 (23.81%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_1" class="gt_row gt_right">18.00 (62.07%)</td>
<td headers="stat_2" class="gt_row gt_right">10.00 (47.62%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_1" class="gt_row gt_right">9.00 (31.03%)</td>
<td headers="stat_2" class="gt_row gt_right">6.00 (28.57%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    D</td>
<td headers="stat_1" class="gt_row gt_right">0.00 (0.00%)</td>
<td headers="stat_2" class="gt_row gt_right">0.00 (0.00%)</td></tr>
  </tbody>
  
  
</table>
</div>
```


You can customize the format by specifying the column size and the alignment.


``` r
data %>%
  Descusmr::desc_var(table_title = "test",
                     group = TRUE,
                     var_group = "traitement") %>%
  custom_format(align = "left",
                column_size = list(label ~ gt::pct(50),
                                   gt::starts_with("stat") ~ gt::pct(25)))
```


```{=html}
<div id="vzmdowysml" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#vzmdowysml table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#vzmdowysml thead, #vzmdowysml tbody, #vzmdowysml tfoot, #vzmdowysml tr, #vzmdowysml td, #vzmdowysml th {
  border-style: none;
}

#vzmdowysml p {
  margin: 0;
  padding: 0;
}

#vzmdowysml .gt_table {
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

#vzmdowysml .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#vzmdowysml .gt_title {
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

#vzmdowysml .gt_subtitle {
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

#vzmdowysml .gt_heading {
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

#vzmdowysml .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vzmdowysml .gt_col_headings {
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

#vzmdowysml .gt_col_heading {
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

#vzmdowysml .gt_column_spanner_outer {
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

#vzmdowysml .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#vzmdowysml .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#vzmdowysml .gt_column_spanner {
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

#vzmdowysml .gt_spanner_row {
  border-bottom-style: hidden;
}

#vzmdowysml .gt_group_heading {
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

#vzmdowysml .gt_empty_group_heading {
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

#vzmdowysml .gt_from_md > :first-child {
  margin-top: 0;
}

#vzmdowysml .gt_from_md > :last-child {
  margin-bottom: 0;
}

#vzmdowysml .gt_row {
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

#vzmdowysml .gt_stub {
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

#vzmdowysml .gt_stub_row_group {
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

#vzmdowysml .gt_row_group_first td {
  border-top-width: 2px;
}

#vzmdowysml .gt_row_group_first th {
  border-top-width: 2px;
}

#vzmdowysml .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vzmdowysml .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#vzmdowysml .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#vzmdowysml .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vzmdowysml .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vzmdowysml .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#vzmdowysml .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#vzmdowysml .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#vzmdowysml .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vzmdowysml .gt_footnotes {
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

#vzmdowysml .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vzmdowysml .gt_sourcenotes {
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

#vzmdowysml .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vzmdowysml .gt_left {
  text-align: left;
}

#vzmdowysml .gt_center {
  text-align: center;
}

#vzmdowysml .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#vzmdowysml .gt_font_normal {
  font-weight: normal;
}

#vzmdowysml .gt_font_bold {
  font-weight: bold;
}

#vzmdowysml .gt_font_italic {
  font-style: italic;
}

#vzmdowysml .gt_super {
  font-size: 65%;
}

#vzmdowysml .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#vzmdowysml .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#vzmdowysml .gt_indent_1 {
  text-indent: 5px;
}

#vzmdowysml .gt_indent_2 {
  text-indent: 10px;
}

#vzmdowysml .gt_indent_3 {
  text-indent: 15px;
}

#vzmdowysml .gt_indent_4 {
  text-indent: 20px;
}

#vzmdowysml .gt_indent_5 {
  text-indent: 25px;
}

#vzmdowysml .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#vzmdowysml div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" style="table-layout:fixed;width:100%;" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <caption><span class='gt_from_md'><strong>test</strong></span></caption>
  <colgroup>
    <col style="width:50%;"/>
    <col style="width:25%;"/>
    <col style="width:25%;"/>
  </colgroup>
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="****">
        <div class="gt_column_spanner"><span class='gt_from_md'><hr />
</span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>BRAS-A</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>BRAS-B</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_left" style="font-weight: bold;">26 (3 ; 6%)</td>
<td headers="stat_2" class="gt_row gt_left" style="font-weight: bold;">19 (2 ; 4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Mean (SD)</td>
<td headers="stat_1" class="gt_row gt_left">51.0 (9.6)</td>
<td headers="stat_2" class="gt_row gt_left">50.2 (9.5)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Median (Q1 ; Q3)</td>
<td headers="stat_1" class="gt_row gt_left">51.3 (44.4 ; 57.0)</td>
<td headers="stat_2" class="gt_row gt_left">49.4 (43.1 ; 58.8)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Min ; Max</td>
<td headers="stat_1" class="gt_row gt_left">30.3 ; 71.7</td>
<td headers="stat_2" class="gt_row gt_left">33.1 ; 67.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">sexe n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_left" style="font-weight: bold;">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_left" style="font-weight: bold;">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Femme</td>
<td headers="stat_1" class="gt_row gt_left">13 (44.8%)</td>
<td headers="stat_2" class="gt_row gt_left">15 (71.4%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Homme</td>
<td headers="stat_1" class="gt_row gt_left">16 (55.2%)</td>
<td headers="stat_2" class="gt_row gt_left">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">quatres niveaux n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_left" style="font-weight: bold;">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_left" style="font-weight: bold;">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A</td>
<td headers="stat_1" class="gt_row gt_left">2 (6.9%)</td>
<td headers="stat_2" class="gt_row gt_left">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    B</td>
<td headers="stat_1" class="gt_row gt_left">18 (62.1%)</td>
<td headers="stat_2" class="gt_row gt_left">10 (47.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    C</td>
<td headers="stat_1" class="gt_row gt_left">9 (31.0%)</td>
<td headers="stat_2" class="gt_row gt_left">6 (28.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    D</td>
<td headers="stat_1" class="gt_row gt_left">0 (0.0%)</td>
<td headers="stat_2" class="gt_row gt_left">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Echelle n (dm ; %dm)</td>
<td headers="stat_1" class="gt_row gt_left" style="font-weight: bold;">29 (0 ; 0%)</td>
<td headers="stat_2" class="gt_row gt_left" style="font-weight: bold;">21 (0 ; 0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_1" class="gt_row gt_left">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_left">7 (33.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_1" class="gt_row gt_left">6 (20.7%)</td>
<td headers="stat_2" class="gt_row gt_left">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2</td>
<td headers="stat_1" class="gt_row gt_left">4 (13.8%)</td>
<td headers="stat_2" class="gt_row gt_left">1 (4.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3</td>
<td headers="stat_1" class="gt_row gt_left">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_left">0 (0.0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4</td>
<td headers="stat_1" class="gt_row gt_left">7 (24.1%)</td>
<td headers="stat_2" class="gt_row gt_left">5 (23.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    5</td>
<td headers="stat_1" class="gt_row gt_left">3 (10.3%)</td>
<td headers="stat_2" class="gt_row gt_left">3 (14.3%)</td></tr>
  </tbody>
  
  
</table>
</div>
```


