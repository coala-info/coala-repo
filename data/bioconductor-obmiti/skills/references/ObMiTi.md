# Using ObMiTi

#### Omar Elashkar

#### 2025-11-04

# ObMiTi

A MusMus Dataset of Ob/ob and WT mice on different diets.

# Overview

In this document, we introduce the purpose of `ObMiTi` package, its contents and its potential use cases. This package is a dataset of RNA-seq samples. The samples are of 6 ob/ob mice and 6 wild type mice divided further into High fat diet and normal diet. From each mice 7 tissues has been analyzed. The duration of dieting was 20 weeks.

The package document the data collection, pre-processing and processing. In addition to the documentation the package contains the scripts that were used to generate the data object from the processed data. This data is deposited as `RangedSummarizedExperiment` object and can be accessed through `ExperimentHub`.

# Introduction

## What is `ObMiTi`?

It is an R package for documenting and distributing a dataset. The package doesn’t contain any R functions.

## What is contained in `ObMiTi`?

The package contains two different things:

1. Scripts for documenting/reproducing the data in `inst/scripts`
2. Access to the final `RangedSummarizedExperiment` through `ExperimentHub`.

## What is `ObMiTi` for?

The `RangedSummarizedExperiment` object contains the `counts`, `colData`, `rowRanges` and `metadata` which can be used for the purposes of differential gene expression and get set enrichment analysis.

# Installation

The `ObMiTi` package can be installed from Bioconductor using `BiocManager`.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ObMiTi")
```

# Generating `ObMiTi`

## 1. RNA-Seq Analysis

RNA-seq analysis of wild type, and ob/ob mice at 25 weeks of age (n = 3 mice per group) . The sequencing library was constructed using Illumina’s TruSeq RNA Prep kit (Illumina Inc., San Diego, CA, USA), and data generation was performed using the NextSeq 500 platform (Illumina Inc.) following the manufacturer’s protocol.

## 2. Quality Control

* Program: Trimmomatic (0.36)
* Input: `*.fastq.gz`
* Options: PE ILLUMINACLIP:TruSeq3-PE.fa:2:30:10

## 3. Aligning reads

* Program: `HISAT2` (2.0.5)
* Input: `*.fastq.gz` and `GRCm38` bowtie2 index for the mouse genome
* Output: `\*.
* Options: defaults

## 4. Counting

* Program: `FeatureCount
* Input: `*.bam`
* Output: `MouseRNA-seq.txt`
* Options: defaults

## Processing

The aim of this step is to construct a self-contained object with minimal manipulations of the pre-processed data followed by a simple exploration of the data in the next section.

### Making a summarized experiment object `ob_counts`

The required steps to make this object from the pre-processed data are documented in the script and are supposed to be fully reproducible when run through this package. The output is a `RangedSummarizedExperiment` object containing the peak counts and the phenotype and features data and metadata.

The `RangedSummarizedExperiment` contains \* The gene counts matrix `counts` \* The phenotype data `colData`. The column `name` links samples with the counts columns. \* The feature data `rowRanges` \* The metadata `metadata` which contain a `data.frame` of extra details about the sample collected and phenotype.

## Exploring the `ob_counts` object

In this section, we conduct a simple exploration of the data objects to show the content of the package and how they can be loaded and used.

```
# loading required libraries
library(ExperimentHub)
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: AnnotationHub
#> Loading required package: BiocFileCache
#> Loading required package: dbplyr
library(SummarizedExperiment)
#> Loading required package: MatrixGenerics
#> Loading required package: matrixStats
#>
#> Attaching package: 'MatrixGenerics'
#> The following objects are masked from 'package:matrixStats':
#>
#>     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
#>     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
#>     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
#>     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
#>     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
#>     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
#>     colWeightedMeans, colWeightedMedians, colWeightedSds,
#>     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
#>     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
#>     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
#>     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
#>     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
#>     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
#>     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
#>     rowWeightedSds, rowWeightedVars
#> Loading required package: GenomicRanges
#> Loading required package: stats4
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: Seqinfo
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#>
#> Attaching package: 'Biobase'
#> The following object is masked from 'package:MatrixGenerics':
#>
#>     rowMedians
#> The following objects are masked from 'package:matrixStats':
#>
#>     anyMissing, rowMedians
#> The following object is masked from 'package:ExperimentHub':
#>
#>     cache
#> The following object is masked from 'package:AnnotationHub':
#>
#>     cache
```

```
# query package resources on ExperimentHub
eh <- ExperimentHub()
query(eh, "ObMiTi")
#> ExperimentHub with 1 record
#> # snapshotDate(): 2025-10-29
#> # names(): EH5442
#> # package(): ObMiTi
#> # $dataprovider: Gyeongsang National University
#> # $species: Mus musculus
#> # $rdataclass: SummarizedExperiment
#> # $rdatadateadded: 2021-03-30
#> # $title: Ob/ob and WT mice transcriptome sequencing
#> # $description: Leptin deficient mice is an appealing model for studying of ...
#> # $taxonomyid: 10090
#> # $genome: mm10
#> # $sourcetype: GSEMatrix
#> # $sourceurl: https://github.com/OmarAshkar/ObMiTi
#> # $sourcesize: NA
#> # $tags: c("GEO", "RNASeqData")
#> # retrieve record with 'object[["EH5442"]]'

# load data from ExperimentHub
ob_counts <- query(eh, "ObMiTi")[[1]]
#> see ?ObMiTi and browseVignettes('ObMiTi') for documentation
#> loading from cache

# print object
ob_counts
#> class: RangedSummarizedExperiment
#> dim: 46045 84
#> metadata(1): measures
#> assays(1): counts
#> rownames(46045): ENSMUSG00000102693 ENSMUSG00000064842 ...
#>   ENSMUSG00000084520 ENSMUSG00000095742
#> rowData names(4): gene_id entrez_id symbol biotype
#> colnames(84): GSM5100485 GSM5100486 ... GSM5100573 GSM5100574
#> colData names(40): title geo_accession ... genotype.ch1 tissue.ch1
```

The count matrix can be accessed using `assay`. Here we show the first five entries of the first five samples.

```
# print count matrix
assay(ob_counts)[1:5, 1:5]
#>                    GSM5100485 GSM5100486 GSM5100487 GSM5100488 GSM5100489
#> ENSMUSG00000102693          0          0          0          0          0
#> ENSMUSG00000064842          0          0          0          0          0
#> ENSMUSG00000051951         15          1          3        575          2
#> ENSMUSG00000102851          0          0          0          0          0
#> ENSMUSG00000103377          0          0          0          1          0
```

The phenotype/samples data is a `data.frame`, It can be accessed using `colData`.

```
#  View Structure of counts
str(colData(ob_counts))
#> Formal class 'DFrame' [package "S4Vectors"] with 6 slots
#>   ..@ rownames       : chr [1:84] "GSM5100485" "GSM5100486" "GSM5100487" "GSM5100488" ...
#>   ..@ nrows          : int 84
#>   ..@ elementType    : chr "ANY"
#>   ..@ elementMetadata: NULL
#>   ..@ metadata       : list()
#>   ..@ listData       :List of 40
#>   .. ..$ title                  : chr [1:84] "ob_ob_HFD_3_He_S12" "ob_ob_HFD_2_He_S11" "WT_HFD_3_Sk_S6" "ob_ob_HFD_1_Sk_S10" ...
#>   .. ..$ geo_accession          : chr [1:84] "GSM5100485" "GSM5100486" "GSM5100487" "GSM5100488" ...
#>   .. ..$ status                 : chr [1:84] "Public on Feb 23 2021" "Public on Feb 23 2021" "Public on Feb 23 2021" "Public on Feb 23 2021" ...
#>   .. ..$ submission_date        : chr [1:84] "Feb 22 2021" "Feb 22 2021" "Feb 22 2021" "Feb 22 2021" ...
#>   .. ..$ last_update_date       : chr [1:84] "Feb 23 2021" "Feb 23 2021" "Feb 23 2021" "Feb 23 2021" ...
#>   .. ..$ type                   : chr [1:84] "SRA" "SRA" "SRA" "SRA" ...
#>   .. ..$ channel_count          : chr [1:84] "1" "1" "1" "1" ...
#>   .. ..$ source_name_ch1        : chr [1:84] "ob_ob_HFD_3_He_S12" "ob_ob_HFD_2_He_S11" "WT_HFD_3_Sk_S6" "ob_ob_HFD_1_Sk_S10" ...
#>   .. ..$ organism_ch1           : chr [1:84] "Mus musculus" "Mus musculus" "Mus musculus" "Mus musculus" ...
#>   .. ..$ characteristics_ch1    : chr [1:84] "genotype: ob_ob" "genotype: ob_ob" "genotype: WT" "genotype: ob_ob" ...
#>   .. ..$ characteristics_ch1.1  : chr [1:84] "diet: HFD" "diet: HFD" "diet: HFD" "diet: HFD" ...
#>   .. ..$ characteristics_ch1.2  : chr [1:84] "tissue: He" "tissue: He" "tissue: Sk" "tissue: Sk" ...
#>   .. ..$ molecule_ch1           : chr [1:84] "total RNA" "total RNA" "total RNA" "total RNA" ...
#>   .. ..$ extract_protocol_ch1   : chr [1:84] "Total mRNA from hearts was isolated using TRIzol and reverse-transcribed using the RevertAid First-Strand cDNA "| __truncated__ "Total mRNA from hearts was isolated using TRIzol and reverse-transcribed using the RevertAid First-Strand cDNA "| __truncated__ "Total mRNA from hearts was isolated using TRIzol and reverse-transcribed using the RevertAid First-Strand cDNA "| __truncated__ "Total mRNA from hearts was isolated using TRIzol and reverse-transcribed using the RevertAid First-Strand cDNA "| __truncated__ ...
#>   .. ..$ extract_protocol_ch1.1 : chr [1:84] "RNA libraries were prepared for sequencing using standard Illumina protocols" "RNA libraries were prepared for sequencing using standard Illumina protocols" "RNA libraries were prepared for sequencing using standard Illumina protocols" "RNA libraries were prepared for sequencing using standard Illumina protocols" ...
#>   .. ..$ taxid_ch1              : chr [1:84] "10090" "10090" "10090" "10090" ...
#>   .. ..$ data_processing        : chr [1:84] "RawdataQC checking with Trimmomatic v0.36   with PE ILLUMINACLIP:TruSeq3-PE.fa:2:30:10" "RawdataQC checking with Trimmomatic v0.36   with PE ILLUMINACLIP:TruSeq3-PE.fa:2:30:10" "RawdataQC checking with Trimmomatic v0.36   with PE ILLUMINACLIP:TruSeq3-PE.fa:2:30:10" "RawdataQC checking with Trimmomatic v0.36   with PE ILLUMINACLIP:TruSeq3-PE.fa:2:30:10" ...
#>   .. ..$ data_processing.1      : chr [1:84] "Read Alignment by Hisat2-2.0.5 with default parameter" "Read Alignment by Hisat2-2.0.5 with default parameter" "Read Alignment by Hisat2-2.0.5 with default parameter" "Read Alignment by Hisat2-2.0.5 with default parameter" ...
#>   .. ..$ data_processing.2      : chr [1:84] "Read count by FeatureCount 1.5.0-p2 with default parameter" "Read count by FeatureCount 1.5.0-p2 with default parameter" "Read count by FeatureCount 1.5.0-p2 with default parameter" "Read count by FeatureCount 1.5.0-p2 with default parameter" ...
#>   .. ..$ data_processing.3      : chr [1:84] "Genome_build: GRCm38" "Genome_build: GRCm38" "Genome_build: GRCm38" "Genome_build: GRCm38" ...
#>   .. ..$ data_processing.4      : chr [1:84] "Supplementary_files_format_and_content: Ob_Mus_RNA_seq_counts.txt" "Supplementary_files_format_and_content: Ob_Mus_RNA_seq_counts.txt" "Supplementary_files_format_and_content: Ob_Mus_RNA_seq_counts.txt" "Supplementary_files_format_and_content: Ob_Mus_RNA_seq_counts.txt" ...
#>   .. ..$ platform_id            : chr [1:84] "GPL19057" "GPL19057" "GPL19057" "GPL19057" ...
#>   .. ..$ contact_name           : chr [1:84] "Gu,Seob,Roh" "Gu,Seob,Roh" "Gu,Seob,Roh" "Gu,Seob,Roh" ...
#>   .. ..$ contact_department     : chr [1:84] "Department of Anatomy and Convergence Medical Science, College of Medicine" "Department of Anatomy and Convergence Medical Science, College of Medicine" "Department of Anatomy and Convergence Medical Science, College of Medicine" "Department of Anatomy and Convergence Medical Science, College of Medicine" ...
#>   .. ..$ contact_institute      : chr [1:84] "Gyeongsang National University" "Gyeongsang National University" "Gyeongsang National University" "Gyeongsang National University" ...
#>   .. ..$ contact_address        : chr [1:84] "Jinju, Gyeongnam, Republic of Korea" "Jinju, Gyeongnam, Republic of Korea" "Jinju, Gyeongnam, Republic of Korea" "Jinju, Gyeongnam, Republic of Korea" ...
#>   .. ..$ contact_city           : chr [1:84] "Jinju" "Jinju" "Jinju" "Jinju" ...
#>   .. ..$ contact_zip.postal_code: chr [1:84] "52727" "52727" "52727" "52727" ...
#>   .. ..$ contact_country        : chr [1:84] "South Korea" "South Korea" "South Korea" "South Korea" ...
#>   .. ..$ data_row_count         : chr [1:84] "0" "0" "0" "0" ...
#>   .. ..$ instrument_model       : chr [1:84] "Illumina NextSeq 500" "Illumina NextSeq 500" "Illumina NextSeq 500" "Illumina NextSeq 500" ...
#>   .. ..$ library_selection      : chr [1:84] "cDNA" "cDNA" "cDNA" "cDNA" ...
#>   .. ..$ library_source         : chr [1:84] "transcriptomic" "transcriptomic" "transcriptomic" "transcriptomic" ...
#>   .. ..$ library_strategy       : chr [1:84] "RNA-Seq" "RNA-Seq" "RNA-Seq" "RNA-Seq" ...
#>   .. ..$ relation               : chr [1:84] "BioSample: https://www.ncbi.nlm.nih.gov/biosample/SAMN17864609" "BioSample: https://www.ncbi.nlm.nih.gov/biosample/SAMN17864608" "BioSample: https://www.ncbi.nlm.nih.gov/biosample/SAMN17864600" "BioSample: https://www.ncbi.nlm.nih.gov/biosample/SAMN17864584" ...
#>   .. ..$ relation.1             : chr [1:84] "SRA: https://www.ncbi.nlm.nih.gov/sra?term=SRX10074369" "SRA: https://www.ncbi.nlm.nih.gov/sra?term=SRX10074368" "SRA: https://www.ncbi.nlm.nih.gov/sra?term=SRX10074359" "SRA: https://www.ncbi.nlm.nih.gov/sra?term=SRX10074341" ...
#>   .. ..$ supplementary_file_1   : chr [1:84] "NONE" "NONE" "NONE" "NONE" ...
#>   .. ..$ diet.ch1               : chr [1:84] "HFD" "HFD" "HFD" "HFD" ...
#>   .. ..$ genotype.ch1           : chr [1:84] "ob_ob" "ob_ob" "WT" "ob_ob" ...
#>   .. ..$ tissue.ch1             : chr [1:84] "He" "He" "Sk" "Sk" ...

# Studies' metadata available
names(colData(ob_counts))
#>  [1] "title"                   "geo_accession"
#>  [3] "status"                  "submission_date"
#>  [5] "last_update_date"        "type"
#>  [7] "channel_count"           "source_name_ch1"
#>  [9] "organism_ch1"            "characteristics_ch1"
#> [11] "characteristics_ch1.1"   "characteristics_ch1.2"
#> [13] "molecule_ch1"            "extract_protocol_ch1"
#> [15] "extract_protocol_ch1.1"  "taxid_ch1"
#> [17] "data_processing"         "data_processing.1"
#> [19] "data_processing.2"       "data_processing.3"
#> [21] "data_processing.4"       "platform_id"
#> [23] "contact_name"            "contact_department"
#> [25] "contact_institute"       "contact_address"
#> [27] "contact_city"            "contact_zip.postal_code"
#> [29] "contact_country"         "data_row_count"
#> [31] "instrument_model"        "library_selection"
#> [33] "library_source"          "library_strategy"
#> [35] "relation"                "relation.1"
#> [37] "supplementary_file_1"    "diet.ch1"
#> [39] "genotype.ch1"            "tissue.ch1"

# Sample GSM ID (Same ob_counts$geo_accession)
rownames(colData(ob_counts))
#>  [1] "GSM5100485" "GSM5100486" "GSM5100487" "GSM5100488" "GSM5100489"
#>  [6] "GSM5100490" "GSM5100491" "GSM5100492" "GSM5100493" "GSM5100494"
#> [11] "GSM5100495" "GSM5100496" "GSM5100497" "GSM5100498" "GSM5100499"
#> [16] "GSM5100500" "GSM5100501" "GSM5100502" "GSM5100503" "GSM5100504"
#> [21] "GSM5100505" "GSM5100506" "GSM5100507" "GSM5100508" "GSM5100509"
#> [26] "GSM5100510" "GSM5100511" "GSM5100512" "GSM5100513" "GSM5100514"
#> [31] "GSM5100515" "GSM5100516" "GSM5100517" "GSM5100518" "GSM5100519"
#> [36] "GSM5100520" "GSM5100521" "GSM5100522" "GSM5100523" "GSM5100524"
#> [41] "GSM5100525" "GSM5100526" "GSM5100527" "GSM5100528" "GSM5100529"
#> [46] "GSM5100531" "GSM5100533" "GSM5100536" "GSM5100539" "GSM5100540"
#> [51] "GSM5100541" "GSM5100542" "GSM5100543" "GSM5100544" "GSM5100545"
#> [56] "GSM5100546" "GSM5100547" "GSM5100548" "GSM5100549" "GSM5100550"
#> [61] "GSM5100551" "GSM5100552" "GSM5100553" "GSM5100554" "GSM5100555"
#> [66] "GSM5100556" "GSM5100557" "GSM5100558" "GSM5100559" "GSM5100560"
#> [71] "GSM5100561" "GSM5100562" "GSM5100563" "GSM5100564" "GSM5100565"
#> [76] "GSM5100566" "GSM5100567" "GSM5100568" "GSM5100569" "GSM5100570"
#> [81] "GSM5100571" "GSM5100572" "GSM5100573" "GSM5100574"

# Sample strain, tissue and diet ID
ob_counts$title
#>  [1] "ob_ob_HFD_3_He_S12" "ob_ob_HFD_2_He_S11" "WT_HFD_3_Sk_S6"
#>  [4] "ob_ob_HFD_1_Sk_S10" "WT_ND_1_Li_S1"      "ob_ob_HFD_3_Hi_S12"
#>  [7] "WT_HFD_2_Ep_S17"    "ob_ob_HFD_2_Hi_S11" "WT_HDF_2_Hi_S5"
#> [10] "WT_HDF_1_Hi_S4"     "ob_ob_ND_3_Hy_S21"  "ob_ob_ND_3_Hi_S9"
#> [13] "ob_ob_ND_2_Hi_S8"   "ob_ob_ND_1_He_S7"   "WT_HFD_3_Ao_S18"
#> [16] "WT_HFD_2_Ao_S17"    "WT_HFD_1_Ao_S16"    "ob_ob_ND_1_Hi_S7"
#> [19] "ob_ob_ND_1_Ao_S19"  "ob_ob_HFD_3_Sk_S12" "ob_ob_HFD_2_Ao_S23"
#> [22] "ob_ob_HFD_3_Hy_S24" "WT_HFD_3_Li_S6"     "WT_HFD_1_Ep_S16"
#> [25] "ob_ob_ND_3_Li_S9"   "ob_ob_ND_1_Li_S7"   "ob_ob_HFD_2_Hy_S23"
#> [28] "ob_ob_HFD_2_Ep_S23" "WT_ND_3_Hi_S3"      "WT_ND_2_Hy_S14"
#> [31] "WT_HDF_2_Hy_S17"    "WT_HDF_1_Hy_S16"    "ob_ob_HFD_1_Hi_S10"
#> [34] "WT_ND_1_He_S1"      "WT_ND_3_Sk_S3"      "WT_HFD_2_Sk_S5"
#> [37] "ob_ob_ND_3_Ao_S21"  "WT_ND_3_Hy_S15"     "WT_ND_2_He_S2"
#> [40] "WT_HFD_1_He_S4"     "ob_ob_ND_1_Hy_S19"  "ob_ob_ND_1_Sk_S7"
#> [43] "WT_ND_2_Li_S2"      "WT_ND_2_Ep_S14"     "WT_ND_1_Ep_S13"
#> [46] "ob_ob_HFD_3_Ep_S24" "WT_ND_1_Hy_S13"     "ob_ob_ND_2_Ep_S20"
#> [49] "ob_ob_HFD_2_Li_S11" "ob_ob_HFD_1_He_S10" "WT_HFD_1_Sk_S4"
#> [52] "WT_HFD_2_Li_S5"     "WT_ND_1_Ao_S13"     "WT_ND_3_Li_S3"
#> [55] "ob_ob_ND_2_Ao_S20"  "ob_ob_ND_3_He_S9"   "WT_ND_2_Ao_S14"
#> [58] "ob_ob_ND_1_Ep_S19"  "WT_HFD_3_He_S6"     "WT_HFD_2_He_S5"
#> [61] "WT_ND_2_Sk_S2"      "ob_ob_ND_2_Sk_S8"   "WT_HFD_3_Ep_S18"
#> [64] "ob_ob_ND_3_Ep_S21"  "ob_ob_HFD_3_Li_S12" "WT_ND_2_Hi_S2"
#> [67] "WT_HDF_3_Hy_S18"    "WT_ND_3_He_S3"      "WT_ND_3_Ao_S15"
#> [70] "WT_ND_1_Sk_S1"      "ob_ob_ND_3_Sk_S9"   "ob_ob_HFD_1_Li_S10"
#> [73] "ob_ob_HFD_1_Hy_S22" "ob_ob_HFD_3_Ao_S24" "ob_ob_ND_2_He_S8"
#> [76] "ob_ob_HFD_2_Sk_S11" "ob_ob_HFD_1_Ao_S22" "WT_ND_3_Ep_S15"
#> [79] "WT_HFD_1_Li_S4"     "ob_ob_ND_2_Li_S8"   "ob_ob_HFD_1_Ep_S22"
#> [82] "WT_ND_1_Hi_S1"      "WT_HDF_3_Hi_S6"     "ob_ob_ND_2_Hy_S20"

# Frequencies of different diets
table(ob_counts$diet.ch1)
#>
#> HFD  ND
#>  42  42

# Frequncies of tissues
table(ob_counts$tissue.ch1)
#>
#> Ao Ep He Hi Hy Li Sk
#> 12 12 12 12 12 12 12

# crosstable of tissue and diet and stratify by genotype
table(ob_counts$diet.ch1, ob_counts$tissue.ch1,ob_counts$genotype.ch1)
#> , ,  = WT
#>
#>
#>       Ao Ep He Hi Hy Li Sk
#>   HFD  3  3  3  3  3  3  3
#>   ND   3  3  3  3  3  3  3
#>
#> , ,  = ob_ob
#>
#>
#>       Ao Ep He Hi Hy Li Sk
#>   HFD  3  3  3  3  3  3  3
#>   ND   3  3  3  3  3  3  3

# Summarize Numeric data
summary(data.frame(colData(ob_counts)))
#>     title           geo_accession         status          submission_date
#>  Length:84          Length:84          Length:84          Length:84
#>  Class :character   Class :character   Class :character   Class :character
#>  Mode  :character   Mode  :character   Mode  :character   Mode  :character
#>  last_update_date       type           channel_count      source_name_ch1
#>  Length:84          Length:84          Length:84          Length:84
#>  Class :character   Class :character   Class :character   Class :character
#>  Mode  :character   Mode  :character   Mode  :character   Mode  :character
#>  organism_ch1       characteristics_ch1 characteristics_ch1.1
#>  Length:84          Length:84           Length:84
#>  Class :character   Class :character    Class :character
#>  Mode  :character   Mode  :character    Mode  :character
#>  characteristics_ch1.2 molecule_ch1       extract_protocol_ch1
#>  Length:84             Length:84          Length:84
#>  Class :character      Class :character   Class :character
#>  Mode  :character      Mode  :character   Mode  :character
#>  extract_protocol_ch1.1  taxid_ch1         data_processing
#>  Length:84              Length:84          Length:84
#>  Class :character       Class :character   Class :character
#>  Mode  :character       Mode  :character   Mode  :character
#>  data_processing.1  data_processing.2  data_processing.3  data_processing.4
#>  Length:84          Length:84          Length:84          Length:84
#>  Class :character   Class :character   Class :character   Class :character
#>  Mode  :character   Mode  :character   Mode  :character   Mode  :character
#>  platform_id        contact_name       contact_department contact_institute
#>  Length:84          Length:84          Length:84          Length:84
#>  Class :character   Class :character   Class :character   Class :character
#>  Mode  :character   Mode  :character   Mode  :character   Mode  :character
#>  contact_address    contact_city       contact_zip.postal_code
#>  Length:84          Length:84          Length:84
#>  Class :character   Class :character   Class :character
#>  Mode  :character   Mode  :character   Mode  :character
#>  contact_country    data_row_count     instrument_model   library_selection
#>  Length:84          Length:84          Length:84          Length:84
#>  Class :character   Class :character   Class :character   Class :character
#>  Mode  :character   Mode  :character   Mode  :character   Mode  :character
#>  library_source     library_strategy     relation          relation.1
#>  Length:84          Length:84          Length:84          Length:84
#>  Class :character   Class :character   Class :character   Class :character
#>  Mode  :character   Mode  :character   Mode  :character   Mode  :character
#>  supplementary_file_1   diet.ch1         genotype.ch1        tissue.ch1
#>  Length:84            Length:84          Length:84          Length:84
#>  Class :character     Class :character   Class :character   Class :character
#>  Mode  :character     Mode  :character   Mode  :character   Mode  :character
```

Other columns in `colData` are selected information about the samples/runs or identifiers to different databases. The following table provides the description of each of these columns. Here are a brief description about the key columns.

| col\_name | description |
| --- | --- |
| title | Sample title include strain, diet, tissue and replicate |
| genotype.ch1 | the mice type; either ob/ob or WT |
| diet.ch1 | The diet type; either high fat (HFD) or Normal diet (ND) |
| tissue.ch1 | tissue type. 7 tissues included\* |

|———————–|———————————————————-| \* Ao: arota, Ep=Epididymis; He=Heart; Hi=Hippocampus; Hy=Hypothalamus; Li=Liver; Sk=Skeletal Muscle.

Additional information about mice characteristics can be accessed from the `metadata`. The main dataframe passed is measures. You can access measures as:

```
metadata(ob_counts)$measures
#>          mouse ALT_UL AST_UL T.Chol_mgdL FFA_uEqL Glucose_mgdL
#> 1  ob/ob_HFD_1    302    405         299      558          267
#> 2  ob/ob_HFD_2    534    717         196      563          378
#> 3  ob/ob_HFD_3    428    604         355      513          412
#> 4   ob/ob_ND_1    357    529         263       NA          290
#> 5   ob/ob_ND_2    451    331         264      742          253
#> 6   ob/ob_ND_3    484    509         246      472          384
#> 7     WT_HFD_1    333    345         256      405          284
#> 8     WT_HFD_2    193    247         240      496          412
#> 9     WT_HFD_3    232    217         219      537          364
#> 10     WT_ND_1     29    231         117      490          343
#> 11     WT_ND_2     26    104         110      628          320
#> 12     WT_ND_3     29    126         105      450          306
#>    Triglyceride_mgdL Leptin_ngml   fat  lean free_water total_water blood
#> 1                 61      0.0000 44.45 22.92       0.86       21.04    12
#> 2                 63      0.0000 46.54 21.73       0.00       20.49    13
#> 3                 86      0.0000 51.07 24.55       0.87       23.21    14
#> 4                 83      0.0000 39.90 23.22       0.91       21.45     9
#> 5                 58      0.0000 39.49 23.25       1.42       22.45    10
#> 6                 64      0.0000 45.23 21.29       1.41       21.16    11
#> 7                 60    850.2180 20.05 26.21       0.24       22.73     9
#> 8                 46    635.7351 18.62 24.72       0.81       20.05    10
#> 9                 93    636.9455 17.88 27.04       0.46       23.51    11
#> 10                56      0.0000  9.41 20.39       0.00       17.89     8
#> 11                62      0.0000  6.61 22.82       0.61       19.84     9
#> 12                50      0.0000  6.66 23.05       1.11       20.05    10
#>    weight fasting_glucose brain    Li mesenteric_fact    Ep
#> 1    71.2             110 0.343 3.035           1.454 2.022
#> 2    72.3             118 0.359 3.567           1.577 2.019
#> 3    80.8             117 0.336 3.352           1.901 2.624
#> 4    68.2             160 0.376 4.529           2.105 2.583
#> 5    67.3             181 0.356 3.990           1.723 2.369
#> 6    71.3             173 0.362 4.261           1.760 2.964
#> 7    50.1             239 0.476 3.006           1.203 1.140
#> 8    46.4             259 0.399 2.645           1.371 1.412
#> 9    47.7             188 0.462 2.227           1.428 1.497
#> 10   32.3             168 0.476 1.198           0.368 1.521
#> 11   32.0             197 0.482 1.194           0.336 1.307
#> 12   32.1             180 0.477 1.208           0.431 1.309
#>    reteroperitoneal_fact
#> 1                  5.475
#> 2                  6.865
#> 3                  6.431
#> 4                  4.983
#> 5                  4.858
#> 6                  5.652
#> 7                  2.057
#> 8                  2.112
#> 9                  1.827
#> 10                 0.725
#> 11                 0.625
#> 12                 0.635
```

The information presented in `measures` table is described in the table below:

| col\_name | description |
| --- | --- |
| blood | Total blood volume |
| weight | mice weight |
| fasting\_glucose | Fasting blood glucose measurement |
| brain | Brain weight |
| Li | Liver weight |
| Ep | Epididymis weight |
| mesentrec\_fact | Mesenteric fat weight |
| reteroperitoneal\_fact | Reteroperitoneal fat weight |
| ALT\_UL | ALT measurment (U/L) |
| AST\_UL | AST measurement (U/L) |
| T.Chol\_mgdL | Total cholesterol measurement (mg/dL) |
| FFA\_uEql | Free fatty acids measurement |
| Glucose\_mgdL | Glucose measrurement (mg/dL) |
| Triglyceride\_mgdL | Triglyceride measurement (mg/dL) |
| Leptin\_ngmL | Leptin measurement (ng/dL) |
| fat | Mice’s fat mass by echo MRI |
| lean | Lean body mass by echo MRI |
| free\_water | Free water measurement by echo MRI |
| total water | Total water measurement by echo MRI |
| ———————– | —————————————- |

The features data are a `GRanges` object and can be accessed using `rowRanges`.

```
# print GRanges object
rowRanges(ob_counts)
#> GRanges object with 46045 ranges and 4 metadata columns:
#>                        seqnames              ranges strand |            gene_id
#>                           <Rle>           <IRanges>  <Rle> |        <character>
#>   ENSMUSG00000102693          1     3143476-3144545      + | ENSMUSG00000102693
#>   ENSMUSG00000064842          1     3172239-3172348      + | ENSMUSG00000064842
#>   ENSMUSG00000051951          1     3276124-3741721      - | ENSMUSG00000051951
#>   ENSMUSG00000102851          1     3322980-3323459      + | ENSMUSG00000102851
#>   ENSMUSG00000103377          1     3435954-3438772      - | ENSMUSG00000103377
#>                  ...        ...                 ...    ... .                ...
#>   ENSMUSG00000094915 GL456212.1         31967-34932      - | ENSMUSG00000094915
#>   ENSMUSG00000079808 GL456212.1       128555-150452      - | ENSMUSG00000079808
#>   ENSMUSG00000095041 JH584304.1         52190-59690      - | ENSMUSG00000095041
#>   ENSMUSG00000084520          4 156424852-156424986      - | ENSMUSG00000084520
#>   ENSMUSG00000095742 JH584295.1             66-1479      - | ENSMUSG00000095742
#>                      entrez_id        symbol              biotype
#>                      <integer>   <character>          <character>
#>   ENSMUSG00000102693      <NA> 4933401J01Rik                  TEC
#>   ENSMUSG00000064842 115487594       Gm26206                snRNA
#>   ENSMUSG00000051951    497097          Xkr4       protein_coding
#>   ENSMUSG00000102851      <NA>       Gm18956 processed_pseudogene
#>   ENSMUSG00000103377      <NA>       Gm37180                  TEC
#>                  ...       ...           ...                  ...
#>   ENSMUSG00000094915    671917                     protein_coding
#>   ENSMUSG00000079808 102638047                     protein_coding
#>   ENSMUSG00000095041      <NA>                     protein_coding
#>   ENSMUSG00000084520      <NA>                              snRNA
#>   ENSMUSG00000095742      <NA>                     protein_coding
#>   -------
#>   seqinfo: 36 sequences from an unspecified genome; no seqlengths
```

Notice there are two types of data in this object. The first is the coordinates of the identified genes `ranges(ob_counts)`. The second is the annotation of the these genes `mcols(ob_counts)`. The following table show the description of the second annotation item. All annotations were obtained using `biomaRt` package as described in the `inst/scripts`.

| col\_name | description |
| --- | --- |
| ranges | The range of start and end of gene |
| strand | Either this gene is located on the positive or negative strand |
| gene\_id | Ensembl gene id |
| entrez\_id | Entrez gene id (if available) |
| symbol | Common gene symbol (if available) |
| biotype | The biological function of gene as classified by Ensembl database |
| ———– | ——————————————————————- |

# Example of using `ObMiTi`

## Selecting Protein Coding genes

```
se <- ob_counts[rowRanges(ob_counts)$biotype == 'protein_coding',]
```

## Plot first 100 genes

```
plot(log(assay(se)[1:100,]))
```

![](data:image/png;base64...)

# Citing `ObMiTi`

For citing the package use:

```
#citing the package
citation("ObMiTi")
```

# Session Info

```
devtools::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-11-04
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package              * version date (UTC) lib source
#>  abind                  1.4-8   2024-09-12 [2] CRAN (R 4.5.1)
#>  AnnotationDbi          1.72.0  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationHub        * 4.0.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biobase              * 2.70.0  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocFileCache        * 3.0.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocVersion            3.22.0  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.78.0  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0   2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1 2025-01-16 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4   2023-03-17 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  crayon                 1.5.3   2024-06-20 [2] CRAN (R 4.5.1)
#>  curl                   7.0.0   2025-08-19 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3   2024-06-02 [2] CRAN (R 4.5.1)
#>  dbplyr               * 2.5.1   2025-09-10 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  devtools               2.4.6   2025-10-03 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
#>  ellipsis               0.3.2   2021-04-29 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  ExperimentHub        * 3.0.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  fastmap                1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  filelock               1.0.3   2023-12-11 [2] CRAN (R 4.5.1)
#>  fs                     1.6.6   2025-04-12 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges        * 1.62.0  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  glue                   1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2                  1.2.1   2025-07-22 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  jquerylib              0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.50.0  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7  2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle              1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4   2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0   2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1   2021-11-26 [2] CRAN (R 4.5.1)
#>  ObMiTi               * 1.18.0  2025-11-04 [1] Bioconductor 3.22 (R 4.5.1)
#>  pillar                 1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgbuild               1.4.8   2025-05-26 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
#>  pkgload                1.4.1   2025-09-23 [2] CRAN (R 4.5.1)
#>  png                    0.1-8   2022-11-29 [2] CRAN (R 4.5.1)
#>  purrr                  1.1.0   2025-07-10 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs               0.3.3   2021-01-31 [2] CRAN (R 4.5.1)
#>  remotes                2.5.0   2024-03-17 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  RSQLite                2.4.3   2025-08-20 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  sass                   0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  Seqinfo              * 1.0.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo            1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  SparseArray            1.10.1  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  SummarizedExperiment * 1.40.0  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
#>  usethis                3.2.1   2025-09-06 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2   2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.54    2025-10-30 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpTu3yoL/Rinst84e3c3cb2a23f
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```