# RUVSeq: Remove Unwanted Variation from RNA-Seq Data

Davide Risso

Department of Statistical Sciences, University of Padova

#### Last modified: November 22, 2022; Compiled: October 30, 2025

# Contents

* [1 Overview](#overview)
* [2 A typical differential expression analysis workflow](#a-typical-differential-expression-analysis-workflow)
  + [2.1 Filtering and exploratory data analysis](#filtering-and-exploratory-data-analysis)
  + [2.2 RUVg: Estimating the factors of unwanted variation using control genes](#ruvg-estimating-the-factors-of-unwanted-variation-using-control-genes)
  + [2.3 Differential expression analysis](#differential-expression-analysis)
  + [2.4 Empirical control genes](#empirical-control-genes)
  + [2.5 Differential expression analysis with *DESeq2*](#differential-expression-analysis-with-deseq2)
* [3 RUVs: Estimating the factors of unwanted variation using replicate samples}](#ruvs-estimating-the-factors-of-unwanted-variation-using-replicate-samples)
* [4 RUVr: Estimating the factors of unwanted variation using residuals](#ruvr-estimating-the-factors-of-unwanted-variation-using-residuals)
* [5 Session info](#session-info)
* [References](#references)

# 1 Overview

In this document, we show how to conduct a differential expression (DE) analysis that controls for “unwanted variation”, e.g., batch, library preparation, and other nuisance effects, using the between-sample normalization methods proposed in Risso et al. ([2014](#ref-risso2013ruv)). We call this approach *RUVSeq* for *remove unwanted variation from RNA-Seq data*.

Briefly, *RUVSeq* works as follows. For \(n\) samples and \(J\) genes, consider the following generalized linear model (GLM), where the RNA-Seq read counts are regressed on both the known covariates of interest and unknown factors of unwanted variation,

\[\begin{equation}
\log E[Y | W, X, O] = W \alpha + X \beta + O.
\end{equation}\]

Here, \(Y\) is the \(n \times J\) matrix of observed gene-level read counts, \(W\) is an \(n \times k\) matrix corresponding to the factors of “unwanted variation” and \(\alpha\) its associated \(k \times J\) matrix of nuisance parameters, \(X\) is an \(n \times p\) matrix corresponding to the \(p\) covariates of interest/factors of “wanted variation” (e.g., treatment effect) and \(\beta\) its associated \(p \times J\) matrix of parameters of interest, and \(O\) is an \(n \times J\) matrix of offsets that can either be set to zero or estimated with some other normalization procedure (such as upper-quartile normalization).

The matrix \(X\) is a random variable, assumed to be known a priori. For instance, in the usual two-class comparison setting (e.g., treated vs. control samples), \(X\) is an \(n \times 2\) design matrix with a column of ones corresponding to an intercept and a column of indicator variables for the class of each sample (e.g., 0 for control and 1 for treated) (McCullagh and Nelder [1989](#ref-mccullough1989generalized)). The matrix \(W\) is an unobserved random variable and \(\alpha\), \(\beta\), and \(k\) are unknown
parameters.

The simultaneous estimation of \(W\), \(\alpha\), \(\beta\), and \(k\) is infeasible. For a given \(k\), we consider instead the following three approaches to estimate the factors of unwanted variation \(W\):

* `RUVg` uses negative control genes, assumed to have constant expression across samples;
* `RUVs` uses centered (technical) replicate/negative control samples for which the covariates of interest are constant;
* `RUVr` uses residuals, e.g., from a first-pass GLM regression of the counts on the covariates of interest.

The resulting estimate of \(W\) can then be plugged into Equation , for the full set of genes and samples, and \(\alpha\) and \(\beta\) estimated by GLM regression. Normalized read counts can be obtained as residuals from
ordinary least squares (OLS) regression of \(\log Y - O\) on the estimated \(W\).

Note that although here we illustrate the RUV approach using the GLM implementation of *edgeR* and *DESeq2*, all three RUV versions can be readily adapted to work with any DE method formulated within a GLM framework.

See Risso et al. ([2014](#ref-risso2013ruv)) for full details and algorithms for each of the
three RUV procedures.

# 2 A typical differential expression analysis workflow

In this section, we consider the `RUVg` function to estimate the factors of unwanted variation using control genes. See the Sections below for examples using the `RUVs` and `RUVr` approaches.

We consider the zebrafish dataset of Ferreira et al. ([2014](#ref-ferreira2013silencing)), available through the Bioconductor package *zebrafishRNASeq*. The data correspond to RNA libraries for three pairs of gallein-treated and control embryonic zebrafish cell pools. For each of the 6 samples, we have RNA-Seq read counts for \(32{,}469\) Ensembl genes and \(92\) ERCC spike-in sequences. See
Risso et al. ([2014](#ref-risso2013ruv)) and the *zebrafishRNASeq* package vignette
for details.

```
library(RUVSeq)
library(zebrafishRNASeq)
data(zfGenes)
head(zfGenes)
#>                    Ctl1 Ctl3 Ctl5 Trt9 Trt11 Trt13
#> ENSDARG00000000001  304  129  339  102    16   617
#> ENSDARG00000000002  605  637  406   82   230  1245
#> ENSDARG00000000018  391  235  217  554   451   565
#> ENSDARG00000000019 2979 4729 7002 7309  9395  3349
#> ENSDARG00000000068   89  356   41  149    45    44
#> ENSDARG00000000069  312  184  844  269   513   243
tail(zfGenes)
#>             Ctl1 Ctl3 Ctl5  Trt9 Trt11 Trt13
#> ERCC-00163   204   59  183   152   104    59
#> ERCC-00164     6    1   74    11   206    21
#> ERCC-00165   140  119   93   331    52    38
#> ERCC-00168     0    0    0     0     2     0
#> ERCC-00170   216  145  111   456   196   552
#> ERCC-00171 12869 6682 7675 47488 24322 26112
```

## 2.1 Filtering and exploratory data analysis

We filter out non-expressed genes, by requiring more than 5 reads
in at least two samples for each gene.

```
filter <- apply(zfGenes, 1, function(x) length(x[x>5])>=2)
filtered <- zfGenes[filter,]
genes <- rownames(filtered)[grep("^ENS", rownames(filtered))]
spikes <- rownames(filtered)[grep("^ERCC", rownames(filtered))]
```

After the filtering, we are left with 20806 genes and
59 spike-ins.

We store the data in an object of S4 class *SeqExpressionSet* from the *EDASeq* package. This allows us to make full use of
the plotting and normalization functionality of *EDASeq*. Note,
however, that all the methods in *RUVSeq* are implemented for both
*SeqExpressionSet* and *matrix* objects. See the
help pages for details.

```
x <- as.factor(rep(c("Ctl", "Trt"), each=3))
set <- newSeqExpressionSet(as.matrix(filtered),
                           phenoData = data.frame(x, row.names=colnames(filtered)))
set
#> SeqExpressionSet (storageMode: lockedEnvironment)
#> assayData: 20865 features, 6 samples
#>   element names: counts, normalizedCounts, offset
#> protocolData: none
#> phenoData
#>   sampleNames: Ctl1 Ctl3 ... Trt13 (6 total)
#>   varLabels: x
#>   varMetadata: labelDescription
#> featureData: none
#> experimentData: use 'experimentData(object)'
#> Annotation:
```

The boxplots of relative log expression (RLE = log-ratio of read count to median read count across sample) and plots of principal components (PC) reveal a clear need for betwen-sample normalization.

```
library(RColorBrewer)
colors <- brewer.pal(3, "Set2")
plotRLE(set, outline=FALSE, ylim=c(-4, 4), col=colors[x])
```

![](data:image/png;base64...)

```
plotPCA(set, col=colors[x], cex=1.2)
```

![](data:image/png;base64...)

We can use the *betweenLaneNormalization* function of
*EDASeq* to normalize the data using upper-quartile (UQ)
normalization (Bullard et al. [2010](#ref-bullard2010evaluation)).

```
set <- betweenLaneNormalization(set, which="upper")
plotRLE(set, outline=FALSE, ylim=c(-4, 4), col=colors[x])
```

![](data:image/png;base64...)

```
plotPCA(set, col=colors[x], cex=1.2)
```

![](data:image/png;base64...)

After upper-quartile normalization, treated sample *Trt11* still
shows extra variability when compared to the rest of the samples.
This is reflected by the first principal
component, that is driven by the difference
between *Trt11* and the other samples.

## 2.2 RUVg: Estimating the factors of unwanted variation using control genes

To estimate the factors of unwanted variation, we need a set of *negative
control genes*, i.e., genes that can be assumed not to be influenced by the
covariates of interest (in the case of the zebrafish dataset, the Gallein
treatment). In many cases, such a set can be identified, e.g., housekeeping genes or spike-in controls. If a good set of
negative controls is not readily available, one can define a set of “in-silico empirical”
controls.

Here, we use the ERCC spike-ins as controls and we consider \(k=1\)
factors of unwanted variation. See Risso et al. ([2014](#ref-risso2013ruv)) and
Gagnon-Bartsch and Speed ([2012](#ref-gagnon2012)) for a discussion on the choice of \(k\).

```
set1 <- RUVg(set, spikes, k=1)
pData(set1)
#>         x         W_1
#> Ctl1  Ctl -0.04539413
#> Ctl3  Ctl  0.50347642
#> Ctl5  Ctl  0.40575319
#> Trt9  Trt -0.30773479
#> Trt11 Trt -0.68455406
#> Trt13 Trt  0.12845337
plotRLE(set1, outline=FALSE, ylim=c(-4, 4), col=colors[x])
```

![](data:image/png;base64...)

```
plotPCA(set1, col=colors[x], cex=1.2)
```

![](data:image/png;base64...)

The *RUVg* function returns two pieces of information: the
estimated factors of unwanted variation (added as columns to the *phenoData* slot of *set*) and
the normalized counts obtained by regressing the original counts on
the unwanted factors. The normalized values are stored in the
*normalizedCounts* slot of *set* and can be accessed
with the *normCounts* method. These counts should be used only
for exploration. It is important that subsequent DE analysis be
done on the *original counts* (accessible through the
*counts* method), as removing the unwanted factors
from the counts can also remove part of a factor of interest (Gagnon-Bartsch, Jacob, and Speed [2013](#ref-ruv4)).

Note that one can relax the negative control
gene assumption by requiring instead the identification of a set of
positive or negative controls, with a priori known
expression fold-changes between samples, i.e., known \(\beta\).
One can then use the centered counts for these genes (\(\log Y - X\beta\)) for normalization purposes.

## 2.3 Differential expression analysis

Now, we are ready to look for differentially expressed genes, using
the negative binomial GLM approach implemented in *edgeR* (see the
*edgeR* package vignette for details).
This is done by considering a design matrix that includes both the
covariates of interest (here, the treatment status) and the factors of
unwanted variation.

```
design <- model.matrix(~x + W_1, data=pData(set1))
y <- DGEList(counts=counts(set1), group=x)
y <- calcNormFactors(y, method="upperquartile")
y <- estimateGLMCommonDisp(y, design)
y <- estimateGLMTagwiseDisp(y, design)

fit <- glmFit(y, design)
lrt <- glmLRT(fit, coef=2)
topTags(lrt)
#> Coefficient:  xTrt
#>                         logFC     logCPM       LR       PValue          FDR
#> ENSDARG00000000906 -13.139604  1.3700668 41.83002 9.956317e-11 2.077386e-06
#> ENSDARG00000086720  12.005538  0.6073574 37.82422 7.741477e-10 6.213996e-06
#> ENSDARG00000040816 -15.428881 -0.3395098 37.28853 1.018820e-09 6.213996e-06
#> ENSDARG00000052057  -8.753810  6.0407525 36.98359 1.191276e-09 6.213996e-06
#> ENSDARG00000026651   9.170093  3.2087681 32.92226 9.591874e-09 4.002689e-05
#> ENSDARG00000091974 -11.869696  1.5354803 32.09026 1.471735e-08 5.117959e-05
#> ENSDARG00000094510   8.992612  1.6823082 30.89895 2.718186e-08 8.102135e-05
#> ENSDARG00000069293 -10.447635  0.2042986 30.47848 3.375904e-08 8.804781e-05
#> ENSDARG00000088842   9.993287  0.9907429 30.01954 4.277156e-08 9.915874e-05
#> ENSDARG00000041516   7.747856  7.8305044 28.67447 8.562500e-08 1.786566e-04
```

## 2.4 Empirical control genes

If no genes are known *a priori* not to be influenced by the covariates of interest, one can obtain a set of “in-silico empirical” negative controls, e.g., least significantly DE genes based on a first-pass DE analysis performed prior to RUVg normalization.

```
design <- model.matrix(~x, data=pData(set))
y <- DGEList(counts=counts(set), group=x)
y <- calcNormFactors(y, method="upperquartile")
y <- estimateGLMCommonDisp(y, design)
y <- estimateGLMTagwiseDisp(y, design)

fit <- glmFit(y, design)
lrt <- glmLRT(fit, coef=2)

top <- topTags(lrt, n=nrow(set))$table
empirical <- rownames(set)[which(!(rownames(set) %in% rownames(top)[1:5000]))]
```

Here, we consider all but the top \(5{,}000\) genes as ranked by
*edgeR* \(p\)-values.

```
set2 <- RUVg(set, empirical, k=1)
pData(set2)
#>         x         W_1
#> Ctl1  Ctl -0.10879677
#> Ctl3  Ctl  0.23066424
#> Ctl5  Ctl  0.19926266
#> Trt9  Trt  0.07672121
#> Trt11 Trt -0.83540924
#> Trt13 Trt  0.43755790
plotRLE(set2, outline=FALSE, ylim=c(-4, 4), col=colors[x])
```

![](data:image/png;base64...)

```
plotPCA(set2, col=colors[x], cex=1.2)
```

![](data:image/png;base64...)

## 2.5 Differential expression analysis with *DESeq2*

In alternative to *edgeR*, one can perform differential expression analysis with *DESeq2*. The approach is very similar, namely, we will use the same design matrix, but we need to specify it within the *DESeqDataSet* object.

```
library(DESeq2)
dds <- DESeqDataSetFromMatrix(countData = counts(set1),
                              colData = pData(set1),
                              design = ~ W_1 + x)
dds <- DESeq(dds)
#> estimating size factors
#> estimating dispersions
#> gene-wise dispersion estimates
#> mean-dispersion relationship
#> final dispersion estimates
#> fitting model and testing
res <- results(dds)
res
#> log2 fold change (MLE): x Trt vs Ctl
#> Wald test p-value: x Trt vs Ctl
#> DataFrame with 20865 rows and 6 columns
#>                     baseMean log2FoldChange     lfcSE       stat    pvalue
#>                    <numeric>      <numeric> <numeric>  <numeric> <numeric>
#> ENSDARG00000000001   232.866      0.8786748  1.389381  0.6324219  0.527111
#> ENSDARG00000000002   499.660      0.8482861  1.250605  0.6783007  0.497581
#> ENSDARG00000000018   467.170      0.9994368  0.926668  1.0785271  0.280799
#> ENSDARG00000000019  6959.358      0.0483696  1.061977  0.0455468  0.963671
#> ENSDARG00000000068   108.518      0.1188108  1.411262  0.0841876  0.932907
#> ...                      ...            ...       ...        ...       ...
#> ERCC-00163           137.567     -1.0762878  1.189237 -0.9050240 0.3654527
#> ERCC-00164            80.339     -1.1169190  2.035970 -0.5485930 0.5832848
#> ERCC-00165           142.686      0.0418648  1.385185  0.0302233 0.9758890
#> ERCC-00170           314.887      1.8354418  1.027683  1.7859999 0.0740993
#> ERCC-00171         26113.478      1.7594758  0.943496  1.8648473 0.0622028
#>                         padj
#>                    <numeric>
#> ENSDARG00000000001  0.902319
#> ENSDARG00000000002  0.891360
#> ENSDARG00000000018  0.768956
#> ENSDARG00000000019  0.996814
#> ENSDARG00000000068  0.992634
#> ...                      ...
#> ERCC-00163          0.830022
#> ERCC-00164          0.920096
#> ERCC-00165          0.998801
#> ERCC-00170          0.495916
#> ERCC-00171          0.462520
```

Note that this will perform by default a Wald test of significance of the last variable in the design formula, in this case \(x\). If one wants to perform a likelihood ratio test, she needs to specify a reduced model that includes \(W\) (see the *DESeq2* vignette for more details on the test statistics).

```
dds <- DESeq(dds, test="LRT", reduced=as.formula("~ W_1"))
res <- results(dds)
```

# 3 RUVs: Estimating the factors of unwanted variation using replicate samples}

As an alternative approach, one can use the *RUVs* method to
estimate the factors of unwanted variation using replicate/negative control samples for which the covariates of interest are constant.

First, we need to construct a matrix specifying the replicates. In
the case of the zebrafish dataset, we can consider the three treated
and the three control samples as replicate groups. The function *makeGroups* can be used.

```
differences <- makeGroups(x)
differences
#>      [,1] [,2] [,3]
#> [1,]    1    2    3
#> [2,]    4    5    6
```

Although in principle one still needs control genes for the estimation
of the factors of unwanted variation, we found that *RUVs* is robust to that choice and that using all the genes works
well in practice (Risso et al. [2014](#ref-risso2013ruv)).

```
set3 <- RUVs(set, genes, k=1, differences)
pData(set3)
#>         x        W_1
#> Ctl1  Ctl  0.1860825
#> Ctl3  Ctl  0.4917394
#> Ctl5  Ctl  0.4926805
#> Trt9  Trt  0.4279274
#> Trt11 Trt -0.5784460
#> Trt13 Trt  0.7289145
```

# 4 RUVr: Estimating the factors of unwanted variation using residuals

Finally, a third approach is to consider the residuals (e.g., deviance residuals) from a first-pass GLM regression of the counts on the covariates of interest. This can be achieved with the *RUVr* method.

First, we need to compute the residuals from the GLM fit, without RUVg normalization, but possibly after normalization using a method such as upper-quartile normalization.

```
design <- model.matrix(~x, data=pData(set))
y <- DGEList(counts=counts(set), group=x)
y <- calcNormFactors(y, method="upperquartile")
y <- estimateGLMCommonDisp(y, design)
y <- estimateGLMTagwiseDisp(y, design)

fit <- glmFit(y, design)
res <- residuals(fit, type="deviance")
```

Again, we can use all the genes to estimate the factors of unwanted
variation.

```
set4 <- RUVr(set, genes, k=1, res)
```

# 5 Session info

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
#>  [1] DESeq2_1.50.0               RColorBrewer_1.1-3
#>  [3] zebrafishRNASeq_1.29.0      RUVSeq_1.44.0
#>  [5] edgeR_4.8.0                 limma_3.66.0
#>  [7] EDASeq_2.44.0               ShortRead_1.68.0
#>  [9] GenomicAlignments_1.46.0    SummarizedExperiment_1.40.0
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] Rsamtools_2.26.0            GenomicRanges_1.62.0
#> [15] Biostrings_2.78.0           Seqinfo_1.0.0
#> [17] XVector_0.50.0              IRanges_2.44.0
#> [19] S4Vectors_0.48.0            BiocParallel_1.44.0
#> [21] Biobase_2.70.0              BiocGenerics_0.56.0
#> [23] generics_0.1.4              BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] DBI_1.2.3              bitops_1.0-9           deldir_2.0-4
#>  [4] httr2_1.2.1            biomaRt_2.66.0         rlang_1.1.6
#>  [7] magrittr_2.0.4         compiler_4.5.1         RSQLite_2.4.3
#> [10] GenomicFeatures_1.62.0 png_0.1-8              vctrs_0.6.5
#> [13] stringr_1.5.2          pwalign_1.6.0          pkgconfig_2.0.3
#> [16] crayon_1.5.3           fastmap_1.2.0          dbplyr_2.5.1
#> [19] magick_2.9.0           rmarkdown_2.30         tinytex_0.57
#> [22] bit_4.6.0              xfun_0.53              cachem_1.1.0
#> [25] cigarillo_1.0.0        jsonlite_2.0.0         progress_1.2.3
#> [28] blob_1.2.4             DelayedArray_0.36.0    jpeg_0.1-11
#> [31] parallel_4.5.1         prettyunits_1.2.0      R6_2.6.1
#> [34] bslib_0.9.0            stringi_1.8.7          rtracklayer_1.70.0
#> [37] jquerylib_0.1.4        Rcpp_1.1.0             bookdown_0.45
#> [40] knitr_1.50             R.utils_2.13.0         Matrix_1.7-4
#> [43] tidyselect_1.2.1       dichromat_2.0-0.1      abind_1.4-8
#> [46] yaml_2.3.10            codetools_0.2-20       hwriter_1.3.2.1
#> [49] curl_7.0.0             lattice_0.22-7         tibble_3.3.0
#> [52] S7_0.2.0               KEGGREST_1.50.0        evaluate_1.0.5
#> [55] BiocFileCache_3.0.0    pillar_1.11.1          BiocManager_1.30.26
#> [58] filelock_1.0.3         RCurl_1.98-1.17        ggplot2_4.0.0
#> [61] hms_1.1.4              scales_1.4.0           glue_1.8.0
#> [64] tools_4.5.1            interp_1.1-6           BiocIO_1.20.0
#> [67] locfit_1.5-9.12        XML_3.99-0.19          grid_4.5.1
#> [70] latticeExtra_0.6-31    AnnotationDbi_1.72.0   restfulr_0.0.16
#> [73] cli_3.6.5              rappdirs_0.3.3         S4Arrays_1.10.0
#> [76] dplyr_1.1.4            gtable_0.3.6           R.methodsS3_1.8.2
#> [79] sass_0.4.10            digest_0.6.37          aroma.light_3.40.0
#> [82] SparseArray_1.10.0     farver_2.1.2           rjson_0.2.23
#> [85] memoise_2.0.1          htmltools_0.5.8.1      R.oo_1.27.1
#> [88] lifecycle_1.0.4        httr_1.4.7             statmod_1.5.1
#> [91] bit64_4.6.0-1          MASS_7.3-65
```

# References

Bullard, J., E. Purdom, K. Hansen, and S. Dudoit. 2010. “Evaluation of Statistical Methods for Normalization and Differential Expression in mRNA-Seq Experiments.” *BMC Bioinformatics* 11 (1): 94.

Ferreira, T., S. R. Wilson, Y. G. Choi, D. Risso, S. Dudoit, T. P. Speed, and J. Ngai. 2014. “Silencing of Odorant Receptor Genes by G Protein \(\beta\gamma\) Signaling Ensures the Expression of One Odorant Receptor Per Olfactory Sensory Neuron.” *Neuron* 81: 847–59.

Gagnon-Bartsch, J., L. Jacob, and T. P. Speed. 2013. “Removing Unwanted Variation from High Dimensional Data with Negative Controls.” 820. Department of Statistics, University of California, Berkeley.

Gagnon-Bartsch, J., and T. P. Speed. 2012. “Using Control Genes to Correct for Unwanted Variation in Microarray Data.” *Biostatistics* 13 (3): 539–52.

McCullagh, P, and JA Nelder. 1989. *Generalized Linear Models*. New York: Chapman; Hall.

Risso, D., J. Ngai, T. P. Speed, and S. Dudoit. 2014. “Normalization of RNA-seq Data Using Factor Analysis of Control Genes or Samples.” *Nature Biotechnology*.