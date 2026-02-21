# ADImpute tutorial

#### 29 October 2025

#### Package

ADImpute 1.20.0

# Contents

* [1 Introduction](#introduction)
* [2 Imputation with method(s) of choice](#imputation-with-methods-of-choice)
* [3 Imputation with ensemble](#imputation-with-ensemble)
* [4 Determination of biological zeros](#determination-of-biological-zeros)
* [5 Imputation of a SingleCellExperiment](#imputation-of-a-singlecellexperiment)
* [6 Additional imputation methods](#additional-imputation-methods)
* [7 Session Info](#session-info)

# 1 Introduction

ADImpute predicts unmeasured gene expression values from single cell
RNA-sequencing data (dropout imputation). This R-package combines multiple
dropout imputation methods. ADImpute currently supports, by default,
and and two novel imputation methods:
and . imputes dropouts with the
average quantified expression level of the respective gene across the dataset.
uses previously learnt regulatory models of gene expression to
infer the expression of dropout genes from the expression of other relevant
(predictive) genes in the cell.
ADImpute consists of 2 fundamental functions: and
.

# 2 Imputation with method(s) of choice

The function allows for dropout imputation with one or more of
the supported methods. In order to specify which imputation method(s) to run,
pass them via the argument:

```
RPM <- NormalizeRPM(ADImpute::demo_data)
imputed <- Impute(data = RPM, do = c("Network"), cores = 2,
    net.coef = ADImpute::demo_net)
```

# 3 Imputation with ensemble

In addition to running different methods on the data, ADImpute can also
determine which of these performs best for each gene and perform an “Ensemble”
imputation, which combines the best performing methods for different genes.
First, evaluate methods using to determine the best
performing imputation method for each gene. This step sets a fraction of the
quantified entries in the input data to zero, applies different imputation
methods to the data and compares the imputation results to the original values.
This allows ADImpute to determine which method imputes values with the lowest
errors for each gene.

```
RPM <- NormalizeRPM(ADImpute::demo_data)
methods_pergene <- EvaluateMethods(data = RPM,
    do = c("Baseline", "DrImpute", "Network"),
    cores = 2, net.coef = ADImpute::demo_net)
```

```
head(methods_pergene)
#>      ABCE1       ABL2      ACSL3     ACTL6A      ADAM9       ADD1
#> "Baseline" "Baseline" "Baseline" "DrImpute" "Baseline" "Baseline"
```

After determining which method performs best for each gene, the imputation can
be re-done on the original data and the results of different methods combined
into an ensemble:

```
imputed <- Impute(do = "Ensemble", method.choice = methods_pergene,
    data = RPM, cores = 2, net.coef = ADImpute::demo_net)
```

```
str(imputed)
#> List of 4
#>  $ Baseline: num [1:696, 1:50] 8.67 9.72 10.51 11.16 9.91 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : Named chr [1:696] "ABCB5" "ABCE1" "ABL2" "ABTB1" ...
#>   .. .. ..- attr(*, "names")= chr [1:696] "ABCB5__chr7" "ABCE1__chr4" "ABL2__chr1" "ABTB1__chr3" ...
#>   .. ..$ : chr [1:50] "D10631_57" "D71_7" "D3en1_33" "D73_66" ...
#>  $ Network : num [1:696, 1:50] 8.67 0 0 0 0 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : Named chr [1:696] "ABCB5" "ABCE1" "ABL2" "ABTB1" ...
#>   .. .. ..- attr(*, "names")= chr [1:696] "ABCB5__chr7" "ABCE1__chr4" "ABL2__chr1" "ABTB1__chr3" ...
#>   .. ..$ : chr [1:50] "D10631_57" "D71_7" "D3en1_33" "D73_66" ...
#>  $ DrImpute: num [1:696, 1:50] 8.672 3.197 5.481 0.564 0.764 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : Named chr [1:696] "ABCB5" "ABCE1" "ABL2" "ABTB1" ...
#>   .. .. ..- attr(*, "names")= chr [1:696] "ABCB5__chr7" "ABCE1__chr4" "ABL2__chr1" "ABTB1__chr3" ...
#>   .. ..$ : chr [1:50] "D10631_57" "D71_7" "D3en1_33" "D73_66" ...
#>  $ Ensemble: num [1:696, 1:50] 8.67 0 0 0 0 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : Named chr [1:696] "ABCB5" "ABCE1" "ABL2" "ABTB1" ...
#>   .. .. ..- attr(*, "names")= chr [1:696] "ABCB5__chr7" "ABCE1__chr4" "ABL2__chr1" "ABTB1__chr3" ...
#>   .. ..$ : chr [1:50] "D10631_57" "D71_7" "D3en1_33" "D73_66" ...
```

Both the method-specific imputations and the final ensemble results are
available for further examination.

# 4 Determination of biological zeros

Some zeros in the data correspond to genes expressed in the cell, but not
captured upon sequencing - the technical dropouts - while others correspond to
genes truly not expressed in the cell - the biological zeros. In order to avoid
imputation of biological zeros, adapts the well-established
approach of for the computation of the probability of each entry
to be a technical dropout. A matrix of such probabilities, of the same size as
the original data, can be provided by the user, or computed by
using ’s approach, as below. To activate this option, provide a
value for in the call to , as exemplified
below:

```
imputed <- Impute(do = "Baseline",
    data = RPM,
    cores = 2,
    true.zero.thr = .3)
```

```
str(imputed)
#> List of 3
#>  $ imputations         :List of 1
#>   ..$ Baseline: num [1:696, 1:50] 8.67 9.72 10.51 11.16 9.91 ...
#>   .. ..- attr(*, "dimnames")=List of 2
#>   .. .. ..$ : Named chr [1:696] "ABCB5" "ABCE1" "ABL2" "ABTB1" ...
#>   .. .. .. ..- attr(*, "names")= chr [1:696] "ABCB5__chr7" "ABCE1__chr4" "ABL2__chr1" "ABTB1__chr3" ...
#>   .. .. ..$ : chr [1:50] "D10631_57" "D71_7" "D3en1_33" "D73_66" ...
#>  $ zerofiltered        :List of 1
#>   ..$ Baseline: num [1:696, 1:50] 8.67 9.72 10.51 11.16 0 ...
#>   .. ..- attr(*, "dimnames")=List of 2
#>   .. .. ..$ : Named chr [1:696] "ABCB5" "ABCE1" "ABL2" "ABTB1" ...
#>   .. .. .. ..- attr(*, "names")= chr [1:696] "ABCB5__chr7" "ABCE1__chr4" "ABL2__chr1" "ABTB1__chr3" ...
#>   .. .. ..$ : chr [1:50] "D10631_57" "D71_7" "D3en1_33" "D73_66" ...
#>  $ dropoutprobabilities: num [1:696, 1:50] NA 1 1 1 NA 0 1 0 0 1 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : Named chr [1:696] "ABCB5" "ABCE1" "ABL2" "ABTB1" ...
#>   .. .. ..- attr(*, "names")= chr [1:696] "ABCB5__chr7" "ABCE1__chr4" "ABL2__chr1" "ABTB1__chr3" ...
#>   .. ..$ : chr [1:50] "D10631_57" "D71_7" "D3en1_33" "D73_66" ...
```

# 5 Imputation of a SingleCellExperiment

can also take a object as input.
In this case, will result in new internal row metadata
being added to the object, with the best performing
methods per gene. results in new assays being added to the
object. If is specified, only the results after setting
biological zeros back to zero will be added to the
object.

```
sce <- NormalizeRPM(sce = ADImpute::demo_sce)
sce <- EvaluateMethods(sce = sce)
sce <- Impute(sce = sce)
```

# 6 Additional imputation methods

is built in a modular way, which facilitates the addition of
custom functions supporting other imputation methods. Two such methods are
and , with wrapper functions already contained
within . To call these methods, please follow these steps:
1) install scImpute and/or SCRABBLE from their github repositories
2) clone the ADImpute repository
3) copy the lines below to the file Wrap.R in the source R/ folder of ADImpute,
line #309.
4) re-load ADImpute using devtools::load\_all() on ADImpute’s folder

```
# # call to scImpute
if('scimpute' %in% tolower(do)){
    message('Make sure you have previously installed scImpute via GitHub.\n')
    res <- tryCatch(ImputeScImpute(count_path, labeled = is.null(labels),
            Kcluster = cell.clusters, labels = labels, drop_thre = drop_thre,
            cores = cores, type = type, tr.length = tr.length),
        error = function(e){ stop(paste('Error:', e$message,
            '\nTry sourcing the Impute_extra.R file.'))})
    imputed$scImpute <- log2( (res / scale) + pseudo.count)
}

# call to SCRABBLE
if('scrabble' %in% tolower(do)){
    message('Make sure you have previously installed SCRABBLE via GitHub.\n')
    res <- tryCatch(ImputeSCRABBLE(data, bulk),
                    error = function(e) { stop(paste('Error:', e$message,
                        '\nTry sourcing the Impute_extra.R file.'))})
    imputed$SCRABBLE <- log2( (res / scale) + pseudo.count)
    rm(res);gc()
}
```

After these steps, and can be run with
or with
.

# 7 Session Info

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] ADImpute_1.20.0  BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] Matrix_1.7-4                jsonlite_2.0.0
#>  [3] compiler_4.5.1              BiocManager_1.30.26
#>  [5] Rcpp_1.1.0                  SummarizedExperiment_1.40.0
#>  [7] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [9] parallel_4.5.1              jquerylib_0.1.4
#> [11] IRanges_2.44.0              Seqinfo_1.0.0
#> [13] BiocParallel_1.44.0         yaml_2.3.10
#> [15] fastmap_1.2.0               lattice_0.22-7
#> [17] XVector_0.50.0              R6_2.6.1
#> [19] S4Arrays_1.10.0             generics_0.1.4
#> [21] kernlab_0.9-33              knitr_1.50
#> [23] BiocGenerics_0.56.0         backports_1.5.0
#> [25] DelayedArray_0.36.0         checkmate_2.3.3
#> [27] bookdown_0.45               snow_0.4-4
#> [29] MatrixGenerics_1.22.0       bslib_0.9.0
#> [31] rlang_1.1.6                 cachem_1.1.0
#> [33] xfun_0.53                   sass_0.4.10
#> [35] SparseArray_1.10.0          cli_3.6.5
#> [37] digest_0.6.37               grid_4.5.1
#> [39] DrImpute_1.0                lifecycle_1.0.4
#> [41] S4Vectors_0.48.0            SingleCellExperiment_1.32.0
#> [43] evaluate_1.0.5              codetools_0.2-20
#> [45] abind_1.4-8                 stats4_4.5.1
#> [47] rmarkdown_2.30              matrixStats_1.5.0
#> [49] tools_4.5.1                 htmltools_0.5.8.1
```

ADImpute was developed in R 4.0.2, under Linux Mint 20, and tested in Linux,
OS X and Windows. For further questions, please contact:
ana.carolina.leote@uni-koeln.de