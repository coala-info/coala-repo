# Increasing power with bulk-based hypothesis weighing (bbhw)

Pierre-Luc Germain1,2,3

1Department of Molecular Life Sciences, University of Zurich, Zurich, Switzerland
2D-HEST Institute for Neuroscience, ETH Zurich, Switzerland
3Swiss Institute of Bioinformatics (SIB), Zurich, Switzerland

#### October 30, 2025

#### Abstract

Due to the costs of single-cell sequencing, sample sizes are often relatively limited, sometimes leading to poorly reproducible results. In many contexts, however, larger bulk RNAseq data is available for the same conditions or experimental paradigm, which can be used as additional evidence of a generalizable differential expression pattern. Here, we show how such data can be used, via bulk-based hypothesis weighing (bbhw), to increase the power and robustness of single-cell differential state analysis.

#### Package

muscat 1.24.0

# Contents

* [Load packages](#load-packages)
* [1 Methods](#methods)
  + [1.1 Creation of the evidence bins](#creation-of-the-evidence-bins)
  + [1.2 P-value adjustment](#p-value-adjustment)
* [2 Example usage](#example-usage)
  + [2.1 Generating input data](#generating-input-data)
    - [2.1.1 Differential State (DS) analysis](#differential-state-ds-analysis)
    - [2.1.2 Generating fake bulk data](#generating-fake-bulk-data)
  + [2.2 bbhw](#bbhw)
* [Session info](#session-info)
* [References](#references)

---

# Load packages

```
library(dplyr)
library(muscat)
library(SingleCellExperiment)
```

# 1 Methods

The function `bbhw` (bulk-based hypothesis weighing) implements various
approaches leveraging independent bulk RNAseq data to increase the power of
cell-type level differential expression (state) analysis (i.e. across
conditions). The general strategy is to group the hypotheses111
A hypothesis, here, is understood as the differential expression (or lack
thereof) of one gene in one cell type. into different bins based on the bulk
dataset, and then employ some False Discovery Rate (FDR) methods that can make
use of this grouping. FDR methods rely on an excess of small p-values (compared
to a uniform distribution) to control the rate of false discoveries, and the
rationale for covariate-based methods is that power can be gained by
concentrating this excess within certain bins. This is illustrated in the
following figure:

![Bulk-based weighing of single-cell hypotheses. A-C: Example p-values of differential expression upon stress, from both a single-cell dataset with modest sample size (A and C) and a much larger bulk dataset (B) (data from Waag et al., biorxiv 2025). C: Splitting the single-cell p-values by significance of the respective gene in the bulk data leads to higher local excess of p-values. D: Example precision-recall curves in a different dataset with ground truth (based on downsampled data) using standard (local) FDR and the default bbhw method (see our paper for more detail).](data:image/png;base64...)

Figure 1: Bulk-based weighing of single-cell hypotheses
A-C: Example p-values of differential expression upon stress, from both a single-cell dataset with modest sample size (A and C) and a much larger bulk dataset (B) (data from Waag et al., biorxiv 2025). C: Splitting the single-cell p-values by significance of the respective gene in the bulk data leads to higher local excess of p-values. D: Example precision-recall curves in a different dataset with ground truth (based on downsampled data) using standard (local) FDR and the default bbhw method (see our paper for more detail).

On its own, the single-cell data shows a modest enrichment in small p-values
(panel A). However, splitting genes into bins based on their p-value in the bulk
dataset (B) leads to much stronger local (i.e. within bin) excess of small
p-values (C). Exploiting this, the `bbhw` method can yield showing substantial
increased in power, as illustrated in a different dataset with ground truth (D).

As this is done at the level of multiple-testing correction, `bbhw` can be
executed on top of any per-celltype differential state analysis as produced by
`pbDS` or `mmDS` (see example below), assuming that the bulk data is from the
same (or a similar) contrast, and that its samples are independent from the
single-cell samples.

For more detail about the methods and their performance, see the
[paper](https://www.biorxiv.org/content/10.1101/2025.04.15.648932v1). Here, we
concentrate on practical use and only briefly summarize the options.

For each of steps (bin creation and usage in FDR), different methods
can be applied, which are described below.

## 1.1 Creation of the evidence bins

The same bulk p-value will necessarily be more informative in a cell type that
is abundant, or for a gene that is more specific to that cell type, since in
both cases the cell type will contribute more to the bulk expression of the
gene222
We define the ‘contribution’ of the cell type to the bulk expression of the gene
as the proportion of the total pseudobulk reads for that gene that is
contributed by the cell type (across all samples).. We therefore include such information (if available) in the
binning of the hypotheses.

Specifically, the following options are available:

* **sig** : the bulk significance values are used as is, eventually
  taking the direction of the logFC into account if provided in `bulkDEA`.
  `nbins` are created using quantiles.
* **combined** : first, significance-based bins are created in the same
  fashion as in `bin.method="sig"`. Each significance bin is then further
  split into genes for which the cell type contributes much to the bulk, and
  genes for which the cell type contributes little.
* **PAS** (Proportion-Adjusted Significance): for each hypothesis, the
  bulk significance is adjusted based on the cell type contribution to the
  bulk of that gene using `inv.logit( logit(p) * sqrt(c) )` where `p` and `c`
  are respectively the bulk p-value and the proportion of bulk reads
  contributed by the cell type). We then split this covariate into quantile
  bins as is done for the “sig” method. *This is the recommended method.*
* **PALFC** (Proportion-Adjusted logFC): same as for **PAS**, except that the
  bulk logFC is used instead of the significance. Note that when using this
  option, it is important to use shrunk logFC estimates, as for instance
  produced by `edgeR::predFC`.
* **asNA** : for hypotheses for which the cell type contributes little
  to the bulk profile, the covariate (i.e. bulk p-value) is set to NA,
  resulting it in making up its own bin.

In all cases, if `useSign=TRUE` (default) and `bulkDEA` contains logFC
information, the concordance of the direction of change between bulk and
single-cell data will also be used to adjust the covariate.

## 1.2 P-value adjustment

Once the bins are created, the following `correction.method` options are
available:

* **binwise** : the Benjamini-Hochberg (BH) procedure is applied
  separately for each bin. Doing this can lead to an increase in false
  positives if the number of bins is large, and to correct for this the
  resulting adjusted p-values are multiplied by `pmin(1,nbins/rank(p))`. This
  results is proper FDR control even across a large number of bins, but the
  method is more conservative than others.
* **IHW** : The Independent Hypothesis Weighing (IHW) method
  (Ignatiadis et al. [2016](#ref-Ignatiadis2016)) is applied. IHW uses cross-validation to optimizes
  hypotheses weights that lead to the highest rejections of the null hypothesis.
  See the *[IHW](https://bioconductor.org/packages/3.22/IHW)* package for more detail.
* **gBH.LSL** and **gBH.TST**: the Grouped BH method (Hu, Zhao, and Zhou [2010](#ref-Hu2010)) is applied.
  The method has two options to compute the groups’ rate of true null
  hypotheses, LSL and TST, which make the corresponding
  `correction.method` options.

To enable the Grouped Benjamini-Hochberg (gBH) methods, we implemented the
procedure from Hu, Zhao and Zhou (Hu, Zhao, and Zhou [2010](#ref-Hu2010)) in the `gBH` function, which can be
used outside of the present context. The method has two variants which differ
in the way the rate of true null hypotheses in each group/bin is estimated (see
`?gBH` for more detail). **We recommend using** `correction.method="gBH.LSL"`,
which in our benchmark provided the best power while appropriately controlling
error.

Each method exists in two flavors: a local one, which is applied for each
cell type separately, and a global one, which is applied once across all cell
types (see the `local` argument). We recommend using the local one, for the same
reasons discussed above: the excess of small p-values in affected cell types
gets diluted when polled with the unaffected cell types, and conversely
conversely the FDR is underestimated for small p-values from unaffected cell
types (which are the result of noise) due to the excess of small p-values coming
from affected cell types.

# 2 Example usage

## 2.1 Generating input data

### 2.1.1 Differential State (DS) analysis

We first load an example dataset and perform a pseudo-bulk differential state
analysis (for more information on this, see the [vignette](analysis.html)).

```
data("example_sce")
# since the dataset is a bit too small for the procedure, we'll double it:
sce <- rbind(example_sce, example_sce)
row.names(sce) <- make.unique(row.names(sce))
# pseudo-bulk aggregation
pb <- aggregateData(sce)
res <- pbDS(pb, verbose = FALSE)
# the signal is too strong in this data, so we'll reduce it
# (don't do this with real data!):
res$table$stim <- lapply(res$table$stim, \(x) {
    x$p_val <- sqrt(x$p_val)
    x$p_adj.loc <- p.adjust(x$p_val, method="fdr")
    x
})
# we assemble the cell types in a single table for the comparison of interest:
res2 <- bind_rows(res$table$stim, .id="cluster_id")
head(res2 <- res2[order(res2$p_adj.loc),])
```

```
##         gene  cluster_id    logFC    logCPM        F        p_val    p_adj.loc
## 1835   ISG15 CD8 T cells 5.577874 11.049612 314.7003 1.353715e-07 7.438711e-05
## 1847    IFI6 CD8 T cells 5.821973  9.926318 238.3450 3.921992e-07 7.438711e-05
## 2261   ISG20 CD8 T cells 3.923398 11.043214 256.9297 3.913973e-07 7.438711e-05
## 2404 ISG15.1 CD8 T cells 5.577874 11.049612 314.7003 1.353715e-07 7.438711e-05
## 2416  IFI6.1 CD8 T cells 5.821973  9.926318 238.3450 3.921992e-07 7.438711e-05
## 2830 ISG20.1 CD8 T cells 3.923398 11.043214 256.9297 3.913973e-07 7.438711e-05
##         p_adj.glb contrast
## 1835 4.898394e-11     stim
## 1847 1.370538e-10     stim
## 2261 1.370538e-10     stim
## 2404 4.898394e-11     stim
## 2416 1.370538e-10     stim
## 2830 1.370538e-10     stim
```

### 2.1.2 Generating fake bulk data

We next prepare the bulk differential expression table. Since we don’t actually
have bulk data for this example dataset, we’ll just make it up (don’t do this!):

```
set.seed(123)
bulkDEA <- data.frame(
    row.names=row.names(pb),
    logFC=rnorm(nrow(pb)),
    PValue=runif(nrow(pb)))
# we'll spike some signal in:
gs_by_k <- split(res2$gene, res2$cluster_id)
sel <- unique(unlist(lapply(gs_by_k, \(x) x[3:150])))
bulkDEA[sel,"PValue"] <- abs(rnorm(length(sel), sd=0.01))
head(bulkDEA)
```

```
##                logFC     PValue
## HES4     -0.56047565 0.01610123
## ISG15    -0.23017749 0.01839477
## AURKAIP1  1.55870831 0.68257091
## MRPL20    0.07050839 0.50781291
## SSU72     0.12928774 0.55437180
## RER1      1.71506499 0.84124010
```

## 2.2 bbhw

We then can apply `bbhw` :

```
# here, we manually set 'nbins'
# because the dataset is too small,
# you shouldn't normally need to do this:
res2 <- bbhw(pbDEA=res2, bulkDEA=bulkDEA, pb=pb, nbins=4, verbose=FALSE)
```

We can see that the adjustment methods do not rank the genes in the same fashion:

```
head(res2[order(res2$padj),c("gene","cluster_id","p_adj.loc","padj")])
```

```
##         gene  cluster_id    p_adj.loc         padj
## 2280  IFI6.1 CD8 T cells 7.438711e-05 3.033229e-05
## 2305   ISG20 CD8 T cells 7.438711e-05 3.033229e-05
## 2306 ISG20.1 CD8 T cells 7.438711e-05 3.033229e-05
## 2303   ISG15 CD8 T cells 7.438711e-05 6.892346e-05
## 2304 ISG15.1 CD8 T cells 7.438711e-05 6.892346e-05
## 2279    IFI6 CD8 T cells 7.438711e-05 1.553109e-04
```

```
table(standard=res2$p_adj.loc < 0.05, bbhw=res2$padj < 0.05)
```

```
##         bbhw
## standard FALSE TRUE
##    FALSE  5149  127
##    TRUE      4   66
```

This results in a different number of genes with adjusted p-values < 0.05:

```
c(standard=sum(res2$p_adj.loc < 0.05), bbhw=sum(res2$padj < 0.05))
```

```
## standard     bbhw
##       70      193
```

In this case the effect is very modest, chiefly because this is a small subset of data (hence few hypotheses) and the signal for this subset is already highly significant to begin with. However, this can often results in substantial improvements in both precision and recall (see Figure 1D above).

# Session info

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
##  [1] UpSetR_1.4.0                scater_1.38.0
##  [3] scuttle_1.20.0              muscData_1.23.0
##  [5] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           ExperimentHub_3.0.0
## [15] AnnotationHub_4.0.0         BiocFileCache_3.0.0
## [17] dbplyr_2.5.1                BiocGenerics_0.56.0
## [19] generics_0.1.4              purrr_1.1.0
## [21] muscat_1.24.0               limma_3.66.0
## [23] ggplot2_4.0.0               dplyr_1.1.4
## [25] cowplot_1.2.0               patchwork_1.3.2
## [27] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RcppAnnoy_0.0.22         splines_4.5.1            filelock_1.0.3
##   [4] bitops_1.0-9             tibble_3.3.0             lpsymphony_1.38.0
##   [7] httr2_1.2.1              lifecycle_1.0.4          Rdpack_2.6.4
##  [10] edgeR_4.8.0              doParallel_1.0.17        globals_0.18.0
##  [13] lattice_0.22-7           MASS_7.3-65              backports_1.5.0
##  [16] magrittr_2.0.4           sass_0.4.10              rmarkdown_2.30
##  [19] jquerylib_0.1.4          yaml_2.3.10              sctransform_0.4.2
##  [22] DBI_1.2.3                minqa_1.2.8              RColorBrewer_1.1-3
##  [25] multcomp_1.4-29          abind_1.4-8              EnvStats_3.1.0
##  [28] glmmTMB_1.1.13           TH.data_1.1-4            rappdirs_0.3.3
##  [31] sandwich_3.1-1           circlize_0.4.16          ggrepel_0.9.6
##  [34] pbkrtest_0.5.5           irlba_2.3.5.1            listenv_0.9.1
##  [37] parallelly_1.45.1        codetools_0.2-20         DelayedArray_0.36.0
##  [40] tidyselect_1.2.1         shape_1.4.6.1            farver_2.1.2
##  [43] lme4_1.1-37              ScaledMatrix_1.18.0      viridis_0.6.5
##  [46] jsonlite_2.0.0           GetoptLong_1.0.5         BiocNeighbors_2.4.0
##  [49] survival_3.8-3           iterators_1.0.14         emmeans_2.0.0
##  [52] foreach_1.5.2            tools_4.5.1              progress_1.2.3
##  [55] Rcpp_1.1.0               blme_1.0-6               glue_1.8.0
##  [58] gridExtra_2.3            SparseArray_1.10.0       xfun_0.53
##  [61] mgcv_1.9-3               DESeq2_1.50.0            withr_3.0.2
##  [64] numDeriv_2016.8-1.1      BiocManager_1.30.26      fastmap_1.2.0
##  [67] boot_1.3-32              caTools_1.18.3           digest_0.6.37
##  [70] rsvd_1.0.5               R6_2.6.1                 estimability_1.5.1
##  [73] colorspace_2.1-2         Cairo_1.7-0              gtools_3.9.5
##  [76] dichromat_2.0-0.1        RSQLite_2.4.3            RhpcBLASctl_0.23-42
##  [79] tidyr_1.3.1              variancePartition_1.40.0 data.table_1.17.8
##  [82] corpcor_1.6.10           httr_1.4.7               prettyunits_1.2.0
##  [85] S4Arrays_1.10.0          uwot_0.2.3               pkgconfig_2.0.3
##  [88] gtable_0.3.6             blob_1.2.4               ComplexHeatmap_2.26.0
##  [91] S7_0.2.0                 XVector_0.50.0           remaCor_0.0.20
##  [94] htmltools_0.5.8.1        bookdown_0.45            TMB_1.9.18
##  [97] clue_0.3-66              scales_1.4.0             png_0.1-8
## [100] fANCOVA_0.6-1            reformulas_0.4.2         knitr_1.50
## [103] reshape2_1.4.4           rjson_0.2.23             curl_7.0.0
## [106] coda_0.19-4.1            nlme_3.1-168             nloptr_2.2.1
## [109] cachem_1.1.0             zoo_1.8-14               GlobalOptions_0.1.2
## [112] stringr_1.5.2            BiocVersion_3.22.0       KernSmooth_2.23-26
## [115] parallel_4.5.1           vipor_0.4.7              AnnotationDbi_1.72.0
## [118] pillar_1.11.1            grid_4.5.1               vctrs_0.6.5
## [121] gplots_3.2.0             slam_0.1-55              BiocSingular_1.26.0
## [124] IHW_1.38.0               beachmat_2.26.0          xtable_1.8-4
## [127] cluster_2.1.8.1          beeswarm_0.4.0           evaluate_1.0.5
## [130] magick_2.9.0             tinytex_0.57             mvtnorm_1.3-3
## [133] cli_3.6.5                locfit_1.5-9.12          compiler_4.5.1
## [136] rlang_1.1.6              crayon_1.5.3             future.apply_1.20.0
## [139] labeling_0.4.3           fdrtool_1.2.18           plyr_1.8.9
## [142] ggbeeswarm_0.7.2         stringi_1.8.7            viridisLite_0.4.2
## [145] BiocParallel_1.44.0      Biostrings_2.78.0        lmerTest_3.1-3
## [148] aod_1.3.3                Matrix_1.7-4             hms_1.1.4
## [151] bit64_4.6.0-1            future_1.67.0            KEGGREST_1.50.0
## [154] statmod_1.5.1            rbibutils_2.3            memoise_2.0.1
## [157] broom_1.0.10             bslib_0.9.0              bit_4.6.0
```

# References

Hu, James X., Hongyu Zhao, and Harrison H. Zhou. 2010. “False Discovery Rate Control with Groups.” *Journal of the American Statistical Association* 105 (491): 1215–27. <https://doi.org/10.1198/jasa.2010.tm09329>.

Ignatiadis, Nikolaos, Bernd Klaus, Judith B. Zaugg, and Wolfgang Huber. 2016. “Data-Driven Hypothesis Weighting Increases Detection Power in Genome-Scale Multiple Testing.” *Nature Methods* 13 (7): 577–80. <https://doi.org/10.1038/nmeth.3885>.