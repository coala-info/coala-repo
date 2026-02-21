# RTCGAToolbox

Mehmet Kemal Samur

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Data Client](#data-client)
  + [3.1 Example Dataset](#example-dataset)
  + [3.2 Conversion to Bioconductor classes](#conversion-to-bioconductor-classes)
* [4 Raw Data](#raw-data)
  + [4.1 Session Info](#session-info)
* [References](#references)

# 1 Introduction

Managing data from large scale projects such as The Cancer Genome Atlas
(TCGA)(Cancer Genome Atlas Research Network [2008](#ref-ref1)) for further analysis is an important and time consuming step for
research projects. Several efforts, such as Firehose project, make TCGA
pre-processed data publicly available via web services and data portals but it
requires managing, downloading and preparing the data for following steps. We
developed an open source and extensible R based data client for Firehose Level
3 and Level 4 data and demonstrated its use with sample case studies.
RTCGAToolbox could improve data management for researchers who are interested
with TCGA data. In addition, it can be integrated with other analysis
pipelines for further data analysis.

RTCGAToolbox is open-source and licensed under the GNU General Public License
Version 2.0. All documentation and source code for RTCGAToolbox is freely
available. Please site the paper at (Samur MK. [2014](#ref-ref3)).

Currently, following functions are provided to access datasets and process
datasets.

* Control functions:
  + getFirehoseRunningDates: This function can be called to access valid
    stddata run dates. To access data, users have to provide valid dates.
  + getFirehoseAnalyzeDates: This function can be called to access valid
    analyze run dates. To access data, users have to provide valid dates. This
    function only affects the GISTIC2 (Mermel, C. H. and Schumacher, S. E. and Hill, B. and Meyerson, M. L. and Beroukhim, R. and Getz, G [2011](#ref-ref2)) processed copy estimate matrices.
  + getFirehoseDatasets: This function can be called to access valid dataset
    aliases.
* Data client function:
  + getFirehoseData: This is the core function of the package. Users can
    access Firehose processed data via this function. Once it is called, several
    steps are realized by the library to access data. Finally this function
    returns an S4 object that keeps all the downloaded data.

# 2 Installation

To install RTCGAToolbox, you can use Bioconductor. Source code is also
available on GitHub. First time users use the following code snippet to
install the package

```
if (!requireNamespace("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("RTCGAToolbox")
```

# 3 Data Client

Before getting the data from Firehose pipelines, users have to check valid
dataset aliases, stddata run dates and analyze run dates. To provide valid
information RTCGAToolbox comes with three control functions. Users can list
datasets with “getFirehoseDatasets” function. In addition, users have to
provide stddata run date or/and analyze run date for client function. Valid
dates are accessible via “getFirehoseRunningDates” and
“getFirehoseAnalyzeDates” functions. Below code chunk shows how to list
datasets and dates.

```
library(RTCGAToolbox)
# Valid aliases
getFirehoseDatasets()
```

```
##  [1] "ACC"      "BLCA"     "BRCA"     "CESC"     "CHOL"     "COADREAD"
##  [7] "COAD"     "DLBC"     "ESCA"     "FPPP"     "GBMLGG"   "GBM"
## [13] "HNSC"     "KICH"     "KIPAN"    "KIRC"     "KIRP"     "LAML"
## [19] "LGG"      "LIHC"     "LUAD"     "LUSC"     "MESO"     "OV"
## [25] "PAAD"     "PCPG"     "PRAD"     "READ"     "SARC"     "SKCM"
## [31] "STAD"     "STES"     "TGCT"     "THCA"     "THYM"     "UCEC"
## [37] "UCS"      "UVM"
```

```
# Valid stddata runs
getFirehoseRunningDates(last = 3)
```

```
## [1] "20160128" "20151101" "20150821"
```

```
# Valid analysis running dates (will return 3 recent date)
getFirehoseAnalyzeDates(last=3)
```

```
## [1] "20160128" "20150821" "20150402"
```

When the dates and datasets are determined users can call data client function
(“getFirehoseData”) to access data. Current version can download multiple data
types except ISOFORM and exon level data due to their huge data size. Below
code chunk will download READ dataset with clinical and mutation data.

```
# READ mutation data and clinical data
brcaData <- getFirehoseData(dataset="READ", runDate="20160128",
    forceDownload=TRUE, clinical=TRUE, Mutation=TRUE)
```

Printing the object will show the user what datasets are in the `FirehoseData`
object:

```
brcaData
```

```
## READ FirehoseData objectStandard run date: 20160128
## Analysis running date: NA
## Available data types:
##   clinical: A data frame of phenotype data, dim:  171 x 19
##   Mutation: A data.frame, dim:  22075 x 39
## To export data, use the 'getData' function.
```

Users have to set several parameters to get data they need. Below
“getFirehoseData” options has been explained:

* dataset: Users should set cohort code for the dataset they would like to
  download. List can be accessiable via `getFirehoseDatasets()` like as explained
  above.
* runDate: Firehose project provides different data point for cohorts. Users
  can list dates by using function above,`getFirehoseRunningDates()`.
* gistic2Date: Just like cohorts Firehose project runs their analysis
  pipelines to process copy number data with GISTIC2 (Mermel, C. H. and Schumacher, S. E. and Hill, B. and Meyerson, M. L. and Beroukhim, R. and Getz, G [2011](#ref-ref2)). Users who want to
  get GISTIC2 processed copy number data should set this date. List can be
  accessible via “getFirehoseAnalyzeDates()”

Following logic keys are provided for different data types. By default client
only download clinical data.

* RNAseqGene
* clinical
* RNASeqGene
* RNASeq2Gene
* RNASeq2GeneNorm
* miRNASeqGene
* CNASNP
* CNVSNP
* CNASeq
* CNACGH
* Methylation
* Mutation
* mRNAArray
* miRNAArray
* RPPAArray

Users can also set following parameters to set client behavior.

* forceDownload: By default RTCGAToolbox checks your working directory before
  download data. If you have data in the working directory from previous run it
  loads data by using these exports. If you would like to suppress this and re
  download data you can force RTCGAToolbox.
* fileSizeLimit: If you would like to set a limit for downloaded file size you
  can use this parameter. Huge data files require longer download time and
  memory to load. By default his parameter set as 500MB.
* getUUIDs: Firehose provides TCGA barcodes for every sample. In some cases
  users may want to use UUIDs for samples. If this parameter set, then after
  processing data RTCGAToolbox gets UUIDs for each barcode.

## 3.1 Example Dataset

We’ve provided an abbreviated dataset from the ‘ACC’ (Adrenocortical carcinoma)
that contains only the top 6 rows for each dataset and a full clinical dataset.
This dataset can be invoked by doing:

```
data(accmini)
accmini
```

```
## ACC FirehoseData objectStandard run date: 20160128
## Analysis running date: 20160128
## Available data types:
##   clinical: A data frame of phenotype data, dim:  92 x 18
##   RNASeq2Gene: A matrix of count or scaled estimate data, dim:  6 x 79
##   RNASeq2GeneNorm: A list of FirehosemRNAArray object(s), length:  1
##   miRNASeqGene: A matrix, dim:  6 x 80
##   CNASNP: A data.frame, dim:  6 x 6
##   CNVSNP: A data.frame, dim:  6 x 6
##   Methylation: A list of FirehoseMethylationArray object(s), length:  1
##   RPPAArray: A list of FirehosemRNAArray object(s), length:  1
##   GISTIC: A FirehoseGISTIC for copy number data
##   Mutation: A data.frame, dim:  6 x 52
## To export data, use the 'getData' function.
```

* `accmini` data is a FirehoseData object that stores RNAseq, copy number,
  mutation, clinical data from the Adrenocortical Carcinoma (ACC) study.

## 3.2 Conversion to Bioconductor classes

The `biocExtract` function allows the user to take any downloaded dataset and
convert it into a standard Bioconductor object. These can either be a
`SummarizedExperiment`, `RangedSummarizedExperiment`, or `RaggedExperiment`
based on features of the data. The user must provide the desired data type
as input to the function along with the actual `FirehoseData` data object.
This allows for easy adaptability to other software in the Bioconductor
ecosystem.

```
biocExtract(accmini, "RNASeq2Gene")
```

```
## working on: RNASeq2Gene
```

```
## class: SummarizedExperiment
## dim: 6 79
## metadata(0):
## assays(1): ''
## rownames(6): A1BG A1CF ... A2ML1 A2M
## rowData names(0):
## colnames(79): TCGA-OR-A5J1-01A-11R-A29S-07 TCGA-OR-A5J2-01A-11R-A29S-07
##   ... TCGA-PK-A5HA-01A-11R-A29S-07 TCGA-PK-A5HB-01A-11R-A29S-07
## colData names(0):
```

```
biocExtract(accmini, "CNASNP")
```

```
## working on: CNASNP
```

```
## class: RangedSummarizedExperiment
## dim: 6 1
## metadata(0):
## assays(2): Num_Probes Segment_Mean
## rownames: NULL
## rowData names(0):
## colnames(1): TCGA-OR-A5J1-10A-01D-A29K-01
## colData names(0):
```

# 4 Raw Data

You can obtain the downloaded data in tabular or list format from the
`FirehoseData` object by using ‘getData()’ function.

```
head(getData(accmini, "clinical"))
```

```
##              Composite Element REF years_to_birth vital_status days_to_death
## tcga.or.a5k0                 value             69            0          <NA>
## tcga.or.a5kp                 value             45            0          <NA>
## tcga.or.a5l5                 value             77            0          <NA>
## tcga.or.a5lb                 value             59            1          1204
## tcga.p6.a5og                 value             45            1           383
## tcga.pk.a5hb                 value             63            0          <NA>
##              days_to_last_followup tumor_tissue_site pathologic_stage
## tcga.or.a5k0                  1029           adrenal         stage ii
## tcga.or.a5kp                  2777           adrenal         stage ii
## tcga.or.a5l5                  1317           adrenal          stage i
## tcga.or.a5lb                  <NA>           adrenal         stage iv
## tcga.p6.a5og                  <NA>           adrenal         stage iv
## tcga.pk.a5hb                  1293           adrenal             <NA>
##              pathology_T_stage pathology_N_stage pathology_M_stage gender
## tcga.or.a5k0                t2                n0              <NA> female
## tcga.or.a5kp                t2                n0              <NA> female
## tcga.or.a5l5                t1                n0              <NA> female
## tcga.or.a5lb                t4                n0              <NA>   male
## tcga.p6.a5og                t4                n0              <NA> female
## tcga.pk.a5hb              <NA>              <NA>              <NA>   male
##              date_of_initial_pathologic_diagnosis radiation_therapy
## tcga.or.a5k0                                 2009                no
## tcga.or.a5kp                                 2006                no
## tcga.or.a5l5                                 2010                no
## tcga.or.a5lb                                 2006               yes
## tcga.p6.a5og                                 2011                no
## tcga.pk.a5hb                                 2003               yes
##                                 histological_type residual_tumor
## tcga.or.a5k0 adrenocortical carcinoma- usual type             r0
## tcga.or.a5kp adrenocortical carcinoma- usual type             r0
## tcga.or.a5l5 adrenocortical carcinoma- usual type             r0
## tcga.or.a5lb adrenocortical carcinoma- usual type             r0
## tcga.p6.a5og adrenocortical carcinoma- usual type             r2
## tcga.pk.a5hb adrenocortical carcinoma- usual type           <NA>
##              number_of_lymph_nodes  race              ethnicity
## tcga.or.a5k0                  <NA> white                   <NA>
## tcga.or.a5kp                     0 white not hispanic or latino
## tcga.or.a5l5                  <NA> white not hispanic or latino
## tcga.or.a5lb                  <NA> white not hispanic or latino
## tcga.p6.a5og                     0 white not hispanic or latino
## tcga.pk.a5hb                  <NA>  <NA>                   <NA>
```

```
getData(accmini, "RNASeq2GeneNorm")
```

```
## [[1]]
```

```
## gdac.broadinstitute.org_ACC.Merge_rnaseqv2__illuminahiseq_rnaseqv2__unc_edu__Level_3__RSEM_genes_normalized__data.Level_3.2016012800.0.0.tar.gz
```

```
## FirehoseCGHArray object, dim: 6  79
```

```
getData(accmini, "GISTIC", "AllByGene")
```

```
##   Gene.Symbol Locus.ID Cytoband TCGA.OR.A5J1.01A.11D.A29H.01
## 1       ACAP3   116983  1p36.33                        0.030
## 2      ACTRT2   140625  1p36.32                        0.030
## 3        AGRN   375790  1p36.33                        0.030
## 4     ANKRD65   441869  1p36.33                        0.030
## 5      ATAD3A    55210  1p36.33                        0.030
## 6      ATAD3B    83858  1p36.33                        0.030
##   TCGA.OR.A5J2.01A.11D.A29H.01 TCGA.OR.A5J3.01A.11D.A29H.01
## 1                       -0.070                       -0.065
## 2                       -0.070                       -0.065
## 3                       -0.070                       -0.065
## 4                       -0.070                       -0.065
## 5                       -0.070                       -0.065
## 6                       -0.070                       -0.065
##   TCGA.OR.A5J4.01A.11D.A29H.01 TCGA.OR.A5J5.01A.11D.A29H.01
## 1                        0.753                       -0.029
## 2                        0.753                       -0.029
## 3                        0.753                       -0.029
## 4                        0.753                       -0.029
## 5                        0.753                       -0.029
## 6                        0.753                       -0.029
##   TCGA.OR.A5J6.01A.31D.A29H.01 TCGA.OR.A5J7.01A.11D.A29H.01
## 1                       -0.010                       -0.339
## 2                       -0.010                       -0.339
## 3                       -0.010                       -0.339
## 4                       -0.010                       -0.339
## 5                       -0.010                       -0.339
## 6                       -0.010                       -0.339
##   TCGA.OR.A5J8.01A.11D.A29H.01 TCGA.OR.A5J9.01A.11D.A29H.01
## 1                       -0.007                       -0.915
## 2                       -0.007                       -0.915
## 3                       -0.007                       -0.915
## 4                       -0.007                       -0.915
## 5                       -0.007                       -0.915
## 6                       -0.007                       -0.915
##   TCGA.OR.A5JA.01A.11D.A29H.01 TCGA.OR.A5JB.01A.11D.A29H.01
## 1                        0.000                        0.635
## 2                        0.000                        0.635
## 3                        0.000                        0.635
## 4                        0.000                        0.635
## 5                        0.000                        0.635
## 6                        0.000                        0.635
##   TCGA.OR.A5JC.01A.11D.A29H.01 TCGA.OR.A5JD.01A.11D.A29H.01
## 1                       -0.244                       -0.772
## 2                       -0.244                       -0.772
## 3                       -0.244                       -0.772
## 4                       -0.244                       -0.772
## 5                       -0.244                       -0.772
## 6                       -0.244                       -0.772
##   TCGA.OR.A5JE.01A.11D.A29H.01 TCGA.OR.A5JF.01A.11D.A29H.01
## 1                       -0.554                       -0.024
## 2                       -0.554                       -0.024
## 3                       -0.554                       -0.024
## 4                       -0.554                       -0.024
## 5                       -0.554                       -0.024
## 6                       -0.554                       -0.024
##   TCGA.OR.A5JG.01A.11D.A29H.01 TCGA.OR.A5JH.01A.11D.A309.01
## 1                       -0.058                       -0.237
## 2                       -0.058                       -0.237
## 3                       -0.058                       -0.237
## 4                       -0.058                       -0.237
## 5                       -0.058                       -0.237
## 6                       -0.058                       -0.237
##   TCGA.OR.A5JI.01A.11D.A29H.01 TCGA.OR.A5JJ.01A.11D.A29H.01
## 1                       -0.421                       -0.124
## 2                       -0.421                       -0.124
## 3                       -0.421                       -0.124
## 4                       -0.421                       -0.124
## 5                       -0.421                       -0.124
## 6                       -0.421                       -0.124
##   TCGA.OR.A5JK.01A.11D.A29H.01 TCGA.OR.A5JL.01A.11D.A29H.01
## 1                       -0.355                       -0.073
## 2                       -0.355                       -0.073
## 3                       -0.355                       -0.073
## 4                       -0.355                       -0.073
## 5                       -0.355                       -0.073
## 6                       -0.355                       -0.073
##   TCGA.OR.A5JM.01A.11D.A29H.01 TCGA.OR.A5JO.01A.11D.A29H.01
## 1                       -0.560                        0.001
## 2                       -0.560                        0.001
## 3                       -0.560                        0.001
## 4                       -0.560                        0.001
## 5                       -0.560                        0.001
## 6                       -0.560                        0.001
##   TCGA.OR.A5JP.01A.11D.A29H.01 TCGA.OR.A5JQ.01A.11D.A29H.01
## 1                       -0.573                       -0.388
## 2                       -0.573                       -0.388
## 3                       -0.573                       -0.388
## 4                       -0.573                       -0.388
## 5                       -0.573                       -0.388
## 6                       -0.573                       -0.388
##   TCGA.OR.A5JR.01A.11D.A29H.01 TCGA.OR.A5JS.01A.11D.A29H.01
## 1                        0.071                       -0.858
## 2                        0.071                       -0.858
## 3                        0.071                       -0.858
## 4                        0.071                       -0.858
## 5                        0.071                       -0.858
## 6                        0.071                       -0.858
##   TCGA.OR.A5JT.01A.11D.A29H.01 TCGA.OR.A5JU.01A.11D.A309.01
## 1                        0.043                       -0.053
## 2                        0.043                       -0.053
## 3                        0.043                       -0.053
## 4                        0.043                       -0.053
## 5                        0.043                       -0.053
## 6                        0.043                       -0.053
##   TCGA.OR.A5JV.01A.11D.A29H.01 TCGA.OR.A5JW.01A.11D.A29H.01
## 1                       -0.602                       -0.802
## 2                       -0.602                       -0.802
## 3                       -0.602                       -0.802
## 4                       -0.602                       -0.802
## 5                       -0.602                       -0.802
## 6                       -0.602                       -0.802
##   TCGA.OR.A5JX.01A.11D.A29H.01 TCGA.OR.A5JY.01A.31D.A29H.01
## 1                       -0.581                       -0.334
## 2                       -0.581                       -0.334
## 3                       -0.581                       -0.334
## 4                       -0.581                       -0.334
## 5                       -0.581                       -0.334
## 6                       -0.581                       -0.334
##   TCGA.OR.A5JZ.01A.11D.A29H.01 TCGA.OR.A5K0.01A.11D.A29H.01
## 1                       -0.031                       -0.046
## 2                       -0.031                       -0.046
## 3                       -0.031                       -0.046
## 4                       -0.031                       -0.046
## 5                       -0.031                       -0.046
## 6                       -0.031                       -0.046
##   TCGA.OR.A5K1.01A.11D.A29H.01 TCGA.OR.A5K2.01A.11D.A29H.01
## 1                        0.000                       -0.610
## 2                        0.000                       -0.610
## 3                        0.000                       -0.610
## 4                        0.000                       -0.610
## 5                        0.000                       -0.610
## 6                        0.000                       -0.610
##   TCGA.OR.A5K3.01A.11D.A29H.01 TCGA.OR.A5K4.01A.11D.A29H.01
## 1                       -0.075                        0.018
## 2                       -0.075                        0.018
## 3                       -0.075                        0.018
## 4                       -0.075                        0.018
## 5                       -0.075                        0.018
## 6                       -0.075                        0.018
##   TCGA.OR.A5K5.01A.11D.A29H.01 TCGA.OR.A5K6.01A.11D.A29H.01
## 1                       -0.610                       -0.926
## 2                       -0.610                       -0.926
## 3                       -0.610                       -0.926
## 4                       -0.610                       -0.926
## 5                       -0.610                       -0.926
## 6                       -0.610                       -0.926
##   TCGA.OR.A5K8.01A.11D.A29H.01 TCGA.OR.A5K9.01A.11D.A29H.01
## 1                       -0.019                       -0.579
## 2                       -0.019                       -0.579
## 3                       -0.019                       -0.579
## 4                       -0.019                       -0.579
## 5                       -0.019                       -0.579
## 6                       -0.019                       -0.579
##   TCGA.OR.A5KB.01A.11D.A309.01 TCGA.OR.A5KO.01A.11D.A29H.01
## 1                        0.514                       -0.034
## 2                        0.514                       -0.034
## 3                        0.514                       -0.034
## 4                        0.514                       -0.034
## 5                        0.514                       -0.034
## 6                        0.514                       -0.034
##   TCGA.OR.A5KP.01A.11D.A309.01 TCGA.OR.A5KQ.01A.11D.A309.01
## 1                       -0.031                        0.013
## 2                       -0.031                        0.013
## 3                       -0.031                        0.013
## 4                       -0.031                        0.013
## 5                       -0.031                        0.013
## 6                       -0.031                        0.013
##   TCGA.OR.A5KS.01A.11D.A309.01 TCGA.OR.A5KT.01A.11D.A29H.01
## 1                       -0.069                        0.029
## 2                       -0.069                        0.029
## 3                       -0.069                        0.029
## 4                       -0.069                        0.029
## 5                       -0.069                        0.029
## 6                       -0.069                        0.029
##   TCGA.OR.A5KU.01A.11D.A29H.01 TCGA.OR.A5KV.01A.11D.A29H.01
## 1                       -0.038                       -0.001
## 2                       -0.038                       -0.001
## 3                       -0.038                       -0.001
## 4                       -0.038                       -0.001
## 5                       -0.038                       -0.001
## 6                       -0.038                       -0.001
##   TCGA.OR.A5KW.01A.11D.A29H.01 TCGA.OR.A5KX.01A.11D.A29H.01
## 1                       -0.015                       -0.449
## 2                       -0.015                       -0.449
## 3                       -0.015                       -0.449
## 4                       -0.015                       -0.449
## 5                       -0.015                       -0.449
## 6                       -0.015                       -0.449
##   TCGA.OR.A5KY.01A.11D.A29H.01 TCGA.OR.A5KZ.01A.11D.A29H.01
## 1                       -0.009                       -0.101
## 2                       -0.009                       -0.101
## 3                       -0.009                       -0.101
## 4                       -0.009                       -0.101
## 5                       -0.009                       -0.101
## 6                       -0.009                       -0.101
##   TCGA.OR.A5L1.01A.11D.A309.01 TCGA.OR.A5L2.01A.11D.A309.01
## 1                       -0.062                       -0.277
## 2                       -0.062                       -0.277
## 3                       -0.062                       -0.277
## 4                       -0.062                       -0.277
## 5                       -0.062                       -0.277
## 6                       -0.062                       -0.277
##   TCGA.OR.A5L3.01A.11D.A29H.01 TCGA.OR.A5L4.01A.11D.A29H.01
## 1                        0.074                       -0.014
## 2                        0.074                       -0.014
## 3                        0.074                       -0.014
## 4                        0.074                       -0.014
## 5                        0.074                       -0.014
## 6                        0.074                       -0.014
##   TCGA.OR.A5L5.01A.11D.A29H.01 TCGA.OR.A5L6.01A.11D.A29H.01
## 1                        0.000                       -0.476
## 2                        0.000                       -0.476
## 3                        0.000                       -0.476
## 4                        0.000                       -0.476
## 5                        0.000                       -0.476
## 6                        0.000                       -0.476
##   TCGA.OR.A5L8.01A.11D.A29H.01 TCGA.OR.A5L9.01A.11D.A29H.01
## 1                       -0.028                       -0.002
## 2                       -0.028                       -0.002
## 3                       -0.028                       -0.002
## 4                       -0.028                       -0.002
## 5                       -0.028                       -0.002
## 6                       -0.028                       -0.002
##   TCGA.OR.A5LA.01A.11D.A29H.01 TCGA.OR.A5LB.01A.11D.A29H.01
## 1                       -0.001                       -0.068
## 2                       -0.001                       -0.068
## 3                       -0.001                       -0.068
## 4                       -0.001                       -0.068
## 5                       -0.001                       -0.068
## 6                       -0.001                       -0.068
##   TCGA.OR.A5LC.01A.11D.A29H.01 TCGA.OR.A5LD.01A.11D.A29H.01
## 1                       -0.829                       -0.001
## 2                       -0.829                       -0.001
## 3                       -0.829                       -0.001
## 4                       -0.829                       -0.001
## 5                       -0.829                       -0.001
## 6                       -0.829                       -0.001
##   TCGA.OR.A5LE.01A.11D.A29H.01 TCGA.OR.A5LF.01A.11D.A309.01
## 1                        0.041                        0.109
## 2                        0.041                        0.109
## 3                        0.041                        0.109
## 4                        0.041                        0.109
## 5                        0.041                        0.109
## 6                        0.041                        0.109
##   TCGA.OR.A5LG.01A.11D.A29H.01 TCGA.OR.A5LH.01A.11D.A29H.01
## 1                       -0.847                        0.032
## 2                       -0.847                        0.032
## 3                       -0.847                        0.032
## 4                       -0.847                        0.032
## 5                       -0.847                        0.032
## 6                       -0.847                        0.032
##   TCGA.OR.A5LI.01A.11D.A309.01 TCGA.OR.A5LJ.01A.11D.A29H.01
## 1                       -0.884                       -0.014
## 2                       -0.884                       -0.014
## 3                       -0.884                       -0.014
## 4                       -0.884                       -0.014
## 5                       -0.884                       -0.014
## 6                       -0.884                       -0.014
##   TCGA.OR.A5LK.01A.11D.A29H.01 TCGA.OR.A5LL.01A.11D.A29H.01
## 1                        0.031                       -0.011
## 2                        0.031                       -0.011
## 3                        0.031                       -0.011
## 4                        0.031                       -0.011
## 5                        0.031                       -0.011
## 6                        0.031                       -0.011
##   TCGA.OR.A5LM.01A.11D.A29H.01 TCGA.OR.A5LN.01A.11D.A29H.01
## 1                       -0.440                       -0.563
## 2                       -0.440                       -0.563
## 3                       -0.440                       -0.563
## 4                       -0.440                       -0.563
## 5                       -0.440                       -0.563
## 6                       -0.440                       -0.563
##   TCGA.OR.A5LO.01A.11D.A29H.01 TCGA.OR.A5LP.01A.11D.A29H.01
## 1                        0.004                       -0.002
## 2                        0.004                       -0.002
## 3                        0.004                       -0.002
## 4                        0.004                       -0.002
## 5                        0.004                       -0.002
## 6                        0.004                       -0.002
##   TCGA.OR.A5LR.01A.11D.A29H.01 TCGA.OR.A5LS.01A.11D.A29H.01
## 1                       -0.001                       -0.523
## 2                       -0.001                       -0.523
## 3                       -0.001                       -0.523
## 4                       -0.001                       -0.523
## 5                       -0.001                       -0.523
## 6                       -0.001                       -0.523
##   TCGA.OR.A5LT.01A.11D.A29H.01 TCGA.OU.A5PI.01A.12D.A29H.01
## 1                       -0.168                       -0.545
## 2                       -0.168                       -0.545
## 3                       -0.168                       -0.545
## 4                       -0.168                       -0.545
## 5                       -0.168                       -0.545
## 6                       -0.168                       -0.545
##   TCGA.P6.A5OG.01A.22D.A29H.01 TCGA.P6.A5OH.01A.11D.A309.01
## 1                        0.221                       -1.057
## 2                        0.221                       -1.057
## 3                        0.221                       -1.057
## 4                        0.221                       -1.057
## 5                        0.221                       -1.057
## 6                        0.221                       -1.057
##   TCGA.PA.A5YG.01A.11D.A29H.01 TCGA.PK.A5H9.01A.11D.A29H.01
## 1                       -0.009                        0.012
## 2                       -0.009                        0.012
## 3                       -0.009                        0.012
## 4                       -0.009                        0.012
## 5                       -0.009                        0.012
## 6                       -0.009                        0.012
##   TCGA.PK.A5HA.01A.11D.A29H.01 TCGA.PK.A5HB.01A.11D.A29H.01
## 1                       -0.812                       -0.056
## 2                       -0.812                       -0.056
## 3                       -0.812                       -0.056
## 4                       -0.812                       -0.056
## 5                       -0.812                       -0.056
## 6                       -0.812                       -0.056
##   TCGA.PK.A5HC.01A.11D.A309.01
## 1                        0.534
## 2                        0.534
## 3                        0.534
## 4                        0.534
## 5                        0.534
## 6                        0.534
```

## 4.1 Session Info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] RTCGAToolbox_2.40.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] tidyselect_1.2.1            dplyr_1.1.4
##   [3] blob_1.2.4                  Biostrings_2.78.0
##   [5] bitops_1.0-9                RaggedExperiment_1.34.0
##   [7] fastmap_1.2.0               RCurl_1.98-1.17
##   [9] GenomicAlignments_1.46.0    promises_1.4.0
##  [11] XML_3.99-0.19               digest_0.6.37
##  [13] lifecycle_1.0.4             processx_3.8.6
##  [15] KEGGREST_1.50.0             RSQLite_2.4.3
##  [17] magrittr_2.0.4              compiler_4.5.1
##  [19] rlang_1.1.6                 sass_0.4.10
##  [21] tools_4.5.1                 yaml_2.3.10
##  [23] data.table_1.17.8           rtracklayer_1.70.0
##  [25] knitr_1.50                  S4Arrays_1.10.0
##  [27] bit_4.6.0                   curl_7.0.0
##  [29] DelayedArray_0.36.0         xml2_1.4.1
##  [31] BiocParallel_1.44.0         abind_1.4-8
##  [33] websocket_1.4.4             BiocGenerics_0.56.0
##  [35] grid_4.5.1                  stats4_4.5.1
##  [37] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
##  [39] cli_3.6.5                   rmarkdown_2.30
##  [41] crayon_1.5.3                generics_0.1.4
##  [43] otel_0.2.0                  rjson_0.2.23
##  [45] httr_1.4.7                  tzdb_0.5.0
##  [47] BiocBaseUtils_1.12.0        GenomicDataCommons_1.34.0
##  [49] DBI_1.2.3                   cachem_1.1.0
##  [51] chromote_0.5.1              stringr_1.5.2
##  [53] parallel_4.5.1              rvest_1.0.5
##  [55] AnnotationDbi_1.72.0        restfulr_0.0.16
##  [57] BiocManager_1.30.26         XVector_0.50.0
##  [59] matrixStats_1.5.0           vctrs_0.6.5
##  [61] Matrix_1.7-4                jsonlite_2.0.0
##  [63] bookdown_0.45               IRanges_2.44.0
##  [65] hms_1.1.4                   S4Vectors_0.48.0
##  [67] bit64_4.6.0-1               GenomicFeatures_1.62.0
##  [69] jquerylib_0.1.4             glue_1.8.0
##  [71] codetools_0.2-20            RJSONIO_2.0.0
##  [73] ps_1.9.1                    stringi_1.8.7
##  [75] later_1.4.4                 GenomeInfoDb_1.46.0
##  [77] BiocIO_1.20.0               GenomicRanges_1.62.0
##  [79] UCSC.utils_1.6.0            tibble_3.3.0
##  [81] pillar_1.11.1               rappdirs_0.3.3
##  [83] htmltools_0.5.8.1           Seqinfo_1.0.0
##  [85] R6_2.6.1                    evaluate_1.0.5
##  [87] lattice_0.22-7              Biobase_2.70.0
##  [89] readr_2.1.5                 cigarillo_1.0.0
##  [91] Rsamtools_2.26.0            png_0.1-8
##  [93] memoise_2.0.1               bslib_0.9.0
##  [95] Rcpp_1.1.0                  SparseArray_1.10.0
##  [97] xfun_0.53                   MatrixGenerics_1.22.0
##  [99] TCGAutils_1.30.0            pkgconfig_2.0.3
```

# References

Cancer Genome Atlas Research Network. 2008. “Comprehensive Genomic Characterization Defines Human Glioblastoma Genes and Core Pathways.”

Mermel, C. H. and Schumacher, S. E. and Hill, B. and Meyerson, M. L. and Beroukhim, R. and Getz, G. 2011. “GISTIC2.0 Facilitates Sensitive and Confident Localization of the Targets of Focal Somatic Copy-Number Alteration in Human Cancers.”

Samur MK. 2014. “RTCGAToolbox: A New Tool for Exporting TCGA Firehose Data.”