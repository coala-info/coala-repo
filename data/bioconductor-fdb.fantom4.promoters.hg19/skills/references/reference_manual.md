FDb.FANTOM4.promoters.hg19

February 11, 2026

hg18ToHg19

UCSC liftOver chain for hg18 to hg19, used in build scripts

Description

In the subdirectory inst/build/, there are several scripts that rebuild this FeatureDb from scratch.
Since this is lifted from hg18, a chain is included.

Author(s)

Tim Triche, Jr.

Examples

data(hg18ToHg19)
hg18ToHg19

FDb.FANTOM4.promoters.hg19

Annotation package for FANTOM4 CAGE promoters from THP-1 cells

Description

This package loads one or more FeatureDb objects. Such FeatureDb objects are an R interface to
prefabricated databases contained by this package. In the case of the FANTOM4 promoter database,
it is FDb.FANTOM4.promoters.hg19 (hg18 is available directly from unibas.ch).

Author(s)

Tim Triche, Jr.

See Also

features makeFeatureDbFromUCSC import.bed

1

2

Examples

FDb.FANTOM4.promoters.hg19

## load the library
library(FDb.FANTOM4.promoters.hg19)

## list the contents that are loaded into memory
ls('package:FDb.FANTOM4.promoters.hg19')

## show the db object that is loaded by calling it's name
FDb.FANTOM4.promoters.hg19

## extract features for use in annotating data
FANTOM4.hg19 <- features(FDb.FANTOM4.promoters.hg19)

## we'd prefer if R would stop us from comparing across assemblies:
met <- metadata(FDb.FANTOM4.promoters.hg19) ## need to fetch genome
genome(FANTOM4.hg19) <- met[which(met[,'name']=='Genome'),'value']

## Plot the observed/expected CpG ratio look like across promoters
## (computed as Pr(CG) / Pr(C)Pr(G)Pr(CG|G,C) within a 3kb window)
## Conversion back to numeric is due to an artifact of features()
values(FANTOM4.hg19)$oecg <- as.numeric(values(FANTOM4.hg19)$oecg)
hist(values(FANTOM4.hg19)$oecg, breaks=200,

xlab='Observed/expected CpG content from hg19',
main='FANTOM4 promoter CpG content, 3kb windows')

## The function used for this is FDb.FANTOM4.promoters.hg19:::oecg()

Index

∗ data

FDb.FANTOM4.promoters.hg19, 1
hg18ToHg19, 1

∗ package

FDb.FANTOM4.promoters.hg19, 1

FDb.FANTOM4.promoters.hg19, 1
FDb.FANTOM4.promoters.hg19-package

(FDb.FANTOM4.promoters.hg19), 1

features, 1

hg18ToHg19, 1

import.bed, 1

makeFeatureDbFromUCSC, 1

3

