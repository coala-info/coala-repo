FDb.InfiniumMethylation.hg18

February 11, 2026

getNearest

Annotate a group of probes supplied as a GenomicRanges object

Description

This function encapsulates the common task of finding what gene/tx/tss is closest to a list of probes,
as might be the case after a model fit.

Author(s)

Tim Triche, Jr.

Examples

## not run
##
## hm450 <- get450k()
## probenames <- c("cg16392865", "cg00395291", "cg09310185", "cg21749424")
## probes <- hm450[probenames]
##
## getNearestTSS(probes)
## getNearestTranscript(probes)
##
## Notice that cg16392865 sits within PTCRA, but the nearest TSS is CNPY3.
##

getPlatform

Retrieve annotations for HumanMethylation27 or HumanMethyla-
tion450 chips

Description

FDb.InfiniumMethylation.hg19 is an omnibus package that merges all of the existing Illumina In-
finium DNA methylation probe annotations into one FDb. However, most users will be analyzing
one of the two chips at any given time. The utility functions getPlatform(platform), get450k(), and
get27k() retrieve a compact GenomicRanges form of the annotations for the requested platform.

1

miscData

2

Author(s)

Tim Triche, Jr.

Examples

hm450.hg18 <- getPlatform(platform='HM450', genome='hg18')
show(hm450.hg18)

hm27.hg18 <- get27k(genome='hg18')
genome(hm27.hg18)

hg18.islands

CpG islands found by Wu, Irizarry, and Feinberg via hidden Markov
model

Description

This GRanges object was constructed from the data provided at http://rafalab.jhsph.edu/CGI/model-
based-cpg-islands-hg18.txt

Additional species and software to run the model can be found at http://rafalab.jhsph.edu/CGI/index.html

Author(s)

Tim Triche, Jr. (with data from Wu, Irizarry, and Feinberg)

Examples

data(hg18.islands)
split(hg18.islands, seqnames(hg18.islands))

miscData

miscellaneous data used in the construction of this FeatureDb package

Description

In the subdirectory inst/build/, there are several scripts that rebuild this FeatureDb from scratch.
A handful of intermediate results from dbSNP and comparison of existing datasets are required to
patch small gaps in the Illumina manifests. These datasets supply those intermediate results.

Author(s)

Tim Triche, Jr.

Examples

data(hm450.rsProbes)
data(hm27.SNP.colors)

FDb.InfiniumMethylation.hg18

3

FDb.InfiniumMethylation.hg18

Annotation package for Illumina Infinium DNA methylation probes

Description

This package loads one or more FeatureDb objects. Such FeatureDb objects are an R interface to
prefabricated databases contained by this package. In the case of the Infinium methylation FDb, it
is FDb.InfiniumMethylation.hg18 (for the moment; hg18 may come later, or alternatively users can
use liftOver() from rtracklayer to do it).

Author(s)

Tim Triche, Jr.

See Also

features makeFeatureDbFromUCSC import.bed getPlatform get450k get27k

Examples

## load the library
library(FDb.InfiniumMethylation.hg18)

## list the contents that are loaded into memory
ls('package:FDb.InfiniumMethylation.hg18')

## show the db object that is loaded by calling it's name
FDb.InfiniumMethylation.hg18

## extract features for use in constructing SummarizedExperiments
## or comparing chip features against other data (e.g. ChIP-seq)
InfiniumMethylation <- features(FDb.InfiniumMethylation.hg18)

## it's much more convenient to address ranges by their probe ID:
names(InfiniumMethylation) <- values(InfiniumMethylation)$name

## we'd prefer if R would stop us from comparing across assemblies:
met <- metadata(FDb.InfiniumMethylation.hg18) ## need to fetch genome
genome(InfiniumMethylation) <- met[which(met[,'name']=='Genome'),'value']

## last but not least, sort the probes in genomic order
InfiniumMethylation <- sort(InfiniumMethylation)
show(InfiniumMethylation)

## Example: probes that overlap Irizarry's HMM CpG islands
data(hg18.islands)
CGI.probes <- subsetByOverlaps(InfiniumMethylation, hg18.islands)
head(CGI.probes)
tail(CGI.probes)

## Same as above, but now for "shores"
hg18.shores <- c(flank(hg18.islands, 2000, start=TRUE),

flank(hg18.islands, 2000, start=FALSE))

4

seqinfo.hg18

shore.probes <- subsetByOverlaps(InfiniumMethylation, hg18.shores)
head(shore.probes)
tail(shore.probes)

## The same logic works for overlapping probes with other data.
## For example, we can easily do this for old 27k data as well:
hm27 <- get27k()
hm27.shores <- subsetByOverlaps(hm27, hg18.shores)

## The same approach works to overlap (e.g.) ChIP-seq peaks or DNAseI footprints
## Much more data is available via GenomicFeatures and rtracklayer:
help(makeFeatureDbFromUCSC)

seqinfo.hg18

Sequence names, lengths, and circularity for hg18

Description

These avoid having to load a BSgenome package just to assign seqinfo(GR).

Author(s)

Tim Triche, Jr.

Examples

## FDb.InfiniumMethylation.hg18
hm450.hg18 <- get450k(genome='hg18')

Index

∗ data

FDb.InfiniumMethylation.hg18, 3
hg18.islands, 2
miscData, 2
seqinfo.hg18, 4

∗ package

FDb.InfiniumMethylation.hg18, 3

FDb.InfiniumMethylation.hg18, 3
FDb.InfiniumMethylation.hg18-package

(FDb.InfiniumMethylation.hg18),
3
features, 3

get27k, 3
get27k (getPlatform), 1
get450k, 3
get450k (getPlatform), 1
getNearest, 1
getNearestGene (getNearest), 1
getNearestTranscript (getNearest), 1
getNearestTSS (getNearest), 1
getPlatform, 1, 3

hg18.islands, 2
hg18ToHg19 (miscData), 2
hm27.controls (miscData), 2
hm27.SNP.colors (miscData), 2
hm450.controls (miscData), 2
hm450k.rsProbes (miscData), 2

import.bed, 3

makeFeatureDbFromUCSC, 3
miscData, 2

seqinfo.hg18, 4
SNPs.hg18 (miscData), 2

unmappable (miscData), 2

5

