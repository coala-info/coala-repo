# An Introduction to the pandaR Package

#### Daniel Schlauch, Albert Young, Joseph N. Paulson

#### 2025-10-30

## Introduction

The fundamental concepts behind the PANDA approach is to model the regulatory network as a bipartite network and estimate edge weights based on the evidence that information from a particular transcription factor *i* is successfully being passed to a particular gene *j*. This evidence comes from the agreement between two measured quantities. First, the correlation in expression between gene *j* and other genes. And second, the strength of evidence of the existence of an edge between TF *i* and those same genes. This concordance is measured using Tanimoto similarity. A gene is said to be available if there is strong evidence of this type of agreement. Analogous to this is the concept of responsibility which similarly focuses on a TF-gene network edge but instead measures the concordance between suspected protein-complex partners of TF *i* and the respective strength of evidence of a regulatory pathway between those TFs and gene *j*.

PANDA utilizes an iterative approach to updating the bipartite edge weights incrementally as evidence for new edges emerges and evidence for existing edges diminishes. This process continues until the algorithm reaches a point of convergence settling on a final score for the strength of information supporting a regulatory mechanism for every pairwise combination of TFs and genes. This package provides a straightforward tool for applying this established method. Beginning with data.frames or matrices representing a set of gene expression samples, motif priors and optional protein-protein interaction users can generate an *m* by *n* matrix representing the bipartite network from *m* TFs regulating *n* genes. Additionally, pandaR reports the co-regulation and cooperative networks at convergence. These are reported as complete graphs representing the evidence for gene co-regulation and transcription factor cooperation.

## Example

An example dataset derived from a subset of stress-induced Yeast is available by running

```
library(pandaR)
```

```
## Loading required package: Biobase
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
data(pandaToyData)
```

**pandaToyData** is a list containing a regulatory structure derived from sequence motif analysis, protein-protein interaction data and a gene expression. The primary function in pandaR is called with

```
pandaResult <- panda(pandaToyData$motif, pandaToyData$expression, pandaToyData$ppi)
pandaResult
```

```
## PANDA network for1000genes and87transcription factors.
```

```
##
## Slots:
```

```
## regNet   : Regulatory network of 87 transcription factors to 1000 genes.
```

```
## coregNet: Co-regulation network of 1000 genes.
```

```
## coopNet  : Cooperative network of 87 transcription factors.
```

```
## Regulatory graph contains 87000 edges.
```

```
## Regulatory graph is complete.
```

Where **pandaResult** is a ‘panda’ object which contains **data.frame**s describing the complete bipartite gene regulatory network as well as complete networks for gene coregulation and transcription factor cooperation. Due to completeness, edgeweights for the regulatory network are reported for all *m*x*n* possible TF-gene edges. The distribution of these edge weights for these networks has approximate mean 0 and standard deviation 1. The edges are therefore best interpreted in a relative sense. Strongly positive values indicative of relatively larger amounts of evidence in favor a regulatory mechanism and conversely, smaller or negative values can be interpreted as lacking evidence of a shared biological role. It is naturally of interest to specify a high edge weight subset of the complete network to investigate as a set of present/absent edges. This is easily performed by using the **topedges** function. A network containing the top 1000 edge scores as binary edges can be obtained by:

```
topNet <- topedges(pandaResult, 1000)
```

Users may then examine the genes targeted by a transcription factor of interest.

```
targetedGenes(topNet, c("AR"))
```

```
##  [1] "AKAP10"       "CNDP2"        "CRHR1"        "HNRNPD"       "KIAA0652"
##  [6] "LOC100093631" "LOC100128811" "PRR15"        "TCF4"         "TCP11L2"
## [11] "TMPRSS11B"    "VCX3B"        "WDR4"
```

The network can be further simplified by focusing only on transcription factors on interest and the genes that they are found to regulate. The **subnetwork** method serves this function

```
topSubnet <- subnetwork(topNet, c("AR","ARID3A","ELK1"))
```

Existing R packages, such as igraph, can be used to visualize the results

```
plotGraph(topSubnet)
```

![](data:image/png;base64...)

## Comparing state-specific PANDA networks

We provide a number of useful plotting functions for the analysis of the networks. The main functions used to plot and analyze the PANDA networks are:

* *plotZ* -Comparison of Z scores between two PANDA runs
* *plotZbyTF* - Plot Z by TF outdegree quartiles

We can compare how parameter choices effect the Z-score estimation between two PANDA runs. Additionally, we can compare two phenotypes:

```
panda.res1 <- with(pandaToyData, panda(motif, expression, ppi, hamming=1))
panda.res2 <- with(pandaToyData, panda(motif, expression +
                   rnorm(prod(dim(expression)),sd=5), ppi, hamming=1))
plotZ(panda.res1, panda.res2,addLine=FALSE)
```

```
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the pandaR package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

Other comparisons are underway…

## Other helpful functions

There are a host of other helpful functions, including *testMotif*, *plotCommunityDetection*, and *multiplot*. See the full help pages.

## Session information

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
## [1] pandaR_1.42.0       Biobase_2.70.0      BiocGenerics_0.56.0
## [4] generics_0.1.4
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6       jsonlite_2.0.0     crayon_1.5.3       dplyr_1.1.4
##  [5] compiler_4.5.1     tidyselect_1.2.1   Rcpp_1.1.0         dichromat_2.0-0.1
##  [9] jquerylib_0.1.4    scales_1.4.0       yaml_2.3.10        fastmap_1.2.0
## [13] lattice_0.22-7     ggplot2_4.0.0      hexbin_1.28.5      R6_2.6.1
## [17] plyr_1.8.9         labeling_0.4.3     igraph_2.2.1       knitr_1.50
## [21] tibble_3.3.0       bslib_0.9.0        pillar_1.11.1      RColorBrewer_1.1-3
## [25] rlang_1.1.6        cachem_1.1.0       reshape_0.8.10     xfun_0.53
## [29] sass_0.4.10        S7_0.2.0           cli_3.6.5          withr_3.0.2
## [33] magrittr_2.0.4     digest_0.6.37      grid_4.5.1         RUnit_0.4.33.1
## [37] lifecycle_1.0.4    vctrs_0.6.5        evaluate_1.0.5     glue_1.8.0
## [41] farver_2.1.2       rmarkdown_2.30     matrixStats_1.5.0  tools_4.5.1
## [45] pkgconfig_2.0.3    htmltools_0.5.8.1
```

##References

Glass K, Huttenhower C, Quackenbush J, Yuan GC. Passing Messages Between Biological Networks to Refine Predicted Interactions, *PLoS One*, 2013 May 31;8(5):e64832

Glass K, Quackenbush J, Silverman EK, Celli B, Rennard S, Yuan GC and DeMeo DL. Sexually-dimorphic targeting of functionally-related genes in COPD, *BMC Systems Biology*, 2014 Nov 28; **8**:118