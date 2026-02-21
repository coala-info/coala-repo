[Skip to contents](#main)

[ukbrapR](../index.html)
0.3.10

* [Reference](../reference/index.html)
* Articles
  + [Ascertain diagnoses](../articles/ascertain_diagnoses.html)
  + [Label fields](../articles/label_fields.html)
  + [Spark functions](../articles/spark_functions.html)
* [Changelog](../news/index.html)

* + Light
  + Dark
  + Auto

# Ascertain diagnoses

Source: [`vignettes/ascertain_diagnoses.Rmd`](https://github.com/lcpilling/ukbrapR/blob/HEAD/vignettes/ascertain_diagnoses.Rmd)

`ascertain_diagnoses.Rmd`

Diagnosis of conditions in UK Biobank participants come from multiple
data sources:

* Self-report during assessment
* Hospital inpatient records (HES)
* Primary care (GP)
* Cancer registry
* Cause of death

The {ukbrapR} package makes it fast and easy to ascertain diagnoses
from multiple UK Biobank data sources in the DNAnexus Research Analysis
Platform (RAP).

## Requires exported files

This only needs to happen once per project. Running
`[export_tables()](../reference/export_tables.html)` will submit the necessary
`table-exporter` jobs to save the raw medical records files
to the RAP persistent storage for the project. ~10Gb of text files are
created. This will cost ~£0.15 per month to store in the RAP standard
storage.

Once the files are exported (~15mins) these can then be used by the
below functions to extract diagnoses based on codes lists.

## Input

Depending on the data source different coding vocabularies are
required:

* `ICD10` (for searching HES diagnoses, cause of death,
  and cancer registry)
* `ICD9` (for searching older HES diagnosis
  data)
* `Read2` and `CTV3` (for GP clinical
  events)
* `OPCS3` and `OPCS4` (for HES
  operations)
* `ukb_cancer` and `ukb_noncancer` (for
  self-reported illness at UK Biobank assessments - all instances will be
  searched)

Ascertaining diagnoses typically takes two steps:

## 1. Get medical records and self-reported illness data for provided codes

For a given set of diagnostic codes get the participant medical
events and self-reported data. Returns a list of 6 data frames: the
subset of the long clinical files with matched codes.

Codes need to be provided as a data frame with two fields:
`vocab_id` and `code`. Valid code vocabularies are
listed above. Other cols (such as condition and description) are
ignored.

```
# example diagnostic codes for Chronic Kidney Disease
codes_df_ckd <- ukbrapR:::codes_df_ckd
head(codes_df_ckd)
#>   condition vocab_id  code
#> 1       ckd    ICD10 N18.3
#> 2       ckd    ICD10 N18.4
#> 3       ckd    ICD10 N18.5
#> 4       ckd    ICD10 N18.6
#> 5       ckd    ICD10 N18.9
#> 6       ckd    ICD10   N19

# get diagnosis data - returns list of data frames (one per source)
diagnosis_list <- get_diagnoses(codes_df_ckd)
#> ℹ ukbrapR v0.3.10
#> → Checking provided codes (remember only the first 5 characters are used)
#>  - N unique ICD10 codes: 7
#>  - N unique Read2 codes: 40
#>  - N unique CTV3 codes: 37
#> Downloading hesin.tsv from the RAP [1/6] ■■■■■■                            17%
#> Downloading hesin_diag.tsv from the RAP [2/6] ■■■■■■■■■■■                      …
#> Downloading gp_clinical.tsv from the RAP [3/6] ■■■■■■■■■■■■■■■■                …
#> Downloading death.tsv from the RAP [4/6] ■■■■■■■■■■■■■■■■■■■■■             67%
#> Downloading death_cause.tsv from the RAP [5/6] ■■■■■■■■■■■■■■■■■■■■■■■■■■      …
#> Downloading baseline_dates.tsv from the RAP [6/6] ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■…
#> → Ascertaining cause of death data.
#> ✔ Loaded `death_cause` with 2650 matched rows.
#> → Ascertaining HES diagnosis data (ICD10s).
#> ✔ Loaded `hesin_diag` with 206390 matched rows.
#> → Ascertaining GP data.
#> ✔ Loaded `gp_clinical` with 29083 matched rows.
#> ✔ Finished. Time taken: 1m 17.2s.

# N records for each source
nrow(diagnosis_list$gp_clinical)
#> [1] 29083
nrow(diagnosis_list$hesin_diag)
#> [1] 206390
nrow(diagnosis_list$death_cause)
#> [1] 2650
```

If providing primary care codes for measures (BMI etc) these are also
returned (the `gp_clinical` object in the returned list
contains all cols for matched codes).

## 2. Get date first diagnosed

Usually the user is interested in combining the separate data sources
into a combined phenotype: the date first diagnosed for each participant
from the data/codes in step 1 (cause of death, HES diagnoses, GP
clinical, cancer registry, HES operations, and self-reported illness
fields).

In addition to the “date first” `df` field are:

* a `src` field indicating the source of the date of first
  diagnosis.
* a `bin` field indicating the cases [1] and controls [0].
  This relies on a small number of baseline fields also exported. The
  `df` field for the controls is the date of censoring
  (currently 30 October 2022).
* a `bin_prev` field indicating whether the case was before
  the UK Biobank baseline assessment

```
# for each participant, get Date First diagnosed with the condition
diagnosis_df <- get_df(diagnosis_list)
#> ℹ ukbrapR v0.3.10
#> ✔ Identified date of first diagnosis in 32162 participants.

names(diagnosis_df)
#> [1] "eid"      "gp_df"    "hes_df"   "death_df" "df"       "bin"      "bin_prev"
#> [8] "src"
summary(diagnosis_df)
#>       eid              gp_df                hes_df
#>  Min.   :1000014   Min.   :1958-01-01   Min.   :1995-08-29
#>  1st Qu.:2256733   1st Qu.:2007-04-27   1st Qu.:2014-11-26
#>  Median :3513182   Median :2009-09-15   Median :2018-05-15
#>  Mean   :3513253   Mean   :2010-02-11   Mean   :2017-04-21
#>  3rd Qu.:4769770   3rd Qu.:2012-12-31   3rd Qu.:2020-11-15
#>  Max.   :6026565   Max.   :2017-09-06   Max.   :2022-10-31
#>                    NA's   :489522       NA's   :477568
#>     death_df                df                  bin             bin_prev
#>  Min.   :2008-02-20   Min.   :1958-01-01   Min.   :0.00000   Min.   :0.00000
#>  1st Qu.:2018-08-17   1st Qu.:2022-10-30   1st Qu.:0.00000   1st Qu.:0.00000
#>  Median :2021-01-18   Median :2022-10-30   Median :0.00000   Median :0.00000
#>  Mean   :2020-05-22   Mean   :2022-04-21   Mean   :0.06403   Mean   :0.01314
#>  3rd Qu.:2022-12-07   3rd Qu.:2022-10-30   3rd Qu.:0.00000   3rd Qu.:0.00000
#>  Max.   :2024-07-04   Max.   :2024-07-01   Max.   :1.00000   Max.   :1.00000
#>  NA's   :499668
#>      src
#>  Length:502269
#>  Class :character
#>  Mode  :character
#>
#>
#>
#>
```

You can add a prefix to all the variable names by specifying the
“prefix” option:

```
diagnosis_df <- get_df(diagnosis_list, prefix="ckd")
#> ℹ ukbrapR v0.3.10
#> ✔ Identified date of first ckd diagnosis in 32162 participants.

# how many cases ascertained?
table(diagnosis_df$ckd_bin)
#>
#>      0      1
#> 470107  32162

# source of earliest diagnosis date
table(diagnosis_df$ckd_src)
#>
#> death    gp   hes
#>   451 12396 19315

# date of diagnosis for prevalent cases (i.e., before UK Biobank baseline assessment)
summary(diagnosis_df$ckd_df[ diagnosis_df$ckd_bin_prev == 1 ])
#>         Min.      1st Qu.       Median         Mean      3rd Qu.         Max.
#> "1958-01-01" "2006-06-21" "2007-01-12" "2006-06-24" "2007-11-19" "2010-06-16"
```

## Ascertaining multiple conditions at once

The default `[get_df()](../reference/get_df.html)` behaviour is to use all available
codes. However, the most time-efficient way to get multiple conditions
is to run `[get_diagnoses()](../reference/get_diagnoses.html)` once for all codes for the
conditions you wish to ascertain, then get the “date first diagnosed”
for each condition separately. In the codes data frame you just need a
field indicating the condition name, that will become the variable
prefixes.

```
# combine haemochromatosis and CKD codes together
#   each contain there columns: condition, vocab_id, and code
#   where `condition` is either "hh" or "ckd" and will become the variable prefix
codes_df_combined <- rbind(ukbrapR:::codes_df_hh, ukbrapR:::codes_df_ckd)

# get diagnosis data - returns list of data frames (one per source)
diagnosis_list <- get_diagnoses(codes_df_combined)
#> ℹ ukbrapR v0.3.10
#> → Checking provided codes (remember only the first 5 characters are used)
#>  - N unique ICD10 codes: 8
#>  - N unique ICD9 codes: 1
#>  - N unique Read2 codes: 45
#>  - N unique CTV3 codes: 45
#>  - N unique UKB-self-reported codes: 1
#> → Ascertaining cause of death data.
#> ✔ Loaded `death_cause` with 2696 matched rows.
#> → Ascertaining HES diagnosis data (ICD10s).
#> ✔ Loaded `hesin_diag` with 239398 matched rows.
#> → Ascertaining HES diagnosis data (ICD9s).
#> ✔ Loaded `hesin_diag` with 0 matched rows.
#> → Ascertaining GP data.
#> ✔ Loaded `gp_clinical` with 30393 matched rows.
#> → Ascertaining self-reported illness data.
#> ✔ Loaded `selfrep_illness` with 185 matched rows.
#> ✔ Finished. Time taken: 59.4s.

# for each participant, get Date First diagnosed with the condition
diagnosis_df <- get_df(diagnosis_list, group_by="condition")
#> ℹ ukbrapR v0.3.10
#> → 2 groups identified - getting date first for each
#> ✔ Identified date of first hh diagnosis in 2015 participants.
#> ✔ Identified date of first ckd diagnosis in 32162 participants.
#> ℹ Finished getting date first diagnosed for each group/condition.

# each condition has full set of output
table(diagnosis_df$hh_bin)
#>
#>      0      1
#> 500254   2015

table(diagnosis_df$ckd_bin)
#>
#>      0      1
#> 470107  32162
```

In the above example we also included a UK Biobank self-reported
illness code for haemochromatosis, that was also ascertained (the Date
First is run on each condition separately, they do not all need to have
the same data sources).

## On this page

Developed by [Luke Pilling](https://lcpilling.github.io).

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.2.0.