# roastgsa vignette (main)

Adria Caballe-Mestres

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Paper associated to R package](#paper-associated-to-r-package)
* [3 Data: array experiment from GSEABenchmarkeR](#data-array-experiment-from-gseabenchmarker)
* [4 Gene set enrichment analysis using roastgsa](#gene-set-enrichment-analysis-using-roastgsa)
  + [4.1 Data treatment](#data-treatment)
  + [4.2 Model setting](#model-setting)
  + [4.3 Visualization of the results](#visualization-of-the-results)
  + [4.4 Effective signature size](#effective-signature-size)
  + [4.5 Functions to present the results](#functions-to-present-the-results)
  + [4.6 Single sample GSA](#single-sample-gsa)
* [5 sessionInfo](#sessioninfo)
* [6 References](#references)
* **Appendix**

# 1 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("roastgsa")
```

# 2 Paper associated to R package

```
library( roastgsa )
```

The R package `roastgsa` contains several functions to perform
gene set analysis, for both competitive and self-contained hypothesis
testing.

It follows the work by Gordon Smyth’s group on rotation based methods
for gene set analysis [1], code available in R through functions
`roast` and `romer` from the `limma` package [2].

They propose to reconsider the sample randomization approach based
on permutations of GSEA [3] to the more general procedure scheme using
rotations of the residual space of the data, which can be used even when
the number of degrees of freedom left is very small.

In our understanding, the test statistics provided in `romer`, which
are all functions of the moderated t-statistics ranks, are too limited. In
this R package we propose to complete the romer functionality by providing
other statistics used in the GSA context [4]. We consider the KS based test
statistics in the GSEA and GSVA [5] as well as computationally more efficient
procedures such as restandardized statistics based on summary statistics
measures. The methodology is presented and compared using both simulated
and benchmarking data in the following publication:

roastgsa: a comparison of rotation-based scores
for gene set enrichment analysis (2023).

We encourage anybody wanting to use the R package to first read the
associated paper.

In this R package, we have also provided several tools to summarize
and visualize the roastgsa results. This vignette will show a work-flow
for gene set analysis with `roastgsa` using microarray data (available in
the `GSEABenchmarkeR` R package [6]).

# 3 Data: array experiment from GSEABenchmarkeR

We consider the fourth dataset available in the `GSEABenchmarkeR` R
package, which consists of a microarray study with 30 samples, 15 paired samples
corresponding to two different groups (that take values 0 and 1 respectively).

```
library(GSEABenchmarkeR)
geo2keggR <- loadEData("geo2kegg", nr.datasets=4)
geo2kegg <- maPreproc(list(geo2keggR[[4]]))
y <- assays(geo2kegg[[1]])$expr
covar <- colData(geo2kegg[[1]])
covar$GROUP <- as.factor(covar$GROUP)
covar$BLOCK <- as.factor(covar$BLOCK)
```

The objective is to understand which KEGG processes might be affected
by such two genotyping conditions. These are made available through the
`EnrichmentBrowser` R package. Here we will consider gene sets of size
between 11 and 499.

```
#library(EnrichmentBrowser)
#kegg.hs <- getGenesets(org="hsa", db="kegg")
data(kegg.hs)
kegg.gs <- kegg.hs[which(sapply(kegg.hs,length)>10&sapply(kegg.hs,length)<500)]
```

# 4 Gene set enrichment analysis using roastgsa

## 4.1 Data treatment

There are some important elements that should be taken into
consideration before undertaking the `roastgsa`. First, the expression
data should be approximately normally distributed, at least in their
univariate form. For RNA-seq data or any other form of counts data, prior
normalization, e.g., `rlog` or `vst` (`DESeq2`), `zscoreDGE` (`edgeR`) or `voom`
(`limma`), should be used. Besides, filtering for expression intensity
and variability could be considered, especially when the gene
variation across individuals is limited by the experimental coverage.

For microarray intensities, as it happens in the example of this
vignette, we can perform
a quantile normalization to balance out the libraries.

```
library(preprocessCore)
ynorm <- normalize.quantiles(y)
rownames(ynorm) <- rownames(y)
colnames(ynorm) <- colnames(y)
par(mfrow=c(1,2))
boxplot(y, las = 2)
boxplot(ynorm, las = 2)
```

![](data:image/png;base64...)

```
y <- ynorm
```

## 4.2 Model setting

Indicating the model to be fitted is essential for the roastgsa
implementation. This follows a similar strategy to the `limma`
specifications. With the attributes `form`, `covar` and `contrast` it can be
set the linear model and the specific estimated coefficient to be used
in `roastgsa` for hypothesis testing. The matrix design is found
automatically taking the `form` and `covar` parameters (see
below). The `contrast` can be in a vector object (length equal to the
number of columns in the matrix design), an integer with the column of
the term of interest in the matrix design, as well as the name of such column.

```
form = as.formula("~ BLOCK + GROUP")
design <- model.matrix(form, covar)
contrast = "GROUP1"
```

Three parameters that define the roast hypothesis testing have to be
properly specified: -a- the number of rotations to draw the null
hypothesis (`nrot`); -b- the statistic to be used (`set.statistic`);
-c- the type of hypothesis (`self.contained` argument), competitive
(set to FALSE) or self-contained (set to TRUE).

Regarding the test statistics, the `maxmean` (directional) and the
`absmean` (nondirectional) are recommended to maximise the power, with
`mean.rank` being a good non-parametric alternative for a more robust
statistic if it is known that a few highly differentially expressed
genes might influence heavily the statistic calculation. For a more
“democratic” statistic, one that counterbalance both ends of
the distribution (negative and positive), we encourage using the
`mean` statistic.

Below, there is the standard `roastgsa` instruction (under competitive
testing) for `maxmean` and `mean.rank` statistics.

```
fit.maxmean.comp <- roastgsa(y, form = form, covar = covar,
contrast = contrast, index = kegg.gs, nrot = 500,
mccores = 1, set.statistic = "maxmean",
self.contained = FALSE, executation.info = FALSE)
f1 <- fit.maxmean.comp$res
rownames(f1) <- substr(rownames(f1),1,8)
head(f1)
```

```
##          total_genes measured_genes       est      nes        pval   adj.pval
## hsa05230          70             69 0.5425399 3.734320 0.001996008 0.05112851
## hsa04520          93             92 0.6180156 3.271618 0.001996008 0.05112851
## hsa04215          32             31 0.6703085 3.270118 0.001996008 0.05112851
## hsa04115          73             73 0.8053401 3.257792 0.001996008 0.05112851
## hsa04530         169            164 0.4897769 3.225338 0.001996008 0.05112851
## hsa00512          36             35 0.8498029 3.082012 0.009980040 0.15106151
```

```
fit.meanrank <- roastgsa(y, form = form, covar = covar,
    contrast = 2, index = kegg.gs, nrot = 500,
    mccores = 1, set.statistic = "mean.rank",
    self.contained = FALSE, executation.info = FALSE)
f2 <- fit.meanrank$res
rownames(f2) <- substr(rownames(f2),1,8)
head(f2)
```

```
##          total_genes measured_genes        est  pval.diff adj.pval.diff
## hsa04012          85             84  2213.2976 0.02195609      0.997006
## hsa04710          34             33  2526.2121 0.02994012      0.997006
## hsa00230         128            124 -1623.6613 0.03792415      0.997006
## hsa04964          23             23  4230.6522 0.05788423      0.997006
## hsa04910         137            136   913.6691 0.06187625      0.997006
## hsa04920          69             69  1440.4058 0.06187625      0.997006
##          pval.mixed adj.pval.mixed
## hsa04012 0.06187625      0.5964993
## hsa04710 0.45508982      0.7148345
## hsa00230 0.32335329      0.6536540
## hsa04964 0.02195609      0.5964993
## hsa04910 0.05389222      0.5964993
## hsa04920 0.08782435      0.5964993
```

## 4.3 Visualization of the results

Several functions to summarize or visualize the results can be applied
to objects of class `roastgsa`, which are found as output of the
`roastgsa` function.

The `plot` function of a `roastgsa` object produces a general image
of the differential expression results within any tested gene set. If
`type = "stats"`, it shows the ordered moderated t-statistics in
various formats, area for up- and down- expressed genes, barcode plot
for these ordered values and density. With the argument `whplot` it can be
selected the gene set of interest (either an integer with the ordered
position in the roastgsa output or the name of the gene set).

```
plot(fit.maxmean.comp, type ="stats", whplot = 2,  gsainfo = TRUE,
    cex.sub = 0.5, lwd = 2)
```

![](data:image/png;base64...)

If the `roastgsa` statistic is `mean.rank`, the moderated-t statistic
centred ranks are printed instead.

```
plot(fit.meanrank,  type ="stats",  whplot = 1, gsainfo = TRUE,
    cex.sub = 0.4, lwd = 2)
```

![](data:image/png;base64...)

Even though the `type = "GSEA"` option is directly interpretable for
ksmean and ksmax statistics, we find it useful for seeing the behavior
in both Kolgomorov-Smirnov type scores and simple summary statistics:

```
plot(fit.maxmean.comp, type = "GSEA", whplot = 2, gsainfo = TRUE,
    maintitle = "",  cex.sub = 0.5, statistic = "mean")
```

![](data:image/png;base64...)

```
plot(fit.meanrank, type = "GSEA",  whplot = 1, gsainfo = TRUE,
    maintitle = "",  cex.sub = 0.5, statistic = "mean")
```

![](data:image/png;base64...)

Another graphic that is proposed in this package to visualize the genes activity
within a gene set can be obtained through the function `heatmaprgsa_hm`.
The main intention is to illustrate the variation across samples for the
gene set of interest. We highly recommend the generation of this graphic,
or any other similar plot that shows sample variation for the tested gene sets.
Not only for showing which genes are activated but also as quality control to
detect samples that can be highly influential in the GSA analysis.

```
hm <- heatmaprgsa_hm(fit.maxmean.comp, y, intvar = "GROUP", whplot = 3,
        toplot = TRUE, pathwaylevel = FALSE, mycol = c("orange","green",
        "white"), sample2zero = FALSE)
```

![](data:image/png;base64...)

The same sort of graphic can be drawn at pathway level, i.e.,
summarized (average) pathway activity, when `pathwaylevel = TRUE`. With the parameter `whplot` it can be specified which pathways
are included in the comparison.

```
hm2 <- heatmaprgsa_hm(fit.maxmean.comp, y, intvar = "GROUP", whplot = 1:50,
        toplot = TRUE, pathwaylevel = TRUE, mycol = c("orange","green",
        "white"), sample2zero = FALSE)
```

![](data:image/png;base64...)

## 4.4 Effective signature size

Gene sets in standard databases might contain from moderately to highly
correlated genes, even when the effect of the known covariates is adjusted
a priori. The variance of summary statistics such as mean or maxmean
increases with the intra-gene set correlation, meaning that the power for
detecting gene set changes between experimental conditions depends on a
combination of genewise effect sizes, signature size and intra-gene set
correlation.

We define the effective signature size of a tested gene set by the total number
of genes that are needed, if these were selected at random, to achieve the same
summary statistic variance as that for the testing set. This can be viewed as a
realistic measure of the total number of independent variables that contribute
to the power of the test. To get an estimate of the effective signature size,
sample variances of rotation scores for randomly generated sets of several sizes
are compared to the observed rotation scores variance for the tested gene set:

```
## Computationally intensive
# varrot <- varrotrand(fit.maxmean.comp, y,
#   testedsizes = c(3:30, seq(32,50, by=2), seq(55,200,by=5)), nrep = 200)
```

A p-value that approximates the probability of obtaining a variance as extreme
as the observed test variance in randomly selected sets of several sizes is
computed:

```
# ploteffsignaturesize(fit.maxmean.comp, varrot,  whplot = 1)
```

## 4.5 Functions to present the results

The outcome obtained in `roastgsa` can be organized in a html table using
the `htmlrgsa` function. The reported file shows all numerical results that
can be found in printing an object of class `roastgsa` as well as the plots
obtained by `plotStats`, `plotGSEA`, `heatmaprgsa_hm` or
`varrotrand` + `ploteffsignaturesize`. A column with html-links for the
differential expression results at gene level can also be provided through the
argument `geneDEhtmlfiles`, which we find extremely useful for researchers to
understand which are the genes that drive the pathway activity.

```
#htmlrgsa(fit.maxmean.comp, htmlpath = getwd(), htmlname = "file.html",
#  plotpath = paste0(getwd(),"/plotsroast/"), geneDEhtmlfiles = NULL,
#  plotstats = TRUE, plotgsea = TRUE, indheatmap = TRUE,
#  ploteffsize = TRUE, y = y, intvar = "GROUP", whplot = 1:50,
#  mycol = c("orange","green","white"), varrot=varrot,
#  sorttable = sorttable,dragtable = dragtable)
```

Complete information on the usage of this function can be found in the manual.

## 4.6 Single sample GSA

To complement the outcome of the `roastgsa`, we encourage the usage of
single sample GSA visualization methods. These approaches are interesting for
assessing the variability of gene set effects at sample level (averaging out
gene wise coefficients) instead of at gene level.

The `heatmaprgsa_hm` instruction used above already provides some insight
of sample variation. Besides, in the `roastgsa` package we have implemented a
function for single sample gene set analysis based on z-scores [7].
We present two methods that correct for the overall structure in
the genome (`method = "GScor"` and `method = "GSadj"`), leading to competitive
testing, and one method that ignores the rest of the genes in the data
(`method = "zscore"`), self-contained testing. For small
sample sizes, we recommend using “GScor” whereas for sufficiently large
sample size (>50) “GSadj” is our preferred option.

```
ss1 <- ssGSA(y, obj=fit.maxmean.comp, method = c("GScor"))
```

Visualizing the summarized gene set information at sample level is
highly recommended to check the variation of the samples in the groups
of interest.

```
plot(ss1, orderby = covar$GROUP, whplot = 1, col = as.numeric(covar$GROUP),
samplename = FALSE, pch =16, maintitle = "", ssgsaInfo = TRUE,
cex.sub = 0.8, xlab = "Group", ylab = "zscore - GS")
```

![](data:image/png;base64...)

# 5 sessionInfo

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
##  [1] preprocessCore_1.72.0       hgu133plus2.db_3.13.0
##  [3] org.Hs.eg.db_3.22.0         AnnotationDbi_1.72.0
##  [5] GSEABenchmarkeR_1.30.0      DESeq2_1.50.0
##  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [13] IRanges_2.44.0              S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] roastgsa_1.8.0              knitr_1.50
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                           bitops_1.0-9
##  [3] httr2_1.2.1                         GSEABase_1.72.0
##  [5] rlang_1.1.6                         magrittr_2.0.4
##  [7] compiler_4.5.1                      RSQLite_2.4.3
##  [9] png_0.1-8                           vctrs_0.6.5
## [11] pkgconfig_2.0.3                     crayon_1.5.3
## [13] fastmap_1.2.0                       dbplyr_2.5.1
## [15] magick_2.9.0                        XVector_0.50.0
## [17] labeling_0.4.3                      caTools_1.18.3
## [19] rmarkdown_2.30                      graph_1.88.0
## [21] KEGGgraph_1.70.0                    tinytex_0.57
## [23] purrr_1.1.0                         bit_4.6.0
## [25] xfun_0.53                           cachem_1.1.0
## [27] jsonlite_2.0.0                      blob_1.2.4
## [29] DelayedArray_0.36.0                 BiocParallel_1.44.0
## [31] parallel_4.5.1                      R6_2.6.1
## [33] bslib_0.9.0                         RColorBrewer_1.1-3
## [35] limma_3.66.0                        jquerylib_0.1.4
## [37] Rcpp_1.1.0                          bookdown_0.45
## [39] Matrix_1.7-4                        tidyselect_1.2.1
## [41] dichromat_2.0-0.1                   abind_1.4-8
## [43] yaml_2.3.10                         gplots_3.2.0
## [45] codetools_0.2-20                    curl_7.0.0
## [47] lattice_0.22-7                      tibble_3.3.0
## [49] withr_3.0.2                         KEGGREST_1.50.0
## [51] S7_0.2.0                            evaluate_1.0.5
## [53] BiocFileCache_3.0.0                 Biostrings_2.78.0
## [55] pillar_1.11.1                       BiocManager_1.30.26
## [57] filelock_1.0.3                      KernSmooth_2.23-26
## [59] RCurl_1.98-1.17                     ggplot2_4.0.0
## [61] scales_1.4.0                        gtools_3.9.5
## [63] xtable_1.8-4                        glue_1.8.0
## [65] tools_4.5.1                         annotate_1.88.0
## [67] locfit_1.5-9.12                     XML_3.99-0.19
## [69] grid_4.5.1                          cli_3.6.5
## [71] rappdirs_0.3.3                      KEGGandMetacoreDzPathwaysGEO_1.29.0
## [73] S4Arrays_1.10.0                     dplyr_1.1.4
## [75] Rgraphviz_2.54.0                    gtable_0.3.6
## [77] sass_0.4.10                         digest_0.6.37
## [79] SparseArray_1.10.0                  farver_2.1.2
## [81] memoise_2.0.1                       htmltools_0.5.8.1
## [83] lifecycle_1.0.4                     httr_1.4.7
## [85] EnrichmentBrowser_2.40.0            KEGGdzPathwaysGEO_1.47.0
## [87] statmod_1.5.1                       bit64_4.6.0-1
```

# 6 References

# Appendix

[1] E. Lim, D. Wu, G. K. Smyth, M.-L. Asselin-Labat, F. Vaillant, and
J. E. Visvader. ROAST: rotation gene set tests for complex microarray
experiments. Bioinformatics, 26(17):2176-2182, 2010.

[2] M. E. Ritchie, B. Phipson, D. Wu, Y. Hu, C. W. Law, W. Shi, and
G. K. Smyth. limma powers differential expression analyses for RNAsequencing
and microarray studies. Nucleic acids research, 43(7):e47,
2015.

[3] A. Subramanian, P. Tamayo, V. K. Mootha, S. Mukherjee, B. L. Ebert,
M. A. Gillette, A. Paulovich, S. L. Pomeroy, T. R. Golub, E. S. Lander,
and J. P. Mesirov. Gene set enrichment analysis: A knowledge-based
approach for interpreting genome-wide expression profiles. Proceedings
of the National Academy of Sciences, 102(43):15545-15550, 2005.

[4] B. Efron and R. Tibshirani. On testing the significance of sets of genes.
The Annals of Applied Statistics, 1(1):107-129, 2007.

[5] S. Hanzelmann, R. Castelo, and J. Guinney. GSVA: gene set variation
analysis for microarray and RNA-Seq data. 14(1):7, 2013.

[6] Geistlinger L, Csaba G, Santarelli M, Schiffer L, Ramos M, Zimmer R,
Waldron L (2019). GSEABenchmarkeR: Reproducible GSEA Benchmarking. R package
version 1.6.0, <https://github.com/waldronlab/GSEABenchmarkeR>.

[7] Caballe Mestres A, Berenguer Llergo A and Stephan-Otto Attolini C.
Adjusting for systematic technical biases in risk assessment of gene signatures
in transcriptomic cancer cohorts. bioRxiv (2018).