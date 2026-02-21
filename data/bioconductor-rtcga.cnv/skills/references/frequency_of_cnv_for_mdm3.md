# Using `RTCGA` package to estimate a frequency of MDM2 duplications based on CNV data

#### Przemyslaw Biecek

#### 2025-11-04

# RTCGA.cnv package

You need RTCGA.cnv package to use CNV scores.

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("RTCGA.cnv")
```

# MDM2

To get scores for all cancers for selected gene or region one should use the get.region.cnv.score() function.

For example, MDM2 is located on chromosome 12 positions 69240000-69200000.

```
get.region.cnv.score <- function(chr="12", start=69240000, stop=69200000) {
  list_cnv <- data(package="RTCGA.cnv")
  datasets <- list_cnv$results[,"Item"]

  filtered <- lapply(datasets, function(dataname) {
    tmp <- get(dataname)
    tmp <- tmp[tmp$Chromosome == chr,]
    tmp <- tmp[pmin(tmp$Start, tmp$End) <= pmax(stop, start) & pmax(tmp$Start, tmp$End) >= pmin(stop, start),]
    data.frame(tmp, cohort=dataname)
  })

  do.call(rbind, filtered)
}
MDM2.scores <- get.region.cnv.score(chr="12", start=69240000, stop=69200000)

# only one per patient
MDM2.scores$Sample <- substr(MDM2.scores$Sample, 1, 12)
MDM2.scores <- MDM2.scores[!duplicated(MDM2.scores$Sample),]
```

Let’s see where there are more than 3 copies of MDM2

```
cutoff <- log(3)/log(2)-1
MDM2cuted <- cut(MDM2.scores$Segment_Mean, c(0, cutoff, Inf), labels = c("<= 3", "> 3"))
```

And now we can calculate number of cases with <= or >3 copies od MDM2 in each cancer type.

```
table(MDM2.scores$cohort, MDM2cuted)
```