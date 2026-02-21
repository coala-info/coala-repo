# Signal drift and batch effect correction for mass spectrometry

Andris Jankevics1\* and Ralf Johannes Maria Weber1\*\*

1Phenome Centre Birmingham, University of Birmingham, UK

\*a.jankevics@bham.ac.uk
\*\*r.j.weber@bham.ac.uk

#### 2025-11-11

#### Package

pmp 1.22.1

# 1 Introduction

This vignette demonstrates how to apply Quality Control-Robust Spline
Correction (QC-RSC) (Kirwan et al., [2013](#ref-kirwan2013)) algorithm for signal drift and batch effect
correction within/across a multi-batch direct infusion mass spectrometry (DIMS)
and liquid chromatography mass spectrometry (LCMS) datasets.

Please read “Signal drift and batch effect correction and mass spectral quality
assessment” vignette to learn how to assess your dataset and details on
algorithm itself.

# 2 Installation

You should have R version 4.0.0 or above and Rstudio installed to be able to
run this notebook.

Execute following commands from the R terminal.

```
install.packages("gridExtra")

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pmp")
```

Load the required libraries into the R environment

```
library(S4Vectors)
library(SummarizedExperiment)
library(pmp)
library(ggplot2)
library(reshape2)
library(gridExtra)
```

# 3 Dataset

In this tutorial we will be using a direct infusion mass spectrometry (DIMS)
dataset consisting of 172 samples measured across 8 batches and is included in
`pmp` package as `SummarizedExperiemnt` class object `MTBLS79`.
More detailed description of the dataset is available from Kirwan et al. ([2014](#ref-kirwan2014)),
[MTBLS79](https://www.ebi.ac.uk/metabolights/MTBLS79) and R man page.

```
help ("MTBLS79")
```

```
data("MTBLS79")

class <- MTBLS79$Class
batch <- MTBLS79$Batch
sample_order <- c(1:ncol(MTBLS79))

# Input data structure
MTBLS79
#> class: SummarizedExperiment
#> dim: 2488 172
#> metadata(0):
#> assays(1): ''
#> rownames(2488): 70.03364 70.03375 ... 569.36369 572.36537
#> rowData names(0):
#> colnames(172): batch01_QC01 batch01_QC02 ... Batch08_C09 Batch08_QC39
#> colData names(4): Batch Sample_Rep Class Class2

class[1:10]
#>  [1] "QC" "QC" "QC" "C"  "S"  "C"  "QC" "S"  "C"  "S"
batch[1:10]
#>  [1] "1" "1" "1" "1" "1" "1" "1" "1" "1" "1"
sample_order[1:10]
#>  [1]  1  2  3  4  5  6  7  8  9 10
```

# 4 Missing values

Current implementation of `QCRSC` algorithm does support missing values in the
input data object, but we would recommend to filter out features which were net
reproducibly measured across quality control (QC) sample. In this example we
will use 80% detection threshold.

```
data <- filter_peaks_by_fraction(df=MTBLS79, classes=class, method="QC",
    qc_label="QC", min_frac=0.8)
```

# 5 Applying signal drift and batch effect correction

Function `QCRSC` should be used to apply signal batch correction.

Argument `df` should be `SummarizedExperiment` object or matrix-like R data
structure with all `numeric()` values.

Argument `order` should be `numeric()` vector containing sample injection
order during analytical measurement and should be the same length as number of
sample in the input object.

Argument `batch` should be `numeric()` or `character()` vector containing values
of sample batch identifier. If all samples were measured in 1 batch, then all
values in the `batch` vector should be identical.

Values for `classes` should be character vector containing sample class labels.
Class label for quality control sample has to be `QC`.

```
corrected_data <- QCRSC(df=data, order=sample_order, batch=batch,
    classes=class, spar=0, minQC=4)
#> The number of NA and <= 0 values in peaksData before QC-RSC: 15330
```

# 6 Visual comparison of the results

Function ‘sbc\_plot’ provides visual comparison of the data before and after
correction. For example we can check output for features ‘1’, ‘5’, and ‘30’ in
peak matrix.

```
plots <- sbc_plot (df=MTBLS79, corrected_df=corrected_data, classes=class,
    batch=batch, output=NULL, indexes=c(1, 5, 30))
plots
#> [[1]]
```

![](data:image/png;base64...)

```
#>
#> [[2]]
```

![](data:image/png;base64...)

```
#>
#> [[3]]
```

![](data:image/png;base64...)

The scores plots of principal components analysis (PCA) before
and after correction can be used to asses effects of data correction.

In this example, probabilistic quotient normalisation (`PQN`) method is used to
normalise data, k-nearest neighbours (`KNN`) for missing value imputation and
`glog` for data scaling. All functions are availiable as a part of
*[pmp](https://bioconductor.org/packages/3.22/pmp)* package.

See Di Guida et al. ([2016](#ref-guida2016)) for a more detailed review on common pre-processing steps and
methods.

```
manual_color = c("#386cb0", "#ef3b2c", "#7fc97f", "#fdb462", "#984ea3",
    "#a6cee3", "#778899", "#fb9a99", "#ffff33")

pca_data <- pqn_normalisation(MTBLS79, classes=class, qc_label="QC")
pca_data <- mv_imputation(pca_data, method="KNN", k=5, rowmax=0.5,
    colmax=0.5, maxp=NULL, check_df=FALSE)
pca_data <- glog_transformation(pca_data, classes=class, qc_label="QC")

pca_corrected_data <- pmp::pqn_normalisation(corrected_data, classes=class,
    qc_label="QC")
pca_corrected_data <- pmp::mv_imputation(pca_corrected_data, method="KNN", k=5,
    rowmax=0.5, colmax=0.5, maxp=NULL, check_df=FALSE)
#> Warning in knnimp(x, k, maxmiss = rowmax, maxp = maxp): 8 rows with more than 50 % entries missing;
#>  mean imputation used for these rows
pca_corrected_data <- pmp::glog_transformation(pca_corrected_data,
    classes=class, qc_label="QC")

pca_data <- prcomp(t(assay(pca_data)), center=TRUE, scale=FALSE)
pca_corrected_data <- prcomp(t(assay(pca_corrected_data)),
    center=TRUE, scale=FALSE)

# Calculate percentage of explained variance of the first two PC's
exp_var_pca <- round(((pca_data$sdev^2)/sum(pca_data$sdev^2)*100)[1:2],2)
exp_var_pca_corrected <- round(((pca_corrected_data$sdev^2) /
    sum(pca_corrected_data$sdev^2)*100)[1:2],2)

plots <- list()

plotdata <- data.frame(PC1=pca_data$x[, 1], PC2=pca_data$x[, 2],
    batch=as.factor(batch), class=class)

plots[[1]] <- ggplot(data=plotdata, aes(x=PC1, y=PC2, col=batch)) +
    geom_point(size=2) + theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color) +
    ggtitle("PCA scores, before correction") +
    xlab(paste0("PC1 (", exp_var_pca[1] ," %)")) +
    ylab(paste0("PC2 (", exp_var_pca[2] ," %)"))

plots[[2]] <- ggplot(data=plotdata, aes(x=PC1, y=PC2, col=class)) +
    geom_point(size=2) + theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color) +
    ggtitle("PCA scores, before correction") +
    xlab(paste0("PC1 (", exp_var_pca[1] ," %)")) +
    ylab(paste0("PC2 (", exp_var_pca[2] ," %)"))

plotdata_corr <- data.frame(PC1=pca_corrected_data$x[, 1],
    PC2=pca_corrected_data$x[, 2], batch=as.factor(batch), class=class)

plots[[3]] <- ggplot(data=plotdata_corr, aes(x=PC1, y=PC2, col=batch)) +
    geom_point(size=2) +
    theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color) +
    ggtitle("PCA scores, after correction") +
    xlab(paste0("PC1 (", exp_var_pca_corrected[1] ," %)")) +
    ylab(paste0("PC2 (", exp_var_pca_corrected[2] ," %)"))

plots[[4]] <- ggplot(data=plotdata_corr, aes(x=PC1, y=PC2, col=class)) +
    geom_point(size=2) +
    theme(panel.background=element_blank()) +
    scale_color_manual(values=manual_color) +
    ggtitle("PCA scores, after correction") +
    xlab(paste0("PC1 (", exp_var_pca_corrected[1] ," %)")) +
    ylab(paste0("PC2 (", exp_var_pca_corrected[2] ," %)"))

grid.arrange(ncol=2, plots[[1]], plots[[2]], plots[[3]], plots[[4]])
```

![](data:image/png;base64...)

# 7 Session information

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
#>  [1] gridExtra_2.3               reshape2_1.4.4
#>  [3] ggplot2_4.0.0               SummarizedExperiment_1.40.0
#>  [5] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [7] Seqinfo_1.0.0               IRanges_2.44.0
#>  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [11] generics_0.1.4              MatrixGenerics_1.22.0
#> [13] matrixStats_1.5.0           pmp_1.22.1
#> [15] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6         impute_1.84.0        xfun_0.54
#>  [4] bslib_0.9.0          lattice_0.22-7       vctrs_0.6.5
#>  [7] tools_4.5.1          Rdpack_2.6.4         parallel_4.5.1
#> [10] missForest_1.6.1     tibble_3.3.0         pkgconfig_2.0.3
#> [13] Matrix_1.7-4         RColorBrewer_1.1-3   S7_0.2.0
#> [16] rngtools_1.5.2       lifecycle_1.0.4      stringr_1.6.0
#> [19] compiler_4.5.1       farver_2.1.2         tinytex_0.57
#> [22] codetools_0.2-20     htmltools_0.5.8.1    sass_0.4.10
#> [25] yaml_2.3.10          crayon_1.5.3         pillar_1.11.1
#> [28] jquerylib_0.1.4      DelayedArray_0.36.0  cachem_1.1.0
#> [31] magick_2.9.0         doRNG_1.8.6.2        iterators_1.0.14
#> [34] abind_1.4-8          foreach_1.5.2        nlme_3.1-168
#> [37] pcaMethods_2.2.0     tidyselect_1.2.1     digest_0.6.37
#> [40] stringi_1.8.7        dplyr_1.1.4          bookdown_0.45
#> [43] splines_4.5.1        labeling_0.4.3       fastmap_1.2.0
#> [46] grid_4.5.1           cli_3.6.5            SparseArray_1.10.1
#> [49] magrittr_2.0.4       S4Arrays_1.10.0      dichromat_2.0-0.1
#> [52] randomForest_4.7-1.2 withr_3.0.2          scales_1.4.0
#> [55] rmarkdown_2.30       XVector_0.50.0       ranger_0.17.0
#> [58] evaluate_1.0.5       knitr_1.50           rbibutils_2.4
#> [61] mgcv_1.9-4           rlang_1.1.6          itertools_0.1-3
#> [64] Rcpp_1.1.0           glue_1.8.0           BiocManager_1.30.26
#> [67] jsonlite_2.0.0       plyr_1.8.9           R6_2.6.1
```

# References

Di Guida, R., Engel, J., Allwood, J.W., et al. (2016) Non-targeted uhplc-ms metabolomic data processing methods: A comparative investigation of normalisation, missing value imputation, transformation and scaling. *Metabolomics*, 12 (5): 93. doi:[10.1007/s11306-016-1030-9](https://doi.org/10.1007/s11306-016-1030-9).

Kirwan, J.A., Weber, R.J., Broadhurst, D.I., et al. (2014) Direct infusion mass spectrometry metabolomics dataset: A benchmark for data processing and quality control. *Scientific data*, 1: 140012. doi:[10.1038/sdata.2014.12](https://doi.org/10.1038/sdata.2014.12).

Kirwan, J., Broadhurst, D., Davidson, R., et al. (2013) Characterising and correcting batch variation in an automated direct infusion mass spectrometry (dims) metabolomics workflow. *Analytical and bioanalytical chemistry*, 405 (15): 5147–5157. doi:[10.1007/s00216-013-6856-7](https://doi.org/10.1007/s00216-013-6856-7).