Software Manual

Institute of Bioinformatics, Johannes Kepler University Linz

panelcn.MOPS - CNV detection tool for targeted
NGS panel data

Verena Haunschmid and Gundula Povysil

Institute of Bioinformatics, Johannes Kepler University Linz
Altenberger Str. 69, 4040 Linz, Austria
povysil@bioinf.jku.at

Version 1.32.0, October 30, 2025

Institute of Bioinformatics
Johannes Kepler University Linz
A-4040 Linz, Austria

Tel. +43 732 2468 8880
Fax +43 732 2468 9511
http://www.bioinf.jku.at

2

Contents

1

Introduction

2 Getting started and quick start

3

4

Input

runPanelcnMops

5 Results

6 Visualization of results

7 Analysis of chromosome X

8 Quality control

9 Adjusting sensitivity and specificity

10 How to cite this package

Contents

3

3

5

7

7

9

10

10

11

11

1 Introduction

1 Introduction

3

The panelcn.mops package is based on the cn.mops package and allows to detect copy number
variations (CNVs) from targeted NGS panel data. Please visit http://www.bioinf.jku.at/
software/panelcnmops/index.html for additional information.

2 Getting started and quick start

To load the package, enter the following in your R session:

library(panelcn.mops)
data(panelcn.mops)

The whole pipeline will only take a few steps, if BAM files are available (for read count

matrices directly go to step 2):

1. Getting count windows from the BED file (also see Section 3).

bed <- "Genes_part.bed"
countWindows <- getWindows(bed)

2. Getting read counts (RCs) from BAM file (also see Section 3). Note that the BAM file is
not included so do not try to run this code. However, the resulting test object is included as
part of the data.

testbam <- "SAMPLE1.bam"
test <- countBamListInGRanges(countWindows = countWindows,

bam.files = testbam, read.width = 150)

3. Running the algorithm (also see Section 4).

selectedGenes <- c("ATM")

XandCB <- test
elementMetadata(XandCB) <- cbind(elementMetadata(XandCB),
elementMetadata(control))

resultlist <- runPanelcnMops(XandCB,

testiv = 1:ncol(elementMetadata(test)),
countWindows = countWindows,
selectedGenes = selectedGenes)

4. Visualization of the detected CNV regions. For more information about the result objects

and visualization see Section 5 and Section 6.

4

2 Getting started and quick start

sampleNames <- colnames(elementMetadata(test))
resulttable <- createResultTable(resultlist = resultlist, XandCB = XandCB,

countWindows = countWindows,
selectedGenes = selectedGenes,
sampleNames = sampleNames)

## Calculating results for sample(s) SAMPLE1.bam

## SAMPLE1.bam

## Building table...

## SAMPLE1.bam

## Finished

(tail(resulttable[[1]]))

Exon
11 ATM ATM.E58.chr11.108216439.108216666
11 ATM ATM.E59.chr11.108217975.108218123
11 ATM ATM.E60.chr11.108224462.108224638
11 ATM ATM.E61.chr11.108225507.108225632
11 ATM ATM.E62.chr11.108235778.108235976
11 ATM ATM.E63.chr11.108236021.108236266

RC medRC RC.norm medRC.norm lowQual

736
285
629
533
1043
1312

702
276
629
533
707
934

Sample Chr Gene

##
## 57 SAMPLE1.bam
## 58 SAMPLE1.bam
## 59 SAMPLE1.bam
## 60 SAMPLE1.bam
## 61 SAMPLE1.bam
## 62 SAMPLE1.bam
End
Start
##
969 768.5
## 57 108216439 108216666
375 301.0
## 58 108217975 108218123
828 692.0
## 59 108224462 108224638
701 550.0
## 60 108225507 108225632
## 61 108235778 108235976 1373
793.0
## 62 108236021 108236266 1727 1018.5
CN
##
## 57 CN2
## 58 CN2
## 59 CN2
## 60 CN2
## 61 CN3
## 62 CN3

plotBoxplot(result = resultlist[[1]], sampleName = sampleNames[1],

countWindows = countWindows,
selectedGenes = selectedGenes, showGene = 1)

3 Input

5

3 Input

The most widely used file format for aligned short reads is the Sequence Alignment Map (SAM)
format or in the compressed form the Binary Alignment Map (BAM). panelcn.mops modifies
the read count function countBamInGRanges from the R package exomeCopy to extract read
counts for a list of BAM files. The result object of the function can directly be used as input for
panelcn.mops.

The first step is to extract all regions of interest (ROIs) that define the count windows from a
BED file with the function getWindows. The BED file that is provided is a subset of the TruSight
Cancer Panel BED file.

bed <- system.file("extdata/Genes_part.bed", package = "panelcn.mops")
countWindows <- getWindows(bed)

## naming without chr prefix chosen, but BED contains chr -> removing chr

The BED file should have the following structure:

## chr1 45794947 45795140 MUTYH.E16.chr1.45794947.45795140
## chr1 45796157 45796260 MUTYH.E15.chr1.45796157.45796260
## chr1 45796823 45797037 MUTYH.E14.chr1.45796823.45797037
## chr1 45797061 45797259 MUTYH.E13.chr1.45797061.45797259

050010001500ATMnormalized read countsE2  ( 1 )E4  ( 3 )E6  ( 5 )E8  ( 7 )E10  ( 9 )E12  ( 11 )E14  ( 13 )E16  ( 15 )E18  ( 17 )E20  ( 19 )E22  ( 21 )E24  ( 23 )E26  ( 25 )E28  ( 27 )E30  ( 29 )E32  ( 31 )E34  ( 33 )E36  ( 35 )E38  ( 37 )E40  ( 39 )E42  ( 41 )E44  ( 43 )E46  ( 45 )E48  ( 47 )E50  ( 49 )E52  ( 51 )E54  ( 53 )E56  ( 55 )E58  ( 57 )E60  ( 59 )E62  ( 61 )SAMPLE1.bam6

3 Input

## chr1 45797302 45797552 MUTYH.E12.chr1.45797302.45797552
## chr1 45797664 45797789 MUTYH.E11.chr1.45797664.45797789

While the first 3 columns list chromosome name, start and end position, the fourth column
needs to start with the gene name. Additional information in the fourth column needs to be sepa-
rated with a dot and may include the exon number and further information. By default the "chr"
prefix of the chromosome name is removed if present. This can be changed by setting the chr
parameter to TRUE. If a mismatch of chromosome naming between the countWindows object
and the BAM files is detected, the naming convention of the BAM file is chosen.

In the second step RCs are generated from the BAM files. The read.width parameter reflects
the typical length of the reads that should be counted. Note that the BAM file is not included so
do not try to run this code. However, the resulting test object is included as part of the data.

testbam <- "SAMPLE1.bam"
test <- countBamListInGRanges(countWindows = countWindows,

bam.files = testbam, read.width = 150)

In test you have now stored the genomic segments (left of the |’s) and the read counts (right

of the |’s):

(test)

seqnames
<Rle>

## GRanges object with 370 ranges and 1 metadata column:
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##

[1]
[2]
[3]
[4]
[5]
...
[366]
[367]
[368]
[369]
[370]
-------
seqinfo: 11 sequences from an unspecified genome; no seqlengths

ranges strand | SAMPLE1.bam
<integer>
637
384
414
361
482
...
618
206
572
735
678

<IRanges>
1 45794947-45795140
1 45796157-45796260
1 45796823-45797037
1 45797061-45797259
1 45797302-45797552
...
2 48032018-48032197
2 48032726-48032877
2 48033312-48033528
2 48033560-48033821
2 48033887-48034030

<Rle> |
* |
* |
* |
* |
* |
... .
* |
* |
* |
* |
* |

...

If the BED file contains very large ROIs, a higher resolution of the CNV detection algorithm
can be achieved by splitting up larger ROIs into smaller overlapping bins. This can be achieved
with the funciton splitROIs:

4 runPanelcnMops

7

splitROIs(bed, "newBed.bed")

By default all ROIs are split into bins of 100 bp with an overlap of 50 bp. The parameter
limit controls the minimum size of the ROIs that should be split (default = 0). The parameters
bin and shift control the size of the bins and the no. of bp between start positions of adjacent
bins.

4 runPanelcnMops

The actual copy number analysis is done with the function runPanelcnMops. The function re-
quires a GRanges object of the RCs of test and control samples as well as the countWindows
object used to extract these RCs. Optional parameters include a vector that indicates which sam-
ples to regard as test samples (default = c(1)), a vector of the names of the genes of interest (by
default all genes are of interest), parameters for normalizing the RCs, a vector of expected fold
changes for the copy number classes and a minimal median RC over all samples to exclude low
coverage ROIs.

selectedGenes <- "ATM"

XandCB <- test
elementMetadata(XandCB) <- cbind(elementMetadata(XandCB),
elementMetadata(control))

resultlist <- runPanelcnMops(XandCB, countWindows = countWindows,

selectedGenes = selectedGenes)

5 Results

The function runPanelcnMops returns a list of objects of the S4 class CNVDetectionResult, one
CNVDetectionResult object per test sample. The structure of the CNVDetectionResult object can
be listed by calling

(str(resultlist[[1]]))

To get detailed information on which data are stored in such objects, enter

help(CNVDetectionResult)

The CNVs per individual are stored in the slot integerCopyNumber:

integerCopyNumber(resultlist[[1]])[1:5]

8

5 Results

* |
* |
* |
* |
* |

[1]
[2]
[3]
[4]
[5]

seqnames
<Rle>

1 45794947-45795140
1 45796157-45796260
1 45796823-45797037
1 45797061-45797259
1 45797302-45797552

## GRanges object with 5 ranges and 5 metadata columns:
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##

ranges strand | SAMPLE1.bam
<IRanges> <Rle> | <character>
CN2
CN2
CN2
CN2
CN2
SAMPLE4.bam SAMPLE3.bam SAMPLE6.bam SAMPLE2.bam
<character> <character> <character> <character>
CN2
CN2
CN2
CN2
CN2

[1]
[2]
[3]
[4]
[5]
-------
seqinfo: 11 sequences from an unspecified genome; no seqlengths

CN2
CN2
CN2
CN2
CN2

CN2
CN2
CN2
CN2
CN2

CN2
CN2
CN2
CN2
CN2

The function createResultTable summarizes all relevant information for user selected genes

of interest in a list of tables with one table per test sample:

sampleNames <- colnames(elementMetadata(test))
resulttable <- createResultTable(resultlist = resultlist, XandCB = XandCB,

countWindows = countWindows,
selectedGenes = selectedGenes,
sampleNames = sampleNames)

## Calculating results for sample(s) SAMPLE1.bam

## SAMPLE1.bam

## Building table...

## SAMPLE1.bam

## Finished

(tail(resulttable[[1]]))

Sample Chr Gene

##
## 57 SAMPLE1.bam
## 58 SAMPLE1.bam
## 59 SAMPLE1.bam
## 60 SAMPLE1.bam
## 61 SAMPLE1.bam
## 62 SAMPLE1.bam
End
Start
##
## 57 108216439 108216666

Exon
11 ATM ATM.E58.chr11.108216439.108216666
11 ATM ATM.E59.chr11.108217975.108218123
11 ATM ATM.E60.chr11.108224462.108224638
11 ATM ATM.E61.chr11.108225507.108225632
11 ATM ATM.E62.chr11.108235778.108235976
11 ATM ATM.E63.chr11.108236021.108236266

RC

medRC RC.norm medRC.norm lowQual

969 768.5

736

702

6 Visualization of results

9

285
629
533
1043
1312

276
629
533
707
934

375 301.0
## 58 108217975 108218123
828 692.0
## 59 108224462 108224638
701 550.0
## 60 108225507 108225632
## 61 108235778 108235976 1373
793.0
## 62 108236021 108236266 1727 1018.5
##
CN
## 57 CN2
## 58 CN2
## 59 CN2
## 60 CN2
## 61 CN3
## 62 CN3

The table contains one line per Region Of Interest (ROI) with information about the RCs
of the test sample ("RC"), the median RCs of all control samples ("medRC"), the normalized
RCs of the test sample ("RC.norm"), the median of the normalized RCs of all control samples
("medRC.norm"), as well as the estimated CN ("CN"). Additionally, in the column "lowQual"
low quality ROIs are flagged.

6 Visualization of results

panelcn.mops contains a plotting function that visualizes the normalized RCs of the samples
analyzed as boxplots:

plotBoxplot(result = resultlist[[1]], sampleName = sampleNames[1],

countWindows = countWindows,
selectedGenes = selectedGenes, showGene = 1)

10

8 Quality control

The function expects a single CNVDetectionResult object as input together with the name of
the test sample, the countWindows used, as well as a vector with the names of the genes of interest
and an integer specifying which of the genes of interest to plot.

7 Analysis of chromosome X

The analysis of ROIs on chromosome X is only possible if all samples have the same sex and the
parameter sex of the function runPanelcnMops is set accordingly. The default "mixed" results in
the removal of all X-chromosomal ROIs. Note, that if all samples are males CN2 in the results
really corresponds to CN1.

8 Quality control

The panelcn.MOPS algorithm includes different quality control metrics. 1) ROIs are excluded if
their median read count (RC) across all samples does not exceed a user defined threshold (default:
30), additionally a warning message is displayed. 2) ROIs are marked as "low quality" in the result
table if their RCs show a high variation across all samples. 3) Samples with a median RC across
all ROIs lower than 0.55 times the median of all samples are considered as low quality. 4) For
each ROI the ratio between the normalized RCs of each sample compared to the median across
all samples is calculated. Samples that show a high variation in these RC ratios are also flagged
as low quality. Low quality samples are excluded if they are control samples which leads to a
warning message. If a test sample is of low quality, only a warning message is displayed.

050010001500ATMnormalized read countsE2  ( 1 )E4  ( 3 )E6  ( 5 )E8  ( 7 )E10  ( 9 )E12  ( 11 )E14  ( 13 )E16  ( 15 )E18  ( 17 )E20  ( 19 )E22  ( 21 )E24  ( 23 )E26  ( 25 )E28  ( 27 )E30  ( 29 )E32  ( 31 )E34  ( 33 )E36  ( 35 )E38  ( 37 )E40  ( 39 )E42  ( 41 )E44  ( 43 )E46  ( 45 )E48  ( 47 )E50  ( 49 )E52  ( 51 )E54  ( 53 )E56  ( 55 )E58  ( 57 )E60  ( 59 )E62  ( 61 )SAMPLE1.bam9 Adjusting sensitivity and specificity

11

9 Adjusting sensitivity and specificity

The default parameters of the panelcn.mops algorithm were optimized on a data set of targeted
NGS panel data with the aim of detecting CNVs ranging in size from part of a ROI to whole genes.
However, you might want to adjust sensitivity and specificity to your specific needs.

The parameter that influences sensitivity and specificity the most is I, the vector of expected
fold changes of the copy number classes. The default for panelcn.mops c(0.025, 0.57, 1, 1.46,
2), leads to a higher sensitivity compared to the default of cn.mops which is c(0.025, 0.5, 1, 1.5,
2). Increasing the values for CN0 and CN1 further and decreasing the values for CN3 and CN4
may help to improve the sensitivity, a change in the other direction may increase the specificity.

Additional parameters that can be tuned to improve the results are the different normalization

parameters: normType, sizeFactor, qu, quSizeFactor, and norm.

10 How to cite this package

If you use this package for research that is published later, you are kindly asked to cite it as follows:
(Povysil et al., 2017).

To obtain BibTEX entries of the reference, you can enter the following into your R session:

toBibtex(citation("panelcn.mops"))

References

Povysil, G., Tzika, A., Vogt, J., Haunschmid, V., Messiaen, L., Zschocke, J., Klambauer, G., Hochreiter, S., and Wimmer, K. (2017). panelcn.MOPS:

Copy number detection in targeted NGS panel data for clinical diagnostics. Human Mutation.

