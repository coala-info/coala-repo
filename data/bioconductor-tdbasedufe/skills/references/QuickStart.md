# QuickStart

Y-h. Taguchi

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
* [3 Data Analyses](#data-analyses)
  + [3.1 Gene expression.](#gene-expression.)
  + [3.2 Multiomics data analysis](#multiomics-data-analysis)
* [4 Conclusion](#conclusion)

# 1 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("TDbasedUFE")
```

# 2 Introduction

```
library(TDbasedUFE)
```

Here I introduce how we can use TDbasedUFE to process real data.

# 3 Data Analyses

## 3.1 Gene expression.

Here is how we can process real data. First we prepare the data set from
tximportdata package

```
require(GenomicRanges)
#> Loading required package: GenomicRanges
#> Loading required package: stats4
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: Seqinfo
require(rTensor)
#> Loading required package: rTensor
#>
#> Attaching package: 'rTensor'
#> The following object is masked from 'package:S4Vectors':
#>
#>     fold
library("readr")
library("tximport")
library("tximportData")
dir <- system.file("extdata", package="tximportData")
samples <- read.table(file.path(dir,"samples.txt"), header=TRUE)
samples$condition <- factor(rep(c("A","B"),each=3))
rownames(samples) <- samples$run
samples[,c("pop","center","run","condition")]
#>           pop center       run condition
#> ERR188297 TSI  UNIGE ERR188297         A
#> ERR188088 TSI  UNIGE ERR188088         A
#> ERR188329 TSI  UNIGE ERR188329         A
#> ERR188288 TSI  UNIGE ERR188288         B
#> ERR188021 TSI  UNIGE ERR188021         B
#> ERR188356 TSI  UNIGE ERR188356         B
files <- file.path(dir,"salmon", samples$run, "quant.sf.gz")
names(files) <- samples$run
tx2gene <- read_csv(file.path(dir, "tx2gene.gencode.v27.csv"))
#> Rows: 200401 Columns: 2
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr (2): TXNAME, GENEID
#>
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
txi <- tximport(files, type="salmon", tx2gene=tx2gene)
#> reading in files with read_tsv
#> 1 2 3 4 5 6
#> summarizing abundance
#> summarizing counts
#> summarizing length
```

As can be seen on the above, this data set is composed of six samples, which
are divided into two classes, each of which includes three out of six samples.
The number of features is 58288

```
dim(txi$counts)
#> [1] 58288     6
```

which is too many to execute small desktops, we reduce number of features to
10,000

```
txi[seq_len(3)] <-
    lapply(txi[seq_len(3)],
    function(x){dim(x);x[seq_len(10000),]})
```

Then we reformat count data, txi$counts, as a tensor, \(Z\), whose dimension is
\(10000 \times 3 \times 2\) and HOSVD was applied to \(Z\) to get tensor
decomposition using function computeHosvd.

```
Z <- PrepareSummarizedExperimentTensor(matrix(samples$sample,c(3,2)),
    rownames(txi$abundance),array(txi$counts,c(dim(txi$counts)[1],3,2)))
dim(attr(Z,"value"))
#> [1] 10000     3     2
HOSVD <- computeHosvd(Z)
#>
  |
  |                                                                      |   0%
  |
  |=======================                                               |  33%
  |
  |===============================================                       |  67%
  |
  |======================================================================| 100%
```

Here 3 and 2 stand for the number of samples in each class and the number of
classes, respectively. HOSVD includes output from HOSVD. Next, we need to decide
which singular value vectors are used for the download analysis interactively.
Since vignettes has no ability to store the output from interactive output from
R, you have to input here as

```
input_all <- selectSingularValueVectorSmall(HOSVD,input_all= c(1,2)) #batch mode
```

![](data:image/png;base64...)![](data:image/png;base64...)
in batch mode. Then you get the above graphic. In actual usage you can
activate interactive mode as

```
input_all <- selectSingularValueVectorSmall(HOSVD)
```

In interactive mode, you can see “Next”, “Prev” and “Select” radio buttons by
which you can select singular value vectors one by one interactively.
Now 1 and 2 is entered in input\_all, since these correspond to constant among
three samples (AAA or BBB) and distinction between A and B, respectively.

Then we try to select features.

```
index <- selectFeature(HOSVD,input_all)
```

![](data:image/png;base64...)
We get the above graphic. The left one represents the dependence of “flatness”
of histogram of \(P\)-values computed with assuming the null hypothesis. More or
less it can select smallest value. Thus it is successful. The right one
represents the histogram of 1-\(P\)-values. Peak at right end corresponds
to genes selected (The peak at the left end does not have any meaning since
they corresponds to \(P \simeq 1\)).
Then we try to see top ranked features

```
head(tableFeatures(Z,index))
#>                Feature p value adjusted p value
#> 11   ENSG00000008988.9       0                0
#> 40   ENSG00000044574.7       0                0
#> 89  ENSG00000075618.17       0                0
#> 90  ENSG00000075624.13       0                0
#> 104 ENSG00000080824.18       0                0
#> 118 ENSG00000086758.15       0                0
```

These are associated with \(P=0\). Thus, successful.

## 3.2 Multiomics data analysis

Next we try to see how we can make use of TDbasedUFE to perform multiomics
analyses. In order that, we prepare data set using MOFAdata package as follows.

```
require(MOFAdata)
#> Loading required package: MOFAdata
data("CLL_data")
data("CLL_covariates")
help(CLL_data)
```

CLL\_data is composed of four omics data,

* Drugs: viability values in response to 310 different drugs and concentrations
* Methylation: methylation M-values for the 4248 most variable CpG sites
* mRNA: normalized expression values for the 5000 most variable genes
* Mutations: Mutation status for 69 selected genes

each of which was converted to squared matrix (i. e., liner
kernel(Taguchi and Turki [2022](#ref-Taguchi2022b)))and they are bundle as one tensor using
PrepareSummarizedExperimentTensorSquare function, to which HOSVD is
applied as follows.

```
Z <- PrepareSummarizedExperimentTensorSquare(
    sample=matrix(colnames(CLL_data$Drugs),1),
    feature=list(Drugs=rownames(CLL_data$Drugs),
    Methylation=rownames(CLL_data$Methylation),
    mRNA=rownames(CLL_data$mRNA),Mutations=rownames(CLL_data$Mutations)),
    value=convertSquare(CLL_data),sampleData=list(CLL_covariates[,1]))
HOSVD <- computeHosvdSqure(Z)
#>
  |
  |                                                                      |   0%
  |
  |=======================                                               |  33%
  |
  |===============================================                       |  67%
  |
  |======================================================================| 100%
```

CLL\_covariate is labeling information, among which we employed the distinction
between male (m) and female (f).

```
table(CLL_covariates[,1])
#>
#>   f   m
#>  79 121
cond <- list(attr(Z,"sampleData")[[1]],attr(Z,"sampleData")[[1]],seq_len(4))
```

Since a tensor is a bundle of liner kernel, the first two singular value
vectors are dedicated to samples and the third (last) one is dedicated to four
omics classes (Drugs, Methylation, mRNA and mutations). In order to select
which singular value vectors are employed, we execute selectFeatureSquare
function in batch mode as follows

```
input_all <- selectSingularValueVectorLarge(HOSVD,cond,input_all=c(8,1))
```

![](data:image/png;base64...)![](data:image/png;base64...)
In actual usage you can activate interactive mode as

```
input_all <- selectSingularValueVectorLarge(HOSVD,cond)
```

and can select the eight singular value vetor for samples that represents
distinction between male and female and the first singular value vectors
to four omics categories that represents the commoness between four omics
data (i.e., constant values for four omics data).

Now we come to the stage to select features. Since there are four features,
we need to optimize SD for each of them. Try to execute selectFeatureSquare
in a batch mode as follows.

```
index <- selectFeatureSquare(HOSVD,input_all,CLL_data,
    de=c(0.3,0.03,0.1,0.1),interact=FALSE) #for batch mode
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)
In actual usage, you can activate interctive mode

```
index <- selectFeatureSquare(HOSVD,input_all,CLL_data,
        de=c(0.3,0.03,0.1,0.1))
```

to see these plots one by one if you hope.
In the above, de=c(0.3,0.03,0.1,0.1) represents initial SD for the optimization
of SD for each of four omics. There might be need for some trial & errors to
get good initial values. Every time you type enter in an interactive mode,
you can see one of four plots for four omics data.

Now the output includes four lists each of which corresponds to one of four
omics data. Each list is composed of two vectors whose length is equivalent to
the number of features in each of omics data. Two vectors, index and p.value,
stores logical vector that shows if individual features are selected and raw
\(P\)-values.

In order to see selected features for all four omics data, tableFeatureSquare
function must be repeated four times as

```
for (id in seq_len(4)){print(head(tableFeaturesSquare(Z,index,id)))}
#> [1] Feature          p value          adjusted p value
#> <0 rows> (or 0-length row.names)
#> [1] Feature          p value          adjusted p value
#> <0 rows> (or 0-length row.names)
#>            Feature      p value adjusted p value
#> 4  ENSG00000152953 9.669707e-13     4.834854e-09
#> 3  ENSG00000163873 1.369068e-10     3.422671e-07
#> 7  ENSG00000169398 2.841302e-09     4.735504e-06
#> 2  ENSG00000095777 3.955241e-09     4.944052e-06
#> 9  ENSG00000180287 9.636882e-08     9.636882e-05
#> 11 ENSG00000186567 2.325751e-07     1.938126e-04
#>        Feature      p value adjusted p value
#> 1   del11q22.3 3.499307e-24     2.414522e-22
#> 6        SF3B1 1.334788e-15     4.605018e-14
#> 3 del13q14_any 9.427628e-10     2.168355e-08
#> 5       NOTCH1 3.071643e-09     5.298584e-08
#> 7         IGHV 4.023699e-07     5.552704e-06
#> 4     del17p13 9.697530e-06     1.115216e-04
```

# 4 Conclusion

In this vignettes, we briefly introduce how we can make use of TDbasedUFE to
perform gene expression analysis and multiomics analysis. I am glad if you can
make use of it as well for your own research.

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] MOFAdata_1.25.0      tximportData_1.37.5  tximport_1.38.0
#>  [4] readr_2.1.5          rTensor_1.4.9        GenomicRanges_1.62.0
#>  [7] Seqinfo_1.0.0        IRanges_2.44.0       S4Vectors_0.48.0
#> [10] BiocGenerics_0.56.0  generics_0.1.4       TDbasedUFE_1.10.0
#> [13] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10         hms_1.1.4           digest_0.6.37
#>  [4] magrittr_2.0.4      evaluate_1.0.5      bookdown_0.45
#>  [7] fastmap_1.2.0       jsonlite_2.0.0      promises_1.4.0
#> [10] BiocManager_1.30.26 jquerylib_0.1.4     cli_3.6.5
#> [13] shiny_1.11.1        rlang_1.1.6         crayon_1.5.3
#> [16] bit64_4.6.0-1       cachem_1.1.0        yaml_2.3.10
#> [19] otel_0.2.0          tools_4.5.1         parallel_4.5.1
#> [22] tzdb_0.5.0          httpuv_1.6.16       vctrs_0.6.5
#> [25] R6_2.6.1            mime_0.13           lifecycle_1.0.4
#> [28] bit_4.6.0           vroom_1.6.6         archive_1.1.12
#> [31] pkgconfig_2.0.3     pillar_1.11.1       bslib_0.9.0
#> [34] later_1.4.4         glue_1.8.0          Rcpp_1.1.0
#> [37] xfun_0.53           tibble_3.3.0        tidyselect_1.2.1
#> [40] knitr_1.50          xtable_1.8-4        htmltools_0.5.8.1
#> [43] rmarkdown_2.30      compiler_4.5.1
```

Taguchi, Y-h, and Turki Turki. 2022. “Novel feature selection method via kernel tensor decomposition for improved multi-omics data analysis.” *BMC Medical Genomics* 15 (1): 37. <https://doi.org/10.1186/s12920-022-01181-4>.