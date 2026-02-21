FDb.UCSC.snp135common.hg19

February 11, 2026

FDb.UCSC.snp135common.hg19

UCSC common SNPs track, dbSNP build 135, genome assembly hg19

Description

FDb.UCSC.snp135common.hg19 is a FeatureDb created from the UCSC common SNPs track
for dbSNP build 135 and genome assembly hg19. The track is too large to automatically con-
struct a FeatureDb using makeFeatureDbFromUCSC, so here it has been manually retrieved (see
inst/build/FDb.UCSC.snp135common.hg19.R) and saved as a FeatureDb.

Author(s)

Tim Triche, Jr.

See Also

features makeFeatureDbFromUCSC

Examples

## load the library
library(FDb.UCSC.snp135common.hg19)

## list the contents that are loaded into memory
ls('package:FDb.UCSC.snp135common.hg19')

## show the db object that is loaded by calling it's name
FDb.UCSC.snp135common.hg19

## extract features for use in annotating data
snp135common <- features(FDb.UCSC.snp135common.hg19)
met <- metadata(FDb.UCSC.snp135common.hg19) ## need to fetch genome
genome(snp135common) <- met[which(met[,'name']=='Genome'),'value']

1

Index

∗ data

FDb.UCSC.snp135common.hg19, 1

∗ package

FDb.UCSC.snp135common.hg19, 1

FDb.UCSC.snp135common.hg19, 1
FDb.UCSC.snp135common.hg19-package

(FDb.UCSC.snp135common.hg19), 1

features, 1

makeFeatureDbFromUCSC, 1

2

