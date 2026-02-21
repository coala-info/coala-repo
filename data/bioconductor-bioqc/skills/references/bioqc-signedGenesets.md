# Using BioQC with signed genesets

#### Jitao David Zhang and Gregor Sturm

#### 2025-10-29

## Introduction

Besides being used as a QC-tool for gene expression data, *BioQC* can be used for general-purpose gene-set enrichment analysis. Its core function, *wmwTest*, can handle not only “normal”, unsigned gene sets, but also signed genesets where two sets of genes represent signatures that are positively and negatively regulated respectively.

This vignette describes an example of such applications. First we load the BioQC library.

```
library(BioQC)
```

## GMT read-in

We first open a toy GMT file containing signed genesets with *readSignedGmt*. The function reads the file into a *SignedGenesets* object.

```
gmtFile <- system.file("extdata/test.gmt", package="BioQC")
## print the file context
cat(readLines(gmtFile), sep="\n")
```

```
## GS_A TestGeneSet_A   AKT1    AKT2    AKT3
## GS_B TestGeneSet_B   MAPK1   MAPK3   MAPK8
## GS_C_UP  TestGeneSet_C   ERBB2   ERBB3
## GS_C_DN  TestGeneSet_C   EGFR    ERBB4
## GS_D_UP  TestGeneSet_D   GATA2   GATA4
## GS_D_DN  TestGeneSet_D   GATA1   GATA3
## GS_E_DN  TestGeneSet_E   TSC1    TSC2
```

```
## read the file into SignedGenesets
genesets <- readSignedGmt(gmtFile)
print(genesets)
```

```
## A list of 5 signed gene-sets
##   GS_A (no genes)
##   GS_B (no genes)
##   GS_C[n=4]
##     positive[n=2]:ERBB2,ERBB3
##     negative[n=2]:EGFR,ERBB4
##   GS_D[n=4]
##     positive[n=2]:GATA2,GATA4
##     negative[n=2]:GATA1,GATA3
##   GS_E[n=2]
##     positive[n=0]:
##     negative[n=2]:TSC1,TSC2
```

Note that though the GMT file contains 6 non-empty lines, only five signed genesets are returned by *readSignedGmt* because a pair of negative and negative geneset of GS\_C is available.

Note that in its current form, no genes are reported for GS\_A and GS\_B, because the names of both sets do not match the patterns. User can decide how to handle such genesets that match patterns of neither positive nor negative sets (GS\_A and GS\_B in this case). By default, such genesets are ignored; however, user can decide to treat them as either positive or negative genesets. For the purpose of this tutorial, we treat these genesets as positive.

```
genesets <- readSignedGmt(gmtFile, nomatch="pos")
print(genesets)
```

```
## A list of 5 signed gene-sets
##   GS_A[n=3]
##     positive[n=3]:AKT1,AKT2,AKT3
##     negative[n=0]:
##   GS_B[n=3]
##     positive[n=3]:MAPK1,MAPK3,MAPK8
##     negative[n=0]:
##   GS_C[n=4]
##     positive[n=2]:ERBB2,ERBB3
##     negative[n=2]:EGFR,ERBB4
##   GS_D[n=4]
##     positive[n=2]:GATA2,GATA4
##     negative[n=2]:GATA1,GATA3
##   GS_E[n=2]
##     positive[n=0]:
##     negative[n=2]:TSC1,TSC2
```

## Expression object construction

Next we construct an ExpressionSet object containing 100 genes, with some of the genes in the GMT file present.

```
set.seed(1887)
testN <- 100L
testSampleCount <- 3L
testGenes <- c("AKT1", "AKT2", "ERBB2", "ERBB3", "EGFR","TSC1", "TSC2", "GATA2", "GATA4", "GATA1", "GATA3")
testRows <- c(testGenes, paste("Gene", (length(testGenes)+1):testN, sep=""))
testMatrix <- matrix(rnorm(testN*testSampleCount, sd=0.1), nrow=testN, dimnames=list(testRows, NULL))
testMatrix[1:2,] <- testMatrix[1:2,]+10
testMatrix[6:7,] <- testMatrix[6:7,]-10
testMatrix[3:4,] <- testMatrix[3:4,]-5
testMatrix[5,] <- testMatrix[5,]+5
testEset <- new("ExpressionSet", exprs=testMatrix)
```

The expression of somes genes are delibrately changed so that some genesets are expected to be significantly enriched.

* AKT1 and AKT2 are higher expressed than the background genes (‘background’ hereafter).
* TSC1 and TSC2 are lower expressed than the background.
* ERBB2 and ERBB3 are moderately lower expressed than the background.
* EGFR is moderately higher expressed than the background.

Considering the geneset composition printed above, we can expect that \* GS\_A shall be significantly up-regulated; \* GS\_B shall not be significant, because its genes are missing; \* GS\_C shall be significantly down-regulated, with positive targets down-regulated and negative targets up-regulated; \* GS\_D shall not always be significant, because its genes are comparable to the background; \* GS\_E shall be significantly up-regulated, because its negative targets are down-regulated.

## Match genes

With both *SignedGenesets* and *ExpressionSet* objects at hand, we can query the indices of genes of genesets in the *ExpressionSet* object.

```
testIndex <- matchGenes(genesets, testEset, col=NULL)
print(testIndex)
```

```
## A list of 5 signed indices with offset=1
## Options: NA removed: TRUE; duplicates removed: TRUE
##   GS_A[n=2]
##     positive[n=2]:1,2
##     negative[n=0]:
##   GS_B (no genes)
##   GS_C[n=3]
##     positive[n=2]:3,4
##     negative[n=1]:5
##   GS_D[n=4]
##     positive[n=2]:8,9
##     negative[n=2]:10,11
##   GS_E[n=2]
##     positive[n=0]:
##     negative[n=2]:6,7
```

If the *ExpressionSet* object has GeneSymbols in its featureData other than the feature names, user can specify the parameter *col* in *matchGenes* to make the match working. *matchGene* also works with characters and matrix as input, please check out the help pages for such uses.

## Perform the analysis

```
wmwResult.greater <- wmwTest(testEset, testIndex, valType="p.greater")
print(wmwResult.greater)
```

```
##                1           2           3
## GS_A 0.008185751 0.008185751 0.008185751
## GS_B 1.000000000 1.000000000 1.000000000
## GS_C 0.997942914 0.997942914 0.997942914
## GS_D 0.924153922 0.114118870 0.211756278
## GS_E 0.008185751 0.008185751 0.008185751
```

As expected, GS\_A and GS\_E are significant when the alternative hypothesis is *greater*.

```
wmwResult.less <- wmwTest(testEset, testIndex, valType="p.less")
print(wmwResult.less)
```

```
##                1           2           3
## GS_A 0.992348913 0.992348913 0.992348913
## GS_B 1.000000000 1.000000000 1.000000000
## GS_C 0.002192387 0.002192387 0.002192387
## GS_D 0.078389208 0.889240837 0.793302033
## GS_E 0.992348913 0.992348913 0.992348913
```

As expected, GS\_C is significant when the alternative hypothesis is *less*.

```
wmwResult.two.sided <- wmwTest(testEset, testIndex, valType="p.two.sided")
print(wmwResult.two.sided)
```

```
##                1           2           3
## GS_A 0.016371502 0.016371502 0.016371502
## GS_B 1.000000000 1.000000000 1.000000000
## GS_C 0.004384774 0.004384774 0.004384774
## GS_D 0.156778415 0.228237741 0.423512555
## GS_E 0.016371502 0.016371502 0.016371502
```

As expected, GS\_A, GS\_C, and GS\_E are significant when the alternative hypothesis is *two.sided*.

A simple way to integrate the results of both alternative hypotheses into one numerical value is the *Q* value, which is defined as absolute log10 transformation of the smaller p value of the two hypotheses, times the sign defined by *greater*=1 and *less*=-1.

```
wmwResult.Q <- wmwTest(testEset, testIndex, valType="Q")
print(wmwResult.Q)
```

```
##               1          2          3
## GS_A  1.7859115  1.7859115  1.7859115
## GS_B  0.0000000  0.0000000  0.0000000
## GS_C -2.3580528 -2.3580528 -2.3580528
## GS_D -0.8047137  0.6416125  0.3731337
## GS_E  1.7859115  1.7859115  1.7859115
```

As expected, genesets GS\_A, GS\_C, and GS\_E have large absolute values, suggesting they are potentially enriched; while GS\_A and GS\_E are positively enriched, GS\_C is negatively enriched.

## Conclusions

In summary, *BioQC* can be used to perform gene-set enrichment analysis with signed genesets. Its speed is comparable to that of unsigned genesets.

## Acknowledgement

I would like to thank the authors of the gCMAP package with the idea of integrating signed genesets into the framework of Wilcoxon-Mann-Whitney test.

## R session info

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
##  [1] rbenchmark_1.0.0     gplots_3.2.0         gridExtra_2.3
##  [4] latticeExtra_0.6-31  lattice_0.22-7       org.Hs.eg.db_3.22.0
##  [7] AnnotationDbi_1.72.0 IRanges_2.44.0       S4Vectors_0.48.0
## [10] testthat_3.2.3       limma_3.66.0         RColorBrewer_1.1-3
## [13] BioQC_1.38.0         Biobase_2.70.0       BiocGenerics_0.56.0
## [16] generics_0.1.4       knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0    gtable_0.3.6       xfun_0.53          bslib_0.9.0
##  [5] caTools_1.18.3     vctrs_0.6.5        tools_4.5.1        bitops_1.0-9
##  [9] RSQLite_2.4.3      blob_1.2.4         pkgconfig_2.0.3    KernSmooth_2.23-26
## [13] desc_1.4.3         lifecycle_1.0.4    compiler_4.5.1     deldir_2.0-4
## [17] Biostrings_2.78.0  brio_1.1.5         statmod_1.5.1      Seqinfo_1.0.0
## [21] htmltools_0.5.8.1  sass_0.4.10        yaml_2.3.10        crayon_1.5.3
## [25] jquerylib_0.1.4    cachem_1.1.0       gtools_3.9.5       locfit_1.5-9.12
## [29] digest_0.6.37      rprojroot_2.1.1    fastmap_1.2.0      grid_4.5.1
## [33] cli_3.6.5          magrittr_2.0.4     edgeR_4.8.0        bit64_4.6.0-1
## [37] rmarkdown_2.30     XVector_0.50.0     httr_1.4.7         jpeg_0.1-11
## [41] bit_4.6.0          interp_1.1-6       png_0.1-8          memoise_2.0.1
## [45] evaluate_1.0.5     rlang_1.1.6        Rcpp_1.1.0         glue_1.8.0
## [49] DBI_1.2.3          pkgload_1.4.1      jsonlite_2.0.0     R6_2.6.1
```