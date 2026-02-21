# curatedTCGAData

#### 18 November 2025

#### Package

curatedTCGAData 1.32.1

# 1 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("curatedTCGAData")
```

Load packages:

```
library(curatedTCGAData)
library(MultiAssayExperiment)
library(TCGAutils)
```

# 2 Citing `curatedTCGAData`

Your citations are important to the project and help us secure funding. Please
refer to the [References](#references) section to see the Ramos et al. ([2020](#ref-Ramos2020-ya)) and
Ramos et al. ([2017](#ref-Ramos2017-og)) citations. For the BibTeX entries, run the `citation` function
(after installation):

```
citation("curatedTCGAData")
citation("MultiAssayExperiment")
```

`curatedTCGAData` uses `MultiAssayExperiment` to coordinate and represent the
data. Please cite the `MultiAssayExperiment` [Cancer Research](https://cancerres.aacrjournals.org/content/77/21/e39) publication.
You can see the PDF of our public data publication on
[JCO Clinical Cancer Informatics](https://ascopubs.org/doi/pdf/10.1200/CCI.19.00119).

# 3 Data versions

`curatedTCGAData` now has a version `2.0.1` set of data with a number of
improvements and bug fixes. To access the previous data release,
please use version `1.1.38`. This can be added to the
`curatedTCGAData` function as:

```
head(
    curatedTCGAData(
        diseaseCode = "COAD", assays = "*", version = "1.1.38"
    )
)
```

```
## See '?curatedTCGAData' for 'diseaseCode' and 'assays' inputs
```

```
## Querying EH with: COAD_CNASeq-20160128
```

```
## Querying EH with: COAD_CNASNP-20160128
```

```
## Querying EH with: COAD_CNVSNP-20160128
```

```
## Querying EH with: COAD_GISTIC_AllByGene-20160128
```

```
## Querying EH with: COAD_GISTIC_Peaks-20160128
```

```
## Querying EH with: COAD_GISTIC_ThresholdedByGene-20160128
```

```
## Querying EH with: COAD_Methylation_methyl27-20160128_assays
```

```
## Querying EH with: COAD_Methylation_methyl27-20160128_se
```

```
## Querying EH with: COAD_Methylation_methyl450-20160128_assays
```

```
## Querying EH with: COAD_Methylation_methyl450-20160128_se
```

```
## Querying EH with: COAD_miRNASeqGene-20160128
```

```
## Querying EH with: COAD_mRNAArray-20160128
```

```
## Querying EH with: COAD_Mutation-20160128
```

```
## Querying EH with: COAD_RNASeq2GeneNorm-20160128
```

```
## Querying EH with: COAD_RNASeqGene-20160128
```

```
## Querying EH with: COAD_RPPAArray-20160128
```

```
##    ah_id                                  title file_size
## 1  EH625                   COAD_CNASeq-20160128    0.3 Mb
## 2  EH626                   COAD_CNASNP-20160128    3.9 Mb
## 3  EH627                   COAD_CNVSNP-20160128    0.9 Mb
## 4  EH629         COAD_GISTIC_AllByGene-20160128    0.5 Mb
## 5 EH2132             COAD_GISTIC_Peaks-20160128      0 Mb
## 6  EH630 COAD_GISTIC_ThresholdedByGene-20160128    0.3 Mb
##                   rdataclass rdatadateadded rdatadateremoved
## 1           RaggedExperiment     2017-10-10             <NA>
## 2           RaggedExperiment     2017-10-10             <NA>
## 3           RaggedExperiment     2017-10-10             <NA>
## 4       SummarizedExperiment     2017-10-10             <NA>
## 5 RangedSummarizedExperiment     2019-01-09             <NA>
## 6       SummarizedExperiment     2017-10-10             <NA>
```

## 3.1 Version 2.0.1

Here is a list of changes to the data provided in version `2.0.1`

* provides `RNASeq2Gene` assays with RSEM gene expression values
* Genomic information is present in `RaggedExperiment` objects as `GRCh37`
  rather than `37`
* Assays coming from the same platform are now merged and provided as one
  (e.g., in `OV` and `GBM`)
* `mRNAArray` data now returns `matrix` data instead of `DataFrame`

# 4 Data source

These data were processed by Broad Firehose pipelines and accessed using
*[RTCGAToolbox](https://bioconductor.org/packages/3.22/RTCGAToolbox)*. For details on the preprocessing
methods used, see the
[Broad GDAC documentation](https://broadinstitute.atlassian.net/wiki/spaces/GDAC/pages/844334346/Documentation).

# 5 Downloading datasets

To get a neat table of cancer data available in `curatedTCGAData`, see
the `diseaseCodes` dataset from `TCGAutils`. Availability is indicated by the
`Available` column in the dataset.

```
data('diseaseCodes', package = "TCGAutils")
head(diseaseCodes)
```

```
##   Study.Abbreviation Available SubtypeData
## 1                ACC       Yes         Yes
## 2               BLCA       Yes         Yes
## 3               BRCA       Yes         Yes
## 4               CESC       Yes          No
## 5               CHOL       Yes          No
## 6               CNTL        No          No
##                                                         Study.Name
## 1                                         Adrenocortical carcinoma
## 2                                     Bladder Urothelial Carcinoma
## 3                                        Breast invasive carcinoma
## 4 Cervical squamous cell carcinoma and endocervical adenocarcinoma
## 5                                               Cholangiocarcinoma
## 6                                                         Controls
```

Alternatively, you can get the full table of data available using wildcards
`'*'` in the `diseaseCode` argument of the main function:

```
curatedTCGAData(
    diseaseCode = "*", assays = "*", version = "2.0.1"
)
```

To see what assays are available for a particular TCGA disease code, leave the
`assays` argument as a wildcard (`'*'`):

```
head(
    curatedTCGAData(
        diseaseCode = "COAD", assays = "*", version = "2.0.1"
    )
)
```

```
## See '?curatedTCGAData' for 'diseaseCode' and 'assays' inputs
```

```
## Querying EH with: COAD_CNASeq-20160128
```

```
## Querying EH with: COAD_CNASNP-20160128
```

```
## Querying EH with: COAD_CNVSNP-20160128
```

```
## Querying EH with: COAD_GISTIC_AllByGene-20160128
```

```
## Querying EH with: COAD_GISTIC_Peaks-20160128
```

```
## Querying EH with: COAD_GISTIC_ThresholdedByGene-20160128
```

```
## Querying EH with: COAD_Methylation_methyl27-20160128_assays
```

```
## Querying EH with: COAD_Methylation_methyl27-20160128_se
```

```
## Querying EH with: COAD_Methylation_methyl450-20160128_assays
```

```
## Querying EH with: COAD_Methylation_methyl450-20160128_se
```

```
## Querying EH with: COAD_miRNASeqGene-20160128
```

```
## Querying EH with: COAD_mRNAArray-20160128
```

```
## Querying EH with: COAD_Mutation-20160128
```

```
## Querying EH with: COAD_RNASeq2Gene-20160128
```

```
## Querying EH with: COAD_RNASeq2GeneNorm_illuminaga-20160128
```

```
## Querying EH with: COAD_RNASeq2GeneNorm_illuminahiseq-20160128
```

```
## Querying EH with: COAD_RNASeqGene-20160128
```

```
## Querying EH with: COAD_RPPAArray-20160128
```

```
##    ah_id                                  title file_size
## 1 EH4820                   COAD_CNASeq-20160128    0.3 Mb
## 2 EH4821                   COAD_CNASNP-20160128    3.9 Mb
## 3 EH4822                   COAD_CNVSNP-20160128    0.9 Mb
## 4 EH4824         COAD_GISTIC_AllByGene-20160128    0.4 Mb
## 5 EH4825             COAD_GISTIC_Peaks-20160128      0 Mb
## 6 EH4826 COAD_GISTIC_ThresholdedByGene-20160128    0.2 Mb
##                   rdataclass rdatadateadded rdatadateremoved
## 1           RaggedExperiment     2021-01-27             <NA>
## 2           RaggedExperiment     2021-01-27             <NA>
## 3           RaggedExperiment     2021-01-27             <NA>
## 4       SummarizedExperiment     2021-01-27             <NA>
## 5 RangedSummarizedExperiment     2021-01-27             <NA>
## 6       SummarizedExperiment     2021-01-27             <NA>
```

# 6 Caveats for working with TCGA data

Not all TCGA samples are cancer, there are a mix of samples in each of the
33 cancer types. Use `sampleTables` on the `MultiAssayExperiment` object
along with `data(sampleTypes, package = "TCGAutils")` to see what samples are
present in the data. There may be tumors that were used to create multiple
contributions leading to technical replicates. These should be resolved using
the appropriate helper functions such as `mergeReplicates`. Primary tumors
should be selected using `TCGAutils::TCGAsampleSelect` and used as input
to the subsetting mechanisms. See the “Samples in Assays” section of this
vignette.

## 6.1 ACC dataset example

```
(accmae <- curatedTCGAData(
    "ACC", c("CN*", "Mutation"), version = "2.0.1", dry.run = FALSE
))
```

```
## A MultiAssayExperiment object of 3 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 3:
##  [1] ACC_CNASNP-20160128: RaggedExperiment with 79861 rows and 180 columns
##  [2] ACC_CNVSNP-20160128: RaggedExperiment with 21052 rows and 180 columns
##  [3] ACC_Mutation-20160128: RaggedExperiment with 20166 rows and 90 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

**Note**. For more on how to use a `MultiAssayExperiment` please see the
`MultiAssayExperiment` vignette.

### 6.1.1 Subtype information

Some cancer datasets contain associated subtype information within the
clinical datasets provided. This subtype information is included in the
metadata of `colData` of the `MultiAssayExperiment` object. To obtain these
variable names, use the `getSubtypeMap` function from TCGA utils:

```
head(getSubtypeMap(accmae))
```

```
##         ACC_annotations   ACC_subtype
## 1            Patient_ID     patientID
## 2 histological_subtypes     Histology
## 3         mrna_subtypes       C1A/C1B
## 4         mrna_subtypes       mRNA_K4
## 5                  cimp    MethyLevel
## 6     microrna_subtypes miRNA cluster
```

### 6.1.2 Typical clinical variables

Another helper function provided by TCGAutils allows users to obtain a set
of consistent clinical variable names across several cancer types.
Use the `getClinicalNames` function to obtain a character vector of common
clinical variables such as vital status, years to birth, days to death, etc.

```
head(getClinicalNames("ACC"))
```

```
## [1] "years_to_birth"        "vital_status"          "days_to_death"
## [4] "days_to_last_followup" "tumor_tissue_site"     "pathologic_stage"
```

```
colData(accmae)[, getClinicalNames("ACC")][1:5, 1:5]
```

```
## DataFrame with 5 rows and 5 columns
##              years_to_birth vital_status days_to_death days_to_last_followup
##                   <integer>    <integer>     <integer>             <integer>
## TCGA-OR-A5J1             58            1          1355                    NA
## TCGA-OR-A5J2             44            1          1677                    NA
## TCGA-OR-A5J3             23            0            NA                  2091
## TCGA-OR-A5J4             23            1           423                    NA
## TCGA-OR-A5J5             30            1           365                    NA
##              tumor_tissue_site
##                    <character>
## TCGA-OR-A5J1           adrenal
## TCGA-OR-A5J2           adrenal
## TCGA-OR-A5J3           adrenal
## TCGA-OR-A5J4           adrenal
## TCGA-OR-A5J5           adrenal
```

### 6.1.3 Identifying samples in Assays

The `sampleTables` function gives an overview of sample types / codes
present in the data:

```
sampleTables(accmae)
```

```
## $`ACC_CNASNP-20160128`
##
## 01 10 11
## 90 85  5
##
## $`ACC_CNVSNP-20160128`
##
## 01 10 11
## 90 85  5
##
## $`ACC_Mutation-20160128`
##
## 01
## 90
```

You can use the reference dataset (`sampleTypes`) from the `TCGAutils` package
to interpret the TCGA sample codes above. The dataset provides clinically
meaningful descriptions:

```
data(sampleTypes, package = "TCGAutils")
head(sampleTypes)
```

```
##   Code                                      Definition Short.Letter.Code
## 1   01                             Primary Solid Tumor                TP
## 2   02                           Recurrent Solid Tumor                TR
## 3   03 Primary Blood Derived Cancer - Peripheral Blood                TB
## 4   04    Recurrent Blood Derived Cancer - Bone Marrow              TRBM
## 5   05                        Additional - New Primary               TAP
## 6   06                                      Metastatic                TM
```

### 6.1.4 Separating samples

Often, an analysis is performed comparing two groups of samples to each other.
To facilitate the separation of samples, the `TCGAsplitAssays` function from
`TCGAutils` identifies all sample types in the assays and moves each into its
own assay. By default, all discoverable sample types are separated into a
separate experiment. In this case we requested only solid tumors and blood
derived normal samples as seen in the `sampleTypes` reference dataset:

```
sampleTypes[sampleTypes[["Code"]] %in% c("01", "10"), ]
```

```
##    Code           Definition Short.Letter.Code
## 1    01  Primary Solid Tumor                TP
## 10   10 Blood Derived Normal                NB
```

```
TCGAsplitAssays(accmae, c("01", "10"))
```

```
## Warning: Some 'sampleCodes' not found in assays
```

```
## A MultiAssayExperiment object of 5 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 5:
##  [1] 01_ACC_CNASNP-20160128: RaggedExperiment with 79861 rows and 90 columns
##  [2] 10_ACC_CNASNP-20160128: RaggedExperiment with 79861 rows and 85 columns
##  [3] 01_ACC_CNVSNP-20160128: RaggedExperiment with 21052 rows and 90 columns
##  [4] 10_ACC_CNVSNP-20160128: RaggedExperiment with 21052 rows and 85 columns
##  [5] 01_ACC_Mutation-20160128: RaggedExperiment with 20166 rows and 90 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

To obtain a logical vector that could be used for subsetting a
`MultiAsssayExperiment`, refer to `TCGAsampleSelect`. To select only primary
tumors, use the function on the colnames of the `MultiAssayExperiment`:

```
tums <- TCGAsampleSelect(colnames(accmae), "01")
```

### 6.1.5 TCGAprimaryTumors convenience

If interested in only the primary tumor samples, `TCGAutils` provides a
convenient operation to extract primary tumors from the MultiAssayExperiment
representation. The `TCGAprimaryTumors` function will return only
samples with primary tumor (either solid tissue or blood) samples using
the above operations in the background:

```
(primaryTumors <- TCGAprimaryTumors(accmae))
```

```
## harmonizing input:
##   removing 180 sampleMap rows with 'colname' not in colnames of experiments
```

```
## A MultiAssayExperiment object of 3 listed
##  experiments with user-defined names and respective classes.
##  Containing an ExperimentList class object of length 3:
##  [1] ACC_CNASNP-20160128: RaggedExperiment with 79861 rows and 90 columns
##  [2] ACC_CNVSNP-20160128: RaggedExperiment with 21052 rows and 90 columns
##  [3] ACC_Mutation-20160128: RaggedExperiment with 20166 rows and 90 columns
## Functionality:
##  experiments() - obtain the ExperimentList instance
##  colData() - the primary/phenotype DataFrame
##  sampleMap() - the sample coordination DataFrame
##  `$`, `[`, `[[` - extract colData columns, subset, or experiment
##  *Format() - convert into a long or wide DataFrame
##  assays() - convert ExperimentList to a SimpleList of matrices
##  exportClass() - save data to flat files
```

To view the results, run `sampleTables` again on the output:

```
sampleTables(primaryTumors)
```

```
## $`ACC_CNASNP-20160128`
##
## 01
## 90
##
## $`ACC_CNVSNP-20160128`
##
## 01
## 90
##
## $`ACC_Mutation-20160128`
##
## 01
## 90
```

### 6.1.6 Keeping colData in an extracted Assay

When extracting a single assay from the `MultiAssayExperiment` the user
can conveniently choose to keep the `colData` from the `MultiAssayExperiment`
in the extracted assay **given** that the class of the extracted assay
supports `colData` storage and operations. `SummarizedExperiment` and its
derived data representations support this operation. In this example, we
extract the mutation data as represented by a `RaggedExperiment` which was
designed to have `colData` functionality. The default replacement method
is to ‘append’ the `MultiAssayExperiment` `colData` to the `RaggedExperiment`
assay. The `mode` argument can also completely replace the `colData` when set
to ‘replace’.

```
(accmut <- getWithColData(accmae, "ACC_Mutation-20160128", mode = "append"))
```

```
## Warning: 'experiments' dropped; see 'drops()'
```

```
## class: RaggedExperiment
## dim: 20166 90
## assays(47): Hugo_Symbol Entrez_Gene_Id ... Trna_alt1 Trna_alt2
## rownames: NULL
## colnames(90): TCGA-OR-A5J1-01A-11D-A29I-10 TCGA-OR-A5J2-01A-11D-A29I-10
##   ... TCGA-PK-A5HB-01A-11D-A29I-10 TCGA-PK-A5HC-01A-11D-A30A-10
## colData names(822): patientID years_to_birth ... genome_doublings ADS
```

```
head(colData(accmut)[, 1:4])
```

```
## DataFrame with 6 rows and 4 columns
##                                 patientID years_to_birth vital_status
##                               <character>      <integer>    <integer>
## TCGA-OR-A5J1-01A-11D-A29I-10 TCGA-OR-A5J1             58            1
## TCGA-OR-A5J2-01A-11D-A29I-10 TCGA-OR-A5J2             44            1
## TCGA-OR-A5J3-01A-11D-A29I-10 TCGA-OR-A5J3             23            0
## TCGA-OR-A5J4-01A-11D-A29I-10 TCGA-OR-A5J4             23            1
## TCGA-OR-A5J5-01A-11D-A29I-10 TCGA-OR-A5J5             30            1
## TCGA-OR-A5J6-01A-31D-A29I-10 TCGA-OR-A5J6             29            0
##                              days_to_death
##                                  <integer>
## TCGA-OR-A5J1-01A-11D-A29I-10          1355
## TCGA-OR-A5J2-01A-11D-A29I-10          1677
## TCGA-OR-A5J3-01A-11D-A29I-10            NA
## TCGA-OR-A5J4-01A-11D-A29I-10           423
## TCGA-OR-A5J5-01A-11D-A29I-10           365
## TCGA-OR-A5J6-01A-31D-A29I-10            NA
```

### 6.1.7 Example use of RaggedExperiment

The RaggedExperiment representation provides a matrix view of a `GRangesList`
internal representation. Typical use of a RaggedExperiment involves a number of
functions to reshape ‘ragged’ measurements into a matrix-like format. These
include `sparseAssay`, `compactAssay`, `disjoinAssay`, and `qreduceAssay`.
See the `RaggedExperiment` vignette for details. In this example, we convert
entrez gene identifiers to numeric in order to show how we can create a sparse
matrix representation of any numeric metadata column in the `RaggedExperiment`.

```
ragex <- accmae[["ACC_Mutation-20160128"]]
## convert score to numeric
mcols(ragex)$Entrez_Gene_Id <- as.numeric(mcols(ragex)[["Entrez_Gene_Id"]])
sparseAssay(ragex, i = "Entrez_Gene_Id", sparse=TRUE)[1:6, 1:3]
```

```
## 6 x 3 sparse Matrix of class "dgCMatrix"
##                         TCGA-OR-A5J1-01A-11D-A29I-10
## 1:11561526:+                                   57540
## 1:12309384:+                                   55187
## 1:33820015:+                                    1912
## 1:152785074-152785097:+                       353132
## 1:152800122:+                                 353131
## 1:152800131:+                                 353131
##                         TCGA-OR-A5J2-01A-11D-A29I-10
## 1:11561526:+                                       .
## 1:12309384:+                                       .
## 1:33820015:+                                       .
## 1:152785074-152785097:+                            .
## 1:152800122:+                                      .
## 1:152800131:+                                      .
##                         TCGA-OR-A5J3-01A-11D-A29I-10
## 1:11561526:+                                       .
## 1:12309384:+                                       .
## 1:33820015:+                                       .
## 1:152785074-152785097:+                            .
## 1:152800122:+                                      .
## 1:152800131:+                                      .
```

Users who would like to use the internal `GRangesList` representation can
invoke the coercion method:

```
as(ragex, "GRangesList")
```

```
## GRangesList object of length 90:
## $`TCGA-OR-A5J1-01A-11D-A29I-10`
## GRanges object with 66 ranges and 47 metadata columns:
##        seqnames              ranges strand | Hugo_Symbol Entrez_Gene_Id
##           <Rle>           <IRanges>  <Rle> | <character>      <numeric>
##    [1]        1            11561526      + |      PTCHD2          57540
##    [2]        1            12309384      + |      VPS13D          55187
##    [3]        1            33820015      + |        PHC2           1912
##    [4]        1 152785074-152785097      + |       LCE1B         353132
##    [5]        1           152800122      + |       LCE1A         353131
##    ...      ...                 ...    ... .         ...            ...
##   [62]        9           132395087      + |       NTMT1          28989
##   [63]        9           139272547      + |      SNAPC4           6621
##   [64]        X           101409174      + |        BEX5         340542
##   [65]        X           154157135      + |          F8           2157
##   [66]       17   80274159-80274160      + |         CD7            924
##                        Center  NCBI_Build Variant_Classification Variant_Type
##                   <character> <character>            <character>  <character>
##    [1] hgsc.bcm.edu;broad.m..          37                 Silent          SNP
##    [2] hgsc.bcm.edu;broad.m..          37                 Silent          SNP
##    [3] hgsc.bcm.edu;broad.m..          37                 Silent          SNP
##    [4] hgsc.bcm.edu;broad.m..          37           In_Frame_Del          DEL
##    [5]           hgsc.bcm.edu          37                 Silent          SNP
##    ...                    ...         ...                    ...          ...
##   [62] hgsc.bcm.edu;broad.m..          37                 Silent          SNP
##   [63] broad.mit.edu;bcgsc.ca          37                 Silent          SNP
##   [64] hgsc.bcm.edu;broad.m..          37      Missense_Mutation          SNP
##   [65] hgsc.bcm.edu;broad.m..          37      Missense_Mutation          SNP
##   [66]          broad.mit.edu          37        Frame_Shift_Ins          INS
##              Reference_Allele      Tumor_Seq_Allele1 Tumor_Seq_Allele2
##                   <character>            <character>       <character>
##    [1]                      G                      G                 A
##    [2]                      T                      T                 G
##    [3]                      C                      C                 T
##    [4] GCTGTGGCTCCAGCTCTGGG.. GCTGTGGCTCCAGCTCTGGG..                 -
##    [5]                      C                      C                 T
##    ...                    ...                    ...               ...
##   [62]                      C                      C                 T
##   [63]                      C                      C                 T
##   [64]                      C                      C                 T
##   [65]                      T                      T                 C
##   [66]                      -                      -                 T
##           dbSNP_RS dbSNP_Val_Status Matched_Norm_Sample_Barcode
##        <character>      <character>                 <character>
##    [1]       novel                       TCGA-OR-A5J1-10A-01D..
##    [2]       novel                       TCGA-OR-A5J1-10A-01D..
##    [3]       novel                       TCGA-OR-A5J1-10A-01D..
##    [4]       novel                       TCGA-OR-A5J1-10A-01D..
##    [5] rs148143373      byfrequency      TCGA-OR-A5J1-10A-01D..
##    ...         ...              ...                         ...
##   [62]       novel                       TCGA-OR-A5J1-10A-01D..
##   [63]       novel                       TCGA-OR-A5J1-10A-01D..
##   [64]       novel                       TCGA-OR-A5J1-10A-01D..
##   [65]       novel                       TCGA-OR-A5J1-10A-01D..
##   [66]       novel                       TCGA-OR-A5J1-10A-01D..
##        Match_Norm_Seq_Allele1 Match_Norm_Seq_Allele2 Tumor_Validation_Allele1
##                   <character>            <character>              <character>
##    [1]                      G                      G                        -
##    [2]                      T                      T                        -
##    [3]                      C                      C                        -
##    [4] GCTGTGGCTCCAGCTCTGGG.. GCTGTGGCTCCAGCTCTGGG..                        -
##    [5]                      C                      C                        -
##    ...                    ...                    ...                      ...
##   [62]                      C                      C                        -
##   [63]                                                                      -
##   [64]                      C                      C                        -
##   [65]                      T                      T                        -
##   [66]                                                                      -
##        Tumor_Validation_Allele2 Match_Norm_Validation_Allele1
##                     <character>                   <character>
##    [1]                        -                             -
##    [2]                        -                             -
##    [3]                        -                             -
##    [4]                        -                             -
##    [5]                        -                             -
##    ...                      ...                           ...
##   [62]                        -                             -
##   [63]                        -                             -
##   [64]                        -                             -
##   [65]                        -                             -
##   [66]                        -                             -
##        Match_Norm_Validation_Allele2 Verification_Status Validation_Status
##                          <character>         <character>       <character>
##    [1]                             -             Unknown          Untested
##    [2]                             -             Unknown          Untested
##    [3]                             -             Unknown          Untested
##    [4]                             -             Unknown          Untested
##    [5]                             -             Unknown          Untested
##    ...                           ...                 ...               ...
##   [62]                             -             Unknown          Untested
##   [63]                             -             Unknown          Untested
##   [64]                             -             Unknown          Untested
##   [65]                             -             Unknown          Untested
##   [66]                             -             Unknown          Untested
##        Mutation_Status Sequencing_Phase Sequence_Source Validation_Method
##            <character>      <character>     <character>       <character>
##    [1]         Somatic          Phase_I             WXS              none
##    [2]         Somatic          Phase_I             WXS              none
##    [3]         Somatic          Phase_I             WXS              none
##    [4]         Somatic          Phase_I             WXS              none
##    [5]         Somatic          Phase_I             WXS              none
##    ...             ...              ...             ...               ...
##   [62]         Somatic          Phase_I             WXS              none
##   [63]         Somatic          Phase_I             WXS              none
##   [64]         Somatic          Phase_I             WXS              none
##   [65]         Somatic          Phase_I             WXS              none
##   [66]         Somatic          Phase_I             WXS              none
##              Score    BAM_File      Sequencer      Tumor_Sample_UUID
##        <character> <character>    <character>            <character>
##    [1]           .           . Illumina GAIIx 352062e7-9b06-41cd-8..
##    [2]           .           . Illumina GAIIx 352062e7-9b06-41cd-8..
##    [3]           .           . Illumina GAIIx 352062e7-9b06-41cd-8..
##    [4]           .           . Illumina GAIIx 352062e7-9b06-41cd-8..
##    [5]           .           . Illumina GAIIx 352062e7-9b06-41cd-8..
##    ...         ...         ...            ...                    ...
##   [62]           .           . Illumina GAIIx 352062e7-9b06-41cd-8..
##   [63]           .           . Illumina GAIIx 352062e7-9b06-41cd-8..
##   [64]           .           . Illumina GAIIx 352062e7-9b06-41cd-8..
##   [65]           .           . Illumina GAIIx 352062e7-9b06-41cd-8..
##   [66]           .           . Illumina GAIIx 352062e7-9b06-41cd-8..
##        Matched_Norm_Sample_UUID COSMIC_Codon COSMIC_Gene Transcript_Id
##                     <character>  <character> <character>   <character>
##    [1]   1d288ab9-ab2d-4483-a..            .  PTCHD2-209     NM_020780
##    [2]   1d288ab9-ab2d-4483-a..            .   VPS13D-95     NM_015378
##    [3]   1d288ab9-ab2d-4483-a..            .    PHC2-227     NM_198040
##    [4]   1d288ab9-ab2d-4483-a..            .    LCE1B-68     NM_178349
##    [5]   1d288ab9-ab2d-4483-a..            .    LCE1A-70     NM_178348
##    ...                      ...          ...         ...           ...
##   [62]   1d288ab9-ab2d-4483-a..            .           .     NM_014064
##   [63]   1d288ab9-ab2d-4483-a..            .   SNAPC4-90     NM_003086
##   [64]   1d288ab9-ab2d-4483-a..            .     BEX5-86  NM_001012978
##   [65]   1d288ab9-ab2d-4483-a..            .      F8-182     NM_000132
##   [66]   1d288ab9-ab2d-4483-a..            .      CD7-90     NM_006137
##               Exon   ChromChange    AAChange Genome_Plus_Minus_10_Bp
##        <character>   <character> <character>             <character>
##    [1]       exon2       c.G477A     p.L159L           GCAGCTGCATCTC
##    [2]       exon6       c.T552G     p.A184A           AAATGCTGTGAAT
##    [3]       exon8      c.G1542A     p.P514P           TGGGGACGGCTGG
##    [4]       exon1  c.152_175del  p.51_59del           GAGGCTGCTGTGG
##    [5]       exon1       c.C174T      p.G58G           TGGGGGCGGCTGC
##    ...         ...           ...         ...                     ...
##   [62]       exon2       c.C105T      p.G35G           GTATGGCCACATC
##   [63]      exon21      c.G3732A    p.Q1244Q           CCCAGGCTGGCGC
##   [64]       exon3        c.G64A      p.A22T           CTAAAGCGGGGGC
##   [65]      exon14      c.A4930G    p.T1644A           CCCAGGTGACTTC
##   [66]       exon3 c.524_525insA    p.A175fs           GAGGCTGCTGGCG
##        Drug_Target     TTotCov     TVarCov     NTotCov     NVarCov
##        <character> <character> <character> <character> <character>
##    [1]           .          22           8          38           0
##    [2]           .         127          48          65           0
##    [3]           .         123          55          81           0
##    [4]           .         105          22         105           0
##    [5]           .          73           8          73           0
##    ...         ...         ...         ...         ...         ...
##   [62]           .         175          71         178           0
##   [63]           .          19           5          36           0
##   [64]           .          31          27          52           0
##   [65]           .          55           5          66           0
##   [66]           .          26           8          57           0
##           dbSNPPopFreq    Trna_tot    Trna_ref    Trna_var   Trna_alt1
##            <character> <character> <character> <character> <character>
##    [1]               .           0           0           0           0
##    [2]               .           0           0           0           0
##    [3]               .           1           1           0           0
##    [4]               .           0           0           0           0
##    [5] C|1.000;T|0.000           0           0           0           0
##    ...             ...         ...         ...         ...         ...
##   [62]               .          99          65          34           0
##   [63]               .           9           6           3           0
##   [64]               .           7           7           0           0
##   [65]               .           0           0           0           0
##   [66]               .           0           0           0           0
##          Trna_alt2
##        <character>
##    [1]           0
##    [2]           0
##    [3]           0
##    [4]           0
##    [5]           0
##    ...         ...
##   [62]           0
##   [63]           0
##   [64]           0
##   [65]           0
##   [66]           0
##   -------
##   seqinfo: 24 sequences from GRCh37 genome; no seqlengths
##
## ...
## <89 more elements>
```

## 6.2 Exporting Data

MultiAssayExperiment provides users with an integrative representation of
multi-omic TCGA data at the convenience of the user. For those users who
wish to use alternative environments, we have provided an export function to
extract all the data from a MultiAssayExperiment instance and write them
to a series of files:

```
td <- tempdir()
tempd <- file.path(td, "ACCMAE")
if (!dir.exists(tempd))
    dir.create(tempd)

exportClass(accmae, dir = tempd, fmt = "csv", ext = ".csv")
```

```
## Writing about 6 files to disk...
```

```
## [1] "/tmp/RtmpEAPfkz/ACCMAE/accmae_META_1.csv"
## [2] "/tmp/RtmpEAPfkz/ACCMAE/accmae_ACC_CNASNP-20160128.csv"
## [3] "/tmp/RtmpEAPfkz/ACCMAE/accmae_ACC_CNVSNP-20160128.csv"
## [4] "/tmp/RtmpEAPfkz/ACCMAE/accmae_ACC_Mutation-20160128.csv"
## [5] "/tmp/RtmpEAPfkz/ACCMAE/accmae_colData.csv"
## [6] "/tmp/RtmpEAPfkz/ACCMAE/accmae_sampleMap.csv"
```

This works for all data classes stored (e.g., `RaggedExperiment`, `HDF5Matrix`,
`SummarizedExperiment`) in the `MultiAssayExperiment` via the `assays` method
which converts classes to `matrix` format (using individual `assay` methods).

# Session Information

Click here to expand

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] RaggedExperiment_1.34.0     TCGAutils_1.30.0
##  [3] curatedTCGAData_1.32.1      MultiAssayExperiment_1.36.1
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] BiocGenerics_0.56.0         generics_0.1.4
## [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1          dplyr_1.1.4
##  [3] blob_1.2.4                filelock_1.0.3
##  [5] Biostrings_2.78.0         bitops_1.0-9
##  [7] fastmap_1.2.0             RCurl_1.98-1.17
##  [9] BiocFileCache_3.0.0       promises_1.5.0
## [11] GenomicAlignments_1.46.0  XML_3.99-0.20
## [13] digest_0.6.38             lifecycle_1.0.4
## [15] processx_3.8.6            KEGGREST_1.50.0
## [17] RSQLite_2.4.4             magrittr_2.0.4
## [19] compiler_4.5.2            rlang_1.1.6
## [21] sass_0.4.10               tools_4.5.2
## [23] yaml_2.3.10               rtracklayer_1.70.0
## [25] knitr_1.50                S4Arrays_1.10.0
## [27] bit_4.6.0                 curl_7.0.0
## [29] DelayedArray_0.36.0       xml2_1.5.0
## [31] websocket_1.4.4           abind_1.4-8
## [33] BiocParallel_1.44.0       withr_3.0.2
## [35] purrr_1.2.0               grid_4.5.2
## [37] ExperimentHub_3.0.0       cli_3.6.5
## [39] rmarkdown_2.30            crayon_1.5.3
## [41] otel_0.2.0                httr_1.4.7
## [43] tzdb_0.5.0                rjson_0.2.23
## [45] BiocBaseUtils_1.12.0      GenomicDataCommons_1.34.1
## [47] chromote_0.5.1            DBI_1.2.3
## [49] cachem_1.1.0              stringr_1.6.0
## [51] rvest_1.0.5               parallel_4.5.2
## [53] AnnotationDbi_1.72.0      BiocManager_1.30.27
## [55] XVector_0.50.0            restfulr_0.0.16
## [57] vctrs_0.6.5               Matrix_1.7-4
## [59] jsonlite_2.0.0            bookdown_0.45
## [61] hms_1.1.4                 bit64_4.6.0-1
## [63] GenomicFeatures_1.62.0    jquerylib_0.1.4
## [65] glue_1.8.0                ps_1.9.1
## [67] codetools_0.2-20          stringi_1.8.7
## [69] later_1.4.4               BiocVersion_3.22.0
## [71] GenomeInfoDb_1.46.0       BiocIO_1.20.0
## [73] UCSC.utils_1.6.0          tibble_3.3.0
## [75] pillar_1.11.1             rappdirs_0.3.3
## [77] htmltools_0.5.8.1         R6_2.6.1
## [79] dbplyr_2.5.1              httr2_1.2.1
## [81] evaluate_1.0.5            lattice_0.22-7
## [83] readr_2.1.6               AnnotationHub_4.0.0
## [85] cigarillo_1.0.0           png_0.1-8
## [87] Rsamtools_2.26.0          memoise_2.0.1
## [89] bslib_0.9.0               Rcpp_1.1.0
## [91] SparseArray_1.10.2        xfun_0.54
## [93] pkgconfig_2.0.3
```

# References

Ramos, Marcel, Ludwig Geistlinger, Sehyun Oh, Lucas Schiffer, Rimsha Azhar, Hanish Kodali, Ino de Bruijn, et al. 2020. “Multiomic Integration of Public Oncology Databases in Bioconductor.” *JCO Clinical Cancer Informatics* 1 (4): 958–71. <https://doi.org/10.1200/CCI.19.00119>.

Ramos, Marcel, Lucas Schiffer, Angela Re, Rimsha Azhar, Azfar Basunia, Carmen Rodriguez, Tiffany Chan, et al. 2017. “Software for the Integration of Multiomics Experiments in Bioconductor.” *Cancer Research* 77 (21): e39–e42. <https://doi.org/10.1158/0008-5472.CAN-17-0344>.