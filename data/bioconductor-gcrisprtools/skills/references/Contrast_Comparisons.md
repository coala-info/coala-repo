# Advanced Screen Analysis: Contrast Comparisons

## Russell Bainer

This is a companion vignette briefly describing the advanced capabilites available for comparing, summarizing, and integrating screening contrasts with gCrisprTools, introduced with version 2.0.

#### Simplified Results Objects

Historically, gCrisprTools was focused on making results data.frames, which exhaustively summarize the results of a screen contrast. They look like this:

```
library(Biobase)
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
library(gCrisprTools)
knitr::opts_chunk$set(message = FALSE, fig.width = 8, fig.height = 8)

data(resultsDF)

head(resultsDF)
```

```
##                        ID              target geneID geneSymbol
## Target1106_a Target1106_a TCAGCCGCTCCTACGGATT   1236 Target1106
## Target1106_c Target1106_c GTGCGCTAAGTCGGCAGAT   1236 Target1106
## Target1106_g Target1106_g TAAACTCTGTCGGGTAGAC   1236 Target1106
## Target1106_e Target1106_e TGGTGATTTCTAGGAAGTT   1236 Target1106
## Target1106_b Target1106_b AGACAAGAGCTATCCTATG   1236 Target1106
## Target1106_d Target1106_d CAACTTCGCCTGTTATCCG   1236 Target1106
##              gRNA Log2 Fold Change gRNA Depletion P gRNA Depletion Q
## Target1106_a              7.572398          0.99999                1
## Target1106_c              7.589259          1.00000                1
## Target1106_g              7.642459          1.00000                1
## Target1106_e              7.768537          1.00000                1
## Target1106_b              7.569902          1.00000                1
## Target1106_d              7.654991          1.00000                1
##              gRNA Enrichment P gRNA Enrichment Q Target-level Enrichment P
## Target1106_a        6.4548e-06         0.0058481                         0
## Target1106_c        2.4731e-06         0.0032638                         0
## Target1106_g        3.9303e-06         0.0042285                         0
## Target1106_e        2.1136e-06         0.0032638                         0
## Target1106_b        2.1912e-06         0.0032638                         0
## Target1106_d        2.9287e-06         0.0033610                         0
##              Target-level Enrichment Q Target-level Depletion P
## Target1106_a                         0                        1
## Target1106_c                         0                        1
## Target1106_g                         0                        1
## Target1106_e                         0                        1
## Target1106_b                         0                        1
## Target1106_d                         0                        1
##              Target-level Depletion Q Median log2 Fold Change   Rho_enrich
## Target1106_a                        1                7.580828 9.047675e-25
## Target1106_c                        1                7.580828 9.047675e-25
## Target1106_g                        1                7.580828 9.047675e-25
## Target1106_e                        1                7.580828 9.047675e-25
## Target1106_b                        1                7.580828 9.047675e-25
## Target1106_d                        1                7.580828 9.047675e-25
##              Rho_deplete
## Target1106_a           1
## Target1106_c           1
## Target1106_g           1
## Target1106_e           1
## Target1106_b           1
## Target1106_d           1
```

In many applications, there are limitations to these objects. For example:

* They are reagent-focused, but many downstream applications are focused on Targets
* The `colnames` are human-readable instead of machine readable
* The distinction between `geneID` and `geneSymbol` is not clear
* Many columns are not informative for the majority of modern applications/screens
* Historically, they are sorted to put the strongest signals at the top (this is not the case now)

To help with downstream analyses, we introduce the `simpleResult` object

```
res <- ct.simpleResult(resultsDF, collapse = 'geneSymbol')
head(res)
```

```
##            geneID geneSymbol   Rho_enrich Rho_deplete best.p best.q direction
## Target1106   1236 Target1106 9.047675e-25           1      0      0    enrich
## Target1633   1369 Target1633 7.117493e-24           1      0      0    enrich
## Target1631  51316 Target1631 9.377686e-21           1      0      0    enrich
## Target1352   5526 Target1352 7.906212e-19           1      0      0    enrich
## Target1469    639 Target1469 4.826451e-16           1      0      0    enrich
## Target1256   1050 Target1256 3.101526e-11           1      0      0    enrich
```

These objects are simpler representations of target signals that are applicable for “most” situations (e.g., when the gRNAs associated with a target have similar effects). They are:

* Target focused, but target signals are collapsed to single directional P/Q stats
* Collapsed on a user-specified identifier to enable comparisons across screening technologies
* Both human-readable and machine-readable
* Consistently ordered, and may be easily placed in register with one another

This format enables better comparisons between screens, and we have some helper functions to support this:

```
# Make "another" result
res2 <- res
res2$best.p <- res2$best.p * runif(nrow(res2))
res2$direction[sample(1:nrow(res), 500)] <- res2$direction[sample(1:nrow(res), 500)]

regularized <- ct.regularizeContrasts(dflist = list('Experiment1' = res[1:1500,],
                                                    'Experiment2' = res2[1:1900,]),
                                      collapse = 'geneSymbol')

str(regularized)
```

```
## List of 2
##  $ Experiment1:'data.frame':	1500 obs. of  7 variables:
##   ..$ geneID     : chr [1:1500] "10059" "2982" "1294" "5641" ...
##   ..$ geneSymbol : chr [1:1500] "NoTarget" "Target10" "Target100" "Target1000" ...
##   ..$ Rho_enrich : num [1:1500] 0.81 1 1 1 0.238 ...
##   ..$ Rho_deplete: num [1:1500] 0.000367 0.097341 0.014417 0.000897 0.227184 ...
##   ..$ best.p     : num [1:1500] 0.008 0.312 0.078 0.004 0.162 0.403 0.162 0.022 0.133 0.005 ...
##   ..$ best.q     : num [1:1500] 0.227 0.965 0.694 0.147 1 ...
##   ..$ direction  : chr [1:1500] "deplete" "deplete" "deplete" "deplete" ...
##  $ Experiment2:'data.frame':	1500 obs. of  7 variables:
##   ..$ geneID     : chr [1:1500] "10059" "2982" "1294" "5641" ...
##   ..$ geneSymbol : chr [1:1500] "NoTarget" "Target10" "Target100" "Target1000" ...
##   ..$ Rho_enrich : num [1:1500] 0.81 1 1 1 0.238 ...
##   ..$ Rho_deplete: num [1:1500] 0.000367 0.097341 0.014417 0.000897 0.227184 ...
##   ..$ best.p     : num [1:1500] 0.001326 0.099468 0.074992 0.000648 0.063788 ...
##   ..$ best.q     : num [1:1500] 0.227 0.965 0.694 0.147 1 ...
##   ..$ direction  : chr [1:1500] "enrich" "deplete" "deplete" "deplete" ...
```

The above function takes in a (named) list of results objects and creates a list of `simpleResult`s with the same names that are “in register” with one another, using the shared elements specified by `collapse`.

The main utility of this function is twofold. First, it enables comparison of lightweight results objects that are derived from screens that could have been executed with different libraries, systems, or technologies by focusing on the targets and their directional significance measures. Second, this “named list of standardized results” can become a standard structure for encoding grouped contrasts for comparison purposes, allowing us to do more sophisticated comparisons between and across contrasts.

### Testing Overlaps Between Two or More Screens

The standardized format allows straightforward identification of signal overlaps observed within multiple screens via `ct.compareContrasts()`. By default, these comparisons are done conditionally, but users may specify more rigid criteria.

```
comparison <- ct.compareContrasts(dflist = regularized,
                                  statistics = c('best.q', 'best.p'),
                                  cutoffs = c(0.5,0.05),
                                  same.dir = rep(TRUE, length(regularized)))

head(comparison, 30)
```

```
##            geneID geneSymbol  Rho_enrich  Rho_deplete best.p    best.q
## NoTarget    10059   NoTarget 0.810198260 0.0003666943  0.008 0.2269867
## Target10     2982   Target10 1.000000000 0.0973406417  0.312 0.9651262
## Target100    1294  Target100 1.000000000 0.0144169517  0.078 0.6944937
## Target1000   5641 Target1000 1.000000000 0.0008970760  0.004 0.1467586
## Target1001    323 Target1001 0.238351536 0.2271836123  0.162 1.0000000
## Target1003  11274 Target1003 1.000000000 0.1122383453  0.403 1.0000000
## Target1004   3697 Target1004 0.367507856 0.9733795039  0.162 1.0000000
## Target1005    445 Target1005 1.000000000 0.0067735320  0.022 0.4106667
## Target1006  10874 Target1006 1.000000000 0.0290253030  0.133 0.7877429
## Target1007   2488 Target1007 0.001687259 0.9734058256  0.005 0.3432258
## Target1008   3269 Target1008 0.341020764 0.9926446575  0.223 1.0000000
## Target1009  23114 Target1009 1.000000000 0.0524040002  0.206 0.9113680
## Target101    7398  Target101 0.026185087 0.8184220674  0.043 1.0000000
## Target1014   4057 Target1014 1.000000000 0.2241604775  0.582 1.0000000
## Target1016   2326 Target1016 1.000000000 0.1931948401  0.526 1.0000000
## Target1017  83461 Target1017 0.169090848 0.0428962671  0.115 1.0000000
## Target1019    650 Target1019 1.000000000 0.0353408339  0.150 0.7993234
## Target102  347734  Target102 1.000000000 0.1445274167  0.442 1.0000000
## Target1020   2324 Target1020 1.000000000 0.2345659583  0.574 1.0000000
## Target1021    821 Target1021 0.048472096 0.0031305804  0.022 0.4106667
## Target1022   6533 Target1022 1.000000000 0.2222939519  0.536 1.0000000
## Target1023   6950 Target1023 1.000000000 0.2252680878  0.578 1.0000000
## Target1024    633 Target1024 1.000000000 0.1437704685  0.432 1.0000000
## Target1025   5073 Target1025 0.167112788 0.0901525902  0.134 1.0000000
## Target1026  54468 Target1026 1.000000000 0.2690389752  0.632 1.0000000
## Target1027   9344 Target1027 1.000000000 0.0666379350  0.254 0.9521783
## Target1028   1439 Target1028 0.078493433 0.6994925536  0.073 1.0000000
## Target1029   4481 Target1029 0.007853608 0.9798213353  0.013 0.7476757
## Target103    5167  Target103 1.000000000 0.0379885178  0.167 0.8401324
## Target1030  29106 Target1030 0.089682636 0.2064889045  0.089 1.0000000
##            direction replicated
## NoTarget     deplete      FALSE
## Target10     deplete      FALSE
## Target100    deplete      FALSE
## Target1000   deplete       TRUE
## Target1001    enrich      FALSE
## Target1003   deplete      FALSE
## Target1004    enrich      FALSE
## Target1005   deplete       TRUE
## Target1006   deplete      FALSE
## Target1007    enrich       TRUE
## Target1008    enrich      FALSE
## Target1009   deplete      FALSE
## Target101     enrich      FALSE
## Target1014   deplete      FALSE
## Target1016   deplete      FALSE
## Target1017    enrich      FALSE
## Target1019   deplete      FALSE
## Target102    deplete      FALSE
## Target1020   deplete      FALSE
## Target1021   deplete       TRUE
## Target1022   deplete      FALSE
## Target1023   deplete      FALSE
## Target1024   deplete      FALSE
## Target1025    enrich      FALSE
## Target1026   deplete      FALSE
## Target1027   deplete      FALSE
## Target1028    enrich      FALSE
## Target1029    enrich      FALSE
## Target103    deplete      FALSE
## Target1030    enrich      FALSE
```

This function returns a `simplifiedResult` version of the `mainresult` argument, appended with a logical column indicating whether signals in the `mainresult` contrast passing the first significance cutoff are replicated in the `validationresult` contrast at the second significance cutoff. This sort of conditional scoring was shown previously to be useful in interpreting the results of validation and counterscreens.

For convenience, we can also return summary statistics characterizing the overlap between the screens:

```
ct.compareContrasts(dflist = regularized,
                    statistics = c('best.q', 'best.p'),
                    cutoffs = c(0.5,0.05),
                    same.dir = rep(TRUE, length(regularized)),
                    return.stats = TRUE)
```

```
##         expected observed p
## enrich    3.6703       24 0
## deplete  43.1636      130 0
## all      46.8339      154 0
```

This can be useful when exploring appropriate cutoff thresholds, or when asking broader questions about overall congruence.

### Visualization of Screen Enrichment and Depletion Dynamics

We provide a number of methods for visualizing and contextualizing the overall signals present within sets of screens. One of the simplest is the cointrast barcharts, which represent the number of observed enrichment and depletion signals in each screen according to specified significance criteria:

```
ct.contrastBarchart(regularized, background = FALSE, statistic = 'best.p')
```

![plot of chunk contrastbarchart](data:image/png;base64...)

In the above figure, each contrast is represented as a horizontal bar, and targets enriched and depleted are represented as bars extending to the right and the left of the vertical dotted line, respectively.

We can also compare the signals observed in two screens directly in a scatterplot:

```
scat <- ct.scatter(regularized,
                   targets = 'geneSymbol',
                   statistic = 'best.p',
                   cutoff = 0.05)
```

![plot of chunk unnamed-chunk-5](data:image/png;base64...)

This provides a scatter plot of the indicated statistic, with quadrants defined according to the user-specified cutoff. The number of targets in each of the quadrants is indicated in grey, and quadrants are keyed like this:

1 2 3
4 5 6
7 8 9

A more complete genewise picture can be achieved by examining the returned invisible object, which appends the relevant quadrants to assist in in focusing on particular targets of interest:

```
head(scat)
```

```
##            geneID geneSymbol Rho.enrich.Experiment1 Rho.deplete.Experiment1
## NoTarget    10059   NoTarget             0.09140869               3.4356958
## Target10     2982   Target10             0.00000000               1.0117058
## Target100    1294  Target100             0.00000000               1.8411266
## Target1000   5641 Target1000             0.00000000               3.0471708
## Target1001    323 Target1001             0.62278205               0.6436230
## Target1003  11274 Target1003             0.00000000               0.9498587
##            p.Experiment1 q.Experiment1 Rho.enrich.Experiment2
## NoTarget       2.0705811   0.594707067             0.09140869
## Target10       0.5051500   0.003309628             0.00000000
## Target100      1.1051303   0.141597698             0.00000000
## Target1000     2.3467875   0.759349249             0.00000000
## Target1001     0.7891466   0.000000000             0.62278205
## Target1003     0.3941565   0.000000000             0.00000000
##            Rho.deplete.Experiment2 p.Experiment2 q.Experiment2 quadrant
## NoTarget                 3.4356958     2.8763622   0.594707067        1
## Target10                 1.0117058     1.0023023   0.003309628        5
## Target100                1.8411266     1.1249662   0.141597698        5
## Target1000               3.0471708     3.1859286   0.759349249        7
## Target1001               0.6436230     1.1952418   0.000000000        5
## Target1003               0.9498587     0.8560607   0.000000000        5
##                     x          y
## NoTarget   -2.0705811  2.8763622
## Target10   -0.5051500 -1.0023023
## Target100  -1.1051303 -1.1249662
## Target1000 -2.3467875 -3.1859286
## Target1001  0.7891466  1.1952418
## Target1003 -0.3941565 -0.8560607
```

As an aside, this simplified infrastructure allows straightforward dissection of interaction effects as well. Often, it is helpful to identify targets that are enriched or depleted with respect to one contrast but inactive with respect to another (e.g., to identify genes that impact a screening phenotype but do not deplete over time).

```
library(Biobase)
library(limma)
library(gCrisprTools)

#Create a complex model design; removing the replicate term for clarity
data("es", package = "gCrisprTools")
data("ann", package = "gCrisprTools")

design <- model.matrix(~ 0 + TREATMENT_NAME, pData(es))
colnames(design) <- gsub('TREATMENT_NAME', '', colnames(design))
contrasts <-makeContrasts(ControlTime = ControlExpansion - ControlReference,
                          DeathOverTime = DeathExpansion - ControlReference,
                          Interaction = DeathExpansion - ControlExpansion,
                          levels = design)

es <- ct.normalizeGuides(es, method = "scale") #See man page for other options
vm <- voom(exprs(es), design)

fit <- lmFit(vm, design)
fit <- contrasts.fit(fit, contrasts)
fit <- eBayes(fit)

allResults <- sapply(colnames(fit$coefficients),
                     function(x){
                         ct.generateResults(fit,
                                            annotation = ann,
                                            RRAalphaCutoff = 0.1,
                                            permutations = 1000,
                                            scoring = "combined",
                                            permutation.seed = 2,
                                            contrast.term = x)
                       }, simplify = FALSE)

allSimple <- ct.regularizeContrasts(allResults)
```

Using the logical columns we can Identify relevant sets of targets. For example, the number of targets changing over time in both timecourses:

```
time.effect <- ct.compareContrasts(list("con" = allSimple$ControlTime,
                                        "tx" = allSimple$DeathOverTime))
summary(time.effect$replicated)
```

```
##    Mode   FALSE    TRUE
## logical    2016     112
```

or targets with a toxicity modifying effect that compromise intrinsic viability:

```
mod.control <- ct.compareContrasts(list("con" = allSimple$ControlTime,
                                        "Interaction" = allSimple$Interaction),
                                 same.dir = c(TRUE, FALSE))
summary(mod.control$replicated)
```

```
##    Mode   FALSE    TRUE
## logical    2076      52
```

#### More Comparisons

Sometimes you might be curious about the relationship between many contrasts. You can accomplish this by making an UpSet plot:

```
upset <- ct.upSet(allSimple)
```

```
## Warning in ct.upSet(allSimple): NaNs produced
```

![plot of chunk unnamed-chunk-9](data:image/png;base64...)

In addition to constructing the UpSet plot above, by default we include fold enrichment and p-value estimates to help interpret the various bars in the context of the nominal or conditional expected values.

Finally, the above function returns a combination matrix containing the overlap values and associated targets, which can be useful for interrogating intersection sets of interest.

```
show(upset)
```

```
## A combination matrix with 3 sets and 7 combinations.
##   ranges of combination set size: c(20, 157).
##   mode for the combination size: conditional.
##   sets are on rows.
##
## Combination sets are:
##   ControlTime DeathOverTime Interaction code size
##             x             x           x  111   27
##             x             x              110  112
##             x                         x  101   20
##                           x           x  011   79
##             x                            100  157
##                           x              010  108
##                                       x  001   68
##
## Sets are:
##             set size
##     ControlTime 2128
##   DeathOverTime 2128
##     Interaction 2128
```

See the documentation about combination matrices provided in the `ComplexHeatmap` package for accessor functions and additional information about the structure and use of this object.

#### Ontological Enrichment

Though not subject to specific set-level analyses yet, the `ct.seas()` function can be likewise extended to use lists of results. The standardized objects can then be consolidated to ask broader questions about enrichment and depletion using standard methods:

```
genesetdb <- sparrow::getMSigGeneSetDb(collection = 'h', species = 'human', id.type = 'entrez')

sparrowList <- ct.seas(allSimple, gdb = genesetdb)
```

```
## Warning in preparePathwaysAndStats(pathways, stats, minSize, maxSize, gseaParam, : There are ties in the preranked stats (35.03% of the list).
## The order of those tied genes will be arbitrary, which may produce unexpected results.
```

```
## Warning in sparrow::seas(x = ipt, gsd = gdb, methods = c("ora", "fgsea"), : The following GSEA methods failed and are removed from the downstream result: ora
```

```
## Warning in preparePathwaysAndStats(pathways, stats, minSize, maxSize, gseaParam, : There are ties in the preranked stats (64.55% of the list).
## The order of those tied genes will be arbitrary, which may produce unexpected results.
```

```
## Warning in sparrow::seas(x = ipt, gsd = gdb, methods = c("ora", "fgsea"), : The following GSEA methods failed and are removed from the downstream result: ora
```

```
## Warning in preparePathwaysAndStats(pathways, stats, minSize, maxSize, gseaParam, : There are ties in the preranked stats (63.33% of the list).
## The order of those tied genes will be arbitrary, which may produce unexpected results.
```

```
## Warning in sparrow::seas(x = ipt, gsd = gdb, methods = c("ora", "fgsea"), : The following GSEA methods failed and are removed from the downstream result: ora
```

```
show(sparrowList)
```

```
## $ControlTime
## SparrowResult (max FDR by collection set to 0.20%)
## ---------------------------------------------------
##   collection method geneset_count sig_count sig_up sig_down
## 1          H  fgsea            50         0      0        0
##
##
## $DeathOverTime
## SparrowResult (max FDR by collection set to 0.20%)
## ---------------------------------------------------
##   collection method geneset_count sig_count sig_up sig_down
## 1          H  fgsea            50         0      0        0
##
##
## $Interaction
## SparrowResult (max FDR by collection set to 0.20%)
## ---------------------------------------------------
##   collection method geneset_count sig_count sig_up sig_down
## 1          H  fgsea            50         1      0        1
```

```
#Can use returned matrices to facilitate downstream comparisons:

plot(-log10(sparrow::results(sparrowList$DeathOverTime, 'fgsea')$padj),
     -log10(sparrow::results(sparrowList$Interaction, 'fgsea')$padj),
     pch = 19, col = rgb(0,0,0.8,0.5),
     ylab = "Pathway -log10(P), Treatment Over Time",
     xlab = "Pathway -log10(P), Marginal Time Effect, Treatment Arm",
     main = 'Evidence for Pathway Enrichment')
abline(0,1,lty = 2)
```

![plot of chunk unnamed-chunk-11](data:image/png;base64...)

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
## [1] limma_3.66.0        gCrisprTools_2.16.0 Biobase_2.70.0
## [4] BiocGenerics_0.56.0 generics_0.1.4
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   gridExtra_2.3
##   [3] BiasedUrn_2.0.12            GSEABase_1.72.0
##   [5] BiocSet_1.24.0              rlang_1.1.6
##   [7] magrittr_2.0.4              clue_0.3-66
##   [9] GetoptLong_1.0.5            msigdbr_25.1.1
##  [11] sparrow_1.16.0              matrixStats_1.5.0
##  [13] compiler_4.5.1              RSQLite_2.4.3
##  [15] png_0.1-8                   vctrs_0.6.5
##  [17] pkgconfig_2.0.3             shape_1.4.6.1
##  [19] crayon_1.5.3                fastmap_1.2.0
##  [21] backports_1.5.0             magick_2.9.0
##  [23] XVector_0.50.0              rmarkdown_2.30
##  [25] graph_1.88.0                purrr_1.1.0
##  [27] bit_4.6.0                   xfun_0.53
##  [29] cachem_1.1.0                jsonlite_2.0.0
##  [31] blob_1.2.4                  DelayedArray_0.36.0
##  [33] BiocParallel_1.44.0         irlba_2.3.5.1
##  [35] parallel_4.5.1              cluster_2.1.8.1
##  [37] R6_2.6.1                    RColorBrewer_1.1-3
##  [39] GenomicRanges_1.62.0        assertthat_0.2.1
##  [41] Rcpp_1.1.0                  Seqinfo_1.0.0
##  [43] SummarizedExperiment_1.40.0 iterators_1.0.14
##  [45] knitr_1.50                  IRanges_2.44.0
##  [47] Matrix_1.7-4                tidyselect_1.2.1
##  [49] dichromat_2.0-0.1           abind_1.4-8
##  [51] viridis_0.6.5               doParallel_1.0.17
##  [53] codetools_0.2-20            curl_7.0.0
##  [55] plyr_1.8.9                  lattice_0.22-7
##  [57] tibble_3.3.0                withr_3.0.2
##  [59] KEGGREST_1.50.0             S7_0.2.0
##  [61] evaluate_1.0.5              ontologyIndex_2.12
##  [63] circlize_0.4.16             Biostrings_2.78.0
##  [65] pillar_1.11.1               MatrixGenerics_1.22.0
##  [67] checkmate_2.3.3             foreach_1.5.2
##  [69] stats4_4.5.1                plotly_4.11.0
##  [71] S4Vectors_0.48.0            ggplot2_4.0.0
##  [73] scales_1.4.0                xtable_1.8-4
##  [75] glue_1.8.0                  lazyeval_0.2.2
##  [77] tools_4.5.1                 BiocIO_1.20.0
##  [79] data.table_1.17.8           fgsea_1.36.0
##  [81] annotate_1.88.0             locfit_1.5-9.12
##  [83] babelgene_22.9              XML_3.99-0.19
##  [85] fastmatch_1.1-6             cowplot_1.2.0
##  [87] grid_4.5.1                  Cairo_1.7-0
##  [89] tidyr_1.3.1                 AnnotationDbi_1.72.0
##  [91] edgeR_4.8.0                 colorspace_2.1-2
##  [93] cli_3.6.5                   S4Arrays_1.10.0
##  [95] viridisLite_0.4.2           ComplexHeatmap_2.26.0
##  [97] dplyr_1.1.4                 gtable_0.3.6
##  [99] digest_0.6.37               SparseArray_1.10.0
## [101] rjson_0.2.23                htmlwidgets_1.6.4
## [103] farver_2.1.2                memoise_2.0.1
## [105] htmltools_0.5.8.1           lifecycle_1.0.4
## [107] httr_1.4.7                  GlobalOptions_0.1.2
## [109] statmod_1.5.1               bit64_4.6.0-1
```