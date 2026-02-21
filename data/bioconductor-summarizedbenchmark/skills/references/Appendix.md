# SummarizedBenchmark

Patrick K. Kimes, Alejandro Reyes

#### *20 January 2019*

#### Abstract

“”

#### Package

SummarizedBenchmark 2.0.1

# Contents

* [1 Data objects](#data-objects)
  + [1.1 Preparing the data from Soneson et al.](#preparing-the-data-from-soneson-et-al.)
* [2 Non-Standard Use](#non-standard-use)
  + [2.1 Manually Constructing a SummarizedBenchmark](#manually-constructing-a-summarizedbenchmark)

# 1 Data objects

## 1.1 Preparing the data from Soneson et al.

The data is available for download from ArrayExpress. Expression data for each sample is provided in the RSEM output format. Corresponding information for the ground truth underlying the simulated data is also available, including transcript differential expression status.

First, we download and import the transcript-level TPM values using the tximport 1.10.1 package.

```
d <- tempdir()
download.file(url = paste0("https://www.ebi.ac.uk/arrayexpress/files/",
                           "E-MTAB-4119/E-MTAB-4119.processed.3.zip"),
              destfile = file.path(d, "samples.zip"))
unzip(file.path(d, "samples.zip"), exdir = d)

fl <- list.files(d, pattern = "*_rsem.txt", full.names=TRUE)
names(fl) <- gsub("sample(.*)_rsem.txt", "\\1", basename(fl))
library(tximport)
library(readr)

txi <- tximport(fl, txIn = TRUE, txOut = TRUE,
                geneIdCol = "gene_id",
                txIdCol = "transcript_id",
                countsCol = "expected_count",
                lengthCol = "effective_length",
                abundanceCol = "TPM",
                countsFromAbundance = "scaledTPM",
                importer = function(x){ read_tsv(x) })
```

```
## 1 Parsed with column specification:
## cols(
##   transcript_id = col_character(),
##   gene_id = col_character(),
##   length = col_double(),
##   effective_length = col_double(),
##   expected_count = col_double(),
##   TPM = col_double(),
##   FPKM = col_double(),
##   IsoPct = col_double()
## )
## 2 Parsed with column specification:
## cols(
##   transcript_id = col_character(),
##   gene_id = col_character(),
##   length = col_double(),
##   effective_length = col_double(),
##   expected_count = col_double(),
##   TPM = col_double(),
##   FPKM = col_double(),
##   IsoPct = col_double()
## )
## 3 Parsed with column specification:
## cols(
##   transcript_id = col_character(),
##   gene_id = col_character(),
##   length = col_double(),
##   effective_length = col_double(),
##   expected_count = col_double(),
##   TPM = col_double(),
##   FPKM = col_double(),
##   IsoPct = col_double()
## )
## 4 Parsed with column specification:
## cols(
##   transcript_id = col_character(),
##   gene_id = col_character(),
##   length = col_double(),
##   effective_length = col_double(),
##   expected_count = col_double(),
##   TPM = col_double(),
##   FPKM = col_double(),
##   IsoPct = col_double()
## )
## 5 Parsed with column specification:
## cols(
##   transcript_id = col_character(),
##   gene_id = col_character(),
##   length = col_double(),
##   effective_length = col_double(),
##   expected_count = col_double(),
##   TPM = col_double(),
##   FPKM = col_double(),
##   IsoPct = col_double()
## )
## 6 Parsed with column specification:
## cols(
##   transcript_id = col_character(),
##   gene_id = col_character(),
##   length = col_double(),
##   effective_length = col_double(),
##   expected_count = col_double(),
##   TPM = col_double(),
##   FPKM = col_double(),
##   IsoPct = col_double()
## )
```

Next, we obtain and load the ground truth information that can be used for evaluating the results of the differential expression analysis.

```
download.file(url = paste0("https://www.ebi.ac.uk/arrayexpress/files/",
                           "E-MTAB-4119/E-MTAB-4119.processed.2.zip"),
              destfile = file.path(d, "truth.zip"))
unzip(file.path(d, "truth.zip"), exdir = d)

truthdat <- read_tsv(file.path(d, "truth_transcript.txt"))
```

```
## Parsed with column specification:
## cols(
##   transcript = col_character(),
##   status = col_double(),
##   logFC_cat = col_character(),
##   logFC = col_double(),
##   avetpm = col_double(),
##   length = col_double(),
##   eff_length = col_double(),
##   tpm1 = col_double(),
##   tpm2 = col_double(),
##   isopct1 = col_double(),
##   isopct2 = col_double(),
##   gene = col_character(),
##   avetpm_cat = col_character()
## )
```

```
#save( txi, truthdat, file="../data/soneson2016.rda" )
```

# 2 Non-Standard Use

## 2.1 Manually Constructing a SummarizedBenchmark

So far, this vignette has shown the recommended use of *SummarizedBenchmark*, that enables users to perform benchmarks automatically keeping track of parameters and software versions. However, users can also construct *SummarizedBenchmark* objects from standard `S3` data objects.

Using data from the *[iCOBRA](https://bioconductor.org/packages/3.8/iCOBRA)*package [@Soneson\_2016], this part of the vignette demonstrates how to build *SummarizedBenchmark* objects from `S3` objects. The dataset contains differential expression results of three different methods (*[limma](https://bioconductor.org/packages/3.8/limma)*, *[edgeR](https://bioconductor.org/packages/3.8/edgeR)* and *[DESeq2](https://bioconductor.org/packages/3.8/DESeq2)*) applied to a simulated RNA-seq dataset.

```
library(iCOBRA)
data(cobradata_example)
```

The process of building a *SummarizedBenchmark* object is similar to the one used to construct a *SummarizedExperiment* object. To build a *SummarizedBenchmark* object, three main objects are required (1) a list where each element corresponds to a *data.frame*, (2) a *DataFrame* with annotations of the methods and (3) when available, a *DataFrame* of ground truths.

In the *SummarizedBenchmark* object, each output of the methods is considered a different `assay`. For example, using the differential expression dataset example, we can define two assays, q-values and estimated log fold changes. For each `assay`, we arrange the output of the different methods as a matrix where each column corresponds to a method and each row corresponds to each feature (in this case, genes). We will need a list in which each of it’s element corresponds to an assay.

```
assays <- list(
  qvalue=cobradata_example@padj,
  logFC=cobradata_example@score )
assays[["qvalue"]]$DESeq2 <- p.adjust(cobradata_example@pval$DESeq2, method="BH")
head( assays[["qvalue"]], 3)
```

```
##                     edgeR      voom     DESeq2
## ENSG00000000457 0.2833295 0.1375146 0.04760152
## ENSG00000000460 0.2700376 0.2826398 0.08717737
## ENSG00000000938 0.9232794 0.9399669 0.99856748
```

```
head( assays[["logFC"]], 3)
```

```
##                      edgeR       voom      DESeq2
## ENSG00000000457 0.22706080 0.23980596 0.274811698
## ENSG00000000460 0.31050478 0.27677537 0.359226203
## ENSG00000000938 0.04985025 0.03344113 0.001526355
```

Since these are simulated data, the ground truths for both assays are known. We can format these as a *DataFrame* where each column corresponds to an assay and each row corresponds to a feature.

```
library(S4Vectors)
```

```
## Loading required package: stats4
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: parallel
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:parallel':
##
##     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
##     clusterExport, clusterMap, parApply, parCapply, parLapply,
##     parLapplyLB, parRapply, parSapply, parSapplyLB
```

```
## The following objects are masked from 'package:iCOBRA':
##
##     score, score<-
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, append,
##     as.data.frame, basename, cbind, colMeans, colSums, colnames,
##     dirname, do.call, duplicated, eval, evalq, get, grep, grepl,
##     intersect, is.unsorted, lapply, lengths, mapply, match, mget,
##     order, paste, pmax, pmax.int, pmin, pmin.int, rank, rbind,
##     rowMeans, rowSums, rownames, sapply, setdiff, sort, table,
##     tapply, union, unique, unsplit, which, which.max, which.min
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:base':
##
##     expand.grid
```

```
groundTruth <- DataFrame( cobradata_example@truth[,c("status", "logFC")] )
colnames(groundTruth) <- names( assays )
groundTruth <- groundTruth[rownames(assays[[1]]),]
head( groundTruth )
```

```
## DataFrame with 6 rows and 2 columns
##                    qvalue              logFC
##                 <integer>          <numeric>
## ENSG00000000457         0                  0
## ENSG00000000460         0                  0
## ENSG00000000938         0                  0
## ENSG00000000971         0                  0
## ENSG00000001460         1   3.93942204325368
## ENSG00000001461         1 0.0602244207363294
```

Then, the method names are also reformatted as a *DataFrame*

```
colData <- DataFrame( method=colnames(assays[[1]]) )
colData
```

```
## DataFrame with 3 rows and 1 column
##        method
##   <character>
## 1       edgeR
## 2        voom
## 3      DESeq2
```

A *SummarizedBenchmark* is build using the following command

```
library(SummarizedBenchmark)
```

```
## Loading required package: tidyr
```

```
##
## Attaching package: 'tidyr'
```

```
## The following object is masked from 'package:S4Vectors':
##
##     expand
```

```
## Loading required package: SummarizedExperiment
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: IRanges
```

```
## Loading required package: GenomeInfoDb
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
## Loading required package: DelayedArray
```

```
## Loading required package: matrixStats
```

```
##
## Attaching package: 'matrixStats'
```

```
## The following objects are masked from 'package:Biobase':
##
##     anyMissing, rowMedians
```

```
## Loading required package: BiocParallel
```

```
##
## Attaching package: 'DelayedArray'
```

```
## The following objects are masked from 'package:matrixStats':
##
##     colMaxs, colMins, colRanges, rowMaxs, rowMins, rowRanges
```

```
## The following objects are masked from 'package:base':
##
##     aperm, apply
```

```
## Loading required package: UpSetR
```

```
## Loading required package: rlang
```

```
##
## Attaching package: 'rlang'
```

```
## The following object is masked from 'package:Biobase':
##
##     exprs
```

```
## Loading required package: stringr
```

```
## Loading required package: ggplot2
```

```
## Loading required package: mclust
```

```
## Package 'mclust' version 5.4.2
## Type 'citation("mclust")' for citing this R package in publications.
```

```
## Loading required package: dplyr
```

```
##
## Attaching package: 'dplyr'
```

```
## The following object is masked from 'package:matrixStats':
##
##     count
```

```
## The following object is masked from 'package:Biobase':
##
##     combine
```

```
## The following objects are masked from 'package:GenomicRanges':
##
##     intersect, setdiff, union
```

```
## The following object is masked from 'package:GenomeInfoDb':
##
##     intersect
```

```
## The following objects are masked from 'package:IRanges':
##
##     collapse, desc, intersect, setdiff, slice, union
```

```
## The following objects are masked from 'package:S4Vectors':
##
##     first, intersect, rename, setdiff, setequal, union
```

```
## The following objects are masked from 'package:BiocGenerics':
##
##     combine, intersect, setdiff, union
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
## Loading required package: digest
```

```
## Loading required package: sessioninfo
```

```
## Loading required package: crayon
```

```
##
## Attaching package: 'crayon'
```

```
## The following object is masked from 'package:ggplot2':
##
##     %+%
```

```
## The following object is masked from 'package:rlang':
##
##     chr
```

```
## Loading required package: tibble
```

```
##
## Attaching package: 'SummarizedBenchmark'
```

```
## The following object is masked _by_ '.GlobalEnv':
##
##     truthdat
```

```
sb <- SummarizedBenchmark(
  assays=assays,
  colData=colData,
  groundTruth=groundTruth )
```