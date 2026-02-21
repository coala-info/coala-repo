# Using curatedAdipoRNA

#### Mahmoud Ahmed

#### 2025-11-04

# Overview

In this document, we introduce the purpose of the `curatedAdipoRNA` package, its contents and its potential use cases. This package is a curated dataset of RNA-Seq samples. The samples are MDI-induced pre-phagocytes (3T3-L1) at different time points/stage of differentiation. The package document the data collection, pre-processing and processing. In addition to the documentation, the package contains the scripts that was used to generated the data in `inst/scripts/` and the final `RangedSummarizedExperiment` object in `data/`.

# Introduction

## What is `curatedAdipoRNA`?

It is an R package for documenting and distributing a curated dataset. The package doesn’t contain any R functions.

## What is contained in `curatedAdipoRNA`?

The package contains two different things:

1. Scripts for documenting/reproducing the data in `inst/scripts`
2. Final `RangedSummarizedExperiment` object in `data/`

## What is `curatedAdipoRNA` for?

The `RangedSummarizedExperiment` object contains the `adipo_counts`, `colData`, `rowRanges` and `metadata` which can be used for the purposes of conducting differential expression or gene set enrichment analysis on the cell line model.

# Installation

The `curatedAdipoRNA` package can be installed from Bioconductor using `BiocManager`.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("curatedAdipoRNA")
```

# Docker image

The pre-processing and processing of the data setup environment is available as a `docker` image. This image is also suitable for reproducing this document. The `docker` image can be obtained using the `docker` CLI client.

```
$ docker pull bcmslab/adiporeg_rna:latest
```

# Generating `curatedAdipoRNA`

## Search strategy & data collection

The term “3T3-L1” was used to search the NCBI **SRA** repository. The results were sent to the **run selector**. 1,176 runs were viewed. The runs were faceted by **Assay Type** and the “rna-seq” which resulted in 323 runs. Only 98 samples from 16 different studies were included after being manually reviewed to fit the following criteria: \* The raw data is available from GEO and has a GEO identifier (GSM#) \* The raw data is linked to a published publicly available article \* The protocols for generating the data sufficiently describe the origin of the cell line, the differentiation medium and the time points when the samples were collected. \* In case the experimental designs included treatment other than the differentiation medias, the control (non-treated) samples were included.

Note: The data quality and the platform discrepancies are not included in these criteria.

## Pre-processing

The scripts to download and process the raw data are located in `inst/scripts/` and are glued together to run sequentially by the GNU make file `Makefile`. The following is basically a description of the recipes in the `Makefile` with emphasis on the software versions, options, inputs and outputs.

### 1. Downloading data `download_fastq`

* Program: `wget` (1.18)
* Input: `run.csv`, the URLs column
* Output: `*.fastq.gz`
* Options: `-N`

### 2. Making a genome index `make_index`

* Program: `hisat2-build` (2.0.5)
* Input: URL for mm10 mouse genome fasta files
* Output: `*.bt2` bowtie2 index for the mouse genome
* Options: defaults

### 3. Dowinloading annotations `get_annotation`

* Program: `wget` (1.18)
* Input: URL for mm10 gene annotation file
* Output: `annotation.gtf`
* Options: `-N`

### 4. Aligning reads `align_reads`

* Program: `hisat2` (2.0.5)
* Input: `*.fastq.gz` and `mm10/` bowtie2 index for the mouse genome
* Output: `*.sam`
* Options: defaults

### 5. Counting features `count_features`

* Program: `featureCounts` (1.5.1)
* Input: `*.bam` and the annotation `gtf` file for the mm10 mouse genome.
* Output: `*.txt`
* Option: defaults

### Quality assessment `fastqc`

* Program: `fastqc` (0.11.5)
* Input: `*.fastq.gz` and `*.sam`
* Output: `*_fastqc.zip`
* Option: defaults

## Processing

The aim of this step is to construct a self-contained object with minimal manipulations of the pre-processed data followed by simple a simple exploration of the data in the next section.

### Making Summarized experiment object `make_object`

The required steps to make this object from the pre-processed data are documented in the script and are supposed to be fully reproducible when run through this package. The output is a `RangedSummarizedExperiment` object containing the gene counts and the phenotype and features data and metadata.

The `RangedSummarizedExperiment` contains \* The gene counts matrix `gene_counts` \* The phenotype data `colData` \* The feature data `rowRanges` \* The metadata `metadata` which contains a `data.frame` of the studies from which the samples were collected.

## Exploring the `adipo_counts` object

In this section, we conduct a simple exploration of the data objects to show the content of the package and how they can be loaded and used.

```
# loading required libraries
library(curatedAdipoRNA)
library(SummarizedExperiment)
library(S4Vectors)
library(fastqcr)
library(DESeq2)
library(dplyr)
library(tidyr)
library(ggplot2)
```

```
# load data
data("adipo_counts")

# print object
adipo_counts
#> class: RangedSummarizedExperiment
#> dim: 23916 98
#> metadata(1): studies
#> assays(1): gene_counts
#> rownames(23916): 0610005C13Rik 0610007P14Rik ... a l7Rn6
#> rowData names(1): gene_id
#> colnames(98): GSM1224676 GSM1224677 ... GSM873963 GSM873964
#> colData names(14): id study ... instrument_model qc
```

The count matrix can be accessed using `assay`. Here we show the first five entries of the first five samples.

```
# print count matrix
assay(adipo_counts)[1:5, 1:5]
#>               GSM1224676 GSM1224677 GSM1224678 GSM1224679 GSM1224680
#> 0610005C13Rik         45         36         66         76         19
#> 0610007P14Rik       7327       7899       4819       4140       4884
#> 0610009B22Rik       1576       1805       2074       1669       2443
#> 0610009L18Rik        198        161        236        172         51
#> 0610009O20Rik       4195       4713       4996       4663       4133
```

The phenotype/samples data is a `data.frame`, It can be accessed using `colData`. The `time` and `stage` columns encode the time point in hours and stage of differentiation respectively.

```
# names of the coldata object
names(colData(adipo_counts))
#>  [1] "id"               "study"            "pmid"             "time"
#>  [5] "stage"            "bibtexkey"        "run"              "submission"
#>  [9] "sample"           "experiment"       "study_name"       "library_layout"
#> [13] "instrument_model" "qc"

# table of times column
table(colData(adipo_counts)$time)
#>
#> -96 -48   0   1   2   4   6  10  24  28  48  96 120 144 168 192 240
#>   1   6  22   1   3   9   1   2   8   1  12   2   1   4  13   8   4

# table of stage column
table(colData(adipo_counts)$stage)
#>
#>  0  1  2  3
#> 29 35  4 30
```

Other columns in `colData` are selected information about the samples/runs or identifiers to different databases. The following table provides the description of each of these columns.

| col\_name | description |
| --- | --- |
| id | The GEO sample identifier. |
| study | The SRA study identifier. |
| pmid | The PubMed ID of the article where the data were published originally. |
| time | The time point of the sample when collected in hours. The time is recorded from the beginning of the protocol as 0 hours. |
| stage | The stage of differentiation of the sample when collected. Possible values are 0 to 3; 0 for non-differentiated; 1 for differentiating; and 2/3 for maturating samples. |
| bibtexkey | The key of the study where the data were published originally. This maps to the studies object of the metadata which records the study information in bibtex format. |
| run | The SRA run identifier. |
| submission | The SRA study submission identifier. |
| sample | The SRA sample identifier. |
| experiment | The SRA experiment identifier. |
| study\_name | The GEO study/series identifier. |
| library\_layout | The type of RNA library. Possible values are SINGLE for single-end and PAIRED for paired-end runs. |
| instrument\_model | The name of the sequencing machine that was used to obtain the sequence reads. |
| qc | The quality control output of fastqc on the separate files/runs. |
|  |  |

Using the identifiers in `colData` along with Bioconductor packages such as [`GEOmetabd`](http://bioconductor.org/packages/GEOmetadb/) and/or [`SRAdb`](http://bioconductor.org/packages/SRAdb/) gives access to the sample metadata as submitted by the authors or recorded in the data repositories.

The features data are a `GRanges` object and can be accessed using `rowRanges`.

```
# print GRanges object
rowRanges(adipo_counts)
#> GRanges object with 23916 ranges and 1 metadata column:
#>                 seqnames              ranges strand |       gene_id
#>                    <Rle>           <IRanges>  <Rle> |   <character>
#>   0610005C13Rik     chr7   45567795-45575176      - | 0610005C13Rik
#>   0610007P14Rik    chr12   85815455-85824545      - | 0610007P14Rik
#>   0610009B22Rik    chr11   51685385-51688634      - | 0610009B22Rik
#>   0610009L18Rik    chr11 120348678-120351190      + | 0610009L18Rik
#>   0610009O20Rik    chr18   38250249-38262629      + | 0610009O20Rik
#>             ...      ...                 ...    ... .           ...
#>             Zyx     chr6   42349828-42360213      + |           Zyx
#>           Zzef1    chr11   72796226-72927120      + |         Zzef1
#>            Zzz3     chr3 152396003-152462826      + |          Zzz3
#>               a     chr2 155013570-155051012      + |             a
#>           l7Rn6     chr7   89918685-89941204      - |         l7Rn6
#>   -------
#>   seqinfo: 35 sequences from an unspecified genome; no seqlengths
```

`qc` is a column of `colData` it is a list of lists. Each entry in the list correspond to one sample. Each sample has one or more objects of `qc_read` class. The reason for that is because paired-end samples has two separate files on which `fastqc` quality control were ran.

```
# show qc data
adipo_counts$qc
#> List of length 98
#> names(98): GSM1224676 GSM1224677 GSM1224678 ... GSM873962 GSM873963 GSM873964

# show the class of the first entry in qc
class(adipo_counts$qc[[1]][[1]])
#> [1] "list"    "qc_read"
```

The metadata is a list of one object. `studies` is a `data.frame` containing the bibliography information of the studies from which the data were collected. Here we show the first entry in `studies`.

```
# print data of first study
metadata(adipo_counts)$studies[1,]
#> # A tibble: 1 × 37
#>   CATEGORY BIBTEXKEY ADDRESS ANNOTE AUTHOR BOOKTITLE CHAPTER CROSSREF EDITION
#>   <chr>    <chr>     <chr>   <chr>  <list> <chr>     <chr>   <chr>    <chr>
#> 1 ARTICLE  Brier2017 <NA>    <NA>   <chr>  <NA>      <NA>    <NA>     <NA>
#> # ℹ 28 more variables: EDITOR <list>, HOWPUBLISHED <chr>, INSTITUTION <chr>,
#> #   JOURNAL <chr>, KEY <chr>, MONTH <chr>, NOTE <chr>, NUMBER <chr>,
#> #   ORGANIZATION <chr>, PAGES <chr>, PUBLISHER <chr>, SCHOOL <chr>,
#> #   SERIES <chr>, TITLE <chr>, TYPE <chr>, VOLUME <chr>, YEAR <dbl>,
#> #   ABSTRACT <chr>, ARCHIVEPREFIX <chr>, ARXIVID <chr>, DOI <chr>,
#> #   EPRINT <chr>, ISBN <chr>, ISSN <chr>, PMID <chr>, FILE <lgl>,
#> #   KEYWORDS <chr>, URL <chr>
```

# Summary of the studies in the dataset

| GEO series ID | PubMed ID | Num. of Samples | Time (hr) | Differentiation Stage | Instrument Model |
| --- | --- | --- | --- | --- | --- |
| GSE100056 | 29138456 | 4 | -48/24 | 0/1 | Ion Torrent Proton |
| GSE104508 | 29091029 | 3 | 192 | 3 | NextSeq 500 |
| GSE35724 | 24095730 | 3 | 192 | 3 | Illumina Genome Analyzer II |
| GSE50612 | 25614607 | 8 | -48/0/10/144 | 0/1/3 | Illumina HiSeq 2000 |
| GSE50934 | 24912735 | 6 | 0/168 | 0/3 | Illumina HiSeq 2000 |
| GSE53244 | 25412662 | 5 | -48/0/48/120/240 | 0/1/3 | Illumina HiSeq 2000 |
| GSE57415 | 24857666 | 4 | 0/4 | 0/1 | Illumina HiSeq 1500 |
| GSE60745 | 26220403 | 12 | 0/24/48 | 0/1 | Illumina HiSeq 2500 |
| GSE64757 | 25596527 | 6 | 168 | 3 | Illumina HiSeq 2000 |
| GSE75639 | 27923061 | 6 | -96/-48/0/6/48/168 | 0/1/3 | Illumina HiSeq 2000 |
| GSE84410 | 27899593 | 6 | 0/4/48/28 | 0/1 | Illumina HiSeq 1500 |
| GSE87113 | 27777310 | 6 | 0/1/2/4/48/168 | 0/1/3 | Illumina HiSeq 2500 |
| GSE89621 | 28009298 | 3 | 240 | 3 | Illumina HiSeq 2500 |
| GSE95029 | 29317436 | 10 | 0/48/96/144/192 | 0/1/2/3 | Illumina HiSeq 2000 |
| GSE95533 | 28475875 | 10 | 4/0/24/48/168 | 1/0/3 | Illumina HiSeq 1500 |
| GSE96764 | 29748257 | 6 | 0/2/4 | 0/1/2 | Illumina HiSeq 2000 |

# Example of using `curatedAdipoRNA`

## Motivation

All the samples in this dataset come from the [3T3-L1](https://en.wikipedia.org/wiki/3T3-L1) cell line. The [MDI](http://www.protocol-online.org/prot/Protocols/In-Vitro-Adipocytes-Differentiation-4789.html) induction media, were used to induce adipocyte differentiation. The two important variables in the dataset are `time` and `stage`, which correspond to the time point and stage of differentiation when the sample were captured. Ideally, this dataset should be treated as a time course. However, for the purposes of this example, we only used samples from two time points 0 and 24 hours and treated them as independent groups. The goal of this example is to show how a typical differential expression analysis can be applied in the dataset. The main focus is to explain how the the data and metadata in `adipo_counts` fit in each main piece of the analysis. We started by filtering the low quality samples and low count genes. Then we applied the `DESeq2` method with the default values.

## Filtering low quality samples

First, we subset the `adipo_counts` object to all samples that has time points 0 or 24. The total number of samples is 30; 22 at 0 hour and 8 samples at 24 hours. The total number of features/genes in the set is 23916.

```
# subsetting counts to 0 and 24 hours
se <- adipo_counts[, adipo_counts$time %in% c(0, 24)]

# showing the numbers of features, samples and time groups
dim(se)
#> [1] 23916    30
table(se$time)
#>
#>  0 24
#> 22  8
```

Since the quality metrics are reported per run file, we need to get the SSR\* id for each of the samples. Notice that, some samples would have more than one file. In this case because some of the samples are paired-end, so each of them would have two files `SRR\*_1` and `SRR\*_2`.

```
# filtering low quality samples
# chek the library layout
table(se$library_layout)
#>
#> PAIRED SINGLE
#>     12     18

# check the number of files in qc
qc <- se$qc
table(lengths(qc))
#>
#>  1  2
#> 18 12

# flattening qc list
qc <- unlist(qc, recursive = FALSE)
length(qc)
#> [1] 42
```

The `qc` object of the `colData` contains the output of [fastqc](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) in a `qc_read` class. More information on this object can be accessed by calling `?fastqcr::qc_read`. Here, we only use the `per_base_sequence_quality` to filter out low quality samples. This is by no means enough quality control but it should drive the point home.

```
# extracting per_base_sequence_quality
per_base <- lapply(qc, function(x) {
  df <- x[['per_base_sequence_quality']]
  df %>%
    select(Base, Mean) %>%
    transform(Base = strsplit(as.character(Base), '-')) %>%
    unnest(Base) %>%
    mutate(Base = as.numeric(Base))
}) %>%
  bind_rows(.id = 'run')
```

After tidying the data, we get a `data.frame` with three columns; `run`, `Mean` and `Base` for the run ID, the mean quality score and the base number in each read. [fastqc](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) provide thorough documentation of this quality control module and others. Notice that read length varies significantly between the runs and that the average of the mean score is suitable.

```
# a quick look at quality scores
summary(per_base)
#>      run                 Base             Mean
#>  Length:3408        Min.   :  1.00   Min.   :10.74
#>  Class :character   1st Qu.: 21.00   1st Qu.:34.45
#>  Mode  :character   Median : 42.00   Median :36.44
#>                     Mean   : 50.24   Mean   :35.28
#>                     3rd Qu.: 70.00   3rd Qu.:37.90
#>                     Max.   :368.00   Max.   :40.17
```

To identify the low quality samples, we categorize the runs by `length` and `run_average` which are the read length and the average of the per base mean scores. The following figure should make it easier to see why these cutoff were used in this case.

```
# find low quality runs
per_base <- per_base %>%
  group_by(run) %>%
  mutate(length = max(Base) > 150,
         run_average = mean(Mean) > 34)

# plot average per base quality
per_base %>%
  ggplot(aes(x = Base, y = Mean, group = run, color = run_average)) +
  geom_line() +
  facet_wrap(~length, scales = 'free_x')
```

![](data:image/png;base64...)

The run IDs of the “bad” samples is then used to remove them from the dataset.

```
# get run ids of low quality samples
bad_samples <- data.frame(samples = unique(per_base$run[per_base$run_average == FALSE]))
bad_samples <- separate(bad_samples, col = samples, into = c('id', 'run'), sep = '\\.')

# subset the counts object
se2 <- se[, !se$id %in% bad_samples$id]
table(se2$time)
#>
#>  0 24
#> 19  6
```

## Filtering low count genes

To identify the low count feature/genes (possibly not expressed), we keep only the features with at least 10 reads in 2 or more samples. Then we subset the object to exclude these genes.

```
# filtering low count genes
low_counts <- apply(assay(se2), 1, function(x) length(x[x>10])>=2)
table(low_counts)
#> low_counts
#> FALSE  TRUE
#> 10254 13662

# subsetting the count object
se3 <- se2[low_counts,]
```

## Applying differential expression using `DESeq2`

[DESeq2](https://bioconductor.org/packages/release/bioc/html/DESeq2.html) is a well documented and widely used R package for the differential expression analysis. Here we use the default values of `DESeq` to find the genes which are deferentially expressed between the samples at 24 hours and 0 hours.

```
# differential expression analysis
se3$time <- factor(se3$time)
dds <- DESeqDataSet(se3, ~time)
#> renaming the first element in assays to 'counts'
#> converting counts to integer mode
dds <- DESeq(dds)
#> estimating size factors
#> estimating dispersions
#> gene-wise dispersion estimates
#> mean-dispersion relationship
#> final dispersion estimates
#> fitting model and testing
#> -- replacing outliers and refitting for 53 genes
#> -- DESeq argument 'minReplicatesForReplace' = 7
#> -- original counts are preserved in counts(dds)
#> estimating dispersions
#> fitting model and testing
res <- results(dds)
table(res$padj < .1)
#>
#> FALSE  TRUE
#>  6194  7462
```

## Next!

In this example, we didn’t attempt to correct for the between study factors that might confound the results. To show how is this possible, we use the [PCA](https://en.wikipedia.org/wiki/Principal_component_analysis) plots with a few of these factors in the following graphs. The first uses the `time` factor which is the factor of interest in this case. We see that the `DESeq` transformation did a good job separating the samples to their expected groups. However, it also seems that the `time` is not the only factor in play. For example, we show in the second and the third graphs two other factors `library_layout` and `instrument_model` which might explain some of the variance between the samples. This is expected because the data were collected from different studies using slightly different protocols and different sequencing machines. Therefore, it is necessary to account for these differences to obtain reliable results. There are multiple methods to do that such as [Removing Unwanted Variation (RUV)](http://www-personal.umich.edu/~johanngb/ruv/) and [Surrogate Variable Analysis (SVA)](http://bioconductor.org/packages/release/bioc/html/sva.html).

```
# explaining variabce
plotPCA(rlog(dds), intgroup = 'time')
#> using ntop=500 top features by variance
```

![](data:image/png;base64...)

```
plotPCA(rlog(dds), intgroup = 'library_layout')
#> using ntop=500 top features by variance
```

![](data:image/png;base64...)

```
plotPCA(rlog(dds), intgroup = 'instrument_model')
#> using ntop=500 top features by variance
```

![](data:image/png;base64...)

## Citing the studies in this subset of the data

Speaking of studies, as mentioned earlier the `studies` object contains full information of the references of the original studies in which the data were published. Please cite them when using this dataset.

```
# keys of the studies in this subset of the data
unique(se3$bibtexkey)
#>  [1] "Duteil2014"                "zhao_fto-dependent_2014"
#>  [3] "siersbaek_molecular_2014"  "Lim2015"
#>  [5] "brunmeir_comparative_2016" "Brier2017"
#>  [7] "park_distinct_2017"        "chen_diabetes_2018"
#>  [9] "siersbaek_dynamic_2017"    "ryu_metabolic_2018"
```

# Citing `curatedAdipoRNA`

For citing the package use:

```
# citing the package
citation("curatedAdipoRNA")
#> To cite package 'curatedAdipoRNA' in publications use:
#>
#>   Ahmed M (2025). _curatedAdipoRNA: A Curated RNA-Seq Dataset of
#>   MDI-induced Differentiated Adipocytes (3T3-L1)_.
#>   doi:10.18129/B9.bioc.curatedAdipoRNA
#>   <https://doi.org/10.18129/B9.bioc.curatedAdipoRNA>, R package version
#>   1.26.0, <https://bioconductor.org/packages/curatedAdipoRNA>.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Manual{,
#>     title = {curatedAdipoRNA: A Curated RNA-Seq Dataset of MDI-induced Differentiated Adipocytes
#> (3T3-L1)},
#>     author = {Mahmoud Ahmed},
#>     year = {2025},
#>     note = {R package version 1.26.0},
#>     url = {https://bioconductor.org/packages/curatedAdipoRNA},
#>     doi = {10.18129/B9.bioc.curatedAdipoRNA},
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
#>  Biobase              * 2.70.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocParallel           1.44.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  bslib                  0.9.0    2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0    2024-05-16 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5    2025-04-23 [2] CRAN (R 4.5.1)
#>  codetools              0.2-20   2024-03-31 [3] CRAN (R 4.5.1)
#>  curatedAdipoRNA      * 1.26.0   2025-11-04 [1] Bioconductor 3.22 (R 4.5.1)
#>  DelayedArray           0.36.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  DESeq2               * 1.50.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  devtools               2.4.6    2025-10-03 [2] CRAN (R 4.5.1)
#>  dichromat              2.0-0.1  2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37   2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr                * 1.1.4    2023-11-17 [2] CRAN (R 4.5.1)
#>  ellipsis               0.3.2    2021-04-29 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5    2025-08-27 [2] CRAN (R 4.5.1)
#>  farver                 2.1.2    2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0    2024-05-15 [2] CRAN (R 4.5.1)
#>  fastqcr              * 0.1.3    2023-02-18 [2] CRAN (R 4.5.1)
#>  fs                     1.6.6    2025-04-12 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4    2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges        * 1.62.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  ggplot2              * 4.0.0    2025-09-11 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0    2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6    2024-10-25 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1  2024-04-04 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0   2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  jquerylib              0.1.4    2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0    2025-03-27 [2] CRAN (R 4.5.1)
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
#>  purrr                  1.1.0    2025-07-10 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1    2025-02-15 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3    2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0    2025-07-02 [2] CRAN (R 4.5.1)
#>  remotes                2.5.0    2024-03-17 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6    2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30     2025-09-28 [2] CRAN (R 4.5.1)
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
#>  [1] /tmp/RtmpoVnl3t/Rinst13fa9522634d9
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```