---
title: "DescribeAE"
date: "2025-05-27"
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

- `desc_ei_per_pt()`: Summarizes adverse events by **System Organ Class (SOC)** and **Preferred Term (PT)**.
- `desc_ei_per_grade()`: Summarizes adverse events by **grade**, which represents severity.

These functions generate tables that help interpret the distribution of adverse events across different treatment arms in a randomized controlled trial (RCT).

# Toy dataset

Before using these functions, we need to create a toy datasets. Below is an example of how to structure the data.

## Assigning Patients to Treatment Arms


``` r
df_pat_grp <- data.frame(
  USUBJID = paste0("ID_", 1:10),
  RDGRPNAME = c(rep("A", 3), rep("B", 3), rep("C", 4))
)
```

## Recording Adverse Events by LLT, PT, SOC and Grade


``` r
df_pat_llt <- data.frame(
  USUBJID = c("ID_1", "ID_1", "ID_2", "ID_4", "ID_9"),
  EINUM = c(1, 2, 1, 1, 1),
  EILLTN = c("llt1", "llt2", "llt1", "llt3", "llt4"),
  EIPTN = c("Arrhythmia", "Myocardial Infarction", "Arrhythmia", "Pneumonia", "Pneumonia"),
  EISOCPN = c("Cardiac Disorders", "Cardiac Disorders", "Cardiac Disorders", "Infections", "Infections"),
  EIGRDM = c(1, 3, 4, 2, 4),
  EIGRAV = c("Grave", "Non grave", "Non grave", "Non grave", "Grave") 
)
```


# Summarizing Adverse Events

## Describing Adverse Events by System Organ Class

To analyze adverse events based on their **System Organ Class (SOC)** and **Preferred Term (PT)**, use the `desc_ei_per_pt()` function:


``` r
desc_ei_per_pt(df_pat_grp = df_pat_grp,
               df_pat_llt = df_pat_llt)
```


```{=html}
<div id="qzgwlsuzke" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#qzgwlsuzke table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#qzgwlsuzke thead, #qzgwlsuzke tbody, #qzgwlsuzke tfoot, #qzgwlsuzke tr, #qzgwlsuzke td, #qzgwlsuzke th {
  border-style: none;
}

#qzgwlsuzke p {
  margin: 0;
  padding: 0;
}

#qzgwlsuzke .gt_table {
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

#qzgwlsuzke .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#qzgwlsuzke .gt_title {
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

#qzgwlsuzke .gt_subtitle {
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

#qzgwlsuzke .gt_heading {
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

#qzgwlsuzke .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qzgwlsuzke .gt_col_headings {
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

#qzgwlsuzke .gt_col_heading {
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

#qzgwlsuzke .gt_column_spanner_outer {
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

#qzgwlsuzke .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#qzgwlsuzke .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#qzgwlsuzke .gt_column_spanner {
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

#qzgwlsuzke .gt_spanner_row {
  border-bottom-style: hidden;
}

#qzgwlsuzke .gt_group_heading {
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

#qzgwlsuzke .gt_empty_group_heading {
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

#qzgwlsuzke .gt_from_md > :first-child {
  margin-top: 0;
}

#qzgwlsuzke .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qzgwlsuzke .gt_row {
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

#qzgwlsuzke .gt_stub {
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

#qzgwlsuzke .gt_stub_row_group {
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

#qzgwlsuzke .gt_row_group_first td {
  border-top-width: 2px;
}

#qzgwlsuzke .gt_row_group_first th {
  border-top-width: 2px;
}

#qzgwlsuzke .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qzgwlsuzke .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#qzgwlsuzke .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#qzgwlsuzke .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qzgwlsuzke .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qzgwlsuzke .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#qzgwlsuzke .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#qzgwlsuzke .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#qzgwlsuzke .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qzgwlsuzke .gt_footnotes {
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

#qzgwlsuzke .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#qzgwlsuzke .gt_sourcenotes {
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

#qzgwlsuzke .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#qzgwlsuzke .gt_left {
  text-align: left;
}

#qzgwlsuzke .gt_center {
  text-align: center;
}

#qzgwlsuzke .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#qzgwlsuzke .gt_font_normal {
  font-weight: normal;
}

#qzgwlsuzke .gt_font_bold {
  font-weight: bold;
}

#qzgwlsuzke .gt_font_italic {
  font-style: italic;
}

#qzgwlsuzke .gt_super {
  font-size: 65%;
}

#qzgwlsuzke .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#qzgwlsuzke .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#qzgwlsuzke .gt_indent_1 {
  text-indent: 5px;
}

#qzgwlsuzke .gt_indent_2 {
  text-indent: 10px;
}

#qzgwlsuzke .gt_indent_3 {
  text-indent: 15px;
}

#qzgwlsuzke .gt_indent_4 {
  text-indent: 20px;
}

#qzgwlsuzke .gt_indent_5 {
  text-indent: 25px;
}

#qzgwlsuzke .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#qzgwlsuzke div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="pt"><span class='gt_from_md'><strong>Evénements indésirables</strong></span></th>
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
      <th colspan="17" class="gt_group_heading" style="background-color: #F5F3F4; font-weight: bold;" scope="colgroup" id="Total">Total</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Total  pt" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">Total</td>
<td headers="Total  Total_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">5</td>
<td headers="Total  Total_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="Total  Total_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">4</td>
<td headers="Total  Total_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">40</td>
<td headers="Total  A_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">3</td>
<td headers="Total  A_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="Total  A_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">2</td>
<td headers="Total  A_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">67</td>
<td headers="Total  B_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="Total  B_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="Total  B_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="Total  B_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">33</td>
<td headers="Total  C_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="Total  C_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="Total  C_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="Total  C_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">25</td></tr>
    <tr class="gt_group_heading_row">
      <th colspan="17" class="gt_group_heading" style="background-color: #F5F3F4; font-weight: bold;" scope="colgroup" id="Cardiac Disorders">Cardiac Disorders</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Cardiac Disorders  pt" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">Total</td>
<td headers="Cardiac Disorders  Total_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">3</td>
<td headers="Cardiac Disorders  Total_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">60</td>
<td headers="Cardiac Disorders  Total_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">2</td>
<td headers="Cardiac Disorders  Total_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">20</td>
<td headers="Cardiac Disorders  A_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">3</td>
<td headers="Cardiac Disorders  A_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="Cardiac Disorders  A_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">2</td>
<td headers="Cardiac Disorders  A_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">67</td>
<td headers="Cardiac Disorders  B_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="Cardiac Disorders  B_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="Cardiac Disorders  B_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="Cardiac Disorders  B_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="Cardiac Disorders  C_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="Cardiac Disorders  C_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="Cardiac Disorders  C_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="Cardiac Disorders  C_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td></tr>
    <tr><td headers="Cardiac Disorders  pt" class="gt_row gt_left">Arrhythmia</td>
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
    <tr><td headers="Cardiac Disorders  pt" class="gt_row gt_left">Myocardial Infarction</td>
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
      <th colspan="17" class="gt_group_heading" style="background-color: #F5F3F4; font-weight: bold;" scope="colgroup" id="Infections">Infections</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Infections  pt" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">Total</td>
<td headers="Infections  Total_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">2</td>
<td headers="Infections  Total_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">40</td>
<td headers="Infections  Total_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">2</td>
<td headers="Infections  Total_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">20</td>
<td headers="Infections  A_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="Infections  A_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="Infections  A_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="Infections  A_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="Infections  B_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="Infections  B_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="Infections  B_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="Infections  B_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">33</td>
<td headers="Infections  C_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="Infections  C_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="Infections  C_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="Infections  C_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">25</td></tr>
    <tr><td headers="Infections  pt" class="gt_row gt_left">Pneumonia</td>
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
                  df_pat_grade = df_pat_llt)
```


```{=html}
<div id="tthkfqezqx" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#tthkfqezqx table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#tthkfqezqx thead, #tthkfqezqx tbody, #tthkfqezqx tfoot, #tthkfqezqx tr, #tthkfqezqx td, #tthkfqezqx th {
  border-style: none;
}

#tthkfqezqx p {
  margin: 0;
  padding: 0;
}

#tthkfqezqx .gt_table {
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

#tthkfqezqx .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#tthkfqezqx .gt_title {
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

#tthkfqezqx .gt_subtitle {
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

#tthkfqezqx .gt_heading {
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

#tthkfqezqx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tthkfqezqx .gt_col_headings {
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

#tthkfqezqx .gt_col_heading {
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

#tthkfqezqx .gt_column_spanner_outer {
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

#tthkfqezqx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#tthkfqezqx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#tthkfqezqx .gt_column_spanner {
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

#tthkfqezqx .gt_spanner_row {
  border-bottom-style: hidden;
}

#tthkfqezqx .gt_group_heading {
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

#tthkfqezqx .gt_empty_group_heading {
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

#tthkfqezqx .gt_from_md > :first-child {
  margin-top: 0;
}

#tthkfqezqx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#tthkfqezqx .gt_row {
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

#tthkfqezqx .gt_stub {
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

#tthkfqezqx .gt_stub_row_group {
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

#tthkfqezqx .gt_row_group_first td {
  border-top-width: 2px;
}

#tthkfqezqx .gt_row_group_first th {
  border-top-width: 2px;
}

#tthkfqezqx .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tthkfqezqx .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#tthkfqezqx .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#tthkfqezqx .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tthkfqezqx .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tthkfqezqx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#tthkfqezqx .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#tthkfqezqx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#tthkfqezqx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tthkfqezqx .gt_footnotes {
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

#tthkfqezqx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#tthkfqezqx .gt_sourcenotes {
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

#tthkfqezqx .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#tthkfqezqx .gt_left {
  text-align: left;
}

#tthkfqezqx .gt_center {
  text-align: center;
}

#tthkfqezqx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#tthkfqezqx .gt_font_normal {
  font-weight: normal;
}

#tthkfqezqx .gt_font_bold {
  font-weight: bold;
}

#tthkfqezqx .gt_font_italic {
  font-style: italic;
}

#tthkfqezqx .gt_super {
  font-size: 65%;
}

#tthkfqezqx .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#tthkfqezqx .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#tthkfqezqx .gt_indent_1 {
  text-indent: 5px;
}

#tthkfqezqx .gt_indent_2 {
  text-indent: 10px;
}

#tthkfqezqx .gt_indent_3 {
  text-indent: 15px;
}

#tthkfqezqx .gt_indent_4 {
  text-indent: 20px;
}

#tthkfqezqx .gt_indent_5 {
  text-indent: 25px;
}

#tthkfqezqx .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#tthkfqezqx div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
    <tr><td headers="grade" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">Any grade</td>
<td headers="Total_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">5</td>
<td headers="Total_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="Total_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">4</td>
<td headers="Total_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">40</td>
<td headers="A_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">3</td>
<td headers="A_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="A_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">2</td>
<td headers="A_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">67</td>
<td headers="B_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="B_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="B_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="B_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">33</td>
<td headers="C_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="C_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="C_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="C_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">25</td></tr>
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
    <tr><td headers="grade" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">SAE</td>
<td headers="Total_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">2</td>
<td headers="Total_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">40</td>
<td headers="Total_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">2</td>
<td headers="Total_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">20</td>
<td headers="A_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="A_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">33</td>
<td headers="A_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="A_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">33</td>
<td headers="B_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="B_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="B_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="B_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="C_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="C_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="C_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="C_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">25</td></tr>
  </tbody>
  
  
</table>
</div>
```


### Interpretation:

This table summarizes the distribution of adverse event grades (severity levels) per treatment group. It helps in understanding whether a treatment is associated with more severe adverse events compared to others.


# What if you have only one group ?

In that case the table `df_pat_grp` must still be provided with RDGRPNAME set to "Total" (or any other string)


``` r
desc_ei_per_pt(df_pat_grp = df_pat_grp |> dplyr::mutate(RDGRPNAME = "A"),
               df_pat_llt = df_pat_llt)
```


```{=html}
<div id="bbmlyykprv" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#bbmlyykprv table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#bbmlyykprv thead, #bbmlyykprv tbody, #bbmlyykprv tfoot, #bbmlyykprv tr, #bbmlyykprv td, #bbmlyykprv th {
  border-style: none;
}

#bbmlyykprv p {
  margin: 0;
  padding: 0;
}

#bbmlyykprv .gt_table {
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

#bbmlyykprv .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#bbmlyykprv .gt_title {
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

#bbmlyykprv .gt_subtitle {
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

#bbmlyykprv .gt_heading {
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

#bbmlyykprv .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bbmlyykprv .gt_col_headings {
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

#bbmlyykprv .gt_col_heading {
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

#bbmlyykprv .gt_column_spanner_outer {
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

#bbmlyykprv .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#bbmlyykprv .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#bbmlyykprv .gt_column_spanner {
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

#bbmlyykprv .gt_spanner_row {
  border-bottom-style: hidden;
}

#bbmlyykprv .gt_group_heading {
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

#bbmlyykprv .gt_empty_group_heading {
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

#bbmlyykprv .gt_from_md > :first-child {
  margin-top: 0;
}

#bbmlyykprv .gt_from_md > :last-child {
  margin-bottom: 0;
}

#bbmlyykprv .gt_row {
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

#bbmlyykprv .gt_stub {
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

#bbmlyykprv .gt_stub_row_group {
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

#bbmlyykprv .gt_row_group_first td {
  border-top-width: 2px;
}

#bbmlyykprv .gt_row_group_first th {
  border-top-width: 2px;
}

#bbmlyykprv .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bbmlyykprv .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#bbmlyykprv .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#bbmlyykprv .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bbmlyykprv .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bbmlyykprv .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#bbmlyykprv .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#bbmlyykprv .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#bbmlyykprv .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bbmlyykprv .gt_footnotes {
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

#bbmlyykprv .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#bbmlyykprv .gt_sourcenotes {
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

#bbmlyykprv .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#bbmlyykprv .gt_left {
  text-align: left;
}

#bbmlyykprv .gt_center {
  text-align: center;
}

#bbmlyykprv .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#bbmlyykprv .gt_font_normal {
  font-weight: normal;
}

#bbmlyykprv .gt_font_bold {
  font-weight: bold;
}

#bbmlyykprv .gt_font_italic {
  font-style: italic;
}

#bbmlyykprv .gt_super {
  font-size: 65%;
}

#bbmlyykprv .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#bbmlyykprv .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#bbmlyykprv .gt_indent_1 {
  text-indent: 5px;
}

#bbmlyykprv .gt_indent_2 {
  text-indent: 10px;
}

#bbmlyykprv .gt_indent_3 {
  text-indent: 15px;
}

#bbmlyykprv .gt_indent_4 {
  text-indent: 20px;
}

#bbmlyykprv .gt_indent_5 {
  text-indent: 25px;
}

#bbmlyykprv .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#bbmlyykprv div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="pt"><span class='gt_from_md'><strong>Evénements indésirables</strong></span></th>
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
      <th colspan="5" class="gt_group_heading" style="background-color: #F5F3F4; font-weight: bold;" scope="colgroup" id="Total">Total</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Total  pt" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">Total</td>
<td headers="Total  Total_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">5</td>
<td headers="Total  Total_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="Total  Total_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">4</td>
<td headers="Total  Total_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">40</td></tr>
    <tr class="gt_group_heading_row">
      <th colspan="5" class="gt_group_heading" style="background-color: #F5F3F4; font-weight: bold;" scope="colgroup" id="Cardiac Disorders">Cardiac Disorders</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Cardiac Disorders  pt" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">Total</td>
<td headers="Cardiac Disorders  Total_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">3</td>
<td headers="Cardiac Disorders  Total_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">60</td>
<td headers="Cardiac Disorders  Total_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">2</td>
<td headers="Cardiac Disorders  Total_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">20</td></tr>
    <tr><td headers="Cardiac Disorders  pt" class="gt_row gt_left">Arrhythmia</td>
<td headers="Cardiac Disorders  Total_nb_ei" class="gt_row gt_left">2</td>
<td headers="Cardiac Disorders  Total_pct_ei" class="gt_row gt_left">40</td>
<td headers="Cardiac Disorders  Total_nb_pat" class="gt_row gt_left">2</td>
<td headers="Cardiac Disorders  Total_pct_pat" class="gt_row gt_left">20</td></tr>
    <tr><td headers="Cardiac Disorders  pt" class="gt_row gt_left">Myocardial Infarction</td>
<td headers="Cardiac Disorders  Total_nb_ei" class="gt_row gt_left">1</td>
<td headers="Cardiac Disorders  Total_pct_ei" class="gt_row gt_left">20</td>
<td headers="Cardiac Disorders  Total_nb_pat" class="gt_row gt_left">1</td>
<td headers="Cardiac Disorders  Total_pct_pat" class="gt_row gt_left">10</td></tr>
    <tr class="gt_group_heading_row">
      <th colspan="5" class="gt_group_heading" style="background-color: #F5F3F4; font-weight: bold;" scope="colgroup" id="Infections">Infections</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Infections  pt" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">Total</td>
<td headers="Infections  Total_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">2</td>
<td headers="Infections  Total_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">40</td>
<td headers="Infections  Total_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">2</td>
<td headers="Infections  Total_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">20</td></tr>
    <tr><td headers="Infections  pt" class="gt_row gt_left">Pneumonia</td>
<td headers="Infections  Total_nb_ei" class="gt_row gt_left">2</td>
<td headers="Infections  Total_pct_ei" class="gt_row gt_left">40</td>
<td headers="Infections  Total_nb_pat" class="gt_row gt_left">2</td>
<td headers="Infections  Total_pct_pat" class="gt_row gt_left">20</td></tr>
  </tbody>
  
  
</table>
</div>
```



``` r
desc_ei_per_grade(df_pat_grp = df_pat_grp,
                  df_pat_grade = df_pat_llt |> dplyr::mutate(RDGRPNAME = "A"))
```


```{=html}
<div id="yupjzrauio" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#yupjzrauio table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#yupjzrauio thead, #yupjzrauio tbody, #yupjzrauio tfoot, #yupjzrauio tr, #yupjzrauio td, #yupjzrauio th {
  border-style: none;
}

#yupjzrauio p {
  margin: 0;
  padding: 0;
}

#yupjzrauio .gt_table {
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

#yupjzrauio .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#yupjzrauio .gt_title {
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

#yupjzrauio .gt_subtitle {
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

#yupjzrauio .gt_heading {
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

#yupjzrauio .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yupjzrauio .gt_col_headings {
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

#yupjzrauio .gt_col_heading {
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

#yupjzrauio .gt_column_spanner_outer {
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

#yupjzrauio .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#yupjzrauio .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#yupjzrauio .gt_column_spanner {
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

#yupjzrauio .gt_spanner_row {
  border-bottom-style: hidden;
}

#yupjzrauio .gt_group_heading {
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

#yupjzrauio .gt_empty_group_heading {
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

#yupjzrauio .gt_from_md > :first-child {
  margin-top: 0;
}

#yupjzrauio .gt_from_md > :last-child {
  margin-bottom: 0;
}

#yupjzrauio .gt_row {
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

#yupjzrauio .gt_stub {
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

#yupjzrauio .gt_stub_row_group {
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

#yupjzrauio .gt_row_group_first td {
  border-top-width: 2px;
}

#yupjzrauio .gt_row_group_first th {
  border-top-width: 2px;
}

#yupjzrauio .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yupjzrauio .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#yupjzrauio .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#yupjzrauio .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yupjzrauio .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yupjzrauio .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#yupjzrauio .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#yupjzrauio .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#yupjzrauio .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yupjzrauio .gt_footnotes {
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

#yupjzrauio .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#yupjzrauio .gt_sourcenotes {
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

#yupjzrauio .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#yupjzrauio .gt_left {
  text-align: left;
}

#yupjzrauio .gt_center {
  text-align: center;
}

#yupjzrauio .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#yupjzrauio .gt_font_normal {
  font-weight: normal;
}

#yupjzrauio .gt_font_bold {
  font-weight: bold;
}

#yupjzrauio .gt_font_italic {
  font-style: italic;
}

#yupjzrauio .gt_super {
  font-size: 65%;
}

#yupjzrauio .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#yupjzrauio .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#yupjzrauio .gt_indent_1 {
  text-indent: 5px;
}

#yupjzrauio .gt_indent_2 {
  text-indent: 10px;
}

#yupjzrauio .gt_indent_3 {
  text-indent: 15px;
}

#yupjzrauio .gt_indent_4 {
  text-indent: 20px;
}

#yupjzrauio .gt_indent_5 {
  text-indent: 25px;
}

#yupjzrauio .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#yupjzrauio div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
    <tr><td headers="grade" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">Any grade</td>
<td headers="Total_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">5</td>
<td headers="Total_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="Total_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">4</td>
<td headers="Total_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">40</td>
<td headers="A_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">3</td>
<td headers="A_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="A_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">2</td>
<td headers="A_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">67</td>
<td headers="B_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="B_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="B_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="B_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">33</td>
<td headers="C_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="C_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="C_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="C_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">25</td></tr>
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
    <tr><td headers="grade" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">SAE</td>
<td headers="Total_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">2</td>
<td headers="Total_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">40</td>
<td headers="Total_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">2</td>
<td headers="Total_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">20</td>
<td headers="A_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="A_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">33</td>
<td headers="A_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="A_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">33</td>
<td headers="B_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="B_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="B_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="B_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;"><br /></td>
<td headers="C_nb_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="C_pct_ei" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">100</td>
<td headers="C_nb_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">1</td>
<td headers="C_pct_pat" class="gt_row gt_left" style="font-style: italic; font-weight: bold;">25</td></tr>
  </tbody>
  
  
</table>
</div>
```


# Plot Adverse Events

This section provides several visualization methods for adverse events (AEs) based on patient data.
Currently, these plots support only two groups. Future work may involve migration to aevisR for enhanced functionality.

First, we define the two patients group:


``` r
df_pat_grp <- df_pat_grp |> 
  dplyr::mutate(RDGRPNAME = c(rep("A", 5), rep("B", 5)))
```


## Dumbell plot

The dumbbell plot visualizes the difference in AE occurrence between the two groups. It highlights the absolute risk difference for each AE.


``` r
plot_dumbell(df_pat_llt = df_pat_llt,
             df_pat_grp = df_pat_grp)
```

![](C:/Users/fertet/Documents/USMR/R&D/develloppementfonction/vignettes/DescribeAE_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

## Volcano plot

The volcano plot displays the association between risk differences and statistical significance (-log10 p-values). This helps identify AEs that differ significantly between groups.


``` r
plot_volcano(df_pat_llt = df_pat_llt,
             df_pat_grp = df_pat_grp)
```

![](C:/Users/fertet/Documents/USMR/R&D/develloppementfonction/vignettes/DescribeAE_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

## Butterfly plot

The butterfly stacked bar plot compares AE frequencies across groups while stacking by severity grade. It provides a detailed view of AE distributions.


``` r
plot_butterfly_stacked_barplot(df_pat_llt = df_pat_llt,
                               df_pat_grp = df_pat_grp)
```

![](C:/Users/fertet/Documents/USMR/R&D/develloppementfonction/vignettes/DescribeAE_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

<!-- ## Patient Span Chart (Panchart) -->

<!-- The Patient Span Chart provides a timeline view of adverse events, treatments, and randomization for a selected patient. -->
<!-- It is particularly useful for tracking the sequence of AEs in relation to treatment administration and study randomization. -->

<!-- ### Example Dataset -->

<!-- ```{r} -->
<!-- df_pat_grp_rando <- data.frame( -->
<!--   id_pat = c("ID_1", "ID_2"), -->
<!--   grp = c("A", "B"), -->
<!--   rando_date = c("2020-12-01", "2021-01-03") -->
<!-- ) -->

<!-- df_pat_pt_grade_date <- data.frame( -->
<!--   id_pat = c("ID_1", "ID_1", "ID_1", "ID_1", "ID_2"), -->
<!--   pt = c("Arrhythmia", "Myocardial Infarction", "Arrhythmia", -->
<!--           "Pneumonia", "Pneumonia"), -->
<!--   grade = c(4, 2, 1, 3, 4), -->
<!--   start = c("2021-01-01", "2021-02-03", "2021-01-02", "2021-03-05", "2021-02-01"), -->
<!--   end = c("2021-01-14", "2021-03-03", "2021-01-22", "2021-05-05", "2021-02-03") -->
<!-- ) -->

<!-- df_pat_treatment_date <- data.frame( -->
<!--   id_pat = c("ID_1", "ID_1", "ID_1"), -->
<!--   treatment_date = c("2021-01-25", "2021-03-01", "2021-01-20") -->
<!-- ) -->
<!-- ``` -->

<!-- ### Generating the Panchart for a Specific Patient -->

<!-- ```{r fig.height=4, fig.width=6} -->
<!-- plot_patient_panchart( -->
<!--   df_soc_pt = df_soc_pt, -->
<!--   df_pat_grp_rando = df_pat_grp_rando, -->
<!--   df_pat_pt_grade_date = df_pat_pt_grade_date, -->
<!--   df_pat_treatment_date = df_pat_treatment_date, -->
<!--   pat_id = "ID_1" -->
<!-- ) -->
<!-- ``` -->

<!-- Interpreting the Chart -->

<!-- - Horizontal bars represent the duration of each adverse event. -->
<!-- - Vertical dashed lines indicate the patient's randomization and treatment dates. -->
<!-- - Colors differentiate the severity of adverse events (by grade). -->
<!-- - Separate facets display treatments and adverse events categorized by Preferred Term (PT). -->

# Conclusion

The `DescribeAE` package provides a structured approach to summarizing and visualizing adverse events in clinical trials. By using `desc_ei_per_soc()` and `desc_ei_per_grade()`, researchers can:

- Identify which organ systems are most affected.
- Compare the frequency and severity of adverse events across treatment arms.
- Gain insights into the safety profile of treatments.

These summaries support better decision-making in clinical trial analyses, ensuring a comprehensive evaluation of adverse events. For further customization, users can preprocess their data accordingly before applying these functions.

