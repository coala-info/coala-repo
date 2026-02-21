# scMultiome tutorial

Aleksander Chlebowski and Xiaosai Yao

#### 4 November 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Accessing datasets](#accessing-datasets)
  + [3.1 Available Data Sets](#available-data-sets)
  + [3.2 Transcription Factor Binding Sites](#transcription-factor-binding-sites)
* [4 Adding Datasets](#adding-datasets)
  + [4.1 Developer Mode](#developer-mode)
  + [4.2 Saving Your Data Set](#saving-your-data-set)
  + [4.3 Creating Metadata](#creating-metadata)
  + [4.4 Documenting Your Data Set](#documenting-your-data-set)
  + [4.5 Creating accessor function](#creating-accessor-function)
  + [4.6 Building documentation](#building-documentation)
  + [4.7 Updating Package Files](#updating-package-files)
  + [4.8 Uploading Your Data Set](#uploading-your-data-set)
  + [4.9 Congratulations](#congratulations)
* [5 Session Info](#session-info)

# 1 Introduction

Single cell data is gaining sophistication - Cells can be measured in multiple modalities including gene expression, chromatin accessibility, cell surface markers and protein expression. These orthogonal measures of the same or matched cells enable a holistic construction of the cell state. However it has been challenging to share multiomic data, especially in an integrated format that consolidates the multiple layers of measurement. The `MultiAssayExperiment` container (implemented in the *[MultiAssayExperiment](https://bioconductor.org/packages/3.22/MultiAssayExperiment)* package) provides a framework to package the various modalities into a single object on a per cell basis.

The *[scMultiome](https://bioconductor.org/packages/3.22/scMultiome)* package is a collection of public single cell multiome data sets pre-processed and packaged into `MultiAssayExperiment` objects for downstream analysis. It also provides basic functions to save the `MultiAssayExperiment` as `.hdf5` files so that users need to only load the desired modalities into memory.

The ‘scMultiome’ package is similar to *[SingleCellMultiModal](https://bioconductor.org/packages/3.22/SingleCellMultiModal)* in terms of providing multimodal data as an ExperimentHub package. One key difference is that we included additional functionalities to load only the desired modalities, and allow users to save their `MAE` objects as `.hdf5`s. The selective loading of experiments is desirable because multimodal data can be large: A typical 10x scMultiome consists of 100-200K atac-seq peaks on top of the typical 30-50K genes from rna-seq. Finally, *[scMultiome](https://bioconductor.org/packages/3.22/scMultiome)* provides a list of transcription factor and chromatin co-activator binding sites compiled from ENCODE and ChIP-Atlas ChIP-seq data as `GRangesList` objects. ChIP-seq data complements transcription factor motif information by potentially distinguishing related family members and providing occupancy information of chromatin factors that do not directly bind to DNA.

# 2 Installation

```
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")

BiocManager::install("scMultiome")
```

# 3 Accessing datasets

## 3.1 Available Data Sets

View currently available data sets and the names of their accessor functions. Help pages for particular accessors contain more information on their data sets.

```
library(scMultiome)
listDatasets()
```

Table 1: Available Data Sets

| Call | Author | Title | Species | Lineage | CellNumber | Multiome | DiskSize | Version |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| AR\_drug() | Xiaosai Yao | Response of prostate cancer cells to drug treatment | Homo sapiens | Prostate | 23118 | paired | 3.3 GB | 2024-09-09 |
| colonHealthy() | Zhang | Healthy colon | Homo sapiens | Colon | 59231 | unpaired | 6.7 GB | 2022-09-21 |
| hematopoiesis() | Granje | scATAC-seq and unpaired scRNA-seq of hematopoetic cells | Homo sapiens | blood | 10250 | unpaired | 1.0 GB | 2019-10-29 |
| PBMC\_10x() | 10X Genomics | PBMC Data Set | Homo sapiens | Blood | 11898 | paired | 1.2 GB | 2024-09-17 |
| prostateENZ() | Taavitsainen | LNCaP Cells Treated with Enzalutamide | Homo sapiens | Prostate | 15522 | unpaired | 2.9 GB | 2022-09-06 |
| reprogramSeq() | Xie | Reprogram-seq of LNCaP cells | Homo sapiens | Prostate | 3903 | paired | 430 MB | 2022-10-04 |
| TEADi\_resistance() | Xiaosai Yao | Resistance of TEAD inhibitor to drug | Homo sapiens | H226 cell line | 4952 | paired | 825.4 MB | 2024-09-17 |
| tfBinding(“hg19”, “atlas”) | ChipAtlas, ENCODE | TF Binding hg19 ChIPAtlas+ENCODE | Homo sapiens | All | Bulk | n/a | 275 MB | 2022-09-20 |
| tfBinding(“hg19”, “atlas.sample”, 1) | ChipAtlas | TF Binding hg19 ChIPAtlas by sample | Homo sapiens | All | Bulk | n/a | 637.4 MB | 2024-09-26 |
| tfBinding(“hg19”, “atlas.sample”, 2) | ChipAtlas | TF Binding hg19 ChIPAtlas by sample | Homo sapiens | All | Bulk | n/a | 565.3 MB | 2024-12-09 |
| tfBinding(“hg19”, “atlas.tissue”, 1) | ChipAtlas | TF Binding hg19 ChIPAtlas by tissue | Homo sapiens | All | Bulk | n/a | 448.8 MB | 2024-09-26 |
| tfBinding(“hg19”, “atlas.tissue”, 2) | ChipAtlas | TF Binding hg19 ChIPAtlas by tissue | Homo sapiens | All | Bulk | n/a | 411.3 MB | 2024-12-09 |
| tfBinding(“hg19”, “encode.sample”, 1) | ENCODE | TF Binding hg19 ENCODE by sample | Homo sapiens | All | Bulk | n/a | 168 MB | 2024-09-26 |
| tfBinding(“hg19”, “encode.sample”, 2) | ENCODE | TF Binding hg19 ENCODE by sample | Homo sapiens | All | Bulk | n/a | 140.9 MB | 2024-12-12 |
| tfBinding(“hg38”, “atlas”) | ChipAtlas, ENCODE | TF Binding hg38 ChIPAtlas+ENCODE | Homo sapiens | All | Bulk | n/a | 280 MB | 2022-09-20 |
| tfBinding(“hg38”, “atlas.sample”, 1) | ChipAtlas | TF Binding hg38 ChIPAtlas by sample | Homo sapiens | All | Bulk | n/a | 660.2 MB | 2024-09-26 |
| tfBinding(“hg38”, “atlas.sample”, 2) | ChipAtlas | TF Binding hg38 ChIPAtlas by sample | Homo sapiens | All | Bulk | n/a | 585.2 MB | 2024-12-08 |
| tfBinding(“hg38”, “atlas.tissue”, 1) | ChipAtlas | TF Binding hg38 ChIPAtlas by tissue | Homo sapiens | All | Bulk | n/a | 466 MB | 2024-09-26 |
| tfBinding(“hg38”, “atlas.tissue”, 2) | ChipAtlas | TF Binding hg38 ChIPAtlas by tissue | Homo sapiens | All | Bulk | n/a | 426.9 MB | 2024-12-08 |
| tfBinding(“hg38”, “encode.tissue”, 1) | ENCODE | TF Binding hg38 ENCODE by sample | Homo sapiens | All | Bulk | n/a | 167.2 MB | 2024-09-26 |
| tfBinding(“hg38”, “encode.tissue”, 2) | ENCODE | TF Binding hg38 ENCODE by sample | Homo sapiens | All | Bulk | n/a | 140.2 MB | 2024-12-08 |
| tfBinding(“mm10”, “atlas”) | ChipAtlas, ENCODE | TF Binding mm10 ChIPAtlas+ENCODE | Mus musculus | All | Bulk | n/a | 160 MB | 2022-09-20 |
| tfBinding(“mm10”, “atlas.sample”, 1) | ChipAtlas | TF Binding mm10 ChIPAtlas by sample | Mus musculus | All | Bulk | n/a | 311.4 MB | 2024-09-26 |
| tfBinding(“mm10”, “atlas.sample”, 2) | ChipAtlas | TF Binding mm10 ChIPAtlas by sample | Mus musculus | All | Bulk | n/a | 253.4 MB | 2024-12-08 |
| tfBinding(“mm10”, “atlas.tissue”, 2) | ChipAtlas | TF Binding mm10 ChIPAtlas by tissue | Mus musculus | All | Bulk | n/a | 193 MB | 2024-12-08 |
| tfBinding(“mm10”, “encode.sample”, 1) | ENCODE | TF Binding mm10 ENCODE by sample | Mus musculus | All | Bulk | n/a | 14.7 MB | 2024-09-26 |
| tfBinding(“mm10”, “encode.sample”, 2) | ENCODE | TF Binding mm10 ENCODE by sample | Mus musculus | All | Bulk | n/a | 11.1 MB | 2024-12-08 |
| tfMotifs(‘mouse’) | Greenleaf Lab | TF motifs human | Mus musculus | n/a | n/a | n/a | 256 KB | 2 |

Access a data set by calling its accessor function:

```
prostateENZ(metadata = TRUE)
#> ExperimentHub with 1 record
#> # snapshotDate(): 2025-10-29
#> # names(): EH7792
#> # package(): scMultiome
#> # $dataprovider: Tampere University
#> # $species: Homo sapiens
#> # $rdataclass: MultiAssayExperiment
#> # $rdatadateadded: 2022-12-13
#> # $title: LNCaP Cells Treated with Enzalutamide
#> # $description: Multiome data (scATAC and scRNAseq) for enzalutamide-treated...
#> # $taxonomyid: 9606
#> # $genome: hg38
#> # $sourcetype: tar.gz
#> # $sourceurl: https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE168667&forma...
#> # $sourcesize: NA
#> # $tags: c("CellCulture", "ExpressionData", "GEO", "Homo_sapiens_Data",
#> #   "SequencingData", "SingleCellData", "Tissue")
#> # retrieve record with 'object[["EH7792"]]'
```

See the help files for accessor functions for possible extra options, e.g. `?prostateENZ`.

## 3.2 Transcription Factor Binding Sites

In addition to single cell multiomic data, the package also provides binding sites of transcription factors, obtained from bulk ChIP-seq studies (merging of ChIP-Atlas and ENCODE).

If multiple ChIP-seq files are available for the same transcription factor, the peaks are merged to create a union set of peaks. Currently three genomic builds genomes are provided: hg38, hg19, and mm10.

The ChIP-seq data is packaged into individual RDS files and they are accessed with a common accessor function, `tfBinding`, specifying the genome and source.

```
tfBinding(genome = "hg38", source ="atlas", metadata = TRUE)
#> Retrieving chip-seq data, version 1
#> ExperimentHub with 1 record
#> # snapshotDate(): 2025-10-29
#> # names(): EH7814
#> # package(): scMultiome
#> # $dataprovider: Genentech
#> # $species: Homo sapiens
#> # $rdataclass: GRangesList
#> # $rdatadateadded: 2023-01-13
#> # $title: TF Binding Info hg38 (ChIP-Atlas and ENCODE)
#> # $description: Combined transcription factor ChIP-seq data from ChIP-Atlas ...
#> # $taxonomyid: 9606
#> # $genome: hg38
#> # $sourcetype: BED
#> # $sourceurl: https://github.com/inutano/chip-atlas/
#> # $sourcesize: NA
#> # $tags: c("CellCulture", "ExpressionData", "GEO", "Homo_sapiens_Data",
#> #   "SequencingData", "SingleCellData", "Tissue")
#> # retrieve record with 'object[["EH7814"]]'
```

# 4 Adding Datasets

If you want to contribute your publicly available multiome data set, please read this section and contact the package maintainer, Xiaosai Yao xiaosai.yao@gmail.com.

Once the data has been preprocessed and converted into `MultiAssayExperiment`, it can be saved in a hdf5 file using `saveMAE`. You also need to provide metadata, documentation, and the accessor function that will retrieve the data from `ExperimentHub`.

## 4.1 Developer Mode

Adding data involves updating the package and as such, it must be done in “developer mode”. The developer mode allows access to additional tools such as documentation templates.

To work in developer mode, you must first clone the package repository with `git`. Create a branch from `master` and work on that.

Start an R session in the package directory (e.g. by opening the RStudio project in RStudio) and load all the functions. This is necessary for the R engine to temporarily identify your working directory as the package installation directory, and to expose the internal functions that you will be using.

## 4.2 Saving Your Data Set

`MultiAssayExperiment` is saved in the hdf5 format as it splits the MAEs into individual experiments so that you can choose to load selected experiments. Upon loading, selected experiments are reassembled and wrapped into an MAE object. Assays are represented by `DelayedMatrix` objects to save memory.and saved as a hdf5 file.

Currently only `MultiAssayExperiment` objects are supported. Experiments must be objects that inherit from `SummarizedExperiment` and will usually be `SingleCellExperiment`, hence full support is provided for the latter and their slots (`reducedDims` and `altExps`).

```
# construct a dummy data set
mae <- dummyMAE()
mae
#> A MultiAssayExperiment object of 2 listed
#>  experiments with user-defined names and respective classes.
#>  Containing an ExperimentList class object of length 2:
#>  [1] EXP1: SingleCellExperiment with 20 rows and 10 columns
#>  [2] EXP2: SingleCellExperiment with 20 rows and 10 columns
#> Functionality:
#>  experiments() - obtain the ExperimentList instance
#>  colData() - the primary/phenotype DataFrame
#>  sampleMap() - the sample coordination DataFrame
#>  `$`, `[`, `[[` - extract colData columns, subset, or experiment
#>  *Format() - convert into a long or wide DataFrame
#>  assays() - convert ExperimentList to a SimpleList of matrices
#>  exportClass() - save data to flat files

# name the file to save to
fileName <- tempfile(fileext = ".h5")

# save data set
saveMAE(mae, fileName)
#> creating h5 file
#> saving experiment EXP1
#>   dissassembling experiment
#>   writing class
#>   writing assays
#>   ... counts
#>   ... logcounts
#>   writing properties
#>   ...colData
#>   ...colnames
#>   ...rowData
#>   ...rownames
#>   ... rowRanges
#>   ... metadata
#>   writing reducedDims
#>   ... PCA
#>   ... tSNE
#>   writing altExps
#>   ... Hash
#>   dissassembling experiment
#>   writing class
#>   writing assays
#>   ... counts
#>   writing properties
#>   ...colnames
#>   ... metadata
#>   ... Protein
#>   dissassembling experiment
#>   writing class
#>   writing assays
#>   ... counts
#>   writing properties
#>   ...colnames
#>   ... metadata
#>  ... done
#> saving experiment EXP2
#>   dissassembling experiment
#>   writing class
#>   writing assays
#>   ... counts
#>   ... logcounts
#>   writing properties
#>   ...colData
#>   ...colnames
#>   ...rowData
#>   ...rownames
#>   ... rowRanges
#>   ... metadata
#>   writing reducedDims
#>   ... PCA
#>   ... tSNE
#>   writing altExps
#>   ... Hash
#>   dissassembling experiment
#>   writing class
#>   writing assays
#>   ... counts
#>   writing properties
#>   ...colnames
#>   ... metadata
#>   ... Protein
#>   dissassembling experiment
#>   writing class
#>   writing assays
#>   ... counts
#>   writing properties
#>   ...colnames
#>   ... metadata
#>  ... done
#> $EXP1
#> [1] TRUE
#>
#> $EXP2
#> [1] TRUE
```

You can use `testFile` to validate that your data set can be reconstructed.

```
testFile(fileName)
#> TESTING loading MAE from file:   /tmp/RtmpL1AKII/file8900b2d41ef2a.h5
#> LOADING ALL EXPERIMENTS: EXP1, EXP2
#> loading dataset stored in file /tmp/RtmpL1AKII/file8900b2d41ef2a.h5
#> loading experiments
#> loading EXP1
#>   loading properties
#>   ... colnames
#>   ... colData
#>   ... rownames
#>   ... rowData
#>   ... rowRanges
#>   ... metadata
#>   loading assays
#>   ... counts
#>   ... logcounts
#>   loading reducedDims
#>   ... PCA
#>   ... tSNE
#>   loading altExps
#>   ... Hash
#> loading EXP1/altExps/Hash
#>   loading properties
#>   ... colnames
#>   ... metadata
#>   loading assays
#>   ... counts
#>   rebuilding experiment
#>   ...colnames
#>   ...metadata
#>   ... Protein
#> loading EXP1/altExps/Protein
#>   loading properties
#>   ... colnames
#>   ... metadata
#>   loading assays
#>   ... counts
#>   rebuilding experiment
#>   ...colnames
#>   ...metadata
#>   rebuilding experiment
#>   ...colData
#>   ...colnames
#>   ...rowData
#>   ...rowRanges
#>   ...rownames
#>   ...metadata
#>   ...reducedDims
#>   ...altExps
#> loading EXP2
#>   loading properties
#>   ... colnames
#>   ... colData
#>   ... rownames
#>   ... rowData
#>   ... rowRanges
#>   ... metadata
#>   loading assays
#>   ... counts
#>   ... logcounts
#>   loading reducedDims
#>   ... PCA
#>   ... tSNE
#>   loading altExps
#>   ... Hash
#> loading EXP2/altExps/Hash
#>   loading properties
#>   ... colnames
#>   ... metadata
#>   loading assays
#>   ... counts
#>   rebuilding experiment
#>   ...colnames
#>   ...metadata
#>   ... Protein
#> loading EXP2/altExps/Protein
#>   loading properties
#>   ... colnames
#>   ... metadata
#>   loading assays
#>   ... counts
#>   rebuilding experiment
#>   ...colnames
#>   ...metadata
#>   rebuilding experiment
#>   ...colData
#>   ...colnames
#>   ...rowData
#>   ...rowRanges
#>   ...rownames
#>   ...metadata
#>   ...reducedDims
#>   ...altExps
#> building MultiAssayExperiment
#> A MultiAssayExperiment object of 2 listed
#>  experiments with user-defined names and respective classes.
#>  Containing an ExperimentList class object of length 2:
#>  [1] EXP1: SingleCellExperiment with 20 rows and 10 columns
#>  [2] EXP2: SingleCellExperiment with 20 rows and 10 columns
#> Functionality:
#>  experiments() - obtain the ExperimentList instance
#>  colData() - the primary/phenotype DataFrame
#>  sampleMap() - the sample coordination DataFrame
#>  `$`, `[`, `[[` - extract colData columns, subset, or experiment
#>  *Format() - convert into a long or wide DataFrame
#>  assays() - convert ExperimentList to a SimpleList of matrices
#>  exportClass() - save data to flat files
```

For a detailed explanation of the process see `?saveMAE`.

## 4.3 Creating Metadata

To add metadata, we first create a R script to store your data set’s metadata. The metadata script provides key information such as data resource, species, genomic build and version number. This R script will be named `inst/scripts/make-metadata-<DATASET_NAME>.R`.

```
makeMakeMetadata(<DATASET_NAME>)
```

Metadata must be a 1-row data frame with specific columns and values must be character strings (some fields allow character vectors). See `inst/scripts/make-metadata.R` for more information and `inst/scripts/make-metadata-prostateENZ.R` for an example.

The file also stores metadata that will be returned by `listDatasets`. Likewise, this must be a 1-row data frame and values must be character strings.

Once your `make-metadata` file is ready, build the metadata

```
source(system.file("scripts", "make-metadata.R", package = "scMultiome"))
```

This must run without errors. If successful,
all the datasets will be captured in `inst/extdata/manifest.csv` and `inst/extdata/metadata.csv`

Subsequently, validate metadata

```
ExperimentHubData::makeExperimentHubMetadata(dirname(system.file(package = "scMultiome")))
```

This call must also run without errors. It will return an `ExperimentHub` object that will display your metadata in the form that the end users will see it.

## 4.4 Documenting Your Data Set

Every data set needs an additional documentation to describe how the data was obtained. This doesn’t have to be a working script, just a report. Pseudocode is acceptable. Note that code evaluation has been disabled so that you can copy your actual code and the lengthy analysis does not run again.

Create an Rmarkdown file called `inst/scripts/make-data-<DATASET_NAME>.Rmd`.

```
makeMakeData(<DATASET_NAME>)
```

## 4.5 Creating accessor function

Every data set is accessed by its own accessor function, which provides access and help for your data set.
For every data set, we create a `R` file that defines the function to retrieve the data set and provide important documentation. The package framework is constructed such that accessor functions are extremely simple and you can basically copy the original one (`prostateENZ`) and most of its documentation.

Create an R file called `<DATASET_NAME>.R`

```
makeR("dataset")
```

This file will quote the accompanying Rmd file created above. This way the R file itself is more concise and easier to edit. Adjust the file accordingly:

1. Give the file the same title was used in the `make-metadata-<>.R` file.
2. Add a Description section.
3. Document any arguments other than `experiments` and `metadata`.
4. Describe the format of your `MultiAssayExperiment`.
5. Cite appropriate references.
6. Make sure the default value of the `experiments` argument reflects the experiment names in your data set.
7. If you want to restore custom classes to your experiments, add converting functions here. They do not require documentation or exporting.

## 4.6 Building documentation

Once the files are ready, build the documentation, and `?scMultiome` and `?<DATASET_NAME>` to review it.

```
# build documentation
devtools::document()

# view package man page
?scMultiome

# view your data set man page
help("dataset")
```

## 4.7 Updating Package Files

Edit the `DESCRIPTION` file to update package metadata: add yourself as package author and package version.

```
desc::desc_add_author("<GIVEN_NAME>", "<FAMILY_NAME>", "<EMAIL>", role = "aut")
desc::desc_bump_version("minor")
```

Push your changes to git and create a merge request. Once the request is approved and merged to the `master` branch, the package maintainer will take over and move on to the next stage.

## 4.8 Uploading Your Data Set

The final step of the process is to place the data set in Bioconductor’s data bucket. This can only be done with Bioconductor’s knowledge and blessing.

Bioconductor will be notified that a `scMultiome` update is coming by email at `hubs@bioconductor.org`. They will issue a temporary SAS token for the Bioconductor data bucket. The data set will be placed in the Bioconductor staging directory with `uploadFile` and Bioconductor will be notified again that the upload is ready. They will receive a link to the package repository, update metadata in `ExperimentHub` and finalize the process.

```
uploadFile(file = fileName, sasToken = "<SAS_TOKEN>")
```

Consult [this vignette](https://www.bioconductor.org/packages/release/bioc/vignettes/HubPub/inst/doc/CreateAHubPackage.html#additional-resources-to-existing-hub-package) for current Bioconductor requirements.

## 4.9 Congratulations

If you found any of this vignette or the process confusing, we would welcome feedback and gladly add more clarifications. Please email the package maintainer, Xiaosai Yao xiaosai.yao@gmail.com.

# 5 Session Info

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
#>  [1] scMultiome_1.10.0           SingleCellExperiment_1.32.0
#>  [3] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
#>  [5] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [7] Seqinfo_1.0.0               IRanges_2.44.0
#>  [9] S4Vectors_0.48.0            MatrixGenerics_1.22.0
#> [11] matrixStats_1.5.0           ExperimentHub_3.0.0
#> [13] AnnotationHub_4.0.0         BiocFileCache_3.0.0
#> [15] dbplyr_2.5.1                BiocGenerics_0.56.0
#> [17] generics_0.1.4              BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1         dplyr_1.1.4              blob_1.2.4
#>  [4] filelock_1.0.3           Biostrings_2.78.0        fastmap_1.2.0
#>  [7] digest_0.6.37            lifecycle_1.0.4          alabaster.matrix_1.10.0
#> [10] KEGGREST_1.50.0          alabaster.base_1.10.0    RSQLite_2.4.3
#> [13] magrittr_2.0.4           compiler_4.5.1           rlang_1.1.6
#> [16] sass_0.4.10              tools_4.5.1              yaml_2.3.10
#> [19] knitr_1.50               S4Arrays_1.10.0          bit_4.6.0
#> [22] curl_7.0.0               DelayedArray_0.36.0      abind_1.4-8
#> [25] HDF5Array_1.38.0         withr_3.0.2              purrr_1.1.0
#> [28] desc_1.4.3               grid_4.5.1               Rhdf5lib_1.32.0
#> [31] cli_3.6.5                rmarkdown_2.30           crayon_1.5.3
#> [34] httr_1.4.7               BiocBaseUtils_1.12.0     DBI_1.2.3
#> [37] cachem_1.1.0             rhdf5_2.54.0             AnnotationDbi_1.72.0
#> [40] BiocManager_1.30.26      XVector_0.50.0           alabaster.schemas_1.10.0
#> [43] vctrs_0.6.5              Matrix_1.7-4             jsonlite_2.0.0
#> [46] bookdown_0.45            bit64_4.6.0-1            h5mread_1.2.0
#> [49] jquerylib_0.1.4          glue_1.8.0               BiocVersion_3.22.0
#> [52] tibble_3.3.0             pillar_1.11.1            rappdirs_0.3.3
#> [55] htmltools_0.5.8.1        rhdf5filters_1.22.0      R6_2.6.1
#> [58] httr2_1.2.1              evaluate_1.0.5           lattice_0.22-7
#> [61] png_0.1-8                backports_1.5.0          memoise_2.0.1
#> [64] bslib_0.9.0              Rcpp_1.1.0               SparseArray_1.10.1
#> [67] checkmate_2.3.3          xfun_0.54                pkgconfig_2.0.3
```