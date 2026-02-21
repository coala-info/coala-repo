# Overview of the MouseGastrulationData datasets

Jonathan Griffiths and Aaron Lun

#### Revised: September 14, 2022

# 1 Introduction

The *[MouseGastrulationData](https://bioconductor.org/packages/3.22/MouseGastrulationData)* package provides convenient access to various -omics datasets from mouse gastrulation and organogeneis.
These datasets are provided in a highly annotated format, so can be used very easily to probe different biological questions, or for methods development.
The primary datasets are the single-cell RNA sequencing (scRNA-seq) datasets from Pijuan-Sala et al. ([2019](#ref-pijuan-sala_single-cell_2019)) and Guibentif et al. ([n.d.](#ref-guibentif2020diverse)).
These include an atlas of embryonic development (`EmbryoAtlasData()`) with high sampling density across time, alongside chimaera experiments, that include gene knockouts in an *in vivo* system.
These Datasets are provided as count matrices with additional feature- and sample-level metadata after processing.
Raw sequencing data can be acquired from ArrayExpress accession [E-MTAB-6967](https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-6967/) for the atlas.

In addition, the package also provides single-nucleus ATAC-seq data from E8.25 embryos (Pijuan-Sala et al. ([2020](#ref-BPS_atac))), and seqFISH (i.e. spatial transcriptomic) data from E8.5 embryos (Lohoff et al. ([2020](#ref-lohoff_highly_2020))).

# 2 Installation

The package may be installed from Bioconductor.
Bioconductor packages can be accessed using the *[BiocManager](https://CRAN.R-project.org/package%3DBiocManager)* package.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MouseGastrulationData")
```

*Bioconductor* devel includes the most recent datasets and changes to the package.
Instructions for installation of *Bioconductor* devel are available [on their website](https://www.bioconductor.org/developers/how-to/useDevel/).

To use the package, load it in the typical way.

```
library(MouseGastrulationData)
```

# 3 Processing overview of the scRNA-seq atlas

Detailed methods are available in the methods that accompany [the paper](https://doi.org/10.1038/s41586-019-0933-9),
or from the code in the corresponding [Github repository](https://github.com/MarioniLab/EmbryoTimecourse2018/).
Briefly, whole embryos were dissociated at timepoints between embryonic days (E) 6.5 and 8.5 of development.
Libraries were generated using the 10x Genomics Chromium platform (v1 chemistry) and sequenced on the Illumina HiSeq 2500.
The computational analysis involved a number of steps:

* Demultiplexing, read alignment and feature quantification was performed with *Cellranger* using Ensembl 92 genome annotation.
* Swapped molecules were excluded using the `swappedDrops()` function from *[DropletUtils](https://bioconductor.org/packages/3.22/DropletUtils)* (Griffiths et al. [2018](#ref-griffiths2018detection)).
* Cell-containing droplets were called using the `emptyDrops()` function from *[DropletUtils](https://bioconductor.org/packages/3.22/DropletUtils)* (Lun et al. [2019](#ref-lun2019emptydrops)).
* Called cells with aberrant transcriptional features (e.g., high mitochondrial gene content) were filtered out.
* Size factors were computed using the `computeSumFactors()` function from *[scran](https://bioconductor.org/packages/3.22/scran)* (Lun, Bach, and Marioni [2016](#ref-lun2016pooling)).
* Putative doublets were identified and excluded using the `doubletCells()` function from *[scran](https://bioconductor.org/packages/3.22/scran)*.
* Cytoplasm-stripped nuclei were also excluded.
* Batch correction was performed in the principal component space with `fastMNN()` from *[scran](https://bioconductor.org/packages/3.22/scran)* (Haghverdi et al. [2018](#ref-haghverdi2018batch)).
* Clusters were identified using a recursive strategy with `buildSNNGraph()` (from *[scran](https://bioconductor.org/packages/3.22/scran)*)
  and `cluster_louvain` (from *[igraph](https://CRAN.R-project.org/package%3Digraph)*), and were annotated and merged into interpretable units by hand.

# 4 Atlas data format

The data accessible via this package is stored in subsets according to the different 10x samples that were generated.
For the embryo atlas, the exported object `AtlasSampleMetadata` provides metadata information for each of the samples.
Descriptions of the contents of each column can be accessed using `?AtlasSampleMetadata`.

```
head(AtlasSampleMetadata, n = 3)
```

```
##   sample stage pool_index seq_batch ncells
## 1      1  E6.5          1         1    360
## 2      2  E7.5          2         1    356
## 3      3  E7.5          3         1    458
```

All data access functions allow you to select the particular samples you would like to access.
By loading only the samples that you are interested in for your particular analysis, you will save time when downloading and loading the data, and also reduce memory consumption on your machine.

## 4.1 Processed data access

The package provides the dataset in the form of a `SingleCellExperiment` object.
This section details how you can interact with the object.
We load in only one of the samples from the atlas to reduce memory consumption when compiling this vignette.

```
sce <- EmbryoAtlasData(samples = 21)
sce
```

```
## class: SingleCellExperiment
## dim: 29452 4651
## metadata(0):
## assays(1): counts
## rownames(29452): ENSMUSG00000051951 ENSMUSG00000089699 ...
##   ENSMUSG00000096730 ENSMUSG00000095742
## rowData names(2): ENSEMBL SYMBOL
## colnames(4651): cell_52466 cell_52467 ... cell_57115 cell_57116
## colData names(17): cell barcode ... colour sizeFactor
## reducedDimNames(2): pca.corrected umap
## mainExpName: NULL
## altExpNames(0):
```

We use the `counts()` function to retrieve the count matrix.
These are stored as a sparse matrix, as implemented in the *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* package.

```
counts(sce)[6:9, 1:3]
```

```
## 4 x 3 sparse Matrix of class "dgCMatrix"
##                    cell_52466 cell_52467 cell_52468
## ENSMUSG00000104328          .          .          .
## ENSMUSG00000033845          6          8         10
## ENSMUSG00000025903          .          .          .
## ENSMUSG00000104217          .          .          .
```

Size factors for normalisation are present in the object and are accessed with the `sizeFactors()` function.

```
head(sizeFactors(sce))
```

```
## [1] 0.8845695 1.4688375 1.2512019 0.8287969 1.3668086 0.9247460
```

After running *[scuttle](https://bioconductor.org/packages/3.22/scuttle)*’s `logNormCounts` function on the *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* object, normalised or log-transformed counts can be accessed using `logcounts` (or, if `log=FALSE`, `normcounts`).
These are not demonstrated in this vignette to avoid a dependency on *[scuttle](https://bioconductor.org/packages/3.22/scuttle)*.

The MGI symbol and Ensembl gene ID for each gene is stored in the `rowData` of the `SingleCellExperiment` object.
All of this data was processed with Ensembl 92 annotation.

```
head(rowData(sce))
```

```
## DataFrame with 6 rows and 2 columns
##                               ENSEMBL      SYMBOL
##                           <character> <character>
## ENSMUSG00000051951 ENSMUSG00000051951        Xkr4
## ENSMUSG00000089699 ENSMUSG00000089699      Gm1992
## ENSMUSG00000102343 ENSMUSG00000102343     Gm37381
## ENSMUSG00000025900 ENSMUSG00000025900         Rp1
## ENSMUSG00000025902 ENSMUSG00000025902       Sox17
## ENSMUSG00000104328 ENSMUSG00000104328     Gm37323
```

The `colData` contains cell-specific attributes.
The meaning of each field is detailed in the function documentation (`?EmbryoAtlasData`).

```
head(colData(sce))
```

```
## DataFrame with 6 rows and 17 columns
##                   cell        barcode    sample      pool              stage
##            <character>    <character> <integer> <integer>        <character>
## cell_52466  cell_52466 AAACATACACGGAG        21        17 mixed_gastrulation
## cell_52467  cell_52467 AAACATACCCAACA        21        17 mixed_gastrulation
## cell_52468  cell_52468 AAACATACTTGCGA        21        17 mixed_gastrulation
## cell_52469  cell_52469 AAACATTGATCGGT        21        17 mixed_gastrulation
## cell_52470  cell_52470 AAACATTGCTTATC        21        17 mixed_gastrulation
## cell_52471  cell_52471 AAACATTGGTTCGA        21        17 mixed_gastrulation
##            sequencing.batch     theiler doub.density   doublet   cluster
##                   <integer> <character>    <numeric> <logical> <integer>
## cell_52466                2      TS9-10    0.0315539     FALSE        14
## cell_52467                2      TS9-10    0.1362419     FALSE         3
## cell_52468                2      TS9-10    0.7468976     FALSE         2
## cell_52469                2      TS9-10    0.2704532     FALSE         1
## cell_52470                2      TS9-10    0.2226039     FALSE        19
## cell_52471                2      TS9-10    0.3261519     FALSE         5
##            cluster.sub cluster.stage cluster.theiler  stripped
##              <integer>     <integer>       <integer> <logical>
## cell_52466           2             5               5     FALSE
## cell_52467           6            12              12     FALSE
## cell_52468           3             3               3     FALSE
## cell_52469           3             1               1     FALSE
## cell_52470           1             5               5     FALSE
## cell_52471           1             4               4     FALSE
##                          celltype      colour sizeFactor
##                       <character> <character>  <numeric>
## cell_52466    Blood progenitors 2      c9a997   0.884569
## cell_52467           ExE ectoderm      989898   1.468838
## cell_52468               Epiblast      635547   1.251202
## cell_52469   Rostral neurectoderm      65A83E   0.828797
## cell_52470 Haematoendothelial p..      FBBE92   1.366809
## cell_52471       Nascent mesoderm      C594BF   0.924746
```

Batch-corrected PCA representations of the data are available via the `reducedDim` function, in the `pca.corrected` slot.
This representation contains `NA` values for cells that are doublets, or cytoplasm-stripped nuclei.

A vector of celltype colours (as used in the paper) is also provided in the exported object `EmbryoCelltypeColours`.
Its use is shown below.

```
#exclude technical artefacts
singlets <- which(!(colData(sce)$doublet | colData(sce)$stripped))
plot(
    x = reducedDim(sce, "umap")[singlets, 1],
    y = reducedDim(sce, "umap")[singlets, 2],
    col = EmbryoCelltypeColours[colData(sce)$celltype[singlets]],
    pch = 19,
    xaxt = "n", yaxt = "n",
    xlab = "UMAP1", ylab = "UMAP2"
)
```

![](data:image/png;base64...)

If you would like to use spliced/unspliced/ambiguously spliced count matrices for the atlas data, these can be accessed using the `get.spliced` argument, as shown below.
Spliced count matrices will be stored as separate entries in the `assays` slot.

```
sce <- EmbryoAtlasData(samples=21, get.spliced=TRUE)
names(assays(sce))
```

```
## [1] "counts"           "spliced_counts"   "unspliced_counts" "ambiguous_counts"
```

## 4.2 Raw data access

Unfiltered count matrices are also available from *[MouseGastrulationData](https://bioconductor.org/packages/3.22/MouseGastrulationData)*.
This refers to count matrices where swapped molecules have been removed but no cells have been called.
They can be obtained using the `EmbryoAtlasData()` function and are returned as `SingleCellExperiment` objects.

```
unfilt <- EmbryoAtlasData(type="raw", samples=c(1:2))
sapply(unfilt, dim)
```

```
##           1      2
## [1,]  29452  29452
## [2,] 117107 107802
```

These unfiltered matrices may be useful if you want to perform tests of cell-calling analyses,
or analyses which use the ambient pool of RNA in 10x samples.
Note that empty columns are excluded from these matrices.

# 5 Chimera data information

## 5.1 Background

Data from experiments involving chimeric embryos in Pijuan-Sala et al. ([2019](#ref-pijuan-sala_single-cell_2019)) and Guibentif et al. ([n.d.](#ref-guibentif2020diverse)) are also available from this package.
In these embryos, a population of fluorescent embryonic stem cells were injected into wild-type E3.5 mouse embryos.
The embryos were then returned to a parent mouse, and allowed to develop normally until collection.
The cells were flow-sorted to purify host and injected populations,
libraries were generated using 10x version 2 chemistry and sequencing was performed on the HiSeq 4000.

Chimeras are especially effective for studying the effect of knockouts of essential developmental genes.
We inject stem cells that possess a knockout of a particular gene, and allow the resulting chimeric embryo to develop.
Both injected and host cells contribute to the different tissues in the mouse.
The presence of the wild-type host cells allows the embryo to compensate and avoid gross developmental failures,
while cells with the knockout are also captured, and their aberrant behaviour can be studied.

## 5.2 Available datasets

The package contains three chimeric datasets:

* Wild-type chimeras involving ten samples, from five independant embryo pools at two timepoints.
  The injected wild-type cells differ only in the insertion of the *td-Tomato* construct.
  These data are useful for identifying properties of a typical chimera in *scRNAseq* data.
  Raw sequencing data are available at [E-MTAB-7324](https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-7324/) for samples 1-6, and [E-MTAB-8812](https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-8812/) for samples 7-10.
  The data can be accessed using the `WTChimeraData()` function.
* *Tal1* knockout chimeras involving four samples, from one embryo pool at one timepoint.
  The injected cells in the *Tal1* chimeras have knockouts for the *Tal1* gene.
  They also contain the *td-Tomato* construct.
  Raw sequencing data are available at [E-MTAB-7325](https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-7325/).
  The data can be accessed using the `Tal1ChimeraData()` function.
* *T* (*Brachyury*) knockout chimeras involving sixteen samples, from eight embryo pools at two timepoints.
  The injected cells in the *T* chimeras have knockouts for the *T* gene.
  They also contain the *td-Tomato* construct.
  Raw sequencing data are available at [E-MTAB-8811](https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-8811/).
  The data can be accessed using the `TChimeraData()` function.

The processed data for each experiment are provided as a `SingleCellExperiment`, as for the previously described atlas data.
However, there are a few small differences:

* They contain an extra feature for expression of the *td-Tomato*.
* Cells derived from the injected cells (and thus are positive for *td-Tomato*) are marked in the `colData` field `tomato`.
* Information for the proper pairing of samples from the same embryo pools can be found in the `colData` field `pool`.
* Spliced count matrices are not provided.

There may also be additional columns in the cell metadata for individual experiments, the meanings of which are described in the help pages for each function.
Unfiltered count matrices are also provided for each sample in these datasets.

# 6 snATAC-seq data information

Data from Pijuan-Sala et al. ([2020](#ref-BPS_atac)) is available in this package in the `BPSATACData()` function.
As the package authors were not involved in this study, we leave it to users to familiarise themselves with the methods used in that paper, [linked here](https://pubmed.ncbi.nlm.nih.gov/32231307/).
Because this data is measured in units of open chromatin, its format is quite different to the other datasets, so it is advised to consult the manual page for the function for more information.
Raw sequencing data is available at GEO accession [GSE133244](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE133244).

# 7 seqFISH data information

Data from Lohoff et al. ([2020](#ref-lohoff_highly_2020)) is available in this package in the `LohoffSeqFISHData()` function.
Methods for the generation of this data may be found in their [biorXiv submission](https://www.biorxiv.org/content/10.1101/2020.11.20.391896v1).
This data is provided as a *[SpatialExperiment](https://bioconductor.org/packages/3.22/SpatialExperiment)* object.
This includes the locations of individual RNA molecules within cells, and also segmentation masks for each cell.
Segmentation masks were determined from cell membrane staining, not from simple distance-to-nuclei methods, which is a unique aspect of this dataset (at the time of its publication).
See the function manual page for information on how this data is delivered.

# 8 10X multiome data information

Data from Argelaguet et al. ([2022](#ref-ricard_multiome)) is available in the `RAMultiomeData()` function.
This dataset contains both RNA expression and chromatin accessibility data from the same cells, from gastrulation embryos of various timepoints.
ATAC-seq data is available via a gene promoter accessibility score (`altExp(sce, "TSS_gene_score")`) and genome-wide peak presence (`altExp(sce, "ATAC_peak_counts")`).
The way `altExp`s work is that these are themselves `SingleCellExperiment` objects, with identical `colData` to the main `SingleCellExperiment` object.
Check the documentation for `RAMultiomeData()` for more information on the contents of each matrix.
Similarly to the main atlas, metadata for each sample is available using `RASampleMetadata`.

# 9 Accessory data information

Some additional data is provided that is specific to analyses performed in individual publications whose data is in this package.
At the moment, the only example of this is `GuibentifExtraData()`, which downloads somitogenesis trajectory information and NMP orderings for Guibentif et al. ([n.d.](#ref-guibentif2020diverse)).

# 10 Working with the data outside of *Bioconductor* and *R*

A user might want to use these data outside of the *Bioconductor* framework in which it is provided from this package.
Fortunately, there are several packages available for *R* that facilitate this.
In my experience, *[zellkonverter](https://bioconductor.org/packages/3.22/zellkonverter)* is by far the best approach for creating h5ad files for use with (scanpy*.
An alternative is to use the* [LoomExperiment](https://bioconductor.org/packages/3.22/LoomExperiment)\* package to create `.loom` files.
You could instead use *[loomR](https://github.com/mojaveazure/loomR)*, which is available through *Github*.
*[Seurat](https://CRAN.R-project.org/package%3DSeurat)* has a function `as.Seurat` to directly convert SingleCellExperiment files directly to *Seurat*-friendly objects.

In any case, it is likely that this package is the easiest way to access the mouse gastrulation datasets, regardless of how you wish to analyse it downstream.

# 11 Session Information

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
##  [1] MouseGastrulationData_1.24.0 SpatialExperiment_1.20.0
##  [3] SingleCellExperiment_1.32.0  SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0               GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0                IRanges_2.44.0
##  [9] S4Vectors_0.48.0             BiocGenerics_0.56.0
## [11] generics_0.1.4               MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0            BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      rjson_0.2.23         xfun_0.54
##  [4] bslib_0.9.0          httr2_1.2.1          lattice_0.22-7
##  [7] vctrs_0.6.5          tools_4.5.1          BumpyMatrix_1.18.0
## [10] curl_7.0.0           AnnotationDbi_1.72.0 tibble_3.3.0
## [13] RSQLite_2.4.3        blob_1.2.4           pkgconfig_2.0.3
## [16] Matrix_1.7-4         dbplyr_2.5.1         lifecycle_1.0.4
## [19] compiler_4.5.1       Biostrings_2.78.0    tinytex_0.57
## [22] htmltools_0.5.8.1    sass_0.4.10          yaml_2.3.10
## [25] crayon_1.5.3         pillar_1.11.1        jquerylib_0.1.4
## [28] DelayedArray_0.36.0  cachem_1.1.0         magick_2.9.0
## [31] abind_1.4-8          ExperimentHub_3.0.0  AnnotationHub_4.0.0
## [34] tidyselect_1.2.1     digest_0.6.37        purrr_1.1.0
## [37] dplyr_1.1.4          bookdown_0.45        BiocVersion_3.22.0
## [40] fastmap_1.2.0        grid_4.5.1           cli_3.6.5
## [43] SparseArray_1.10.1   magrittr_2.0.4       S4Arrays_1.10.0
## [46] withr_3.0.2          filelock_1.0.3       rappdirs_0.3.3
## [49] bit64_4.6.0-1        httr_1.4.7           rmarkdown_2.30
## [52] XVector_0.50.0       bit_4.6.0            png_0.1-8
## [55] memoise_2.0.1        evaluate_1.0.5       knitr_1.50
## [58] BiocFileCache_3.0.0  rlang_1.1.6          Rcpp_1.1.0
## [61] glue_1.8.0           DBI_1.2.3            BiocManager_1.30.26
## [64] jsonlite_2.0.0       R6_2.6.1
```

# References

Argelaguet, Ricard, Tim Lohoff, Jingyu Gavin Li, Asif Nakhuda, Deborah Drage, Felix Krueger, Lars Velten, Stephen J. Clark, and Wolf Reik. 2022. “Decoding gene regulation in the mouse embryo using single-cell multi-omics.” *bioRxiv*, 2022.06.15.496239. <https://doi.org/10.1101/2022.06.15.496239>.

Griffiths, J. A., A. C. Richard, K. Bach, A. T. L. Lun, and J. C. Marioni. 2018. “Detection and removal of barcode swapping in single-cell RNA-seq data.” *Nat Commun* 9 (1): 2667.

Guibentif, Carolina, Jonathan A. Griffiths, Ivan Imaz-Rosshandler, Shila Ghazanfar, Jennifer Nichols, Valerie Wilson, Berthold Göttgens, and John C. Marioni. n.d. “Diverse Routes Towards Early Somites in the Mouse Embryo.” *Dev. Cell*.

Haghverdi, L., A. T. L. Lun, M. D. Morgan, and J. C. Marioni. 2018. “Batch effects in single-cell RNA-sequencing data are corrected by matching mutual nearest neighbors.” *Nat. Biotechnol.* 36 (5): 421–27.

Lohoff, T., S. Ghazanfar, A. Missarova, N. Koulena, N. Pierson, J. A. Griffiths, E. S. Bardot, et al. 2020. “Highly Multiplexed Spatially Resolved Gene Expression Profiling of Mouse Organogenesis.” *bioRxiv*, November, 2020.11.20.391896. <https://doi.org/10.1101/2020.11.20.391896>.

Lun, A. T., K. Bach, and J. C. Marioni. 2016. “Pooling across cells to normalize single-cell RNA sequencing data with many zero counts.” *Genome Biol.* 17 (April): 75.

Lun, A. T. L., S. Riesenfeld, T. Andrews, T. P. Dao, T. Gomes, and J. C. Marioni. 2019. “EmptyDrops: distinguishing cells from empty droplets in droplet-based single-cell RNA sequencing data.” *Genome Biol.* 20 (1): 63.

Pijuan-Sala, Blanca, Jonathan A. Griffiths, Carolina Guibentif, Tom W. Hiscock, Wajid Jawaid, Fernando J. Calero-Nieto, Carla Mulas, et al. 2019. “A Single-Cell Molecular Map of Mouse Gastrulation and Early Organogenesis.” *Nature* 566 (7745): 490–95. <https://doi.org/10.1038/s41586-019-0933-9>.

Pijuan-Sala, Blanca, Nicola K. Wilson, Jun Xia, Xiaomeng Hou, Rebecca L. Hannah, Sarah Kinston, Fernando J. Calero-Nieto, et al. 2020. “Single-Cell Chromatin Accessibility Maps Reveal Regulatory Programs Driving Early Mouse Organogenesis.” *Nature Cell Biology* 22 (4): 487–97. <https://doi.org/10.1038/s41556-020-0489-9>.