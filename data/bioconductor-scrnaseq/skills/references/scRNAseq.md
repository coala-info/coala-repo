# Overview of the scRNAseq dataset collection

Davide Risso1 and Aaron Lun\*

1Division of Biostatistics and Epidemiology, Weill Cornell Medicine

\*infinite.monkeys.with.keyboards@gmail.com

#### Created: May 25, 2016; Compiled: 2025-11-04

#### Package

scRNAseq 2.24.0

# Contents

* [1 Introduction](#introduction)
* [2 Finding datasets](#finding-datasets)
* [3 Loading a dataset](#loading-a-dataset)
* [4 Adding new datasets](#adding-new-datasets)
* [Session information](#session-information)

# 1 Introduction

The *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* package provides convenient access to several publicly available single-cell datasets in the form of `SingleCellExperiment` objects.
We do all of the necessary data munging for each dataset beforehand, so that users can obtain a `SingleCellExperiment` for immediate use in further analyses.
To enable discovery, each dataset is decorated with metadata such as the study title/abstract, the species involved, the number of cells, etc.
Users can also contribute their own published datasets to enable re-use by the wider Bioconductor community.

# 2 Finding datasets

The `surveyDatasets()` function will show all available datasets along with their metadata.
This can be used to discover interesting datasets for further analysis.

```
library(scRNAseq)
all.ds <- surveyDatasets()
all.ds
```

```
## DataFrame with 83 rows and 15 columns
##                       name     version        path                 object
##                <character> <character> <character>            <character>
## 1        aztekin-tail-2019  2023-12-14          NA single_cell_experiment
## 2   splicing-demonstrati..  2023-12-20          NA single_cell_experiment
## 3       marques-brain-2016  2023-12-19          NA single_cell_experiment
## 4    grun-bone_marrow-2016  2023-12-14          NA single_cell_experiment
## 5          giladi-hsc-2018  2023-12-21      crispr single_cell_experiment
## ...                    ...         ...         ...                    ...
## 79          he-organs-2020  2023-12-21     trachea single_cell_experiment
## 80   bhaduri-organoid-2020  2023-12-21          NA single_cell_experiment
## 81      grun-pancreas-2016  2023-12-14          NA                     NA
## 82  fletcher-olfactory-2..  2023-12-21          NA single_cell_experiment
## 83    lawlor-pancreas-2017  2023-12-17          NA single_cell_experiment
##                      title            description taxonomy_id   genome
##                <character>            <character>      <List>   <List>
## 1   Identification of a .. Identification of a ..        8355 Xenla9.1
## 2   [reprocessed, subset.. [reprocessed, subset..       10090   GRCm38
## 3   Oligodendrocyte hete.. Oligodendrocyte hete..       10090   GRCm38
## 4   De Novo Prediction o.. De Novo Prediction o..       10090   GRCm38
## 5   Single-cell characte.. Single-cell characte..       10090  MGSCv37
## ...                    ...                    ...         ...      ...
## 79  Single-cell transcri.. Single-cell transcri..        9606   GRCh38
## 80  Cell stress in corti.. Cell stress in corti..        9606   GRCh38
## 81  De Novo Prediction o.. De Novo Prediction o..       10090   GRCm38
## 82  Deconstructing Olfac.. Deconstructing Olfac..       10090   GRCm38
## 83  Single-cell transcri.. Single-cell transcri..        9606   GRCh37
##          rows   columns            assays
##     <integer> <integer>            <List>
## 1       31535     13199            counts
## 2       54448      2325 spliced,unspliced
## 3       23556      5069            counts
## 4       23536      1915            counts
## 5          30     24070            counts
## ...       ...       ...               ...
## 79      18505      7522            counts
## 80      16774    242349        normalized
## 81         NA        NA
## 82      47083       849            counts
## 83      26616       638            counts
##                                          column_annotations reduced_dimensions
##                                                      <List>             <List>
## 1          sample,DevelopmentalStage,DaysPostAmputation,...               UMAP
## 2                                                  celltype
## 3                    source_name,age,inferred cell type,...
## 4                                           sample,protocol
## 5                                       amplification.batch
## ...                                                     ...                ...
## 79                       Tissue,nCount_RNA,nFeature_RNA,...               TSNE
## 80                            title,age (weeks),cloneid,...
## 81
## 82  MD_expt_condition,MD_sequencing_run_id,MD_c1_run_id,...
## 83                                    age,bmi,cell type,...
##     alternative_experiments
##                      <List>
## 1
## 2
## 3
## 4
## 5
## ...                     ...
## 79
## 80
## 81
## 82
## 83
##                                                                                    sources
##                                                                       <SplitDataFrameList>
## 1                                           ArrayExpress:E-MTAB-7716:NA,PubMed:31097661:NA
## 2                                     GEO:GSE109033:NA,GEO:GSM2928341:NA,SRA:SRR6459157:NA
## 3                                                       GEO:GSE75330:NA,PubMed:27284195:NA
## 4                                                       GEO:GSE76983:NA,PubMed:27345837:NA
## 5                                                       PubMed:29915358:NA,GEO:GSE11349:NA
## ...                                                                                    ...
## 79    GEO:GSE159929:NA,PubMed:33287869:NA,GitHub:bei-lab/scRNA-AHCA:45c4b104e66f82729b00..
## 80                                                     GEO:GSE132672:NA,PubMed:31996853:NA
## 81                                                                         GEO:GSE81076:NA
## 82  GEO:GSE95601:NA,PubMed:28506465:NA,GitHub:rufletch/p63-HBC-diff:86dea4ea81826481e675..
## 83                                                      GEO:GSE86469:NA,PubMed:27864352:NA
```

Users can also search on the metadata text using the `searchDatasets()` function.
This accepts both simple text queries as well as more complicated expressions involving boolean operations.

```
# Find all datasets involving pancreas.
searchDatasets("pancreas")[,c("name", "title")]
```

```
## DataFrame with 5 rows and 2 columns
##                    name                  title
##             <character>            <character>
## 1 grun-bone_marrow-2016 De Novo Prediction o..
## 2  muraro-pancreas-2016 A Single-Cell Transc..
## 3   baron-pancreas-2016 A Single-Cell Transc..
## 4   baron-pancreas-2016 A Single-Cell Transc..
## 5    grun-pancreas-2016 De Novo Prediction o..
```

```
# Find all mm10 datasets involving pancreas or neurons.
searchDatasets(
   defineTextQuery("GRCm38", field="genome") &
   (defineTextQuery("neuro%", partial=TRUE) |
    defineTextQuery("pancrea%", partial=TRUE))
)[,c("name", "title")]
```

```
## DataFrame with 14 rows and 2 columns
##                       name                  title
##                <character>            <character>
## 1    grun-bone_marrow-2016 De Novo Prediction o..
## 2      campbell-brain-2017 A molecular census o..
## 3           hu-cortex-2017 Dissecting cell-type..
## 4           hu-cortex-2017 Dissecting cell-type..
## 5       romanov-brain-2017 Molecular interrogat..
## ...                    ...                    ...
## 10     baron-pancreas-2016 A Single-Cell Transc..
## 11       zeisel-brain-2015 Brain structure. Cel..
## 12         chen-brain-2017 Single-Cell RNA-Seq ..
## 13      grun-pancreas-2016 De Novo Prediction o..
## 14  fletcher-olfactory-2.. Deconstructing Olfac..
```

Keep in mind that the search results are not guaranteed to be reproducible -
more datasets may be added over time, and existing datasets may be updated with new versions.
Once a dataset of interest is identified, users should explicitly list the name and version of the dataset in their scripts to ensure reproducibility.

# 3 Loading a dataset

The `fetchDataset()` function will download a particular dataset, returning it as a `SingleCellExperiment`:

```
sce <- fetchDataset("zeisel-brain-2015", "2023-12-14")
sce
```

```
## class: SingleCellExperiment
## dim: 20006 3005
## metadata(0):
## assays(1): counts
## rownames(20006): Tspan12 Tshz1 ... mt-Rnr1 mt-Nd4l
## rowData names(1): featureType
## colnames(3005): 1772071015_C02 1772071017_G12 ... 1772066098_A12
##   1772058148_F03
## colData names(9): tissue group # ... level1class level2class
## reducedDimNames(0):
## mainExpName: gene
## altExpNames(2): repeat ERCC
```

For studies that generate multiple datasets, the dataset of interest must be explicitly requested via the `path=` argument:

```
sce <- fetchDataset("baron-pancreas-2016", "2023-12-14", path="human")
sce
```

```
## class: SingleCellExperiment
## dim: 20125 8569
## metadata(0):
## assays(1): counts
## rownames(20125): A1BG A1CF ... ZZZ3 pk
## rowData names(0):
## colnames(8569): human1_lib1.final_cell_0001 human1_lib1.final_cell_0002
##   ... human4_lib3.final_cell_0700 human4_lib3.final_cell_0701
## colData names(2): donor label
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

By default, array data is loaded as a file-backed `DelayedArray` from the *[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)* package.
Setting `realize.assays=TRUE` and/or `realize.reduced.dims=TRUE` will coerce these to more conventional in-memory representations like ordinary arrays or `dgCMatrix` objects.

```
assay(sce)
```

```
## <20125 x 8569> sparse DelayedMatrix object of type "integer":
##        human1_lib1.final_cell_0001 ... human4_lib3.final_cell_0701
##   A1BG                           0   .                           0
##   A1CF                           4   .                           0
##    A2M                           0   .                           0
##  A2ML1                           0   .                           0
## A4GALT                           0   .                           0
##    ...                           .   .                           .
## ZYG11B                           0   .                           0
##    ZYX                           2   .                           0
##  ZZEF1                           0   .                           0
##   ZZZ3                           0   .                           0
##     pk                           1   .                           0
```

```
sce <- fetchDataset("baron-pancreas-2016", "2023-12-14", path="human", realize.assays=TRUE)
class(assay(sce))
```

```
## [1] "dgCMatrix"
## attr(,"package")
## [1] "Matrix"
```

Users can also fetch the metadata associated with each dataset:

```
str(fetchMetadata("zeisel-brain-2015", "2023-12-14"))
```

```
## List of 9
##  $ title               : chr "Brain structure. Cell types in the mouse cortex and hippocampus revealed by single-cell RNA-seq"
##  $ description         : chr "The mammalian cerebral cortex supports cognitive functions such as sensorimotor integration, memory, and social"| __truncated__
##  $ taxonomy_id         :List of 1
##   ..$ : chr "10090"
##  $ genome              :List of 1
##   ..$ : chr "GRCm38"
##  $ sources             :List of 5
##   ..$ :List of 3
##   .. ..$ provider: chr "URL"
##   .. ..$ id      : chr "https://storage.googleapis.com/linnarsson-lab-www-blobs/blobs/cortex/expression_mRNA_17-Aug-2014.txt"
##   .. ..$ version : chr "2024-02-23"
##   ..$ :List of 3
##   .. ..$ provider: chr "URL"
##   .. ..$ id      : chr "https://storage.googleapis.com/linnarsson-lab-www-blobs/blobs/cortex/expression_rep_17-Aug-2014.txt"
##   .. ..$ version : chr "2024-02-23"
##   ..$ :List of 3
##   .. ..$ provider: chr "URL"
##   .. ..$ id      : chr "https://storage.googleapis.com/linnarsson-lab-www-blobs/blobs/cortex/expression_spikes_17-Aug-2014.txt"
##   .. ..$ version : chr "2024-02-23"
##   ..$ :List of 3
##   .. ..$ provider: chr "URL"
##   .. ..$ id      : chr "https://storage.googleapis.com/linnarsson-lab-www-blobs/blobs/cortex/expression_mito_17-Aug-2014.txt"
##   .. ..$ version : chr "2024-02-23"
##   ..$ :List of 2
##   .. ..$ provider: chr "PubMed"
##   .. ..$ id      : chr "25700174"
##  $ maintainer_name     : chr "Aaron Lun"
##  $ maintainer_email    : chr "infinite.monkeys.with.keyboards@gmail.com"
##  $ bioconductor_version: chr "3.19"
##  $ applications        :List of 1
##   ..$ takane:List of 3
##   .. ..$ type                  : chr "single_cell_experiment"
##   .. ..$ summarized_experiment :List of 4
##   .. .. ..$ rows              : int 20006
##   .. .. ..$ columns           : int 3005
##   .. .. ..$ assays            :List of 1
##   .. .. .. ..$ : chr "counts"
##   .. .. ..$ column_annotations:List of 9
##   .. .. .. ..$ : chr "tissue"
##   .. .. .. ..$ : chr "group #"
##   .. .. .. ..$ : chr "total mRNA mol"
##   .. .. .. ..$ : chr "well"
##   .. .. .. ..$ : chr "sex"
##   .. .. .. ..$ : chr "age"
##   .. .. .. ..$ : chr "diameter"
##   .. .. .. ..$ : chr "level1class"
##   .. .. .. ..$ : chr "level2class"
##   .. ..$ single_cell_experiment:List of 2
##   .. .. ..$ reduced_dimensions     : list()
##   .. .. ..$ alternative_experiments:List of 2
##   .. .. .. ..$ : chr "repeat"
##   .. .. .. ..$ : chr "ERCC"
```

# 4 Adding new datasets

Want to contribute your own dataset to this package?
It’s easy!
Just follow these simple steps for instant fame and prestige.

1. Format your dataset as a `SummarizedExperiment` or `SingleCellExperiment`.
   Let’s just make up something here.

   ```
   library(SingleCellExperiment)
   sce <- SingleCellExperiment(list(counts=matrix(rpois(1000, lambda=1), 100, 10)))
   rownames(sce) <- sprintf("GENE_%i", seq_len(nrow(sce)))
   colnames(sce) <- head(LETTERS, 10)
   ```
2. Assemble the metadata for your dataset.
   This should be a list structured as specified in the [Bioconductor metadata schema](https://artifactdb.github.io/bioconductor-metadata-index/bioconductor/v1.json)
   Check out some examples from `fetchMetadata()` - note that the `application.takane` property will be automatically added later, and so can be omitted from the list that you create.

   ```
   meta <- list(
       title="My dataset",
       description="This is my dataset",
       taxonomy_id="10090",
       genome="GRCh38",
       sources=list(
           list(provider="GEO", id="GSE12345"),
           list(provider="PubMed", id="1234567")
       ),
       maintainer_name="Chihaya Kisaragi",
       maintainer_email="kisaragi.chihaya@765pro.com"
   )
   ```
3. Save your `SummarizedExperiment` (or whatever object contains your dataset) to disk with `saveDataset()`.
   This saves the dataset into a “staging directory” using language-agnostic file formats - check out the [**alabaster**](https://github.com/ArtifactDB/alabaster.base) framework for more details.
   In more complex cases involving multiple datasets, users may save each dataset into a subdirectory of the staging directory.

   ```
   # Simple case: you only have one dataset to upload.
   staging <- tempfile()
   saveDataset(sce, staging, meta)
   list.files(staging, recursive=TRUE)
   ```

   ```
   ##  [1] "OBJECT"                       "_bioconductor.json"
   ##  [3] "_environment.json"            "assays/0/OBJECT"
   ##  [5] "assays/0/array.h5"            "assays/names.json"
   ##  [7] "column_data/OBJECT"           "column_data/basic_columns.h5"
   ##  [9] "row_data/OBJECT"              "row_data/basic_columns.h5"
   ```

   ```
   # Complex case: you have multiple datasets to upload.
   staging <- tempfile()
   dir.create(staging)
   saveDataset(sce, file.path(staging, "foo"), meta)
   saveDataset(sce, file.path(staging, "bar"), meta) # etc.
   ```

   You can check that everything was correctly saved by reloading the on-disk data into the R session for inspection:

   ```
   alabaster.base::readObject(file.path(staging, "foo"))
   ```

   ```
   ## class: SingleCellExperiment
   ## dim: 100 10
   ## metadata(0):
   ## assays(1): counts
   ## rownames(100): GENE_1 GENE_2 ... GENE_99 GENE_100
   ## rowData names(0):
   ## colnames(10): A B ... I J
   ## colData names(0):
   ## reducedDimNames(0):
   ## mainExpName: NULL
   ## altExpNames(0):
   ```
4. Open a [pull request (PR)](https://github.com/LTLA/scRNAseq/pulls) for the addition of a new dataset.
   You will need to provide a few things here:

   * The name of your dataset.
     This typically follows the format of `{NAME}-{SYSTEM}-{YEAR}`, where `NAME` is the last name of the first author of the study,
     `SYSTEM` is the biological system (e.g., tissue, cell types) being studied,
     and `YEAR` is the year of publication for the dataset.
   * The version of your dataset.
     This is usually just the current date… or whenever you started putting together the dataset for upload.
     The exact date doesn’t really matter as long as we can establish a timeline for later versions.
   * An Rmarkdown file containing the code used to assemble the dataset.
     This should be added to the [`scripts/`](https://github.com/LTLA/scRNAseq/tree/master/scripts) directory of this package,
     in order to provide some record of how the dataset was created.
5. Wait for us to grant temporary upload permissions to your GitHub account.
6. Upload your staging directory to [**gypsum** backend](https://github.com/ArtifactDB/gypsum-worker) with `gypsum::uploadDirectory()`.
   On the first call to this function, it will automatically prompt you to log into GitHub so that the backend can authenticate you.
   If you are on a system without browser access (e.g., most computing clusters), a [token](https://github.com/settings/tokens) can be manually supplied via `gypsum::setAccessToken()`.

   ```
   gypsum::uploadDirectory(staging, "scRNAseq", "my_dataset_name", "my_version")
   ```

   You can check that everything was successfully uploaded by calling `fetchDataset()` with the same name and version:

   ```
   fetchDataset("my_dataset_name", "my_version")
   ```

   If you realized you made a mistake, no worries.
   Use the following call to clear the erroneous dataset, and try again:

   ```
   gypsum::rejectProbation("scRNAseq", "my_dataset_name", "my_version")
   ```
7. Comment on the PR to notify us that the dataset has finished uploading and you’re happy with it.
   We’ll review it and make sure everything’s in order.
   If some fixes are required, we’ll just clear the dataset so that you can upload a new version with the necessary changes.
   Otherwise, we’ll approve the dataset.
   Note that once a version of a dataset is approved, no further changes can be made to that version;
   you’ll have to upload a new version if you want to modify something.

# Session information

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
##  [1] scRNAseq_2.24.0             SingleCellExperiment_1.32.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1         jsonvalidate_1.5.0       alabaster.se_1.10.0
##  [4] dplyr_1.1.4              blob_1.2.4               filelock_1.0.3
##  [7] Biostrings_2.78.0        bitops_1.0-9             lazyeval_0.2.2
## [10] fastmap_1.2.0            RCurl_1.98-1.17          BiocFileCache_3.0.0
## [13] GenomicAlignments_1.46.0 XML_3.99-0.19            digest_0.6.37
## [16] lifecycle_1.0.4          ProtGenerics_1.42.0      alabaster.matrix_1.10.0
## [19] KEGGREST_1.50.0          alabaster.base_1.10.0    RSQLite_2.4.3
## [22] magrittr_2.0.4           compiler_4.5.1           rlang_1.1.6
## [25] sass_0.4.10              tools_4.5.1              yaml_2.3.10
## [28] rtracklayer_1.70.0       knitr_1.50               S4Arrays_1.10.0
## [31] bit_4.6.0                curl_7.0.0               DelayedArray_0.36.0
## [34] abind_1.4-8              BiocParallel_1.44.0      HDF5Array_1.38.0
## [37] gypsum_1.6.0             grid_4.5.1               ExperimentHub_3.0.0
## [40] Rhdf5lib_1.32.0          cli_3.6.5                rmarkdown_2.30
## [43] crayon_1.5.3             httr_1.4.7               rjson_0.2.23
## [46] DBI_1.2.3                cachem_1.1.0             rhdf5_2.54.0
## [49] parallel_4.5.1           AnnotationDbi_1.72.0     AnnotationFilter_1.34.0
## [52] BiocManager_1.30.26      XVector_0.50.0           restfulr_0.0.16
## [55] alabaster.schemas_1.10.0 vctrs_0.6.5              V8_8.0.1
## [58] Matrix_1.7-4             jsonlite_2.0.0           bookdown_0.45
## [61] bit64_4.6.0-1            ensembldb_2.34.0         alabaster.ranges_1.10.0
## [64] GenomicFeatures_1.62.0   h5mread_1.2.0            jquerylib_0.1.4
## [67] glue_1.8.0               codetools_0.2-20         GenomeInfoDb_1.46.0
## [70] BiocVersion_3.22.0       UCSC.utils_1.6.0         BiocIO_1.20.0
## [73] tibble_3.3.0             pillar_1.11.1            rhdf5filters_1.22.0
## [76] rappdirs_0.3.3           htmltools_0.5.8.1        R6_2.6.1
## [79] dbplyr_2.5.1             httr2_1.2.1              alabaster.sce_1.10.0
## [82] evaluate_1.0.5           lattice_0.22-7           AnnotationHub_4.0.0
## [85] png_0.1-8                Rsamtools_2.26.0         cigarillo_1.0.0
## [88] memoise_2.0.1            bslib_0.9.0              Rcpp_1.1.0
## [91] SparseArray_1.10.1       xfun_0.54                pkgconfig_2.0.3
```