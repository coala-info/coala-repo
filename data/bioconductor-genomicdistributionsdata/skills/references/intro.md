# Getting started with GenomicDistributionsData

Jose Verdezoto

#### 2025-11-04

# Contents

* [1 Introduction to GenomicDistributionsData](#introduction-to-genomicdistributionsdata)
  + [1.1 Load GenomicDistributionsData and ExperimentHub](#load-genomicdistributionsdata-and-experimenthub)
  + [1.2 Create an ExperimentHub object and inspect the data](#create-an-experimenthub-object-and-inspect-the-data)
  + [1.3 Chromosome Sizes](#chromosome-sizes)
  + [1.4 Transcription Start Sites (TSS)](#transcription-start-sites-tss)
  + [1.5 Gene Models](#gene-models)
  + [1.6 Open Signal Matrices](#open-signal-matrices)
  + [1.7 Access data using file named functions](#access-data-using-file-named-functions)

# 1 Introduction to GenomicDistributionsData

GenomicDistributionsData is the associated data package for GenomicDistributions. Using GenomicDistributionsData, we can generate information about chromosome sizes, Transcription Start Sites (TSS), gene models (exons, introns, etc.) for 4 different genome assemblies: **hg19, hg38, mm9 and mm10**. These datasets can then be used as input for the main functions in the GenomicDistributions Package. Additionally, GenomicDistributionsData generates open chromatin signal matrices used for calculating the tissue specificity of a set of genomic ranges (currently for hg19, hg38 and mm10).

In this vignette we’ll go over the steps to access the **hg38** data files using the *ExperimentHub* interface.

## 1.1 Load GenomicDistributionsData and ExperimentHub

Start by loading up GenomicDistributionsData and the ExperimentHub packages:

```
library(GenomicDistributionsData)
library(ExperimentHub)
```

## 1.2 Create an ExperimentHub object and inspect the data

```
hub = ExperimentHub()
query(hub, "GenomicDistributionsData")
```

```
## ExperimentHub with 15 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Ensdb
## # $species: Homo sapiens, Mus musculus
## # $rdataclass: list with 4 GRanges, Int, GRanges, data.frame, data.table
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH3472"]]'
##
##            title
##   EH3472 | chromSizes_hg19
##   EH3473 | chromSizes_hg38
##   EH3474 | chromSizes_mm9
##   EH3475 | chromSizes_mm10
##   EH3476 | TSS_hg19
##   ...      ...
##   EH3482 | geneModels_mm9
##   EH3483 | geneModels_mm10
##   EH3484 | openSignalMatrix_hg19
##   EH3485 | openSignalMatrix_hg38
##   EH3768 | openSignalMatrix_mm10
```

For details on data sources and the functions used to build the data files, see `?GenomicDistributionsData`
and the scripts:

* `inst/scripts/make-metadata.R`
* `R/utils.R`
* `R/build.R`

## 1.3 Chromosome Sizes

Cromosome lengths are used as input for Chromosome distribution plots in GenomicDistributions. In order to get the chromosome lengths for the hg38 genome reference, we simply need to use the ExperimentHub identifier or pass the assembly string to the **buildChromSizes()** function:

```
# Retrieve the chrom sizes file
c = hub[["EH3473"]]
head(c)
```

```
##      chr1      chr2      chr3      chr4      chr5      chr6
## 248956422 242193529 198295559 190214555 181538259 170805979
```

We can also access each file and its respective metadata using the following alternate approach:

```
# Access the chrom sizes file and inspect its metadata
chromSizes = query(hub, c("GenomicDistributionsData", "chromSizes_hg38"))
chromSizes
```

```
## ExperimentHub with 1 record
## # snapshotDate(): 2025-10-29
## # names(): EH3473
## # package(): GenomicDistributionsData
## # $dataprovider: Ensdb
## # $species: Homo sapiens
## # $rdataclass: Int
## # $rdatadateadded: 2020-06-26
## # $title: chromSizes_hg38
## # $description: A dataset containing chromosome sizes for the Homo sapiens h...
## # $taxonomyid: 9606
## # $genome: hg38
## # $sourcetype: UCSC track
## # $sourceurl: https://bioconductor.org/packages/release/data/annotation/html...
## # $sourcesize: NA
## # $tags: c("ExperimentHub", "ExperimentData", "Genome")
## # retrieve record with 'object[["EH3473"]]'
```

```
# Retrieve the chromosome sizes file from ExperimentHub
c2 = chromSizes[[1]]
```

## 1.4 Transcription Start Sites (TSS)

Similarly, if we wish to get the location of the TSS of the hg38 genome assembly (used to calculate distances of genomic regions to these features), we just need to pass the appropriate ExperimentHub identifier or assembly string to the **buildTSS()** function:

```
TSS = hub[["EH3477"]]
TSS[1:3, "symbol"]
```

```
## GRanges object with 3 ranges and 1 metadata column:
##                   seqnames        ranges strand |      symbol
##                      <Rle>     <IRanges>  <Rle> | <character>
##   ENSG00000186092     chr1   69090-69091      + |       OR4F5
##   ENSG00000279928     chr1 182392-182393      + |  FO538757.2
##   ENSG00000279457     chr1 200322-200323      - |  FO538757.1
##   -------
##   seqinfo: 287 sequences from GRCh38 genome
```

## 1.5 Gene Models

GenomicDistributionsData can build gene models, which point the location of features such as genes, exons, 3 and 5 UTRs. This information can then be used by GenomicDistributions to calculate the distribution of regions across genome annotation classes. As in the previous cases, we need to pass the ExperimentHub identifier or build them using the **buildGeneModels()** function with the proper assembly string:

```
#GeneModels = buildGeneModels("hg38")
GeneModels = hub[["EH3481"]]

# Get the locations of exons
head(GeneModels[["exonsGR"]])
```

```
## GRanges object with 6 ranges and 0 metadata columns:
##       seqnames        ranges strand
##          <Rle>     <IRanges>  <Rle>
##   [1]     chr1   69091-70008      +
##   [2]     chr1 182393-182746      +
##   [3]     chr1 183114-183240      +
##   [4]     chr1 183922-184158      +
##   [5]     chr1 923928-924948      +
##   [6]     chr1 925150-925189      +
##   -------
##   seqinfo: 25 sequences from GRCh38 genome
```

## 1.6 Open Signal Matrices

Lastly, Genomic DistributionsData can generate an open chromatin signal matrix that will be used to calculate and plot the tissue specificity of a set of genomic ranges. This can be achieved by using the appropriate ExperimentHub identifier or passing the genome assembly string to the **buildOpenSignalMatrix()** function:

```
#hg38OpenSignal = buildOpenSignalMatrix("hg38")
OpenSignal = hub[["EH3485"]]
head(OpenSignal)
```

## 1.7 Access data using file named functions

GenomicDistributionsData also incorporates an ExperimentHub wrapper that exports each resource name into a function. This allows data to be loaded by name:

```
chromSizes_hg38()
chromSizes_hg19()
chromSizes_mm10()
chromSizes_mm9()
TSS_hg38()
TSS_hg19()
TSS_mm10()
TSS_mm9()
geneModels_hg38()
geneModels_hg19()
geneModels_mm10()
geneModels_mm9()
openSignalMatrix_hg38()
openSignalMatrix_hg19()
openSignalMatrix_mm10()
```

That’s it. Although the package currently supports the **hg19, hg38, mm9 and mm10** reference assemblies, GenomicDistributionsData is flexible enough to use other genomes. This can be achieved by a few tweaks in the main functions available on the R directory.