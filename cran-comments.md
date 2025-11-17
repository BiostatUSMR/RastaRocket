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

## Response to mail from 11/11/2025

Thanks you for your feedbacks !

### RQ1

If there are references describing the methods in your package, please add these in the description field of your DESCRIPTION file in the form authors (year) <doi:...> authors (year, ISBN:...) or if those are not available: <https:...> with no space after 'doi:', 'https:' and angle brackets for auto-linking. (If you want to add a title as well please put it in
quotes: "Title")
For more details: 
<https://contributor.r-project.org/cran-cookbook/description_issues.html#references>

**No reference is needed for the descriptive methods in this package**

### RQ2

You have examples for unexported functions. Please either omit these examples or export these functions.

-> Examples for unexported function
   desc_ei_per_pt_df_to_gt() in:
      desc_ei_per_pt_df_to_gt.Rd
   desc_ei_per_pt_prepare_df() in:
      desc_ei_per_pt_prepare_df.Rd

**Examples were removed**

### RQ3

\dontrun{} should only be used if the example really cannot be executed (e.g. because of missing additional software, missing API keys, ...) by the user. That's why wrapping examples in \dontrun{} adds the comment ("# Not run:") as a warning for the user. Does not seem necessary. 
Please replace \dontrun with \donttest.

Please unwrap the examples if they are executable in < 5 sec, or replace dontrun{} with \donttest{}.

For more details: 
<https://contributor.r-project.org/cran-cookbook/general_issues.html#structuring-of-examples> 

**dontrun was removed as the exemple is executable in less than 5 sec.**
