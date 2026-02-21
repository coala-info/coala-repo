# Multi-sample multi-group scRNA-seq data

Helena L. Crowell

#### 4 November 2025

# Contents

* [1 Overview](#overview)
* [2 Available datasets](#available-datasets)
* [3 Loading the data](#loading-the-data)
  + [3.1 Via accessor functions](#via-accessor-functions)
  + [3.2 Via `ExperimentHub`](#via-experimenthub)
    - [3.2.1 Using `query`](#using-query)
    - [3.2.2 Using `list/loadResources`](#using-listloadresources)
* [4 Exploring the data](#exploring-the-data)
* [5 Session info](#session-info)
* [References](#references)

# 1 Overview

The `muscData` package contains a set of publicly available single-cell RNA sequencing (scRNA-seq) datasets with complex experimental designs, i.e., datasets that contain multiple samples (e.g., individuals) measured across multiple experimental conditions (e.g., treatments), formatted into `SingleCellExperiment` (SCE) Bioconductor objects. Data objects are hosted through Bioconductor’s ExperimentHub web resource.

# 2 Available datasets

The table below gives an overview of currently available datasets, including a unique identifier (ID) that can be used to load the data (see next section), a brief description, the original data source, and a reference. Dataset descriptions may also be viewed from within R via `?ID` (e.g., `?Kang18_8vs8`).

| ID | Description | Availability | Reference |
| --- | --- | --- | --- |
| `Kang18_8vs8` | 10x droplet-based scRNA-seq PBMC data from 8 Lupus patients before and after 6h-treatment with INF-beta (16 samples in total) | Gene Expression Ombnibus (GEO) accession [GSE96583](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE96583) | Kang et al. ([2018](#ref-Kang2018)) |
| `Crowell19_4vs4` | Single-nuclei RNA-seq data of 8 CD-1 male mice, split into 2 groups with 4 animals each: vehicle and peripherally lipopolysaccharaide (LPS) treated mice | Figshare [DOI:10.6084/m9.figshare.8976473.v1](https://doi.org/10.6084/m9.figshare.8976473.v1) | Crowell et al. ([2019](#ref-Crowell2019-muscat)) |

# 3 Loading the data

All datasets available within `muscData` may be loaded either via named functions that directly reffer to the object names, or by using the `ExperimentHub` interface. Both methods are demonstrated below.

## 3.1 Via accessor functions

The datasets listed above may be loaded into R by their ID. All provided SCEs contain unfiltered raw counts in their `assay` slot, and any available gene and cell metadata in the `rowData` and `colData` slots, respectively.

```
library(muscData)
Kang18_8vs8()
```

```
## class: SingleCellExperiment
## dim: 35635 29065
## metadata(0):
## assays(1): counts
## rownames(35635): MIR1302-10 FAM138A ... MT-ND6 MT-CYB
## rowData names(2): ENSEMBL SYMBOL
## colnames(29065): AAACATACAATGCC-1 AAACATACATTTCC-1 ... TTTGCATGGTTTGG-1
##   TTTGCATGTCTTAC-1
## colData names(5): ind stim cluster cell multiplets
## reducedDimNames(1): TSNE
## mainExpName: NULL
## altExpNames(0):
```

## 3.2 Via `ExperimentHub`

Besides using an accession function as demonstrated above, we can browse ExperimentHub records (using `query`) or package specific records (using `listResources`), and then load the data of interest. The key differences between these approaches is that `query` will search all of ExperimentHub, while `listResources` facilitate data discovery within the specified package (here, `muscData`).

### 3.2.1 Using `query`

We first initialize a Hub instance to search for and load available data with the `ExperimentHub` function, and store the complete list of >2000 records in a variable `eh`. Using `query`, we then identify any records made available by `muscData`, as well as their accession IDs (EH1234). Finally, we can load the data into R via `eh[[id]]`.

```
# create Hub instance
library(ExperimentHub)
eh <- ExperimentHub()
(q <- query(eh, "muscData"))
```

```
## ExperimentHub with 2 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: GEO, F. Hoffmann-La Roche Ltd.
## # $species: Mus musculus, Homo sapiens
## # $rdataclass: SingleCellExperiment
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH2259"]]'
##
##            title
##   EH2259 | Kang18_8vs8
##   EH3297 | Crowell19_4vs4
```

```
# load data via accession ID
eh[["EH2259"]]
```

### 3.2.2 Using `list/loadResources`

Alternatively, available records may be viewed via `listResources`. To then load a specific dataset or subset thereof using `loadResources`, we require a character vector of metadata search terms to filter by.

Available metadata can accessed from the ExperimentHub records found by `query` via `mcols()`, or viewed using the accessors shown above with option `metadata = TRUE`. In the example below, we use `"PMBC"` and `"INF-beta"` to select the `Kang18_8vs8` dataset. However, note that any metadata keyword(s) that uniquely identify the data of interest could be used (e.g., `"Lupus"` or `"GSE96583"`).

```
listResources(eh, "muscData")
```

```
## [1] "Kang18_8vs8"    "Crowell19_4vs4"
```

```
# view metadata
mcols(q)
Kang18_8vs8(metadata = TRUE)

# load data using metadata search terms
loadResources(eh, "muscData", c("PBMC", "INF-beta"))
```

# 4 Exploring the data

The *[scater](https://bioconductor.org/packages/3.22/scater)* (McCarthy et al. [2017](#ref-McCarthy2017)) package provides an easy-to-use set of visualization tools for scRNA-seq data.

For interactive visualization, we recommend the *[iSEE](https://bioconductor.org/packages/3.22/iSEE)* (*interactive SummerizedExperiment Explorer*) package (Rue-Albrecht et al. [2018](#ref-Albrecht2018)), which provides a Shiny-based graphical user interface for exploration of single-cell data in `SummarizedExperiment` format (installation instructions and user guides are available [here](https://bioconductor.org/packages/release/bioc/html/iSEE.html)).

When available, a great tool for interactive exploration and comparison of dimension-reduced embeddings is *[sleepwalk](https://CRAN.R-project.org/package%3Dsleepwalk)* (Ovchinnikova and Anders [2019](#ref-Ovchinnikova2018)).

# 5 Session info

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
##  [1] muscData_1.24.0             SingleCellExperiment_1.32.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] ExperimentHub_3.0.0         AnnotationHub_4.0.0
## [13] BiocFileCache_3.0.0         dbplyr_2.5.1
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      xfun_0.54            bslib_0.9.0
##  [4] httr2_1.2.1          lattice_0.22-7       vctrs_0.6.5
##  [7] tools_4.5.1          curl_7.0.0           tibble_3.3.0
## [10] AnnotationDbi_1.72.0 RSQLite_2.4.3        blob_1.2.4
## [13] pkgconfig_2.0.3      Matrix_1.7-4         lifecycle_1.0.4
## [16] compiler_4.5.1       Biostrings_2.78.0    htmltools_0.5.8.1
## [19] sass_0.4.10          yaml_2.3.10          pillar_1.11.1
## [22] crayon_1.5.3         jquerylib_0.1.4      DelayedArray_0.36.0
## [25] cachem_1.1.0         abind_1.4-8          tidyselect_1.2.1
## [28] digest_0.6.37        purrr_1.1.0          dplyr_1.1.4
## [31] bookdown_0.45        BiocVersion_3.22.0   fastmap_1.2.0
## [34] grid_4.5.1           SparseArray_1.10.1   cli_3.6.5
## [37] magrittr_2.0.4       S4Arrays_1.10.0      withr_3.0.2
## [40] filelock_1.0.3       rappdirs_0.3.3       bit64_4.6.0-1
## [43] rmarkdown_2.30       XVector_0.50.0       httr_1.4.7
## [46] bit_4.6.0            png_0.1-8            memoise_2.0.1
## [49] evaluate_1.0.5       knitr_1.50           rlang_1.1.6
## [52] glue_1.8.0           DBI_1.2.3            BiocManager_1.30.26
## [55] jsonlite_2.0.0       R6_2.6.1
```

# References

Crowell, Helena L, Charlotte Soneson, Pierre-Luc Germain, Daniela Calini, Ludovic Collin, Catarina Raposo, Dheeraj Malhotra, and Mark D Robinson. 2019. “On the Discovery of Population-Specific State Transitions from Multi-Sample Multi-Condition Single-Cell RNA Sequencing Data.” *bioRxiv* 713412.

Kang, Hyun Min, Meena Subramaniam, Sasha Targ, Michelle Nguyen, Lenka Maliskova, Elizabeth McCarthy, Eunice Wan, et al. 2018. “Multiplexed Droplet Single-Cell Rna-Sequencing Using Natural Genetic Variation.” *Nat Biotechnol* 36 (1): 89–94. <https://doi.org/10.1038/nbt.4042>.

McCarthy, Davis J, Kieran R Campbell, Quin F Wills, and Aaron T L Lun. 2017. “Scater: Pre-Processing, Quality Control, Normalization and Visualization of Single-Cell RNA-Seq Data in R.” *Bioinformatics* 33 (8): 1179–86. <https://doi.org/10.1093/bioinformatics/btw777>.

Ovchinnikova, Svetlana, and Simon Anders. 2019. “Exploring Dimension-Reduced Embeddings with Sleepwalk.” *bioRxiv*. <https://doi.org/10.1101/603589>.

Rue-Albrecht, Kévin, Federico Marini, Charlotte Soneson, and Aaron T L Lun. 2018. “ISEE: Interactive SummarizedExperiment Explorer.” *F1000Res* 7: 741. <https://doi.org/10.12688/f1000research.14966.1>.