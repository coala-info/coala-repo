# TSRchitect Introduction

#### *R. Taylor Raborn*

#### *2018-11-17*

## R. Taylor Raborn and Volker P. Brendel

## Department of Biology, Indiana University

### July 10, 2018

TSRchitect is an R package for analyzing diverse types of high-throughput transcription start site (TSS) profiling datasets. TSRchitect can handle TSS profiling experiments that contain either single-end or paired-end sequence reads, such as CAGE, RAMPAGE, PEAT, STRIPE-seq and others. TSRchitect is an open-source bioinformatics package that is intended to support large-scale, reproducible analysis of TSS profiling data in a broad array of eukaryotic model systems.

Before we can begin, we must first load TSRchitect in our working environment.

```
library(TSRchitect)
```

The TSRchitect User’s Guide is available; it goes through several well-documented examples of TSRchitect using different datasets.

To open the TSRchitect User’s Guide on your machine, enter the following:

```
TSRchitectUsersGuide()
```

## Getting started

Now that you have loaded TSRchitect, we can proceed with a small example.

First, we will create a tssObject using `loadTSSobj` and import our sample .bam files (which are found in `extdata/`). In doing this, we provide sample names and identify our replicate names using the argument `sampleNames`. We do this in the following manner:

```
extdata.dir <- system.file("extdata", package="TSRchitect")

tssObjectExample <- loadTSSobj(experimentTitle="Vignette Example",
inputDir=extdata.dir, isPairedBAM=TRUE,
sampleNames=c("sample1-rep1", "sample1-rep2","sample2-rep1",
"sample2-rep2"), replicateIDs=c(1,1,2,2)) #datasets 1-2 and 3-4 are replicates
```

```
## ... loadTSSobj ...
```

```
##
## Importing paired-end reads ...
```

```
##
## TSS data were specified to be paired-end read alignments.
```

```
##
## Beginning import of 4 bam files ...
```

```
## Done. Alignment data from 4 bam files have been attached to the tssObject.
```

```
## -----------------------------------------------------
```

```
##
## Names and replicate IDs were successfully added to the tssObject.
```

```
## -----------------------------------------------------
```

```
##  Done.
```

If we wish to see our new tssObject, we simply type its name on the console and hit return, as follows:

```
tssObjectExample
```

Now that the .bam files have been imported, we need to retrieve TSSs from the BAM records, and calculate the abundance of each tag at a given TSS. We opt to not run these in parallel, and specify this by setting `n.cores = 1`.

```
tssObjectExample <- inputToTSS(experimentName=tssObjectExample)
```

```
## ... inputToTSS ...
```

```
##
## Beginning input to TSS data conversion ...
```

```
## Retrieving data from bam file #1...
```

```
## Retrieving data from bam file #2...
```

```
## Retrieving data from bam file #3...
```

```
## Retrieving data from bam file #4...
```

```
## Done. TSS data from 4 separate bam files have been successfully
## added to the tssObject.
```

```
## ----------------------------------------------------
```

```
##  Done.
```

```
tssObjectExample <- processTSS(experimentName=tssObjectExample, n.cores=1,
tssSet="all", writeTable=FALSE)
```

```
## ... processTSS ...
```

```
##
## ... the TSS expression matrix for dataset 1 has been successfully
## added to the tssObject.
```

```
## -----------------------------------------------------
```

```
##
## ... the TSS expression matrix for dataset 2 has been successfully
## added to the tssObject.
```

```
## -----------------------------------------------------
```

```
##
## ... the TSS expression matrix for dataset 3 has been successfully
## added to the tssObject.
```

```
## -----------------------------------------------------
```

```
##
## ... the TSS expression matrix for dataset 4 has been successfully
## added to the tssObject.
```

```
## -----------------------------------------------------
##
## -----------------------------------------------------
```

```
##  Done.
```

Now that this is complete we can we proceed with identifing TSRs from TSSs. We do this for each of the 4 datasets we imported at once by specifying tssSet=“all”.

```
tssObjectExample <- determineTSR(experimentName=tssObjectExample, n.cores=1,
tsrSetType="replicates", tssSet="all", tagCountThreshold=25, clustDist=20,
writeTable=FALSE)
```

```
## ... determineTSR ...
```

```
## ... detTSR ...
```

```
## ---------------------------------------------------------
```

```
##  Done.
```

```
## ... detTSR ...
```

```
## ---------------------------------------------------------
```

```
##  Done.
```

```
## ... detTSR ...
```

```
## ---------------------------------------------------------
```

```
##  Done.
```

```
## ... detTSR ...
```

```
## ---------------------------------------------------------
```

```
##  Done.
```

```
## -----------------------------------------------------
```

```
##  Done.
```

Next we merge our replicate data (according to the information we provided in `loadTSSobj`) and identify TSRs on these merged samples. We then use `addTagCountsToTSR` to quantify the number of tags found in each of our 4 datasets.

```
tssObjectExample <- mergeSampleData(experimentName=tssObjectExample)
```

```
## ... mergeSampleData ...
```

```
##
## ... the TSS expression data have been merged
## and added to the tssObject object.
```

```
## ------------------------------------------------------
```

```
##  Done.
```

```
tssObjectExample <- determineTSR(experimentName=tssObjectExample, n.cores=1,
tsrSetType="merged", tssSet="all", tagCountThreshold=25, clustDist=20,
writeTable=FALSE)
```

```
## ... determineTSR ...
```

```
## ... detTSR ...
```

```
## ---------------------------------------------------------
```

```
##  Done.
```

```
## ... detTSR ...
```

```
## ---------------------------------------------------------
```

```
##  Done.
```

```
## ... detTSR ...
```

```
## ---------------------------------------------------------
```

```
##  Done.
```

```
## -----------------------------------------------------
```

```
##  Done.
```

```
tssObjectExample <- addTagCountsToTSR(experimentName=tssObjectExample,
tsrSetType="merged", tsrSet=1, tagCountThreshold=25, writeTable=FALSE)
```

```
## ... addTagCountsToTSR ...
```

```
##
## The merged TSR set for TSS dataset 1 has been written to file TSRsetMerged-1.txt
## in your working directory.
```

```
## ---------------------------------------------------------
```

```
##  Done.
```

Now that we have identified TSRs using `determineTSR` from all replicate and merged datasets, we can select individual results directly. To do this, we use `getTSRdata`, one of the `tssObject` accessor methods.

```
sample_1_1_tsrs <- getTSRdata(experimentName=tssObjectExample,
slotType="replicates", slot=1)

print(sample_1_1_tsrs)
```

```
##      seq    start      end strand nTSSs nTAGs tsrPeak tsrWdth tsrTrq tsrSI
## 2  chr22 15784937 15784952      +     6  1253    0.54      16   2.18  0.10
## 21 chr22 11974141 11974144      -     2   137    0.75       4   0.76  1.19
## 3  chr22 11974187 11974228      -     5   343    0.39      42  -8.59 -0.07
##    tsrMSI
## 2    0.26
## 21   0.19
## 3    0.11
```

We see that 3 distinct TSRs were identified from this small example dataset.

Finally, we import an annotation file (containing Gencode annotated transcripts) and then assocate this annotation with our small set of identified TSRs.

```
tssObjectExample <- importAnnotationExternal(experimentName=tssObjectExample,
fileType="gff3",
annotFile=paste(extdata.dir,"gencode.v19.chr22.transcript.gff3",sep="/"))
```

```
## ... importAnnotationExternal ...
```

```
## Done. Annotation data have been attached to the tssObject.
```

```
## -----------------------------------------------------
```

```
##  Done.
```

```
tssObjectExample <- addAnnotationToTSR(experimentName=tssObjectExample,
tsrSetType="merged", tsrSet=1, upstreamDist=2000, downstreamDist=500,
feature="transcript", featureColumnID="ID", writeTable=FALSE)
```

```
## ... addAnnotationToTSR ...
```

```
##
## The merged TSR set for TSS dataset 1 has been written to file TSRsetMerged-1.txt
## in your working directory.
```

```
## Done. GeneIDs have been associated with adjacent TSRs.
```

```
## -----------------------------------------------------
```

```
##  Done.
```

Before we end, we can choose to save an binary of our tssObject to return to at a later time.

```
save(tssObjectExample, file="tssObjectExample_vignette.RData")
```

This ends our vignette. Please see the TSRchitect User’s Guide for more extensively documented examples.