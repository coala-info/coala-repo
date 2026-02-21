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

# Spark functions

Source: [`vignettes/spark_functions.Rmd`](https://github.com/lcpilling/ukbrapR/blob/HEAD/vignettes/spark_functions.Rmd)

`spark_functions.Rmd`

## Pull phenotype data from Spark environment to an R data frame

**Needs to be run in an Apache Spark environment on the UK
Biobank DNAnexus RAP.**

Recommend launching a Spark cluster with at least
`mem1_hdd1_v2_x16` and **2 nodes** otherwise
this can fail with error “…ensure that workers…have sufficient
resources”

The underlying code is mostly from the [UK
Biobank GitHub](https://github.com/UK-Biobank/UKB-RAP-Notebooks/blob/main/NBs_Prelim/105_export_participant_data_to_r.ipynb).

```
# get phenotype data (participant ID, sex, baseline age, and baseline assessment date)
ukb <- get_rap_phenos(c("eid", "p31", "p21003_i0", "p53_i0"))
#> 48.02 sec elapsed

# summary of data
table(ukb$p31)
#> Female   Male
#> 273297 229067
summary(ukb$p21003_i0)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>  37.00   50.00   58.00   56.53   63.00   73.00
```

### No more updates…

I am moving away from using Spark as the default environment, mostly
due to the cost implications; it is significantly cheaper (and quicker!)
to store and search exported raw text files in the RAP persistant
storage than do everything in a Spark environment (plus the added
benefit that the RStudio interface is available in “normal”
instances).

The Spark functions are available as before but all updates are to
improve functionality in “normal” instances using RStudio, as we move to
the new era of RAP-only UK Biobank analysis.

If you need to see the previous release documentation follow the tags
to the version required: <https://github.com/lcpilling/ukbrapR/tree/v0.1.7>

## On this page

Developed by [Luke Pilling](https://lcpilling.github.io).

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.2.0.