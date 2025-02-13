---
title: "DescribeAE"
date: "2025-02-13"
output:
  html_vignette:
    toc: true
    toc_depth: 2
    keep_md: true
vignette: >
  %\VignetteIndexEntry{DescribeAE}
  %\VignetteEncoding{UTF-8}
  %\VignetteEngine{knitr::rmarkdown}
---




``` r
library(Descusmr)
```

# Introduction

Adverse events (AE) are a crucial aspect of clinical trials, providing insight into the safety profile of treatments. The `DescribeAE` package provides functions to summarize and visualize adverse events by different criteria such as **System Organ Class (SOC)**, **Preferred Term (PT)**, and **Grade**.

This vignette demonstrates how to use two core functions:

- `desc_ei_per_soc()`: Summarizes adverse events by **System Organ Class (SOC)** and **Preferred Term (PT)**.
- `desc_ei_per_grade()`: Summarizes adverse events by **grade**, which represents severity.

These functions generate tables that help interpret the distribution of adverse events across different treatment arms in a randomized controlled trial (RCT).

# Toy dataset

Before using these functions, we need to create a toy datasets. Below is an example of how to structure the data.

## Defining the System Organ Class (SOC) and Preferred Term (PT)


``` r
df_soc_pt <- data.frame(
  soc = c("Arrhythmia", "Myocardial Infarction", "Pneumonia", "Sepsis"),
  pt = c("Cardiac Disorders", "Cardiac Disorders", "Infections", "Infections")
)
```

## Assigning Patients to Treatment Arms


``` r
df_pat_grp <- data.frame(
  id_pat = paste0("ID_", 1:10),
  grp = c(rep("A", 3), rep("B", 3), rep("C", 4))
)
```

## Recording Adverse Events by SOC and Grade


``` r
df_pat_soc_grade <- data.frame(
  id_pat = c("ID_1", "ID_1", "ID_2", "ID_4", "ID_9"),
  soc = c("Arrhythmia", "Myocardial Infarction", "Arrhythmia", "Pneumonia", "Pneumonia"),
  grade = c(1, 3, 4, 2, 4)
)
```


# Summarizing Adverse Events

## Describing Adverse Events by System Organ Class

To analyze adverse events based on their **System Organ Class (SOC)** and **Preferred Term (PT)**, use the `desc_ei_per_soc()` function:


``` r
desc_ei_per_soc(df_soc_pt = df_soc_pt,
                df_pat_grp = df_pat_grp,
                df_pat_soc = df_pat_soc_grade)
```


```{=html}
<div id="nrgyeyeels" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#nrgyeyeels table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#nrgyeyeels thead, #nrgyeyeels tbody, #nrgyeyeels tfoot, #nrgyeyeels tr, #nrgyeyeels td, #nrgyeyeels th {
  border-style: none;
}

#nrgyeyeels p {
  margin: 0;
  padding: 0;
}

#nrgyeyeels .gt_table {
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

#nrgyeyeels .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#nrgyeyeels .gt_title {
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

#nrgyeyeels .gt_subtitle {
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

#nrgyeyeels .gt_heading {
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

#nrgyeyeels .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nrgyeyeels .gt_col_headings {
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

#nrgyeyeels .gt_col_heading {
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

#nrgyeyeels .gt_column_spanner_outer {
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

#nrgyeyeels .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#nrgyeyeels .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#nrgyeyeels .gt_column_spanner {
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

#nrgyeyeels .gt_spanner_row {
  border-bottom-style: hidden;
}

#nrgyeyeels .gt_group_heading {
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

#nrgyeyeels .gt_empty_group_heading {
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

#nrgyeyeels .gt_from_md > :first-child {
  margin-top: 0;
}

#nrgyeyeels .gt_from_md > :last-child {
  margin-bottom: 0;
}

#nrgyeyeels .gt_row {
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

#nrgyeyeels .gt_stub {
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

#nrgyeyeels .gt_stub_row_group {
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

#nrgyeyeels .gt_row_group_first td {
  border-top-width: 2px;
}

#nrgyeyeels .gt_row_group_first th {
  border-top-width: 2px;
}

#nrgyeyeels .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nrgyeyeels .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#nrgyeyeels .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#nrgyeyeels .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nrgyeyeels .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nrgyeyeels .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#nrgyeyeels .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#nrgyeyeels .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#nrgyeyeels .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nrgyeyeels .gt_footnotes {
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

#nrgyeyeels .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nrgyeyeels .gt_sourcenotes {
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

#nrgyeyeels .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nrgyeyeels .gt_left {
  text-align: left;
}

#nrgyeyeels .gt_center {
  text-align: center;
}

#nrgyeyeels .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#nrgyeyeels .gt_font_normal {
  font-weight: normal;
}

#nrgyeyeels .gt_font_bold {
  font-weight: bold;
}

#nrgyeyeels .gt_font_italic {
  font-style: italic;
}

#nrgyeyeels .gt_super {
  font-size: 65%;
}

#nrgyeyeels .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#nrgyeyeels .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#nrgyeyeels .gt_indent_1 {
  text-indent: 5px;
}

#nrgyeyeels .gt_indent_2 {
  text-indent: 10px;
}

#nrgyeyeels .gt_indent_3 {
  text-indent: 15px;
}

#nrgyeyeels .gt_indent_4 {
  text-indent: 20px;
}

#nrgyeyeels .gt_indent_5 {
  text-indent: 25px;
}

#nrgyeyeels .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#nrgyeyeels div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="1" scope="col"></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="4" scope="colgroup" id="over_Total">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Total</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="4" scope="colgroup" id="over_A">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>A</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="4" scope="colgroup" id="over_B">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>B</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="4" scope="colgroup" id="over_C">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>C</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="soc"><span class='gt_from_md'><strong>Evénements indésirables</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="EI_Total">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>EI</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="Patients_Total">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Patients</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="EI_A">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>EI</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="Patients_A">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Patients</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="EI_B">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>EI</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="Patients_B">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Patients</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="EI_C">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>EI</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="Patients_C">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Patients</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_nb_ei"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_pct_ei"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_nb_pat"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_pct_pat"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="A_nb_ei"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="A_pct_ei"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="A_nb_pat"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="A_pct_pat"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="B_nb_ei"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="B_pct_ei"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="B_nb_pat"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="B_pct_pat"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="C_nb_ei"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="C_pct_ei"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="C_nb_pat"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="C_pct_pat"><span class='gt_from_md'><strong>%</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr class="gt_group_heading_row">
      <th colspan="17" class="gt_group_heading" style="background-color: #E6E6E6; font-weight: bold;" scope="colgroup" id="Total">Total</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Total  soc" class="gt_row gt_left" style="background-color: #C8F3FF;">Total</td>
<td headers="Total  Total_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">5</td>
<td headers="Total  Total_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">100</td>
<td headers="Total  Total_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">4</td>
<td headers="Total  Total_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">40</td>
<td headers="Total  A_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">3</td>
<td headers="Total  A_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">100</td>
<td headers="Total  A_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">2</td>
<td headers="Total  A_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">67</td>
<td headers="Total  B_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">1</td>
<td headers="Total  B_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">100</td>
<td headers="Total  B_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">1</td>
<td headers="Total  B_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">33</td>
<td headers="Total  C_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">1</td>
<td headers="Total  C_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">100</td>
<td headers="Total  C_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">1</td>
<td headers="Total  C_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">25</td></tr>
    <tr class="gt_group_heading_row">
      <th colspan="17" class="gt_group_heading" style="background-color: #E6E6E6; font-weight: bold;" scope="colgroup" id="Cardiac Disorders">Cardiac Disorders</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Cardiac Disorders  soc" class="gt_row gt_left" style="background-color: #C8F3FF;">Total</td>
<td headers="Cardiac Disorders  Total_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">3</td>
<td headers="Cardiac Disorders  Total_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">60</td>
<td headers="Cardiac Disorders  Total_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">2</td>
<td headers="Cardiac Disorders  Total_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">20</td>
<td headers="Cardiac Disorders  A_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">3</td>
<td headers="Cardiac Disorders  A_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">100</td>
<td headers="Cardiac Disorders  A_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">2</td>
<td headers="Cardiac Disorders  A_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">67</td>
<td headers="Cardiac Disorders  B_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;"><br /></td>
<td headers="Cardiac Disorders  B_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;"><br /></td>
<td headers="Cardiac Disorders  B_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;"><br /></td>
<td headers="Cardiac Disorders  B_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;"><br /></td>
<td headers="Cardiac Disorders  C_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;"><br /></td>
<td headers="Cardiac Disorders  C_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;"><br /></td>
<td headers="Cardiac Disorders  C_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;"><br /></td>
<td headers="Cardiac Disorders  C_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;"><br /></td></tr>
    <tr><td headers="Cardiac Disorders  soc" class="gt_row gt_left">Arrhythmia</td>
<td headers="Cardiac Disorders  Total_nb_ei" class="gt_row gt_left">2</td>
<td headers="Cardiac Disorders  Total_pct_ei" class="gt_row gt_left">40</td>
<td headers="Cardiac Disorders  Total_nb_pat" class="gt_row gt_left">2</td>
<td headers="Cardiac Disorders  Total_pct_pat" class="gt_row gt_left">20</td>
<td headers="Cardiac Disorders  A_nb_ei" class="gt_row gt_left">2</td>
<td headers="Cardiac Disorders  A_pct_ei" class="gt_row gt_left">67</td>
<td headers="Cardiac Disorders  A_nb_pat" class="gt_row gt_left">2</td>
<td headers="Cardiac Disorders  A_pct_pat" class="gt_row gt_left">67</td>
<td headers="Cardiac Disorders  B_nb_ei" class="gt_row gt_left"><br /></td>
<td headers="Cardiac Disorders  B_pct_ei" class="gt_row gt_left"><br /></td>
<td headers="Cardiac Disorders  B_nb_pat" class="gt_row gt_left"><br /></td>
<td headers="Cardiac Disorders  B_pct_pat" class="gt_row gt_left"><br /></td>
<td headers="Cardiac Disorders  C_nb_ei" class="gt_row gt_left"><br /></td>
<td headers="Cardiac Disorders  C_pct_ei" class="gt_row gt_left"><br /></td>
<td headers="Cardiac Disorders  C_nb_pat" class="gt_row gt_left"><br /></td>
<td headers="Cardiac Disorders  C_pct_pat" class="gt_row gt_left"><br /></td></tr>
    <tr><td headers="Cardiac Disorders  soc" class="gt_row gt_left">Myocardial Infarction</td>
<td headers="Cardiac Disorders  Total_nb_ei" class="gt_row gt_left">1</td>
<td headers="Cardiac Disorders  Total_pct_ei" class="gt_row gt_left">20</td>
<td headers="Cardiac Disorders  Total_nb_pat" class="gt_row gt_left">1</td>
<td headers="Cardiac Disorders  Total_pct_pat" class="gt_row gt_left">10</td>
<td headers="Cardiac Disorders  A_nb_ei" class="gt_row gt_left">1</td>
<td headers="Cardiac Disorders  A_pct_ei" class="gt_row gt_left">33</td>
<td headers="Cardiac Disorders  A_nb_pat" class="gt_row gt_left">1</td>
<td headers="Cardiac Disorders  A_pct_pat" class="gt_row gt_left">33</td>
<td headers="Cardiac Disorders  B_nb_ei" class="gt_row gt_left"><br /></td>
<td headers="Cardiac Disorders  B_pct_ei" class="gt_row gt_left"><br /></td>
<td headers="Cardiac Disorders  B_nb_pat" class="gt_row gt_left"><br /></td>
<td headers="Cardiac Disorders  B_pct_pat" class="gt_row gt_left"><br /></td>
<td headers="Cardiac Disorders  C_nb_ei" class="gt_row gt_left"><br /></td>
<td headers="Cardiac Disorders  C_pct_ei" class="gt_row gt_left"><br /></td>
<td headers="Cardiac Disorders  C_nb_pat" class="gt_row gt_left"><br /></td>
<td headers="Cardiac Disorders  C_pct_pat" class="gt_row gt_left"><br /></td></tr>
    <tr class="gt_group_heading_row">
      <th colspan="17" class="gt_group_heading" style="background-color: #E6E6E6; font-weight: bold;" scope="colgroup" id="Infections">Infections</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Infections  soc" class="gt_row gt_left" style="background-color: #C8F3FF;">Total</td>
<td headers="Infections  Total_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">2</td>
<td headers="Infections  Total_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">40</td>
<td headers="Infections  Total_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">2</td>
<td headers="Infections  Total_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">20</td>
<td headers="Infections  A_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;"><br /></td>
<td headers="Infections  A_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;"><br /></td>
<td headers="Infections  A_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;"><br /></td>
<td headers="Infections  A_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;"><br /></td>
<td headers="Infections  B_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">1</td>
<td headers="Infections  B_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">100</td>
<td headers="Infections  B_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">1</td>
<td headers="Infections  B_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">33</td>
<td headers="Infections  C_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">1</td>
<td headers="Infections  C_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">100</td>
<td headers="Infections  C_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">1</td>
<td headers="Infections  C_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">25</td></tr>
    <tr><td headers="Infections  soc" class="gt_row gt_left">Pneumonia</td>
<td headers="Infections  Total_nb_ei" class="gt_row gt_left">2</td>
<td headers="Infections  Total_pct_ei" class="gt_row gt_left">40</td>
<td headers="Infections  Total_nb_pat" class="gt_row gt_left">2</td>
<td headers="Infections  Total_pct_pat" class="gt_row gt_left">20</td>
<td headers="Infections  A_nb_ei" class="gt_row gt_left"><br /></td>
<td headers="Infections  A_pct_ei" class="gt_row gt_left"><br /></td>
<td headers="Infections  A_nb_pat" class="gt_row gt_left"><br /></td>
<td headers="Infections  A_pct_pat" class="gt_row gt_left"><br /></td>
<td headers="Infections  B_nb_ei" class="gt_row gt_left">1</td>
<td headers="Infections  B_pct_ei" class="gt_row gt_left">100</td>
<td headers="Infections  B_nb_pat" class="gt_row gt_left">1</td>
<td headers="Infections  B_pct_pat" class="gt_row gt_left">33</td>
<td headers="Infections  C_nb_ei" class="gt_row gt_left">1</td>
<td headers="Infections  C_pct_ei" class="gt_row gt_left">100</td>
<td headers="Infections  C_nb_pat" class="gt_row gt_left">1</td>
<td headers="Infections  C_pct_pat" class="gt_row gt_left">25</td></tr>
  </tbody>
  
  
</table>
</div>
```


### Interpretation:

This table shows how frequently different types of adverse events occur within each treatment arm. It helps in identifying which organ systems are most affected and whether certain treatment groups have higher rates of specific adverse events.


## Describing Adverse Events by Grade

To assess the severity of adverse events across treatment arms, use `desc_ei_per_grade()`:


``` r
desc_ei_per_grade(df_pat_grp = df_pat_grp,
                  df_pat_grade = df_pat_soc_grade)
```


```{=html}
<div id="qgtqzrixjh" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#qgtqzrixjh table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#qgtqzrixjh thead, #qgtqzrixjh tbody, #qgtqzrixjh tfoot, #qgtqzrixjh tr, #qgtqzrixjh td, #qgtqzrixjh th {
  border-style: none;
}

#qgtqzrixjh p {
  margin: 0;
  padding: 0;
}

#qgtqzrixjh .gt_table {
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

#qgtqzrixjh .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#qgtqzrixjh .gt_title {
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

#qgtqzrixjh .gt_subtitle {
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

#qgtqzrixjh .gt_heading {
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

#qgtqzrixjh .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qgtqzrixjh .gt_col_headings {
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

#qgtqzrixjh .gt_col_heading {
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

#qgtqzrixjh .gt_column_spanner_outer {
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

#qgtqzrixjh .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#qgtqzrixjh .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#qgtqzrixjh .gt_column_spanner {
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

#qgtqzrixjh .gt_spanner_row {
  border-bottom-style: hidden;
}

#qgtqzrixjh .gt_group_heading {
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

#qgtqzrixjh .gt_empty_group_heading {
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

#qgtqzrixjh .gt_from_md > :first-child {
  margin-top: 0;
}

#qgtqzrixjh .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qgtqzrixjh .gt_row {
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

#qgtqzrixjh .gt_stub {
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

#qgtqzrixjh .gt_stub_row_group {
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

#qgtqzrixjh .gt_row_group_first td {
  border-top-width: 2px;
}

#qgtqzrixjh .gt_row_group_first th {
  border-top-width: 2px;
}

#qgtqzrixjh .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qgtqzrixjh .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#qgtqzrixjh .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#qgtqzrixjh .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qgtqzrixjh .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qgtqzrixjh .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#qgtqzrixjh .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#qgtqzrixjh .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#qgtqzrixjh .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qgtqzrixjh .gt_footnotes {
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

#qgtqzrixjh .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#qgtqzrixjh .gt_sourcenotes {
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

#qgtqzrixjh .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#qgtqzrixjh .gt_left {
  text-align: left;
}

#qgtqzrixjh .gt_center {
  text-align: center;
}

#qgtqzrixjh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#qgtqzrixjh .gt_font_normal {
  font-weight: normal;
}

#qgtqzrixjh .gt_font_bold {
  font-weight: bold;
}

#qgtqzrixjh .gt_font_italic {
  font-style: italic;
}

#qgtqzrixjh .gt_super {
  font-size: 65%;
}

#qgtqzrixjh .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#qgtqzrixjh .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#qgtqzrixjh .gt_indent_1 {
  text-indent: 5px;
}

#qgtqzrixjh .gt_indent_2 {
  text-indent: 10px;
}

#qgtqzrixjh .gt_indent_3 {
  text-indent: 15px;
}

#qgtqzrixjh .gt_indent_4 {
  text-indent: 20px;
}

#qgtqzrixjh .gt_indent_5 {
  text-indent: 25px;
}

#qgtqzrixjh .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#qgtqzrixjh div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="1" scope="col"></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="4" scope="colgroup" id="over_Total">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Total</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="4" scope="colgroup" id="over_A">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>A</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="4" scope="colgroup" id="over_B">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>B</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="4" scope="colgroup" id="over_C">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>C</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="grade"><span class='gt_from_md'><strong>Grade</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="EI_Total">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>EI</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="Patients_Total">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Patients</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="EI_A">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>EI</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="Patients_A">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Patients</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="EI_B">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>EI</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="Patients_B">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Patients</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="EI_C">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>EI</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="Patients_C">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Patients</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_nb_ei"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_pct_ei"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_nb_pat"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_pct_pat"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="A_nb_ei"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="A_pct_ei"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="A_nb_pat"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="A_pct_pat"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="B_nb_ei"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="B_pct_ei"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="B_nb_pat"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="B_pct_pat"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="C_nb_ei"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="C_pct_ei"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="C_nb_pat"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="C_pct_pat"><span class='gt_from_md'><strong>%</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="grade" class="gt_row gt_left" style="background-color: #C8F3FF;">Total</td>
<td headers="Total_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">5</td>
<td headers="Total_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">100</td>
<td headers="Total_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">4</td>
<td headers="Total_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">40</td>
<td headers="A_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">3</td>
<td headers="A_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">100</td>
<td headers="A_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">2</td>
<td headers="A_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">67</td>
<td headers="B_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">1</td>
<td headers="B_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">100</td>
<td headers="B_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">1</td>
<td headers="B_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">33</td>
<td headers="C_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">1</td>
<td headers="C_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">100</td>
<td headers="C_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">1</td>
<td headers="C_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">25</td></tr>
    <tr><td headers="grade" class="gt_row gt_left">1</td>
<td headers="Total_nb_ei" class="gt_row gt_left">1</td>
<td headers="Total_pct_ei" class="gt_row gt_left">20</td>
<td headers="Total_nb_pat" class="gt_row gt_left">1</td>
<td headers="Total_pct_pat" class="gt_row gt_left">10</td>
<td headers="A_nb_ei" class="gt_row gt_left">1</td>
<td headers="A_pct_ei" class="gt_row gt_left">33</td>
<td headers="A_nb_pat" class="gt_row gt_left">1</td>
<td headers="A_pct_pat" class="gt_row gt_left">33</td>
<td headers="B_nb_ei" class="gt_row gt_left"><br /></td>
<td headers="B_pct_ei" class="gt_row gt_left"><br /></td>
<td headers="B_nb_pat" class="gt_row gt_left"><br /></td>
<td headers="B_pct_pat" class="gt_row gt_left"><br /></td>
<td headers="C_nb_ei" class="gt_row gt_left"><br /></td>
<td headers="C_pct_ei" class="gt_row gt_left"><br /></td>
<td headers="C_nb_pat" class="gt_row gt_left"><br /></td>
<td headers="C_pct_pat" class="gt_row gt_left"><br /></td></tr>
    <tr><td headers="grade" class="gt_row gt_left">2</td>
<td headers="Total_nb_ei" class="gt_row gt_left">1</td>
<td headers="Total_pct_ei" class="gt_row gt_left">20</td>
<td headers="Total_nb_pat" class="gt_row gt_left">1</td>
<td headers="Total_pct_pat" class="gt_row gt_left">10</td>
<td headers="A_nb_ei" class="gt_row gt_left"><br /></td>
<td headers="A_pct_ei" class="gt_row gt_left"><br /></td>
<td headers="A_nb_pat" class="gt_row gt_left"><br /></td>
<td headers="A_pct_pat" class="gt_row gt_left"><br /></td>
<td headers="B_nb_ei" class="gt_row gt_left">1</td>
<td headers="B_pct_ei" class="gt_row gt_left">100</td>
<td headers="B_nb_pat" class="gt_row gt_left">1</td>
<td headers="B_pct_pat" class="gt_row gt_left">33</td>
<td headers="C_nb_ei" class="gt_row gt_left"><br /></td>
<td headers="C_pct_ei" class="gt_row gt_left"><br /></td>
<td headers="C_nb_pat" class="gt_row gt_left"><br /></td>
<td headers="C_pct_pat" class="gt_row gt_left"><br /></td></tr>
    <tr><td headers="grade" class="gt_row gt_left">3</td>
<td headers="Total_nb_ei" class="gt_row gt_left">1</td>
<td headers="Total_pct_ei" class="gt_row gt_left">20</td>
<td headers="Total_nb_pat" class="gt_row gt_left">1</td>
<td headers="Total_pct_pat" class="gt_row gt_left">10</td>
<td headers="A_nb_ei" class="gt_row gt_left">1</td>
<td headers="A_pct_ei" class="gt_row gt_left">33</td>
<td headers="A_nb_pat" class="gt_row gt_left">1</td>
<td headers="A_pct_pat" class="gt_row gt_left">33</td>
<td headers="B_nb_ei" class="gt_row gt_left"><br /></td>
<td headers="B_pct_ei" class="gt_row gt_left"><br /></td>
<td headers="B_nb_pat" class="gt_row gt_left"><br /></td>
<td headers="B_pct_pat" class="gt_row gt_left"><br /></td>
<td headers="C_nb_ei" class="gt_row gt_left"><br /></td>
<td headers="C_pct_ei" class="gt_row gt_left"><br /></td>
<td headers="C_nb_pat" class="gt_row gt_left"><br /></td>
<td headers="C_pct_pat" class="gt_row gt_left"><br /></td></tr>
    <tr><td headers="grade" class="gt_row gt_left">4</td>
<td headers="Total_nb_ei" class="gt_row gt_left">2</td>
<td headers="Total_pct_ei" class="gt_row gt_left">40</td>
<td headers="Total_nb_pat" class="gt_row gt_left">2</td>
<td headers="Total_pct_pat" class="gt_row gt_left">20</td>
<td headers="A_nb_ei" class="gt_row gt_left">1</td>
<td headers="A_pct_ei" class="gt_row gt_left">33</td>
<td headers="A_nb_pat" class="gt_row gt_left">1</td>
<td headers="A_pct_pat" class="gt_row gt_left">33</td>
<td headers="B_nb_ei" class="gt_row gt_left"><br /></td>
<td headers="B_pct_ei" class="gt_row gt_left"><br /></td>
<td headers="B_nb_pat" class="gt_row gt_left"><br /></td>
<td headers="B_pct_pat" class="gt_row gt_left"><br /></td>
<td headers="C_nb_ei" class="gt_row gt_left">1</td>
<td headers="C_pct_ei" class="gt_row gt_left">100</td>
<td headers="C_nb_pat" class="gt_row gt_left">1</td>
<td headers="C_pct_pat" class="gt_row gt_left">25</td></tr>
  </tbody>
  
  
</table>
</div>
```


### Interpretation:

This table summarizes the distribution of adverse event grades (severity levels) per treatment group. It helps in understanding whether a treatment is associated with more severe adverse events compared to others.


# What if you have only one group ?

In that case the table `df_pat_grp` must still be provided with grp set to "Total" (or any other string)


``` r
desc_ei_per_soc(df_soc_pt = df_soc_pt,
                df_pat_grp = df_pat_grp |> dplyr::mutate(grp = "A"),
                df_pat_soc = df_pat_soc_grade)
```


```{=html}
<div id="tfyclanlwz" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#tfyclanlwz table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#tfyclanlwz thead, #tfyclanlwz tbody, #tfyclanlwz tfoot, #tfyclanlwz tr, #tfyclanlwz td, #tfyclanlwz th {
  border-style: none;
}

#tfyclanlwz p {
  margin: 0;
  padding: 0;
}

#tfyclanlwz .gt_table {
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

#tfyclanlwz .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#tfyclanlwz .gt_title {
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

#tfyclanlwz .gt_subtitle {
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

#tfyclanlwz .gt_heading {
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

#tfyclanlwz .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tfyclanlwz .gt_col_headings {
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

#tfyclanlwz .gt_col_heading {
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

#tfyclanlwz .gt_column_spanner_outer {
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

#tfyclanlwz .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#tfyclanlwz .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#tfyclanlwz .gt_column_spanner {
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

#tfyclanlwz .gt_spanner_row {
  border-bottom-style: hidden;
}

#tfyclanlwz .gt_group_heading {
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

#tfyclanlwz .gt_empty_group_heading {
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

#tfyclanlwz .gt_from_md > :first-child {
  margin-top: 0;
}

#tfyclanlwz .gt_from_md > :last-child {
  margin-bottom: 0;
}

#tfyclanlwz .gt_row {
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

#tfyclanlwz .gt_stub {
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

#tfyclanlwz .gt_stub_row_group {
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

#tfyclanlwz .gt_row_group_first td {
  border-top-width: 2px;
}

#tfyclanlwz .gt_row_group_first th {
  border-top-width: 2px;
}

#tfyclanlwz .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tfyclanlwz .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#tfyclanlwz .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#tfyclanlwz .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tfyclanlwz .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tfyclanlwz .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#tfyclanlwz .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#tfyclanlwz .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#tfyclanlwz .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tfyclanlwz .gt_footnotes {
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

#tfyclanlwz .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#tfyclanlwz .gt_sourcenotes {
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

#tfyclanlwz .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#tfyclanlwz .gt_left {
  text-align: left;
}

#tfyclanlwz .gt_center {
  text-align: center;
}

#tfyclanlwz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#tfyclanlwz .gt_font_normal {
  font-weight: normal;
}

#tfyclanlwz .gt_font_bold {
  font-weight: bold;
}

#tfyclanlwz .gt_font_italic {
  font-style: italic;
}

#tfyclanlwz .gt_super {
  font-size: 65%;
}

#tfyclanlwz .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#tfyclanlwz .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#tfyclanlwz .gt_indent_1 {
  text-indent: 5px;
}

#tfyclanlwz .gt_indent_2 {
  text-indent: 10px;
}

#tfyclanlwz .gt_indent_3 {
  text-indent: 15px;
}

#tfyclanlwz .gt_indent_4 {
  text-indent: 20px;
}

#tfyclanlwz .gt_indent_5 {
  text-indent: 25px;
}

#tfyclanlwz .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#tfyclanlwz div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="1" scope="col"></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="4" scope="colgroup" id="over_Total">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Total</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="soc"><span class='gt_from_md'><strong>Evénements indésirables</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="EI_Total">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>EI</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="Patients_Total">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Patients</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_nb_ei"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_pct_ei"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_nb_pat"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_pct_pat"><span class='gt_from_md'><strong>%</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr class="gt_group_heading_row">
      <th colspan="5" class="gt_group_heading" style="background-color: #E6E6E6; font-weight: bold;" scope="colgroup" id="Total">Total</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Total  soc" class="gt_row gt_left" style="background-color: #C8F3FF;">Total</td>
<td headers="Total  Total_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">5</td>
<td headers="Total  Total_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">100</td>
<td headers="Total  Total_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">4</td>
<td headers="Total  Total_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">40</td></tr>
    <tr class="gt_group_heading_row">
      <th colspan="5" class="gt_group_heading" style="background-color: #E6E6E6; font-weight: bold;" scope="colgroup" id="Cardiac Disorders">Cardiac Disorders</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Cardiac Disorders  soc" class="gt_row gt_left" style="background-color: #C8F3FF;">Total</td>
<td headers="Cardiac Disorders  Total_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">3</td>
<td headers="Cardiac Disorders  Total_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">60</td>
<td headers="Cardiac Disorders  Total_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">2</td>
<td headers="Cardiac Disorders  Total_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">20</td></tr>
    <tr><td headers="Cardiac Disorders  soc" class="gt_row gt_left">Arrhythmia</td>
<td headers="Cardiac Disorders  Total_nb_ei" class="gt_row gt_left">2</td>
<td headers="Cardiac Disorders  Total_pct_ei" class="gt_row gt_left">40</td>
<td headers="Cardiac Disorders  Total_nb_pat" class="gt_row gt_left">2</td>
<td headers="Cardiac Disorders  Total_pct_pat" class="gt_row gt_left">20</td></tr>
    <tr><td headers="Cardiac Disorders  soc" class="gt_row gt_left">Myocardial Infarction</td>
<td headers="Cardiac Disorders  Total_nb_ei" class="gt_row gt_left">1</td>
<td headers="Cardiac Disorders  Total_pct_ei" class="gt_row gt_left">20</td>
<td headers="Cardiac Disorders  Total_nb_pat" class="gt_row gt_left">1</td>
<td headers="Cardiac Disorders  Total_pct_pat" class="gt_row gt_left">10</td></tr>
    <tr class="gt_group_heading_row">
      <th colspan="5" class="gt_group_heading" style="background-color: #E6E6E6; font-weight: bold;" scope="colgroup" id="Infections">Infections</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Infections  soc" class="gt_row gt_left" style="background-color: #C8F3FF;">Total</td>
<td headers="Infections  Total_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">2</td>
<td headers="Infections  Total_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">40</td>
<td headers="Infections  Total_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">2</td>
<td headers="Infections  Total_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">20</td></tr>
    <tr><td headers="Infections  soc" class="gt_row gt_left">Pneumonia</td>
<td headers="Infections  Total_nb_ei" class="gt_row gt_left">2</td>
<td headers="Infections  Total_pct_ei" class="gt_row gt_left">40</td>
<td headers="Infections  Total_nb_pat" class="gt_row gt_left">2</td>
<td headers="Infections  Total_pct_pat" class="gt_row gt_left">20</td></tr>
  </tbody>
  
  
</table>
</div>
```



``` r
desc_ei_per_grade(df_pat_grp = df_pat_grp |> dplyr::mutate(grp = "A"),
                  df_pat_grade = df_pat_soc_grade)
```


```{=html}
<div id="djulqunoff" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#djulqunoff table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#djulqunoff thead, #djulqunoff tbody, #djulqunoff tfoot, #djulqunoff tr, #djulqunoff td, #djulqunoff th {
  border-style: none;
}

#djulqunoff p {
  margin: 0;
  padding: 0;
}

#djulqunoff .gt_table {
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

#djulqunoff .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#djulqunoff .gt_title {
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

#djulqunoff .gt_subtitle {
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

#djulqunoff .gt_heading {
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

#djulqunoff .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#djulqunoff .gt_col_headings {
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

#djulqunoff .gt_col_heading {
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

#djulqunoff .gt_column_spanner_outer {
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

#djulqunoff .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#djulqunoff .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#djulqunoff .gt_column_spanner {
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

#djulqunoff .gt_spanner_row {
  border-bottom-style: hidden;
}

#djulqunoff .gt_group_heading {
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

#djulqunoff .gt_empty_group_heading {
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

#djulqunoff .gt_from_md > :first-child {
  margin-top: 0;
}

#djulqunoff .gt_from_md > :last-child {
  margin-bottom: 0;
}

#djulqunoff .gt_row {
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

#djulqunoff .gt_stub {
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

#djulqunoff .gt_stub_row_group {
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

#djulqunoff .gt_row_group_first td {
  border-top-width: 2px;
}

#djulqunoff .gt_row_group_first th {
  border-top-width: 2px;
}

#djulqunoff .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#djulqunoff .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#djulqunoff .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#djulqunoff .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#djulqunoff .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#djulqunoff .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#djulqunoff .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#djulqunoff .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#djulqunoff .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#djulqunoff .gt_footnotes {
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

#djulqunoff .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#djulqunoff .gt_sourcenotes {
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

#djulqunoff .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#djulqunoff .gt_left {
  text-align: left;
}

#djulqunoff .gt_center {
  text-align: center;
}

#djulqunoff .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#djulqunoff .gt_font_normal {
  font-weight: normal;
}

#djulqunoff .gt_font_bold {
  font-weight: bold;
}

#djulqunoff .gt_font_italic {
  font-style: italic;
}

#djulqunoff .gt_super {
  font-size: 65%;
}

#djulqunoff .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#djulqunoff .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#djulqunoff .gt_indent_1 {
  text-indent: 5px;
}

#djulqunoff .gt_indent_2 {
  text-indent: 10px;
}

#djulqunoff .gt_indent_3 {
  text-indent: 15px;
}

#djulqunoff .gt_indent_4 {
  text-indent: 20px;
}

#djulqunoff .gt_indent_5 {
  text-indent: 25px;
}

#djulqunoff .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#djulqunoff div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="1" scope="col"></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="4" scope="colgroup" id="over_Total">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Total</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="grade"><span class='gt_from_md'><strong>Grade</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="EI_Total">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>EI</strong></span></div>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="Patients_Total">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Patients</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_nb_ei"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_pct_ei"><span class='gt_from_md'><strong>%</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_nb_pat"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Total_pct_pat"><span class='gt_from_md'><strong>%</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="grade" class="gt_row gt_left" style="background-color: #C8F3FF;">Total</td>
<td headers="Total_nb_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">5</td>
<td headers="Total_pct_ei" class="gt_row gt_left" style="background-color: #C8F3FF;">100</td>
<td headers="Total_nb_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">4</td>
<td headers="Total_pct_pat" class="gt_row gt_left" style="background-color: #C8F3FF;">40</td></tr>
    <tr><td headers="grade" class="gt_row gt_left">1</td>
<td headers="Total_nb_ei" class="gt_row gt_left">1</td>
<td headers="Total_pct_ei" class="gt_row gt_left">20</td>
<td headers="Total_nb_pat" class="gt_row gt_left">1</td>
<td headers="Total_pct_pat" class="gt_row gt_left">10</td></tr>
    <tr><td headers="grade" class="gt_row gt_left">2</td>
<td headers="Total_nb_ei" class="gt_row gt_left">1</td>
<td headers="Total_pct_ei" class="gt_row gt_left">20</td>
<td headers="Total_nb_pat" class="gt_row gt_left">1</td>
<td headers="Total_pct_pat" class="gt_row gt_left">10</td></tr>
    <tr><td headers="grade" class="gt_row gt_left">3</td>
<td headers="Total_nb_ei" class="gt_row gt_left">1</td>
<td headers="Total_pct_ei" class="gt_row gt_left">20</td>
<td headers="Total_nb_pat" class="gt_row gt_left">1</td>
<td headers="Total_pct_pat" class="gt_row gt_left">10</td></tr>
    <tr><td headers="grade" class="gt_row gt_left">4</td>
<td headers="Total_nb_ei" class="gt_row gt_left">2</td>
<td headers="Total_pct_ei" class="gt_row gt_left">40</td>
<td headers="Total_nb_pat" class="gt_row gt_left">2</td>
<td headers="Total_pct_pat" class="gt_row gt_left">20</td></tr>
  </tbody>
  
  
</table>
</div>
```



# Conclusion

The `DescribeAE` package provides a structured approach to summarizing and visualizing adverse events in clinical trials. By using `desc_ei_per_soc()` and `desc_ei_per_grade()`, researchers can:

- Identify which organ systems are most affected.
- Compare the frequency and severity of adverse events across treatment arms.
- Gain insights into the safety profile of treatments.

These summaries support better decision-making in clinical trial analyses, ensuring a comprehensive evaluation of adverse events. For further customization, users can preprocess their data accordingly before applying these functions.

