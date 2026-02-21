# MultimodalExperiment

Lucas Schiffer1

1Center for Data Science, Rutgers New Jersey Medical School, Newark, NJ

#### October 30, 2025

#### Package

MultimodalExperiment 1.10.0

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
* [3 Example Data](#example-data)
* [4 Construction](#construction)
* [5 Manipulation](#manipulation)
* [6 Session Info](#session-info)

# 1 Installation

To install *[MultimodalExperiment](https://bioconductor.org/packages/3.22/MultimodalExperiment)* from Bioconductor, use *[BiocManager](https://CRAN.R-project.org/package%3DBiocManager)* as follows.

```
BiocManager::install("MultimodalExperiment")
```

To install *[MultimodalExperiment](https://bioconductor.org/packages/3.22/MultimodalExperiment)* from GitHub, use *[BiocManager](https://CRAN.R-project.org/package%3DBiocManager)* as follows.

```
BiocManager::install("schifferl/MultimodalExperiment", dependencies = TRUE, build_vignettes = TRUE)
```

Most users should simply install *[MultimodalExperiment](https://bioconductor.org/packages/3.22/MultimodalExperiment)* from Bioconductor.

# 2 Introduction

MultimodalExperiment is an S4 class that integrates bulk and single-cell experiment data; it is optimally storage-efficient, and its methods are exceptionally fast. It effortlessly represents multimodal data of any nature and features normalized experiment, subject, sample, and cell annotations, which are related to underlying biological experiments through maps. Its coordination methods are opt-in and employ database-like join operations internally to deliver fast and flexible management of multimodal data.

![MultimodalExperiment Schematic. Normalized experiment, subject, sample, and cell annotations reside in the **Annotations** layer in blue at the top; the **Maps** layer in green in the middle contains the **experimentMap**, which specifies an experiment's type (bulk or single-cell), and the subject, sample, and cell maps which relate annotations to underlying biological data (i.e., experiments); the **Experiments** layer in orange at the bottom separates experiments by type (bulk or single-cell). The figure shows the subsetting of a MultimodalExperiment object: solid lines represent bulk information, and hatched lines represent single-cell information.](data:image/png;base64...)

Figure 1: MultimodalExperiment Schematic
Normalized experiment, subject, sample, and cell annotations reside in the **Annotations** layer in blue at the top; the **Maps** layer in green in the middle contains the **experimentMap**, which specifies an experiment’s type (bulk or single-cell), and the subject, sample, and cell maps which relate annotations to underlying biological data (i.e., experiments); the **Experiments** layer in orange at the bottom separates experiments by type (bulk or single-cell). The figure shows the subsetting of a MultimodalExperiment object: solid lines represent bulk information, and hatched lines represent single-cell information.

To begin using MultimodalExperiment, users should familiarize themselves with its application programming interface (API) outlined in the table below. The names of slot methods are consistent with those shown in the MultimodalExperiment Schematic (Figure [1](#fig:figure-one)), except `bulkExperiments` and `singleCellExperiments` because these are not actually individual slots. Instead, the `experiments` slot contains a single `ExperimentList` object with both bulk and single-cell experiments as elements; the `experimentMap` is used to distinguish between the two types of experiments. Also, note that the API of MultimodalExperiment is relatively sparse because it is a data structure, and further packages are needed to conduct analysis.

|  |  |
| --- | --- |
| **Constructors** |  |
| `MultimodalExperiment` | construct a MultimodalExperiment object |
| `ExperimentList` | construct an ExperimentList object |
| **Slots** |  |
| `experimentData` | get or set experimentData (experiment annotations) |
| `subjectData` | get or set subjectData (subject annotations) |
| `sampleData` | get or set sampleData (sample annotations) |
| `cellData` | get or set cellData (cell annotations) |
| `experimentMap` | get or set experimentMap (experiment -> type map) |
| `subjectMap` | get or set subjectMap (subject -> experiment map) |
| `sampleMap` | get or set sampleMap (sample -> subject map) |
| `cellMap` | get or set cellMap (cell -> sample map) |
| `experiments` | get or set experiments |
| `metadata` | get or set metadata |
| **Annotations** |  |
| `joinAnnotations` | join experimentData, subjectData, sampleData, and cellData |
| **Maps** |  |
| `joinMaps` | join experimentMap, subjectMap, sampleMap, and cellMap |
| **Experiments** |  |
| `experiment(ME, i)` | get or set experiments element by index |
| `experiment(ME, "name")` | get or set experiments element by name |
| `bulkExperiments` | get or set experiments element(s) where `type == "bulk"` |
| `singleCellExperiments` | get or set experiments element(s) where `type == "single-cell"` |
| **Names** |  |
| `rownames` | get or set rownames of experiments element(s) |
| `colnames` | get or set colnames of experiments element(s) |
| `experimentNames` | get or set names of experiments |
| **Subsetting** |  |
| `ME[i, j]` | subset rows and/or columns of experiments |
| `ME[i, ]` | `i`: list, List, LogicalList, IntegerList, CharacterList |
| `ME[, j]` | `j`: list, List, LogicalList, IntegerList, CharacterList |
| **Coordination** |  |
| `propagate` | propagate experiment, subject, sample, and cell indices across all tables |
| `harmonize` | harmonize experiment, subject, sample, and cell indices across all tables |

As the API table above might suggest, the coordination methods of MultimodalExperiment are opt-in, meaning the propagation and harmonization of indices are deferred until the user request them. This philosophy prevents computationally expensive operations from being called repetitively while changes to a MultimodalExperiment object are made.

# 3 Example Data

To demonstrate the functionality of the MultimodalExperiment class, a subset of the *PBMCs of a Healthy Donor - 5’ Gene Expression with a Panel of TotalSeq™-C Antibodies* dataset from 10x Genomics has been included in the MultimodalExperiment package. Specifically, human peripheral blood mononuclear cells (PBMCs) from a single healthy donor were profiled by cellular indexing of transcriptomes and epitopes by sequencing (CITE-seq) to generate single-cell antibody-derived tag sequencing (scADTseq) and single-cell RNA sequencing (scRNAseq) data simultaneously; the scRNAseq data was summed into pseudo-bulk RNA sequencing (pbRNAseq) data using *[scuttle](https://bioconductor.org/packages/3.22/scuttle)*. The dimensions of resulting matrices were reduced to conserve storage because these data are only used for demonstration here.

```
pbRNAseq[1:4, 1:1, drop = FALSE]
```

```
##      SAMPLE-1
## A1BG     1020
## A1CF        0
## AAAS      413
## AACS      117
```

```
scRNAseq[1:4, 1:4, drop = FALSE]
```

```
##      AAACCTGAGAGCAATT AAACCTGAGGCTCTTA AAACCTGAGTGAACGC AAACCTGCAAACGCGA
## A1BG                1                0                0                0
## A1CF                0                0                0                0
## AAAS                0                0                0                0
## AACS                0                0                0                0
```

```
scADTseq[1:4, 1:4, drop = FALSE]
```

```
##      AAACCTGAGAGCAATT AAACCTGAGGCTCTTA AAACCTGAGTGAACGC AAACCTGCAAACGCGA
## CD3               225             1064             1833               18
## CD4                 0                0                0                1
## CD14                0                0                0                3
## CD15             6890               29               42               47
```

The dataset does not include annotations, and only limited information can be gathered from its citation111 *PBMCs of a Healthy Donor - 5’ Gene Expression with a Panel of TotalSeq™-C Antibodies*, Single Cell Immune Profiling Dataset by Cell Ranger 3.0.0, 10x Genomics, (2018, November 19)., as follows:

1. These data are known to come from peripheral blood mononuclear cells (PBMCs)
2. These data are known to come from a single, healthy donor
3. These data were published on November 19, 2018

Where a MultimodalExperiment object is constructed from these data in the proceeding section, these facts will be used to create experiment, subject, and sample annotations.

# 4 Construction

To construct a MultimodalExperiment object from the example data, begin by assigning an empty MultimodalExperiment object to the variable `ME`.

```
ME <-
    MultimodalExperiment()
```

Then, use the `bulkExperiments<-` method to assign a named ExperimentList containing the pbRNAseq matrix as the bulkExperiments of the `ME` object.

```
bulkExperiments(ME) <-
    ExperimentList(
        pbRNAseq = pbRNAseq
    )
```

Next, use the `singleCellExperiments<-` method to assign a named ExperimentList containing the scADTseq and scRNAseq matrices as the singleCellExperiments of the `ME` object.

```
singleCellExperiments(ME) <-
    ExperimentList(
        scADTseq = scADTseq,
        scRNAseq = scRNAseq
    )
```

The `bulkExperiments<-` and `singleCellExperiments<-` methods are the only exceptions to opt-in coordination; they automatically propagate experiment, sample, and cell indices into the relevant annotation (experimentData, sampleData, and cellData) and map (experimentMap, sampleMap, and cellMap) slots to simplify the process of construing a MultimodalExperiment object. Despite their automatic propagation, these methods remain computationally efficient because they do not call `propagate` internally.

To establish that all experiments are related to a single subject, the value `"SUBJECT-1"` is assigned to the `"subject"` column of the `subjectMap`.

```
subjectMap(ME)[["subject"]] <-
    "SUBJECT-1"
```

To establish that all samples are related to a single subject, the value `"SUBJECT-1"` is assigned to the `"subject"` column of the `sampleMap`.

```
sampleMap(ME)[["subject"]] <-
    "SUBJECT-1"
```

To establish that all cells are related to a single sample, the value `"SAMPLE-1"` is assigned to the `"sample"` column of the `cellMap`.

```
cellMap(ME)[["sample"]] <-
    "SAMPLE-1"
```

To make the relationships established in the preceding steps clear to the reader, the `joinMaps` method is used to display all maps joined into an unnormalized DataFrame object.

```
joinMaps(ME)
```

```
## DataFrame with 10002 rows and 5 columns
##              type  experiment     subject      sample             cell
##       <character> <character> <character> <character>      <character>
## 1              NA          NA          NA          NA               NA
## 2            bulk    pbRNAseq   SUBJECT-1    SAMPLE-1               NA
## 3     single-cell    scADTseq   SUBJECT-1    SAMPLE-1 AAACCTGAGAGCAATT
## 4     single-cell    scADTseq   SUBJECT-1    SAMPLE-1 AAACCTGAGGCTCTTA
## 5     single-cell    scADTseq   SUBJECT-1    SAMPLE-1 AAACCTGAGTGAACGC
## ...           ...         ...         ...         ...              ...
## 9998  single-cell    scRNAseq   SUBJECT-1    SAMPLE-1 TTTGTCAGTTGGACCC
## 9999  single-cell    scRNAseq   SUBJECT-1    SAMPLE-1 TTTGTCAGTTGGAGGT
## 10000 single-cell    scRNAseq   SUBJECT-1    SAMPLE-1 TTTGTCAGTTTAGCTG
## 10001 single-cell    scRNAseq   SUBJECT-1    SAMPLE-1 TTTGTCATCATGGTCA
## 10002 single-cell    scRNAseq   SUBJECT-1    SAMPLE-1 TTTGTCATCTCGTTTA
```

Although the relationships established should now be clear, it is important to note that the unnormalized representation is not storage efficient and is not how maps are stored in a MultimodalExperiment object. The design of MultimodalExperiment takes advantage of the structure of multimodal data where sample or cell indices are repeated across experiments by storing annotations and relationships only once.

In the MultimodalExperiment paradigm, cells belong to samples, samples belong to subjects, and subjects participate in experiments; these relationships were established above with modifications to the cell, sample, and subject maps. However, the subject indices created when the subject and sample maps were modified were not added to the row names of the `subjectData` slot per the opt-in principle. The `propagate` method inserts experiment, subject, sample, and cell indices into all relevant tables by taking their union and adding missing indices; it is used below to add the missing indices to the `subjectData` slot.

```
ME <-
    propagate(ME)
```

Experiment, subject, sample, and cell indices are now present across all annotation and map slots, and the order of row names across annotation slots is also known. The order of row names of experiment, sample, and cell annotations is consistent with their order of insertion; this means the `experimentData` slot contains a DataFrame with three rows (pbRNAseq, scADTseq, and scRNAseq) and zero columns. To establish when the data were published, three dates are assigned to the `"published"` column of `experimentData`.

```
experimentData(ME)[["published"]] <-
    c(NA_character_, "2018-11-19", "2018-11-19") |>
    as.Date()
```

The data are known to come from a single, healthy subject; this is annotated by assigning the value `"healthy"` to the `"condition"` column of `subjectData`.

```
subjectData(ME)[["condition"]] <-
    as.character("healthy")
```

The data are also known to come from PBMCs; this is annotated by assigning the value `"peripheral blood mononuclear cells"` to the `"sampleType"` column of `sampleData`.

```
sampleData(ME)[["sampleType"]] <-
    as.character("peripheral blood mononuclear cells")
```

As no cell annotations are provided, a naive cell type classification function is implemented below for demonstration (i.e., do not use these classifications for research purposes).

```
cellType <- function(x) {
    if (x[["CD4"]] > 0L) {
        return("T Cell")
    }

    if (x[["CD14"]] > 0L) {
        return("Monocyte")
    }

    if (x[["CD19"]] > 0L) {
        return("B Cell")
    }

    if (x[["CD56"]] > 0L) {
        return("NK Cell")
    }

    NA_character_
}
```

To annotate cell types, the `"cellType"` column of `cellData` is assigned by piping the `scADTseq` experiment to the apply function, which applies the `cellType` function over the columns of the matrix.

```
cellData(ME)[["cellType"]] <-
    experiment(ME, "scADTseq") |>
    apply(2L, cellType)
```

This completes the process of constructing a MultimodalExperiment object from the example data; now, when the `ME` variable is called, the `show` method is used to display essential information about the object.

```
ME
```

```
## MultimodalExperiment with 1 bulk and 2 single-cell experiment(s).
##
## experimentData: DataFrame with 3 row(s) and 1 column(s).
##           published
##              <Date>
## pbRNAseq         NA
## scADTseq 2018-11-19
## scRNAseq 2018-11-19
##
## subjectData: DataFrame with 1 row(s) and 1 column(s).
##             condition
##           <character>
## SUBJECT-1     healthy
##
## sampleData: DataFrame with 1 row(s) and 1 column(s).
##                                  sampleType
##                                 <character>
## SAMPLE-1 peripheral blood mononuclear cells
##
## cellData: DataFrame with 5000 row(s) and 1 column(s).
##                     cellType
##                  <character>
## AAACCTGAGAGCAATT      B Cell
## AAACCTGAGGCTCTTA     NK Cell
## ...                      ...
## TTTGTCATCATGGTCA     NK Cell
## TTTGTCATCTCGTTTA     NK Cell
##
## bulkExperiments: ExperimentList with 1 bulk experiment(s).
## [1] pbRNAseq: matrix with 3000 row(s) and 1 column(s).
##
## singleCellExperiments: ExperimentList with 2 single-cell experiment(s).
## [1] scADTseq: matrix with 8 row(s) and 5000 column(s).
## [2] scRNAseq: matrix with 3000 row(s) and 5000 column(s).
##
## Need help? Try browseVignettes("MultimodalExperiment").
## Publishing? Cite with citation("MultimodalExperiment").
```

Notice that `cellData` contains only 5,000 rows, while there are two `singleCellExperiments` of 5,000 rows each; the annotations are stored just once because they apply to the same single cells.

# 5 Manipulation

To help users understand how to manipulate a MultimodalExperiment object, a brief example of how to filter out everything except monocytes in singleCellExperiments is shown here. First, a logical vector is created from the `"cellType"` column of `cellData`.

```
isMonocyte <-
    cellData(ME)[["cellType"]] %in% "Monocyte"
```

Then, `cellData` is assigned as `cellData` subset to include only the rows which are annotated as monocytes.

```
cellData(ME) <-
    cellData(ME)[isMonocyte, , drop = FALSE]
```

When the `harmonize` method is called, the intersection of experiment, subject, sample, and cell indices from all relevant tables is taken, and extraneous indices are deleted. Notice the `scADTseq` and `scRNAseq` experiments only contain 685 columns each now.

```
harmonize(ME)
```

```
## MultimodalExperiment with 1 bulk and 2 single-cell experiment(s).
##
## experimentData: DataFrame with 3 row(s) and 1 column(s).
##           published
##              <Date>
## pbRNAseq         NA
## scADTseq 2018-11-19
## scRNAseq 2018-11-19
##
## subjectData: DataFrame with 1 row(s) and 1 column(s).
##             condition
##           <character>
## SUBJECT-1     healthy
##
## sampleData: DataFrame with 1 row(s) and 1 column(s).
##                                  sampleType
##                                 <character>
## SAMPLE-1 peripheral blood mononuclear cells
##
## cellData: DataFrame with 685 row(s) and 1 column(s).
##                     cellType
##                  <character>
## AAACCTGTCTGTTGAG    Monocyte
## AAACGGGCACCTCGTT    Monocyte
## ...                      ...
## TTTGGTTTCGCCTGTT    Monocyte
## TTTGTCAAGAAGGTTT    Monocyte
##
## bulkExperiments: ExperimentList with 1 bulk experiment(s).
## [1] pbRNAseq: matrix with 3000 row(s) and 1 column(s).
##
## singleCellExperiments: ExperimentList with 2 single-cell experiment(s).
## [1] scADTseq: matrix with 8 row(s) and 685 column(s).
## [2] scRNAseq: matrix with 3000 row(s) and 685 column(s).
##
## Need help? Try browseVignettes("MultimodalExperiment").
## Publishing? Cite with citation("MultimodalExperiment").
```

Finally, while learning to use the MultimodalExperiment package, print out the [Cheat Sheet](https://github.com/schifferl/MultimodalExperiment/blob/master/MultimodalExperiment.pdf) and consult the documentation for specific methods for further usage examples.

# 6 Session Info

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
## [1] MultimodalExperiment_1.10.0 IRanges_2.44.0
## [3] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [5] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4                jsonlite_2.0.0
##  [3] compiler_4.5.1              BiocManager_1.30.26
##  [5] BiocBaseUtils_1.12.0        SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] jquerylib_0.1.4             Seqinfo_1.0.0
## [11] yaml_2.3.10                 fastmap_1.2.0
## [13] lattice_0.22-7              R6_2.6.1
## [15] XVector_0.50.0              S4Arrays_1.10.0
## [17] MultiAssayExperiment_1.36.0 knitr_1.50
## [19] DelayedArray_0.36.0         bookdown_0.45
## [21] MatrixGenerics_1.22.0       bslib_0.9.0
## [23] rlang_1.1.6                 cachem_1.1.0
## [25] xfun_0.53                   sass_0.4.10
## [27] SparseArray_1.10.0          cli_3.6.5
## [29] digest_0.6.37               grid_4.5.1
## [31] lifecycle_1.0.4             evaluate_1.0.5
## [33] abind_1.4-8                 rmarkdown_2.30
## [35] matrixStats_1.5.0           tools_4.5.1
## [37] htmltools_0.5.8.1
```