# multiWGCNA: visualizing condition-specific networks

Dario Tommasini

#### 2025-10-07

# Contents

* [1 Introduction](#introduction)
* [2 Load multiWGCNA library](#load-multiwgcna-library)
* [3 Load astrocyte Ribotag RNA-seq data](#load-astrocyte-ribotag-rna-seq-data)
* [4 Network construction](#network-construction)
* [5 Compare modules by overlap](#compare-modules-by-overlap)
* [6 Identify a module of interest](#identify-a-module-of-interest)
* [7 Draw the multiWGCNA network](#draw-the-multiwgcna-network)
* [8 Observe differential co-expression of top module genes](#observe-differential-co-expression-of-top-module-genes)
* [9 Follow up with a preservation analysis](#follow-up-with-a-preservation-analysis)
* [10 Determining if preservation value is significant](#determining-if-preservation-value-is-significant)
* [11 Conclusion](#conclusion)

# 1 Introduction

In this vignette, we will be showing various ways users can analyze their condition-specific network across the conditions of their experiment. We will be using the astrocyte Ribotag data from Itoh et al. PNAS. 2018 (<https://doi.org/10.1073/pnas.1716032115>). This data comes with the multiWGCNAdata package hosted on ExperimentHub and can be accessed as shown below.

# 2 Load multiWGCNA library

```
library(multiWGCNA)
#> Loading required package: ggalluvial
#> Loading required package: ggplot2
#>
```

# 3 Load astrocyte Ribotag RNA-seq data

```
# Download data from the ExperimentHub
library(ExperimentHub)
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: AnnotationHub
#> Loading required package: BiocFileCache
#> Loading required package: dbplyr
eh = ExperimentHub()

# Note: this requires the SummarizedExperiment package to be installed
eh_query = query(eh, c("multiWGCNAdata"))
astrocyte_se = eh_query[["EH8223"]]
#> see ?multiWGCNAdata and browseVignettes('multiWGCNAdata') for documentation
#> loading from cache
#> require("SummarizedExperiment")

# Collect the metadata in the sampleTable; the first column must be named "Sample"
sampleTable = colData(astrocyte_se)

# Check the data
assays(astrocyte_se)[[1]][1:5, 1:5]
#>                   EAE_1    EAE_2    EAE_3    EAE_4    EAE_5
#> 0610007P14Rik 6.8295061 6.855911 6.254815 6.018663 7.082242
#> 0610009B22Rik 6.7316000 7.131389 5.512180 5.350221 6.612084
#> 0610009O20Rik 5.2374819 4.613763 5.163960 4.499471 5.376452
#> 0610010B08Rik 0.6621082 1.237812 2.602756 1.404309 2.646006
#> 0610010F05Rik 2.7476431 3.870872 3.311788 3.329422 3.424676
sampleTable
#> DataFrame with 36 rows and 3 columns
#>                 Sample     Disease      Region
#>            <character> <character> <character>
#> EAE_1            EAE_1         EAE         Cbl
#> EAE_2            EAE_2         EAE         Cbl
#> EAE_3            EAE_3         EAE         Cbl
#> EAE_4            EAE_4         EAE         Cbl
#> EAE_5            EAE_5         EAE         Cbl
#> ...                ...         ...         ...
#> healthy_12  healthy_12          WT       Hippo
#> healthy_13  healthy_13          WT          Sc
#> healthy_14  healthy_14          WT          Sc
#> healthy_15  healthy_15          WT          Sc
#> healthy_16  healthy_16          WT          Sc

# Define our conditions for trait 1 (disease) and 2 (brain region)
conditions1 = unique(sampleTable[,2])
conditions2 = unique(sampleTable[,3])
```

# 4 Network construction

We now perform network construction, module eigengene calculation, module-trait correlation. Let’s use power = 12 since we used this in our paper (Tommasini and Fogel. BMC Bioinformatics. 2023.) for all the networks.

```
# Construct the combined networks and all the sub-networks (EAE, WT, and each region)
# Same parameters as Tommasini and Fogel. BMC Bioinformatics
astrocyte_networks = constructNetworks(astrocyte_se, sampleTable, conditions1, conditions2,
                                  networkType = "signed", TOMType = "unsigned",
                                  power = 12, minModuleSize = 100, maxBlockSize = 25000,
                                  reassignThreshold = 0, minKMEtoStay = 0, mergeCutHeight = 0,
                                  numericLabels = TRUE, pamRespectsDendro = FALSE,
                                  deepSplit = 4, verbose = 3)
```

This step takes a while since it performs seven network constructions, so we also provide the WGCNA object list (astrocyte\_networks) in a loadable format. These were generated from the function above.

```
# Load pre-computed astrocyte networks
astrocyte_networks = eh_query[["EH8222"]]
#> see ?multiWGCNAdata and browseVignettes('multiWGCNAdata') for documentation
#> loading from cache

# Check one of the WGCNA objects
astrocyte_networks[["combined"]]
#> ##### datExpr #####
#>                           X     EAE_1    EAE_2    EAE_3    EAE_4
#> 0610007P14Rik 0610007P14Rik 6.8295061 6.855911 6.254815 6.018663
#> 0610009B22Rik 0610009B22Rik 6.7316000 7.131389 5.512180 5.350221
#> 0610009O20Rik 0610009O20Rik 5.2374819 4.613763 5.163960 4.499471
#> 0610010B08Rik 0610010B08Rik 0.6621082 1.237812 2.602756 1.404309
#> 0610010F05Rik 0610010F05Rik 2.7476431 3.870872 3.311788 3.329422
#> 0610010K14Rik 0610010K14Rik 6.7580660 5.741782 7.068028 6.066397
#>
#> ##### conditions #####
#>   Sample Cbl Ctx Hippo Sc EAE WT
#> 1  EAE_1   1   2     2  2   1  2
#> 2  EAE_2   1   2     2  2   1  2
#> 3  EAE_3   1   2     2  2   1  2
#> 4  EAE_4   1   2     2  2   1  2
#> 5  EAE_5   1   2     2  2   1  2
#> 6  EAE_6   2   1     2  2   1  2
#>
#> ##### module-trait correlation #####
#>         Module                 Cbl                Ctx              Hippo
#> 1 combined_000 -0.0364476003508565 -0.255256505885536  0.197531123492674
#> 2 combined_001   0.288897873627807  0.224331519793051 -0.951891696612219
#> 3 combined_002  -0.173307792846142  0.192824350579657 -0.737858151950135
#> 4 combined_003  -0.602638473395467  0.358865557684427 -0.443014688492424
#> 5 combined_004  -0.298759692763236  0.237517325231285  0.389483421290234
#> 6 combined_005    0.33717807439664  0.217125827452453  0.404748752737107
#>                   Sc                EAE                  WT
#> 1 0.0941729827437187 -0.129401075697594   0.129401075697594
#> 2  0.438662303191361 0.0564118630816024 -0.0564118630816024
#> 3  0.718341594216621  0.124624344929484  -0.124624344929484
#> 4  0.686787604203464  0.118489907579839  -0.118489907579839
#> 5 -0.328241053758283  -0.27623235802516    0.27623235802516
#> 6 -0.959052654586201 0.0993302279700684 -0.0993302279700684
#>            p.value.Cbl        p.value.Ctx        p.value.Hippo
#> 1    0.832857799237777  0.132966929718593    0.248179967153461
#> 2   0.0874757049142457  0.188400881435516 4.88276900785685e-19
#> 3    0.312100684420068  0.259856986766255 2.82359321810442e-07
#> 4 0.000100501116087253 0.0316046790137704  0.00681175845919204
#> 5   0.0767322030921174   0.16305699722782   0.0188747122157827
#> 6   0.0443263856584159  0.203366848448585    0.014341658701339
#>             p.value.Sc       p.value.EAE        p.value.WT trait log10Pvalue
#> 1     0.58485059401596 0.451944819774715 0.451944819774715  None   0.8762564
#> 2  0.00744524874705859 0.743829515380077 0.743829515380077 Hippo  18.3113338
#> 3 8.09340902303281e-07 0.468950669314544 0.468950669314544 Hippo   6.5491979
#> 4 3.73966334787861e-06 0.491276518086413 0.491276518086413    Sc   5.4271675
#> 5   0.0506450923633608 0.102930451571833 0.102930451571833 Hippo   1.7241197
#> 6 3.33227384463383e-20 0.564360643230857 0.564360643230857    Sc  19.4772593
#>
#> ##### module eigengenes #####
#>                    EAE_1       EAE_2        EAE_3       EAE_4       EAE_5
#> combined_000  0.02299076  0.04566290 -0.016901593 -0.04957158  0.05120053
#> combined_001 -0.12249369 -0.04708563 -0.103509765 -0.08154738 -0.10047042
#> combined_002 -0.09416519  0.11637829  0.001182349  0.02840979  0.04835513
#> combined_003  0.01507925  0.20555343  0.141335547  0.13334496  0.21012775
#> combined_004  0.21553261 -0.19353170  0.303492247  0.17313968  0.25254140
#> combined_005 -0.07089446 -0.01972901 -0.159155387 -0.09926386 -0.15912974
#>
#> ##### outlier modules #####
#> [1] "combined_000" "combined_019" "combined_025" "combined_028" "combined_030"
#> [6] "combined_035" "combined_036" "combined_037" "combined_038"
```

# 5 Compare modules by overlap

Next, we compare modules (by hypergeometric overlap) across conditions. We’ll save the results in a list.

```
# Save results to a list
results = list()
results$overlaps = iterate(astrocyte_networks, overlapComparisons, plot=FALSE)
#>
#> #### comparing combined and EAE ####
#>
#> #### comparing combined and WT ####
#>
#> #### comparing combined and Cbl ####
#>
#> #### comparing combined and Ctx ####
#>
#> #### comparing combined and Hippo ####
#>
#> #### comparing combined and Sc ####
#>
#> #### comparing EAE and WT ####
#>
#> #### comparing EAE and Cbl ####
#>
#> #### comparing EAE and Ctx ####
#>
#> #### comparing EAE and Hippo ####
#>
#> #### comparing EAE and Sc ####
#>
#> #### comparing WT and Cbl ####
#>
#> #### comparing WT and Ctx ####
#>
#> #### comparing WT and Hippo ####
#>
#> #### comparing WT and Sc ####
#>
#> #### comparing Cbl and Ctx ####
#>
#> #### comparing Cbl and Hippo ####
#>
#> #### comparing Cbl and Sc ####
#>
#> #### comparing Ctx and Hippo ####
#>
#> #### comparing Ctx and Sc ####
#>
#> #### comparing Hippo and Sc ####

# Check the overlaps, ie between the EAE and wildtype networks
head(results$overlaps$EAE_vs_WT$overlap)
#>      mod1   mod2 mod1.size mod2.size overlap p.value p.adj
#> 1 EAE_000 WT_000         1         2       0       1     1
#> 2 EAE_000 WT_001         1      1001       0       1     1
#> 3 EAE_000 WT_002         1       885       0       1     1
#> 4 EAE_000 WT_003         1       883       0       1     1
#> 5 EAE_000 WT_004         1       767       0       1     1
#> 6 EAE_000 WT_005         1       727       0       1     1
```

# 6 Identify a module of interest

Then, we perform differential module expression analysis to detect modules with disease-associated expression patterns. This incorporates the linear model described in the paper and tests for significance using ANOVA.

```
# Run differential module expression analysis (DME) on combined networks
results$diffModExp = runDME(astrocyte_networks[["combined"]],
                            sampleTable,
                            p.adjust = "fdr",
                            refCondition = "Region",
                            testCondition = "Disease")
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the multiWGCNA package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
                            # plot=TRUE,
                            # out="ANOVA_DME.pdf")

# Check results sorted by disease association FDR
results$diffModExp[order(results$diffModExp$Disease),]
#>                  Disease Disease*Region       Region
#> combined_013 0.004565611     0.98775812 5.707380e-04
#> combined_016 0.056027353     0.02147806 2.496359e-09
#> combined_021 0.056027353     0.98775812 1.591773e-01
#> combined_033 0.056027353     0.98775812 6.349427e-06
#> combined_032 0.075974114     0.98775812 1.228102e-01
#> combined_020 0.081916454     0.98775812 1.545306e-05
#> combined_026 0.125548873     0.98775812 2.274020e-02
#> combined_005 0.129290571     0.98775812 1.985491e-18
#> combined_017 0.129290571     0.98775812 3.390485e-03
#> combined_031 0.129290571     0.98775812 8.937602e-06
#> combined_003 0.201313016     0.98775812 5.082058e-14
#> combined_004 0.201313016     0.98775812 8.237774e-03
#> combined_002 0.204080192     0.98775812 7.594394e-13
#> combined_009 0.204080192     0.98775812 1.817818e-24
#> combined_022 0.235673317     0.98775812 1.522679e-17
#> combined_010 0.260509013     0.98775812 1.278032e-05
#> combined_015 0.260509013     0.98775812 1.286140e-03
#> combined_008 0.305563496     0.98775812 9.832001e-05
#> combined_011 0.305563496     0.98775812 1.488179e-19
#> combined_012 0.364451132     0.98775812 5.490254e-17
#> combined_014 0.364451132     0.98775812 7.311012e-22
#> combined_018 0.364451132     0.98775812 5.347187e-19
#> combined_023 0.364451132     0.98775812 3.631151e-09
#> combined_025 0.364451132     0.98775812 1.769155e-01
#> combined_001 0.387743702     0.98775812 4.956367e-17
#> combined_036 0.387743702     0.98775812 4.677576e-01
#> combined_029 0.433469339     0.98775812 5.875322e-15
#> combined_037 0.435725138     0.98775812 2.151891e-01
#> combined_006 0.442761880     0.98775812 9.999069e-17
#> combined_028 0.442761880     0.98775812 3.015503e-01
#> combined_035 0.442761880     0.98775812 4.374292e-01
#> combined_007 0.500999238     0.98775812 9.767417e-05
#> combined_030 0.500999238     0.98775812 3.015503e-01
#> combined_000 0.504429894     0.98775812 4.374292e-01
#> combined_034 0.504429894     0.98775812 5.707380e-04
#> combined_038 0.515358345     0.98775812 4.037062e-01
#> combined_024 0.692301058     0.98775812 3.840878e-18
#> combined_019 0.717692761     0.98775812 4.677576e-01
#> combined_027 0.717692761     0.98775812 1.378638e-15

# You can check the expression of module M13 from Tommasini and Fogel. BMC Bioinformatics. 2023 like this. Note that the values reported in the bottom panel title are p-values and not adjusted for multiple comparisons like in results$diffModExp
diffModuleExpression(astrocyte_networks[["combined"]],
                     geneList = topNGenes(astrocyte_networks[[1]], "combined_013"),
                     design = sampleTable,
                     test = "ANOVA",
                     plotTitle = "combined_013",
                     plot = TRUE)
```

![](data:image/png;base64...)

```
#> #### plotting combined_013 ####
#>          Factors      p.value
#> 1        Disease 0.0001170670
#> 2         Region 0.0003394679
#> 3 Disease*Region 0.1386488005
```

# 7 Draw the multiWGCNA network

We can now check to see if M13 is present in any of the sub-networks. An easy way to do this is using the network-network correspondences from hypergeometric overlap. These are stored in results$overlaps. We can plot these in a convenient visualization scheme that also organizes the three levels of the multiWGCNA analysis: 1) combined network, 2) EAE and wildtype networks, and 3) the four regional networks.

```
drawMultiWGCNAnetwork(astrocyte_networks,
                      results$overlaps,
                      "combined_013",
                      design = sampleTable,
                      overlapCutoff = 0,
                      padjCutoff = 1,
                      removeOutliers = TRUE,
                      alpha = 1e-50,
                      layout = NULL,
                      hjust = 0.4,
                      vjust = 0.3,
                      width = 0.5)
```

![](data:image/png;base64...)

```
#> NULL
```

This corresponds to Figure 2C from Tommasini and Fogel. BMC Bioinformatics. 2023. We see that M13 is really only present in the EAE network, but not any of the other sub-networks. Most importantly, it cannot be resolved in the wildtype network. This makes M13 a biologically interesting network, both in terms of differential expression and differential co-expression.

We can identify the EAE module that corresponds to M13 using the overlap analysis:

```
bidirectionalBestMatches(results$overlaps$combined_vs_EAE)
```

![](data:image/png;base64...)

```
#>    combined EAE         p.adj
#> 1       003 007 1.425488e-318
#> 2       001 001 4.260005e-306
#> 3       002 003 4.260005e-306
#> 4       004 002 4.260005e-306
#> 5       006 005 4.260005e-306
#> 6       007 009 4.260005e-306
#> 7       008 008 4.260005e-306
#> 8       009 006 4.260005e-306
#> 9       013 015 4.260005e-306
#> 10      019 010 4.260005e-306
#> 11      025 016 4.260005e-306
#> 12      028 021 8.844123e-285
#> 13      030 023 7.316481e-274
#> 14      010 022 1.803606e-248
#> 15      005 004 1.072392e-245
#> 16      011 013 3.737081e-238
#> 17      036 032 2.377904e-215
#> 18      037 034 2.494348e-214
#> 19      035 019 2.612013e-209
#> 20      038 037 5.744812e-203
#> 21      023 014 1.430064e-195
#> 22      012 028 7.465249e-192
#> 23      029 031 4.026429e-180
#> 24      021 017 1.956705e-171
#> 25      024 027 3.167232e-157
#> 26      022 026 1.139861e-155
#> 27      018 012 4.407054e-148
#> 28      020 020 9.716337e-146
#> 29      017 018 2.767286e-110
#> 30      015 044 1.132537e-102
#> 31      033 046  1.341711e-98
#> 32      026 047  8.515681e-90
#> 33      031 035  4.408228e-89
#> 34      027 029  1.832957e-75
```

The colors correspond to -log10(FDR) derived from the hypergeometric test, while the numbers in the cells correspond to the number of genes overlapping. From this plot, we see that the module from the EAE network that corresponds to combined\_013 is called EAE\_015.

# 8 Observe differential co-expression of top module genes

We can visually check that combined\_013/EAE\_015 genes are co-expressed in EAE and not co-expressed in WT samples.

```
# Get expression data for top 20 genes in EAE_015 module
datExpr = GetDatExpr(astrocyte_networks[[1]],
                     genes = topNGenes(astrocyte_networks$EAE, "EAE_015", 20))

# Plot
coexpressionLineGraph(datExpr, splitBy = 1.5, fontSize = 2.5) +
  geom_vline(xintercept = 20.5, linetype='dashed')
```

![](data:image/png;base64...)

This corresponds to Figure 2D from Tommasini and Fogel. BMC Bioinformatics. 2023. Indeed, we see that these representative module members, which include many immune-related genes, co-vary in EAE samples but less so in WT samples.

# 9 Follow up with a preservation analysis

Typically, you would want to follow this up with a preservation analysis between EAE and WT (described in general\_workflow.Rmd). This is slow so we don’t actually run this in the vignette.

```
# To enable multi-threading
# library(doParallel)
# library(WGCNA)
# nCores = 2
# registerDoParallel(cores = nCores)
# enableWGCNAThreads(nThreads = nCores)

# Turn off multi-threading
# registerDoSEQ()
# disableWGCNAThreads()

# Calculate preservation statistics
results$preservation=iterate(astrocyte_networks[c("EAE", "WT")],
                             preservationComparisons,
                             write=FALSE,
                             plot=TRUE,
                             nPermutations=2)
```

# 10 Determining if preservation value is significant

Then, one can perform a permutation procedure that estimates the probability of observing a disease (or wildtype) module with this preservation score in the wildtype (or disease) setting (PreservationPermutationTest). The test is designed to control for the other condition in the sampleTable. In this case, it will equally distribute the samples belonging to each anatomical region when testing preservation of this disease module in the wildtype samples. This is the slowest step! We recommend to let this run on a computing cluster overnight.

```
options(paged.print = FALSE)
results$permutation.test = PreservationPermutationTest(astrocyte_networks$combined@datExpr[sample(17000,3000),],
                                                       sampleTable,
                                                       constructNetworksIn = "EAE", # Construct networks using EAE samples
                                                       testPreservationIn = "WT", # Test preservation of disease samples in WT samples
                                                       nPermutations = 10, # Number of permutations for permutation test
                                                       nPresPermutations = 10, # Number of permutations for modulePreservation function

                                                       # WGCNA parameters for re-sampled networks (should be the same as used for network construction)
                                                       networkType = "signed", TOMType = "unsigned",
                                                       power = 12, minModuleSize = 100, maxBlockSize = 25000,
                                                       reassignThreshold = 0, minKMEtoStay = 0, mergeCutHeight = 0,
                                                       numericLabels = TRUE, pamRespectsDendro = FALSE,
                                                       deepSplit = 4, verbose = 3
                                                       )
```

Because this step is slow, we provide pre-computed results within the package, stored as `permutationTestResults`. Since module preservation scores are dependent on the module size (larger modules have larger preservation scores), we generate the null distribution of preservation scores based on similarly sized modules from each permutation. Note that we have to filter out “outlier modules” first, as these are modules where the correlations are driven by a single sample.

```
# Load pre-computed results
data(permutationTestResults)

# Remove outlier modules
permutationTestResultsFiltered = lapply(permutationTestResults, function(x) x[!x$is.outlier.module,])

# Extract the preservation score distribution
results$scores.summary = PreservationScoreDistribution(permutationTestResultsFiltered,
                                                       moduleOfInterestSize = 303 # The size of the module of interest (dM15)
                                                       )

# Observed preservation score of dM15
observed.score = 9.16261490617938

# How many times did we observe a score lower than or equal to this observed score?
z.summary.dist = results$scores.summary$z.summary
below=length(z.summary.dist[z.summary.dist <= observed.score])
probability= below/100
message("Probability of observing a score of ", round(observed.score, 2), " is ", probability)
#> Probability of observing a score of 9.16 is 0.01
```

You can plot the observed score and the null distribution on a histogram like in Figure 2B of the manuscript.

```
# Plot on a histogram
ggplot(results$scores.summary, aes(x=z.summary)) +
      geom_histogram(color="black", fill="white", bins = 15)+
      xlab("Preservation score")+
      ylab("Frequency")+
      geom_vline(xintercept=observed.score, color="red3", linetype="solid")+
      scale_y_continuous(expand = c(0,0))+
      theme_classic()+
      theme(plot.title = element_text(hjust = 0.5))
```

![](data:image/png;base64...)

# 11 Conclusion

This analysis provides a great deal of evidence suggesting that dM15 is a transcriptional network that is gained in this disease status and is not present in healthy astrocytes. Further investigation will reveal that this network corresponds to the reactive astrocyte transcriptional network, which indeed is active in the EAE model and is absent in healthy astrocytes. Please see Tommasini and Fogel. BMC Bioinformatics. 2023. for more details.

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
#>  [85] grid_4.5.1            impute_1.83.0         AnnotationDbi_1.71.1
#>  [88] colorspace_2.1-2      patchwork_1.3.2       htmlTable_2.4.3
#>  [91] Formula_1.2-5         cli_3.6.5             rappdirs_0.3.3
#>  [94] S4Arrays_1.9.1        dplyr_1.1.4           gtable_0.3.6
#>  [97] dynamicTreeCut_1.63-1 sass_0.4.10           digest_0.6.37
#> [100] ggrepel_0.9.6         SparseArray_1.9.1     htmlwidgets_1.6.4
#> [103] farver_2.1.2          memoise_2.0.1         htmltools_0.5.8.1
#> [106] lifecycle_1.0.4       httr_1.4.7            GO.db_3.21.0
#> [109] bit64_4.6.0-1
```