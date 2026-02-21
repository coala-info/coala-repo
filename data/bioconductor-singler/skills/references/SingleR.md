# Using SingleR to annotate single-cell RNA-seq data

Aaron Lun\*, Jared M. Andrews1, Friederike Dündar2 and Daniel Bunis3

1Washington University in St. Louis, School of Medicine, St. Louis, MO, USA
2Applied Bioinformatics Core, Weill Cornell Medicine
3Bakar Computational Health Sciences Institute, University of California San Francisco, San Francisco, CA

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: June 14th, 2020

#### Package

SingleR 2.12.0

# 1 Introduction

*[SingleR](https://bioconductor.org/packages/3.22/SingleR)* is an automatic annotation method for single-cell RNA sequencing (scRNAseq) data (Aran et al. [2019](#ref-aran2019reference)).
Given a reference dataset of samples (single-cell or bulk) with known labels,
it labels new cells from a test dataset based on similarity to the reference.
Thus, the burden of manually interpreting clusters and defining marker genes only has to be done once,
for the reference dataset, and this biological knowledge can be propagated to new datasets in an automated manner.

To keep things brief, this vignette only provides a brief summary of the basic capabilities of *[SingleR](https://bioconductor.org/packages/3.22/SingleR)*.
However, the package also provides more advanced functionality that includes the use of multiple references simultaneously,
manipulating the cell ontology and improving performance on big datasets.
Readers are referred to the [book](https://bioconductor.org/books/devel/SingleRBook/) for more details.

# 2 Using built-in references

The easiest way to use *[SingleR](https://bioconductor.org/packages/3.22/SingleR)* is to annotate cells against built-in references.
In particular, the *[celldex](https://bioconductor.org/packages/3.22/celldex)* package provides access to several reference datasets
(mostly derived from bulk RNA-seq or microarray data) through dedicated retrieval functions.
Here, we will use the Human Primary Cell Atlas (Mabbott et al. [2013](#ref-hpcaRef)),
represented as a `SummarizedExperiment` object containing a matrix of log-expression values with sample-level labels.

```
library(celldex)
hpca.se <- HumanPrimaryCellAtlasData()
hpca.se
```

```
## class: SummarizedExperiment
## dim: 19363 713
## metadata(0):
## assays(1): logcounts
## rownames(19363): A1BG A1BG-AS1 ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(713): GSM112490 GSM112491 ... GSM92233 GSM92234
## colData names(3): label.main label.fine label.ont
```

Our test dataset consists of some human embryonic stem cells (La Manno et al. [2016](#ref-lamanno2016molecular)) from the *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* package.
For the sake of speed, we will only label the first 100 cells from this dataset.
The test dataset does not need to be log-transformed, as only the ranks will be used by `SingleR()`.

```
library(scRNAseq)
hESCs <- LaMannoBrainData('human-es')
hESCs <- hESCs[,1:100]
```

We use our `hpca.se` reference to annotate each cell in `hESCs` via the `SingleR()` function.
This identifies marker genes from the reference and uses them to compute assignment scores (based on the Spearman correlation across markers) for each cell in the test dataset against each label in the reference.
The label with the highest score is the assigned to the test cell,
possibly with further fine-tuning to resolve closely related labels.

```
library(SingleR)
pred.hesc <- SingleR(test = hESCs, ref = hpca.se, assay.type.test=1,
    labels = hpca.se$label.main)
```

Each row of the output `DataFrame` contains prediction results for a single cell.
Labels are shown before (`labels`) and after pruning (`pruned.labels`), along with the associated scores.

```
pred.hesc
```

```
## DataFrame with 100 rows and 4 columns
##                                          scores               labels delta.next
##                                        <matrix>          <character>  <numeric>
## 1772122_301_C02  0.347652:0.109547:0.123901:... Neuroepithelial_cell 0.08332864
## 1772122_180_E05  0.361187:0.134934:0.148672:...              Neurons 0.07283500
## 1772122_300_H02  0.446411:0.190084:0.222594:... Neuroepithelial_cell 0.13882912
## 1772122_180_B09  0.373512:0.143537:0.164743:... Neuroepithelial_cell 0.00317443
## 1772122_180_G04  0.357341:0.126511:0.141987:... Neuroepithelial_cell 0.09717938
## ...                                         ...                  ...        ...
## 1772122_299_E07 0.371989:0.169379:0.1986877:... Neuroepithelial_cell  0.0837521
## 1772122_180_D02 0.353314:0.115864:0.1374981:... Neuroepithelial_cell  0.0842804
## 1772122_300_D09 0.348789:0.136732:0.1303042:... Neuroepithelial_cell  0.0595056
## 1772122_298_F09 0.332361:0.141439:0.1437860:... Neuroepithelial_cell  0.1200606
## 1772122_302_A11 0.324928:0.101609:0.0949826:...            Astrocyte  0.0509478
##                        pruned.labels
##                          <character>
## 1772122_301_C02 Neuroepithelial_cell
## 1772122_180_E05              Neurons
## 1772122_300_H02 Neuroepithelial_cell
## 1772122_180_B09 Neuroepithelial_cell
## 1772122_180_G04 Neuroepithelial_cell
## ...                              ...
## 1772122_299_E07 Neuroepithelial_cell
## 1772122_180_D02 Neuroepithelial_cell
## 1772122_300_D09 Neuroepithelial_cell
## 1772122_298_F09 Neuroepithelial_cell
## 1772122_302_A11            Astrocyte
```

```
# Summarizing the distribution:
table(pred.hesc$labels)
```

```
##
##            Astrocyte Neuroepithelial_cell              Neurons
##                   14                   81                    5
```

At this point, it is worth noting that *[SingleR](https://bioconductor.org/packages/3.22/SingleR)* is workflow/package agnostic.
The above example uses `SummarizedExperiment` objects, but the same functions will accept any (log-)normalized expression matrix.

# 3 Using single-cell references

Here, we will use two human pancreas datasets from the *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* package.
The aim is to use one pre-labelled dataset to annotate the other unlabelled dataset.
First, we set up the Muraro et al. ([2016](#ref-muraro2016singlecell)) dataset to be our reference.

```
library(scRNAseq)
sceM <- MuraroPancreasData()

# One should normally do cell-based quality control at this point, but for
# brevity's sake, we will just remove the unlabelled libraries here.
sceM <- sceM[,!is.na(sceM$label)]

# SingleR() expects reference datasets to be normalized and log-transformed.
library(scuttle)
sceM <- logNormCounts(sceM)
```

We then set up our test dataset from Grun et al. ([2016](#ref-grun2016denovo)).
To speed up this demonstration, we will subset to the first 100 cells.

```
sceG <- GrunPancreasData()
sceG <- sceG[,colSums(counts(sceG)) > 0] # Remove libraries with no counts.

# Log-transformation is not actually required for SingleR itself,
# but we'll do it anyway as we need it for plotting heatmaps later.
sceG <- logNormCounts(sceG)
```

We then run `SingleR()` as described previously but with a marker detection mode that considers the variance of expression across cells.
Here, we will use the Wilcoxon ranked sum test to identify the top markers for each pairwise comparison between labels.
This is slower but more appropriate for single-cell data compared to the default marker detection algorithm (which may fail for low-coverage data where the median is frequently zero).

```
pred.grun <- SingleR(test=sceG, ref=sceM, labels=sceM$label, de.method="wilcox")
table(pred.grun$labels)
```

```
##
##      acinar       alpha        beta       delta        duct endothelial
##         722         228         233          65         345          34
##     epsilon mesenchymal          pp     unclear
##           2          49          36           4
```

# 4 Annotation diagnostics

`plotScoreHeatmap()` displays the scores for all cells across all reference labels,
which allows users to inspect the confidence of the predicted labels across the dataset.
Ideally, each cell (i.e., column of the heatmap) should have one score that is obviously larger than the rest,
indicating that it is unambiguously assigned to a single label.
A spread of similar scores for a given cell indicates that the assignment is uncertain,
though this may be acceptable if the uncertainty is distributed across similar cell types that cannot be easily resolved.

```
plotScoreHeatmap(pred.grun)
```

![](data:image/png;base64...)

Another diagnostic is based on the per-cell “deltas”, i.e., the difference between the score for the assigned label and the median across all labels for each cell.
Low deltas indicate that the assignment is uncertain, which is especially relevant if the cell’s true label does not exist in the reference.
We can inspect these deltas across cells for each label using the `plotDeltaDistribution()` function.

```
plotDeltaDistribution(pred.grun, ncol = 3)
```

![](data:image/png;base64...)

The `pruneScores()` function will remove potentially poor-quality or ambiguous assignments based on the deltas.
The minimum threshold on the deltas is defined using an outlier-based approach that accounts for differences in the scale of the correlations in various contexts - see `?pruneScores` for more details.
`SingleR()` will also report the pruned scores automatically in the `pruned.labels` field where low-quality assignments are replaced with `NA`.

```
summary(is.na(pred.grun$pruned.labels))
```

```
##    Mode   FALSE    TRUE
## logical    1660      58
```

Finally, a simple yet effective diagnostic is to examine the expression of the marker genes for each label in the test dataset.
We extract the identity of the markers from the metadata of the `SingleR()` results and use them in the `plotMarkerHeatmap()` function, as shown below for beta cell markers.
If a cell in the test dataset is confidently assigned to a particular label, we would expect it to have strong expression of that label’s markers.
At the very least, it should exhibit upregulation of those markers relative to cells assigned to other labels.

```
plotMarkerHeatmap(pred.grun, sceG, label="beta")
```

![](data:image/png;base64...)

# 5 FAQs

*How can I use this with my `Seurat`, `SingleCellExperiment`, or `cell_data_set` object?*

*[SingleR](https://bioconductor.org/packages/3.22/SingleR)* is workflow agnostic - all it needs is normalized counts.
An example showing how to map its results back to common single-cell data objects is available in the [README](https://github.com/SingleR-inc/SingleR/blob/master/README.md).

*Where can I find reference sets appropriate for my data?*

*[celldex](https://bioconductor.org/packages/3.22/celldex)* contains many built-in references that were previously in *[SingleR](https://bioconductor.org/packages/3.22/SingleR)*
but have been migrated into a separate package for more general use by other Bioconductor packages.
*[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* contains many single-cell datasets, many of which contain the authors’ manual annotations.
*[ArrayExpress](https://bioconductor.org/packages/3.22/ArrayExpress)* and *[GEOquery](https://bioconductor.org/packages/3.22/GEOquery)* can be used to download any of the bulk or single-cell datasets in [ArrayExpress](https://www.ebi.ac.uk/arrayexpress) or [GEO](https://www.ncbi.nlm.nih.gov/geo/), respectively.

*Where can I get more help?*

It is likely that your questions is already answered by the function documentation (e.g., `?SingleR`).
Further explanations on the reasoning behind certain functions can be found in the [book](https://bioconductor.org/books/devel/SingleRBook/).
If this is not sufficient, we recommend posting an issue on the [Bioconductor support site](https://support.bioconductor.org)
or [the GitHub repository](https://github.com/SingleR-inc/SingleR) for this package.
Be sure to include your session information and a minimal reproducible example.

# 6 Session information

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
##  [1] scuttle_1.20.0              SingleR_2.12.0
##  [3] scRNAseq_2.23.1             SingleCellExperiment_1.32.0
##  [5] celldex_1.19.0              SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                 bitops_1.0-9
##   [3] gridExtra_2.3             httr2_1.2.1
##   [5] rlang_1.1.6               magrittr_2.0.4
##   [7] gypsum_1.6.0              compiler_4.5.1
##   [9] RSQLite_2.4.3             GenomicFeatures_1.62.0
##  [11] DelayedMatrixStats_1.32.0 png_0.1-8
##  [13] vctrs_0.6.5               ProtGenerics_1.42.0
##  [15] pkgconfig_2.0.3           crayon_1.5.3
##  [17] fastmap_1.2.0             magick_2.9.0
##  [19] dbplyr_2.5.1              XVector_0.50.0
##  [21] labeling_0.4.3            Rsamtools_2.26.0
##  [23] rmarkdown_2.30            UCSC.utils_1.6.0
##  [25] tinytex_0.57              bit_4.6.0
##  [27] xfun_0.53                 beachmat_2.26.0
##  [29] cachem_1.1.0              cigarillo_1.0.0
##  [31] GenomeInfoDb_1.46.0       jsonlite_2.0.0
##  [33] blob_1.2.4                rhdf5filters_1.22.0
##  [35] DelayedArray_0.36.0       Rhdf5lib_1.32.0
##  [37] BiocParallel_1.44.0       parallel_4.5.1
##  [39] R6_2.6.1                  RColorBrewer_1.1-3
##  [41] bslib_0.9.0               rtracklayer_1.70.0
##  [43] jquerylib_0.1.4           Rcpp_1.1.0
##  [45] bookdown_0.45             knitr_1.50
##  [47] Matrix_1.7-4              tidyselect_1.2.1
##  [49] dichromat_2.0-0.1         viridis_0.6.5
##  [51] abind_1.4-8               yaml_2.3.10
##  [53] codetools_0.2-20          curl_7.0.0
##  [55] alabaster.sce_1.10.0      lattice_0.22-7
##  [57] tibble_3.3.0              withr_3.0.2
##  [59] S7_0.2.0                  KEGGREST_1.50.0
##  [61] evaluate_1.0.5            BiocFileCache_3.0.0
##  [63] alabaster.schemas_1.10.0  ExperimentHub_3.0.0
##  [65] Biostrings_2.78.0         pillar_1.11.1
##  [67] BiocManager_1.30.26       filelock_1.0.3
##  [69] RCurl_1.98-1.17           ggplot2_4.0.0
##  [71] BiocVersion_3.22.0        ensembldb_2.34.0
##  [73] scales_1.4.0              scrapper_1.4.0
##  [75] sparseMatrixStats_1.22.0  alabaster.base_1.10.0
##  [77] glue_1.8.0                alabaster.ranges_1.10.0
##  [79] pheatmap_1.0.13           alabaster.matrix_1.10.0
##  [81] lazyeval_0.2.2            tools_4.5.1
##  [83] AnnotationHub_4.0.0       BiocIO_1.20.0
##  [85] BiocNeighbors_2.4.0       GenomicAlignments_1.46.0
##  [87] XML_3.99-0.19             rhdf5_2.54.0
##  [89] grid_4.5.1                AnnotationDbi_1.72.0
##  [91] HDF5Array_1.38.0          restfulr_0.0.16
##  [93] cli_3.6.5                 rappdirs_0.3.3
##  [95] viridisLite_0.4.2         S4Arrays_1.10.0
##  [97] dplyr_1.1.4               AnnotationFilter_1.34.0
##  [99] gtable_0.3.6              alabaster.se_1.10.0
## [101] sass_0.4.10               digest_0.6.37
## [103] SparseArray_1.10.0        farver_2.1.2
## [105] rjson_0.2.23              memoise_2.0.1
## [107] htmltools_0.5.8.1         lifecycle_1.0.4
## [109] h5mread_1.2.0             httr_1.4.7
## [111] bit64_4.6.0-1
```

# References

Aran, D., A. P. Looney, L. Liu, E. Wu, V. Fong, A. Hsu, S. Chak, et al. 2019. “Reference-based analysis of lung single-cell sequencing reveals a transitional profibrotic macrophage.” *Nat. Immunol.* 20 (2): 163–72.

Grun, D., M. J. Muraro, J. C. Boisset, K. Wiebrands, A. Lyubimova, G. Dharmadhikari, M. van den Born, et al. 2016. “De Novo Prediction of Stem Cell Identity using Single-Cell Transcriptome Data.” *Cell Stem Cell* 19 (2): 266–77.

La Manno, G., D. Gyllborg, S. Codeluppi, K. Nishimura, C. Salto, A. Zeisel, L. E. Borm, et al. 2016. “Molecular Diversity of Midbrain Development in Mouse, Human, and Stem Cells.” *Cell* 167 (2): 566–80.

Mabbott, Neil A., J. K. Baillie, Helen Brown, Tom C. Freeman, and David A. Hume. 2013. “An expression atlas of human primary cells: Inference of gene function from coexpression networks.” *BMC Genomics* 14. <https://doi.org/10.1186/1471-2164-14-632>.

Muraro, M. J., G. Dharmadhikari, D. Grun, N. Groen, T. Dielen, E. Jansen, L. van Gurp, et al. 2016. “A Single-Cell Transcriptome Atlas of the Human Pancreas.” *Cell Syst* 3 (4): 385–94.