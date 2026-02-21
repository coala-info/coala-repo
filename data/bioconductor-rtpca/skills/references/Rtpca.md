# Introduction to Rtpca

Nils Kurzawa1

1European Molecular Biology Laboratory (EMBL), Genome Biology Unit

#### 30 October, 2025

#### Package

Rtpca 1.20.0

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
* [3 The `Rtpca` package workflow](#the-rtpca-package-workflow)
  + [3.1 Import Thermal proteome profiling data using the `TPP` package](#import-thermal-proteome-profiling-data-using-the-tpp-package)
  + [3.2 Performing thermal co-aggregation analysis with `Rtpca`](#performing-thermal-co-aggregation-analysis-with-rtpca)
    - [3.2.1 Run TPCA on data from a single condition](#run-tpca-on-data-from-a-single-condition)
    - [3.2.2 Run differential TPCA on two conditions](#run-differential-tpca-on-two-conditions)
* [4 Additional remarks](#additional-remarks)
* [5 Acknowledgements](#acknowledgements)
* [References](#references)

# 1 Installation

Installation from *Bioconductor*

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Rtpca")
```

2. Load the package into your R session.

```
library(Rtpca)
```

# 2 Introduction

Thermal proteome profiling (TPP) (Mateus et al., [2020](#ref-Mateus2020); Savitski et al., [2014](#ref-Savitski2014)) is a mass
spectrometry-based, proteome-wide implemention of the cellular thermal shift
assay (Martinez Molina et al., [2013](#ref-Molina2013)). It was originally developed to study drug-(off-)target
engagement. However, it was realized that profiles of interacting protein
pairs appeared more similar than by chance which was coined as
‘thermal proximity co-aggregation’ (TPCA) (Tan et al., [2018](#ref-Tan2018)). The R package `Rtpca`
enables analysis of TPP datasets using the TPCA concept for studying
protein-protein interactions and protein complexes and also allows to test for
differential protein-protein interactions across different conditions.

This vignette only represents a minimal example. To have a look at a more
realistic example feel free to check out [this more realisticexample](https://github.com/nkurzaw/Rtpca_analysis/blob/master/Becher_et_al_reanalysis.pdf).

**Note:** if you use `Rtpca` in published research, please cite:

> Kurzawa, N., Mateus, A. & Savitski, M.M. (2020)
> Rtpca: an R package for differential thermal proximity coaggregation analysis.
> *Bioinformatics*, [10.1093/bioinformatics/btaa682](https://doi.org/10.1093/bioinformatics/btaa682)

# 3 The `Rtpca` package workflow

We also load the `TPP` package to illustrate how to import TPP data with the
Bioconductor package and then input it into the `Rtpca` functions.

```
library(TPP)
```

## 3.1 Import Thermal proteome profiling data using the `TPP` package

We load the data `hdacTR_smallExample` which is part of the `TPP` package

```
data("hdacTR_smallExample")
```

Filter hdacTR\_data to speed up computations

```
set.seed(123)
random_proteins <- sample(hdacTR_data[[1]]$gene_name, 300)
```

```
hdacTR_data_fil <- lapply(hdacTR_data, function(temp_df){
    filter(temp_df, gene_name %in% random_proteins)
})
```

We can now import our small example dataset using the import function from
the `TPP` package:

```
trData <- tpptrImport(configTable = hdacTR_config, data = hdacTR_data_fil)
```

```
## Importing data...
```

```
## Comparisons will be performed between the following experiments:
```

```
## Panobinostat_1_vs_Vehicle_1
```

```
## Panobinostat_2_vs_Vehicle_2
```

```
##
```

```
## The following valid label columns were detected:
## 126, 127L, 127H, 128L, 128H, 129L, 129H, 130L, 130H, 131L.
```

```
##
## Importing TR dataset: Vehicle_1
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 300 out of 300 rows kept for further analysis.
```

```
##   -> Vehicle_1 contains 300 proteins.
```

```
##   -> 299 out of 300 proteins (99.67%) suitable for curve fit (criterion: > 2 valid fold changes per protein).
```

```
##
## Importing TR dataset: Vehicle_2
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 299 out of 299 rows kept for further analysis.
```

```
##   -> Vehicle_2 contains 299 proteins.
```

```
##   -> 296 out of 299 proteins (99%) suitable for curve fit (criterion: > 2 valid fold changes per protein).
```

```
##
## Importing TR dataset: Panobinostat_1
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 300 out of 300 rows kept for further analysis.
```

```
##   -> Panobinostat_1 contains 300 proteins.
```

```
##   -> 298 out of 300 proteins (99.33%) suitable for curve fit (criterion: > 2 valid fold changes per protein).
```

```
##
## Importing TR dataset: Panobinostat_2
```

```
## Removing duplicate identifiers using quality column 'qupm'...
```

```
## 300 out of 300 rows kept for further analysis.
```

```
##   -> Panobinostat_2 contains 300 proteins.
```

```
##   -> 294 out of 300 proteins (98%) suitable for curve fit (criterion: > 2 valid fold changes per protein).
```

```
##
```

## 3.2 Performing thermal co-aggregation analysis with `Rtpca`

Then, we load `string_ppi_df` which is a data frame that annotates
protein-protein interactions as obtained from StringDB (Szklarczyk et al., [2019](#ref-Szklarczyk2019)) that
comes with the `Rtpca` package

```
data("string_ppi_df")
string_ppi_df
```

```
## # A tibble: 252,558 × 4
##    x     y       combined_score pair
##    <chr> <chr>            <dbl> <chr>
##  1 ARF5  SPTBN2             909 ARF5:SPTBN2
##  2 ARF5  KIF13B             910 ARF5:KIF13B
##  3 ARF5  KIF21A             910 ARF5:KIF21A
##  4 ARF5  TMED7              906 ARF5:TMED7
##  5 ARF5  ARFGAP1            971 ARF5:ARFGAP1
##  6 ARF5  ANK2               915 ANK2:ARF5
##  7 ARF5  KLC1               905 ARF5:KLC1
##  8 ARF5  COPZ2              927 ARF5:COPZ2
##  9 ARF5  KIF15              914 ARF5:KIF15
## 10 ARF5  DCTN5              902 ARF5:DCTN5
## # ℹ 252,548 more rows
```

This table has been created from the human *protein.links* table downloaded from the StringDB website. It can serve as a template for users to create equivalent tables for other organisms.

### 3.2.1 Run TPCA on data from a single condition

We can run TPCA for protein-protein interactions like this by using the
function `runTPCA`

```
string_ppi_cs_950_df <- string_ppi_df %>%
    filter(combined_score >= 950 )

vehTPCA <- runTPCA(
    objList = trData,
    ppiAnno = string_ppi_cs_950_df
)
```

```
## Checking input arguments.
```

```
##
## Creating distance matrices.
```

```
##
## Testing for complex co-aggregation.
```

```
##
## Performing PPi ROC analysis.
```

Note: it is not necessary that your data has the format of the TPP package
(ExpressionSet), you can also supply the function with a list of matrices of
data frames (in the case of data frames you need to additionally indicate with
column contains the protein or gene names).

We can also run TPCA to test for coaggregation of protein complexes. For this
purpose with can load a data frame that annotates proteins to protein complexes
curated by Ori et al. ([2016](#ref-Ori2016))

```
data("ori_et_al_complexes_df")
ori_et_al_complexes_df
```

```
## # A tibble: 2,597 × 3
##    ensembl_id      protein id
##    <chr>           <chr>   <chr>
##  1 ENSG00000222028 PSMB11  26S Proteasome
##  2 ENSG00000108671 PSMD11  26S Proteasome
##  3 ENSG00000197170 PSMD12  26S Proteasome
##  4 ENSG00000110801 PSMD9   26S Proteasome
##  5 ENSG00000115233 PSMD14  26S Proteasome
##  6 ENSG00000101182 PSMA7   26S Proteasome
##  7 ENSG00000108344 PSMD3   26S Proteasome
##  8 ENSG00000101843 PSMD10  26S Proteasome
##  9 ENSG00000165916 PSMC3   26S Proteasome
## 10 ENSG00000008018 PSMB1   26S Proteasome
## # ℹ 2,587 more rows
```

Then, we can invoke

```
vehComplexTPCA <- runTPCA(
    objList = trData,
    complexAnno = ori_et_al_complexes_df,
    minCount = 2
)
```

```
## Checking input arguments.
```

```
##
## Creating distance matrices.
```

```
##
## Testing for complex co-aggregation.
```

```
##
## Performing Complex ROC analysis.
```

We can plot a ROC curve for how well our data captures protein-protein
interactions:

```
plotPPiRoc(vehTPCA, computeAUC = TRUE)
```

![](data:image/png;base64...)

And we can also plot a ROC curve for how well our data captures protein
complexes:

```
plotComplexRoc(vehComplexTPCA, computeAUC = TRUE)
```

![](data:image/png;base64...)

### 3.2.2 Run differential TPCA on two conditions

In order to test for protein-protein interactions that change significantly
between both conditions, we can run the `runDiffTPCA` as illustrated below:

```
diffTPCA <-
    runDiffTPCA(
        objList = trData[1:2],
        contrastList = trData[3:4],
        ctrlCondName = "DMSO",
        contrastCondName = "Panobinostat",
        ppiAnno = string_ppi_cs_950_df)
```

```
## Checking input arguments.
```

```
## Creating distance matrices.
```

```
## Comparing annotated protein-pairs across conditions.
```

```
## Comparing random protein-pairs across conditions.
```

```
## Generating result table.
```

We can then plot a volcano plot to visualize the results:

```
plotDiffTpcaVolcano(
    diffTPCA,
    setXLim = TRUE,
    xlimit = c(-0.5, 0.5))
```

![](data:image/png;base64...)

The underlying result table can be inspected like this;

```
head(diffTpcaResultTable(diffTPCA) %>%
         arrange(p_value) %>%
        dplyr::select(pair, rssC1_rssC2, f_stat, p_value, p_adj))
```

```
## # A tibble: 6 × 5
##   pair            rssC1_rssC2 f_stat p_value p_adj
##   <chr>                 <dbl>  <dbl>   <dbl> <dbl>
## 1 PPP2R1A:PPP2R2D      0.109    3.86  0.0233 0.672
## 2 KPNA6:KPNB1         -0.0707   3.62  0.0267 0.672
## 3 NDUFS4:NDUFV2     -292.       2.95  0.0371 0.672
## 4 GLB1:HEXA           -0.143    2.84  0.0402 0.672
## 5 SEC22B:SEC24D       -1.05     2.77  0.0423 0.672
## 6 MAP2K4:MAP3K2        0.0683   2.58  0.0482 0.672
```

We can see that none of these interactions is significant consiering the
multiple comparisons we have done. Yet, we can look at the melting curves of
pairs like the “KPNA6:KPNB1” by evoking:

```
plotPPiProfiles(diffTPCA, pair = c("KPNA6", "KPNB1"))
```

![](data:image/png;base64...)
We can see that both protein do seem to coaggregate, but that the mild
difference in the treatment condition compared to the control condition is
likely due to technical rather than biological reasons.
This way of inspecting hits obtained by the differential analysis is
recommended in the case that significant pairs can be found to validate that
they do coaggregate in one condition and that the less strong coaggregations
in the other condition is based on reliable signal.

# 4 Additional remarks

As mentioned above, this vignette includes only a very minimal example, have a
look at a more extensive example [here](https://github.com/nkurzaw/Rtpca_analysis/blob/master/Becher_et_al_reanalysis.pdf).

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] TPP_3.38.0          magrittr_2.0.4      Biobase_2.70.0
## [4] BiocGenerics_0.56.0 generics_0.1.4      Rtpca_1.20.0
## [7] tidyr_1.3.1         dplyr_1.1.4         BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6         xfun_0.53            bslib_0.9.0
##  [4] ggplot2_4.0.0        lattice_0.22-7       nls2_0.3-4
##  [7] bitops_1.0-9         vctrs_0.6.5          tools_4.5.1
## [10] stats4_4.5.1         parallel_4.5.1       tibble_3.3.0
## [13] pkgconfig_2.0.3      proto_1.0.0          Matrix_1.7-4
## [16] data.table_1.17.8    RColorBrewer_1.1-3   S7_0.2.0
## [19] VennDiagram_1.7.3    lifecycle_1.0.4      stringr_1.5.2
## [22] compiler_4.5.1       farver_2.1.2         tinytex_0.57
## [25] statmod_1.5.1        codetools_0.2-20     htmltools_0.5.8.1
## [28] sass_0.4.10          RCurl_1.98-1.17      fdrtool_1.2.18
## [31] yaml_2.3.10          pillar_1.11.1        jquerylib_0.1.4
## [34] MASS_7.3-65          cachem_1.1.0         limma_3.66.0
## [37] magick_2.9.0         iterators_1.0.14     foreach_1.5.2
## [40] nlme_3.1-168         tidyselect_1.2.1     zip_2.3.3
## [43] digest_0.6.37        stringi_1.8.7        reshape2_1.4.4
## [46] purrr_1.1.0          bookdown_0.45        labeling_0.4.3
## [49] splines_4.5.1        fastmap_1.2.0        grid_4.5.1
## [52] cli_3.6.5            utf8_1.2.6           dichromat_2.0-0.1
## [55] withr_3.0.2          scales_1.4.0         rmarkdown_2.30
## [58] lambda.r_1.2.4       gridExtra_2.3        futile.logger_1.4.3
## [61] openxlsx_4.2.8       VGAM_1.1-13          evaluate_1.0.5
## [64] knitr_1.50           doParallel_1.0.17    mgcv_1.9-3
## [67] rlang_1.1.6          futile.options_1.0.1 Rcpp_1.1.0
## [70] glue_1.8.0           BiocManager_1.30.26  formatR_1.14
## [73] pROC_1.19.0.1        jsonlite_2.0.0       R6_2.6.1
## [76] plyr_1.8.9
```

# 5 Acknowledgements

A big thanks to Thomas Naake and Mike Smith for helping with speeding up the code.

# References

Martinez Molina, D., Jafari, R., Ignatushchenko, M., Seki, T., Larsson, E.A., Dan, C., Sreekumar, L., Cao, Y., and Nordlund, P. (2013). Monitoring drug target engagement in cells and tissues using the cellular thermal shift assay. Science *341*, 84–87.

Mateus, A., Kurzawa, N., Becher, I., Sridharan, S., Helm, D., Stein, F., Typas, A., and Savitski, M.M. (2020). Thermal proteome profiling for interrogating protein interactions. Molecular Systems Biology 16, e9232.

Ori, A., Iskar, M., Buczak, K., Kastritis, P., Parca, L., Andrés-pons, A., Singer, S., Bork, P., and Beck, M. (2016). Spatiotemporal variation of mammalian protein complex stoichiometries. Genome Biology 1–15.

Savitski, M.M., Reinhard, F.B.M., Franken, H., Werner, T., Savitski, M.F., Eberhard, D., Martinez Molina, D., Jafari, R., Dovega, R.B., Klaeger, S., et al. (2014). Tracking cancer drugs in living cells by thermal profiling of the proteome. Science *346, 6205*, 1255784.

Szklarczyk, D., Gable, A.L., Lyon, D., Junge, A., Wyder, S., Huerta-Cepas, J., Simonovic, M., Doncheva, N.T., Morris, J.H., Bork, P., et al. (2019). STRING v11: Protein-protein association networks with increased coverage, supporting functional discovery in genome-wide experimental datasets. Nucleic Acids Research *47*, D607–D613.

Tan, C.S.H., Go, K.D., Bisteau, X., Dai, L., Yong, C.H., Prabhu, N., Ozturk, M.B., Lim, Y.T., Sreekumar, L., Lengqvist, J., et al. (2018). Thermal proximity coaggregation for system-wide profiling of protein complex dynamics in cells. Science *359, 6380*, 1170–1177.