# Questions and answers from over the years

Sean Davis

#### Sunday, November 09, 2025

# 1 How could I generate a manifest file with filtering of Race and Ethnicity?

From <https://support.bioconductor.org/p/9138939/>.

```
library(GenomicDataCommons,quietly = TRUE)
```

I made a small change to the filtering expression approach based on
changes to lazy evaluation best practices. There is now no need to
include the `~` in the filter expression. So:

```
q = files() |>
  GenomicDataCommons::filter(
    cases.project.project_id == 'TCGA-COAD' &
      data_type == 'Aligned Reads' &
      experimental_strategy == 'RNA-Seq' &
      data_format == 'BAM')
```

And get a count of the results:

```
count(q)
```

```
## [1] 1188
```

And the manifest.

```
manifest(q)
```

Your question about race and ethnicity is a good one.

```
all_fields = available_fields(files())
```

And we can grep for `race` or `ethnic` to get potential matching fields
to look at.

```
grep('race|ethnic',all_fields,value=TRUE)
```

```
## [1] "cases.demographic.ethnicity"
## [2] "cases.demographic.race"
## [3] "cases.follow_ups.hormonal_contraceptive_type"
## [4] "cases.follow_ups.hormonal_contraceptive_use"
## [5] "cases.follow_ups.other_clinical_attributes.hormonal_contraceptive_type"
## [6] "cases.follow_ups.other_clinical_attributes.hormonal_contraceptive_use"
## [7] "cases.follow_ups.scan_tracer_used"
```

Now, we can check available values for each field to determine how to complete
our filter expressions.

```
available_values('files',"cases.demographic.ethnicity")
```

```
## [1] "not hispanic or latino" "not reported"           "hispanic or latino"
## [4] "unknown"                "_missing"
```

```
available_values('files',"cases.demographic.race")
```

```
##  [1] "white"
##  [2] "not reported"
##  [3] "black or african american"
##  [4] "asian"
##  [5] "unknown"
##  [6] "american indian or alaska native"
##  [7] "native hawaiian or other pacific islander"
##  [8] "other"
##  [9] "not allowed to collect"
## [10] "_missing"
```

We can complete our filter expression now to limit to `white` race only.

```
q_white_only = q |>
  GenomicDataCommons::filter(cases.demographic.race=='white')
count(q_white_only)
```

```
## [1] 695
```

```
manifest(q_white_only)
```

# 2 How can I get the number of cases with RNA-Seq data added by date to TCGA project with `GenomicDataCommons`?

* From <https://support.bioconductor.org/p/9135791/>

I would like to get the number of cases added (created, any logical datetime would suffice here) to the TCGA project by experiment type. I attempted to get this data via GenomicDataCommons package, but it is giving me I believe the number of files for a given experiment type rather than number cases. How can I get the number of cases for which there is RNA-Seq data?

```
library(tibble)
library(dplyr)
```

```
##
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:GenomicDataCommons':
##
##     count, filter, select
```

```
## The following objects are masked from 'package:stats':
##
##     filter, lag
```

```
## The following objects are masked from 'package:base':
##
##     intersect, setdiff, setequal, union
```

```
library(GenomicDataCommons)

cases() |>
  GenomicDataCommons::filter(
    ~ project.program.name=='TCGA' & files.experimental_strategy=='RNA-Seq'
  ) |>
  facet(c("files.created_datetime")) |>
  aggregations() |>
  unname() |>
  unlist(recursive = FALSE) |>
  as_tibble() |>
  dplyr::arrange(dplyr::desc(key))
```