# Overview of the MouseThymusAgeing datasets

Mike Morgan

#### November 4, 2020

# 1 Introduction

The *[MouseThymusAgeing](https://bioconductor.org/packages/3.22/MouseThymusAgeing)* package provides convenient access to the single-cell RNA sequencing (scRNA-seq) datasets from Baran-Gale et al. ([2020](#ref-baran-gale_ageing_2020)). The study used single-cell transcriptomic profiling to resolve how the epithelial composition of the mouse thymus
changes with ageing. The datasets from the paper are provided as count matrices with relevant sample-level and feature-level meta-data. All data
are provided post-processing and QC. The raw sequencing data can be directly acquired from ArrayExpress using accessions
[E-MTAB-8560](https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-8560/) and [E-MTAB-8737](https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-8737/).

# 2 Installation

The package can be installed from Bioconductor. Bioconductor packages can be accessed using the *[BiocManager](https://CRAN.R-project.org/package%3DBiocManager)* package.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MouseThymusAgeing")
```

To use the package, load it in the typical way.

```
library(MouseThymusAgeing)
```

# 3 Processsing Overview

Detailed experimental protocols are available in [the manuscript](https://elifesciences.org/articles/56221) and analytical details are provided
in the accompanying [GitHub repo](https://github.com/WTSA-Homunculus/Ageing2019).

This data package contains 2 single-cell data sets from the paper. The first details the initial transcriptomic profiling of defined TEC
populations using the plate-based SMART-seq2 chemistry. These cells were sorted from mice at 1, 4, 16, 32 and 52 weeks of age using the
following flow cytometry phenotypes:

* mTEClo: Cd45- EpCam+ Ly51- Cd80lo MHCIIlo Dsg3-
* mTEChi: Cd45- EpCam+ Ly51- Cd80hi MHCIIhi Dsg3-
* cTEC: Cd45- EpCam+ Ly51+ Cd80-
* Dsg3+ TEC: Cd45- EpCam+ Ly51- Cd80lo MHCIIlo Dsg3+

In each case cells were sorted from 5 separate mice at each age into a 384 well plate containing lysis buffer, with cells from different ages
and days block sorted into different areas of each plate to minimise the confounding between batch effects, mouse age and sorted subpopulation. The single-cell libraries were prepared according to the [SMART-seq2 protocol](https://doi.org/10.1038/nprot.2014.006) and sequenced on an Illumina
NovaSeq 6000.

The computational processing invovled the following steps:

* Read trimming with trimmomatic, prior to alignment to the mm10 genome with STAR v2.5.3a, and read de-duplication using Picard Tools.
* FeatureCounts was used to count reads on each gene using the Ensembl v95 annotation.
* Poor quality cells were removed based on excess of ERCC92 spiked-in sequences, poor sequencing coverage and low gene-detection.
* Gene counts were normalized using size factors estimated using `computeSumFactors()` function from *[scran](https://bioconductor.org/packages/3.22/scran)* (L. Lun, Bach, and Marioni [2016](#ref-l._lun_pooling_2016)).
* Highly variable genes were identified, and used to subset the log (+1 pseudocount) normalised expression prior to PCA.
* Shared nearest neighbour (SNN) graph building was performed using *[igraph](https://CRAN.R-project.org/package%3Digraph)* and cells were clustered using the Walktrap community
  detection algorithm (Pons and Latapy [2005](#ref-pons_computing_2005)). Clusters were manually annotated based on inspecting the expression of marker genes.

The second dataset contains cells that were profiling from TEC at 8, 20 and 36 weeks old, derived from a transgenic model system that is also able
to lineage trace cells that derive from those that express the thymoproteasomal gene, \(\beta\)-5t. When this gene is expressed it drives
the expression of a fluorescent reporter gene, ZsGreen (ZsG). The mouse is denoted \(\mbox{3xtg}^{\beta5t}\). Each mouse (3 replicates per age)
first had their transgene induced using doxycycline, and 4 weeks later the TEC were collected by flow cytometry in separate ZsG+ and ZsG- groups.
Within each of these groups cells were FAC-sorted into mTEC (Cd45+EpCam+MHCII+Ly51-UEA1+) and cTEC (Cd45+EpCam+Ly51+UEA1+) populations. For this
experiment we made us of recent developments in multiplexing with hashtag oligos (HTO; cell-hashing)(Stoeckius et al. [2018](#ref-stoeckius_cell_2018)). Consequently, the
cells were super-loaded onto the 10X Genomics Chromium chips before library prep and sequencing on an Illumina NovaSeq 6000.

The computational processing for these data is different to above. Specifically:

* Demultiplexing, read alignment, UMI deduplication and feature counting were all performed using *Cellranger* v3.1.0.
* Non-empty droplets were called separately using the `emptyDrops()` from the *[DropletUtils](https://bioconductor.org/packages/3.22/DropletUtils)* (participants in the 1st Human Cell Atlas Jamboree et al. [2019](#ref-lun_emptydrops_2019)).
* Cells were de-multiplexed into specific samples by assigning each cell to its best-matching hashtag oligo using the approach by
  (Stoeckius et al. [2018](#ref-stoeckius_cell_2018)) - this was also able to identify multiplet cells containing multiple HTOs.
* Cells were filtered based on low sequencing coverage and high deviation of mitochondrial content from the population median.
* Size factors were estimated as above using `computeSumFactors()` function from *[scran](https://bioconductor.org/packages/3.22/scran)* (L. Lun, Bach, and Marioni [2016](#ref-l._lun_pooling_2016)), and used for
  normalization with a `log(X + 1)` transformation.
* A SNN-graph was then built using *[igraph](https://CRAN.R-project.org/package%3Digraph)* as above, and cell were also clustered using Walktrap community detection algorithm
  (Pons and Latapy [2005](#ref-pons_computing_2005)). These clusters were annotated with concordant labels from the above data set. The exception being that many more clusters
  were identified, and thus each cluster was suffixed with a number to uniquely identify them.

# 4 Package data format

The SMART-seq2 data is stored in subsets according to the sorting day (numbered 1-5). For the droplet data, the data can be accessed according
to the specific multiplexed samples (6 in total). For the SMART-seq2 the exported object `SMARTseqMetadata` provides the relevant metadata
information for each sorting day, the equivalent object `DropletMetadata` contains the relevant information for each separate sample. Specific
descriptions of each column can be accessed using `?SMARTseqMetadata` and `?DropletMetadata`.

```
head(SMARTseqMetadata, n = 5)
```

```
##   sample  Age Gender ncells
## 1   day1  1wk female     10
## 2   day1  4wk female     19
## 3   day1 16wk female     10
## 4   day1 32wk female     43
## 5   day1 52wk female     52
```

All of the data access functions allow you to select the particular samples or sorting days that you would like to access for the relevant data
set. By loading only the samples or sorting days that you are interested in for your particular analysis, you will save time when downloading
and loading the data, and also reduce memory consumption on your machine.

Droplet single-cell experiments tend to be much larger owing to the ability to encapsulate and process many more cells than in either 96- or 384-well
plates. The droplet scRNA-seq made use of hashtag oligonucleotides to multiplex samples, allowing for replicated experimental design without
breaking the bank.

```
head(DropletMetadata, n = 5)
```

```
##        sample Gender       HTO ncells
## 1 ZsG_1stRun1 female  Wk1_ZsGp   5160
## 2 ZsG_1stRun1 female  Wk4_ZsGp   3902
## 3 ZsG_1stRun1 female Wk16_ZsGp   3798
## 4 ZsG_1stRun2 female  Wk1_ZsGp   3360
## 5 ZsG_1stRun2 female  Wk4_ZsGp   2355
```

## 4.1 Data access

Package data are provided as `SingleCellExperiment` objects, an extension of the Bioconductor `SummarizedExperiment` object for high-throughput
omics experiment data. `SingleCellExperiment` object uses memory-efficient storage and sparse matrices to store the single-cell experiment data,
whilst allowing the layering of additional feature- and cell-wise meta-data to facilitate single-cell analyses. This section will detail how
to access and interact with these objects from the `MouseThymusAgeing` package.

```
smart.sce <- MouseSMARTseqData(samples="day2")
smart.sce
```

```
## class: SingleCellExperiment
## dim: 48801 661
## metadata(0):
## assays(1): counts
## rownames(48801): ERCC-00002 ERCC-00003 ... ENSMUSG00000064371
##   ENSMUSG00000064372
## rowData names(6): Geneid Chr ... Strand Length
## colnames(661): B1.B002294.2_32.4.52.1_S109 B10.B002294.2_32.4.52.1_S118
##   ... P9.B002284.2_52.1.32.1_S9 P9.B002294.2_32.4.52.1_S153
## colData names(11): CellID ClusterID ... SubType sizeFactor
## reducedDimNames(1): PCA
## mainExpName: NULL
## altExpNames(0):
```

The gene counts are stored in the `assays(sce, "counts")` slot, which can be accessed using the convenience function `counts`. The gene counts are
stored in a memory efficient sparse matrix class from the *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* package.

```
head(counts(smart.sce)[, 1:10])
```

```
##            B1.B002294.2_32.4.52.1_S109 B10.B002294.2_32.4.52.1_S118
## ERCC-00002                        2071                         2739
## ERCC-00003                           1                           70
## ERCC-00004                         179                          533
## ERCC-00009                         507                            0
## ERCC-00012                           0                            0
## ERCC-00013                           0                            0
##            B11.B002284.2_52.1.32.1_S275 B11.B002294.2_32.4.52.1_S119
## ERCC-00002                         2612                         1722
## ERCC-00003                           47                          140
## ERCC-00004                          193                          210
## ERCC-00009                          898                            0
## ERCC-00012                            0                            0
## ERCC-00013                            0                            0
##            B13.B002294.2_32.4.52.1_S121 B14.B002284.2_52.1.32.1_S278
## ERCC-00002                         1853                         1987
## ERCC-00003                          130                          111
## ERCC-00004                          417                           60
## ERCC-00009                          487                            0
## ERCC-00012                            0                            0
## ERCC-00013                            0                            0
##            B14.B002294.2_32.4.52.1_S122 B14.B002295.2_1.16.4.1_S206
## ERCC-00002                         1788                       14714
## ERCC-00003                          112                          13
## ERCC-00004                          183                        1251
## ERCC-00009                          479                           0
## ERCC-00012                            0                           0
## ERCC-00013                            0                           0
##            B16.B002284.2_52.1.32.1_S280 B17.B002283.2_4.52.16.1_S197
## ERCC-00002                         2458                         3697
## ERCC-00003                           35                          150
## ERCC-00004                           62                          387
## ERCC-00009                          236                            0
## ERCC-00012                            0                            0
## ERCC-00013                            0                            0
```

The normalisation factors per cell can be accessed using the `sizeFactors()` function.

```
head(sizeFactors((smart.sce)))
```

```
## [1] 1.3178659 1.7034129 1.5202621 0.4705083 2.2748982 1.8011869
```

These are used to normalise the data. To generate single-cell expression values on a log-normal scale, we can apply the `logNormCounts` from the
*[scuttle](https://bioconductor.org/packages/3.22/scuttle)* package. This will add the `logcounts` entry to the `assays` slot in our object.

```
library(scuttle)
smart.sce <- logNormCounts(smart.sce)
```

With these normalised counts we can perform our standard down-stream analytical tasks, such as identifying highly variable genes, projecting
cells into a reduced dimensional space and clustering using a nearest-neighbour graph. You can further inspect the cell-wise meta-data attached
to each dataset, stored in the `colData` for each *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* object.

```
head(colData(smart.sce))
```

```
## DataFrame with 6 rows and 11 columns
##                                              CellID ClusterID    Position
##                                         <character> <integer> <character>
## B1.B002294.2_32.4.52.1_S109  B1.B002294.2_32.4.52..         8          B1
## B10.B002294.2_32.4.52.1_S118 B10.B002294.2_32.4.5..         2         B10
## B11.B002284.2_52.1.32.1_S275 B11.B002284.2_52.1.3..         2         B11
## B11.B002294.2_32.4.52.1_S119 B11.B002294.2_32.4.5..         2         B11
## B13.B002294.2_32.4.52.1_S121 B13.B002294.2_32.4.5..         2         B13
## B14.B002284.2_52.1.32.1_S278 B14.B002284.2_52.1.3..         2         B14
##                                  PlateID    Column         Row    SortType
##                              <character> <integer> <character> <character>
## B1.B002294.2_32.4.52.1_S109      B002294         1           B      mTEClo
## B10.B002294.2_32.4.52.1_S118     B002294        10           B      mTEClo
## B11.B002284.2_52.1.32.1_S275     B002284        11           B      mTEClo
## B11.B002294.2_32.4.52.1_S119     B002294        11           B      mTEClo
## B13.B002294.2_32.4.52.1_S121     B002294        13           B      mTEClo
## B14.B002284.2_52.1.32.1_S278     B002284        14           B      mTEClo
##                                SortDay         Age          SubType sizeFactor
##                              <integer> <character>      <character>  <numeric>
## B1.B002294.2_32.4.52.1_S109          2        32wk             nTEC   0.898811
## B10.B002294.2_32.4.52.1_S118         2         4wk Intertypical TEC   1.161762
## B11.B002284.2_52.1.32.1_S275         2         1wk Intertypical TEC   1.036849
## B11.B002294.2_32.4.52.1_S119         2         4wk Intertypical TEC   0.320896
## B13.B002294.2_32.4.52.1_S121         2         4wk Intertypical TEC   1.551526
## B14.B002284.2_52.1.32.1_S278         2         1wk Intertypical TEC   1.228445
```

Details of what information is stored can be found in the documentation using `?DropletMetadata` and `?SMARTseqMetada`. In each object we also
have the pre-computed reduced dimensions that can be accessed through the `reducedDim(<sce>, "PCA")` slot.

# 5 Session Information

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
##  [1] scuttle_1.20.0              MouseThymusAgeing_1.18.0
##  [3] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      xfun_0.54            bslib_0.9.0
##  [4] httr2_1.2.1          lattice_0.22-7       vctrs_0.6.5
##  [7] tools_4.5.1          parallel_4.5.1       curl_7.0.0
## [10] tibble_3.3.0         AnnotationDbi_1.72.0 RSQLite_2.4.3
## [13] blob_1.2.4           pkgconfig_2.0.3      Matrix_1.7-4
## [16] dbplyr_2.5.1         lifecycle_1.0.4      compiler_4.5.1
## [19] Biostrings_2.78.0    codetools_0.2-20     htmltools_0.5.8.1
## [22] sass_0.4.10          yaml_2.3.10          crayon_1.5.3
## [25] pillar_1.11.1        jquerylib_0.1.4      BiocParallel_1.44.0
## [28] DelayedArray_0.36.0  cachem_1.1.0         abind_1.4-8
## [31] ExperimentHub_3.0.0  AnnotationHub_4.0.0  tidyselect_1.2.1
## [34] digest_0.6.37        purrr_1.1.0          dplyr_1.1.4
## [37] bookdown_0.45        BiocVersion_3.22.0   fastmap_1.2.0
## [40] grid_4.5.1           cli_3.6.5            SparseArray_1.10.1
## [43] magrittr_2.0.4       S4Arrays_1.10.0      withr_3.0.2
## [46] filelock_1.0.3       rappdirs_0.3.3       bit64_4.6.0-1
## [49] rmarkdown_2.30       XVector_0.50.0       httr_1.4.7
## [52] bit_4.6.0            png_0.1-8            beachmat_2.26.0
## [55] memoise_2.0.1        evaluate_1.0.5       knitr_1.50
## [58] BiocFileCache_3.0.0  rlang_1.1.6          Rcpp_1.1.0
## [61] glue_1.8.0           DBI_1.2.3            BiocManager_1.30.26
## [64] jsonlite_2.0.0       R6_2.6.1
```

# References

Baran-Gale, Jeanette, Michael D Morgan, Stefano Maio, Fatima Dhalla, Irene Calvo-Asensio, Mary E Deadman, Adam E Handel, et al. 2020. “Ageing Compromises Mouse Thymus Function and Remodels Epithelial Cell Differentiation.” *eLife* 9 (August). <https://doi.org/10.7554/eLife.56221>.

L. Lun, Aaron T., Karsten Bach, and John C. Marioni. 2016. “Pooling Across Cells to Normalize Single-Cell RNA Sequencing Data with Many Zero Counts.” *Genome Biology* 17 (1). <https://doi.org/10.1186/s13059-016-0947-7>.

participants in the 1st Human Cell Atlas Jamboree, Aaron T. L. Lun, Samantha Riesenfeld, Tallulah Andrews, The Phuong Dao, Tomas Gomes, and John C. Marioni. 2019. “EmptyDrops: Distinguishing Cells from Empty Droplets in Droplet-Based Single-Cell RNA Sequencing Data.” *Genome Biology* 20 (1). <https://doi.org/10.1186/s13059-019-1662-y>.

Pons, P., and M. Latapy. 2005. “Computing Communities in Large Networks Using Random Walks (Long Version).” *ArXiv Physics E-Prints*, December.

Stoeckius, Marlon, Shiwei Zheng, Brian Houck-Loomis, Stephanie Hao, Bertrand Z. Yeung, William M. Mauck, Peter Smibert, and Rahul Satija. 2018. “Cell Hashing with Barcoded Antibodies Enables Multiplexing and Doublet Detection for Single Cell Genomics.” *Genome Biology* 19 (1). <https://doi.org/10.1186/s13059-018-1603-1>.