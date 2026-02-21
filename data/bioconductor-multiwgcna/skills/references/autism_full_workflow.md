# multiWGCNA: the full workflow

Dario Tommasini

#### 2025-10-07

# Contents

* [1 Introduction](#introduction)
* [2 Install the multiWGCNA R package](#install-the-multiwgcna-r-package)
* [3 Load microarray data from human post-mortem brains](#load-microarray-data-from-human-post-mortem-brains)
* [4 Perform network construction, module eigengene calculation, module-trait correlation](#perform-network-construction-module-eigengene-calculation-module-trait-correlation)
* [5 Compare modules by overlap across conditions](#compare-modules-by-overlap-across-conditions)
* [6 Perform differential module expression analysis](#perform-differential-module-expression-analysis)
* [7 Perform the module preservation analysis](#perform-the-module-preservation-analysis)
* [8 Summarize interesting results from the analyses](#summarize-interesting-results-from-the-analyses)
* [9 Print the session info](#print-the-session-info)

# 1 Introduction

The multiWGCNA R package is a WGCNA-based procedure designed for RNA-seq datasets with two biologically meaningful variables. We developed this package because we’ve found that the experimental design for network analysis can be ambiguous. For example, should I analyze my treatment and wildtype samples separately or together? We find that it is informative to perform all the possible design combinations, and subsequently integrate these results. For more information, please see Tommasini and Fogel. BMC Bioinformatics. 2023.

In this vignette, we will be showing how users can perform a full start-to-finish multiWGCNA analysis. We will be using the regional autism data from Voineagu et al. 2011 (<https://www.nature.com/articles/nature10110>). This dataset has two sample traits: 1) autism versus control, and 2) temporal cortex versus frontal cortex.

# 2 Install the multiWGCNA R package

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("multiWGCNA")
```

The development version of multiWGCNA can be installed from GitHub like this:

```
if (!require("devtools", quietly = TRUE))
    install.packages("devtools")

devtools::install_github("fogellab/multiWGCNA")
```

Load multiWGCNA library

```
library(multiWGCNA)
```

# 3 Load microarray data from human post-mortem brains

Since this is purely an example of how to run the entire analysis from start to finish, we are going to limit our analysis to 1500 randomly selected probes.

Input data:

* The expression data can be either a SummarizedExperiment object or a data.frame with genes as rows and samples as columns
* The sampleTable should be a data.frame with the first column named “Sample”. The second and third column names can be arbitrary, i.e. “disease” or “Genotype”

```
# Download data from the ExperimentHub
library(ExperimentHub)
eh = ExperimentHub()

# Note: this requires the SummarizedExperiment package to be installed
eh_query = query(eh, c("multiWGCNAdata"))
autism_se = eh_query[["EH8219"]]
#> see ?multiWGCNAdata and browseVignettes('multiWGCNAdata') for documentation
#> loading from cache

# Collect the metadata in the sampleTable
sampleTable = colData(autism_se)

# Randomly sample 1500 genes from the expression matrix
set.seed(1)
autism_se = autism_se[sample(rownames(autism_se), 1500),]

# Check the data
assays(autism_se)[[1]][1:5, 1:5]
#>              GSM706412 GSM706413 GSM706414 GSM706415 GSM706416
#> ILMN_1672121 11.034264 10.446682 11.473705 11.732849  11.43105
#> ILMN_2151368 10.379812  9.969130  9.990030  9.542288  10.26247
#> ILMN_1757569  9.426955  9.050024  9.347505  9.235251   9.38837
#> ILMN_2400219 12.604047 12.886037 12.890658 12.446960  12.98925
#> ILMN_2222101 12.385019 12.748229 12.418027 11.690253  13.10915
# sampleTable$Status = paste0("test_", sampleTable$Status, "_test")
# sampleTable$Sample = paste0(sampleTable$Sample, "_test")
sampleTable
#> DataFrame with 58 rows and 3 columns
#>                Sample      Status      Tissue
#>           <character> <character> <character>
#> GSM706412   GSM706412      autism          FC
#> GSM706413   GSM706413      autism          FC
#> GSM706414   GSM706414      autism          FC
#> GSM706415   GSM706415      autism          FC
#> GSM706416   GSM706416      autism          FC
#> ...               ...         ...         ...
#> GSM706465   GSM706465    controls          TC
#> GSM706466   GSM706466    controls          TC
#> GSM706467   GSM706467    controls          TC
#> GSM706468   GSM706468    controls          TC
#> GSM706469   GSM706469    controls          TC

# Define our conditions for trait 1 (disease) and 2 (brain region)
conditions1 = unique(sampleTable[,2])
conditions2 = unique(sampleTable[,3])
```

# 4 Perform network construction, module eigengene calculation, module-trait correlation

Also, let’s find best trait for each module and identify outlier modules (ie modules driven by a single sample).

Let’s use power = 10 since Voineagu et al. 2011 used that for all their networks. They also constructed “unsigned” networks and a mergeCutHeight of 0.10 so that modules with similar expression are merged. This step may take a minute.

```
# Construct the combined networks and all the sub-networks (autism only, controls only, FC only, and TC only)
autism_networks = constructNetworks(autism_se, sampleTable, conditions1, conditions2,
                                  networkType = "unsigned", power = 10,
                                  minModuleSize = 40, maxBlockSize = 25000,
                                  reassignThreshold = 0, minKMEtoStay = 0.7,
                                  mergeCutHeight = 0.10, numericLabels = TRUE,
                                  pamRespectsDendro = FALSE, verbose=3,
                                  saveTOMs = TRUE)
#>  Flagging genes and samples with too many missing values...
#>   ..step 1
#>  Calculating module eigengenes block-wise from all genes
#>    Flagging genes and samples with too many missing values...
#>     ..step 1
#>  ..Working on block 1 .
#>     TOM calculation: adjacency..
#>     ..will not use multithreading.
#>      Fraction of slow calculations: 0.000000
#>     ..connectivity..
#>     ..matrix multiplication (system BLAS)..
#>     ..normalization..
#>     ..done.
#>    ..saving TOM for block 1 into file combined-block.1.RData
#>  ....clustering..
#>  ....detecting modules..
#>  ....calculating module eigengenes..
#>  ....checking kME in modules..
#>      ..removing 163 genes from module 1 because their KME is too low.
#>      ..removing 126 genes from module 2 because their KME is too low.
#>      ..removing 59 genes from module 3 because their KME is too low.
#>      ..removing 18 genes from module 4 because their KME is too low.
#>      ..removing 28 genes from module 5 because their KME is too low.
#>      ..removing 24 genes from module 6 because their KME is too low.
#>      ..removing 9 genes from module 7 because their KME is too low.
#>  ..merging modules that are too close..
#>      mergeCloseModules: Merging modules whose distance is less than 0.1
#>        Calculating new MEs...
#>  softConnectivity: FYI: connecitivty of genes with less than 20 valid samples will be returned as NA.
#>  ..calculating connectivities..
#>  Flagging genes and samples with too many missing values...
#>   ..step 1
#>  Calculating module eigengenes block-wise from all genes
#>    Flagging genes and samples with too many missing values...
#>     ..step 1
#>  ..Working on block 1 .
#>     TOM calculation: adjacency..
#>     ..will not use multithreading.
#>      Fraction of slow calculations: 0.000000
#>     ..connectivity..
#>     ..matrix multiplication (system BLAS)..
#>     ..normalization..
#>     ..done.
#>    ..saving TOM for block 1 into file autism-block.1.RData
#>  ....clustering..
#>  ....detecting modules..
#>  ....calculating module eigengenes..
#>  ....checking kME in modules..
#>      ..removing 139 genes from module 1 because their KME is too low.
#>      ..removing 82 genes from module 2 because their KME is too low.
#>      ..removing 95 genes from module 3 because their KME is too low.
#>      ..removing 37 genes from module 4 because their KME is too low.
#>      ..removing 35 genes from module 5 because their KME is too low.
#>      ..removing 36 genes from module 6 because their KME is too low.
#>      ..removing 27 genes from module 7 because their KME is too low.
#>  ..merging modules that are too close..
#>      mergeCloseModules: Merging modules whose distance is less than 0.1
#>        Calculating new MEs...
#>  softConnectivity: FYI: connecitivty of genes with less than 10 valid samples will be returned as NA.
#>  ..calculating connectivities..
#>  Flagging genes and samples with too many missing values...
#>   ..step 1
#>  Calculating module eigengenes block-wise from all genes
#>    Flagging genes and samples with too many missing values...
#>     ..step 1
#>  ..Working on block 1 .
#>     TOM calculation: adjacency..
#>     ..will not use multithreading.
#>      Fraction of slow calculations: 0.000000
#>     ..connectivity..
#>     ..matrix multiplication (system BLAS)..
#>     ..normalization..
#>     ..done.
#>    ..saving TOM for block 1 into file controls-block.1.RData
#>  ....clustering..
#>  ....detecting modules..
#>  ....calculating module eigengenes..
#>  ....checking kME in modules..
#>      ..removing 212 genes from module 1 because their KME is too low.
#>      ..removing 107 genes from module 2 because their KME is too low.
#>      ..removing 65 genes from module 3 because their KME is too low.
#>      ..removing 51 genes from module 4 because their KME is too low.
#>      ..removing 50 genes from module 5 because their KME is too low.
#>      ..removing 40 genes from module 6 because their KME is too low.
#>  ..merging modules that are too close..
#>      mergeCloseModules: Merging modules whose distance is less than 0.1
#>        Calculating new MEs...
#>  softConnectivity: FYI: connecitivty of genes with less than 10 valid samples will be returned as NA.
#>  ..calculating connectivities..
#>  Flagging genes and samples with too many missing values...
#>   ..step 1
#>  Calculating module eigengenes block-wise from all genes
#>    Flagging genes and samples with too many missing values...
#>     ..step 1
#>  ..Working on block 1 .
#>     TOM calculation: adjacency..
#>     ..will not use multithreading.
#>      Fraction of slow calculations: 0.000000
#>     ..connectivity..
#>     ..matrix multiplication (system BLAS)..
#>     ..normalization..
#>     ..done.
#>    ..saving TOM for block 1 into file FC-block.1.RData
#>  ....clustering..
#>  ....detecting modules..
#>  ....calculating module eigengenes..
#>  ....checking kME in modules..
#>      ..removing 164 genes from module 1 because their KME is too low.
#>      ..removing 138 genes from module 2 because their KME is too low.
#>      ..removing 86 genes from module 3 because their KME is too low.
#>      ..removing 33 genes from module 4 because their KME is too low.
#>      ..removing 35 genes from module 5 because their KME is too low.
#>      ..removing 34 genes from module 6 because their KME is too low.
#>      ..removing 19 genes from module 7 because their KME is too low.
#>  ..merging modules that are too close..
#>      mergeCloseModules: Merging modules whose distance is less than 0.1
#>        Calculating new MEs...
#>  softConnectivity: FYI: connecitivty of genes with less than 11 valid samples will be returned as NA.
#>  ..calculating connectivities..
#>  Flagging genes and samples with too many missing values...
#>   ..step 1
#>  Calculating module eigengenes block-wise from all genes
#>    Flagging genes and samples with too many missing values...
#>     ..step 1
#>  ..Working on block 1 .
#>     TOM calculation: adjacency..
#>     ..will not use multithreading.
#>      Fraction of slow calculations: 0.000000
#>     ..connectivity..
#>     ..matrix multiplication (system BLAS)..
#>     ..normalization..
#>     ..done.
#>    ..saving TOM for block 1 into file TC-block.1.RData
#>  ....clustering..
#>  ....detecting modules..
#>  ....calculating module eigengenes..
#>  ....checking kME in modules..
#>      ..removing 146 genes from module 1 because their KME is too low.
#>      ..removing 119 genes from module 2 because their KME is too low.
#>      ..removing 52 genes from module 3 because their KME is too low.
#>      ..removing 31 genes from module 4 because their KME is too low.
#>      ..removing 34 genes from module 5 because their KME is too low.
#>      ..removing 12 genes from module 6 because their KME is too low.
#>      ..removing 13 genes from module 7 because their KME is too low.
#>      ..removing 10 genes from module 8 because their KME is too low.
#>  ..merging modules that are too close..
#>      mergeCloseModules: Merging modules whose distance is less than 0.1
#>        Calculating new MEs...
#>  softConnectivity: FYI: connecitivty of genes with less than 9 valid samples will be returned as NA.
#>  ..calculating connectivities..
```

# 5 Compare modules by overlap across conditions

For calculating significance of overlap, we use the hypergeometric test (also known as the one-sided Fisher exact test). We’ll save the results in a list. Then, let’s take a look at the mutual best matches between autism modules and control modules.

```
# Save results to a list
results=list()
results$overlaps=iterate(autism_networks, overlapComparisons, plot=TRUE)
#>
#> #### comparing combined and autism ####
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
#>
#> #### comparing combined and controls ####
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
#>
#> #### comparing combined and FC ####
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
#>
#> #### comparing combined and TC ####
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
#>
#> #### comparing autism and controls ####
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
#>
#> #### comparing autism and FC ####
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
#>
#> #### comparing autism and TC ####
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
#>
#> #### comparing controls and FC ####
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
#>
#> #### comparing controls and TC ####
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
#>
#> #### comparing FC and TC ####
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
# Check the reciprocal best matches between the autism and control networks
head(results$overlaps$autism_vs_controls$bestMatches)
#>   autism controls        p.adj
#> 1    000      000 8.297322e-45
#> 2    001      001 3.120968e-42
#> 3    005      002 1.086422e-39
#> 4    006      005 3.817972e-15
#> 5    002      006 1.644800e-10
```

You can use the TOMFlowPlot to plot the recruitment of genes from one network analysis to another. See Figure 6 from Tommasini and Fogel, 2023 for an example. Note that you will need to set saveTOMs = TRUE in the constructNetworks function above.

```
networks = c("autism", "controls")
toms = lapply(networks, function(x) {
  load(paste0(x, '-block.1.RData'))
  get("TOM")
})

# Check module autism_005
TOMFlowPlot(autism_networks,
            networks,
            toms,
            genes_to_label = topNGenes(autism_networks$autism, "autism_005"),
            color = 'black',
            alpha = 0.1,
            width = 0.05)
#> Clustering TOM tree 1...
#> Clustering TOM tree 2...
#> Warning in to_lodes_form(data = data, axes = axis_ind, discern =
#> params$discern): Some strata appear at multiple axes.
#> Warning in to_lodes_form(data = data, axes = axis_ind, discern =
#> params$discern): Some strata appear at multiple axes.
#> Warning in to_lodes_form(data = data, axes = axis_ind, discern =
#> params$discern): Some strata appear at multiple axes.
#> Warning: Removed 2872 rows containing missing values or values outside the scale range
#> (`geom_flow()`).
```

![](data:image/png;base64...)

# 6 Perform differential module expression analysis

This test for an association between the module eigengene (ME) and the two sample traits or their interaction. Therefore, the model is ME = trait1 + trait2 + trait1\*trait2 and tests for a significant association to the traits using factorial ANOVA. These results can be stored in the diffModExp component of the results list. It can also perform PERMANOVA, which uses multivariate distances and can thus be applied to the module expression rather than just the first principal component (module eigengene).

Module combined\_004 seems to be the module most significantly associated with disease status using standard ANOVA (module combined\_000 represents genes that were unassigned so disregard this module). Let’s use the diffModuleExpression function to visually check this module for an association to autism status.

Note: By setting plot = TRUE, the runDME function generates a PDF file called “combined\_DME.pdf” in the current directory with these plots for all the modules.

```
# Run differential module expression analysis (DME) on combined networks
results$diffModExp = runDME(autism_networks[["combined"]],
                            sampleTable,
                            p.adjust="fdr",
                            refCondition="Tissue",
                            testCondition="Status")
                            # plot=TRUE,
                            # out="combined_DME.pdf")

# to run PERMANNOVA
# library(vegan)
# results$diffModExp = runDME(autism_networks[["combined"]], p.adjust="fdr", refCondition="Tissue",
#                          testCondition="Status", plot=TRUE, test="PERMANOVA", out="PERMANOVA_DME.pdf")

# Check adjusted p-values for the two sample traits
results$diffModExp
#>                    Status Status*Tissue    Tissue
#> combined_000 0.0353564058     0.9136177 0.5793902
#> combined_001 0.0102214526     0.9136177 0.5793902
#> combined_002 0.1528251969     0.9136177 0.5793902
#> combined_003 0.1567507927     0.9136177 0.5793902
#> combined_004 0.0009209122     0.9136177 0.5793902
#> combined_005 0.3630573298     0.9136177 0.5793902
#> combined_006 0.0001526292     0.9136177 0.5793902

# You can check the expression of a specific module like this. Note that the values reported in the bottom panel title are p-values and not FDR-adjusted like in results$diffModExp
diffModuleExpression(autism_networks[["combined"]],
                     geneList = topNGenes(autism_networks[["combined"]], "combined_004"),
                     design = sampleTable,
                     test = "ANOVA",
                     plotTitle = "combined_004",
                     plot = TRUE)
```

![](data:image/png;base64...)

```
#> #### plotting combined_004 ####
#>         Factors      p.value
#> 1        Status 0.0002631178
#> 2        Tissue 0.5514341469
#> 3 Status*Tissue 0.8360827273
```

# 7 Perform the module preservation analysis

Determine if any modules in the autism data are not preserved in the healthy data (or vice versa). This is the slowest step as the calculation of permuted statistics takes a while. Typically, this can be parallelized using the enableWGCNAThreads function, but for this vignette we’ll just do 10 permutations so one core should suffice.

```
# To enable multi-threading
# library(doParallel)
# library(WGCNA)
# nCores = 8
# registerDoParallel(cores = nCores)
# enableWGCNAThreads(nThreads = nCores)

# Calculate preservation statistics
results$preservation=iterate(autism_networks[conditions1], # this does autism vs control; change to "conditions2" to perform comparison between FC and TC
                             preservationComparisons,
                             write=FALSE,
                             plot=TRUE,
                             nPermutations=10)
#>  Flagging genes and samples with too many missing values...
#>   ..step 1
#>  Flagging genes and samples with too many missing values...
#>   ..step 1
#>   ..checking data for excessive amounts of missing data..
#>      Flagging genes and samples with too many missing values...
#>       ..step 1
#>      Flagging genes and samples with too many missing values...
#>       ..step 1
#>   ..unassigned 'module' name: grey
#>   ..all network sample 'module' name: gold
#>   ..calculating observed preservation values
#>   ..calculating permutation Z scores
#>  ..Working with set 1 as reference set
#>  ....working with set 2 as test set
#>   ......parallel calculation of permuted statistics..
#> Warning: executing %dopar% sequentially: no parallel backend registered
#>  Flagging genes and samples with too many missing values...
#>   ..step 1
#>  Flagging genes and samples with too many missing values...
#>   ..step 1
#>   ..checking data for excessive amounts of missing data..
#>      Flagging genes and samples with too many missing values...
#>       ..step 1
#>      Flagging genes and samples with too many missing values...
#>       ..step 1
#>   ..unassigned 'module' name: grey
#>   ..all network sample 'module' name: gold
#>   ..calculating observed preservation values
#>   ..calculating permutation Z scores
#>  ..Working with set 1 as reference set
#>  ....working with set 2 as test set
#>   ......parallel calculation of permuted statistics..
```

![](data:image/png;base64...)

# 8 Summarize interesting results from the analyses

These include differentially preserved trait-associated modules and differentially expressed modules.

```
# Print a summary of the results
summarizeResults(autism_networks, results)
#> ### Non-preserved modules ###
#>              moduleSize Zsummary.pres Zdensity.pres Zconnectivity.pres
#> controls_003         65      9.616328      7.769176           11.46348
#>              Z.propVarExplained.pres Z.meanSignAwareKME.pres
#> controls_003                2.591291                12.77358
#>              Z.meanSignAwareCorDat.pres Z.meanAdj.pres Z.meanMAR.pres Z.cor.kIM
#> controls_003                   39.45015       2.764772       2.610056   6.19965
#>              Z.cor.kME Z.cor.kMEall Z.cor.cor Z.cor.MAR
#> controls_003  11.46348      185.709  32.06553  7.109537
#> ### Differentially expressed modules ###
#>                    Status Status*Tissue    Tissue
#> combined_000 0.0353564058     0.9136177 0.5793902
#> combined_001 0.0102214526     0.9136177 0.5793902
#> combined_004 0.0009209122     0.9136177 0.5793902
#> combined_006 0.0001526292     0.9136177 0.5793902
```

# 9 Print the session info

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
#>  [1] SummarizedExperiment_1.39.2 Biobase_2.69.1
#>  [3] GenomicRanges_1.61.5        Seqinfo_0.99.2
#>  [5] IRanges_2.43.5              S4Vectors_0.47.4
#>  [7] MatrixGenerics_1.21.0       matrixStats_1.5.0
#>  [9] multiWGCNAdata_1.7.0        ExperimentHub_2.99.5
#> [11] AnnotationHub_3.99.6        BiocFileCache_2.99.6
#> [13] dbplyr_2.5.1                BiocGenerics_0.55.1
#> [15] generics_0.1.4              multiWGCNA_1.7.0
#> [17] ggalluvial_0.12.5           ggplot2_4.0.0
#> [19] BiocStyle_2.37.1
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.3             httr2_1.2.1           gridExtra_2.3
#>   [4] rlang_1.1.6           magrittr_2.0.4        compiler_4.5.1
#>   [7] RSQLite_2.4.3         reshape2_1.4.4        png_0.1-8
#>  [10] vctrs_0.6.5           stringr_1.5.2         pkgconfig_2.0.3
#>  [13] crayon_1.5.3          fastmap_1.2.0         magick_2.9.0
#>  [16] backports_1.5.0       XVector_0.49.1        labeling_0.4.3
#>  [19] rmarkdown_2.30        tzdb_0.5.0            preprocessCore_1.71.2
#>  [22] tinytex_0.57          purrr_1.1.0           bit_4.6.0
#>  [25] xfun_0.53             cachem_1.1.0          dcanr_1.25.0
#>  [28] jsonlite_2.0.0        flashClust_1.01-2     blob_1.2.4
#>  [31] DelayedArray_0.35.3   parallel_4.5.1        cluster_2.1.8.1
#>  [34] R6_2.6.1              bslib_0.9.0           stringi_1.8.7
#>  [37] RColorBrewer_1.1-3    rpart_4.1.24          jquerylib_0.1.4
#>  [40] Rcpp_1.1.0            bookdown_0.45         iterators_1.0.14
#>  [43] knitr_1.50            WGCNA_1.73            base64enc_0.1-3
#>  [46] readr_2.1.5           Matrix_1.7-4          splines_4.5.1
#>  [49] nnet_7.3-20           igraph_2.1.4          tidyselect_1.2.1
#>  [52] rstudioapi_0.17.1     dichromat_2.0-0.1     abind_1.4-8
#>  [55] yaml_2.3.10           doParallel_1.0.17     codetools_0.2-20
#>  [58] curl_7.0.0            doRNG_1.8.6.2         plyr_1.8.9
#>  [61] lattice_0.22-7        tibble_3.3.0          withr_3.0.2
#>  [64] KEGGREST_1.49.1       S7_0.2.0              evaluate_1.0.5
#>  [67] foreign_0.8-90        survival_3.8-3        Biostrings_2.77.2
#>  [70] filelock_1.0.3        pillar_1.11.1         BiocManager_1.30.26
#>  [73] rngtools_1.5.2        checkmate_2.3.3       foreach_1.5.2
#>  [76] BiocVersion_3.22.0    hms_1.1.3             scales_1.4.0
#>  [79] glue_1.8.0            Hmisc_5.2-4           tools_4.5.1
#>  [82] data.table_1.17.8     fastcluster_1.3.0     cowplot_1.2.0
#>  [85] grid_4.5.1            impute_1.83.0         tidyr_1.3.1
#>  [88] AnnotationDbi_1.71.1  colorspace_2.1-2      patchwork_1.3.2
#>  [91] htmlTable_2.4.3       Formula_1.2-5         cli_3.6.5
#>  [94] rappdirs_0.3.3        S4Arrays_1.9.1        dplyr_1.1.4
#>  [97] gtable_0.3.6          dynamicTreeCut_1.63-1 sass_0.4.10
#> [100] digest_0.6.37         ggrepel_0.9.6         SparseArray_1.9.1
#> [103] htmlwidgets_1.6.4     farver_2.1.2          memoise_2.0.1
#> [106] htmltools_0.5.8.1     lifecycle_1.0.4       httr_1.4.7
#> [109] GO.db_3.21.0          bit64_4.6.0-1
```