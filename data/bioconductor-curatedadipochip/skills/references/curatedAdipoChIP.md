# Using curatedAdipoChIP

#### Mahmoud Ahmed

#### 2025-11-04

# curatedAdipoChIP

A Curated ChIP-Seq Dataset of MDI-induced Differentiated Adipocytes (3T3-L1)

# Overview

In this document, we introduce the purpose of `curatedAdipoChIP` package, its contents and its potential use cases. This package is a curated dataset of ChIP-Seq samples. The samples are MDI-induced pre-adipocytes (3T3-L1) at different time points/stage of differentiation. The ChIP-antibodies used in this dataset are of transcription factors, chromatin remodelers and histone modifications. The package document the data collection, pre-processing and processing. In addition to the documentation the package contains the scripts that were used to generate the data in `inst/scripts` and access to the final `RangedSummarizedExperiment` object through `ExperimentHub`.

# Introduction

## What is `curatedAdipoChIP`?

It is an R package for documenting and distributing a curated dataset. The package doesn’t contain any R functions.

## What is contained in `curatedAdipoChIP`?

The package contains two different things:

1. Scripts for documenting/reproducing the data in `inst/scripts`
2. Access to the final `RangedSummarizedExperiment` through `ExperimentHub`.

## What is `curatedAdipoChIP` for?

The `RangedSummarizedExperiment` object contains the `peak_counts`, `colData`, `rowRanges` and `metadata` which can be used for the purposes of conducting differential peak binding or gene set enrichment analysis on the cell line model.

# Installation

The `curatedAdipoChIP` package can be installed from Bioconductor using `BiocManager`.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("curatedAdipoChIP")
```

# Docker image

The pre-processing and processing of the data setup environment is available as a `docker` image. This image is also suitable for reproducing this document. The `docker` image can be obtained using the `docker` CLI client.

```
$ docker pull bcmslab/adiporeg_chip:latest
```

# Generating `curatedAdipoChIP`

## Search starategy & data collection

The term “3T3-L1” was used to search the NCBI **SRA** repository. The results were sent to the **run selector**. 1,176 runs were viewed. The runs were faceted by **Assay Type** and the “chip-seq” which resulted in 739 runs. Only 235 samples from 20 different studies were included after being manually reviewed to fit the following criteria: \* The raw data is available from GEO and has a GEO identifier (GSM#) \* The raw data is linked to a published publicly available article \* The protocols for generating the data sufficiently describe the origin of the cell line, the differentiation medium and the time points when the samples were collected. \* In case the experimental designs included treatment other than the differentiation medias, the control (non-treated) samples were included.

Note: The data quality and the platform discrepancies are not included in these criteria

## Pre-processing

The scripts to download and process the raw data are located in `inst/scripts/` and are glued together to run sequentially by the GNU make file `Makefile`. The following is basically a description of the recipes in the `Makefile` with emphasis on the software versions, options, inputs and outputs.

### 1. Downloading data `download_fastq`

* Program: `wget` (1.18)
* Input: `run.csv`, the URLs column
* Output: `*.fastq.gz`
* Options: `-N`

### 2. Making a genome index `make_index`

* Program: `bowtie2-build` (2.3.0)
* Input: URL for mm10 mouse genome fasta files
* Output: `*.bt2` bowtie2 index for the mouse genome
* Options: defaults

### 3. Dowinloading annotations `get_annotation`

* Program: `wget` (1.18)
* Input: URL for mm10 gene annotation file
* Output: `annotation.gtf`
* Options: `-N`

### 4. Aligning reads `align_reads`

* Program: `bowtie2` (2.3.0)
* Input: `*.fastq.gz` and `mm10/` bowtie2 index for the mouse genome
* Output: `*.sam`
* Options: `--no-unal`

### 5. Calling peaks `peak_calling`

* Program: `macs2` (2.1.2)
* Input: `*.bam` and
* Output: `peaks.bed`
* Options: `-B --nomodel --SPMR`

### 6. Making a peakset `get_peakset`

* Program: `bedtools` (2.26.0)
* Input: `*.bed`
* Output: `peakset.bed`
* Options: `-c 4,4 -o count_distinct,distinct`

### 7. Counting reads in peaks `count_features`

* Program: `bedtools multicov` (2.26.0)
* Input: `*.bam` and `peakset.bed`
* Output: `peakset.txt`
* Options: defaults

### 8. Quality assessment `fastqc`

* Program: `fastqc` (0.11.5)
* Input: `*.fastq.gz` and `*.sam`
* Output: `*_fastqc.zip`
* Option: defaults

## Processing

The aim of this step is to construct a self-contained object with minimal manipulations of the pre-processed data followed by a simple exploration of the data in the next section.

### Making a summarized experiment object `peak_object`

The required steps to make this object from the pre-processed data are documented in the script and are supposed to be fully reproducible when run through this package. The output is a `RangedSummarizedExperiment` object containing the peak counts and the phenotype and features data and metadata.

The `RangedSummarizedExperiment` contains \* The gene counts matrix `peak_counts` \* The phenotype data `colData`. The column `name` links each peak to one or more samples \* The feature data `rowRanges` \* The metadata `metadata` which contain a `data.frame` of the studies from which the samples were collected.

## Exploring the `peak_counts` object

In this section, we conduct a simple exploration of the data objects to show the content of the package and how they can be loaded and used.

```
# loading required libraries
library(ExperimentHub)
library(SummarizedExperiment)
library(S4Vectors)
library(fastqcr)
library(DESeq2)
library(dplyr)
library(tidyr)
library(ggplot2)
```

```
# query package resources on ExperimentHub
eh <- ExperimentHub()
query(eh, "curatedAdipoChIP")
#> ExperimentHub with 5 records
#> # snapshotDate(): 2025-10-29
#> # $dataprovider: GEO, SRA
#> # $species: Mus musculus
#> # $rdataclass: SummarizedExperiment, RangedSummarizedExperiment
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["EH2258"]]'
#>
#>            title
#>   EH2258 | A Curated ChIP-Seq Dataset of MDI-induced Differentiated Adipocy...
#>   EH3286 | A Curated Microarrays Dataset  of MDI-induced Differentiated Adi...
#>   EH3287 | A Curated Microarrays Dataset (processed) of MDI-induced Differe...
#>   EH3288 | A Curated Microarrays Dataset  of MDI-induced Differentiated Adi...
#>   EH3289 | A Curated Microarrays Dataset (processed) of MDI-induced Differe...

# load data from ExperimentHub
peak_counts <- query(eh, "curatedAdipoChIP")[[1]]
#> see ?curatedAdipoChIP and browseVignettes('curatedAdipoChIP') for documentation
#> loading from cache

# print object
peak_counts
#> class: RangedSummarizedExperiment
#> dim: 837030 207
#> metadata(1): studies
#> assays(1): peak_counts
#> rownames(837030): peak_1 peak_2 ... peak_837855 peak_837856
#> rowData names(10): peak name ... geneId distanceToTSS
#> colnames(207): GSM1017630 GSM1017631 ... GSM838021 GSM838022
#> colData names(11): id runs ... control_type qc
```

The count matrix can be accessed using `assay`. Here we show the first five entries of the first five samples.

```
# print count matrix
assay(peak_counts)[1:5, 1:5]
#>        GSM1017630 GSM1017631 GSM1017632 GSM1017633 GSM1017634
#> peak_1          0          0          7          2          3
#> peak_2          0         10         28         24          5
#> peak_3          0          1          9         13          2
#> peak_4          4          9          9         20          6
#> peak_5          1          1         14         10          2
```

The phenotype/samples data is a `data.frame`, It can be accessed using `colData`. The `time` and `stage` columns encode the time point in hours and stage of differentiation respectively. The column `factor` records the ChIP antibody used in the sample.

```
# names of the coldata object
names(colData(peak_counts))
#>  [1] "id"           "runs"         "study"        "pmid"         "factor"
#>  [6] "time"         "stage"        "bibtexkey"    "control_id"   "control_type"
#> [11] "qc"

# table of times column
table(colData(peak_counts)$time)
#>
#> -48   0   2   4   6  24  48  72  96 144 168
#>   2  46   1  43   1   4  21   3   9   7  22

# table of stage column
table(colData(peak_counts)$stage)
#>
#>  0  1  2  3
#> 67 73  9 40

# table of factor column
table(colData(peak_counts)$factor)
#>
#>      ATF2      ATF7     CEBPA     CEBPB     CEBPD     CREB1      CTCF      E2F4
#>         2         1         2         9         2         3        10         1
#>     EP300     FOSL2      GPS2   H3K27ac  H3K27me3  H3K36me3   H3K4me1   H3K4me2
#>         6         2         2         6         6         3         7         5
#>   H3K4me3  H3K79me2  H3K79me3   H3K9me2   H3K9me3  H4K20me1     HDAC2     HDAC3
#>        12         1         1         1         4         1         4         4
#>       JUN      JUND     KDM1A     KDM5A     KDM5C      KLF4      KLF5     KMT2B
#>         2         1         2         6         2         1         1         1
#>      MBD1      MED1     NCOR1     NR3C1      NRF1      PBX1    POLR2A     PPARG
#>         2        14         5         1         1         1        12        13
#>     PSMB1      RXRG    SETDB1   SMARCA4     SMC1A     STAT1    STAT5A      TCF7
#>         1         8         3         1        10         1         1         1
#> Ubiquitin       VDR
#>         2         1
```

Other columns in `colData` are selected information about the samples/runs or identifiers to different databases. The following table provides the description of each of these columns.

| col\_name | description |
| --- | --- |
| id | The GEO sample identifier. |
| runs | A list of tibbles with information about individual run files. |
| study | The SRA study identifier. |
| pmid | The PubMed ID of the article where the data were published originally. |
| factor | The name of the ChIP antibody that was used in the sample. |
| time | The time point of the sample when collected in hours. The time is recorded from the beginning of the protocol as 0 hours. |
| stage | The stage of differentiation of the sample when collected. Possible values are 0 to 3; 0 for non-differentiated; 1 for differentiating; and 2/3 for maturating samples. |
| bibtexkey | The key of the study where the data were published originally. This maps to the studies object of the metadata which records the study information in bibtex format. |
| control\_id | The GEO sample identifier of the control (input) sample. |
| control\_type | The method for assigning the control samples. Possible values are “provided” when the same study has control sample/s or “other” when control samples were selected from other studies. |
| library\_layout | The type of RNA library. Possible values are SINGLE for single-end and PAIRED for paired-end runs. |
| instrument\_model | The name of the sequencing machine that was used to obtain the sequence reads. |
| qc | The quality control output of fastqc on the separate files/runs. |

The features data are a `GRanges` object and can be accessed using `rowRanges`.

```
# print GRanges object
rowRanges(peak_counts)
#> GRanges object with 837030 ranges and 10 metadata columns:
#>               seqnames            ranges strand |
#>                  <Rle>         <IRanges>  <Rle> |
#>        peak_1     chr1   3029191-3029410      * |
#>        peak_2     chr1   3031394-3031660      * |
#>        peak_3     chr1   3037771-3037971      * |
#>        peak_4     chr1   3049860-3050379      * |
#>        peak_5     chr1   3051655-3051881      * |
#>           ...      ...               ...    ... .
#>   peak_837852     chrY 90830107-90830335      * |
#>   peak_837853     chrY 90830368-90830710      * |
#>   peak_837854     chrY 90834938-90835190      * |
#>   peak_837855     chrY 90835545-90836986      * |
#>   peak_837856     chrY 90839338-90840071      * |
#>                                               peak        name
#>                                    <CharacterList> <character>
#>        peak_1                GSM2515964,GSM2515966      peak_1
#>        peak_2 GSM1370450,GSM1893625,GSM1893626,...      peak_2
#>        peak_3                           GSM2515948      peak_3
#>        peak_4 GSM1412513,GSM2515948,GSM2515949,...      peak_4
#>        peak_5                           GSM2515966      peak_5
#>           ...                                  ...         ...
#>   peak_837852                            GSM340808 peak_837852
#>   peak_837853                            GSM340808 peak_837853
#>   peak_837854                            GSM686970 peak_837854
#>   peak_837855 GSM1368009,GSM1368013,GSM1368014,... peak_837855
#>   peak_837856 GSM1370470,GSM1412512,GSM2233369,... peak_837856
#>                      annotation   geneChr geneStart   geneEnd geneLength
#>                     <character> <integer> <integer> <integer>  <integer>
#>        peak_1 Distal Intergenic         1   3214482   3671498     457017
#>        peak_2 Distal Intergenic         1   3214482   3671498     457017
#>        peak_3 Distal Intergenic         1   3214482   3671498     457017
#>        peak_4 Distal Intergenic         1   3214482   3671498     457017
#>        peak_5 Distal Intergenic         1   3214482   3671498     457017
#>           ...               ...       ...       ...       ...        ...
#>   peak_837852 Distal Intergenic        21  90785442  90816465      31024
#>   peak_837853 Distal Intergenic        21  90785442  90816465      31024
#>   peak_837854 Distal Intergenic        21  90785442  90816465      31024
#>   peak_837855 Distal Intergenic        21  90785442  90816465      31024
#>   peak_837856 Distal Intergenic        21  90785442  90816465      31024
#>               geneStrand      geneId distanceToTSS
#>                <integer> <character>     <numeric>
#>        peak_1          2        Xkr4        642088
#>        peak_2          2        Xkr4        639838
#>        peak_3          2        Xkr4        633527
#>        peak_4          2        Xkr4        621119
#>        peak_5          2        Xkr4        619617
#>           ...        ...         ...           ...
#>   peak_837852          1       Erdr1         44665
#>   peak_837853          1       Erdr1         44926
#>   peak_837854          1       Erdr1         49496
#>   peak_837855          1       Erdr1         50103
#>   peak_837856          1       Erdr1         53896
#>   -------
#>   seqinfo: 64 sequences from an unspecified genome; no seqlengths
```

Notice there are two types of data in this object. The first is the coordinates of the identified peaks `ranges(peak_counts)`. The second is the annotation of the these regions `mcols(peak_counts)`. The following table show the description of the second annotation item. Except for the first three columns, all annotations were obtained using `ChIPSeeker::annotatePeak` as described in the `inst/scripts`.

| col\_name | description |
| --- | --- |
| peak | The GEO sample identifier of the samples containing this peak in a CharacterList. |
| name | The name of the peak in the set of unique merged peaks. |
| annotation | genomic feature of the peak, for instance if the peak is located in 5’UTR, it will annotated by 5’UTR. Possible annotation is Promoter-TSS, Exon, 5’ UTR, 3’ UTR, Intron, and Intergenic. |
| geneChr | Chromosome of the nearest gene |
| geneStart | Gene start |
| geneEnd | Gene end |
| geneLength | Gene length |
| geneStrand | Gene Strand |
| geneId | Gene symbol |
| distanceToTSS | Distance from peak to gene TSS |

The metadata is a list of one object. `studies` is a `data.frame` containing the bibliography information of the studies from which the data were collected. Here we show the first entry in the `studies` object.

```
# print data of first study
metadata(peak_counts)$studies[1,]
#> # A tibble: 1 × 34
#>   CATEGORY BIBTEXKEY ADDRESS ANNOTE AUTHOR BOOKTITLE CHAPTER CROSSREF EDITION
#>   <chr>    <chr>     <chr>   <chr>  <list> <chr>     <chr>   <chr>    <chr>
#> 1 ARTICLE  Brier2017 <NA>    <NA>   <chr>  <NA>      <NA>    <NA>     <NA>
#> # ℹ 25 more variables: EDITOR <list>, HOWPUBLISHED <chr>, INSTITUTION <chr>,
#> #   JOURNAL <chr>, KEY <chr>, MONTH <chr>, NOTE <chr>, NUMBER <chr>,
#> #   ORGANIZATION <chr>, PAGES <chr>, PUBLISHER <chr>, SCHOOL <chr>,
#> #   SERIES <chr>, TITLE <chr>, TYPE <chr>, VOLUME <chr>, YEAR <dbl>,
#> #   ARCHIVEPREFIX <chr>, ARXIVID <chr>, DOI <chr>, EPRINT <chr>, ISBN <chr>,
#> #   ISSN <chr>, PMID <chr>, URL <chr>
```

# Summary of the studies in the dataset

| GEO series ID | PubMed ID | Num. of Samples | Time (hr) | Differentiation Stage | Factor |
| --- | --- | --- | --- | --- | --- |
| SRP000630 | 18981474 | 18 | 0/ 24/ 48/ 72/ 96/ 144 | 0/1/2/3 | PPARG/ RXRG/ POLR2A |
| SRP002283 | 20442865 | 1 | NA | 3 | E2F4 |
| SRP002337 | 20887899 | 15 | -48/ 0/ 48/ 168 | 0/1/3 | H3K4me3/ H3K27me3/ H3K36me3/ H3K4me2/ H3K4me1/ H3K27ac/ PPARG |
| SRP002507 | 20478996 | 2 | 0/ 6 | 0/1 | CEBPB |
| SRP006001 | 21427703 | 13 | 0/ 2/ 4/ 48/ 144 | 0/1/3 | CEBPB/ CEBPD/ NR3C1/ STAT5A/ RXRG/ PPARG/ POLR2A |
| SRP008061 | 21914845 | 1 | 24 | 1 | TCF7 |
| SRP009613 | 24315104 | 6 | NA | 0 | PPARG/ JUN/ CREB1/ PSMB1/ Ubiquitin |
| SRP016054 | 23178591 | 4 | NA/ 168 | 0/3 | H3K4me3/ H3K27me3/ H3K9me2/ H3K9me3 |
| SRP028367 | 23885096 | 7 | 168 | 3 | PPARG/ MED1/ CEBPA/ POLR2A/ CREB1 |
| SRP029985 | 24912735 | 3 | 0/ 168 | 0/3 | KDM1A/ NRF1 |
| SRP041129 | 24788520 | 10 | NA | 3 | MED1/ CREB1/ EP300/ NCOR1/ CEBPA/ CEBPB/ ATF2/ JUND/ FOSL2 |
| SRP041249 | 24857652 | 19 | 4 | 1 | ATF2/ ATF7/ JUN/ FOSL2/ KLF4/ KLF5/ PBX1/ STAT1/ VDR/ RXRG/ MED1/ EP300/ SMARCA4/ H3K27ac/ H3K4me1/ H3K4me2 |
| SRP042079 | 24953653 | 2 | 0 | 0 | GPS2 |
| SRP043216 | 25503565 | 8 | NA | 0 | H3K27ac/ H3K27me3/ H3K36me3/ H3K4me1/ H3K4me3/ H3K79me2/ H3K79me3/ H4K20me1 |
| SRP064188 | 26590716 | 11 | 0/ 144 | 0/3 | H3K27me3/ H3K9me3/ SETDB1/ MBD1/ POLR2A |
| SRP065028 | 28398509 | 1 | 168 | 3 | KMT2B |
| SRP078506 | 27899593 | 14 | 0/ 4/ 48 | 0/1 | H3K4me3/ KDM5A/ KDM5C |
| SRP080809 | 28107648 | 2 | NA | 0 | CEBPB |
| SRP100871 | 28475875 | 52 | 4/ 0/ 48/ 96/ 168 | 1/0/2/3 | CTCF/ H3K27ac/ H3K4me1/ H3K4me2/ HDAC2/ HDAC3/ MED1/ NCOR1/ EP300/ SMC1A |

Some of the samples included in this object are control samples.

```
# show the number of control samples
table(is.na(peak_counts$control_id))
#>
#> FALSE  TRUE
#>   189    18
```

Also, some entries are recorded as `NA` such as in the column `time` when the the data are missing or couldn’t be determined from the metadata.

# Example of using `curatedAdipoChIP`

## Motivation

All the samples in this dataset come from the [3T3-L1](https://en.wikipedia.org/wiki/3T3-L1) cell line. The [MDI](http://www.protocol-online.org/prot/Protocols/In-Vitro-Adipocytes-Differentiation-4789.html) induction media, were used to induce adipocyte differentiation. The two important variables in the dataset are `time` and `stage`, which correspond to the time point and stage of differentiation when the sample were captured. Ideally, this dataset should be treated as a time course. However, for the purposes of this example, we only used samples from two differentiation stages 0 and 1 for the transcription factor [(CEBPB)](https://en.wikipedia.org/wiki/CEBPB) and treated them as independent groups. The goal of this example is to show how a typical differential binding analysis can be applied in the dataset. The main focus is to explain how the the data and metadata in `peak_counts` fit in each main piece of the analysis. We started by sub-setting the object to the samples of interest, filtering the low quality samples and low count genes. Then we applied the `DESeq2` method with the default values.

## Subsetting the object to samples and peaks of interest

First, we subset the `peak_counts` object to all samples in the differentiation stage 0 or 1 for the transcription factor CEBPB. Using the samples IDs we get chose only the features/peaks that was found in at least one of samples. Notice that other criteria for choosing peaks can be applied depending on the purpose of the analysis. The total number of samples is 8 with 4 samples in each stage. The total number of peaks is 49028.

```
# subset peaks_count object
# select samples for the factor CEBPB and stage 0 and 1
sample_ind <- (peak_counts$factor == 'CEBPB') & (peak_counts$stage %in% c(0, 1))
sample_ids <- colnames(peak_counts)[sample_ind]

# select peaks from the selected samples
peak_ind <- lapply(mcols(peak_counts)$peak, function(x) sum(sample_ids %in% x))
peak_ind <- unlist(peak_ind) > 2

# subset the object
se <- peak_counts[peak_ind, sample_ind]

# show the number of samples in each group
table(se$stage)
#>
#> 0 1
#> 4 4

# show the number of peak in each sample
table(unlist(mcols(se)$peak))[sample_ids]
#>
#> GSM2257705 GSM2257706  GSM544720  GSM544721  GSM686970  GSM686971  GSM686972
#>        749        677       1806      14251      14074      15381       7653
#>  GSM686973
#>       3367
```

## Filtering low quality samples

Since the quality metrics are reported per run file, we need to get the SSR\* id for each of the samples. Notice that, some samples would have more than one file. In this case because some of the samples are paired-end, so each of them would have two files `SRR\*_1` and `SRR\*_2`. This kind of information is available in `colData`.

```
# check the number of files in qc
qc <- se$qc
table(lengths(qc))
#>
#> 1 2
#> 6 2

# flattening qc list
qc <- unlist(qc, recursive = FALSE)
length(qc)
#> [1] 10
```

The `qc` object of the metadata contains the output of [fastqc](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) in a `qc_read` class. More information on this object can be accessed by calling `?fastqcr::qc_read`. Here, we only use the `per_base_sequence_quality` to filter out low quality samples. This is by no means enough quality control but it should drive the point home.

```
# extracting per_base_sequence_quality
per_base <- lapply(qc, function(x) {
  df <- x[['per_base_sequence_quality']]
  df %>%
    dplyr::select(Base, Mean) %>%
    transform(Base = strsplit(as.character(Base), '-')) %>%
    unnest(Base) %>%
    mutate(Base = as.numeric(Base))
}) %>%
  bind_rows(.id = 'run')
```

After tidying the data, we get a `data.frame` with three columns; `run`, `Mean` and `Base` for the run ID, the mean quality score and the base number in each read. [fastqc](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) provide thorough documentation of this quality control module and others.

```
# a quick look at quality scores
summary(per_base)
#>      run                 Base           Mean
#>  Length:362         Min.   : 1.0   Min.   :28.24
#>  Class :character   1st Qu.:10.0   1st Qu.:31.90
#>  Mode  :character   Median :19.0   Median :34.80
#>                     Mean   :18.6   Mean   :33.96
#>                     3rd Qu.:28.0   3rd Qu.:35.57
#>                     Max.   :37.0   Max.   :36.50
```

To identify the low quality samples, we categorize the runs `run_average` which correspond to the average of the per base mean scores. The following figure should make it easier to see why this cutoff were used in this case.

```
# find low quality runs
per_base <- per_base %>%
  group_by(run) %>%
  mutate(run_average = mean(Mean) > 34)

# plot average per base quality
per_base %>%
  ggplot(aes(x = Base, y = Mean, group = run, color = run_average)) +
  geom_line() +
  lims(y = c(0,40))
```

![](data:image/png;base64...)

The run IDs of the “bad” samples is then used to remove them from the dataset.

```
# get run ids of low quality samples
bad_runs <- unique(per_base$run[per_base$run_average == FALSE])
bad_samples <- lapply(se$runs, function(x) sum(x$run %in% bad_runs))

# subset the counts object
se2 <- se[, unlist(bad_samples) == 0]

# show remaining samples by stage
table(se2$stage)
#>
#> 0 1
#> 3 3
```

## Filtering peaks with low counts

To identify the low count feature/peaks, we keep only the features with at least 10 reads in 2 or more samples. Then we subset the object to exclude the rest.

```
# filtering low count genes
low_counts <- apply(assay(se2), 1, function(x) length(x[x>10])>=2)
table(low_counts)
#> low_counts
#> FALSE  TRUE
#>    45 15435

# subsetting the count object
se3 <- se2[low_counts,]
```

## Check sample reproducibility

One expects that samples from the same group should reflect similar biology. In fact, this is also expected for the differential binding analysis to be reliable. In the context of ChIP-Seq, several measures were proposed to quantify the similarities and discrepancies between the samples, check this [article](https://genome.cshlp.org/content/genome/22/9/1813.full.html) for more. Here, we use scatter plots of the pairs of samples in each group to show that there is a general agreement in terms of the counts in the peakset.

```
# plot scatters of samples from each group
par(mfrow = c(2,3))
lapply(split(colnames(se3), se3$stage), function(x) {
  # get counts of three samples
  y1 <- assay(se3)[, x[1]]
  y2 <- assay(se3)[, x[2]]
  y3 <- assay(se3)[, x[3]]

  # plot scatters of pairs of samples
  plot(log10(y1 + 1), log10(y2 + 1), xlab = x[1], ylab = x[2])
  plot(log10(y1 + 1), log10(y3 + 1), xlab = x[1], ylab = x[3])
  plot(log10(y2 + 1), log10(y3 + 1), xlab = x[2], ylab = x[3])
})
```

![](data:image/png;base64...)

```
#> $`0`
#> NULL
#>
#> $`1`
#> NULL
```

## Applying differential binding using `DESeq2`

[DESeq2](https://bioconductor.org/packages/release/bioc/html/DESeq2.html) is a well documented and widely used R package for the differential binding analysis of ChIP-Seq data. Here we use the default values of `DESeq` to find the peaks which are deferentially bound in stage 1 compared to 0.

```
# differential binding analysis
colData(se3) <- colData(se3)[, -2]
se3$stage <- factor(se3$stage)
dds <- DESeqDataSet(se3, ~stage)
#> renaming the first element in assays to 'counts'
#> converting counts to integer mode
dds <- DESeq(dds)
#> estimating size factors
#> estimating dispersions
#> gene-wise dispersion estimates
#> mean-dispersion relationship
#> final dispersion estimates
#> fitting model and testing
res <- results(dds)
table(res$padj < .1)
#>
#> FALSE  TRUE
#> 13297  1240
```

## Next!

In this example, we didn’t attempt to correct for the between study factors that might confound the results. To show how is this possible, we use the [PCA](https://en.wikipedia.org/wiki/Principal_component_analysis) plots with a few of these factors in the following graphs. The first uses the `stage` factor which is the factor of interest in this case. We see that the `DESeq` transformation did a good job separating the samples to their expected groups. However, it also seems that the `stage` is not the only factor in play. For example, we show in the second and the third graphs two other factors `library_layout` and `instrument_model` which might explain some of the variance between the samples. This is expected because the data were collected from different studies using slightly different protocols and different sequencing machines. Therefore, it is necessary to account for these differences to obtain reliable results. There are multiple methods to do that such as [Removing Unwanted Variation (RUV)](http://www-personal.umich.edu/~johanngb/ruv/) and [Surrogate Variable Analysis (SVA)](http://bioconductor.org/packages/release/bioc/html/sva.html).

```
# explaining variabce
plotPCA(rlog(dds), intgroup = 'stage')
#> using ntop=500 top features by variance
```

![](data:image/png;base64...)

```
plotPCA(rlog(dds), intgroup = 'study')
#> using ntop=500 top features by variance
```

![](data:image/png;base64...)

## Citing the studies in this subset of the data

Speaking of studies, as mentioned earlier the `studies` object contains full information of the references of the original studies in which the data were published. Please cite them when using this dataset.

```
# keys of the studies in this subset of the data
unique(se3$bibtexkey)
#> [1] "luo_parp-1_2017"          "siersbaek_extensive_2011"
```

# Citing `curatedAdipoChIP`

For citing the package use:

```
# citing the package
citation("curatedAdipoChIP")
#> To cite package 'curatedAdipoChIP' in publications use:
#>
#>   Ahmed M (2025). _curatedAdipoChIP: A Curated ChIP-Seq Dataset of
#>   MDI-induced Differentiated Adipocytes (3T3-L1)_.
#>   doi:10.18129/B9.bioc.curatedAdipoChIP
#>   <https://doi.org/10.18129/B9.bioc.curatedAdipoChIP>, R package
#>   version 1.26.0, <https://bioconductor.org/packages/curatedAdipoChIP>.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Manual{,
#>     title = {curatedAdipoChIP: A Curated ChIP-Seq Dataset of MDI-induced Differentiated Adipocytes
#> (3T3-L1)},
#>     author = {Mahmoud Ahmed},
#>     year = {2025},
#>     note = {R package version 1.26.0},
#>     url = {https://bioconductor.org/packages/curatedAdipoChIP},
#>     doi = {10.18129/B9.bioc.curatedAdipoChIP},
#>   }
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
#>  package              * version  date (UTC) lib source
#>  abind                  1.4-8    2024-09-12 [2] CRAN (R 4.5.1)
#>  AnnotationDbi          1.72.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationHub        * 4.0.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biobase              * 2.70.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocFileCache        * 3.0.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26  2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel           1.44.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocVersion            3.22.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.78.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0    2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1  2025-01-16 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4    2023-03-17 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0    2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0    2024-05-16 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5    2025-04-23 [2] CRAN (R 4.5.1)
#>  codetools              0.2-20   2024-03-31 [3] CRAN (R 4.5.1)
#>  crayon                 1.5.3    2024-06-20 [2] CRAN (R 4.5.1)
#>  curatedAdipoChIP     * 1.26.0   2025-11-04 [1] Bioconductor 3.22 (R 4.5.1)
#>  curl                   7.0.0    2025-08-19 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3    2024-06-02 [2] CRAN (R 4.5.1)
#>  dbplyr               * 2.5.1    2025-09-10 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  DESeq2               * 1.50.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  devtools               2.4.6    2025-10-03 [2] CRAN (R 4.5.1)
#>  dichromat              2.0-0.1  2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37   2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr                * 1.1.4    2023-11-17 [2] CRAN (R 4.5.1)
#>  ellipsis               0.3.2    2021-04-29 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5    2025-08-27 [2] CRAN (R 4.5.1)
#>  ExperimentHub        * 3.0.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  farver                 2.1.2    2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0    2024-05-15 [2] CRAN (R 4.5.1)
#>  fastqcr              * 0.1.3    2023-02-18 [2] CRAN (R 4.5.1)
#>  filelock               1.0.3    2023-12-11 [2] CRAN (R 4.5.1)
#>  fs                     1.6.6    2025-04-12 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4    2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges        * 1.62.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  ggplot2              * 4.0.0    2025-09-11 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0    2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6    2024-10-25 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1  2024-04-04 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7    2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2                  1.2.1    2025-07-22 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  jquerylib              0.1.4    2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0    2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.50.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50     2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling               0.4.3    2023-08-29 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7   2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle              1.0.4    2023-11-07 [2] CRAN (R 4.5.1)
#>  locfit                 1.5-9.12 2025-03-05 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4    2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4    2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0    2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1    2021-11-26 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1   2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgbuild               1.4.8    2025-05-26 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3    2019-09-22 [2] CRAN (R 4.5.1)
#>  pkgload                1.4.1    2025-09-23 [2] CRAN (R 4.5.1)
#>  png                    0.1-8    2022-11-29 [2] CRAN (R 4.5.1)
#>  purrr                  1.1.0    2025-07-10 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1    2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs               0.3.3    2021-01-31 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3    2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0    2025-07-02 [2] CRAN (R 4.5.1)
#>  remotes                2.5.0    2024-03-17 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6    2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30     2025-09-28 [2] CRAN (R 4.5.1)
#>  RSQLite                2.4.3    2025-08-20 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0    2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10   2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0    2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo              * 1.0.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo            1.2.3    2025-02-05 [2] CRAN (R 4.5.1)
#>  SparseArray            1.10.1   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  SummarizedExperiment * 1.40.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0    2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr                * 1.3.1    2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1    2024-03-11 [2] CRAN (R 4.5.1)
#>  usethis                3.2.1    2025-09-06 [2] CRAN (R 4.5.1)
#>  utf8                   1.2.6    2025-06-08 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5    2023-12-01 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2    2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.54     2025-10-30 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10   2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpwH0QKT/Rinst13f88545014a7
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```