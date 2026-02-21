# Simplifying Genomic Annotations in R

Mohammed Omar Elsiddieg Abdallah

#### 29 October 2025

#### Package

cellbaseR 1.34.0

# Contents

* [1 Introduction to CellbaseR](#introduction-to-cellbaser)
* [2 CellbaseR Classes and Methods](#cellbaser-classes-and-methods)
  + [2.1 The CellbaseR class](#the-cellbaser-class)
  + [2.2 The CellbaseR Methods](#the-cellbaser-methods)
    - [2.2.1 getGene](#getgene)
    - [2.2.2 getRegion](#getregion)
    - [2.2.3 getVariant](#getvariant)
    - [2.2.4 getClinical](#getclinical)
* [3 cellbaseR wrappers](#cellbaser-wrappers)
* [4 CellbaseR utilities](#cellbaser-utilities)
  + [4.1 CreateGeneModel](#creategenemodel)
  + [4.2 AnnotateVcf](#annotatevcf)

# 1 Introduction to CellbaseR

This R package makes use of the exhaustive RESTful Web service API that has been
implemented for the Cellabase database. It enable researchers to query and
obtain a wealth of biological information from a single database saving a lot
of time. Another benefit is that researchers can easily make queries about
different biological topics and link all this information together as all
information is integrated.

# 2 CellbaseR Classes and Methods

## 2.1 The CellbaseR class

This is an S4 class that holds the basic configuration for connecting to the
Cellbase web services. Let us start by loading the library.

```
# to get the default CellbaseR object (human data, from genome GRCh37)
library(cellbaseR)
# A default cellbaseR object is created as follows
cb <- CellBaseR()
```

## 2.2 The CellbaseR Methods

The cellbaseR package
provide many methods to query the cellbase webservices, they include:

* getGene
* getProtein
* getTranscript
* getRegion
* getVariant
* getClinical
* getTf
* getXref

In all cases the user is expected to provide the ids for the query and the
resource to be queried, in addition to the CellbaseQuery object they created.
For example, a query through the cbGene will look something like this

### 2.2.1 getGene

```
library(cellbaseR)
cb <- CellBaseR()
genes <- c("TP73","TET1")
res <- getGene(object = cb, ids = genes, resource = "info")
str(res,2)
```

```
## 'data.frame':    1 obs. of  13 variables:
##  $ id         : chr "ENSG00000078900"
##  $ name       : chr "TP73"
##  $ chromosome : chr "1"
##  $ start      : int 3652516
##  $ end        : int 3736201
##  $ strand     : chr "+"
##  $ biotype    : chr "protein_coding"
##  $ status     : chr "KNOWN"
##  $ source     : chr "ensembl"
##  $ version    : chr "15"
##  $ description: chr "tumor protein p73 [Source:HGNC Symbol;Acc:HGNC:12003]"
##  $ transcripts:List of 1
##   ..$ :'data.frame': 14 obs. of  23 variables:
##  $ annotation :'data.frame': 1 obs. of  5 variables:
##   ..$ expression  :List of 1
##   ..$ diseases    :List of 1
##   ..$ drugs       :List of 1
##   ..$ constraints :List of 1
##   ..$ mirnaTargets:List of 1
```

```
# as you can see the res dataframe also contains a transcripts column
# which is in fact a list column of nested dataframes, to get the
# trasnscripts data.frame for first gene
TET1_transcripts <- res$transcripts[[1]]
str(TET1_transcripts,1)
```

```
## 'data.frame':    14 obs. of  23 variables:
##  $ id                : chr  "ENST00000378295.9" "ENST00000604074.5" "ENST00000354437.8" "ENST00000603362.5" ...
##  $ name              : chr  "TP73-208" "TP73-211" "TP73-202" "TP73-209" ...
##  $ chromosome        : chr  "1" "1" "1" "1" ...
##  $ start             : int  3652516 3652520 3652565 3682366 3682366 3690672 3690672 3690672 3690707 3698046 ...
##  $ end               : int  3736201 3736201 3733292 3733079 3733079 3733292 3733292 3736201 3729751 3708534 ...
##  $ strand            : chr  "+" "+" "+" "+" ...
##  $ biotype           : chr  "protein_coding" "protein_coding" "protein_coding" "protein_coding" ...
##  $ status            : chr  "KNOWN" "KNOWN" "KNOWN" "KNOWN" ...
##  $ genomicCodingStart: int  3682366 3682366 3682366 3682366 3682366 3690906 3690906 3690906 0 0 ...
##  $ genomicCodingEnd  : int  3733079 3732762 3732762 3733079 3733079 3732762 3731555 3733079 0 0 ...
##  $ cdnaCodingStart   : int  160 156 111 1 1 235 235 235 0 0 ...
##  $ cdnaCodingEnd     : int  2070 1367 1610 1668 1623 1587 1515 1998 0 0 ...
##  $ cdsLength         : int  1910 1211 1499 1667 1622 1352 1280 1763 0 0 ...
##  $ cdnaSequence      : chr  "GCCCTGCCTCCCCGCCCGCGCACCCGCCCGGAGGCTCGCGCGCCCGCGAAGGGGACGCAGCGAAACCGGGGCCCGCGCCAGGCCAGCCGGGACGGACGCCGATGCCCGGGG"| __truncated__ "TGCCTCCCCGCCCGCGCACCCGCCCGGAGGCTCGCGCGCCCGCGAAGGGGACGCAGCGAAACCGGGGCCCGCGCCAGGCCAGCCGGGACGGACGCCGATGCCCGGGGCTGC"| __truncated__ "AGGGGACGCAGCGAAACCGGGGCCCGCGCCAGGCCAGCCGGGACGGACGCCGATGCCCGGGGCTGCGACGGCTGCAGAGCGAGCTGCCCTCGGAGGCCGGCGTGGGGAAGA"| __truncated__ "ATGGCCCAGTCCACCGCCACCTCCCCTGATGGGGGCACCACGTTTGAGCACCTCTGGAGCTCTCTGGAACCAGACAGCACCTACTTCGACCTTCCCCAGTCAAGCCGGGGG"| __truncated__ ...
##  $ proteinId         : chr  "ENSP00000367545.4" "ENSP00000475143.1" "ENSP00000346423.4" "ENSP00000474626.1" ...
##  $ proteinSequence   : chr  "MAQSTATSPDGGTTFEHLWSSLEPDSTYFDLPQSSRGNNEVVGGTDSSMDVFHLEGMTTSVMAQFNLLSSTMDQMSSRAASASPYTPEHAASVPTHSPYAQPSSTFDTMSP"| __truncated__ "MAQSTATSPDGGTTFEHLWSSLEPDSTYFDLPQSSRGNNEVVGGTDSSMDVFHLEGMTTSVMAQFNLLSSTMDQMSSRAASASPYTPEHAASVPTHSPYAQPSSTFDTMSP"| __truncated__ "MAQSTATSPDGGTTFEHLWSSLEPDSTYFDLPQSSRGNNEVVGGTDSSMDVFHLEGMTTSVMAQFNLLSSTMDQMSSRAASASPYTPEHAASVPTHSPYAQPSSTFDTMSP"| __truncated__ "MAQSTATSPDGGTTFEHLWSSLEPDSTYFDLPQSSRGNNEVVGGTDSSMDVFHLEGMTTSVMAQFNLLSSTMDQMSSRAASASPYTPEHAASVPTHSPYAQPSSTFDTMSP"| __truncated__ ...
##  $ version           : chr  "9" "5" "8" "5" ...
##  $ source            : chr  "ensembl" "ensembl" "ensembl" "ensembl" ...
##  $ exons             :List of 14
##  $ xrefs             :List of 14
##  $ tfbs              :List of 14
##  $ flags             :List of 14
##  $ annotation        :'data.frame':  14 obs. of  2 variables:
```

### 2.2.2 getRegion

```
# making a query through cbRegion to get all the clinically relevant variants
# in a specific region
library(cellbaseR)
cb <- CellBaseR()
# to get all conservation data in this region
res <- getRegion(object=cb,ids="17:1000000-1005000",
resource="conservation")
#likewise to get all the regulatory data for the same region
res <- getRegion(object=cb,ids="17:1000000-1005000", resource="regulatory")
str(res,1)
```

```
## 'data.frame':    3 obs. of  6 variables:
##  $ id         : chr  "ENSR00000546759" "ENSR00001005684" "ENSR00001005685"
##  $ chromosome : chr  "17" "17" "17"
##  $ start      : int  998401 1001001 1003601
##  $ end        : int  1000000 1001200 1004000
##  $ featureType: chr  "CTCF_binding_site" "CTCF_binding_site" "CTCF_binding_site"
##  $ cellTypes  :List of 3
```

### 2.2.3 getVariant

Getting annotation for a specific variant

```
library(cellbaseR)
cb <- CellBaseR()
res2 <- getVariant(object=cb, ids="1:169549811:A:G", resource="annotation")
# to get the data
res2 <- cbData(res2)
str(res2, 1)
```

A very powerfull feature of cellbaseR is ability to fetch a wealth of clinical
data, as well as abiliy to fiter these data by gene, phenotype, rs, etc…

### 2.2.4 getClinical

```
library(cellbaseR)
cb <- CellBaseR()
# First we have to specify aour param, we do that by creating an object of
# class CellbaseParam
cbparam <- CellBaseParam(feature = "TET1", assembly = "grch38",limit=50)
cbparam
```

```
## |An object of class CellBaseParam
## |use this object to control what results are returned from the CellBaseR
##       methods
```

```
# Note that cbClinical does NOT require any Ids to be passed, only the param
# and of course the CellbaseQuery object
res <- getClinical(object=cb,param=cbparam)
str(res,1)
```

```
## 'data.frame':    50 obs. of  17 variables:
##  $ chromosome            : chr  "10" "10" "10" "10" ...
##  $ start                 : int  68572667 68572384 68572823 68603154 68572485 68572906 68573138 68579871 68601184 68573573 ...
##  $ reference             : chr  "C" "G" "A" "G" ...
##  $ alternate             : chr  "A" "A" "G" "C" ...
##  $ hgvs                  :List of 50
##  $ displayConsequenceType: chr  "missense_variant" "missense_variant" "missense_variant" "intron_variant" ...
##  $ consequenceTypes      :List of 50
##  $ conservation          :List of 50
##  $ geneConstraints       :List of 50
##  $ geneMirnaTargets      :List of 50
##  $ geneCancerAssociations:List of 50
##  $ traitAssociation      :List of 50
##  $ functionalScore       :List of 50
##  $ cytoband              :List of 50
##  $ id                    : chr  NA NA "10:68572823:A:G" NA ...
##  $ populationFrequencies :List of 50
##  $ repeat                :List of 50
```

# 3 cellbaseR wrappers

cellbaseE package also provides many wrapper functions around commomn cellbaseR
queries. These include:
- getClinicalByGene
- getTranscriptByGene
- getGeneInfo
- getProteinInfo
- getClinicalByRegion
- getConservationByRegion
- getRegulatoryByRegion
- getTfbsByRegion
- getVariantAnnotation

# 4 CellbaseR utilities

## 4.1 CreateGeneModel

A usefull utility for fast building of gene models, compatible with Gviz
package for genomic visualization

```
library(cellbaseR)
cb <- CellBaseR()
cbparam <- CellBaseParam(feature = "TET1", assembly = "grch37")
test <- createGeneModel(object = cb, region = "17:1500000-1550000")
if(require("Gviz")){
  testTrack <- Gviz::GeneRegionTrack(test)
  Gviz::plotTracks(testTrack, transcriptAnnotation='symbol')
}
```

![](data:image/png;base64...)

## 4.2 AnnotateVcf

This utility allows users to annoate genomic variants from small to medium-sized
vcf files directly from the cellbase server, with a wealth of genomic
annotations including riche clinical annotations like clinvar, gwas, and cosmic
data, as well as conservation and functional scores like phast and cadd scores
, without the need to download any files.

```
library(cellbaseR)
library(VariantAnnotation)
cb <- CellBaseR()
fl <- system.file("extdata", "hapmap_exome_chr22_200.vcf.gz",package = "cellbaseR" )
res <- AnnotateVcf(object=cb, file=fl, BPPARAM = bpparam(workers=2),batch_size = 100)
vcf <- readVcf(fl, "hg19")
samples(header(vcf))
```

```
##  [1] "NA07034@1099927558" "NA07048@1099927687" "NA07055@1099927615"
##  [4] "NA10846@1099927836" "NA10847@1099927741" "NA12146@1099927743"
##  [7] "NA12239@1099927424" "NA12877@1099925716" "NA12878@1099927697"
## [10] "NA12891@1099927856" "NA12892@1099927810" "NA18503@1099927775"
## [13] "NA18504@0178873056" "NA18505@1099927412" "NA18506@1099927650"
## [16] "NA18524@1099927756" "NA18532@1099927601" "NA18912@1099927835"
## [19] "NA18913@1099927630" "NA18914@0178874379" "NA18940@1099927867"
## [22] "NA18947@0178875080"
```

```
length(rowRanges(vcf))==nrow(res)
```

```
## [1] TRUE
```

```
str(res,1)
```

```
## 'data.frame':    200 obs. of  19 variables:
##  $ chromosome            : chr  "22" "22" "22" "22" ...
##  $ start                 : int  16157603 17060707 17072347 17177682 17265124 17326914 17446991 17469049 17602839 17603503 ...
##  $ reference             : chr  "G" "G" "C" "C" ...
##  $ alternate             : chr  "C" "A" "T" "A" ...
##  $ hgvs                  :List of 200
##  $ displayConsequenceType: chr  "intergenic_variant" "non_coding_transcript_exon_variant" "2KB_downstream_variant" "2KB_downstream_variant" ...
##  $ consequenceTypes      :List of 200
##  $ conservation          :List of 200
##  $ geneTraitAssociation  :List of 200
##  $ geneDrugInteraction   :List of 200
##  $ geneConstraints       :List of 200
##  $ geneMirnaTargets      :List of 200
##  $ geneCancerAssociations:List of 200
##  $ cancerHotspots        :List of 200
##  $ functionalScore       :List of 200
##  $ cytoband              :List of 200
##  $ repeat                :List of 200
##  $ id                    : chr  NA NA NA NA ...
##  $ populationFrequencies :List of 200
```