# Using scTHI

Michele Ceccarelli and Francesca Pia Caruso

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Examples](#examples)
  + [3.1 Analysis of H3K27M glioma from Fibin et al. Science 2018](#analysis-of-h3k27m-glioma-from-fibin-et-al.-science-2018)
    - [3.1.1 Input Data](#input-data)
    - [3.1.2 Run scTHI.score](#run-scthi.score)
    - [3.1.3 Tumor microenvironment classification](#tumor-microenvironment-classification)
* [4 Session Info](#session-info)
* [5 References](#references)
* **Appendix**

# 1 Introduction

The detection of tumor-host interaction is a major challange in cancer
understanding. More recent advances in single cell next generation
sequencing have provided new insights in unveiling tumor microenvironment
(TME) cells comunications. The scTHI package provides some useful functions
to identify and visualize the cell types making up the TME, and a rank-based
approach to discover interesting ligand-receptor interactions establishing
among malignant and non tumor cells

# 2 Installation

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scTHI")
```

# 3 Examples

## 3.1 Analysis of H3K27M glioma from Fibin et al. Science 2018

### 3.1.1 Input Data

The scTHI package requires a matrix of count data (or normalized counts)
from single cell RNA-seq experiments, where rows are genes presented with
Hugo Symbols and columns are cells. For a practical demonstration, we
will use the scRNA-seq data available on the [Broad Institute Single-Cell
Portal](https://portals.broadinstitute.org/single_cell/study/single-cell-%20analysis-in-pediatric-midline-gliomas-withhistone-h3k27m-mutation) [1].
The dataset provides 3,321 scRNA-seq profiles from six primary Glioma
(H3K27M-glioma), and includes both malignant cells and several tumor
microenvironment cell types, as immune cells and oligodendrocytes.
Our goal is to identify the significant ligand-receptor interactions
that are established between cancer and immune cells present in the tumor
microenvironment. For this reason, after downloading H3K27M-glioma data
we preprocessed them, selecting only one sample of interest (i.e. BCH836),
removing not-expresse genes, transforming data in log TPM , and applying
quantile normalization. Processed are included in the package and can be
loaded as follows:

```
library(scTHI)
library(scTHI.data)
set.seed(1234)
data("H3K27")
data("H3K27.meta")
```

H3K27.meta includes the annotation of each cell, so as to identify
the tumor cells and the immune cells in BCH836 patient:

```
table(H3K27.meta$Type)
```

```
##
##          Filter     Immune cell       Malignant Oligodendrocyte
##               2              53             438              34
```

We will use the cells annotated as Immune and a subset of Malignant.

```
Malignant <-
rownames(H3K27.meta)[H3K27.meta$Type == "Malignant"][1:100]
Immune <- rownames(H3K27.meta)[H3K27.meta$Type == "Immune cell"]
```

### 3.1.2 Run scTHI.score

The function `scTHI.score` can be used to detect significant
ligand-receptor interactions occurring between cancer and immune cells.
The function uses a dataset of 1044 ligand-receptor pairs to identify
those which are significantly enriched between pairs clusters of your
dataset. A score is computed for each interaction pair. This score does
not simply reflect the average expression of the two partners in the
interaction pair, it is rather based on the percentage of cells that
express the interaction pair at the top of the ordered gene list. It
considers a gene expressed in a cell, only if it is in the top 10% of
the ranked gene list, as set in `topRank` argument.
Interactions are not symmetric, so partnerA expression is considered
on the first cluster (in the example the Malignant cells), and partnerB
expression is considered on the second cluster (i.e. Immune cells).
A p-value for each pair is computed, based on a null model from random
permutations of data, and and only significant
interaction pairs are reported.

```
H3K27.result <-
scTHI_score(
expMat = H3K27,
cellCusterA = Malignant,
cellCusterB = Immune,
cellCusterAName = "Malignant",
cellCusterBName = "Immune",
topRank = 10,
PValue = TRUE,
pvalueCutoff = 0.05,
nPermu = 10,
ncore = 1
)
```

```
## Warning: Not all interaction genes are in expMat
```

```
## Computing score for 2333 interaction pairs...
```

```
## [1] "Computed ranked values for partner A"
## [1] "Computed ranked values for partner B"
```

```
## Removing low score interactions...
```

```
## Computing permutation....
```

```
## Interaction pairs detected:
```

```
##  [1] "RPS19_C5AR1"      "THY1_ITGAX:ITGB2" "B2M_HLA-F"        "PTN_PLXNB2"
##  [5] "B2M_LILRB1"       "PSAP_LRP1"        "SERPINE2_LRP1"    "KLRC2_HLA-E"
##  [9] "APP_CD74"         "VCAN_ITGB1"       "CALR_LRP1"        "HLA-A_APLP2"
## [13] "THY1_ITGB2:ITGAM" "VCAN_TLR2"        "HLA-A_LILRB1"     "CHAD_ITGB1"
## [17] "APP_LRP1"         "APP_NCSTN"
```

For which partner A and partner B are expressed in at least 50%
of the cells of the respective clusters, as set in `filterCutoff`
argument. P-value computation is optional and is estimated by
permuting the mates of interaction pairs. Result also includes
two columns with the average expression values of each partner
in the respective clusters.

```
head(H3K27.result$result)
```

```
##                    interationPair interactionType partnerA    partnerB
## RPS19_C5AR1           RPS19_C5AR1          simple    RPS19       C5AR1
## THY1_ITGAX:ITGB2 THY1_ITGAX:ITGB2         complex     THY1 ITGAX:ITGB2
## B2M_HLA-F               B2M_HLA-F          simple      B2M       HLA-F
## PTN_PLXNB2             PTN_PLXNB2          simple      PTN      PLXNB2
## B2M_LILRB1             B2M_LILRB1          simple      B2M      LILRB1
## PSAP_LRP1               PSAP_LRP1          simple     PSAP        LRP1
##                  rnkPartnerA_Malignant expValueA_Malignant rnkPartnerB_Immune
## RPS19_C5AR1                       0.99                9.63               0.89
## THY1_ITGAX:ITGB2                  0.81                7.12               0.92
## B2M_HLA-F                         0.98                9.63               0.66
## PTN_PLXNB2                        0.98                9.57               0.62
## B2M_LILRB1                        0.98                9.63               0.60
## PSAP_LRP1                         0.98                9.09               0.60
##                  expValueB_Immune SCORE pValue FDR
## RPS19_C5AR1                  7.82 0.940      0   0
## THY1_ITGAX:ITGB2      8.08 # 9.18 0.865      0   0
## B2M_HLA-F                    6.34 0.820      0   0
## PTN_PLXNB2                   6.23 0.800      0   0
## B2M_LILRB1                   5.91 0.790      0   0
## PSAP_LRP1                     6.3 0.790      0   0
```

The function `scTHI.plotResult` with argument `plotType` as
“score” displays the score of each significant pair through
barplots. The number of asterisks indicates significance.
Otherwise, setting the argument `plotType` as “pair”, for each
pair are shown bar plots displaying the percentage of cells in
each cluster expressing partner A and partner B, respectively.

```
scTHI_plotResult(scTHIresult = H3K27.result,
                cexNames = 0.7,
                plotType = "score")
```

![](data:image/png;base64...)

```
scTHI_plotResult(scTHIresult = H3K27.result,
                cexNames = 0.7,
                plotType = "pair")
```

![](data:image/png;base64...)

Another useful way to explore results is the visualization of the
entire data set through the t-SNE plot. scTHI allows the user to
compute the non-linear dimensionality reduction of data using the
scTHI.runTsne function based on the Rtsne R package [2].

```
H3K27.result <- scTHI_runTsne(scTHIresult = H3K27.result)
```

```
## Loading required namespace: Rtsne
```

Users can decide to display on the tsne the two input clusters,
i.e. Maglignant and Immune cells, or to observe the intensity of
the expression of an intresting interaction pair in the whole
dataset. The scTHI.plotCluster function differently labels cells
on t-SNE if they belong to ClusterA or ClusterB.

```
scTHI_plotCluster(scTHIresult = H3K27.result,
                cexPoint = 0.8,
                legendPos = "bottomleft")
```

![](data:image/png;base64...)

On the other hand the scTHI.plotPairs function colors the cells on
the t-SNE based on the expression levels of a user-defined
interaction pair. For example, let’s try plotting the expression
of the interaction pair consisting of THY1, which should be expressed
by the cancer cells and the ITGAX-ITGB2 complex, instead expressed
by the immune cells.

```
scTHI_plotPairs(
scTHIresult = H3K27.result,
cexPoint = 0.8,
interactionToplot = "THY1_ITGAX:ITGB2"
)
```

![](data:image/png;base64...)

The THY1 gene appears uniformly expressed in tumor cells, and
in according to results table, it was expressed in 861% of
malignant cells at the top 10% of the ranked gene list of
each cell. On the other hand the ITGAX-ITGB2 complex is highly
specific of the Immune cluster, where it is expressed by 92% of
the cells at the top 10% of the ranked gene list of each cell.

### 3.1.3 Tumor microenvironment classification

Another important problem in study tumor-host interaction is
the classification of all cell types that make up the tumor
microenvironment. Generally, tools for single cell data analysis
are based on the use of marker genes to classify different cell
types identified by clustering approaches. This strategy is not
always the most accurate, our approach uses a different method
for the classification of TME based on gene signature enrichment
analysis. The `TME.classification` implements the
Mann-Whitney-Wilcoxon Gene Set Test (MWW-GST) algorithm [3]
and tests for each cell the enrichment of a collection of
signatures of different cell types, with greater interest for
the Immune System and the Central Nervous System cells. Thus,
each cell is associated with a specific phenotype based on the
more significant enriched gene set.
Let’s try to classify the TME cells of the BCH836 patient,
excluding malignant cells from the dataset.

```
Tme.cells <-
rownames(H3K27.meta)[which(H3K27.meta$Type != "Malignant")]
H3K27.tme <- H3K27[, Tme.cells]
```

Note that `TME.classification` function can take a
long time if the number of cells to test is large.

```
Class <- TME_classification(expMat = H3K27.tme, minLenGeneSet = 10)
```

The H3K27M dataset annotation table suggests that non-tumor cells
from BCH836 patient are mainly composed by Oligodendrocyte and Immune
cells, respectively. The TME.classification function identifies a
similar number of Oligodendrocytes and Immune cells, distinguishing
the latter mainly in Microglia, Monocytes and Macrophages and fewer
other Immune cells.

```
table(Class$Class[Tme.cells], H3K27.meta[Tme.cells, "Type"])
```

```
##
##                    Filter Immune cell Oligodendrocyte
##   Adipocytes            0           0               1
##   Bcells                0           1               0
##   Eosinophils           0           1               0
##   Macrophages           0           4               0
##   MacrophagesM1         0           5               0
##   Microglia             0          19               0
##   Monocytes             0          20               0
##   NaturalKiller         0           1               0
##   Neutrophils           0           1               0
##   Oligodendrocytes      2           0              32
##   Tregs                 0           1               0
##   nc                    0           0               1
```

Finally, using the previously calculated t-SNE or a set of
user-defined coordinates, you can view the new classification
of the TME.

```
TME_plot(tsneData = H3K27.result$tsneData, Class, cexPoint = 0.8)
```

![](data:image/png;base64...)

# 4 Session Info

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
## [1] scTHI.data_1.21.0 scTHI_1.22.0      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] magick_2.9.0        xfun_0.53           jsonlite_2.0.0
##  [7] Rtsne_0.17          htmltools_0.5.8.1   tinytex_0.57
## [10] sass_0.4.10         rmarkdown_2.30      evaluate_1.0.5
## [13] jquerylib_0.1.4     fastmap_1.2.0       yaml_2.3.10
## [16] lifecycle_1.0.4     bookdown_0.45       BiocManager_1.30.26
## [19] compiler_4.5.1      codetools_0.2-20    Rcpp_1.1.0
## [22] BiocParallel_1.44.0 digest_0.6.37       R6_2.6.1
## [25] parallel_4.5.1      magrittr_2.0.4      bslib_0.9.0
## [28] tools_4.5.1         cachem_1.1.0
```

# 5 References

# Appendix

1. Filbin, M. G., Tirosh, I., Hovestadt, V., Shaw, M. L., Escalante,
   L. E., Mathewson, N. D., … & Haberler, C. (2018). Developmental
   and oncogenic programs in H3K27M gliomas dissected by single-cell
   RNA-seq. Science, 360(6386), 331-335.
2. Maaten, L. V. D., & Hinton, G. (2008). Visualizing data
   using t-SNE. Journal of machine learning research, 9(Nov), 2579-2605.
3. Frattini, V., Pagnotta, S. M., Fan, J. J., Russo, M. V., Lee,
   S. B., Garofano, L., … & Frederick, V. (2018). A metabolic
   function of FGFR3-TACC3 gene fusions in cancer. Nature, 553(7687), 222.