# methcp: User’s Guide

Boying Gong

#### 2020-04-07

# 1 Introduction

`methcp` is a differentially methylated region
(DMR) detecting method for whole-genome bisulfite sequencing (WGBS)
data. It is applicable for a wide range of experimental designs.
In this document, we provide examples for two-group comparisons and
time-course analysis.

`methcp` identifies DMRs based on change point detection, which
naturally segments the genome and provides region-level
differential analysis. We direct the interested reader to our paper
[here](https://link.springer.com/chapter/10.1007/978-3-030-17083-7_5)

Load packages.

```
library(bsseq)
library(MethCP)
```

# 2 Two-group comparison

In this section, we use the CpG methylation data from an Arabidopsis dataset
available from GEO with accession number
[GSM954584](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM954584). We
take a subset of chromosome 1 and 2 from each of the samples and perform
differential analysis between the wild-type plants and the H2A.Z mutant
plants, which we refer to as `treatment` and `control` in the rest of
the document.

## 2.1 Read data

We use a well-developed Bioconductor package `bsseq` to load the store the raw
data. Below is an example of how to read raw counts using `bsseq`.

We provide a helper function `createBsseqObject` to create a bsseq object
when the data for each sample is stored in a separate text file.

For more operations regarding the `bsseq` object, or to create a `bsseq`
object customized to your file format, please refer to their
[User’s Guide](http://bioconductor.org/packages/release/bioc/html/bsseq.html).

```
# The dataset is consist of 6 samples. 3 samples are H2A.Z mutant
# plants, and 3 samples are controls.
sample_names <- c(
    paste0("control", seq_len(3)),
    paste0("treatment", seq_len(3))
)

# Get the vector of file path and names
raw_files <- system.file(
    "extdata", paste0(sample_names, ".txt"), package = "MethCP")

# load the data
bs_object <- createBsseqObject(
    files = raw_files, sample_names = sample_names,
    chr_col = 'Chr', pos_col = 'Pos', m_col = "M", cov_col = 'Cov')
```

The `bsseq` object.

```
bs_object
```

```
## An object of type 'BSseq' with
##   82103 methylation loci
##   6 samples
## has not been smoothed
## All assays are in-memory
```

Header of the raw file for one of the samples.

```
dt <- read.table(
            raw_files[1], stringsAsFactors = FALSE, header = TRUE)
head(dt)
```

```
##    Chr Pos M Cov
## 1 chr1 109 3   3
## 2 chr1 110 4   4
## 3 chr1 115 3   3
## 4 chr1 116 4   4
## 5 chr1 161 0   1
## 6 chr1 162 1   1
```

## 2.2 Calculate the statistics

We calculate the per-cytosine statistics using two different test `DSS` and
`methylKit` using the function `calcLociStat`. This function returns a
`MethCP` object that is used for the future segmentation step. We allow
parallelized computing when there are multiple chromosomes in the dataset.

```
# the sample names of the two groups to compare. They should be subsets of the
# sample names provided when creating the `bsseq` objects.
group1 <- paste0("control", seq_len(3))
group2 <- paste0("treatment", seq_len(3))

# Below we calculate the per-cytosine statistics using two different
# test `DSS` and `methylKit`. The users may pick one of the two for their
#  application.
obj_DSS <- calcLociStat(bs_object, group1, group2, test = "DSS")
obj_methylKit <- calcLociStat(
    bs_object, group1, group2, test = "methylKit")
```

```
obj_DSS
```

```
## MethCP object with 2 chromosomes, 79351 methylation loci
## test: DSS
## group1: control1 control2 control3
## group2: treatment1 treatment2 treatment3
## has not been segmented
```

```
obj_methylKit
```

```
## MethCP object with 2 chromosomes, 81936 methylation loci
## test: methylKit
## group1: control1 control2 control3
## group2: treatment1 treatment2 treatment3
## has not been segmented
```

In cases the user wants to use their pre-calculated test statistics for
experiments other than two-group comparison and time course data, we use the
calculated statistics and create a `MethCP` object.

```
data <- data.frame(
    chr = rep("Chr01", 5),
    pos = c(2, 5, 9, 10, 18),
    effect.size = c(1,-1, NA, 9, Inf),
    pvals = c(0, 0.1, 0.9, NA, 0.02))
obj <- MethCPFromStat(
    data, test.name="myTest",
    pvals.field = "pvals",
    effect.size.field="effect.size",
    seqnames.field="chr",
    pos.field="pos"
)
```

```
## Filtering out NAs and infinite values.
## Cytosine counts before filtering: 5.
## Cytosine counts after filtering: 3.
```

```
obj
```

```
## MethCP object with 1 chromosomes, 3 methylation loci
## test: myTest
## group1: notApplicable
## group2: notApplicable
## has not been segmented
```

## 2.3 Segmentation

`segmentMethCP` performs segmentation on a `MethCP` object. We allow
parallelized computing when there are multiple chromosomes in the dataset.
Different from `calcLociStat` function in the previous section, we do not put
any constraint on the number of cores used. Please see the documentation for
adjusting the parameters used in the segmentation.

```
obj_DSS <- segmentMethCP(
    obj_DSS, bs_object, region.test = "weighted-coverage")

obj_methylKit <- segmentMethCP(
    obj_methylKit, bs_object, region.test = "fisher")
```

```
obj_DSS
```

```
## MethCP object with 2 chromosomes, 79351 methylation loci
## test: DSS
## group1: control1 control2 control3
## group2: treatment1 treatment2 treatment3
## has been segmented
```

```
obj_methylKit
```

```
## MethCP object with 2 chromosomes, 81936 methylation loci
## test: methylKit
## group1: control1 control2 control3
## group2: treatment1 treatment2 treatment3
## has been segmented
```

## 2.4 Significant regions

Use function `getSigRegion` on a `MethCP` object to get the list of DMRs.

```
region_DSS <- getSigRegion(obj_DSS)
head(region_DSS)
```

```
##      seqnames  start    end nC.valid nC mean.diff mean.cov  region.pval
## 1.1      chr1    109    512       11 12    0.3924   3.3636 1.602589e-04
## 1.4      chr1  26852  27083       11 11   -0.3096   6.6667 3.525229e-08
## 1.17     chr1  47817  47966       15 16   -0.2058   7.6111 8.381894e-05
## 1.26     chr1  65562  65735       10 10   -0.5742   5.2167 0.000000e+00
## 2.8      chr1  94712  95021       12 12    0.1304   7.9444 8.214642e-05
## 3.6      chr1 115200 115276       10 10   -0.3957   8.1833 3.345990e-12
```

```
region_methylKit <- getSigRegion(obj_methylKit)
head(region_methylKit)
```

```
##      seqnames start   end nC.valid nC mean.diff mean.cov  region.pval
## 1.2      chr1 26853 27083       10 10   -0.3126   6.8500 6.306067e-14
## 1.5      chr1 30691 30768       11 11   -0.1776   8.3788 4.028997e-05
## 1.13     chr1 47817 47966       16 16   -0.2058   7.1354 4.314515e-08
## 1.21     chr1 65562 65735       10 10   -0.5742   5.2167 0.000000e+00
## 1.36     chr1 92672 92891       10 10    0.4067   8.9667 0.000000e+00
## 1.38     chr1 94712 95021       12 12    0.1304   7.9444 1.295822e-10
```

# 3 A time-course example

MethCP is flexible for a wide variety of experimental designs. We apply MethCP
on an Arabidopsis thaliana seed germination dataset available from the GEO
with accession number
[https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE94712](GSE94712)
The data is generated from two replicates of dry seed and germinating seeds of
wild-type plants (Col-0) and ros1 dml2 dml3 (rdd) triple demethylase mutant
plants at 0-4 days after imbibition for 4 days (DAI). For cytosine-based
statistics, we fit linear models on the methylation ratios and test the
differences between the time coefficient of condition Col-0 and condition rdd.

Read the meta data.

```
meta_file <- system.file(
    "extdata", "meta_data.txt", package = "MethCP")
meta <- read.table(meta_file, sep = "\t", header = TRUE)

head(meta)
```

```
##   Condition TimeName Time Replicate                  SampleName
## 1     Col-0       DS    0         1   GSM2481288_mC_Col-0_DS_r1
## 2     Col-0       DS    0         2   GSM2481289_mC_Col-0_DS_r2
## 3     Col-0     0DAI    1         1 GSM2481290_mC_Col-0_0DAI_r1
## 4     Col-0     0DAI    1         2 GSM2481291_mC_Col-0_0DAI_r2
## 5     Col-0     1DAI    2         1 GSM2481292_mC_Col-0_1DAI_r1
## 6     Col-0     1DAI    2         2 GSM2481293_mC_Col-0_1DAI_r2
```

Read the counts data.

```
# Get the vector of file path and names
raw_files <- system.file(
    "extdata", paste0(meta$SampleName, ".tsv"), package = "MethCP")

# read files
bs_object <- createBsseqObject(
    files = raw_files, sample_names = meta$SampleName,
    chr_col = 1, pos_col = 2, m_col = 4, cov_col = 5, header = TRUE)
```

Apply coverage filter to make sure each loci has total coverage (summed across
samples) more than 3 for each condition.

```
groups <- split(seq_len(nrow(meta)), meta$Condition)
coverages <- as.data.frame(getCoverage(bs_object, type = "Cov"))
filter <- rowSums(coverages[, meta$SampleName[groups[[1]]]] != 0) >= 3 &
    rowSums(coverages[, meta$SampleName[groups[[2]]]] != 0) >= 3
bs_object <- bs_object[filter, ]
```

Calculate the statistics. A dataframe of the meta data will be passed to
function `calcLociStatTimeCourse`. Note that there must be columns named
`Condition`, `Time` and `SampleName` in the dataframe.

```
obj <- calcLociStatTimeCourse(bs_object, meta)
```

```
obj
```

```
## MethCP object with 1 chromosomes, 26001 methylation loci
## test: TimeCourse
## group1: GSM2481288_mC_Col-0_DS_r1 GSM2481289_mC_Col-0_DS_r2 GSM2481290_mC_Col-0_0DAI_r1 GSM2481291_mC_Col-0_0DAI_r2 GSM2481292_mC_Col-0_1DAI_r1 GSM2481293_mC_Col-0_1DAI_r2 GSM2481294_mC_Col-0_2DAI_r1 GSM2481295_mC_Col-0_2DAI_r2 GSM2481296_mC_Col-0_3DAI_r1 GSM2481297_mC_Col-0_3DAI_r2 GSM2481298_mC_Col-0_4DAI_r1 GSM2481299_mC_Col-0_4DAI_r2
## group2: GSM2481300_mC_rdd_DS_r1 GSM2481301_mC_rdd_DS_r2 GSM2481302_mC_rdd_0DAI_r1 GSM2481303_mC_rdd_0DAI_r2 GSM2481304_mC_rdd_1DAI_r1 GSM2481305_mC_rdd_1DAI_r2 GSM2481306_mC_rdd_2DAI_r1 GSM2481307_mC_rdd_2DAI_r2 GSM2481308_mC_rdd_3DAI_r1 GSM2481309_mC_rdd_3DAI_r2 GSM2481310_mC_rdd_4DAI_r1 GSM2481311_mC_rdd_4DAI_r2
## has not been segmented
```

Segmentation.

```
obj <- segmentMethCP(obj, bs_object, region.test = "stouffer")
```

Get the DMRs.

```
regions <- getSigRegion(obj)
```

```
head(regions)
```

```
##     seqnames   start     end nC.valid  nC mean.diff mean.cov  region.pval
## 31         1  238367  239326       69  69   -0.1042   5.7144 0.0012861236
## 66         1  394175  395220       50  50   -0.2490   3.9292 0.0026789957
## 70         1  405983  408116       52  52   -0.1079   6.3197 0.0082183067
## 92         1  531037  532534       36  36   -0.1900   4.3507 0.0007397345
## 187        1  962256  966028      145 145   -0.1049   5.9529 0.0029463070
## 241        1 1258866 1259519       30  30   -0.1454   5.6153 0.0028433185
```

# 4 Session info

```
sessionInfo()
```

```
## R version 3.6.3 (2020-02-29)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.4 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.10-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.10-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] MethCP_1.0.2                bsseq_1.22.0
##  [3] SummarizedExperiment_1.16.1 DelayedArray_0.12.2
##  [5] BiocParallel_1.20.1         matrixStats_0.56.0
##  [7] Biobase_2.46.0              GenomicRanges_1.38.0
##  [9] GenomeInfoDb_1.22.1         IRanges_2.20.2
## [11] S4Vectors_0.24.3            BiocGenerics_0.32.0
## [13] BiocStyle_2.14.4
##
## loaded via a namespace (and not attached):
##  [1] splines_3.6.3            DelayedMatrixStats_1.8.0 R.utils_2.9.2
##  [4] gtools_3.8.2             assertthat_0.2.1         BiocManager_1.30.10
##  [7] BSgenome_1.54.0          GenomeInfoDbData_1.2.2   Rsamtools_2.2.3
## [10] yaml_2.2.1               pillar_1.4.3             numDeriv_2016.8-1.1
## [13] lattice_0.20-41          glue_1.4.0               limma_3.42.2
## [16] bbmle_1.0.23.1           digest_0.6.25            XVector_0.26.0
## [19] qvalue_2.18.0            colorspace_1.4-1         htmltools_0.4.0
## [22] Matrix_1.2-18            R.oo_1.23.0              plyr_1.8.6
## [25] pkgconfig_2.0.3          XML_3.99-0.3             emdbook_1.3.12
## [28] DSS_2.34.0               bookdown_0.18            zlibbioc_1.32.0
## [31] purrr_0.3.3              mvtnorm_1.1-0            scales_1.1.0
## [34] HDF5Array_1.14.3         tibble_3.0.0             ggplot2_3.3.0
## [37] ellipsis_0.3.0           cli_2.0.2                mclust_5.4.5
## [40] crayon_1.3.4             magrittr_1.5             evaluate_0.14
## [43] R.methodsS3_1.8.0        fansi_0.4.1              MASS_7.3-51.5
## [46] tools_3.6.3              data.table_1.12.8        lifecycle_0.2.0
## [49] stringr_1.4.0            Rhdf5lib_1.8.0           munsell_0.5.0
## [52] locfit_1.5-9.4           Biostrings_2.54.0        compiler_3.6.3
## [55] fastseg_1.32.0           rlang_0.4.5              rhdf5_2.30.1
## [58] grid_3.6.3               RCurl_1.98-1.1           methylKit_1.12.0
## [61] bitops_1.0-6             rmarkdown_2.1            DNAcopy_1.60.0
## [64] gtable_0.3.0             reshape2_1.4.3           R6_2.4.1
## [67] GenomicAlignments_1.22.1 dplyr_0.8.5              knitr_1.28
## [70] rtracklayer_1.46.0       bdsmatrix_1.3-4          permute_0.9-5
## [73] stringi_1.4.6            Rcpp_1.0.4               vctrs_0.2.4
## [76] tidyselect_1.0.0         xfun_0.12                coda_0.19-3
```