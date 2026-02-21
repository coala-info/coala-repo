Code

* Show All Code
* Hide All Code

# The cytoKernel user’s guide

Tusharkanti Ghosh1, Victor Lui2, Pratyaydipta Rudra3, Souvik Seal1, Thao Vu1, Elena Hsieh2 and Debashis Ghosh1

1Colorado School of Public Health
2University of Colorado, Anschutz Medical Campus, School of Medicine
3Oklahoma State University

#### 29 October 2025

#### Abstract

cytoKernel (Differential Expression Analysis using Kernel-based Score test) is a nonlinear method based approach that detects differentially expressed features for high-dimensional biological data.

#### Package

cytoKernel 1.16.0

---

# 1 Introduction

The majority of statistical strategies used in differential expression analysis of high-dimensional biological data (e.g., gene expression, CyTOF) are based on linear models or (analysis of variance). Linear models are favored in many biological problems mainly due to their ease of use and interpretability. However, some biological problems (e.g., gene expression, CyTOF) often require nonlinear models as linear models might be insufficient to capture the relationship among the co-expression features (e.g., relationships among signaling markers within (and across) cell subpopulations in CyTOF data). Kernel-based approaches extend the class of linear models to nonlinear models in a computationally tractable manner. Additionally, kernel-based approaches assume a more general relationship based on a Hilbert space of functions spanned by a certain kernel function instead of assuming a linear functional relationship.

In this vignette, we introduce a differential expression analysis of high-dimensional biological data using kernel based score test, referred to as **kernel-based differential analysis** (**cytoKernel**), which can identify differentially expressed features. The `cytoKernel` R-package contains the `CytoK()` function, which computes the adjusted p value for each feature based on two groups. Further, the package calculates the shrunken effective size and its corresponding effective size standard deviation (sd) using the Adaptive Shrinkage (ash) procedure (Stephens ([2017](#ref-stephens2017false))). We demonstrate with an example data set that the Differential expression analysis using Kernel-based Score test (cytoKernel) procedure can be adapted to flow and mass cytometry experiments along with other biological experiments (e.g., gene expression, RNASeq).

Consider a matrix of order \(p \times n\) with elements \(x\_{ij}\), \(i=1,\dots,p\) and \(j=1,\dots,n\), where \(n\) is the number of samples (Group1+Group2 combined) and \(p\) is the number of features.

We observe the data \(\{x\_{ij},y\_j\}\), where \(x\_{ij}\) is the median intensity for sample \(j\) and feature \(i\). \(y\_j\) (binary response) is the group (or condition) label for sample \(j\) (\(y\_j=0\) (Group1) and \(y\_j=1\) (Group2).

For feature \(i\), \(i=1,\dots,p\), we define a simple logistic (semi-parametric) model,

\[
logit[P(y\_j=1)] = \beta\_0+ f(x\_{ij}),
\]

where \(f(.)\) is a centered smooth function in a Reproducible Kernel Hilbert Space (RKHS) spanned by \(k\).

If \(H\_0:~f(.)=0\), then feature expression value \(x\_{ij}\) is not related to the group labels \(y\_j\) for feature \(i\) i.e., feature \(i\) is differentially expressed.

Let \(K\) be a \(n \times n\) Gram matrix with \(K\_{st}=K\_{\rho}(x\_{sj},~x\_{tj})\). Here, \(k\_{\rho}(.,.)\) is the reproducing kernel of RKHS which contains \(f(.)\) and \(\rho\) is an unknown kernel parameter.

Let \(\mathbf{y}\) be a \(n \times 1\) vector of \(0\) and \(1\). The score test statistic under null hypothesis (\(H\_0:~f(.)=0\)) in the logistic model defined above is,
\[
S(\rho) = \frac{Q(\rho)- \mu\_{Q}}{\sigma\_{Q}},
\]

where \(Q(\rho)=(\mathbf{y}-\mathbf{\hat{\mu\_0}})^{\mathbf{T}}\mathbf{K}(\mathbf{y}-\mathbf{\hat{\mu\_0}})\), \(\mathbf{\hat{\mu\_0}}={logit}^{-1}\hat{\beta\_0}\) and \(\hat{\beta\_0}\) is the estimate of \(\beta\_0\) under null model.

More details about the estimation of \(\mu\_{Q}\), \(\sigma\_{Q}\) and choices of \(\rho\) in (Zhan, Patterson, and Ghosh ([2015](#ref-zhan2015kernel)), Liu, Ghosh, and Lin ([2008](#ref-liu2008estimation)), Davies ([1987](#ref-davies1987hypothesis)).

\(Q(\rho)\) can be rewritten as,
\[
Q(\rho) = \sum\_s {\sum\_t {{k(x\_{is},x\_{it})}(y\_{s}-\hat{\mu\_0})(y\_{t}-\hat{\mu\_0})}},
\]
which is the component-wise product of matrices \(\mathbf{K}\) and \((\mathbf{y}-\mathbf{\hat{\mu\_0}})(\mathbf{y}-\mathbf{\hat{\mu\_0}})^{\mathbf{T}}\).

We use a Gaussian distance based kernel:
\[
k(x\_{is},x\_{it})= exp\left\{-\frac{(x\_{is}-x\_{it})^2}{\rho}\right\}.
\]

\(S(\rho)\) has a Normal distribution for each value of \(\rho\) (Davies ([1987](#ref-davies1987hypothesis))).

The data structure is shown in Figure 1 below.

![Feature-Sample data matrix](data:image/png;base64...)

Figure 1: Feature-Sample data matrix

# 2 Getting Started

Load the package in R

```
library(cytoKernel)
```

# 3 cytoHD Data

The **cytoKernel** package contains a pre-processed median marker expressions data `SummarizedExperiment` assay
object of 126 cluster-marker combinations (features) measured in 8 subjects (4 measured before and 4 upon BCR/FcR-XL stimulation (BCRXL) with B cell receptor/Fc receptor crosslinking for 30’, resulting in a total of 8 samples) from (Bodenmiller et al. ([2012](#ref-bodenmiller2012multiplexed))) that was also used in the CITRUS paper (Bruggner et al. ([2014](#ref-bruggner2014automated))) and `CATALYST` (Crowell et al. ([2020](#ref-crowell2020r))). In this vignette, we only used a subset of the original raw cytometry data downloaded from the Bioconductor data package `HDCytoData` (Weber and Soneson ([2019](#ref-weber2019hdcytodata))) using the command (Bodenmiller\_BCR\_XL\_flowSet()).

## 3.1 cytoHDBMW data pre-processing

The **cytoHDBMW** data in the **cytoKernel** package was pre-processed using the CATALYST Bioconductor package (Crowell et al. ([2020](#ref-crowell2020r))). The data pre-processing include \(4\) steps and
they are as follows:
1. `Creating a SingleCellExperiment Object`: the flowSet data object along with the metadata are converted into a SingleCellExperiment object using the `CATALYST` R/Bioconductor package.
2. `Clustering`: We apply `Louvain` algorithm using the R package `igraph` (Csardi, Nepusz, and others ([2006](#ref-csardi2006igraph))) to cluster the expression values by the state markers (surface markers) (Traag, Waltman, and Van Eck ([2019](#ref-traag2019louvain))).
3. `Median`: Medians are calculated within a cluster for every signaling marker and subject using the `scuttle` Bioconductor
package (McCarthy et al. ([2017](#ref-mccarthy2017scater))).
4. `Aggregating and converting the data`: We convert the aggregated data into a SummarizedExperiment.

```
data("cytoHDBMW")
cytoHDBMW
```

```
## class: SummarizedExperiment
## dim: 126 8
## metadata(0):
## assays(1): exprs
## rownames(126): pNFkB pp38 ... pLat pS6
## rowData names(1): cluster
## colnames(8): Ref1 Ref2 ... BCRXL3 BCRXL4
## colData names(4): sample_id condition patient_id ids
```

# 4 Using the `CytoK()` function

## 4.1 Input for `CytoK()`

The `CytoK()` function must have two object as input:
1. `object`: a data frame or a matrix or a SummarizedExperiment object with abundance measurements of metabolites (features) on the rows and samples (samples) as the columns. `CytoK()` accepts objects which are a data frame or matrix with observations (e.g. cluster-marker combinations) on the rows and samples as the columns.
2. `group_factor`: a binary categorical response variable
that represents the group condition for each sample. For example if the samples represent two different groups or conditions (e.g., before stimulation and after stimulation), provide `CytoK()` with a phenotype representing which columns in the
`object` are different groups.
3. `lowerRho`: **optional** a positive value that represents the lower bound of the kernel parameter. Default is 2.
4. `upperRho`: **optional** a positive value that represents the upper bound of the kernel parameter. Default is 12.
5. `gridRho`: **optional** a positive value that represents the number of grid points in the interval of upper and bound of the kernel parameter. Default is 4.
6. `alpha`: **optional** level of significance to control the False Discovery
rate (FDR). Default is \(0.05\) (i.e., \(\alpha=0.05\)).
7. `featureVars`: **optional** Vector of the columns which identify features. If a `SummarizedExperiment` is used for `data`, row variables will be used. Default is NULL.

## 4.2 Running `CytoK()`

### 4.2.1 cytoHDBMW SummarizedExperiment example - Identifying differentially expressed features

We apply the CytoK procedure to identify the differentially expressed cluster-marker combinations in the cytoHDBMW data.
To run the `CytoK()` function, we only input the data object and group factor. We obtain 3 outputs
after running the `CytoK()` function. They are shown below:

```
library(cytoKernel)
CytoK_output<- CytoK(cytoHDBMW,group_factor = rep(c(0, 1),
               c(4, 4)),lowerRho=2,upperRho=12,gridRho=4,
               alpha = 0.05,featureVars = NULL)
CytoK_output
```

```
## CytoK: Differential expression using
##            kernel-based score test
## CytoKFeatures (length = 126 ):
##        cluster EffectSize EffectSizeSD pvalue  padj
## pNFkB        1      2.024        0.673  0.002 0.007
## pp38         1      0.036        0.165  0.003 0.011
## pStat5       1      0.393        0.167  0.577 0.765
## ...
## CytoKFeaturesOrdered (length = 126 ):
##        cluster EffectSize EffectSizeSD pvalue padj
## pBtk.1       2      0.433        0.241      0    0
## pS6.8        9      3.360        0.671      0    0
## pp38.7       8      0.037        0.069      0    0
## ...
```

```
## Head of the data.frame containing shrunken effect sizes, shrunken ##effect size sd's, p values and adjusted p values
head(CytoKFeatures(CytoK_output))
```

```
##        cluster EffectSize EffectSizeSD      pvalue        padj
## pNFkB        1 2.02367428   0.67290649 0.001970156 0.007301166
## pp38         1 0.03647958   0.16532500 0.003251778 0.011381222
## pStat5       1 0.39345165   0.16748947 0.576504359 0.765271619
## pAkt         1 2.09276549   0.70372729 0.644688311 0.765271619
## pStat1       1 0.13722890   0.27677527 0.552315231 0.765271619
## pSHP2        1 0.44989429   0.08264906 0.681940272 0.765271619
```

```
## Head of the data.frame containing shrunken effect sizes, shrunken ##effect size sd's, p values and adjusted p values ordered by ##adjusted p values from low to high
head(CytoKFeaturesOrdered(CytoK_output))
```

```
##          cluster  EffectSize EffectSizeSD       pvalue         padj
## pBtk.1         2 0.433279948   0.24130035 7.831438e-07 4.933806e-05
## pS6.8          9 3.359722803   0.67069336 5.840003e-07 4.933806e-05
## pp38.7         8 0.036670302   0.06854772 1.669379e-06 7.011390e-05
## pp38.6         7 0.003349933   0.02985019 2.938640e-06 9.256716e-05
## pNFkB.2        3 2.399243818   0.54714335 4.314569e-06 1.079152e-04
## pPlcg2.8       9 0.539173837   0.12741839 5.138821e-06 1.079152e-04
```

```
## Percent of differentially expressed features
CytoKDEfeatures(CytoK_output)
```

```
## [1] 34.12698
```

## 4.3 Filtering the data by differentially expressed features

```
## Filtering the data by reproducible features
CytoKDEData_HD<- CytoKDEData(CytoK_output, by = "features")
CytoKDEData_HD
```

```
## class: SummarizedExperiment
## dim: 43 8
## metadata(1): nonDEfeatures
## assays(1): exprs
## rownames(43): pNFkB pp38 ... pErk pS6
## rowData names(5): cluster EffectSize EffectSizeSD pvalue padj
## colnames(8): Ref1 Ref2 ... BCRXL3 BCRXL4
## colData names(4): sample_id condition patient_id ids
```

## 4.4 Heatmap of the expression matrix

This heatmap illustrates the expression profiles with differentially expressed features (cluster-marker combinations) on the rows and patients on the columns from the kernel-based score test implemented using the `CytoK` function. The differentially expressed data (matrix) can be extracted using the (`CytoKDEData`) function (see above). The generic heatmap of the differentially expressed expression matrix can be plotted using the `plotCytoK()` function. Any specific meta information can also be added using the `ComplexHeatmap` package. An illustration is shown below where the cluster ids are separately added onto the heatmap generated by the `plotCytoK()` function.

```
heatmap1<- plotCytoK(CytoK_output,
group_factor = rep(c(0, 1), c(4, 4)),topK=10,
featureVars = NULL)
featureOrderedExtracted<- CytoKFeaturesOrdered(CytoK_output)
rowmeta_cluster<- featureOrderedExtracted$cluster
topK<- 10
rowmeta_clusterTopK<- rowmeta_cluster[seq_len(topK)]
library(ComplexHeatmap)
heatmap2<- Heatmap(rowmeta_clusterTopK,
             name = "cluster")
heatmap2+heatmap1
```

![Differentially expressed (top 10) cluster-marker data using cytoKernel](data:image/png;base64...)

Figure 2: Differentially expressed (top 10) cluster-marker data using cytoKernel

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
## [1] grid      stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] ComplexHeatmap_2.26.0 cytoKernel_1.16.0     knitr_1.50
## [4] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.40.0 circlize_0.4.16
##  [3] shape_1.4.6.1               rjson_0.2.23
##  [5] xfun_0.53                   bslib_0.9.0
##  [7] GlobalOptions_0.1.2         Biobase_2.70.0
##  [9] lattice_0.22-7              Cairo_1.7-0
## [11] vctrs_0.6.5                 tools_4.5.1
## [13] generics_0.1.4              stats4_4.5.1
## [15] parallel_4.5.1              tibble_3.3.0
## [17] cluster_2.1.8.1             pkgconfig_2.0.3
## [19] Matrix_1.7-4                data.table_1.17.8
## [21] SQUAREM_2021.1              RColorBrewer_1.1-3
## [23] S4Vectors_0.48.0            lifecycle_1.0.4
## [25] truncnorm_1.0-9             compiler_4.5.1
## [27] tinytex_0.57                Seqinfo_1.0.0
## [29] codetools_0.2-20            clue_0.3-66
## [31] htmltools_0.5.8.1           sass_0.4.10
## [33] yaml_2.3.10                 pillar_1.11.1
## [35] crayon_1.5.3                jquerylib_0.1.4
## [37] BiocParallel_1.44.0         cachem_1.1.0
## [39] DelayedArray_0.36.0         magick_2.9.0
## [41] iterators_1.0.14            abind_1.4-8
## [43] foreach_1.5.2               tidyselect_1.2.1
## [45] digest_0.6.37               dplyr_1.1.4
## [47] bookdown_0.45               ashr_2.2-63
## [49] fastmap_1.2.0               colorspace_2.1-2
## [51] cli_3.6.5                   invgamma_1.2
## [53] SparseArray_1.10.0          magrittr_2.0.4
## [55] S4Arrays_1.10.0             withr_3.0.2
## [57] rmarkdown_2.30              XVector_0.50.0
## [59] matrixStats_1.5.0           png_0.1-8
## [61] GetoptLong_1.0.5            evaluate_1.0.5
## [63] GenomicRanges_1.62.0        IRanges_2.44.0
## [65] doParallel_1.0.17           irlba_2.3.5.1
## [67] rlang_1.1.6                 Rcpp_1.1.0
## [69] mixsqp_0.3-54               glue_1.8.0
## [71] BiocManager_1.30.26         BiocGenerics_0.56.0
## [73] jsonlite_2.0.0              R6_2.6.1
## [75] MatrixGenerics_1.22.0
```

# References

Bodenmiller, Bernd, Eli R Zunder, Rachel Finck, Tiffany J Chen, Erica S Savig, Robert V Bruggner, Erin F Simonds, et al. 2012. “Multiplexed Mass Cytometry Profiling of Cellular States Perturbed by Small-Molecule Regulators.” *Nature Biotechnology* 30 (9): 858–67.

Bruggner, Robert V, Bernd Bodenmiller, David L Dill, Robert J Tibshirani, and Garry P Nolan. 2014. “Automated Identification of Stratifying Signatures in Cellular Subpopulations.” *Proceedings of the National Academy of Sciences* 111 (26): E2770–E2777.

Crowell, Helena L, Stéphane Chevrier, Andrea Jacobs, Sujana Sivapatham, Bernd Bodenmiller, Mark D Robinson, Tumor Profiler Consortium, and others. 2020. “An R-Based Reproducible and User-Friendly Preprocessing Pipeline for Cytof Data.” *F1000Research* 9 (1263): 1263.

Csardi, Gabor, Tamas Nepusz, and others. 2006. “The Igraph Software Package for Complex Network Research.” *InterJournal, Complex Systems* 1695 (5): 1–9.

Davies, Robert B. 1987. “Hypothesis Testing When a Nuisance Parameter Is Present Only Under the Alternative.” *Biometrika* 74 (1): 33–43.

Liu, Dawei, Debashis Ghosh, and Xihong Lin. 2008. “Estimation and Testing for the Effect of a Genetic Pathway on a Disease Outcome Using Logistic Kernel Machine Regression via Logistic Mixed Models.” *BMC Bioinformatics* 9 (1): 1–11.

McCarthy, Davis J, Kieran R Campbell, Aaron TL Lun, and Quin F Wills. 2017. “Scater: Pre-Processing, Quality Control, Normalization and Visualization of Single-Cell Rna-Seq Data in R.” *Bioinformatics* 33 (8): 1179–86.

Stephens, Matthew. 2017. “False Discovery Rates: A New Deal.” *Biostatistics* 18 (2): 275–94.

Traag, Vincent A, Ludo Waltman, and Nees Jan Van Eck. 2019. “From Louvain to Leiden: Guaranteeing Well-Connected Communities.” *Scientific Reports* 9 (1): 1–12.

Weber, Lukas M, and Charlotte Soneson. 2019. “HDCytoData: Collection of High-Dimensional Cytometry Benchmark Datasets in Bioconductor Object Formats.” *F1000Research* 8.

Zhan, Xiang, Andrew D Patterson, and Debashis Ghosh. 2015. “Kernel Approaches for Differential Expression Analysis of Mass Spectrometry-Based Metabolomics Data.” *BMC Bioinformatics* 16 (1): 1–13.