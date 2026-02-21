# The vignette for running scShapes

#### Malindrie Dharmaratne

#### 2025-10-30

## Pulling and running singularity container

```
$ singularity pull --name scShapes.sif shub://Malindrie/scShapes
$ singularity shell scShapes.sif
Singularity scShapes.sif:~ >
```

## Pulling and running docker container

```
$ docker pull maldharm/scshapes
$ docker run -it maldharm/scshapes
root@516e456b0762:/#
```

To use containerized `scShapes` package, need to launch `R` or execute an R script through `Rscript`.

## Install `scShapes` from `install_github`

```
devtools::install_github('Malindrie/scShapes')
```

```
library(scShapes)
library(BiocParallel)
set.seed(0xBEEF)
```

## Example

This is a basic example which shows how you can use scShapes for identifying differential distributions in single-cell RNA-seq data. For this example data we use the toy example data `scData` included in the package.

```
# Loading and preparing data for input

data(scData)
```

We first filter the genes to keep only genes expressed in at least 10% of cells:

```
scData_filt <- filter_counts(scData$counts, perc.zero = 0.1)
```

In order to normalize for differences in sequencing depth, the log of the total UMI counts assigned per cell will be used as an offset in the GLM. This function is inbuilt in the algorithm; however the user is required to input the library sizes. In our example data this information together with the covariates is given under the lists `lib_size` and `covariates` respectively.

Perform Kolmogorov-Smirnov test to select genes belonging to the family of ZINB distributions.

```
scData_KS <- ks_test(counts=scData$counts, cexpr=scData$covariates, lib.size=scData$lib_size, BPPARAM=SnowParam(workers=8,type="SOCK"))

# Select genes significant from the KS test.
# By default the 'ks_sig' function performs Benjamini-Hochberg correction for multiple   hypothese testing
# and selects genes significant at p-value of 0.01

scData_KS_sig <- ks_sig(scData_KS)

# Subset UMI counts corresponding to the genes significant from the KS test
scData.sig.genes <- scData$counts[rownames(scData$counts) %in% names(scData_KS_sig$genes),]
```

Fit the 4 distributions P,NB,ZIP,ZINB for genes that belong to the ZINB family of distributions by fitting GLM with log of the library sizes as an offset and cell types as a covariate in the GLM.

```
scData_models <- fit_models(counts=scData.sig.genes, cexpr=scData$covariates, lib.size=scData$lib_size, BPPARAM=SnowParam(workers=8,type="SOCK"))
```

Once the 4 distributions are fitted, we next calculate the BIC value for each model and select the model with the least BIC value.

```
scData_bicvals <- model_bic(scData_models)

# select model with least bic value
scData_least.bic <- lbic_model(scData_bicvals, scData$counts)
```

To ensure the fit of the models selected based on the least BIC value, additionally we perform LRT to test for model adequacy and presence of zero-inflation.

```
scData_gof <- gof_model(scData_least.bic, cexpr=scData$covariates, lib.size=scData$lib_size, BPPARAM=SnowParam(workers=8,type="SOCK"))
```

Finally based on the results of the model adequacy tests, we can identify the distribution of best fit for each gene.

```
scData_fit <- select_model(scData_gof)
```

Once the distribution of best fit is identified for genes of interest, it is also possible to extract parameters of interest for the models.

```
scData_params <- model_param(scData_models, scData_fit, model=NULL)
```

If our dataset consists of multiple conditions we can follow the above approach to identify the best fir distribution shape for each gene under each treatment condition (selecting the subset of genes common between conditions). Then using the dataframe of genes and distribution followed under each condition, now we can identify genes changing distribution between conditions.

For example suppose we follow above pipeline for scRNA-seq data on two treatment conditions ‘CTRL’ and ‘STIM’ and have identified the best distribution fit for each gene under each condition independently. Suppose the dataframe `ifnb.distr`; with genes as rows and columns as ‘CTRL’ and ‘STIM’ with the corresponding distribution name a particular gene follows, then we can identify genes changing distribution shape between ‘CTRL’ and ‘STIM’ as;

```
ifnb.DD.genes <- change_shape(ifnb.distr)
```

This will give a list of two lists with genes changing distribution between condition and genes changing distribution from unimodal in one condition to zero-inflated in the other condition.

# Session Information

Here is the output of sessionInfo() on the system on which this document was compiled:

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
#> [1] BiocParallel_1.44.0 scShapes_1.16.0
#>
#> loaded via a namespace (and not attached):
#>  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
#>  [4] xfun_0.53           jsonlite_2.0.0      plyr_1.8.9
#>  [7] htmltools_0.5.8.1   snow_0.4-4          sass_0.4.10
#> [10] stats4_4.5.1        rmarkdown_2.30      grid_4.5.1
#> [13] dgof_1.5.1          evaluate_1.0.5      jquerylib_0.1.4
#> [16] MASS_7.3-65         fastmap_1.2.0       mvtnorm_1.3-3
#> [19] numDeriv_2016.8-1.1 yaml_2.3.10         lifecycle_1.0.4
#> [22] emdbook_1.3.14      compiler_4.5.1      codetools_0.2-20
#> [25] coda_0.19-4.1       pscl_1.5.9          Rcpp_1.1.0
#> [28] bbmle_1.0.25.1      VGAM_1.1-13         lattice_0.22-7
#> [31] digest_0.6.37       R6_2.6.1            parallel_4.5.1
#> [34] splines_4.5.1       magrittr_2.0.4      bslib_0.9.0
#> [37] Matrix_1.7-4        tools_4.5.1         bdsmatrix_1.3-7
#> [40] cachem_1.1.0
```