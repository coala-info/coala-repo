# multistateQTL: Orchestrating multi-state QTL analysis in R

Christina B Azodi, Davis McCarthy and Amelia Dunstone

#### 2025-10-30

#### Package

multistateQTL 2.2.0

# 1 Introduction

`multistateQTL` is a Bioconductor package for applying basic statistical tests (e.g., feature-wise FDR correction, calculating pairwise sharing), summarizing, and visualizing QTL summary statistics from multiple states (e.g., tissues, celltypes, environmental conditions). It works on the `QTLExperiment` (`QTLE`) object class, where rows represent features (e.g., genes, transcripts, genomic regions), columns represent states, and assays are the various summary statistics. It also provides wrapper implementations of a number of multi-test correction methods (e.g., [mashr](https://github.com/stephenslab/mashr), [meta-soft](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3146723/), etc), which result in a set of multi-test corrected summary statistics.

## 1.1 Installation

QTLExperiment and multistateQTL can be installed from GitHub:

```
if (!require("BiocManager", quietly=TRUE))
    install.packages("BiocManager")

BiocManager::install(c("QTLExperiment", "multistateQTL"))
```

They are also available on GitHub:

```
devtools::install_git("https://github.com/dunstone-a/QTLExperiment", build_vignettes=TRUE)
devtools::install_git(https://github.com/dunstone-a/multistateQTL", build_vignettes=TRUE)
```

```
library(QTLExperiment)
library(multistateQTL)
```

# 2 Simulating data

## 2.1 Estimate parameters from GTEx

Provided with real QTL summary statistics as either a `QTLE` object or a named list with betas and error (and optionally pval or lfsr), key parameters are estimated that are used to simulate realistic multi-state QTL data. We demonstrate the parameter estimation function on publicly available summary statistics from GTEx (v8). Note that this data only contains tests that were called as significant by GTEx and vroom only loads the first chunk of results as it does not read .gz compressed objects well. This truncated dataset is used in the vignette for convenience, however, to estimate the default parameters in `qtleParams()` we downloaded QTL summary statistics for all associations tested for the 10 GTEx tissues with the largest sample sizes from [Google Cloud](https://console.cloud.google.com/storage/browser/gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_eQTL_all_associations?pageState=(%22StorageObjectListTable%22%3A(%22f%22%3A%22%255B%255D%22))&prefix&forceOnObjectsSortingFiltering=false&cloudshell=true)). To speed up calculations we filtered this to include only associations on chromosome 1 and considered significant tests with pval < 0.05 and null tests with a pval > 0.1.

See [QTLExperiment](https://github.com/dunstone-a/QTLExperiment) for more info on the `sumstats2qtle` function and for other approaches for reading in QTL summary statistics.

The parameters estimated here include:

* **Significant betas shape and rate:** Define the gamma distribution used to sample *mean effect sizes* for each QTL that is significant in at least one state. These simulated mean effect sizes are used as the mean parameter in `rnorm` to sample an effect size for each QTL for each state. The variance parameter for `rnorm` is user defined (default = 0.1).
* **Significant coefficient of variation (cv) shape and rate:** Define the gamma distribution used to sample the cv for each QTL in each state where that QTL is significant. The cv is multiplied by the simulated significant effect size for that test/state to get the simulated standard error values.
* **Null beta shape and rate:** Define the gamma distribution used to sample the effect sizes for each QTL in each state where the effect is not significant.
* **Null beta cv shape and rate:** Define the gamma distribution used to sample the cv for each QTL in each state where that QTL is not significant. This cv is then multiplied by the simulated null effect size for that test/state to get the simulated stand error values.

```
input_path <- system.file("extdata", package="multistateQTL")
state <- c("lung", "thyroid", "spleen", "blood")

input <- data.frame(
    state=state,
    path=paste0(input_path, "/GTEx_tx_", state, ".tsv"))

gtex <- sumstats2qtle(
    input,
    feature_id="molecular_trait_id",
    variant_id="rsid",
    betas="beta",
    errors="se",
    pvalues="pvalue",
    verbose=TRUE)
gtex
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
head(betas(gtex))
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

Estimating parameters:

```
params <- qtleEstimate(gtex, threshSig=0.05, threshNull=0.5)
params
```

```
## $cv.sig.shape
## [1] 7.070354
##
## $cv.sig.rate
## [1] 7.717703
##
## $cv.null.shape
## [1] 1.903592
##
## $cv.null.rate
## [1] 0.8979238
##
## $betas.sig.shape
## [1] 3.470245
##
## $betas.sig.rate
## [1] 16.27222
##
## $betas.null.shape
## [1] 1.360183
##
## $betas.null.rate
## [1] 11.03394
```

Looking at the distributions defined by these estimated parameters, the simulated effect sizes for significant QTL will tend to be larger, while the simulated coefficient of variation values will be smaller than for the non-significant QTL.

```
plotSimulationParams(params=params)
```

![Gamma distributions defined by the parameters estimated by qtleEstimate.](data:image/png;base64...)

(#fig:plot-estimated params)Gamma distributions defined by the parameters estimated by qtleEstimate.

The default parameters available through `qtleParams()` were estimated from the GTEx v8 tissue-level eQTL summary statistics from chromosome 1 using the 10 tissues with the largest sample sizes. From these data, significant QTL parameters were estimated from tests in the lowest p-value quantile, while null parameters were estimated from tests in the highest p-value quantile. Data for tests on chromosome 1 were included in all four tissues (n=32613).

## 2.2 Simulate multi-state QTL data

The simulation tool allows for the simulation of four types of associations: (1) Global, where the simulated effect size is approximately equal across all states; (2) Unique, where the association is only significant in one state; (3) Multi-state, where the association is significant in a subset of states (i.e., state-groups), and (4) Null, where the association has no significant effects in any state. First each test is randomly assigned as one of the above types according to the proportions specified by the user. For multi-state QTL, each state is assigned to a state-group, either randomly or according to user defined groups, then each multi-state QTL is assigned randomly to one of the state-groups. For unique QTL, the QTL is randomly assigned to a single state.

Simulated mean effect sizes for all non-null QTL are sampled from gamma(beta.sig.shape, beta.sig.rate) and are randomly assigned a positive or negative effect direction. Then for each state where that QTL is significant, an effect size is sampled from N(mean effect size, σ), where σ is user defined (default=0.1). Effect sizes for null QTL are sampled from gamma(beta.null.shape, beta.null.rate) and are randomly assigned a positive or negative effect direction. Standard errors for each QTL for each state are simulated by sampling from gamma(cv.sig.shape, cv.sig.rate) or gamma(cv.null.shape, cv.null.rate) for significant and null QTL, respectively, and multiplying the sampled cv by the absolute value of the simulated beta for that QTL in that state.

Here is an example of a simple simulation with half of the simulated QTL tests having globally significant effects. This example uses the default parameters.

```
sim <- qtleSimulate(nTests=1000, nStates=6, global=0.5)
sim
```

```
## class: QTLExperiment
## dim: 1000 6
## metadata(0):
## assays(3): betas errors lfsrs
## rownames(1000): F0867|v86973 F0107|v67504 ... F0874|v42722 F0190|v78203
## rowData names(11): feature_id variant_id ... S5 S6
## colnames(6): S1 S2 ... S5 S6
## colData names(1): state_id
```

```
head(rowData(sim))
```

```
## DataFrame with 6 rows and 11 columns
##               feature_id  variant_id         QTL           id mean_beta
##              <character> <character> <character>  <character> <numeric>
## F0867|v86973       F0867      v86973      global F0867|v86973  0.274222
## F0107|v67504       F0107      v67504      global F0107|v67504  0.740930
## F0239|v64205       F0239      v64205      global F0239|v64205  0.211987
## F0531|v90951       F0531      v90951      global F0531|v90951 -0.650529
## F0950|v93596       F0950      v93596        null F0950|v93596  0.000000
## F0851|v25798       F0851      v25798        null F0851|v25798  0.000000
##                     S1        S2        S3        S4        S5        S6
##              <logical> <logical> <logical> <logical> <logical> <logical>
## F0867|v86973      TRUE      TRUE      TRUE      TRUE      TRUE      TRUE
## F0107|v67504      TRUE      TRUE      TRUE      TRUE      TRUE      TRUE
## F0239|v64205      TRUE      TRUE      TRUE      TRUE      TRUE      TRUE
## F0531|v90951      TRUE      TRUE      TRUE      TRUE      TRUE      TRUE
## F0950|v93596     FALSE     FALSE     FALSE     FALSE     FALSE     FALSE
## F0851|v25798     FALSE     FALSE     FALSE     FALSE     FALSE     FALSE
```

We can also generate more complex simulations, for example this simulation has 20% global, 40% multi-state, 20% unique, and 20% null QTL effects, where multi-state effects are assigned to one of two state-groups.

```
sim <- qtleSimulate(
    nStates=10, nFeatures=100, nTests=1000,
    global=0.2, multi=0.4, unique=0.2, k=2)
```

Here is a snapshot of the simulation key for QTL simulated as unique to a single state:

```
head(rowData(subset(sim, QTL == "unique")))
```

```
## DataFrame with 6 rows and 16 columns
##              feature_id  variant_id         QTL          id mean_beta       S01
##             <character> <character> <character> <character> <numeric> <logical>
## F064|v35885        F064      v35885      unique F064|v35885  0.409911     FALSE
## F004|v26038        F004      v26038      unique F004|v26038  0.460528     FALSE
## F088|v38945        F088      v38945      unique F088|v38945  1.279785     FALSE
## F072|v77053        F072      v77053      unique F072|v77053  0.577497     FALSE
## F020|v13801        F020      v13801      unique F020|v13801  0.428142     FALSE
## F031|v81523        F031      v81523      unique F031|v81523 -0.443593     FALSE
##                   S02       S03       S04       S05       S06       S07
##             <logical> <logical> <logical> <logical> <logical> <logical>
## F064|v35885     FALSE     FALSE     FALSE     FALSE     FALSE     FALSE
## F004|v26038     FALSE     FALSE     FALSE     FALSE     FALSE     FALSE
## F088|v38945     FALSE     FALSE     FALSE     FALSE     FALSE     FALSE
## F072|v77053     FALSE     FALSE     FALSE     FALSE     FALSE     FALSE
## F020|v13801     FALSE     FALSE     FALSE     FALSE     FALSE     FALSE
## F031|v81523     FALSE     FALSE     FALSE     FALSE     FALSE     FALSE
##                   S08       S09       S10 multistateGroup
##             <logical> <logical> <logical>     <character>
## F064|v35885      TRUE     FALSE     FALSE              NA
## F004|v26038     FALSE      TRUE     FALSE              NA
## F088|v38945     FALSE      TRUE     FALSE              NA
## F072|v77053     FALSE     FALSE      TRUE              NA
## F020|v13801     FALSE     FALSE      TRUE              NA
## F031|v81523     FALSE      TRUE     FALSE              NA
```

Here is a snapshot of the simulation key for QTL simulated as multi-state:

```
head(rowData(subset(sim, QTL == "multistate")))
```

```
## DataFrame with 6 rows and 16 columns
##              feature_id  variant_id         QTL          id mean_beta       S01
##             <character> <character> <character> <character> <numeric> <logical>
## F023|v5205         F023       v5205  multistate  F023|v5205 -0.567860      TRUE
## F061|v76102        F061      v76102  multistate F061|v76102  0.589580     FALSE
## F072|v45821        F072      v45821  multistate F072|v45821  0.528045     FALSE
## F066|v36503        F066      v36503  multistate F066|v36503 -0.462518     FALSE
## F016|v385          F016        v385  multistate   F016|v385 -0.575820     FALSE
## F077|v62943        F077      v62943  multistate F077|v62943 -0.702591      TRUE
##                   S02       S03       S04       S05       S06       S07
##             <logical> <logical> <logical> <logical> <logical> <logical>
## F023|v5205      FALSE      TRUE     FALSE      TRUE      TRUE     FALSE
## F061|v76102      TRUE     FALSE      TRUE     FALSE     FALSE      TRUE
## F072|v45821      TRUE     FALSE      TRUE     FALSE     FALSE      TRUE
## F066|v36503      TRUE     FALSE      TRUE     FALSE     FALSE      TRUE
## F016|v385        TRUE     FALSE      TRUE     FALSE     FALSE      TRUE
## F077|v62943     FALSE      TRUE     FALSE      TRUE      TRUE     FALSE
##                   S08       S09       S10 multistateGroup
##             <logical> <logical> <logical>     <character>
## F023|v5205       TRUE      TRUE      TRUE          Group1
## F061|v76102     FALSE     FALSE     FALSE          Group2
## F072|v45821     FALSE     FALSE     FALSE          Group2
## F066|v36503     FALSE     FALSE     FALSE          Group2
## F016|v385       FALSE     FALSE     FALSE          Group2
## F077|v62943      TRUE      TRUE      TRUE          Group1
```

```
message("Number of QTL specific to each state-group:")
table(rowData(subset(sim, QTL == "multistate"))$multistateGroup)
```

```
##
## Group1 Group2
##    180    220
```

# 3 Dealing with missing data

The multistateQTL toolkit provides two functions to help deal with missing data, `getComplete` and `replaceNAs`. The `getComplete` function is a smart subsetting function that remove QTL associations (rows) with more than an allowed amount of missing data. The `replaceNAs` function allows for NAs in each assay to be replaced with a constant or with the row mean or row median. For example, here is a snapshot of our simulated data from above with added NAs:

```
na_pattern <- sample(seq(1, ncol(sim)*nrow(sim)), 1000)

sim_na <- sim
assay(sim_na, "betas")[na_pattern] <- NA
assay(sim_na, "errors")[na_pattern] <- NA
assay(sim_na, "lfsrs")[na_pattern] <- NA

message("Number of simulated tests: ", nrow(sim_na))
head(betas(sim_na))
```

```
##                    S01        S02         S03        S04        S05        S06
## F023|v5205  -0.6408860         NA -0.61015989  0.4746848 -0.5355503 -0.5996299
## F064|v35885  0.3058540  0.1503173  0.39147843  0.3581393 -0.2495009  0.3656625
## F061|v76102  0.6789483  0.6452821  0.01386314  0.6205773  0.1526890  0.1482970
## F072|v45821 -0.2920567  0.5642467          NA  0.5109627 -0.2517743  0.1750774
## F052|v25298  0.1206159 -0.4384336  0.63220732  0.2553040  0.1784669         NA
## F066|v36503  0.2950614 -0.5365944  0.04943200 -0.4945238  0.2825350 -0.1313272
##                    S07       S08        S09        S10
## F023|v5205          NA        NA -0.5265607 -0.7008404
## F064|v35885  0.1797833 0.3770677  0.2747453  0.2506665
## F061|v76102  0.7101835 0.2389427  0.4925350 -0.6088679
## F072|v45821  0.5460297 0.1897046 -0.5222729         NA
## F052|v25298  0.3867841 0.3070954         NA -0.6314165
## F066|v36503 -0.5335727 0.2287540         NA -0.1775369
```

First we can use `getComplete` to keep only the tests that have data for at least half of the states:

```
sim_na <- getComplete(sim_na, n=0.5, verbose=TRUE)
```

Then for the remaining QTL, we can fill in the missing values using the following scheme

```
sim_na <- replaceNAs(sim_na, verbose=TRUE)

head(betas(sim_na))
```

```
##                    S01        S02         S03        S04        S05        S06
## F023|v5205  -0.6408860  0.0000000 -0.61015989  0.4746848 -0.5355503 -0.5996299
## F064|v35885  0.3058540  0.1503173  0.39147843  0.3581393 -0.2495009  0.3656625
## F061|v76102  0.6789483  0.6452821  0.01386314  0.6205773  0.1526890  0.1482970
## F072|v45821 -0.2920567  0.5642467  0.00000000  0.5109627 -0.2517743  0.1750774
## F052|v25298  0.1206159 -0.4384336  0.63220732  0.2553040  0.1784669  0.0000000
## F066|v36503  0.2950614 -0.5365944  0.04943200 -0.4945238  0.2825350 -0.1313272
##                    S07       S08        S09        S10
## F023|v5205   0.0000000 0.0000000 -0.5265607 -0.7008404
## F064|v35885  0.1797833 0.3770677  0.2747453  0.2506665
## F061|v76102  0.7101835 0.2389427  0.4925350 -0.6088679
## F072|v45821  0.5460297 0.1897046 -0.5222729  0.0000000
## F052|v25298  0.3867841 0.3070954  0.0000000 -0.6314165
## F066|v36503 -0.5335727 0.2287540  0.0000000 -0.1775369
```

# 4 Calling significance

The multistateQTL toolkit also provides the `callSignificance` function, which calls QTL tests significant in each state using either a single or two-step threshold approach. For example, we can set a single lfsr threshold of 0.1 to call significance of our simulate QTL:

```
sim <- callSignificance(sim, assay="lfsrs", thresh=0.05)

message("Median number of significant tests per state: ",
    median(colData(sim)$nSignificant))
```

Because we have the simulated ground-truth, we can compare these significance calls to what was simulated using the `simPerformance` function, which provides the following global (i.e. across all state) performance metrics:

```
sim <- callSignificance(sim, assay="lfsrs", thresh=0.001)
perf_metrics <- simPerformance(sim)
lapply(perf_metrics, FUN=function(x) {round(x, 2)})
```

```
## $accuracy
## [1] 0.41
##
## $precision
## [1] 0.41
##
## $recall
## [1] 1
##
## $f1
## [1] 0.58
##
## $cm
##          called
## simulated FALSE TRUE
##     FALSE    33 5847
##     TRUE     15 4105
```

As you can see the recall of TRUE significant QTL is quite low. However if we change our significance calling approach to be more flexible.

```
sim <- callSignificance(
    sim, mode="simple", assay="lfsrs",
    thresh=0.0001, secondThresh=0.0002)
simPerformance(sim)$recall
```

```
## [1] 0.990534
```

# 5 Plotting global patterns of sharing

The `multistateQTL` package contains five functions for visualising multi-state eQTL data.
These functions are based on the *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* and *[ComplexHeatmap](https://bioconductor.org/packages/3.22/ComplexHeatmap)* R packages.

* `plotPairwiseSharing`: based on `ComplexHeatmap::Heatmap`
* `plotQTLClusters`: based on `ComplexHeatmap::Heatmap`
* `plotUpSet`: based on `ComplexHeatmap::UpSet`
* `plotCompareStates`: based on `ggplot2`
* `plotSimulationParams`: based on `ggplot2`

The functions built on `ggplot2` are compatible with `ggplot2` syntax such as the `+` operator.

## 5.1 Pairwise sharing

The function `plotPairwiseSharing` shows the degree of pairwise sharing of significant hits for each combination of two states.
Column annotations can be added by specifying a valid column name from the `colData` of the object.

In the plot below, columns are ordered by the broad cell type (`multistateGroup`) of the states.
We expect states belonging to the same multi-state group to be more related and have a greater degree of sharing of significant eQTLs.
Column annotations are used to show the number of significant eQTLs for each state.

```
sim_sig <- getSignificant(sim)
sim_top <- getTopHits(sim_sig, assay="lfsrs", mode="state")
sim_top <- runPairwiseSharing(sim_top)
p1 <- plotPairwiseSharing(sim_top, annotateColsBy=c("nSignificant", "multistateGroup"))
p1
```

![](data:image/png;base64...)

## 5.2 Upset plots

These plots show the set of tests that are significant, but not necessarily shared, by groups of states.

```
plotUpSet(sim_top, annotateColsBy=c("nSignificant", "multistateGroup"))
```

![](data:image/png;base64...)

# 6 Characterizing multi-state QTL patterns

## 6.1 Categorizing multi-state QTL tests

Once multi-state test correction is performed, you will want to identify global, multi-state, and unique QTL.

Note that `plotCompareStates` returns a list with a `ggplot2` object as the first element and a `table` as the second element.
These can be accessed using the names “plot” or “counts”.

```
sim_top <- runTestMetrics(sim_top)

plotCompareStates(sim_top, x="S01", y="S02")
```

```
## $plot
```

![](data:image/png;base64...)

```
##
## $counts
##
##            S01            S02 both_diverging    both_shared
##             13              9            160            271
```

```
table(rowData(sim_top)$qtl_type)
```

```
##
##     global_diverging        global_shared multistate_diverging
##                  253                  124                   63
##    multistate_shared
##                   13
```

```
hist(rowData(sim_top)$nSignificant)
```

![](data:image/png;base64...)

## 6.2 Visualizing multi-state QTL

The function `plotQTLClusters` can be used to produce a heatmap of the eQTL betas values for each state.
Each row is a SNP-gene pair, and columns are states.
Row and column annotations can be added by naming column names from the `rowData` or `colData` of the input `QTLExperiment` object.

```
sim_top_ms <- subset(sim_top, qtl_type_simple == "multistate")

plotQTLClusters(
    sim_top_ms,
    annotateColsBy=c("multistateGroup"),
    annotateRowsBy=c("qtl_type", "mean_beta", "QTL"))
```

![](data:image/png;base64...)

# 7 Session Info

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] multistateQTL_2.2.0         collapse_2.1.4
##  [3] ComplexHeatmap_2.26.0       QTLExperiment_2.2.0
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] BiocGenerics_0.56.0         generics_0.1.4
## [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gridExtra_2.3       rlang_1.1.6         magrittr_2.0.4
##  [4] clue_0.3-66         GetoptLong_1.0.5    compiler_4.5.1
##  [7] png_0.1-8           vctrs_0.6.5         pkgconfig_2.0.3
## [10] shape_1.4.6.1       crayon_1.5.3        fastmap_1.2.0
## [13] magick_2.9.0        backports_1.5.0     XVector_0.50.0
## [16] labeling_0.4.3      rmarkdown_2.30      tzdb_0.5.0
## [19] tinytex_0.57        purrr_1.1.0         bit_4.6.0
## [22] xfun_0.53           cachem_1.1.0        jsonlite_2.0.0
## [25] DelayedArray_0.36.0 irlba_2.3.5.1       parallel_4.5.1
## [28] cluster_2.1.8.1     R6_2.6.1            bslib_0.9.0
## [31] RColorBrewer_1.1-3  SQUAREM_2021.1      jquerylib_0.1.4
## [34] Rcpp_1.1.0          bookdown_0.45       assertthat_0.2.1
## [37] iterators_1.0.14    knitr_1.50          Matrix_1.7-4
## [40] splines_4.5.1       tidyselect_1.2.1    dichromat_2.0-0.1
## [43] abind_1.4-8         yaml_2.3.10         viridis_0.6.5
## [46] doParallel_1.0.17   codetools_0.2-20    lattice_0.22-7
## [49] tibble_3.3.0        plyr_1.8.9          withr_3.0.2
## [52] S7_0.2.0            evaluate_1.0.5      archive_1.1.12
## [55] survival_3.8-3      fitdistrplus_1.2-4  circlize_0.4.16
## [58] pillar_1.11.1       BiocManager_1.30.26 checkmate_2.3.3
## [61] foreach_1.5.2       vroom_1.6.6         invgamma_1.2
## [64] truncnorm_1.0-9     ggplot2_4.0.0       scales_1.4.0
## [67] ashr_2.2-63         glue_1.8.0          tools_4.5.1
## [70] data.table_1.17.8   mvtnorm_1.3-3       Cairo_1.7-0
## [73] tidyr_1.3.1         colorspace_2.1-2    mashr_0.2.79
## [76] cli_3.6.5           mixsqp_0.3-54       S4Arrays_1.10.0
## [79] viridisLite_0.4.2   dplyr_1.1.4         gtable_0.3.6
## [82] sass_0.4.10         digest_0.6.37       SparseArray_1.10.0
## [85] rjson_0.2.23        farver_2.1.2        htmltools_0.5.8.1
## [88] lifecycle_1.0.4     rmeta_3.0           GlobalOptions_0.1.2
## [91] bit64_4.6.0-1       MASS_7.3-65
```