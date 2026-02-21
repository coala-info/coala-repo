FDb.InfiniumMethylation.hg19

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

lift27kToHg19

2

Author(s)

Tim Triche, Jr.

Examples

hm450.hg19 <- getPlatform(platform='HM450', genome='hg19')
show(hm450.hg19)

hm27.hg19 <- get27k()
genome(hm27.hg19)

hg19.islands

CpG islands found by Wu, Irizarry, and Feinberg via hidden Markov
model

Description

This GRanges object was constructed from the data provided at http://rafalab.jhsph.edu/CGI/model-
based-cpg-islands-hg19.txt

Additional species and software to run the model can be found at http://rafalab.jhsph.edu/CGI/index.html

Author(s)

Tim Triche, Jr. (with data from Wu, Irizarry, and Feinberg)

Examples

data(hg19.islands)
split(hg19.islands, seqnames(hg19.islands))

lift27kToHg19

Take a GenomicRatioSet or similar annotated to hg18 and reannotate
it

Description

lift27kToHg19 is a convenience function that does exactly what it says:
takes an hm27 dataset
(typically downloaded from GEO and coerced into a GenomicRatioSet, as for example by fetchGE-
OMethylationDataset()), replacing the hg18-derived coordinates with hg19 coordinates from this
package.

Author(s)

Tim Triche, Jr.

miscData

Examples

3

## not run:
##
## devtools:::install_github('ttriche/chromophobe/')
## library(chromophobe)
##
## CMML_HM27 <- fetchGEOMethylationDataset('GSE31600')
## CMML_HM27 <- lift27kToHg19(CMML_HM27)
## CMML_HM27$CMML <- grepl('CMML', CMML_HM27$title)
## CMML_HM27$TET2 <- grepl('TET2-mut', CMML_HM27$characteristics_ch1.3)
## CMML_HM27$gender <- getXplots(CMML_HM27)
##
## Compare to, say, TET2 mutants in GSE32251 or GSE58477, if you wish.

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

FDb.InfiniumMethylation.hg19

Annotation package for Illumina Infinium DNA methylation probes

Description

This package loads one or more FeatureDb objects. Such FeatureDb objects are an R interface to
prefabricated databases contained by this package. In the case of the Infinium methylation FDb, it
is FDb.InfiniumMethylation.hg19 (for the moment; hg18 may come later, or alternatively users can
use liftOver() from rtracklayer to do it).

Author(s)

Tim Triche, Jr.

4

See Also

getPlatform get450k get27k

Examples

## load the library
library(FDb.InfiniumMethylation.hg19)

seqinfo.hg19

## list the contents that are loaded into memory
ls('package:FDb.InfiniumMethylation.hg19')

## show the db object that is loaded by calling it's name
FDb.InfiniumMethylation.hg19

## extract features for use in constructing SummarizedExperiments
## or comparing chip features against other data (e.g. ChIP-seq)
InfiniumMethylation <- features(FDb.InfiniumMethylation.hg19)

## we'd prefer if R would stop us from comparing across assemblies:
met <- metadata(FDb.InfiniumMethylation.hg19) ## need to fetch genome
genome(InfiniumMethylation) <- met[which(met[,'name']=='Genome'),'value']

## last but not least, sort the probes in genomic order
InfiniumMethylation <- sort(InfiniumMethylation)
show(InfiniumMethylation)

## Example: probes that overlap Irizarry's HMM CpG islands
data(hg19.islands)
CGI.probes <- subsetByOverlaps(InfiniumMethylation, hg19.islands)
head(CGI.probes)
tail(CGI.probes)

## Same as above, but now for "shores"
hg19.shores <- c(flank(hg19.islands, 2000, start=TRUE),

flank(hg19.islands, 2000, start=FALSE))

shore.probes <- subsetByOverlaps(InfiniumMethylation, hg19.shores)
head(shore.probes)
tail(shore.probes)

## The same logic works for overlapping probes with other data.
## For example, we can easily do this for old 27k data as well:
hm27 <- get27k()
hm27.shores <- subsetByOverlaps(hm27, hg19.shores)

## The same logic applies to overlapping ChIP-seq peaks, DNAseI footprints, etc.
## Much more data is available via GenomicFeatures and rtracklayer:
## help(makeFeatureDbFromUCSC)

seqinfo.hg19

Sequence names, lengths, and circularity for hg19

Description

These avoid having to load a BSgenome package just to assign seqinfo(GR).

seqinfo.hg19

Author(s)

Tim Triche, Jr.

Examples

## FDb.InfiniumMethylation.hg19
hm450.hg19 <- get450k(genome='hg19')

5

Index

∗ data

FDb.InfiniumMethylation.hg19, 3
hg19.islands, 2
miscData, 3
seqinfo.hg19, 4

∗ package

FDb.InfiniumMethylation.hg19, 3

FDb.InfiniumMethylation.hg19, 3
FDb.InfiniumMethylation.hg19-package

(FDb.InfiniumMethylation.hg19),
3

get27k, 4
get27k (getPlatform), 1
get450k, 4
get450k (getPlatform), 1
getNearest, 1
getNearestGene (getNearest), 1
getNearestTranscript (getNearest), 1
getNearestTSS (getNearest), 1
getPlatform, 1, 4

hg18ToHg19 (miscData), 3
hg19.islands, 2
hm27.controls (miscData), 3
hm27.SNP.colors (miscData), 3
hm27ToHg19 (lift27kToHg19), 2
hm450.controls (miscData), 3
hm450k.rsProbes (miscData), 3

lift27kToHg19, 2

miscData, 3

seqinfo.hg19, 4

6

