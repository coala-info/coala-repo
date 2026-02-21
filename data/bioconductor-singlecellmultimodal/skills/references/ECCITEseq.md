# ECCITEseq Peripheral Blood

Dario Righelli

#### 04 November, 2025

#### Package

SingleCellMultiModal 1.22.0

# 1 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("SingleCellMultiModal")
```

# 2 Load libraries

```
library(MultiAssayExperiment)
library(SingleCellMultiModal)
library(SingleCellExperiment)
```

# 3 ECCITE-seq dataset

ECCITE-seq data are an evolution of the CITE-seq data
(see also [CITE-seq vignette](CITEseq.html) for more details)
by extending the CITE-seq original data types with a third one always extracted
from the same cell.
Indeed, in addition to the CITE-seq providing scRNA-seq and antibody-derived tags
(ADT), it provides around ten Hashtagged Oligo (HTO).
In particular this dataset is provided by Mimitou et al. ([2019](#ref-mimitou2019multiplexed)).

## 3.1 Downloading datasets

The user can see the available dataset by using the default options through the
CITE-seq function.

```
CITEseq(DataType="peripheral_blood", modes="*", dry.run=TRUE, version="1.0.0")
```

```
## Dataset: peripheral_blood
```

```
##     ah_id             mode file_size rdataclass rdatadateadded rdatadateremoved
## 1  EH4613       CTCL_scADT    0.4 Mb     matrix     2020-09-24             <NA>
## 2  EH4614       CTCL_scHTO    0.1 Mb     matrix     2020-09-24             <NA>
## 3  EH4615       CTCL_scRNA   14.3 Mb  dgCMatrix     2020-09-24             <NA>
## 4  EH4616       CTCL_TCRab    0.3 Mb data.frame     2020-09-24             <NA>
## 5  EH4617       CTCL_TCRgd    0.1 Mb data.frame     2020-09-24             <NA>
## 6  EH4618       CTRL_scADT    0.4 Mb     matrix     2020-09-24             <NA>
## 7  EH4619       CTRL_scHTO    0.1 Mb     matrix     2020-09-24             <NA>
## 8  EH4620       CTRL_scRNA   13.3 Mb  dgCMatrix     2020-09-24             <NA>
## 9  EH4621       CTRL_TCRab    0.2 Mb data.frame     2020-09-24             <NA>
## 10 EH4622       CTRL_TCRgd    0.1 Mb data.frame     2020-09-24             <NA>
## 11 EH8229 scRNAseq_coldata    0.1 Mb data.frame     2023-05-17             <NA>
```

Or simply by setting `dry.run = FALSE` it downloads the data and by default
creates the `MultiAssayExperiment` object.

In this example, we will use one of the two available datasets `scADT_Counts`:

```
mae <- CITEseq(DataType="peripheral_blood", modes="*", dry.run=FALSE, version="1.0.0")
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
## Warning: sampleMap[['assay']] coerced with as.factor()
```

```
mae
```

```
## A MultiAssayExperiment object of 3 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 3:
##  [1] scADT: dgCMatrix with 52 rows and 13000 columns
##  [2] scHTO: dgCMatrix with 7 rows and 13000 columns
##  [3] scRNA: dgCMatrix with 33538 rows and 10248 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

Example with actual data:

```
experiments(mae)
```

```
## ExperimentList class object of length 3:
##  [1] scADT: dgCMatrix with 52 rows and 13000 columns
##  [2] scHTO: dgCMatrix with 7 rows and 13000 columns
##  [3] scRNA: dgCMatrix with 33538 rows and 10248 columns
```

Additionally, we stored into the object metedata

## 3.2 Exploring the data structure

Check row annotations:

```
rownames(mae)
```

```
## CharacterList of length 3
## [["scADT"]] B220 (CD45R) B7-H1 (PD-L1) C-kit (CD117) ... no_match total_reads
## [["scHTO"]] HTO28_5P HTO29_5P HTO30_5P HTO44_5P bad_struct no_match total_reads
## [["scRNA"]] hg19_A1BG hg19_A1BG-AS1 hg19_A1CF ... hg19_ZZEF1 hg19_hsa-mir-1253
```

Take a peek at the `sampleMap`:

```
sampleMap(mae)
```

```
## DataFrame with 36248 rows and 3 columns
##          assay               primary               colname
##       <factor>           <character>           <character>
## 1        scADT CTCL_AAACCTGAGCTATGCT CTCL_AAACCTGAGCTATGCT
## 2        scADT CTCL_AAACCTGCAATGGAGC CTCL_AAACCTGCAATGGAGC
## 3        scADT CTCL_AAACCTGCATACTACG CTCL_AAACCTGCATACTACG
## 4        scADT CTCL_AAACCTGCATATGGTC CTCL_AAACCTGCATATGGTC
## 5        scADT CTCL_AAACCTGCATGCATGT CTCL_AAACCTGCATGCATGT
## ...        ...                   ...                   ...
## 36244    scRNA CTRL_TTTGTCAGTCACCCAG CTRL_TTTGTCAGTCACCCAG
## 36245    scRNA CTRL_TTTGTCAGTGCAGGTA CTRL_TTTGTCAGTGCAGGTA
## 36246    scRNA CTRL_TTTGTCATCACAATGC CTRL_TTTGTCATCACAATGC
## 36247    scRNA CTRL_TTTGTCATCCTAAGTG CTRL_TTTGTCATCCTAAGTG
## 36248    scRNA CTRL_TTTGTCATCGTTGACA CTRL_TTTGTCATCGTTGACA
```

## 3.3 scRNA-seq data

The scRNA-seq data are accessible with the name `scRNAseq`, which returns a
*matrix* object.

```
head(experiments(mae)$scRNA)[, 1:4]
```

```
## 6 x 4 sparse Matrix of class "dgCMatrix"
##               CTCL_AAACCTGCAATGGAGC CTCL_AAACCTGCATACTACG CTCL_AAACCTGCATATGGTC
## hg19_A1BG                         .                     .                     .
## hg19_A1BG-AS1                     .                     .                     .
## hg19_A1CF                         .                     .                     .
## hg19_A2M                          .                     .                     .
## hg19_A2M-AS1                      .                     .                     .
## hg19_A2ML1                        .                     .                     .
##               CTCL_AAACCTGCATGCATGT
## hg19_A1BG                         .
## hg19_A1BG-AS1                     .
## hg19_A1CF                         .
## hg19_A2M                          .
## hg19_A2M-AS1                      .
## hg19_A2ML1                        .
```

## 3.4 scADT data

The scADT data are accessible with the name `scADT`, which returns a
**matrix** object.

```
head(experiments(mae)$scADT)[, 1:4]
```

```
## 6 x 4 sparse Matrix of class "dgCMatrix"
##               CTCL_AAACCTGAGCTATGCT CTCL_AAACCTGCAATGGAGC CTCL_AAACCTGCATACTACG
## B220 (CD45R)                      4                     1                     .
## B7-H1 (PD-L1)                     2                     .                     3
## C-kit (CD117)                     5                     2                     3
## CCR7                             23                     7                    11
## CD11b                             4                     .                    11
## CD11c                             5                     3                     3
##               CTCL_AAACCTGCATATGGTC
## B220 (CD45R)                      1
## B7-H1 (PD-L1)                     3
## C-kit (CD117)                     5
## CCR7                             18
## CD11b                             5
## CD11c                             3
```

## 3.5 CTCL/CTRL conditions

The dataset has two different conditions (CTCL and CTRL) which samples can be identified with the `colData` accessor.

CTCL stands for cutaneous T-cell lymphoma while CTRL for control.

For example, if we want only the CTCL samples, we can run:

```
(ctclMae <- mae[,colData(mae)$condition == "CTCL",])
```

```
## A MultiAssayExperiment object of 3 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 3:
##  [1] scADT: dgCMatrix with 52 rows and 6500 columns
##  [2] scHTO: dgCMatrix with 7 rows and 6500 columns
##  [3] scRNA: dgCMatrix with 33538 rows and 5399 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

And if you’re interested into the common samples across all the modalities
you can use the `complete.cases` funtion.

```
ctclMae[,complete.cases(ctclMae),]
```

```
## A MultiAssayExperiment object of 3 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 3:
##  [1] scADT: dgCMatrix with 52 rows and 4190 columns
##  [2] scHTO: dgCMatrix with 7 rows and 4190 columns
##  [3] scRNA: dgCMatrix with 33538 rows and 4190 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

## 3.6 sgRNAs CRISPR pertubation data

The CRISPR perturbed scRNAs data are stored in a different spot
to keep their original long format.

They can be accessed with the `metadata` accessors which, in this case returns a named `list` of `data.frame`s.

```
sgRNAs <- metadata(mae)
names(sgRNAs)
```

```
## [1] "CTCL_TCRab" "CTCL_TCRgd" "CTRL_TCRab" "CTRL_TCRgd"
```

There are four different sgRNAs datasets, one per each condition and family receptors combination.

TCR stands for T-Cell Receptor, while a,b,g,d stand for alpha, beta, gamma and delta respectively.

To look into the TCRab, simply run:

```
head(sgRNAs$CTCL_TCRab)
```

```
##                 barcode is_cell                   contig_id high_confidence
## 1    AAACCTGCAATGGAGC-1    True AAACCTGCAATGGAGC-1_contig_1            True
## 10   AAACCTGGTCATACTG-1    True AAACCTGGTCATACTG-1_contig_2            True
## 100  AAAGTAGGTAAATACG-1    True AAAGTAGGTAAATACG-1_contig_1            True
## 1000 ACGGGCTTCGGCGCAT-1    True ACGGGCTTCGGCGCAT-1_contig_2            True
## 1001 ACGGGTCAGGACTGGT-1    True ACGGGTCAGGACTGGT-1_contig_1            True
## 1002 ACGGGTCAGGACTGGT-1    True ACGGGTCAGGACTGGT-1_contig_2            True
##      length chain   v_gene d_gene  j_gene c_gene full_length productive
## 1       609   TRB TRBV12-4  TRBD1 TRBJ2-7  TRBC2       False       None
## 10      552   TRB  TRBV5-5  TRBD1 TRBJ2-1  TRBC2        True       True
## 100     556   TRA TRAV12-1   None  TRAJ40   TRAC        True       True
## 1000    560   TRB TRBV20-1   None TRBJ2-1  TRBC2        True       True
## 1001    669   TRB  TRBV5-1   None TRBJ2-5  TRBC2        True       True
## 1002    720   TRA  TRAV8-1   None  TRAJ22   TRAC        True       True
##                  cdr3                                          cdr3_nt reads
## 1       CASSLGAVGEQYF          TGTGCCAGCAGTCTCGGGGCCGTCGGGGAGCAGTACTTC  4173
## 10      CASSLLRVYEQFF          TGTGCCAGCAGCTTACTCAGGGTTTATGAGCAGTTCTTC  5561
## 100  CVVNMLIGPGTYKYIF TGTGTGGTGAACATGCTCATCGGCCCAGGAACCTACAAATACATCTTT  1725
## 1000  CSARFLRGGYNEQFF    TGCAGTGCTAGGTTCCTCCGGGGTGGCTACAATGAGCAGTTCTTC  8428
## 1001     CASSPPGETQYF             TGCGCCAGCAGTCCCCCGGGAGAGACCCAGTACTTC 27854
## 1002   CAVNGAGSARQLTF       TGTGCCGTGAATGGAGCTGGTTCTGCAAGGCAACTGACCTTT  6497
##      umis raw_clonotype_id         raw_consensus_id
## 1       2     clonotype126                     None
## 10      3      clonotype31  clonotype31_consensus_2
## 100     1       clonotype3   clonotype3_consensus_2
## 1000    6       clonotype2   clonotype2_consensus_2
## 1001   17     clonotype289 clonotype289_consensus_2
## 1002    4     clonotype289 clonotype289_consensus_1
```

# 4 SingleCellExperiment object conversion

Because of already large use of some methodologies (such as
in the [SingleCellExperiment vignette][1] or [CiteFuse Vignette][2] where the
`SingleCellExperiment` object is used for CITE-seq data,
we provide a function for the conversion of our CITE-seq `MultiAssayExperiment`
object into a `SingleCellExperiment` object with scRNA-seq data as counts and
scADT data as `altExp`s.

```
sce <- CITEseq(DataType="peripheral_blood", modes="*", dry.run=FALSE,
               version="1.0.0", DataClass="SingleCellExperiment")
```

```
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
## Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
##   potential for errors with mixed data types
```

```
## Warning: sampleMap[['assay']] coerced with as.factor()
```

```
sce
```

```
## class: SingleCellExperiment
## dim: 33538 8482
## metadata(4): CTCL_TCRab CTCL_TCRgd CTRL_TCRab CTRL_TCRgd
## assays(1): counts
## rownames(33538): hg19_A1BG hg19_A1BG-AS1 ... hg19_ZZEF1
##   hg19_hsa-mir-1253
## rowData names(0):
## colnames(8482): CTCL_AAACCTGCAATGGAGC CTCL_AAACCTGCATACTACG ...
##   CTRL_TTTGTCATCCTAAGTG CTRL_TTTGTCATCGTTGACA
## colData names(9): sampleID condition ... discard_CTCL discard
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(2): scADT scHTO
```

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] SingleCellExperiment_1.32.0 SingleCellMultiModal_1.22.0
##  [3] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0          rjson_0.2.23             xfun_0.54
##  [4] bslib_0.9.0              httr2_1.2.1              lattice_0.22-7
##  [7] vctrs_0.6.5              tools_4.5.1              curl_7.0.0
## [10] tibble_3.3.0             AnnotationDbi_1.72.0     RSQLite_2.4.3
## [13] blob_1.2.4               pkgconfig_2.0.3          BiocBaseUtils_1.12.0
## [16] Matrix_1.7-4             dbplyr_2.5.1             lifecycle_1.0.4
## [19] compiler_4.5.1           Biostrings_2.78.0        htmltools_0.5.8.1
## [22] sass_0.4.10              yaml_2.3.10              pillar_1.11.1
## [25] crayon_1.5.3             jquerylib_0.1.4          DelayedArray_0.36.0
## [28] cachem_1.1.0             magick_2.9.0             abind_1.4-8
## [31] ExperimentHub_3.0.0      AnnotationHub_4.0.0      tidyselect_1.2.1
## [34] digest_0.6.37            purrr_1.1.0              dplyr_1.1.4
## [37] bookdown_0.45            BiocVersion_3.22.0       fastmap_1.2.0
## [40] grid_4.5.1               cli_3.6.5                SparseArray_1.10.1
## [43] magrittr_2.0.4           S4Arrays_1.10.0          withr_3.0.2
## [46] filelock_1.0.3           rappdirs_0.3.3           bit64_4.6.0-1
## [49] rmarkdown_2.30           XVector_0.50.0           httr_1.4.7
## [52] bit_4.6.0                png_0.1-8                SpatialExperiment_1.20.0
## [55] memoise_2.0.1            evaluate_1.0.5           knitr_1.50
## [58] BiocFileCache_3.0.0      rlang_1.1.6              Rcpp_1.1.0
## [61] glue_1.8.0               DBI_1.2.3                formatR_1.14
## [64] BiocManager_1.30.26      jsonlite_2.0.0           R6_2.6.1
```

# 6 Additional References

<https://www.bioconductor.org/packages/release/bioc/vignettes/SingleCellExperiment/inst/doc/intro.html#5_adding_alternative_feature_sets>
<http://www.bioconductor.org/packages/release/bioc/vignettes/CiteFuse/inst/doc/CiteFuse.html>

# References

Mimitou, Eleni P, Anthony Cheng, Antonino Montalbano, Stephanie Hao, Marlon Stoeckius, Mateusz Legut, Timothy Roush, et al. 2019. “Multiplexed Detection of Proteins, Transcriptomes, Clonotypes and Crispr Perturbations in Single Cells.” *Nature Methods* 16 (5): 409–12.