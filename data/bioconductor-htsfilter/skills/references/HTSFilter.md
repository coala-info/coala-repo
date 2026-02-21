# *HTSFilter* package: Quick-start guide

Andrea Rau1\*, Mélina Gallopin, Gilles Celeux and Florence Jaffrézic

1INRAE

\*andrea.rau@inrae.fr

#### 2025-10-30

#### Package

HTSFilter 1.50.0

This vignette illustrates the use of the *HTSFilter* package to filter
replicated data from transcriptome sequencing experiments (e.g., RNA sequencing
data) for a variety of different data classes: `matrix`,
`data.frame`, the S3 classes associated with the *edgeR* package (`DGEExact`
and `DGELRT`), and the S4 class associated with the *DESeq2* package
(`DESeqDataSet`).

# 1 Introduction

High-throughput sequencing (HTS) data, such as RNA-sequencing (RNA-seq) data,
are increasingly used to conduct differential analyses, in which statistical
tests are performed for each biological feature (e.g., a gene, transcript, exon)
in order to identify those whose expression levels show systematic covariation
with a particular condition, such as a treatment or phenotype of interest.
For the remainder of this vignette, we will focus on gene-level differential
analyses, although these methods may also be applied to differential analyses
of (count-based measures of) transcript- or exon-level expression.

Because hypothesis tests are performed for gene-by-gene differential analyses,
the obtained \(p\)-values must be adjusted to correct for multiple testing.
However, procedures to adjust \(p\)-values to control the number of detected
false positives often lead to a loss of power to detect truly differentially
expressed (DE) genes due to the large number of hypothesis tests performed.
To reduce the impact of such procedures, independent data filters are often
used to identify and remove genes that appear to generate an uninformative
signal (Bourgon, Gentleman, and Huber [2010](#ref-Bourgon2010)); this in turn moderates the correction needed to adjust
for multiple testing. For independent filtering methods for microarray data,
see for example the
[*genefilter*](https://bioconductor.org/packages/release/bioc/html/genefilter.html)
Bioconductor package (Gentleman et al. [2020](#ref-Gentleman)).

The *HTSFilter* package implements a novel data-based filtering procedure
based on the calculation of a similarity index among biological replicates
for read counts arising from replicated transcriptome sequencing (RNA-seq)
data. This technique provides an intuitive data-driven way to filter
high-throughput transcriptome sequencing data and to effectively remove genes
with low, constant expression levels without incorrectly removing those that
would otherwise have been identified as DE. The two fundamental assumptions of
the filter implemented in the *HTSFilter* package are as follows:

* Biological replicates are present for each experimental condition, and
* Data can be appropriately normalized (scaled) to correct for systematic
  inter-sample biases.

Assuming these conditions hold, *HTSFilter* implements a method to identify a
filtering threshold that maximizes the *filtering similarity* among replicates,
that is, one where most genes tend to either have normalized counts less than
or equal to the cutoff in all samples (i.e., filtered genes) or greater than
the cutoff in all samples (i.e., non-filtered genes). This filtering similarity
is defined using the global Jaccard index, that is, the average Jaccard index
calculated between pairs of replicates within each experimental condition;
see Rau et al. ([2013](#ref-Rau2012a)) for more details.

For more information about between-sample normalization strategies, see
Dillies et al. ([2013](#ref-Dillies2012)); in particular, strategies for normalizing data with differences
in library size and composition may be found in Anders and Huber ([2010](#ref-Anders2010)) and Robinson and Oshlack ([2010](#ref-Robinson2010)),
and strategies for normalizing data exhibiting sample-specific biases due to
GC content may be found in Risso et al. ([2011](#ref-Risso2011)) and Hansen, Irizarry, and Wu ([2012](#ref-Hansen2012)). Within the *HTSFilter*
package, the Trimmed Means of M-values (TMM) (Robinson and Oshlack [2010](#ref-Robinson2010)) and DESeq
(Anders and Huber [2010](#ref-Anders2010)) normalization strategies may be used prior to calculating an
appropriate data-based filter. If an alternative normalization strategy is
needed or desired, the normalization may be applied prior to filtering the
data with `normalization="none"`in the `HTSFilter` function;
see Section [4](#edaseqnorm) for an example.

The *HTSFilter* package is able to accommodate unnormalized or normalized
replicated count data in the form of a `matrix` or `data.frame` (in which each
row corresponds to a biological feature and each column to a biological
sample), one of the S3 classes associated with the *edgeR* package (`DGEList`,
`DGEExact`, `DGEGLM`, and `DGELRT`), or `DESeqDataSet` (the S4 class associated
with the *DESeq2* package), as illustrated in the following sections.

Finally, we note that the filtering method implemented in the *HTSFilter*
package is designed to filter transcriptome sequencing, and not microarray,
data; in particular, the proposed filter is effective for data with features
that take on values over a large order of magnitude and with a subset of
features exhibiting small levels of expression across samples (see, for example,
Figure [1](#fig:loadingPackages)). In this vignette, we illustrate its use on
count-based measures of gene expression, although its use is not strictly
limited to discrete data.

# 2 Input data

For the purposes of this vignette, we make use of data from a study of
sex-specific expression of liver cells in human and the *DESeq2* and *edgeR*
packages for differential analysis. Sultan et al. ([2008](#ref-Sultan2008)) obtained a high-throughput
sequencing data (using a 1G Illumina Genome Analyzer sequencing machine) from a
human embryonic kidney and a B cell line, with two biological replicates each.
The raw read counts and phenotype tables were obtained from the ReCount online
resource (Frazee, Langmead, and Leek [2011](#ref-Frazee2011)).

To begin, we load the *HTSFilter* package, attach the gene-level count
data contained in `sultan`, and take a quick look at a histrogram of gene counts:

```
library(HTSFilter)
library(edgeR)
library(DESeq2)
data("sultan")
hist(log(exprs(sultan)+1), col="grey", breaks=25, main="",
  xlab="Log(counts+1)")
```

![Histogram of log transformed counts from the Sultan data. This illustrates the large number of genes with very small counts as well as the large heterogeneity in counts observed.](data:image/png;base64...)

Figure 1: Histogram of log transformed counts from the Sultan data
This illustrates the large number of genes with very small counts as well as the large heterogeneity in counts observed.

```
pData(sultan)
```

```
##           sample.id num.tech.reps    cell.line
## SRX008333 SRX008333             1 Ramos B cell
## SRX008334 SRX008334             1 Ramos B cell
## SRX008331 SRX008331             1      HEK293T
## SRX008332 SRX008332             1      HEK293T
```

```
dim(sultan)
```

```
## Features  Samples
##     9010        4
```

The unfiltered data contain 9010 genes in four samples (two replicates per
condition).

# 3 Use of *HTSFilter* with varying data types

## 3.1 `matrix` and `data.frame` classes

To filter high-throughput sequencing data in the form of a `matrix` or
`data.frame`, we first access the expression data, contained in `exprs(sultan)`,
and create a vector identifying the condition labels for each of the samples
via the `pData` *Biobase* function. We then filter the data using the
`HTSFilter` function, specifying that the number of tested thresholds be only 25
(`s.len=25`) rather than the default value of 100 to reduce computation time
for this example. Note that as it is unspecified, the default normalization
method is used for filtering the data, namely the Trimmed Mean of M-values
(TMM) method of Robinson and Oshlack ([2010](#ref-Robinson2010)). To use the DESeq normalization method
(Anders and Huber [2010](#ref-Anders2010)) `normalization="DESeq"` may be specified.

```
mat <- exprs(sultan)
conds <- as.character(pData(sultan)$cell.line)

## Only 25 tested thresholds to reduce computation time
filter <- HTSFilter(mat, conds, s.min=1, s.max=200, s.len=25)
```

![Global Jaccard index for the Sultan data. The index is calculated for a variety of threshold values after TMM normalization, with a loess curve (blue line) superposed and data-based threshold values (red cross and red dotted line) equal to 11.764.](data:image/png;base64...)

Figure 2: Global Jaccard index for the Sultan data
The index is calculated for a variety of threshold values after TMM normalization, with a loess curve (blue line) superposed and data-based threshold values (red cross and red dotted line) equal to 11.764.

```
mat <- filter$filteredData
dim(mat)
```

```
## [1] 4995    4
```

```
dim(filter$removedData)
```

```
## [1] 4015    4
```

For this example, we find a data-based threshold equal to 11.764; genes with
normalized values less than this threshold in all samples are filtered from
subsequent analyses. The proposed filter thus removes 4015 genes from further
analyses, leaving 4995 genes.

We note that an important part of the filter proposed in the *HTSFilter*
package is a check of the behavior of the global similarity index calculated
over a range of threshold values, and in particular, to verify that a
reasonable maximum value is reached for the global similarity index over the
range of tested threshold values (see Figure [2](#fig:matrix)); the maximum
possible value for the global Jaccard index is nearly 1. To illustrate the
importance of this check, we attempt to re-apply the proposed filter to the
previously filtered data (in practice, of course, this would be nonsensical):

```
par(mfrow = c(1,2), mar = c(4,4,2,2))
filter.2 <- HTSFilter(mat, conds, s.len=25)
dim(filter.2$removedData)
```

```
## [1] 0 4
```

```
hist(log(filter.2$filteredData+1), col="grey", breaks=25, main="",
  xlab="Log(counts+1)")
```

![HTSFilter on pre-filtered Sultan data. (left) The global Jaccard index on the pre-filtered data is calculated for a variety of threshold values after TMM normalization, with a loess curve (blue line) superposed and data-based threshold values (red cross and red dotted line) equal to 1.64. (right) Histogram of the re-filtered data after applying HTSFilter.](data:image/png;base64...)

Figure 3: HTSFilter on pre-filtered Sultan data
(left) The global Jaccard index on the pre-filtered data is calculated for a variety of threshold values after TMM normalization, with a loess curve (blue line) superposed and data-based threshold values (red cross and red dotted line) equal to 1.64. (right) Histogram of the re-filtered data after applying HTSFilter.

In the lefthand panel of Figure [3](#fig:refilter), we note a plateau of large
global Jaccard index values for thresholds less than 2, with a decrease
thereafter; this corresponds to filtering no genes, unsurprising given that
genes with low, constant levels of expression have already been filtered from
the analysis (see the righthand panel of Figure [3](#fig:refilter)).

## 3.2 *edgeR* package pipeline

We next illustrate the use of *HTSFilter* within the *edgeR* pipeline
for differential analysis (S3 classes `DGEList`, `DGEExact`, `DGEGLM`, or
`DGELRT`). For the purposes of this vignette, we will consider the S3 classes
`DGEExact` and `DGELRT`. The former is the class containing the results of the
differential expression analysis between two groups of count libraries
(resulting from a call to the function `exactTest` in *edgeR*); the latter is
the class containing the results of a generalized linear model (GLM)-based
differential analysis (resulting from a call to the function `glmLRT` in
*edgeR*). Although the filter may be applied earlier in the *edgeR*
pipeline (i.e., to objects of class `DGEList` or `DGEGLM`), we do not
recommend doing so, as parameter estimation makes use of counts adjusted
using a quantile-to-quantile method (pseudo-counts).

### 3.2.1 S3 class `DGEExact`

We first coerce the data into the appropriate class with the function
`DGEList`, where the `group` variable is set to contain a vector of
condition labels for each of the samples. Next, after calculating normalizing
factors to scale library sizes (`calcNormFactors`), we estimate common and
tagwise dispersion parameters using `estimateDisp` (using the quantile
conditional likelihood for each gene) and obtain differential analysis
results using `exactTest`. Finally, we apply the filter using the `HTSFilter`
function, again specifying that the number of tested thresholds be only 25
(`s.len=25`) rather than the default value of 100. Note that as it is
unspecified, the default normalization method is used for filtering the data,
namely the Trimmed Mean of M-values (TMM) method (Robinson and Oshlack [2010](#ref-Robinson2010)); alternative
normalization, including `"pseudo.counts"` for the quantile-to-quantile
adjusted counts used for parameter estimation, may also be specified.
We suppress the plot of the global Jaccard index below using
`plot = FALSE`, as it is identical to that shown in Figure [2](#fig:matrix).

```
dge <- DGEList(counts=exprs(sultan), group=conds)
dge <- calcNormFactors(dge)
dge <- estimateDisp(dge)
```

```
## Using classic mode.
```

```
et <- exactTest(dge)
et <- HTSFilter(et, DGEList=dge, s.len=25, plot=FALSE)$filteredData
dim(et)
```

```
## [1] 4995    3
```

```
class(et)
```

```
## [1] "DGEExact"
## attr(,"package")
## [1] "edgeR"
```

```
topTags(et)
```

```
## Comparison of groups:  Ramos B cell-HEK293T
##                      logFC   logCPM        PValue           FDR
## ENSG00000133124 -14.394459 11.56789  0.000000e+00  0.000000e+00
## ENSG00000105369  11.925777 11.23367  0.000000e+00  0.000000e+00
## ENSG00000100721  14.399258 11.53328 5.859619e-321 9.756265e-318
## ENSG00000135144  10.921892 11.05896 2.576238e-310 3.217078e-307
## ENSG00000111348  13.797193 10.92306 1.025378e-298 1.024353e-295
## ENSG00000110777  13.850498 10.97744 7.972681e-273 6.637257e-270
## ENSG00000118308  13.494133 10.61473 3.403410e-271 2.428576e-268
## ENSG00000177606  -9.731884 10.81415 3.223707e-266 2.012802e-263
## ENSG00000012124  10.171667 10.29617 9.607857e-250 5.332360e-247
## ENSG00000149418  10.899596 10.19056 3.325484e-231 1.661079e-228
```

Note that the filtered data are of the class `DGEExact`, allowing for a call
to the `topTags` function.

```
topTags(et)
```

```
## Comparison of groups:  Ramos B cell-HEK293T
##                      logFC   logCPM        PValue           FDR
## ENSG00000133124 -14.394459 11.56789  0.000000e+00  0.000000e+00
## ENSG00000105369  11.925777 11.23367  0.000000e+00  0.000000e+00
## ENSG00000100721  14.399258 11.53328 5.859619e-321 9.756265e-318
## ENSG00000135144  10.921892 11.05896 2.576238e-310 3.217078e-307
## ENSG00000111348  13.797193 10.92306 1.025378e-298 1.024353e-295
## ENSG00000110777  13.850498 10.97744 7.972681e-273 6.637257e-270
## ENSG00000118308  13.494133 10.61473 3.403410e-271 2.428576e-268
## ENSG00000177606  -9.731884 10.81415 3.223707e-266 2.012802e-263
## ENSG00000012124  10.171667 10.29617 9.607857e-250 5.332360e-247
## ENSG00000149418  10.899596 10.19056 3.325484e-231 1.661079e-228
```

### 3.2.2 S3 class `DGELRT`

We follow the same steps as the previous example, where the `estimateDisp`
function is now used to obtain per-gene dispersion parameter estimates using
the adjusted profile loglikelihood, the `glmFit` function is used to fit a
negative binomial generalized log-linear model to the read counts for each
gene, and the `glmLRT` function is used to conduct likelihood ratio tests for
one or more coefficients in the GLM. The output of `glmLRT` is an S3 object of
class `DGELRT` and contains the GLM differential analysis results.
As before, we apply the filter using the `HTSFilter` function, again
suppressing the plot of the global Jaccard index using ,
as it is identical to that shown in Figure [2](#fig:matrix).

```
design <- model.matrix(~conds)
dge <- DGEList(counts=exprs(sultan), group=conds)
dge <- calcNormFactors(dge)
dge <- estimateDisp(dge, design)
fit <- glmFit(dge,design)
lrt <- glmLRT(fit,coef=2)
lrt <- HTSFilter(lrt, DGEGLM=fit, s.len=25, plot=FALSE)$filteredData
dim(lrt)
```

```
## [1] 4995    4
```

```
class(lrt)
```

```
## [1] "DGELRT"
## attr(,"package")
## [1] "edgeR"
```

Note that the filtered data are of the class `DGEList`, allowing for a call
to the `topTags` function.

```
topTags(lrt)
```

```
## Coefficient:  condsRamos B cell
##                      logFC   logCPM       LR        PValue           FDR
## ENSG00000100721  14.399262 11.53265 1564.261  0.000000e+00  0.000000e+00
## ENSG00000133124 -14.394460 11.56849 1575.589  0.000000e+00  0.000000e+00
## ENSG00000105369  11.925775 11.23291 1606.961  0.000000e+00  0.000000e+00
## ENSG00000135144  10.921895 11.05814 1503.659  0.000000e+00  0.000000e+00
## ENSG00000111348  13.797196 10.92217 1472.384 3.903119e-322 3.899215e-319
## ENSG00000118308  13.494129 10.61369 1339.872 2.446675e-293 2.036857e-290
## ENSG00000110777  13.850504 10.97659 1335.498 2.183233e-292 1.557893e-289
## ENSG00000177606  -9.731884 10.81502 1237.613 4.084109e-271 2.550016e-268
## ENSG00000012124  10.171668 10.29498 1215.384 2.766166e-266 1.535222e-263
## ENSG00000149418  10.899601 10.18933 1131.952 3.752668e-248 1.874457e-245
```

## 3.3 *DESeq2* package pipeline: S4 class `DESeqDataSet`}

The *HTSFilter* package allows for a straightforward integration within the
*DESeq2* analysis pipeline, most notably allowing for \(p\)-values to be
adjusted only for those genes passing the filter. Note that *DESeq2* now
implements an independent filtering procedure by default in the `results`
function; this filter is a potential alternative filtering technique and does
not need to be used in addition to the one included in *HTSFilter*. In fact,
each filter is targeting the same weakly expressed genes to be filtered from
the analysis. As such, if the user wishes to make use of *HTSFilter* within
the *DESeq2* pipeline, the argument `independentFiltering=FALSE` should be
used when calling the `results` function in *DESeq2*.

To illustrate the application of a filter for high-throughput sequencing data
in the form of a `DESeqDataSet` (the class used within the *DESeq2* pipeline
for differential analysis), we coerce `sultan` into an object of the class
`DESeqDataSet` using the function `DESeqDataSetFromMatrix`. Once again,
we specify that the number of tested thresholds be only 25 (`s.len=25`)
rather than the default value of 100 to reduce computation time.
or objects in the form of a `DESeqDataSet`, the default normalization
strategy is `"DESeq"`, although alternative normalization strategies may also
be used. Note that below we replace the spaces in condition names with “.”
prior to creating a `"DESeqDataSet"` object.

```
conds <- gsub(" ", ".", conds)
dds <- DESeqDataSetFromMatrix(countData = exprs(sultan),
                              colData = data.frame(cell.line = factor(conds)),
                              design = ~ cell.line)
dds <- DESeq(dds)
```

```
## estimating size factors
```

```
## estimating dispersions
```

```
## gene-wise dispersion estimates
```

```
## mean-dispersion relationship
```

```
## final dispersion estimates
```

```
## fitting model and testing
```

```
filter <- HTSFilter(dds, s.len=25, plot=FALSE)$filteredData
class(filter)
```

```
## [1] "DESeqDataSet"
## attr(,"package")
## [1] "DESeq2"
```

```
dim(filter)
```

```
## [1] 5143    4
```

```
res <- results(filter, independentFiltering=FALSE)
head(res)
```

```
## log2 fold change (MLE): cell.line Ramos.B.cell vs HEK293T
## Wald test p-value: cell.line Ramos.B.cell vs HEK293T
## DataFrame with 6 rows and 6 columns
##                  baseMean log2FoldChange     lfcSE      stat      pvalue
##                 <numeric>      <numeric> <numeric> <numeric>   <numeric>
## ENSG00000000003  15.49081      -7.226373  1.579373 -4.575469 4.75154e-06
## ENSG00000000419  15.41426       0.952434  0.718812  1.325012 1.85167e-01
## ENSG00000000457  18.49191      -0.887415  0.653819 -1.357280 1.74692e-01
## ENSG00000000460   9.70452       0.289614  0.874092  0.331331 7.40395e-01
## ENSG00000001036   7.84776      -6.245476  1.701730 -3.670075 2.42479e-04
## ENSG00000001167  77.33272      -0.372907  0.323513 -1.152680 2.49042e-01
##                        padj
##                   <numeric>
## ENSG00000000003 2.75504e-05
## ENSG00000000419 2.90428e-01
## ENSG00000000457 2.77505e-01
## ENSG00000000460 8.23853e-01
## ENSG00000001036 9.16964e-04
## ENSG00000001167 3.64284e-01
```

The filtered data remain an object of class `DESeqDataSet`, and subsequent
functions from *DESeq2* (such as the results summary function )
may be called directly upon it.

# 4 Alternative normalization using *EDAseq*

As a final example, we illustrate the use of the *HTSFilter* package with an
alternative normalization strategy, namely the full quantile normalization
method in the *EDAseq* package; such a step may be useful when the TMM or
DESeq normalization methods are not appropriate for a given dataset. Once
again, we create a new object of the appropriate class with the function
`newSeqExpressionSet` and normalize data using the `betweenLaneNormalization`
function (with `which="full"`) in *EDAseq*.

```
library(EDASeq)
ses <- newSeqExpressionSet(exprs(sultan),
       phenoData=pData(sultan))
ses.norm <- betweenLaneNormalization(ses, which="full")
```

Subsequently, `HTSFilter` is applied to the normalized data (again using
`s.len=25`), and the normalization method is set to `norm="none"`. We may then
make use of the `on` vector in the results, which identifies filtered and
unfiltered genes (respectively) with 0 and 1, to identify rows in the original
data matrix to be retained.

```
filter <- HTSFilter(counts(ses.norm), conds, s.len=25, norm="none",
          plot=FALSE)
head(filter$on)
table(filter$on)
```

# 5 Session Info

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
##  [1] DESeq2_1.50.0               SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [5] matrixStats_1.5.0           GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              edgeR_4.8.0
## [13] limma_3.66.0                HTSFilter_1.50.0
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         SparseArray_1.10.0  lattice_0.22-7
##  [4] magrittr_2.0.4      digest_0.6.37       RColorBrewer_1.1-3
##  [7] evaluate_1.0.5      grid_4.5.1          bookdown_0.45
## [10] fastmap_1.2.0       jsonlite_2.0.0      Matrix_1.7-4
## [13] tinytex_0.57        BiocManager_1.30.26 scales_1.4.0
## [16] codetools_0.2-20    jquerylib_0.1.4     abind_1.4-8
## [19] cli_3.6.5           rlang_1.1.6         XVector_0.50.0
## [22] cachem_1.1.0        DelayedArray_0.36.0 yaml_2.3.10
## [25] S4Arrays_1.10.0     tools_4.5.1         parallel_4.5.1
## [28] BiocParallel_1.44.0 dplyr_1.1.4         ggplot2_4.0.0
## [31] locfit_1.5-9.12     vctrs_0.6.5         R6_2.6.1
## [34] magick_2.9.0        lifecycle_1.0.4     pkgconfig_2.0.3
## [37] pillar_1.11.1       bslib_0.9.0         gtable_0.3.6
## [40] glue_1.8.0          Rcpp_1.1.0          statmod_1.5.1
## [43] tidyselect_1.2.1    tibble_3.3.0        xfun_0.53
## [46] dichromat_2.0-0.1   knitr_1.50          farver_2.1.2
## [49] htmltools_0.5.8.1   rmarkdown_2.30      compiler_4.5.1
## [52] S7_0.2.0
```

# References

Anders, Simon, and Wolfgang Huber. 2010. “Differential Expression Analysis for Sequence Count Data.” *Genome Biology* 11 (R106): 1–28.

Bourgon, Richard, Robert Gentleman, and Wolfgang Huber. 2010. “Independent Filtering Increases Detection Power for High-Throughput Experiments.” *PNAS* 107 (21): 9546–51.

Dillies, Marie-Agnès, Andrea Rau, Julie Aubert, Christelle Hennequet-Antier, Marine Jeanmougin, Nicolas Servant, Céline Keime, et al. 2013. “A comprehensive evaluation of normalization methods for Illumina high-throughput RNA sequencing data analysis.” *Briefings in Bioinformatics* 14 (6): 671–83.

Frazee, A. C., B. Langmead, and J. T. Leek. 2011. “ReCount: a multi-experiment resource of analysis-ready RNA-seq gene count datasets.” *BMC Bioinformatics* 12 (449).

Gentleman, R., V. Carey, W. Huber, and F. Hahne. 2020. *genefilter: methods for filtering genes from microarray experiments*.

Hansen, Kasper D., Rafael A. Irizarry, and Zhijin Wu. 2012. “Removing technical variability in RNA-seq data using conditional quantile normalization.” *Biostatistics* 13 (2): 204–16.

Rau, A., M. Gallopin, G. Celeux, and F. Jaffrézic. 2013. “Data-Based Filtering for Replicated High-Throughput Transcriptome Sequencing Experiments.” *Bioinformatics* 29 (17): 2146–52.

Risso, Davide, Katja Schwartz, Gavin Sherlock, and Sandrine Dudoit. 2011. “GC-content normalization for RNA-seq data.” *BMC Bioinformatics* 12 (480).

Robinson, Mark D., and Alicia Oshlack. 2010. “A scaling normalization method for differential expression analysis of RNA-seq data.” *Genome Biology* 11 (R25).

Sultan, M., M. H. Schulz, H. Richard, A. Magen, A. Klingenhoff, M. Scherf, M. Seifert, et al. 2008. “A Global View of Gene Activity and Alternative Splicing by Deep Sequencing of the Human Transcriptome.” *Science* 15 (5891): 956–60.