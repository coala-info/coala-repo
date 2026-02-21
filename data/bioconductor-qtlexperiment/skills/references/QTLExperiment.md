# An introduction to the QTLExperiment class

Christina B Azodi, Amelia Dunstone and Davis McCarthy

#### 2025-10-30

#### Package

QTLExperiment 2.2.0

# 1 1. Motivation

The `QTLExperiment` class is a Bioconductor container for storing and manipulating QTL summary statistics (e.g., effect sizes, standard errors, significance metrics) from one or more states (e.g., tissues, cell-types, environmental conditions). It extends the `RangedSummarizedExperiment` class (from the *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* package), where rows represent QTL associations, columns represent states, and assays contain the various summary statistics. Associations are identified by the feature and variant tested in the format `feature_id|variant_id`. For example, a QTL association between the gene ENSG00000103888 and the SNP variant rs112057726 would be stored as ENSG00000103888|rs112057726. This package also provides convenient and robust methods for loading, merging, and subsetting multi-state QTL data.

![](data:image/png;base64...)

QTLExperiment container structure

## 1.1 Installation

QTLExperiment can be installed from GitHub:

```
if (!require("BiocManager", quietly=TRUE))
    install.packages("BiocManager")

BiocManager::install("QTLExperiment", version = "devel")
```

```
library(QTLExperiment)
```

# 2 2. Creating QTLExperiment instances

## 2.1 Manually

`QTLExperiment` objects can be created manually by passing required information to the `QTLExperiment` function. The assays (i.e., *betas*, *error*, and other user defined assays) can be provided as a named list or as a `SummarizedExperiment` object. All assays should contain the same rows and columns. Important metadata (i.e., *state\_id*, *feature\_id*, and *variant\_id*) can be inferred from the input data or provided directly. If not provided, `QTLExperiment` will use the assay column names as state IDs and will look for the row names to contain the feature IDs and the variant IDs separated by a pipe (“|”). For example:

```
set.seed(42)
nStates <- 6
nQTL <- 40

mock_summary_stats <- mockSummaryStats(nStates=nStates, nQTL=nQTL)
mock_summary_stats$betas[1:5,1:5]
```

```
##                    state1     state2      state3       state4     state5
## geneA|snp37973  1.3709584  0.2059986  1.51270701 -1.493625067 -0.1755259
## geneC|snp97737 -0.5646982 -0.3610573  0.25792144 -1.470435741 -1.0717824
## geneB|snp10284  0.3631284  0.7581632  0.08844023  0.124702386  0.1632069
## geneB|snp67251  0.6328626 -0.7267048 -0.12089654 -0.996639135 -0.3627384
## geneB|snp8449   0.4042683 -1.3682810 -1.19432890 -0.001822614  0.5900135
```

With input data in this format, the `qtle` object can be generated as shown below.

```
qtle <- QTLExperiment(
    assays=list(
        betas=mock_summary_stats$betas,
        errors=mock_summary_stats$errors),
    metadata=list(study="mock-example"))
qtle
```

```
## class: QTLExperiment
## dim: 40 6
## metadata(1): study
## assays(2): betas errors
## rownames(40): geneA|snp37973 geneC|snp97737 ... geneB|snp51163
##   geneC|snp17502
## rowData names(2): feature_id variant_id
## colnames(6): state1 state2 ... state5 state6
## colData names(1): state_id
```

Alternatively, the state IDs, feature IDs, and variant IDs can be provided manually. **Note that in this mode the user must ensure the rows and columns of all assays are in the order of the IDs provided!**

```
mock_summary_stats <- mockSummaryStats(nStates=nStates, nQTL=nQTL, names=FALSE)
mock_summary_stats$betas[1:5,1:5]
```

```
##            [,1]       [,2]        [,3]       [,4]       [,5]
## [1,] -1.1872946 -0.8664769  1.93253557 -0.2675735  1.2216340
## [2,] -0.2035310  1.4811912  0.25001404  1.1926643  0.6262407
## [3,] -1.0591162 -0.3604593  0.74765249  1.5921706  1.0063578
## [4,]  0.6613011  1.1137537  1.00108017 -0.9963816 -0.3485696
## [5,] -0.3329064  0.1817592 -0.07813849 -1.0139292 -1.1513481
```

```
qtle <- QTLExperiment(assays=list(betas=mock_summary_stats$betas,
                                  errors=mock_summary_stats$errors),
                      feature_id=paste0("gene_", 1:nQTL),
                      variant_id=sample(1:1e6, nQTL),
                      state_id=paste0("state_", LETTERS[1:nStates]),
                      metadata=list(study="mock-example2"))
qtle
```

```
## class: QTLExperiment
## dim: 40 6
## metadata(1): study
## assays(2): betas errors
## rownames: NULL
## rowData names(2): feature_id variant_id
## colnames(6): state_A state_B ... state_E state_F
## colData names(1): state_id
```

A mock `QTLExperiment` object can also be generated automatically using the `mockQTLe` function:

```
qtle <- mockQTLE(nStates=nStates, nQTL=nQTL)
qtle
```

```
## class: QTLExperiment
## dim: 40 6
## metadata(0):
## assays(3): betas errors pvalues
## rownames(40): geneB|snp49286 geneC|snp99993 ... geneC|snp77204
##   geneB|snp89706
## rowData names(2): feature_id variant_id
## colnames(6): state1 state2 ... state5 state6
## colData names(2): state_id sample_size
```

## 2.2 From QTL summary statistics for each state

The `sumstats2qtle()` function is a generic function to load QTL summary statistics from multiple files, where each file represents a state, and convert them into a `QTLExperiment` object. Because different QTL mapping software produce summary statistics in different formats, this function is flexible, allowing users to specify the column name or index where required data is stored. This function can also utilize parallel processing (cores available are automatically detected, see the *[vroom](https://CRAN.R-project.org/package%3Dvroom)* documentation for details.

Required arguments:

* input: A named list (name=`state`; value=`path`) or matrix with two columns (`state` and `path`) where the state is the desired name and the path is the full local path or the weblink to the summary statistics for that state.
* feature\_id: The index or name of the column in the summary statistic files containing the feature ID
* variant\_id: The index or name of the column in the summary statistic files containing the variant ID
* betas: The index or name of the column in the summary statistic files containing the estimated betas
* error: The index or name of the column in the summary statistic files containing the estimated beta errors

Optional arguments:
- na.rm: Logical. To remove QTL tests (rows) with missing data for any state.
- pval: The index or name of the column in the summary statistic files containing test statistics.
- n\_max: The number of rows to read from each file

Note that vroom does not handle compressed files well, and will not load all rows for large files.
It is best to provide vroom with uncompressed objects for this reason.

As an example, we can load summary statistics from the [EBI eQTL database](https://www.ebi.ac.uk/eqtl/Data_access/).
Transcript usage data for lung, thyroid, spleen and blood are available in the `inst/extdata` folder.
This data is licensed under the Creative Commons Attribution 4.0 International License. See `inst/script/data_processing.R` for details about how these data files were obtained from the database.

```
input_path <- system.file("extdata", package="QTLExperiment")
state <- c("lung", "thyroid", "spleen", "blood")

input <- data.frame(
    state=state,
    path=paste0(input_path, "/GTEx_tx_", state, ".tsv"))

qtle4 <- sumstats2qtle(
    input,
    feature_id="molecular_trait_id",
    variant_id="rsid",
    betas="beta",
    errors="se",
    pvalues="pvalue",
    verbose=TRUE)
qtle4
```

```
## class: QTLExperiment
## dim: 1163 4
## metadata(0):
## assays(3): betas errors pvalues
## rownames(1163): ENST00000428771|rs554008981 ENST00000477976|rs554008981
##   ... ENST00000445118|rs368254419 ENST00000483767|rs368254419
## rowData names(2): feature_id variant_id
## colnames(4): lung thyroid spleen blood
## colData names(1): state_id
```

```
head(betas(qtle4))
```

```
##                                   lung    thyroid   spleen     blood
## ENST00000428771|rs554008981 -0.1733690         NA 0.134913        NA
## ENST00000477976|rs554008981  0.1616170  0.3173110       NA        NA
## ENST00000483767|rs554008981 -0.4161480 -0.0483018       NA -0.204647
## ENST00000623070|rs554008981 -0.1137930         NA       NA        NA
## ENST00000669922|rs554008981 -0.1921680 -0.1067540 0.724622 -0.117424
## ENST00000428771|rs201055865 -0.0630909         NA       NA        NA
```

## 2.3 From mashr data format

A convenience function is also available to convert `mash` objects (generated here using the simple\_sims function from mashr) into `QTLe` objects.

```
mashr_sim <- mockMASHR(nStates=nStates, nQTL=nQTL)

qtle2 <- mash2qtle(
    mashr_sim,
    rowData=DataFrame(feature_id=row.names(mashr_sim$Bhat),
                      variant_id=sample(seq(1:1e5), nQTL)))
qtle2
```

```
## class: QTLExperiment
## dim: 40 6
## metadata(0):
## assays(2): betas errors
## rownames(40): geneA|snp80753 geneA|snp88570 ... geneA|snp57953
##   geneB|snp82573
## rowData names(2): feature_id variant_id
## colnames(6): state1 state2 ... state5 state6
## colData names(1): state_id
```

# 3 3. Basic object manipulation

Any operation that can be applied to a RangedSummarizedExperiment is also applicable to any instance of a `QTLExperiment`. This includes access to assay data via assay(), column metadata with colData(), etc.

```
dim(qtle4)
```

```
## [1] 1163    4
```

```
colnames(qtle4)
```

```
## [1] "lung"    "thyroid" "spleen"  "blood"
```

```
head(rowData(qtle4))
```

```
## DataFrame with 6 rows and 2 columns
##                                  feature_id  variant_id
##                                 <character> <character>
## ENST00000428771|rs554008981 ENST00000428771 rs554008981
## ENST00000477976|rs554008981 ENST00000477976 rs554008981
## ENST00000483767|rs554008981 ENST00000483767 rs554008981
## ENST00000623070|rs554008981 ENST00000623070 rs554008981
## ENST00000669922|rs554008981 ENST00000669922 rs554008981
## ENST00000428771|rs201055865 ENST00000428771 rs201055865
```

```
qtle4b <- qtle4
state_id(qtle4b) <- paste0(state_id(qtle4), "_b")
dim(cbind(qtle4, qtle4b))
```

```
## [1] 1163    8
```

```
qtle4b <- qtle4
feature_id(qtle4b) <- paste0(feature_id(qtle4), "_b")
dim(rbind(qtle4, qtle4b))
```

```
## [1] 2326    4
```

```
qtle.subset <- qtle[rowData(qtle)$feature_id == "geneA", ]
dim(qtle.subset)
```

```
## [1] 13  6
```

```
qtle.subset <- qtle[, c("state1", "state2")]
dim(qtle.subset)
```

```
## [1] 40  2
```

```
qtle.subset <- subset(qtle, , sample_size > 100)
dim(qtle.subset)
```

```
## [1] 40  6
```

# 4 4. Working with assays

The `QTLExperiment` assays can be viewed and manipulated using appropriate getter and setter methods. For common assay types (i.e., betas, errors, pvalues, and lfsrs), convenient getter and setters are available. For example, the betas getter and setter is shown here:

```
betas(qtle)[1:5,1:5]
```

```
##                     state1      state2     state3      state4     state5
## geneB|snp49286  1.69640227  0.03453868  0.3160142  1.11069222 -0.6743804
## geneC|snp99993  1.54284685  0.28629965 -1.0381128  2.14072073 -2.3030232
## geneC|snp83889  0.21452759  1.18620809 -0.7551373 -0.83097181 -0.1493329
## geneA|snp38048  1.70068830 -0.03754937 -0.4915043  0.07640586  0.9486896
## geneB|snp98396 -0.00798683  0.42037159  0.1472257  0.93582445  1.1563625
```

```
betas(qtle) <- betas(qtle) * -1

betas(qtle)[1:5,1:5]
```

```
##                     state1      state2     state3      state4     state5
## geneB|snp49286 -1.69640227 -0.03453868 -0.3160142 -1.11069222  0.6743804
## geneC|snp99993 -1.54284685 -0.28629965  1.0381128 -2.14072073  2.3030232
## geneC|snp83889 -0.21452759 -1.18620809  0.7551373  0.83097181  0.1493329
## geneA|snp38048 -1.70068830  0.03754937  0.4915043 -0.07640586 -0.9486896
## geneB|snp98396  0.00798683 -0.42037159 -0.1472257 -0.93582445 -1.1563625
```

Users or downstream tools may add and see additional assays to the `QTLe` object using generic getter and setter methods. For example, to store information about what QTL are significant, we could add a new assay called *significant* using the generic setter method and then look at the data in the new assay using the generic getter method:

```
assay(qtle4, "significant") <- assay(qtle4, "pvalues") < 0.05

assay(qtle4, "significant")[1:5, 1:4]
```

```
##                              lung thyroid spleen blood
## ENST00000428771|rs554008981 FALSE      NA  FALSE    NA
## ENST00000477976|rs554008981 FALSE   FALSE     NA    NA
## ENST00000483767|rs554008981  TRUE   FALSE     NA FALSE
## ENST00000623070|rs554008981 FALSE      NA     NA    NA
## ENST00000669922|rs554008981 FALSE   FALSE   TRUE FALSE
```

# 5 5. Working with critical meta data

Because the feature, variant, and state IDs are critical for the continuity of a `QTLExperiment` object, special getters and setters are used to ensure changes to avoid unintentional mislabeling and to make sure that changes made to these data are synced across the `QTLe` object. Getter functions include `state_id()`, `feature_id()`, and `variant_id()`.

```
state_id(qtle4)
```

```
## [1] "lung"    "thyroid" "spleen"  "blood"
```

```
feature_id(qtle4)[1:3]
```

```
## [1] "ENST00000428771" "ENST00000477976" "ENST00000483767"
```

```
variant_id(qtle4)[1:3]
```

```
## [1] "rs554008981" "rs554008981" "rs554008981"
```

These functions can also be used as setters. For example, when `state_id()` is used to update the names of the states, this information is updated in the colData and in the assays.

```
state_id(qtle4) <- c("LUNG", "THYROID", "SPLEEN", "BLOOD")
head(colData(qtle4))
```

```
## DataFrame with 4 rows and 1 column
##            state_id
##         <character>
## LUNG           LUNG
## THYROID     THYROID
## SPLEEN       SPLEEN
## BLOOD         BLOOD
```

```
head(betas(qtle4))
```

```
##                                   LUNG    THYROID   SPLEEN     BLOOD
## ENST00000428771|rs554008981 -0.1733690         NA 0.134913        NA
## ENST00000477976|rs554008981  0.1616170  0.3173110       NA        NA
## ENST00000483767|rs554008981 -0.4161480 -0.0483018       NA -0.204647
## ENST00000623070|rs554008981 -0.1137930         NA       NA        NA
## ENST00000669922|rs554008981 -0.1921680 -0.1067540 0.724622 -0.117424
## ENST00000428771|rs201055865 -0.0630909         NA       NA        NA
```

# 6 Session Info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
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
##  [1] QTLExperiment_2.2.0         SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] xfun_0.53           bslib_0.9.0         collapse_2.1.4
##  [4] lattice_0.22-7      tzdb_0.5.0          vctrs_0.6.5
##  [7] tools_4.5.1         parallel_4.5.1      tibble_3.3.0
## [10] pkgconfig_2.0.3     Matrix_1.7-4        checkmate_2.3.3
## [13] SQUAREM_2021.1      lifecycle_1.0.4     truncnorm_1.0-9
## [16] compiler_4.5.1      htmltools_0.5.8.1   sass_0.4.10
## [19] yaml_2.3.10         pillar_1.11.1       crayon_1.5.3
## [22] jquerylib_0.1.4     tidyr_1.3.1         DelayedArray_0.36.0
## [25] cachem_1.1.0        abind_1.4-8         tidyselect_1.2.1
## [28] digest_0.6.37       dplyr_1.1.4         purrr_1.1.0
## [31] bookdown_0.45       ashr_2.2-63         fastmap_1.2.0
## [34] grid_4.5.1          archive_1.1.12      cli_3.6.5
## [37] invgamma_1.2        SparseArray_1.10.0  magrittr_2.0.4
## [40] S4Arrays_1.10.0     withr_3.0.2         backports_1.5.0
## [43] bit64_4.6.0-1       rmarkdown_2.30      XVector_0.50.0
## [46] bit_4.6.0           evaluate_1.0.5      knitr_1.50
## [49] irlba_2.3.5.1       rlang_1.1.6         Rcpp_1.1.0
## [52] mixsqp_0.3-54       glue_1.8.0          BiocManager_1.30.26
## [55] vroom_1.6.6         jsonlite_2.0.0      R6_2.6.1
```