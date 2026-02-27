CNVPanelizer: Reliable CNV detection in target
sequencing applications

Oliveira, Cristiano
cristiano.oliveira@med.uni-heidelberg.de

Wolf, Thomas
thomas_Wolf71@gmx.de

October 29, 2025

Amplicon based targeted sequencing, over the last few years, has become a mainstay in the clini-
cal use of next generation sequencing technologies. For the detection of somatic and germline SNPs
this has been proven to be a highly robust methodology. One area of genomic analysis which is usu-
ally not covered by targeted sequencing, is the detection of copy number variations (CNVs). While a
large number of available algorithms and software address the problem of CNV detection in whole
genome or whole exome sequencing, there are no such established tools for amplicon based targeted
sequencing. We introduced a novel algorithm for the reliable detection of CNVs from targeted se-
quencing.

1 Introduction

To assess if a region specific change in read counts correlates with the presence of CNVs, we imple-
mented an algorithm that uses a subsampling strategy similar to Random Forest to reliable predict the
presence of CNVs. We also introduce a novel method to correct for the background noise introduced
by sequencing genes with a low number of amplicons. To make it available to the community we
implemented the algorithm as an R package.

2 Using

This section provides an overview of the package functions.

2.1

Installing and Loading the package

The package is available through the Bioconductor repository and can be installed and loaded using
the following R commands:

# To install from Bioconductor
if (!requireNamespace("BiocManager", quietly=TRUE))

install.packages("BiocManager")

BiocManager::install("CNVPanelizer")

# To load the package
library(CNVPanelizer)

1

2.2 Reading data

2.2.1 BED file

The BED file is required to obtain amplicon and gene name information associated with the panel.

# Bed file defining the amplicons
bedFilepath <- "/somePath/someFile.bed"

# The column number of the gene Names in the BED file.
amplColumnNumber <- 4

# Extract the information from a bed file
genomicRangesFromBed <- BedToGenomicRanges(bedFilepath,

ampliconColumn = amplColumnNumber,
split = "_")

metadataFromGenomicRanges <- elementMetadata(genomicRangesFromBed)
geneNames = metadataFromGenomicRanges["geneNames"][, 1]
ampliconNames = metadataFromGenomicRanges["ampliconNames"][, 1]

2.2.2 Selecting files

Two sets of data are required. The samples of interest and the set of reference bam files to compare
against.

# Directory with the test data
sampleDirectory <- "/somePathToTestData"

# Directory with the reference data
referenceDirectory <- "/somePathToReferenceData"

# Vector with test filenames
sampleFilenames <- list.files(path = sampleDirectory,

pattern = ".bam$",
full.names = TRUE)

# Vector with reference filenames
referenceFilenames <- list.files(path = referenceDirectory,

pattern = ".bam$",
full.names = TRUE)

2.2.3 Counting reads

The reads were counted using a wrapper function around the ExomeCopy package from the Biocon-
ductor project. All reads overlapping with the region of an amplicon were counted for this amplicon.
Only reads with a mapping quality ≥ 20 were counted and the function allows to remove PCR Dupli-
cates. For reads with the same start site, end site and chromosomal orientation only one is kept. PCR
duplicates might cause a bias for the ratio between reference and the samples of interest. Thus this
serves as an additional quality control step in the CNV detection pipeline. It is only recommended for
Ion Torrent generated data. For Illumina data this step is not recommended.

2

# Should duplicated reads (same start, end site and strand) be removed
removePcrDuplicates <- FALSE # TRUE is only recommended for Ion Torrent data

# Read the Reference data set
referenceReadCounts <- ReadCountsFromBam(referenceFilenames,

genomicRangesFromBed,
sampleNames = referenceFilenames,
ampliconNames = ampliconNames,
removeDup = removePcrDuplicates)

# Read the sample of interest data set
sampleReadCounts <- ReadCountsFromBam(sampleFilenames,

genomicRangesFromBed,
sampleNames = sampleFilenames,
ampliconNames = ampliconNames,
removeDup = removePcrDuplicates)

2.2.4 Using Synthetic Data

We also make available synthetic data to test the functions. The following examples make use of two
generated data sets, one for the reference and the other as a testing set

data(sampleReadCounts)
data(referenceReadCounts)

# Gene names should be same size as row columns
# For real data this is a vector of the genes associated
# with each row/amplicon. For example Gene1, Gene1, Gene2, Gene2, Gene3, ...
geneNames <- row.names(referenceReadCounts)

# Not defined for synthetic data
# For real data this gives a unique name to each amplicon.
# For example Gene1:Amplicon1, Gene1:Amplicon2, Gene2:Amplicon1,
# Gene2:Amplicon2, Gene3:Amplicon1 ...
ampliconNames <- NULL

2.3 Normalization

To account for sample and sequencing run specific variations the counts obtained for each sample
were normalized using a wrapper function around the tmm normalization function from the NOISeq
package.

normalizedReadCounts <- CombinedNormalizedCounts(sampleReadCounts,

referenceReadCounts,
ampliconNames = ampliconNames)

# After normalization data sets need to be splitted again to perform bootstrap
samplesNormalizedReadCounts = normalizedReadCounts["samples"][[1]]
referenceNormalizedReadCounts = normalizedReadCounts["reference"][[1]]

2.4 Bootstrap based CNV

This aproach is similar to the Random Forest method, which bootstraps the samples and subsamples
the features. In our case features would be equivalent to amplicons. The subsampling procedure is
repeated n times to generate a large set of randomized synthetic references B = b1, . . . , bn by selecting

3

with replacement (bootstrapping) from the set of reference samples. The ratio between the sample of
interest and each randomized reference is calculated for each gene, using only a randomly selected
subset of amplicons. To get an estimate of significance, the 95 percent confidence interval of the
bootstrapping/subsampling ratio distribution was calculated. A significant change is considered as an
amplification for a lower bound ratio > 1 and a deletion for an upper bound ratio < 1. The confidence
interval was calculated using the 0.025 and 0.975 percent quantiles of the bootstrapping/subsampling
ratio distribution.

# Number of bootstrap replicates to be used
replicates <- 10000

# Perform the bootstrap based analysis
bootList <- BootList(geneNames,

samplesNormalizedReadCounts,
referenceNormalizedReadCounts,
replicates = replicates)

2.5 Background Estimation

Not all genes have the same number of amplicons |AG| and it has been shown that sequencing genes
with a higher number of amplicons yields better sensitivity and specifity when detecting putative
copy number variations. Still genes sequenced with a low number of amplicons might still show
significant changes in observed read counts. While normalization makes the comparison of read
counts comparable between samples, genes with a small number of amplicons might still show a
bias. To quantify the effect of a low number of amplicons on the calling of CNVs we introduced a
background noise estimation procedure. Using the ratio between the mean reference and the sample
used for calling we subsample for each unique number of amplicons. In the case of two amplicons
we repeatedly sample two random amplicons from the set of all amplicons, and average the ratios.
Amplicons that belong to genes showing significant copy number variations Gsig are not included in
the subsampling pool. Each amplicon is weighted according to the number of amplicons the respective
gene has wA = 1
|Ag| . Thus the probablity of sampling from a gene is the same regardless of the number
amplicons. For each number of amplicons a background noise distribution is estimated. The reported
background is defined by the lower noise meanNoise + qnorm(0.025) ∗ standardDeviationNoise and the
upper noise meanNoise + qnorm(0.975) ∗ standardDeviationNoise of the respective distribution. This
defines the 95 percent confidence interval. The significance level can also be passed as parameter. Less
conservative detection can be achieved by setting the significanceLevel = 0.1. To calculate the mean
and standard deviation (sd) of ratios the log ratios were used. If setting robust = TRUE, median is
used instead of mean and mad (median absolute deviation) replaces sd. The upper bound ratio has to
be below the lower noise (deletion) or the lower bound ratio above the upper noise (amplification) to
be considered reliable.

# Estimate the background noise left after normalization
backgroundNoise <- Background(geneNames,

samplesNormalizedReadCounts,
referenceNormalizedReadCounts,
bootList,
replicates = replicates,
significanceLevel = 0.1,
robust = TRUE)

2.6 Results

To analyse the results we provide two outputs. A plot which shows the detected variations, and a
report table with more detailed information about those variations.

4

2.6.1 Report

The report describes the bootstrap distribution for each gene. An example can be found in figure 1.
The final report is genewise, and is based on the bootstrapping.

# Build report tables
reportTables <- ReportTables(geneNames,

samplesNormalizedReadCounts,
referenceNormalizedReadCounts,
bootList,
backgroundNoise)

At the figure 1 we can see an example of the report table for a single sample.

5

##
## Gene_01
## Gene_02
## Gene_03
## Gene_04
## Gene_05
## Gene_06
## Gene_07
## Gene_08
## Gene_09
## Gene_10
## Gene_11
## Gene_12
## Gene_13
## Gene_14
## Gene_15
## Gene_16
## Gene_17
## Gene_18
## Gene_19
## Gene_20

6

LowerBoundBoot MeanBoot UpperBoundBoot LowerNoise MeanNoise UpperNoise Signif. AboveNoise Amplicons PutativeStatus ReliableStatus
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Amplification
Normal
Normal
Normal

Normal
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Normal
Deletion
Deletion
Normal
Amplification
Deletion
Normal
Normal

FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
TRUE
FALSE
FALSE
FALSE

FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
FALSE
TRUE
TRUE
FALSE
TRUE
TRUE
FALSE
FALSE

0.53
0.56
0.53
0.58
0.59
0.48
0.55
0.58
0.55
0.55
0.59
0.55
0.56
0.55
0.48
0.58
0.51
0.48
0.53
0.59

0.85
0.82
0.85
0.82
0.82
0.91
0.84
0.82
0.84
0.84
0.82
0.84
0.83
0.84
0.91
0.82
0.87
0.91
0.85
0.82

1.37
1.19
1.37
1.16
1.14
1.70
1.29
1.16
1.29
1.29
1.14
1.29
1.24
1.29
1.70
1.16
1.48
1.70
1.37
1.14

0.18
0.46
0.6
0.22
0.21
0.87
0.37
0.11
0.6
0.27
0.36
1
0.1
0.06
0.26
0.61
2
0.33
0.29
0.64

2.73
1.7
1.59
2
1.09
2.08
1.04
1.46
1.69
1.34
1.73
2
1.61
0.98
0.87
2.21
2.87
0.9
1.05
1.9

0.69
0.87
0.98
0.7
0.49
1.32
0.6
0.5
1.02
0.66
0.79
1.4
0.57
0.28
0.47
1.24
2.35
0.53
0.54
1.15

4
7
4
8
9
2
5
8
5
5
9
5
6
5
2
8
3
2
4
9

Figure 1: Sample report table.

LowerBoundBoot | MeanBoot | UpperBoundBoot The confidence interval of the Bootstrap distribution
The Lower/Mean/Upper background noise bounds
Lower | Mean | Upper Noise
Boolean value representing if read counts differences are Significant
Signif.
Boolean value representing if LowerBoundBoot is above UpperNoise (UpperBoundBoot below
AboveNoise
LowerNoise)
Number of Amplicons associated with the gene
The detected level of change
if both Signif. and AboveNoise are TRUE then 2, if only one is TRUE then 1 and if both are
FALSE then 0

Amplicons
PutativeStatus
Passed

Table 1: Report table Column Description

2.6.2 Plots

The generated plots (one per test sample) show the bootstrap distribution for each gene. The function
PlotBootstrapDistributions generates a list of plots for all test samples (A plot per sample). At the
figure 2 we can see an example of the plot for a single sample.

PlotBootstrapDistributions(bootList, reportTables)

2.7 Shiny App

To allow a more user friendly interaction and quick testing of CNVPanelizer, a shiny app is made
available through the following command:

# default port is 8100
RunCNVPanelizerShiny(port = 8080)

7

8

Figure 2: Plot for a single test sample

No Change
Non Reliable Change The change is significant but below the noise level for the number of amplicons associated with

There is no change in the read count

Reliable Change

this gene
The change is above the noise level and significant

Table 2: Description of the CNV detection levels

−10−50510Gene_01Gene_02Gene_03Gene_04Gene_05Gene_06Gene_07Gene_08Gene_09Gene_10Gene_11Gene_12Gene_13Gene_14Gene_15Gene_16Gene_17Gene_18Gene_19Gene_20Gene Nameslog2(ratios)CNV ReliabilityNoChangeNonReliableChangeReliableChangeSample_2