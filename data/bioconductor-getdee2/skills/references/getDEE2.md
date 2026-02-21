# getDEE2: Programmatic access to the DEE2 RNA expression dataset

#### Mark Ziemann & Antony Kaspi

#### 2025-10-30

* [Background](#background)
* [Getting started](#getting-started)
* [Searching for datasets of interest starting with accession numbers](#searching-for-datasets-of-interest-starting-with-accession-numbers)
* [Fetching DEE2 data using SRA run accession numbers](#fetching-dee2-data-using-sra-run-accession-numbers)
* [Downstream analysis](#downstream-analysis)
* [Legacy function](#legacy-function)
* [Large project bundles](#large-project-bundles)
* [Session Info](#session-info)

## Background

Digital Expression Explorer 2 (or DEE2 for short) is a repository of processed RNA-seq data in the form of counts. It was designed so that researchers could undertake re-analysis and meta-analysis of published RNA-seq studies quickly and easily. As of April 2020, over 1 million SRA runs have been processed.

For further information about the resource, refer to the [journal article](https://doi.org/10.1093/gigascience/giz022) and [project homepage](http://dee2.io).

This package provides an interface to access these expression data programmatically.

## Getting started

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("getDEE2")
```

```
library("getDEE2")
```

## Searching for datasets of interest starting with accession numbers

The first step is to download the list of accession numbers of available datasets with the `getDEE2Metadata` function, specifying a species name. options for species currently are:

| Scientific name | Common name | DEE2 name | Organism group |
| --- | --- | --- | --- |
| *Caenorhabditis elegans* | Roundworm | celegans | animals |
| *Drosophila melanogaster* | Fruitfly | dmelanogaster | animals |
| *Danio rerio* | Zebrafish | drerio | animals |
| *Homo sapiens* | Human | hsapiens | animals |
| *Mus musculus* | Mouse | mmusculus | animals |
| *Rattus norvegicus* | Rat | rnorvegicus | animals |
| *Arabidopsis thaliana* | Thale cress | athaliana | plants |
| *Brachypodium distachyon* | Purple false brome (grass) | bdistachyon | plants |
| *Glycine max* | Soybean | gmax | plants |
| *Hordeum vulgare* | Barley | hvulgare | plants |
| *Oryza sativa* | Rice | osativa | plants |
| *Populus trichocarpa* | Black cottonwood tree | ptrichocarpa | plants |
| *Sorghum bicolor* | Sorghum | sbicolor | plants |
| *Solanum lycopersicum* | Tomato | slycopersicum | plants |
| *Solanum tuberosum* | Potato | stuberosum | plants |
| *Triticum aestivum* | Wheat | taestivum | plants |
| *Vitis vinifera* | Grapevine | vvinifera | plants |
| *Escherichia coli* | E. coli | ecoli | microbes |
| *Saccharomyces cerevisiae* | Yeast | scerevisiae | microbes |

If the species name is incorrect, an error will be thrown.

```
mdat <- getDEE2Metadata("celegans")
head(mdat)
```

```
##   SRR_accession  QC_summary SRX_accession SRS_accession SRP_accession
## 1     DRR003389   WARN(2,6)     DRX002713     DRS002797     DRP000898
## 2     DRR003390 WARN(2,6,7)     DRX002714     DRS002798     DRP000898
## 3     DRR024071   WARN(5,7)     DRX021821     DRS023187     DRP002871
## 4     DRR024072   WARN(5,7)     DRX021822     DRS002797     DRP002871
## 5     DRR031524   FAIL(3,6)     DRX028492     DRS092197     DRP004944
## 6     DRR031525   FAIL(3,6)     DRX028493     DRS092198     DRP004944
##                                          Experiment_title GEO_series
## 1                                     KH1668:smg-2(yb979)
## 2                     KH1857:smg-2(yb979) unc-75 (yb1701)
## 3 Illumina Genome Analyzer IIx sequencing of SAMD00021020
## 4 Illumina Genome Analyzer IIx sequencing of SAMD00015748
## 5          Illumina HiSeq 2500 sequencing of SAMD00027920
## 6          Illumina HiSeq 2500 sequencing of SAMD00027921
```

If you have a SRA project accession number in mind already (eg: SRP009256) then we can see if the datasets are present.

```
mdat[which(mdat$SRP_accession %in% "SRP009256"),]
```

```
##       SRR_accession      QC_summary SRX_accession SRS_accession SRP_accession
## 15319     SRR363796 FAIL(2,3,4,6,7)     SRX105188     SRS270025     SRP009256
## 15320     SRR363797   FAIL(3,4,6,7)     SRX105189     SRS270026     SRP009256
## 15321     SRR363798 FAIL(2,3,4,6,7)     SRX105190     SRS270027     SRP009256
## 15322     SRR363799   FAIL(3,4,6,7)     SRX105191     SRS270028     SRP009256
##                    Experiment_title GEO_series
## 15319 GSM829554: 4SU_GLD1_PARCLIP_1   GSE33543
## 15320 GSM829555: 4SU_GLD1_PARCLIP_2   GSE33543
## 15321 GSM829556: 4SU_GLD1_PARCLIP_3   GSE33543
## 15322 GSM829557: 6SG_GLD1_PARCLIP_1   GSE33543
```

DEE2 data is centred around SRA run accessions numbers, these SRR\_accessions can be obtained like this:

```
mdat1 <- mdat[which(mdat$SRP_accession %in% "SRP009256"),]
SRRvec <- as.vector(mdat1$SRR_accession)
SRRvec
```

```
## [1] "SRR363796" "SRR363797" "SRR363798" "SRR363799"
```

## Fetching DEE2 data using SRA run accession numbers

The general syntax for obtaining DEE2 data is this:

`getDEE2(species,SRRvec,metadata,outfile="NULL",counts="GeneCounts")`

First, the function queries the metadata to make sure that the requested datasets are present. If metadata is not specified, then it will download a ‘fresh’ copy of the metadata. It then fetches the requested expression data and constructs a [SummarizedExperiment object](http://bioconductor.org/packages/SummarizedExperiment). The ‘counts’ parameter controls the type of counts provided:

* `GeneCounts` STAR gene level counts (this is the default)
* `TxCounts` Kallisto transcript level counts
* `Tx2Gene` transcript counts aggregated (sum) to the gene level.

If ‘outfile’ is defined, then files will be downloaded to the specified path. If it is not defined, then the files are downloaded to a temporary directory and deleted immediately after use.

The SRR numbers need to exactly match those in SRA.

Here is an example of using the SRR vector as defined above.

```
suppressPackageStartupMessages(library("SummarizedExperiment"))
x <- getDEE2("celegans",SRRvec,metadata=mdat,counts="GeneCounts")
```

```
## For more information about DEE2 QC metrics, visit
##     https://github.com/markziemann/dee2/blob/master/qc/qc_metrics.md
```

```
x
```

```
## class: SummarizedExperiment
## dim: 46739 4
## metadata(0):
## assays(1): counts
## rownames(46739): WBGene00197333 WBGene00198386 ... WBGene00010967
##   WBGene00014473
## rowData names(0):
## colnames(4): SRR363796 SRR363797 SRR363798 SRR363799
## colData names(50): QC_summary SRX_accession ... Kallisto_MapRate
##   QC_SUMMARY
```

```
# show sample level metadata
colData(x)[1:7]
```

```
## DataFrame with 4 rows and 7 columns
##                QC_summary SRX_accession SRS_accession SRP_accession
##               <character>   <character>   <character>   <character>
## SRR363796 FAIL(2,3,4,6,7)     SRX105188     SRS270025     SRP009256
## SRR363797   FAIL(3,4,6,7)     SRX105189     SRS270026     SRP009256
## SRR363798 FAIL(2,3,4,6,7)     SRX105190     SRS270027     SRP009256
## SRR363799   FAIL(3,4,6,7)     SRX105191     SRS270028     SRP009256
##                 Experiment_title  GEO_series sample_alias
##                      <character> <character>  <character>
## SRR363796 GSM829554: 4SU_GLD1_..    GSE33543    GSM829554
## SRR363797 GSM829555: 4SU_GLD1_..    GSE33543    GSM829555
## SRR363798 GSM829556: 4SU_GLD1_..    GSE33543    GSM829556
## SRR363799 GSM829557: 6SG_GLD1_..    GSE33543    GSM829557
```

```
# show the counts
head(assays(x)$counts)
```

```
##                SRR363796 SRR363797 SRR363798 SRR363799
## WBGene00197333         0         0         0         0
## WBGene00198386         0         0         0         0
## WBGene00015153         4        16         6         4
## WBGene00002061        44       100       217        77
## WBGene00255704         0         5         1         1
## WBGene00235314         0         0         0         1
```

You can directly specify the SRR accessions in the command line, but be sure to type them correctly. In case SRR accessions are not present in the database, there will be a warning message.

```
x <- getDEE2("celegans",c("SRR363798","SRR363799","SRR3581689","SRR3581692"),
    metadata=mdat,counts="GeneCounts")
```

```
## For more information about DEE2 QC metrics, visit
##     https://github.com/markziemann/dee2/blob/master/qc/qc_metrics.md
```

```
## Warning, datasets not found: 'SRR3581689,SRR3581692'
```

In this case the accessions SRR3581689 and SRR3581692 are *A. thaliana* accessions and therefore not present in the *C. elegans* accession list.

## Downstream analysis

DEE2 data are perfectly suitable for downstream analysis with [edgeR](https://bioconductor.org/packages/edgeR/), [DESeq2](https://bioconductor.org/packages/DESeq2/), and many other gene expression and pathway enrichment tools. For more information about working with SummarizedExperiment refer to the [rnaseqGene package](https://bioconductor.org/packages/rnaseqGene/) which describes a workflow for differential gene expression of SummarizedExperiment objects.

## Legacy function

The function to obtain DEE2 in the legacy format is provided for completeness but is no longer recommended. It gives DEE2 data in the form of a list object with slots for gene counts, transcript counts, gene length, transcript length, quality control data, sample metadata summary, sample metadata (full) and any absent datasets.

```
x <- getDEE2("celegans",SRRvec,metadata=mdat,legacy=TRUE)
```

```
## For more information about DEE2 QC metrics, visit
##     https://github.com/markziemann/dee2/blob/master/qc/qc_metrics.md
```

```
names(x)
```

```
## [1] "GeneCounts"      "TxCounts"        "GeneInfo"        "TxInfo"
## [5] "QcMx"            "MetadataSummary" "MetadataFull"    "absent"
```

```
head(x$GeneCounts)
```

```
##                SRR363796 SRR363797 SRR363798 SRR363799
## WBGene00197333         0         0         0         0
## WBGene00198386         0         0         0         0
## WBGene00015153         4        16         6         4
## WBGene00002061        44       100       217        77
## WBGene00255704         0         5         1         1
## WBGene00235314         0         0         0         1
```

```
head(x$TxCounts)
```

```
##            SRR363796 SRR363797 SRR363798 SRR363799
## Y110A7A.10        11        23        48        45
## F27C8.1            0         0         0         0
## F07C3.7            0         2         0        21
## F52H2.2a           0         0         7         0
## F52H2.2b           0         4         0         5
## T13A10.10a         0         0         0         0
```

```
head(x$QcMx)
```

```
##                             SRR363796          SRR363797          SRR363798
## SequenceFormat                     SE                 SE                 SE
## QualityEncoding    Sanger/Illumina1.9 Sanger/Illumina1.9 Sanger/Illumina1.9
## Read1MinimumLength                 36                 36                 36
## Read1MedianLength                  36                 36                 36
## Read1MaxLength                     36                 36                 36
## Read2MinimumLength               NULL               NULL               NULL
##                             SRR363799
## SequenceFormat                     SE
## QualityEncoding    Sanger/Illumina1.9
## Read1MinimumLength                 36
## Read1MedianLength                  36
## Read1MaxLength                     36
## Read2MinimumLength               NULL
```

```
head(x$GeneInfo)
```

```
##                GeneSymbol mean median longest_isoform merged
## WBGene00197333   cTel3X.2  150    150             150    150
## WBGene00198386   cTel3X.3  150    150             150    150
## WBGene00015153    B0348.5  988    988            1178   1178
## WBGene00002061      ife-3 1024   1023            1107   1107
## WBGene00255704   B0348.10  363    363             363    363
## WBGene00235314    B0348.9  220    220             220    220
```

```
head(x$TxInfo)
```

```
##                    GeneID GeneSymbol TxLength
## Y110A7A.10 WBGene00000001      aap-1     1787
## F27C8.1    WBGene00000002      aat-1     1940
## F07C3.7    WBGene00000003      aat-2     1728
## F52H2.2a   WBGene00000004      aat-3     1739
## F52H2.2b   WBGene00000004      aat-3     1840
## T13A10.10a WBGene00000005      aat-4     1734
```

## Large project bundles

The DEE2 webpage has processed many projects containing dozens to thousands of runs ([available here](http://dee2.io/huge)). These large project datasets are easiest to access with the “bundles” functionality described here. The three functions are:

1. `list_bundles` downloads a list of available bundles for a species
2. `query_bundles` checks whether a particular SRA project or GEO series accession number is available
3. `getDEE2_bundle` fetches the expression data for a particular accession and loads it as a SummarizedExperiment object

In this first example, we search for a dataset with SRA project accession number SRP058781 and load the gene level counts.

```
bundles <- list_bundles("athaliana")
head(bundles)
```

```
##          file_name date_added time_added file_size SRP_accession GSE_accession
## 1 DRP001761_NA.zip 2023-02-21      04:05      3.2M     DRP001761            NA
## 2 DRP002301_NA.zip 2023-02-21      04:05      2.2M     DRP002301            NA
## 3 DRP003066_NA.zip 2023-02-21      04:05      1.8M     DRP003066            NA
## 4 DRP003416_NA.zip 2023-02-21      04:05      3.5M     DRP003416            NA
## 5 DRP003686_NA.zip 2023-02-21      04:05      5.1M     DRP003686            NA
## 6 DRP003759_NA.zip 2023-02-21      04:05      2.4M     DRP003759            NA
```

```
query_bundles(species="athaliana",query="SRP058781",
    col="SRP_accession",bundles=bundles)
```

```
## $present
## [1] "SRP058781"
##
## $absent
## character(0)
```

```
x <- getDEE2_bundle("athaliana", "SRP058781",
    col="SRP_accession",counts="GeneCounts")
```

```
## For more information about DEE2 QC metrics, visit
##     https://github.com/markziemann/dee2/blob/master/qc/qc_metrics.md
```

```
    assays(x)$counts[1:6,1:4]
```

```
##           SRR2042819 SRR2042820 SRR2042821 SRR2042822
## AT1G01010         26         47        101         97
## AT1G01020        115        105        187        130
## AT1G03987          0          0          1          2
## AT1G01030         22         32         38         30
## AT1G01040        628        591       1227        890
## AT1G03993          0          0          0          0
```

Similarly, it is possible to search with GEO series numbers, as in the next example.

```
x <- getDEE2_bundle("drerio", "GSE106677",
    col="GSE_accession",counts="GeneCounts")
```

```
## For more information about DEE2 QC metrics, visit
##     https://github.com/markziemann/dee2/blob/master/qc/qc_metrics.md
```

```
    assays(x)$counts[1:6,1:4]
```

```
##                    SRR6268134 SRR6268135 SRR6268136 SRR6268137
## ENSDARG00000104632          0          0          0          0
## ENSDARG00000100660         51         41         36         38
## ENSDARG00000098417          0          0          0          0
## ENSDARG00000100422         11          5          4          9
## ENSDARG00000102128          0          0          0          0
## ENSDARG00000103095          0          0          0          0
```

## Session Info

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
##  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [5] IRanges_2.44.0              S4Vectors_0.48.0
##  [7] BiocGenerics_0.56.0         generics_0.1.4
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] getDEE2_1.20.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] xfun_0.53           DelayedArray_0.36.0 jsonlite_2.0.0
##  [7] htmltools_0.5.8.1   sass_0.4.10         rmarkdown_2.30
## [10] grid_4.5.1          abind_1.4-8         evaluate_1.0.5
## [13] jquerylib_0.1.4     fastmap_1.2.0       yaml_2.3.10
## [16] lifecycle_1.0.4     compiler_4.5.1      XVector_0.50.0
## [19] lattice_0.22-7      digest_0.6.37       R6_2.6.1
## [22] SparseArray_1.10.0  htm2txt_2.2.2       Matrix_1.7-4
## [25] bslib_0.9.0         tools_4.5.1         S4Arrays_1.10.0
## [28] cachem_1.1.0
```