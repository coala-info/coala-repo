# ath1121501frmavecs

Quentin Riviere

#### 2024-03-27

#### Package

ath1121501frmavecs 1.0.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Usage](#usage)
* [4 References](#references)
* **Appendix**
* [A Session info](#session-info)

# 1 Introduction

The *ath1121501frmavecs* data package allows the implementation of the frozen Robust Multiarray Analysis (fRMA) procedure for *Arabidopsis thaliana* (for microarray data compatible with the GPL198 Gene Expression Omnibus platform). Such a pre-processing method of gene expression arrays was developed by McCall et al. (2010) to ensure the comparability of datasets preprocessed separately. This not only allows to obtain reliable results from small batches of samples but also to reduce the computational burden to perform meta-analysis and save time when including new samples to a database.

The fRMA procedure is a platform-specific method, based on the pre-computation of parameter vectors holding the reference normalization distribution, the probe effect estimates, the within batch residual variance, the between batch residual variance, and the within probeset average standard deviation. GPL198 corresponds to the most popular platform for *Arabidopsis thaliana*, hosting data obtained with the Affymetrix Arabidopsis ATH1 Genome Array and annotated with the ATH1-121501 CDF file. Upon recommendation of the authors, *ath1121501frmavecs* was built based on 100 triplicates originating from 100 different series, using the *frmaTools* package (McCall and Irizarry, 2011). Those 100 triplicates were related to a large variety of study subjects, encompassing biotic treatments, abiotic stresses, control conditions (in seedlings), development (different tissues, organs, in control condition) and chemical treatments (hormones, growth regulators, …). Details about these training samples are provided in the manual of the package (make a link).

# 2 Installation

*ath1121501frmavecs* is an annotation package for the *fRMA* Bioconductor package, allowing to preprocess micro-array data for *Arabidopsis thaliana* given the **GPL198** platform (Array: Affymetrix Arabidopsis ATH1 Genome Array; CDF: ATH1-121501).

To install this package, start R (version >= 3.5.0) and enter:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ath1121501frmavecs")
```

# 3 Usage

In the following example, we show how to compute fRMA values for three samples selected on the **GPL198** platform, namely: GSM433634, GSM1179807, and GSM433644 (GEO sample IDs). First, we download the corresponding CEL files with the **GEOquery** package and retrieve the paths of those files on our local computer; then we load the data with **affy**, and preprocess the micro-array data and extract the expression values with **frma**.

```
library(ath1121501frmavecs)
library(GEOquery)
library(affy)
library(frma)

# 1. Download the CEL files
GSM_considered <- c("GSM433634", "GSM1179807", "GSM433644")
for (sample in GSM_considered) {
  getGEOSuppFiles(
    sample,
    makeDirectory = FALSE,
    baseDir = tempdir(),
    filter_regex = "cel.gz || CEL.gz",
    fetch_files = TRUE
  )
}

# 2. Obtain the CEL file paths
celpaths <-
  grepl(
    pattern = paste0(c(
      ".*(", paste0(GSM_considered, collapse = "|"), ").*"
    ), collapse = ""),
    x = list.files(tempdir()),
    ignore.case = TRUE
  )
celpaths <- list.files(tempdir())[celpaths]
celpaths <-
  celpaths[grepl(pattern = "cel.gz", celpaths, ignore.case = TRUE)]
celpaths <- file.path(tempdir(), celpaths)

# 3. Load and preprocess the data
cel_batch <- read.affybatch(celpaths)
data(ath1121501frmavecs)
cel_frma <-
  frma(
    object = cel_batch,
    target = "full",
    input.vec = ath1121501frmavecs,
    verbose = TRUE
  )

# 4. Extract the fRMA values
cel_e <- exprs(cel_frma)
cel_e <- as.data.frame(cel_e)
head(cel_e)
```

```
##           GSM1179807_0h_WT_1_ATH1-121501_.CEL.gz GSM433634.CEL.gz
## 244901_at                              10.699085         5.428368
## 244902_at                               8.751768         4.281745
## 244903_at                               9.462991         5.505874
## 244904_at                               7.300124         6.923266
## 244905_at                               3.646117         3.995055
## 244906_at                               9.521829         6.509041
##           GSM433644.CEL.gz
## 244901_at         5.098084
## 244902_at         4.675352
## 244903_at         5.368374
## 244904_at         7.092549
## 244905_at         4.409851
## 244906_at         6.284098
```

Finally, we can annotate the probesets with the gene names and select, for each gene model, only one probeset, with the highest levels of signal on average. The annotations of the probesets are available within the *ath1121501.db* package.

```
library(ath1121501.db)
probeset2gene <- mapIds(
  ath1121501.db,
  keys = rownames(cel_e),
  column = "TAIR",
  keytype = "PROBEID"
)
#cel_e <- cel_e[rownames(cel_e) %in% probeset2gene$array_element_name,]
cel_e$AGI <-
  probeset2gene[match(x = rownames(cel_e), table = names(probeset2gene))]
multiple_ps <- table(cel_e$AGI)
multiple_ps <- names(multiple_ps[multiple_ps > 1])
todel_ps <- list()
for (gene in multiple_ps) {
  considered <- cel_e[cel_e$AGI == gene, ]
  mu_considered <-
    apply(as.matrix(considered[, seq(1, ncol(considered) - 1)]), 1, mean)
  mu_considered <-
    mu_considered[order(mu_considered, decreasing = TRUE)]
  todel_ps[[gene]] <- names(mu_considered)[2:length(mu_considered)]
}
todel_ps <- do.call(c, todel_ps)
cel_e <- cel_e[!(rownames(cel_e) %in% todel_ps), ]
```

# 4 References

# Appendix

McCall MN, Bolstad BM, Irizarry RA. Frozen robust multiarray analysis (fRMA). Biostatistics. 2010 Apr;11(2):242-53. doi: 10.1093/biostatistics/kxp059. Epub 2010 Jan 22. PMID: 20097884; PMCID: PMC2830579.

McCall MN, Irizarry RA. Thawing Frozen Robust Multi-array Analysis (fRMA). BMC Bioinformatics. 2011 Sep 16;12:369. doi: 10.1186/1471-2105-12-369. PMID: 21923903; PMCID: PMC3180392.

# A Session info

```
sessionInfo()
```

```
## R version 4.4.0 alpha (2024-03-27 r86216)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 22.04.4 LTS
##
## Matrix products: default
## BLAS:   /home/lorikern/R-Installs/bin/R-4-4-branch/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] ath1121501.db_3.13.0     org.At.tair.db_3.18.0    AnnotationDbi_1.65.2
##  [4] IRanges_2.37.1           S4Vectors_0.41.5         ath1121501cdf_2.18.0
##  [7] frma_1.55.0              affy_1.81.0              GEOquery_2.71.0
## [10] Biobase_2.63.0           BiocGenerics_0.49.1      ath1121501frmavecs_1.0.0
## [13] BiocStyle_2.31.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] blob_1.2.4                  Biostrings_2.71.5
##  [5] bitops_1.0-7                fastmap_1.1.1
##  [7] RCurl_1.98-1.14             digest_0.6.35
##  [9] lifecycle_1.0.4             oligoClasses_1.65.0
## [11] KEGGREST_1.43.0             statmod_1.5.0
## [13] RSQLite_2.3.5               magrittr_2.0.3
## [15] compiler_4.4.0              rlang_1.1.3
## [17] sass_0.4.9                  tools_4.4.0
## [19] utf8_1.2.4                  yaml_2.3.8
## [21] data.table_1.15.2           knitr_1.45
## [23] S4Arrays_1.3.6              curl_5.2.1
## [25] bit_4.0.5                   DelayedArray_0.29.9
## [27] xml2_1.3.6                  oligo_1.67.0
## [29] abind_1.4-5                 purrr_1.0.2
## [31] grid_4.4.0                  preprocessCore_1.65.0
## [33] fansi_1.0.6                 affxparser_1.75.2
## [35] iterators_1.0.14            MASS_7.3-60.2
## [37] SummarizedExperiment_1.33.3 cli_3.6.2
## [39] rmarkdown_2.26              crayon_1.5.2
## [41] generics_0.1.3              httr_1.4.7
## [43] tzdb_0.4.0                  DBI_1.2.2
## [45] cachem_1.0.8                zlibbioc_1.49.3
## [47] splines_4.4.0               BiocManager_1.30.22
## [49] XVector_0.43.1              matrixStats_1.2.0
## [51] vctrs_0.6.5                 Matrix_1.6-5
## [53] jsonlite_1.8.8              bookdown_0.38
## [55] hms_1.1.3                   bit64_4.0.5
## [57] foreach_1.5.2               limma_3.59.6
## [59] tidyr_1.3.1                 jquerylib_0.1.4
## [61] affyio_1.73.0               glue_1.7.0
## [63] codetools_0.2-19            GenomeInfoDb_1.39.9
## [65] GenomicRanges_1.55.4        tibble_3.2.1
## [67] pillar_1.9.0                htmltools_0.5.7
## [69] GenomeInfoDbData_1.2.11     R6_2.5.1
## [71] ff_4.0.12                   evaluate_0.23
## [73] lattice_0.22-6              readr_2.1.5
## [75] png_0.1-8                   memoise_2.0.1
## [77] bslib_0.6.2                 SparseArray_1.3.4
## [79] xfun_0.42                   MatrixGenerics_1.15.0
## [81] pkgconfig_2.0.3
```