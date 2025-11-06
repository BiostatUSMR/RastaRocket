## R CMD check results

0 errors | 0 warnings | 2 notes

❯ checking CRAN incoming feasibility ... [13s] NOTE
  Maintainer: 'USMR CHU de Bordeaux <astreinte.usmr@chu-bordeaux.fr>'
  
  New submission

N  checking for future file timestamps ... 
   unable to verify current time

* This is a new release.

## Response to mail from 06112025

### Notes

2 NOTES : 

Maintainer: 'USMR CHU de Bordeaux <astreinte.usmr@chu-bordeaux.fr>'

New submission

Possibly misspelled words in DESCRIPTION:
  ungrouped (29:41)
  
Missing dependency on R >= 4.1.0 because package code uses the pipe
  |> or function shorthand \(...) syntax added in R 4.1.0.
  File(s) using such syntax:
    'custom_headers.R' 'custom_round.R' 'desc_ei_per_grade.R'
    'desc_ei_per_pt.R' 'df_builder_ae.R'
    'plot_butterfly_stacked_barplot.R' 'plot_dumbell.R'
    'plot_patient_panchart.R' 'plot_volcano.R'

### Response

'ungrouped' was removed and replaced by 'not grouped' in description file

Dependency on R >= 4.1.0 was added to DESCRIPTION file.

