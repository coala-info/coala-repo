gwascatData – a snapshot of the EBI/EMBL
GWAS catalog

Vincent J. Carey, stvjc at channing.harvard.edu, Shweta
Gopaulakrishnan reshg at channing.harvard.edu

May 14, 2021

Contents

1

Introduction .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2

gwascatData – a snapshot of the EBI/EMBL GWAS catalog

1

Introduction

This package deﬁnes an AnnotationHub resource representing the EBI GWAS catalog on
March 30 2021.

library(AnnotationHub)

## Loading required package: BiocGenerics

## Loading required package: parallel

##

## Attaching package: 'BiocGenerics'

## The following objects are masked from 'package:parallel':

##

##

##

##

clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,

clusterExport, clusterMap, parApply, parCapply, parLapply,

parLapplyLB, parRapply, parSapply, parSapplyLB

## The following objects are masked from 'package:stats':

##

##

IQR, mad, sd, var, xtabs

## The following objects are masked from 'package:base':

##

##

##

##

##

##

##

Filter, Find, Map, Position, Reduce, anyDuplicated, append,

as.data.frame, basename, cbind, colnames, dirname, do.call,

duplicated, eval, evalq, get, grep, grepl, intersect, is.unsorted,

lapply, mapply, match, mget, order, paste, pmax, pmax.int, pmin,

pmin.int, rank, rbind, rownames, sapply, setdiff, sort, table,

tapply, union, unique, unsplit, which.max, which.min

## Loading required package: BiocFileCache

## Loading required package: dbplyr

ahub = AnnotationHub()

## snapshotDate(): 2021-05-14

mymeta <- query(ahub , "gwascatData")

mymeta

## AnnotationHub with 1 record

## # snapshotDate(): 2021-05-14

## # names(): AH91571

## # $dataprovider: EBI/EMBL

## # $species: Homo sapiens

## # $rdataclass: character

## # $rdatadateadded: 2021-04-12

## # $title: gwascatData

## # $description: text file in cloud with March 30 2021 snapshot of EBI/EMBL G...

## # $taxonomyid: 9606

## # $genome: GRCh38

## # $sourcetype: TSV

## # $sourceurl: http://www.ebi.ac.uk/gwas/api/search/downloads/alternative

## # $sourcesize: NA

## # $tags: c("GWAS", "GWAS catalog")

## # retrieve record with 'object[["AH91571"]]'

tag = names(mymeta)[1]

tag

## [1] "AH91571"

2

gwascatData – a snapshot of the EBI/EMBL GWAS catalog

head(ahub[[tag]][,1:6])

## downloading 1 resources

## retrieving 1 resource

## loading from cache

##

DATE ADDED TO CATALOG PUBMEDID FIRST AUTHOR

DATE

JOURNAL

## 1

## 2

## 3

## 4

## 5

## 6

##

2020-06-04 32296059

Han Y 2020-04-15

Nat Commun

2020-02-05 31666681

Zhao B 2019-10-30 Mol Psychiatry

2020-02-05 31666681

Zhao B 2019-10-30 Mol Psychiatry

2020-06-04 32296059

Han Y 2020-04-15

Nat Commun

2020-02-05 31666681

Zhao B 2019-10-30 Mol Psychiatry

2020-02-05 31666681

Zhao B 2019-10-30 Mol Psychiatry

LINK

## 1 www.ncbi.nlm.nih.gov/pubmed/32296059

## 2 www.ncbi.nlm.nih.gov/pubmed/31666681

## 3 www.ncbi.nlm.nih.gov/pubmed/31666681

## 4 www.ncbi.nlm.nih.gov/pubmed/32296059

## 5 www.ncbi.nlm.nih.gov/pubmed/31666681

## 6 www.ncbi.nlm.nih.gov/pubmed/31666681

The gwascat package includes tooling to transform this to a GRanges-like object.

3

