# WeberDivechaLCdata package

Lukas M. Weber1 and Heena R. Divecha2

1Johns Hopkins Bloomberg School of Public Health, Baltimore, MD, USA
2Lieber Institute for Brain Development, Baltimore, MD, USA

#### 4 November 2025

#### Package

WeberDivechaLCdata 1.12.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Installation](#installation)
  + [1.2 Contents](#contents)
* [2 Loading the data](#loading-the-data)
  + [2.1 Show data](#show-data)
* [3 Session information](#session-information)

# 1 Introduction

This package contains data from our paper on the gene expression landscape of the human locus coeruleus (LC).

The dataset consists of spatially-resolved transcriptomics (SRT) and single-nucleus RNA-sequencing (snRNA-seq) data from the LC in postmortem human brain samples. Data were generated with the 10x Genomics Visium SRT and 10x Genomics Chromium snRNA-seq platforms.

The data are provided as `SpatialExperiment` and `SingleCellExperiment` R/Bioconductor objects in this package, and in online web apps (`Shiny` and `iSEE`) for interactive exploration (see links in paper).

A preprint of the paper is available from [bioRxiv](https://www.biorxiv.org/content/10.1101/2022.10.28.514241v1).

## 1.1 Installation

The package can be installed from Bioconductor ([WeberDivechaLCdata](https://bioconductor.org/packages/WeberDivechaLCdata)) as follows:

```
install.packages("BiocManager")
BiocManager::install("WeberDivechaLCdata")
```

## 1.2 Contents

The package contains the following objects:

* `WeberDivechaLCdata_Visium`: SRT (Visium) dataset
* `WeberDivechaLCdata_singleNucleus`: snRNA-seq dataset

# 2 Loading the data

The data objects can be loaded using the dataset names as follows:

```
library(SpatialExperiment)
library(SingleCellExperiment)
library(WeberDivechaLCdata)
```

```
# Load objects using dataset names
spe <- WeberDivechaLCdata_Visium()
sce <- WeberDivechaLCdata_singleNucleus()
```

Alternatively, the data objects can be loaded by accessing the ExperimentHub
IDs:

```
library(ExperimentHub)
```

```
# create ExperimentHub instance
eh <- ExperimentHub()

# query datasets
my_files <- query(eh, "WeberDivechaLCdata")
my_files
```

```
## ExperimentHub with 2 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: NA
## # $species: Homo sapiens
## # $rdataclass: SpatialExperiment, SingleCellExperiment
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH7737"]]'
##
##            title
##   EH7737 | WeberDivechaLCdata_Visium
##   EH7738 | WeberDivechaLCdata_singleNucleus
```

```
# metadata
md <- as.data.frame(mcols(my_files))
```

```
# load data using ExperimentHub query
spe <- my_files[[1]]
sce <- my_files[[2]]
```

```
# load data using ExperimentHub IDs
# spe <- myfiles[["EHXXXX"]]
# sce <- myfiles[["EHYYYY"]]
```

## 2.1 Show data

Check that the data have been loaded:

```
# Visium data (SpatialExperiment format)
spe
```

```
## class: SpatialExperiment
## dim: 23728 20380
## metadata(0):
## assays(2): counts logcounts
## rownames(23728): ENSG00000238009 ENSG00000241860 ... ENSG00000278817
##   ENSG00000277196
## rowData names(6): source type ... gene_name gene_type
## colnames(20380): Br6522_LC_1_round1_AAACAAGTATCTCCCA-1
##   Br6522_LC_1_round1_AAACACCAATAACTGC-1 ...
##   Br8153_LC_round3_TTGTTTGTATTACACG-1
##   Br8153_LC_round3_TTGTTTGTGTAAATTC-1
## colData names(20): sample_id donor_id ... discard sizeFactor
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
## imgData names(4): sample_id image_id data scaleFactor
```

```
# dimensions
dim(spe)
```

```
## [1] 23728 20380
```

```
# assays
assayNames(spe)
```

```
## [1] "counts"    "logcounts"
```

```
# row data
rowData(spe)
```

```
## DataFrame with 23728 rows and 6 columns
##                   source     type         gene_id gene_version   gene_name
##                 <factor> <factor>     <character>  <character> <character>
## ENSG00000238009   HAVANA     gene ENSG00000238009            6  AL627309.1
## ENSG00000241860   HAVANA     gene ENSG00000241860            7  AL627309.5
## ENSG00000241599   HAVANA     gene ENSG00000241599            1  AL627309.4
## ENSG00000237491   HAVANA     gene ENSG00000237491           10   LINC01409
## ENSG00000177757   HAVANA     gene ENSG00000177757            2      FAM87B
## ...                  ...      ...             ...          ...         ...
## ENSG00000273748  ENSEMBL     gene ENSG00000273748            1  AL592183.1
## ENSG00000271254  ENSEMBL     gene ENSG00000271254            6  AC240274.1
## ENSG00000276345  ENSEMBL     gene ENSG00000276345            1  AC004556.3
## ENSG00000278817  ENSEMBL     gene ENSG00000278817            1  AC007325.4
## ENSG00000277196  ENSEMBL     gene ENSG00000277196            4  AC007325.2
##                      gene_type
##                    <character>
## ENSG00000238009         lncRNA
## ENSG00000241860         lncRNA
## ENSG00000241599         lncRNA
## ENSG00000237491         lncRNA
## ENSG00000177757         lncRNA
## ...                        ...
## ENSG00000273748 protein_coding
## ENSG00000271254 protein_coding
## ENSG00000276345 protein_coding
## ENSG00000278817 protein_coding
## ENSG00000277196 protein_coding
```

```
# column data
colData(spe)
```

```
## DataFrame with 20380 rows and 20 columns
##                                                sample_id donor_id round_id
##                                                 <factor> <factor> <factor>
## Br6522_LC_1_round1_AAACAAGTATCTCCCA-1 Br6522_LC_1_round1   Br6522   round1
## Br6522_LC_1_round1_AAACACCAATAACTGC-1 Br6522_LC_1_round1   Br6522   round1
## Br6522_LC_1_round1_AAACAGAGCGACTCCT-1 Br6522_LC_1_round1   Br6522   round1
## Br6522_LC_1_round1_AAACAGCTTTCAGAAG-1 Br6522_LC_1_round1   Br6522   round1
## Br6522_LC_1_round1_AAACATTTCCCGGATT-1 Br6522_LC_1_round1   Br6522   round1
## ...                                                  ...      ...      ...
## Br8153_LC_round3_TTGTTGGCAATGACTG-1     Br8153_LC_round3   Br8153   round3
## Br8153_LC_round3_TTGTTTCACATCCAGG-1     Br8153_LC_round3   Br8153   round3
## Br8153_LC_round3_TTGTTTCATTAGTCTA-1     Br8153_LC_round3   Br8153   round3
## Br8153_LC_round3_TTGTTTGTATTACACG-1     Br8153_LC_round3   Br8153   round3
## Br8153_LC_round3_TTGTTTGTGTAAATTC-1     Br8153_LC_round3   Br8153   round3
##                                                       key_id     part_id
##                                                  <character> <character>
## Br6522_LC_1_round1_AAACAAGTATCTCCCA-1 Br6522_LC_1_round1_A..      single
## Br6522_LC_1_round1_AAACACCAATAACTGC-1 Br6522_LC_1_round1_A..      single
## Br6522_LC_1_round1_AAACAGAGCGACTCCT-1 Br6522_LC_1_round1_A..      single
## Br6522_LC_1_round1_AAACAGCTTTCAGAAG-1 Br6522_LC_1_round1_A..      single
## Br6522_LC_1_round1_AAACATTTCCCGGATT-1 Br6522_LC_1_round1_A..      single
## ...                                                      ...         ...
## Br8153_LC_round3_TTGTTGGCAATGACTG-1   Br8153_LC_round3_TTG..       right
## Br8153_LC_round3_TTGTTTCACATCCAGG-1   Br8153_LC_round3_TTG..       right
## Br8153_LC_round3_TTGTTTCATTAGTCTA-1   Br8153_LC_round3_TTG..       right
## Br8153_LC_round3_TTGTTTGTATTACACG-1   Br8153_LC_round3_TTG..       right
## Br8153_LC_round3_TTGTTTGTGTAAATTC-1   Br8153_LC_round3_TTG..        left
##                                               sample_part_id in_tissue
##                                                  <character> <logical>
## Br6522_LC_1_round1_AAACAAGTATCTCCCA-1 Br6522_LC_1_round1_s..      TRUE
## Br6522_LC_1_round1_AAACACCAATAACTGC-1 Br6522_LC_1_round1_s..      TRUE
## Br6522_LC_1_round1_AAACAGAGCGACTCCT-1 Br6522_LC_1_round1_s..      TRUE
## Br6522_LC_1_round1_AAACAGCTTTCAGAAG-1 Br6522_LC_1_round1_s..      TRUE
## Br6522_LC_1_round1_AAACATTTCCCGGATT-1 Br6522_LC_1_round1_s..      TRUE
## ...                                                      ...       ...
## Br8153_LC_round3_TTGTTGGCAATGACTG-1   Br8153_LC_round3_right      TRUE
## Br8153_LC_round3_TTGTTTCACATCCAGG-1   Br8153_LC_round3_right      TRUE
## Br8153_LC_round3_TTGTTTCATTAGTCTA-1   Br8153_LC_round3_right      TRUE
## Br8153_LC_round3_TTGTTTGTATTACACG-1   Br8153_LC_round3_right      TRUE
## Br8153_LC_round3_TTGTTTGTGTAAATTC-1    Br8153_LC_round3_left      TRUE
##                                       array_row array_col annot_region
##                                       <integer> <integer>    <logical>
## Br6522_LC_1_round1_AAACAAGTATCTCCCA-1        50       102        FALSE
## Br6522_LC_1_round1_AAACACCAATAACTGC-1        59        19        FALSE
## Br6522_LC_1_round1_AAACAGAGCGACTCCT-1        14        94        FALSE
## Br6522_LC_1_round1_AAACAGCTTTCAGAAG-1        43         9        FALSE
## Br6522_LC_1_round1_AAACATTTCCCGGATT-1        61        97        FALSE
## ...                                         ...       ...          ...
## Br8153_LC_round3_TTGTTGGCAATGACTG-1          76        30        FALSE
## Br8153_LC_round3_TTGTTTCACATCCAGG-1          58        42        FALSE
## Br8153_LC_round3_TTGTTTCATTAGTCTA-1          60        30        FALSE
## Br8153_LC_round3_TTGTTTGTATTACACG-1          73        41        FALSE
## Br8153_LC_round3_TTGTTTGTGTAAATTC-1           7        51        FALSE
##                                       annot_spot       sum  detected
##                                        <logical> <numeric> <integer>
## Br6522_LC_1_round1_AAACAAGTATCTCCCA-1      FALSE       227       162
## Br6522_LC_1_round1_AAACACCAATAACTGC-1      FALSE      3268      1585
## Br6522_LC_1_round1_AAACAGAGCGACTCCT-1      FALSE       112        86
## Br6522_LC_1_round1_AAACAGCTTTCAGAAG-1      FALSE      8796      3524
## Br6522_LC_1_round1_AAACATTTCCCGGATT-1      FALSE       465       319
## ...                                          ...       ...       ...
## Br8153_LC_round3_TTGTTGGCAATGACTG-1        FALSE       202       141
## Br8153_LC_round3_TTGTTTCACATCCAGG-1        FALSE       610       436
## Br8153_LC_round3_TTGTTTCATTAGTCTA-1        FALSE       405       300
## Br8153_LC_round3_TTGTTTGTATTACACG-1        FALSE        36        30
## Br8153_LC_round3_TTGTTTGTGTAAATTC-1        FALSE       343       244
##                                       subsets_mito_sum subsets_mito_detected
##                                              <numeric>             <integer>
## Br6522_LC_1_round1_AAACAAGTATCTCCCA-1               40                     8
## Br6522_LC_1_round1_AAACACCAATAACTGC-1              666                    13
## Br6522_LC_1_round1_AAACAGAGCGACTCCT-1               25                    10
## Br6522_LC_1_round1_AAACAGCTTTCAGAAG-1              751                    12
## Br6522_LC_1_round1_AAACATTTCCCGGATT-1               84                    13
## ...                                                ...                   ...
## Br8153_LC_round3_TTGTTGGCAATGACTG-1                 49                     9
## Br8153_LC_round3_TTGTTTCACATCCAGG-1                107                    11
## Br8153_LC_round3_TTGTTTCATTAGTCTA-1                 86                    10
## Br8153_LC_round3_TTGTTTGTATTACACG-1                 11                     5
## Br8153_LC_round3_TTGTTTGTGTAAATTC-1                 62                    10
##                                       subsets_mito_percent low_lib_size
##                                                  <numeric>    <logical>
## Br6522_LC_1_round1_AAACAAGTATCTCCCA-1             17.62115        FALSE
## Br6522_LC_1_round1_AAACACCAATAACTGC-1             20.37944        FALSE
## Br6522_LC_1_round1_AAACAGAGCGACTCCT-1             22.32143        FALSE
## Br6522_LC_1_round1_AAACAGCTTTCAGAAG-1              8.53797        FALSE
## Br6522_LC_1_round1_AAACATTTCCCGGATT-1             18.06452        FALSE
## ...                                                    ...          ...
## Br8153_LC_round3_TTGTTGGCAATGACTG-1                24.2574        FALSE
## Br8153_LC_round3_TTGTTTCACATCCAGG-1                17.5410        FALSE
## Br8153_LC_round3_TTGTTTCATTAGTCTA-1                21.2346        FALSE
## Br8153_LC_round3_TTGTTTGTATTACACG-1                30.5556        FALSE
## Br8153_LC_round3_TTGTTTGTGTAAATTC-1                18.0758        FALSE
##                                       low_n_features   discard sizeFactor
##                                            <logical> <logical>  <numeric>
## Br6522_LC_1_round1_AAACAAGTATCTCCCA-1          FALSE     FALSE   0.222823
## Br6522_LC_1_round1_AAACACCAATAACTGC-1          FALSE     FALSE   3.207867
## Br6522_LC_1_round1_AAACAGAGCGACTCCT-1          FALSE     FALSE   0.109939
## Br6522_LC_1_round1_AAACAGCTTTCAGAAG-1          FALSE     FALSE   8.634150
## Br6522_LC_1_round1_AAACATTTCCCGGATT-1          FALSE     FALSE   0.456444
## ...                                              ...       ...        ...
## Br8153_LC_round3_TTGTTGGCAATGACTG-1            FALSE     FALSE  0.1982831
## Br8153_LC_round3_TTGTTTCACATCCAGG-1            FALSE     FALSE  0.5987757
## Br8153_LC_round3_TTGTTTCATTAGTCTA-1            FALSE     FALSE  0.3975478
## Br8153_LC_round3_TTGTTTGTATTACACG-1            FALSE     FALSE  0.0353376
## Br8153_LC_round3_TTGTTTGTGTAAATTC-1            FALSE     FALSE  0.3366886
```

```
# spatial coordinates
head(spatialCoords(spe))
```

```
##                    pxl_col_in_fullres pxl_row_in_fullres
## AAACAAGTATCTCCCA-1              21121               7033
## AAACACCAATAACTGC-1              24501              23844
## AAACAGAGCGACTCCT-1               8424               8808
## AAACAGCTTTCAGAAG-1              18873              25942
## AAACATTTCCCGGATT-1              25019               8002
## AAACCGGGTAGGTACC-1              18474              22089
```

```
# image data
imgData(spe)
```

```
## DataFrame with 16 rows and 4 columns
##              sample_id    image_id   data scaleFactor
##               <factor> <character> <list>   <numeric>
## 1   Br6522_LC_1_round1       hires   ####   0.0575473
## 2   Br6522_LC_1_round1      lowres   ####   0.0172642
## 3   Br6522_LC_2_round1       hires   ####   0.0575473
## 4   Br6522_LC_2_round1      lowres   ####   0.0172642
## 5   Br8153_LC_round2         hires   ####   0.0666422
## ...                ...         ...    ...         ...
## 12    Br8079_LC_round3      lowres   ####   0.0184434
## 13    Br2701_LC_round3       hires   ####   0.0614779
## 14    Br2701_LC_round3      lowres   ####   0.0184434
## 15    Br8153_LC_round3       hires   ####   0.0614779
## 16    Br8153_LC_round3      lowres   ####   0.0184434
```

```
# snRNA-seq data (SingleCellExperiment format)
sce
```

```
## class: SingleCellExperiment
## dim: 33352 20191
## metadata(1): Samples
## assays(2): counts logcounts
## rownames(33352): ENSG00000186092 ENSG00000238009 ... ENSG00000278817
##   ENSG00000277196
## rowData names(6): source type ... gene_name gene_type
## colnames(20191): Br6522_LC_AAACCCAAGCCATTTG-1
##   Br6522_LC_AAACGAACATCGATAC-1 ... Br2701_LC_TTTGTTGTCGCTTGCT-1
##   Br2701_LC_TTTGTTGTCTGACAGT-1
## colData names(16): Sample Barcode ... unsupervised_5HT supervised_NE
## reducedDimNames(2): PCA UMAP
## mainExpName: NULL
## altExpNames(0):
```

```
# dimensions
dim(sce)
```

```
## [1] 33352 20191
```

```
# assays
assayNames(sce)
```

```
## [1] "counts"    "logcounts"
```

```
# row data
rowData(sce)
```

```
## DataFrame with 33352 rows and 6 columns
##                   source     type         gene_id gene_version   gene_name
##                 <factor> <factor>     <character>  <character> <character>
## ENSG00000186092   HAVANA     gene ENSG00000186092            6       OR4F5
## ENSG00000238009   HAVANA     gene ENSG00000238009            6  AL627309.1
## ENSG00000239945   HAVANA     gene ENSG00000239945            1  AL627309.3
## ENSG00000239906   HAVANA     gene ENSG00000239906            1  AL627309.2
## ENSG00000241860   HAVANA     gene ENSG00000241860            7  AL627309.5
## ...                  ...      ...             ...          ...         ...
## ENSG00000273554  ENSEMBL     gene ENSG00000273554            4  AC136616.1
## ENSG00000278633  ENSEMBL     gene ENSG00000278633            1  AC023491.2
## ENSG00000276017  ENSEMBL     gene ENSG00000276017            1  AC007325.1
## ENSG00000278817  ENSEMBL     gene ENSG00000278817            1  AC007325.4
## ENSG00000277196  ENSEMBL     gene ENSG00000277196            4  AC007325.2
##                      gene_type
##                    <character>
## ENSG00000186092 protein_coding
## ENSG00000238009         lncRNA
## ENSG00000239945         lncRNA
## ENSG00000239906         lncRNA
## ENSG00000241860         lncRNA
## ...                        ...
## ENSG00000273554 protein_coding
## ENSG00000278633 protein_coding
## ENSG00000276017 protein_coding
## ENSG00000278817 protein_coding
## ENSG00000277196 protein_coding
```

```
# column data
colData(sce)
```

```
## DataFrame with 20191 rows and 16 columns
##                                   Sample            Barcode       sum  detected
##                              <character>        <character> <numeric> <integer>
## Br6522_LC_AAACCCAAGCCATTTG-1   Br6522_LC AAACCCAAGCCATTTG-1      1366       999
## Br6522_LC_AAACGAACATCGATAC-1   Br6522_LC AAACGAACATCGATAC-1     29255      6869
## Br6522_LC_AAACGCTCACACGGTC-1   Br6522_LC AAACGCTCACACGGTC-1     69772     10443
## Br6522_LC_AAACGCTCACCTATCC-1   Br6522_LC AAACGCTCACCTATCC-1       598       531
## Br6522_LC_AAACGCTGTAGATTAG-1   Br6522_LC AAACGCTGTAGATTAG-1     40503      9088
## ...                                  ...                ...       ...       ...
## Br2701_LC_TTTGTTGGTGTTTACG-1   Br2701_LC TTTGTTGGTGTTTACG-1       982       759
## Br2701_LC_TTTGTTGTCACATACG-1   Br2701_LC TTTGTTGTCACATACG-1     41730      8093
## Br2701_LC_TTTGTTGTCCGAGCTG-1   Br2701_LC TTTGTTGTCCGAGCTG-1      2452      1546
## Br2701_LC_TTTGTTGTCGCTTGCT-1   Br2701_LC TTTGTTGTCGCTTGCT-1      9090      3575
## Br2701_LC_TTTGTTGTCTGACAGT-1   Br2701_LC TTTGTTGTCTGACAGT-1      4601      2367
##                              subsets_Mito_sum subsets_Mito_detected
##                                     <numeric>             <integer>
## Br6522_LC_AAACCCAAGCCATTTG-1               79                    12
## Br6522_LC_AAACGAACATCGATAC-1              114                    11
## Br6522_LC_AAACGCTCACACGGTC-1              764                    13
## Br6522_LC_AAACGCTCACCTATCC-1               13                     6
## Br6522_LC_AAACGCTGTAGATTAG-1              349                    12
## ...                                       ...                   ...
## Br2701_LC_TTTGTTGGTGTTTACG-1               51                    11
## Br2701_LC_TTTGTTGTCACATACG-1             1657                    13
## Br2701_LC_TTTGTTGTCCGAGCTG-1               52                    11
## Br2701_LC_TTTGTTGTCGCTTGCT-1              286                    11
## Br2701_LC_TTTGTTGTCTGACAGT-1               20                     9
##                              subsets_Mito_percent   discard sizeFactor
##                                         <numeric> <logical>  <numeric>
## Br6522_LC_AAACCCAAGCCATTTG-1             5.783309     FALSE  0.1440373
## Br6522_LC_AAACGAACATCGATAC-1             0.389677     FALSE  3.0698366
## Br6522_LC_AAACGCTCACACGGTC-1             1.094995     FALSE  8.3284110
## Br6522_LC_AAACGCTCACCTATCC-1             2.173913     FALSE  0.0703227
## Br6522_LC_AAACGCTGTAGATTAG-1             0.861665     FALSE  5.0136522
## ...                                           ...       ...        ...
## Br2701_LC_TTTGTTGGTGTTTACG-1             5.193483     FALSE   0.124831
## Br2701_LC_TTTGTTGTCACATACG-1             3.970764     FALSE   4.537642
## Br2701_LC_TTTGTTGTCCGAGCTG-1             2.120718     FALSE   0.256114
## Br2701_LC_TTTGTTGTCGCTTGCT-1             3.146315     FALSE   0.918521
## Br2701_LC_TTTGTTGTCTGACAGT-1             0.434688     FALSE   0.444832
##                                                 Key    label      label_merged
##                                         <character> <factor>          <factor>
## Br6522_LC_AAACCCAAGCCATTTG-1 Br6522_LC_AAACCCAAGC..       12  oligodendrocytes
## Br6522_LC_AAACGAACATCGATAC-1 Br6522_LC_AAACGAACAT..       24  inhibitory
## Br6522_LC_AAACGCTCACACGGTC-1 Br6522_LC_AAACGCTCAC..       25  inhibitory
## Br6522_LC_AAACGCTCACCTATCC-1 Br6522_LC_AAACGCTCAC..       17  inhibitory
## Br6522_LC_AAACGCTGTAGATTAG-1 Br6522_LC_AAACGCTGTA..       25  inhibitory
## ...                                             ...      ...               ...
## Br2701_LC_TTTGTTGGTGTTTACG-1 Br2701_LC_TTTGTTGGTG..        9 oligodendrocytes
## Br2701_LC_TTTGTTGTCACATACG-1 Br2701_LC_TTTGTTGTCA..        1 neurons_ambiguous
## Br2701_LC_TTTGTTGTCCGAGCTG-1 Br2701_LC_TTTGTTGTCC..        1 neurons_ambiguous
## Br2701_LC_TTTGTTGTCGCTTGCT-1 Br2701_LC_TTTGTTGTCG..        2 neurons_ambiguous
## Br2701_LC_TTTGTTGTCTGACAGT-1 Br2701_LC_TTTGTTGTCT..        1 neurons_ambiguous
##                              label_inhibitory unsupervised_NE unsupervised_5HT
##                                     <integer>       <logical>        <logical>
## Br6522_LC_AAACCCAAGCCATTTG-1               NA           FALSE            FALSE
## Br6522_LC_AAACGAACATCGATAC-1                5           FALSE            FALSE
## Br6522_LC_AAACGCTCACACGGTC-1                2           FALSE            FALSE
## Br6522_LC_AAACGCTCACCTATCC-1                3           FALSE            FALSE
## Br6522_LC_AAACGCTGTAGATTAG-1                2           FALSE            FALSE
## ...                                       ...             ...              ...
## Br2701_LC_TTTGTTGGTGTTTACG-1               NA           FALSE            FALSE
## Br2701_LC_TTTGTTGTCACATACG-1               NA           FALSE            FALSE
## Br2701_LC_TTTGTTGTCCGAGCTG-1               NA           FALSE            FALSE
## Br2701_LC_TTTGTTGTCGCTTGCT-1               NA           FALSE            FALSE
## Br2701_LC_TTTGTTGTCTGACAGT-1               NA           FALSE            FALSE
##                              supervised_NE
##                                  <logical>
## Br6522_LC_AAACCCAAGCCATTTG-1         FALSE
## Br6522_LC_AAACGAACATCGATAC-1         FALSE
## Br6522_LC_AAACGCTCACACGGTC-1         FALSE
## Br6522_LC_AAACGCTCACCTATCC-1         FALSE
## Br6522_LC_AAACGCTGTAGATTAG-1         FALSE
## ...                                    ...
## Br2701_LC_TTTGTTGGTGTTTACG-1         FALSE
## Br2701_LC_TTTGTTGTCACATACG-1         FALSE
## Br2701_LC_TTTGTTGTCCGAGCTG-1         FALSE
## Br2701_LC_TTTGTTGTCGCTTGCT-1         FALSE
## Br2701_LC_TTTGTTGTCTGACAGT-1         FALSE
```

# 3 Session information

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
##  [1] WeberDivechaLCdata_1.12.0   ExperimentHub_3.0.0
##  [3] AnnotationHub_4.0.0         BiocFileCache_3.0.0
##  [5] dbplyr_2.5.1                SpatialExperiment_1.20.0
##  [7] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0               IRanges_2.44.0
## [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [15] generics_0.1.4              MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      rjson_0.2.23         xfun_0.54
##  [4] bslib_0.9.0          httr2_1.2.1          lattice_0.22-7
##  [7] vctrs_0.6.5          tools_4.5.1          curl_7.0.0
## [10] tibble_3.3.0         AnnotationDbi_1.72.0 RSQLite_2.4.3
## [13] blob_1.2.4           pkgconfig_2.0.3      Matrix_1.7-4
## [16] lifecycle_1.0.4      compiler_4.5.1       Biostrings_2.78.0
## [19] htmltools_0.5.8.1    sass_0.4.10          yaml_2.3.10
## [22] crayon_1.5.3         pillar_1.11.1        jquerylib_0.1.4
## [25] DelayedArray_0.36.0  cachem_1.1.0         magick_2.9.0
## [28] abind_1.4-8          tidyselect_1.2.1     digest_0.6.37
## [31] purrr_1.1.0          dplyr_1.1.4          bookdown_0.45
## [34] BiocVersion_3.22.0   fastmap_1.2.0        grid_4.5.1
## [37] cli_3.6.5            SparseArray_1.10.1   magrittr_2.0.4
## [40] S4Arrays_1.10.0      withr_3.0.2          filelock_1.0.3
## [43] rappdirs_0.3.3       bit64_4.6.0-1        rmarkdown_2.30
## [46] XVector_0.50.0       httr_1.4.7           bit_4.6.0
## [49] png_0.1-8            memoise_2.0.1        evaluate_1.0.5
## [52] knitr_1.50           rlang_1.1.6          Rcpp_1.1.0
## [55] glue_1.8.0           DBI_1.2.3            BiocManager_1.30.26
## [58] jsonlite_2.0.0       R6_2.6.1
```