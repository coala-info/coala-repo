metagenomeSeq: Statistical analysis for sparse
high-throughput sequencing

Joseph Nathaniel Paulson

Applied Mathematics & Statistics, and Scientific Computation
Center for Bioinformatics and Computational Biology
University of Maryland, College Park

jpaulson@umiacs.umd.edu

Modified: October 4, 2016. Compiled: October 30, 2025

Contents

1 Introduction

2 Data preparation

2.1 Biom-Format . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Loading count data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3 Loading taxonomy . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.4 Loading metadata . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.5 Creating a MRexperiment object . . . . . . . . . . . . . . . . . . . . . . . . . .
2.6 Example datasets . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.7 Useful commands . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Normalization

3.1 Calculating normalization factors . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.1.1 Calculating normalization factors using Wrench . . . . . . . . . . . . . . .
3.2 Exporting data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Statistical testing

4.2 Zero-inflated Gaussian mixture model

4.1 Zero-inflated Log-Normal mixture model for each feature . . . . . . . . . . . . . .
4.1.1 Example using fitFeatureModel for differential abundance testing . . . . .
. . . . . . . . . . . . . . . . . . . . . . . .
4.2.1 Example using fitZig for differential abundance testing . . . . . . . . . . .
4.2.2 Multiple groups . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2.3 Exporting fits . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.3 Time series analysis
4.4 Log Normal permutation test . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.5 Presence-absence testing . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.6 Discovery odds ratio testing . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.7 Feature correlations
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.8 Unique OTUs or features

3

4
4
5
5
6
6
7
9

14
14
14
15

16
16
16
16
17
19
20
20
21
21
22
23
23

1

5 Aggregating counts

6 Visualization of features

6.1
Interactive Display . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.2 Structural overview . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.3 Feature specific . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

7 Summary

7.1 Citing metagenomeSeq . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7.2 Session Info . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

8 Appendix

8.1 Appendix A: MRexperiment internals
8.2 Appendix B: Mathematical model
8.3 Appendix C: Calculating the proper percentile

. . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . .

25

26
26
26
28

31
31
31

33
33
33
33

2

1 Introduction

This is a vignette for pieces of an association study pipeline. For a full list of
functions available in the package: help(package=metagenomeSeq). For more in-
formation about a particular function call: ?function. See fitFeatureModel for our latest
development.

To load the metagenomeSeq library:

library(metagenomeSeq)

Metagenomics is the study of genetic material targeted directly from an environmental com-
munity. Originally focused on exploratory and validation projects, these studies now focus on
understanding the differences in microbial communities caused by phenotypic differences. Ana-
lyzing high-throughput sequencing data has been a challenge to researchers due to the unique
biological and technological biases that are present in marker-gene survey data.

We present a R package, metagenomeSeq, that implements methods developed to account
for previously unaddressed biases specific to high-throughput sequencing microbial marker-gene
survey data. Our method implements a novel normalization technique and method to account
for sparsity due to undersampling. Other methods include White et al.’s Metastats and Segata
et al.’s LEfSe. The first is a non-parametric permutation test on t-statistics and the second is a
non-parametric Kruskal-Wallis test followed by subsequent wilcox rank-sum tests on subgroups
to guard against positive discoveries of differential abundance driven by potential confounders -
neither address normalization nor sparsity.

This vignette describes the basic protocol when using metagenomeSeq. A normalization
method able to control for biases in measurements across taxonomic features and a mixture
model that implements a zero-inflated Gaussian distribution to account for varying depths of
coverage are implemented. Using a linear model methodology, it is easy to include confounding
sources of variability and interpret results. Additionally, visualization functions are provided to
examine discoveries.

The software was designed to determine features (be it Operational Taxonomic Unit (OTU),
species, etc.) that are differentially abundant between two or more groups of multiple samples.
The software was also designed to address the effects of both normalization and undersampling
of microbial communities on disease association detection and testing of feature correlations.

3

Figure 1: General overview. metagenomeSeq requires the user to convert their data into MR-
experiment objects. Using those MRexperiment objects, one can normalize their data, run
statistical tests (abundance or presence-absence), and visualize or save results.

2 Data preparation

Microbial marker-gene sequence data is preprocessed and counts are algorithmically defined from
project-specific sequence data by clustering reads according to read similarity. Given m features
and n samples, the elements in a count matrix C (m, n), cij, are the number of reads annotated
for a particular feature i (whether it be OTU, species, genus, etc.) in sample j.

f eature1
f eature2
...
f eaturem









sample1
c11
c21
...
cm1

sample2
c12
c22
...
cm2

. . .
. . .
. . .
. . .
. . .

samplen
c1n
c2n
...
cmn









Count data should be stored in a delimited (tab by default) file with sample names along

the first row and feature names along the first column.

Data is prepared and formatted as a MRexperiment object. For an overview of the internal

structure please see Appendix A.

2.1 Biom-Format

You can load in BIOM file format data, the output of many commonly used, using the loadBiom
function. The biom2MRexperiment and MRexperiment2biom functions serve as a gateway
between the biom-class object defined in the biom package and a MRexperiment-class
object. BIOM format files IO is available thanks to the biomformat package.

As an example, we show how one can read in a BIOM file and convert it to a MRexperiment

object.

4

Prepare MRexperiment objectNormalizationStatistical testingStep 1Step 2Step 3metagenomeSeq overview1. Visualize data2. Save results1. Abundance2. P/A# reading in a biom file
library(biomformat)
biom_file <- system.file("extdata", "min_sparse_otu_table.biom",

package = "biomformat")

b <- read_biom(biom_file)
biom2MRexperiment(b)

element names: counts

## MRexperiment (storageMode: environment)
## assayData: 5 features, 6 samples
##
## protocolData: none
## phenoData: none
## featureData: none
## experimentData: use 'experimentData(object)'
## Annotation:

As an example, we show how one can write a MRexperiment object out as a BIOM file.

Here is an example writing out the mouseData MRexperiment object to a BIOM file.

data(mouseData)
# options include to normalize or not
b <- MRexperiment2biom(mouseData)
write_biom(b, biom_file = "˜/Desktop/otu_table.biom")

2.2 Loading count data

Following preprocessing and annotation of sequencing data metagenomeSeq requires a count
matrix with features along rows and samples along the columns. metagenomeSeq includes
functions for loading delimited files of counts loadMeta and phenodata loadPhenoData.

As an example, a portion of the lung microbiome [1] OTU matrix is provided in metagenomeSeq’s

library ”extdata” folder. The OTU matrix is stored as a tab delimited file. loadMeta loads
the taxa and counts into a list.

dataDirectory <- system.file("extdata", package = "metagenomeSeq")
lung = loadMeta(file.path(dataDirectory, "CHK_NAME.otus.count.csv"))
dim(lung$counts)

## [1] 1000

78

2.3 Loading taxonomy

Next we want to load the annotated taxonomy. Check to make sure that your taxa annotations
and OTUs are in the same order as your matrix rows.

taxa = read.delim(file.path(dataDirectory, "CHK_otus.taxonomy.csv"),

stringsAsFactors = FALSE)

As our OTUs appear to be in order with the count matrix we loaded earlier, the next step

is to load phenodata.

Warning: features need to have the same names as the rows of the count matrix when we

create the MRexperiment object for provenance purposes.

5

2.4 Loading metadata

Phenotype data can be optionally loaded into R with loadPhenoData. This function loads
the data as a list.

clin = loadPhenoData(file.path(dataDirectory, "CHK_clinical.csv"),

tran = TRUE)

ord = match(colnames(lung$counts), rownames(clin))
clin = clin[ord, ]
head(clin[1:2, ])

##
SampleType
## CHK_6467_E3B11_BRONCH2_PREWASH_V1V2 Bronch2.PreWash
## CHK_6467_E3B11_OW_V1V2
OW
##
SiteSampled
## CHK_6467_E3B11_BRONCH2_PREWASH_V1V2 Bronchoscope.Channel
OralCavity
## CHK_6467_E3B11_OW_V1V2
##
## CHK_6467_E3B11_BRONCH2_PREWASH_V1V2
## CHK_6467_E3B11_OW_V1V2

SmokingStatus
Smoker
Smoker

Warning: phenotypes must have the same names as the columns on the count matrix when

we create the MRexperiment object for provenance purposes.

2.5 Creating a MRexperiment object

Function newMRexperiment takes a count matrix, phenoData (annotated data frame), and
featureData (annotated data frame) as input. Biobase provides functions to create annotated
data frames. Library sizes (depths of coverage) and normalization factors are also optional
inputs.

phenotypeData = AnnotatedDataFrame(clin)
phenotypeData

rowNames: CHK_6467_E3B11_BRONCH2_PREWASH_V1V2

## An object of class 'AnnotatedDataFrame'
##
##
##
##
##

CHK_6467_E3B11_OW_V1V2 ...
CHK_6467_E3B09_BAL_A_V1V2 (78 total)

varLabels: SampleType SiteSampled SmokingStatus
varMetadata: labelDescription

A feature annotated data frame. In this example it is simply the OTU numbers, but it can

as easily be the annotated taxonomy at multiple levels.

OTUdata = AnnotatedDataFrame(taxa)
OTUdata

## An object of class 'AnnotatedDataFrame'
##
##
##

rowNames: 1 2 ... 1000 (1000 total)
varLabels: OTU Taxonomy ... strain (10 total)
varMetadata: labelDescription

6

obj = newMRexperiment(lung$counts,phenoData=phenotypeData,featureData=OTUdata)
# Links to a paper providing further details can be included optionally.
# experimentData(obj) = annotate::pmid2MIAME("21680950")
obj

element names: counts

sampleNames: CHK_6467_E3B11_BRONCH2_PREWASH_V1V2

CHK_6467_E3B11_OW_V1V2 ...
CHK_6467_E3B09_BAL_A_V1V2 (78 total)

## MRexperiment (storageMode: environment)
## assayData: 1000 features, 78 samples
##
## protocolData: none
## phenoData
##
##
##
##
##
## featureData
##
##
##
## experimentData: use 'experimentData(object)'
## Annotation:

featureNames: 1 2 ... 1000 (1000 total)
fvarLabels: OTU Taxonomy ... strain (10 total)
fvarMetadata: labelDescription

varLabels: SampleType SiteSampled SmokingStatus
varMetadata: labelDescription

2.6 Example datasets

There are two datasets included as examples in the metagenomeSeq package. Data needs to
be in a MRexperiment object format to normalize, run statistical tests, and visualize. As an
example, throughout the vignette we’ll use the following datasets. To understand a function’s
usage or included data simply enter ?functionName.

1. Human lung microbiome [1]: The lung microbiome consists of respiratory flora sampled
from six healthy individuals. Three healthy nonsmokers and three healthy smokers. The
upper lung tracts were sampled by oral wash and oro-/nasopharyngeal swabs. Samples
were taken using two bronchoscopes, serial bronchoalveolar lavage and lower airway pro-
tected brushes.

data(lungData)
lungData

sampleNames: CHK_6467_E3B11_BRONCH2_PREWASH_V1V2

element names: counts

## MRexperiment (storageMode: environment)
## assayData: 51891 features, 78 samples
##
## protocolData: none
## phenoData
##
##
##
##
##
## featureData
##

CHK_6467_E3B11_OW_V1V2 ...
CHK_6467_E3B09_BAL_A_V1V2 (78 total)

featureNames: 1 2 ... 51891 (51891 total)

varLabels: SampleType SiteSampled SmokingStatus
varMetadata: labelDescription

7

fvarLabels: taxa
fvarMetadata: labelDescription

##
##
## experimentData: use 'experimentData(object)'
## Annotation:

2. Humanized gnotobiotic mouse gut [2]: Twelve germ-free adult male C57BL/6J mice were
fed a low-fat, plant polysaccharide-rich diet. Each mouse was gavaged with healthy adult
human fecal material. Following the fecal transplant, mice remained on the low-fat, plant
polysacchaaride-rich diet for four weeks, following which a subset of 6 were switched to a
high-fat and high-sugar diet for eight weeks. Fecal samples for each mouse went through
PCR amplification of the bacterial 16S rRNA gene V2 region weekly. Details of exper-
imental protocols and further details of the data can be found in Turnbaugh et. al.
Sequences and further information can be found at: http://gordonlab.wustl.edu/
TurnbaughSE_10_09/STM_2009.html

data(mouseData)
mouseData

element names: counts

PM9:20080303 (139 total)

sampleNames: PM1:20080107 PM1:20080108 ...

## MRexperiment (storageMode: environment)
## assayData: 10172 features, 139 samples
##
## protocolData: none
## phenoData
##
##
##
##
## featureData
##
##
##
##
## experimentData: use 'experimentData(object)'
## Annotation:

varLabels: mouseID date ... status (5 total)
varMetadata: labelDescription

... Parabacteroides:956 (10172 total)

fvarLabels: superkingdom phylum ... OTU (7 total)
fvarMetadata: labelDescription

featureNames: Prevotellaceae:1 Lachnospiraceae:1

8

2.7 Useful commands

Phenotype information can be accessed with the phenoData and pData methods:

phenoData(obj)

sampleNames: CHK_6467_E3B11_BRONCH2_PREWASH_V1V2

## An object of class 'AnnotatedDataFrame'
##
##
##
##
##

CHK_6467_E3B11_OW_V1V2 ...
CHK_6467_E3B09_BAL_A_V1V2 (78 total)

varLabels: SampleType SiteSampled SmokingStatus
varMetadata: labelDescription

head(pData(obj), 3)

##
SampleType
## CHK_6467_E3B11_BRONCH2_PREWASH_V1V2 Bronch2.PreWash
OW
## CHK_6467_E3B11_OW_V1V2
## CHK_6467_E3B08_OW_V1V2
OW
SiteSampled
##
## CHK_6467_E3B11_BRONCH2_PREWASH_V1V2 Bronchoscope.Channel
OralCavity
## CHK_6467_E3B11_OW_V1V2
## CHK_6467_E3B08_OW_V1V2
OralCavity
##
## CHK_6467_E3B11_BRONCH2_PREWASH_V1V2
## CHK_6467_E3B11_OW_V1V2
## CHK_6467_E3B08_OW_V1V2

SmokingStatus
Smoker
Smoker
NonSmoker

Feature information can be accessed with the featureData and fData methods:

featureData(obj)

## An object of class 'AnnotatedDataFrame'
##
##
##

featureNames: 1 2 ... 1000 (1000 total)
varLabels: OTU Taxonomy ... strain (10 total)
varMetadata: labelDescription

head(fData(obj)[, -c(2, 10)], 3)

1
2
3

<NA>

order

OTU superkingdom

phylum
Bacteria Proteobacteria
<NA>

class
Epsilonproteobacteria
<NA>
Bacteria Actinobacteria Actinobacteria (class)

##
## 1
## 2
## 3
##
genus
## 1 Campylobacterales Campylobacteraceae Campylobacter
## 2
<NA>
Actinomyces
## 3
species
##
Campylobacter rectus
## 1
<NA>
## 2
## 3 Actinomyces radicidentis

<NA>
Actinomycetaceae

<NA>
Actinomycetales

family

9

The raw or normalized counts matrix can be accessed with the MRcounts function:

head(MRcounts(obj[, 1:2]))

##
## 1
## 2
## 3
## 4
## 5
## 6
##
## 1
## 2
## 3
## 4
## 5
## 6

CHK_6467_E3B11_BRONCH2_PREWASH_V1V2
0
0
0
0
0
0

CHK_6467_E3B11_OW_V1V2
0
0
0
0
0
0

A MRexperiment-class object can be easily subsetted, for example:

featuresToKeep = which(rowSums(obj) >= 100)
samplesToKeep = which(pData(obj)$SmokingStatus == "Smoker")
obj_smokers = obj[featuresToKeep, samplesToKeep]
obj_smokers

element names: counts

sampleNames: CHK_6467_E3B11_BRONCH2_PREWASH_V1V2

CHK_6467_E3B11_OW_V1V2 ...
CHK_6467_E3B09_BAL_A_V1V2 (33 total)

## MRexperiment (storageMode: environment)
## assayData: 1 features, 33 samples
##
## protocolData: none
## phenoData
##
##
##
##
##
## featureData
##
##
##
## experimentData: use 'experimentData(object)'
## Annotation:

featureNames: 570
fvarLabels: OTU Taxonomy ... strain (10 total)
fvarMetadata: labelDescription

varLabels: SampleType SiteSampled SmokingStatus
varMetadata: labelDescription

head(pData(obj_smokers), 3)

SampleType
##
## CHK_6467_E3B11_BRONCH2_PREWASH_V1V2 Bronch2.PreWash
## CHK_6467_E3B11_OW_V1V2
OW
## CHK_6467_E3B11_BAL_A_V1V2
BAL.A
SiteSampled
##
## CHK_6467_E3B11_BRONCH2_PREWASH_V1V2 Bronchoscope.Channel
OralCavity
## CHK_6467_E3B11_OW_V1V2

10

## CHK_6467_E3B11_BAL_A_V1V2
##
## CHK_6467_E3B11_BRONCH2_PREWASH_V1V2
## CHK_6467_E3B11_OW_V1V2
## CHK_6467_E3B11_BAL_A_V1V2

SmokingStatus
Smoker
Smoker
Smoker

Lung

Alternative normalization scaling factors can be accessed or replaced with the normFactors

method:

head(normFactors(obj))

##
## CHK_6467_E3B11_BRONCH2_PREWASH_V1V2
## CHK_6467_E3B11_OW_V1V2
## CHK_6467_E3B08_OW_V1V2
## CHK_6467_E3B07_BAL_A_V1V2
## CHK_6467_E3B11_BAL_A_V1V2
## CHK_6467_E3B09_OP_V1V2

[,1]
NA
NA
NA
NA
NA
NA

normFactors(obj) <- rnorm(ncol(obj))
head(normFactors(obj))

## CHK_6467_E3B11_BRONCH2_PREWASH_V1V2
##
1.3709584
CHK_6467_E3B11_OW_V1V2
##
##
-0.5646982
CHK_6467_E3B08_OW_V1V2
##
##
0.3631284
CHK_6467_E3B07_BAL_A_V1V2
##
##
0.6328626
CHK_6467_E3B11_BAL_A_V1V2
##
##
0.4042683
CHK_6467_E3B09_OP_V1V2
##
-0.1061245
##

Library sizes (sequencing depths) can be accessed or replaced with the libSize method:

head(libSize(obj))

##
## CHK_6467_E3B11_BRONCH2_PREWASH_V1V2
## CHK_6467_E3B11_OW_V1V2
## CHK_6467_E3B08_OW_V1V2
## CHK_6467_E3B07_BAL_A_V1V2
## CHK_6467_E3B11_BAL_A_V1V2
## CHK_6467_E3B09_OP_V1V2

[,1]
0
16
1
2
118
5

libSize(obj) <- rnorm(ncol(obj))
head(libSize(obj))

## CHK_6467_E3B11_BRONCH2_PREWASH_V1V2
-0.88577630
##

11

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

CHK_6467_E3B11_OW_V1V2
-1.09978090
CHK_6467_E3B08_OW_V1V2
1.51270701
CHK_6467_E3B07_BAL_A_V1V2
0.25792144
CHK_6467_E3B11_BAL_A_V1V2
0.08844023
CHK_6467_E3B09_OP_V1V2
-0.12089654

12

Additionally, data can be filtered to maintain a threshold of minimum depth or OTU pres-

ence:

data(mouseData)
filterData(mouseData, present = 10, depth = 1000)

element names: counts

PM9:20080303 (137 total)

sampleNames: PM1:20080108 PM1:20080114 ...

varLabels: mouseID date ... status (5 total)
varMetadata: labelDescription

## MRexperiment (storageMode: environment)
## assayData: 1057 features, 137 samples
##
## protocolData: none
## phenoData
##
##
##
##
## featureData
##
##
##
##
##
## experimentData: use 'experimentData(object)'
## Annotation:

Lachnospiraceae:129 ... Collinsella:34 (1057
total)

fvarLabels: superkingdom phylum ... OTU (7 total)
fvarMetadata: labelDescription

featureNames: Erysipelotrichaceae:8

Two MRexperiment-class objects can be merged with the mergeMRexperiments func-

tion, e.g.:

data(mouseData)
newobj = mergeMRexperiments(mouseData, mouseData)

## MRexperiment 1 and 2 share sample ids; adding labels to sample ids.

newobj

sampleNames: PM1:20080107.x PM1:20080108.x ...

element names: counts

PM9:20080303.y (278 total)

## MRexperiment (storageMode: environment)
## assayData: 10172 features, 278 samples
##
## protocolData: none
## phenoData
##
##
##
##
## featureData
##
##
##
##
## experimentData: use 'experimentData(object)'
## Annotation:

varLabels: mouseID date ... status (5 total)
varMetadata: labelDescription

... Parabacteroides:956 (10172 total)

fvarLabels: superkingdom phylum ... OTU (7 total)
fvarMetadata: labelDescription

featureNames: Prevotellaceae:1 Lachnospiraceae:1

13

3 Normalization

Normalization is required due to varying depths of coverage across samples. cumNorm is a
normalization method that calculates scaling factors equal to the sum of counts up to a particular
quantile.

Denote the lth quantile of sample j as ql

j. For l = ⌊.95m⌋ then ql

j, that is, in sample j there are l taxonomic features
j corresponds to the 95th percentile of the

with counts smaller than ql
count distribution for sample j.
j = (cid:80)

Denote sl

(i|cij ≤ql

j ) cij as the sum of counts for sample j up to the lth quantile. Our
normalization chooses a value ˆl ≤ m to define a normalization scaling factor for each sample
to produce normalized counts ˜cij = cij
N where N is an appropriately chosen normalization
sˆl
j
constant. See Appendix C for more information on how our method calculates the proper
percentile.

These normalization factors are stored in the experiment summary slot. Functions to deter-
mine the proper percentile cumNormStat, save normalized counts exportMat, or save various
sample statistics exportStats are also provided. Normalized counts can be called easily by
cumNormMat(MRexperimentObject) or MRcounts(MRexperimentObject,norm=TRUE,log=FALSE).

3.1 Calculating normalization factors

After defining a MRexperiment object, the first step is to calculate the proper percentile by
which to normalize counts. There are several options in calculating and visualizing the relative
differences in the reference. Figure 3 is an example from the lung dataset.

data(lungData)
p = cumNormStatFast(lungData)

To calculate the scaling factors we simply run cumNorm

lungData = cumNorm(lungData, p = p)

The user can alternatively choose different percentiles for the normalization scheme by spec-

ifying p.

There are other functions, including normFactors, cumNormMat, that return the normal-
ization factors or a normalized matrix for a specified percentile. To see a full list of functions
please refer to the manual and help pages.

3.1.1 Calculating normalization factors using Wrench

An alternative to normalizing counts using cumNorm is to use wrenchNorm. It behaves similarly
to cumNorm, however, it takes the argument condition instead of p. condition is a factor
with values that separate samples into phenotypic groups of interest. When appropriate, wrench
normalization is preferrable over cumulative normalization (see https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-
018-5160-5 for details). In the example below, mouseData samples are compared based on diet.

condition = mouseData$diet
mouseData = wrenchNorm(mouseData, condition = condition)

14

3.2 Exporting data

To export normalized count matrices:

mat = MRcounts(lungData, norm = TRUE, log = TRUE)[1:5, 1:5]
exportMat(mat, file = file.path(dataDirectory, "tmp.tsv"))

To save sample statistics (sample scaling factor, quantile value, number of identified features
and library size):

exportStats(lungData[, 1:5], file = file.path(dataDirectory,

"tmp.tsv"))

## Default value being used.

head(read.csv(file = file.path(dataDirectory, "tmp.tsv"), sep = "\t"))

Subject Scaling.factor
67
2475
2198
836
1008

##
## 1 CHK_6467_E3B11_BRONCH2_PREWASH_V1V2
CHK_6467_E3B11_OW_V1V2
## 2
CHK_6467_E3B08_OW_V1V2
## 3
CHK_6467_E3B07_BAL_A_V1V2
## 4
## 5
CHK_6467_E3B11_BAL_A_V1V2
##
## 1
## 2
## 3
## 4
## 5

Quantile.value Number.of.identified.features Library.size
271
7863
8360
5249
3383

60
3299
2994
1188
1098

2
1
1
1
1

15

4 Statistical testing

Now that we have taken care of normalization we can address the effects of under sampling on
detecting differentially abundant features (OTUs, genes, etc). This is our latest development
and we recommend fitFeatureModel over fitZig. MRcoefs, MRtable and MRfulltable are useful
summary tables of the model outputs.

4.1 Zero-inflated Log-Normal mixture model for each feature

By reparametrizing our zero-inflation model, we’re able to fit a zero-inflated model for each
specific OTU separately. We currently recommend using the zero-inflated log-normal model as
implemented in fitFeatureModel.

4.1.1 Example using fitFeatureModel for differential abundance testing

Here is an example comparing smoker’s and non-smokers lung microbiome.

data(lungData)
lungData = lungData[, -which(is.na(pData(lungData)$SmokingStatus))]
lungData = filterData(lungData, present = 30, depth = 1)
lungData <- cumNorm(lungData, p = 0.5)
pd <- pData(lungData)
mod <- model.matrix(˜1 + SmokingStatus, data = pd)
lungres1 = fitFeatureModel(lungData, mod)
head(MRcoefs(lungres1))

logFC

pvalues

##
adjPvalues
se
## 3465 -4.824463 0.5707507 0.000000e+00 0.000000e+00
## 35827 -4.303970 0.5451951 2.886580e-15 1.169065e-13
2.320624 0.4325701 8.106793e-08 1.641626e-06
## 2817
## 2735
2.260145 0.4333020 1.827337e-07 2.960286e-06
1.748019 0.3102521 1.758848e-08 4.748890e-07
## 5411
## 48745 -1.645601 0.3301395 6.210252e-07 8.383840e-06

4.2 Zero-inflated Gaussian mixture model

The depth of coverage in a sample is directly related to how many features are detected in a
sample motivating our zero-inflated Gaussian (ZIG) mixture model. Figure 2 is representative of
the linear relationship between depth of coverage and OTU identification ubiquitous in marker-
gene survey datasets currently available. For a quick overview of the mathematical model see
Appendix B.

Function fitZig performs a complex mathematical optimization routine to estimate prob-
abilities that a zero for a particular feature in a sample is a technical zero or not. The function
relies heavily on the limma package [4]. Design matrices can be created in R by using the
model.matrix function and are inputs for fitZig.

For large survey studies it is often pertinent to include phenotype information or confounders
into a design matrix when testing the association between the abundance of taxonomic features
and a phenotype of interest (disease, for instance). Our linear model methodology can easily
incorporate these confounding covariates in a straightforward manner. fitZig output includes
weighted fits for each of the m features. Results can be filtered and saved using MRcoefs or
MRtable.

16

Figure 2: The number of unique features is plotted against depth of coverage for samples from the Human
Microbiome Project [3]. Including the depth of coverage and the interaction of body site and sequencing site
we are able to acheive an adjusted R2 of .94. The zero-inflated Gaussian mixture was developed to account for
missing features.

4.2.1 Example using fitZig for differential abundance testing

Warning: The user should restrict significant features to those with a minimum number of
positive samples. What this means is that one should not claim features are significant unless
the effective number of samples is above a particular percentage. For example, fold-change
estimates might be unreliable if an entire group does not have a positive count for the feature
in question.

We recommend the user remove features based on the number of estimated effective samples,
please see calculateEffectiveSamples. We recommend removing features with less than
the average number of effective samples in all features. In essence, setting eff = .5 when using
MRcoefs, MRfulltable, or MRtable. To find features absent from a group the function
uniqueFeatures provides a table of the feature ids, the number of positive features and reads
for each group.

In our analysis of the lung microbiome data, we can remove features that are not present
in many samples, controls, and calculate the normalization factors. The user needs to decide
which metadata should be included in the linear model.

data(lungData)
controls = grep("Extraction.Control", pData(lungData)$SampleType)
lungTrim = lungData[, -controls]
rareFeatures = which(rowSums(MRcounts(lungTrim) > 0) < 10)
lungTrim = lungTrim[-rareFeatures, ]
lungp = cumNormStat(lungTrim, pFlag = TRUE, main = "Trimmed lung data")

## Default value being used.

lungTrim = cumNorm(lungTrim, p = lungp)

17

Figure 3: Relative difference for the median difference in counts from the reference.

After the user defines an appropriate model matrix for hypothesis testing there are optional
inputs to fitZig, including settings determined by zigControl. We ask the user to review
the help files for both fitZig and zigControl. For this example we include body site as
covariates and want to test for the bacteria differentially abundant between smokers and non-
smokers.

smokingStatus = pData(lungTrim)$SmokingStatus
bodySite = pData(lungTrim)$SampleType
normFactor = normFactors(lungTrim)
normFactor = log2(normFactor/median(normFactor) + 1)
mod = model.matrix(˜smokingStatus + bodySite + normFactor)
settings = zigControl(maxit = 10, verbose = TRUE)
fit = fitZig(obj = lungTrim, mod = mod, useCSSoffset = FALSE,

control = settings)

## it= 0, nll=88.42, log10(eps+1)=Inf, stillActive=1029
## it= 1, nll=93.56, log10(eps+1)=0.06, stillActive=261
## it= 2, nll=93.46, log10(eps+1)=0.05, stillActive=120
## it= 3, nll=93.80, log10(eps+1)=0.05, stillActive=22
## it= 4, nll=93.94, log10(eps+1)=0.03, stillActive=3
## it= 5, nll=93.93, log10(eps+1)=0.00, stillActive=1
## it= 6, nll=93.90, log10(eps+1)=0.00, stillActive=1
## it= 7, nll=93.87, log10(eps+1)=0.00, stillActive=1
## it= 8, nll=93.86, log10(eps+1)=0.00, stillActive=1
## it= 9, nll=93.85, log10(eps+1)=0.00, stillActive=1

# The default, useCSSoffset = TRUE, automatically includes
# the CSS scaling normalization factor.

The result, fit, is a list providing detailed estimates of the fits including a limma fit in
fit$fit and an ebayes statistical fit in fit$eb. This data can be analyzed like any limma

18

0.00.10.20.30.40.50.6Trimmed lung dataIndexRelative difference for reference00.250.50.751fit and in this example, the column of the fitted coefficients represents the fold-change for our
”smoker” vs. ”nonsmoker” analysis.

Looking at the particular analysis just performed, there appears to be OTUs representing two
Prevotella, two Neisseria, a Porphyromonas and a Leptotrichia that are differentially abundant.
One should check that similarly annotated OTUs are not equally differentially abundant in
controls.

Alternatively, the user can input a model with their own normalization factors including them

directly in the model matrix and specifying the option useCSSoffset = FALSE in fitZig.

4.2.2 Multiple groups

Assuming there are multiple groups it is possible to make use of Limma’s topTable functions
for F-tests and contrast functions to compare multiple groups and covariates of interest. The
output of fitZig includes a ’MLArrayLM’ Limma object that can be called on by other functions.
When running fitZig by default there is an additional covariate added to the design matrix. The
fit and the ultimate design matrix are crucial for contrasts.

# maxit=1 is for demonstration purposes
settings = zigControl(maxit = 1, verbose = FALSE)
mod = model.matrix(˜bodySite)
colnames(mod) = levels(bodySite)
# fitting the ZIG model
res = fitZig(obj = lungTrim, mod = mod, control = settings)
# The output of fitZig contains a list of various useful
# items. hint: names(res).
# limma 'MLArrayLM' object called fit.
zigFit = slot(res, "fit")
finalMod = slot(res, "fit")$design

Probably the most useful is the

contrast.matrix = makeContrasts(BAL.A - BAL.B, OW - PSB, levels = finalMod)
fit2 = contrasts.fit(zigFit, contrast.matrix)
fit2 = eBayes(fit2)
topTable(fit2)

BAL.A...BAL.B
-0.10695735
0.37318792
-0.37995461
0.17344138
0.06892926
-0.28665883
-0.22859078
0.59882970
-0.07145998

F
AveExpr
OW...PSB
##
1.658829 0.4671470 12.990553
## 6291
2.075648 0.7343081 12.667091
## 18531
2.174071 0.4526060 12.501191
## 37977
1.466113 0.2435881 12.118648
## 6901
1.700238 0.2195735 11.865586
## 40291
2.233996 0.4084024 10.512096
## 36117
1.559465 0.3116465 10.103285
## 7343
9.374249
1.902346 0.5334647
## 7342
9.757988
1.481582 0.2475735
## 40329
1.09837459 -2.160466 0.7780167
9.276041
## 1727
adj.P.Val
##
## 6291 5.519662e-05 0.02905255
## 18531 5.646754e-05 0.02905255
## 37977 8.569551e-05 0.02939356
## 6901 1.301174e-04 0.03195463
## 40291 1.552703e-04 0.03195463
## 36117 3.198856e-04 0.05091040

P.Value

19

## 7343 3.989201e-04 0.05091040
## 7342 5.104103e-04 0.05091040
## 40329 5.188482e-04 0.05091040
## 1727 5.351034e-04 0.05091040

# See help pages on decideTests, topTable, topTableF,
# vennDiagram, etc.

Further specific details can be found in section 9.3 and beyond of the Limma user guide.
The take home message is that to make use of any Limma functions one needs to extract the
final model matrix used: res$fit$design and the MLArrayLM Limma fit object: res$fit.

4.2.3 Exporting fits

Currently functions are being developed to wrap and output results more neatly, but MRcoefs,
MRtable, MRfulltable can be used to view coefficient fits and related statistics and export
the data with optional output values - see help files to learn how they differ. An important note
is that the by variable controls which coefficients are of interest whereas coef determines the
display.

To only consider features that are found in a large percentage of effectively positive (positive
samples + the weight of zero counts included in the Gaussian mixture) use the eff option in the
MRtables.

taxa = sapply(strsplit(as.character(fData(lungTrim)$taxa), split = ";"),

function(i) {

i[length(i)]

})

head(MRcoefs(fit, taxa = taxa, coef = 2))

smokingStatusSmoker
-4.031612
-3.958899
-2.927686
-2.675306
2.575672
2.574172

##
## Neisseria polysaccharea
## Neisseria meningitidis
## Prevotella intermedia
## Porphyromonas sp. UQD 414
## Prevotella paludivivens
## Leptotrichia sp. oral clone FP036
adjPvalues
##
3.927097e-11 2.959194e-08
## Neisseria polysaccharea
5.751592e-11 2.959194e-08
## Neisseria meningitidis
4.339587e-09 8.930871e-07
## Prevotella intermedia
1.788697e-07 1.357269e-05
## Porphyromonas sp. UQD 414
## Prevotella paludivivens
1.360718e-07 1.272890e-05
## Leptotrichia sp. oral clone FP036 3.544957e-04 1.414122e-03

pvalues

4.3 Time series analysis

Implemented in the fitTimeSeries function is a method for calculating time intervals for
which bacteria are differentially abundant. Fitting is performed using Smoothing Splines ANOVA
(SS-ANOVA), as implemented in the gss package. Given observations at multiple time points
for two groups the method calculates a function modeling the difference in abundance across all

20

time. Using group membership permutations weestimate a null distribution of areas under the
difference curve for the time intervals of interest and report significant intervals of time.

Use of the function for analyses should cite: ”Finding regions of interest in high throughput

genomics data using smoothing splines” Talukder H, Paulson JN, Bravo HC. (Submitted)

For a description of how to perform a time-series / genome based analysis call the fitTimeSeries

vignette.

# vignette('fitTimeSeries')

4.4 Log Normal permutation test

Included is a standard log normal linear model with permutation based p-values permutation.
We show the fit for the same model as above using 10 permutations providing p-value resolution
to the tenth. The coef parameter refers to the coefficient of interest to test. We first generate
the list of significant features.

coeffOfInterest = 2
res = fitLogNormal(obj = lungTrim, mod = mod, useCSSoffset = FALSE,

B = 10, coef = coeffOfInterest)

# extract p.values and adjust for multiple testing res$p
# are the p-values calculated through permutation
adjustedPvalues = p.adjust(res$p, method = "fdr")

# extract the absolute fold-change estimates
foldChange = abs(res$fit$coef[, coeffOfInterest])

# determine features still significant and order by the
sigList = which(adjustedPvalues <= 0.05)
sigList = sigList[order(foldChange[sigList])]

# view the top taxa associated with the coefficient of
# interest.
head(taxa[sigList])

## [1] "Veillonella montpellierensis"
## [2] "Veillonella sp. oral clone VeillI7"
## [3] "Listeria grayi"
## [4] "Megasphaera micronuciformis"
## [5] "Campylobacter curvus"
## [6] "Prevotella intermedia"

4.5 Presence-absence testing

The hypothesis for the implemented presence-absence test is that the proportion/odds of a given
feature present is higher/lower among one group of individuals compared to another, and we
want to test whether any difference in the proportions observed is significant. We use Fisher’s
exact test to create a 2x2 contingency table and calculate p-values, odd’s ratios, and confidence
intervals. fitPA calculates the presence-absence for each organism and returns a table of p-
values, odd’s ratios, and confidence intervals. The function will accept either a MRexperiment

21

object or matrix. MRfulltable when sent a result of fitZig will also include the results of
fitPA.

classes = pData(mouseData)$diet
res = fitPA(mouseData[1:5, ], cl = classes)
# Warning - the p-value is calculating 1 despite a high
# odd's ratio.
head(res)

lower
Inf 0.01630496
Inf 0.01630496
Inf 0.01630496

upper
Inf
Inf
Inf
0 0.00000000 24.77661
Inf

oddsRatio

##
## Prevotellaceae:1
## Lachnospiraceae:1
## Unclassified-Screened:1
## Clostridiales:1
## Clostridiales:2
##
1.0000000
## Prevotellaceae:1
## Lachnospiraceae:1
1.0000000
## Unclassified-Screened:1 1.0000000
0.3884892
## Clostridiales:1
1.0000000
## Clostridiales:2

Inf 0.01630496
pvalues adjPvalues
1
1
1
1
1

4.6 Discovery odds ratio testing

The hypothesis for the implemented discovery test is that the proportion of observed counts
for a feature of all counts are comparable between groups. We use Fisher’s exact test to create
a 2x2 contingency table and calculate p-values, odd’s ratios, and confidence intervals. fitDO
calculates the proportion of counts for each organism and returns a table of p-values, odd’s
ratios, and confidence intervals. The function will accept either a MRexperiment object or
matrix.

classes = pData(mouseData)$diet
res = fitDO(mouseData[1:100, ], cl = classes, norm = FALSE, log = FALSE)
head(res)

lower
Inf 0.01630496
Inf 0.01630496
Inf 0.01630496

upper
Inf
Inf
Inf
0 0.00000000 24.77661
Inf
0 0.00000000 24.77661

Inf 0.01630496

oddsRatio

##
## Prevotellaceae:1
## Lachnospiraceae:1
## Unclassified-Screened:1
## Clostridiales:1
## Clostridiales:2
## Firmicutes:1
##
1.0000000
## Prevotellaceae:1
1.0000000
## Lachnospiraceae:1
## Unclassified-Screened:1 1.0000000
0.3884892
## Clostridiales:1
1.0000000
## Clostridiales:2
0.3884892
## Firmicutes:1

pvalues adjPvalues
1.0000000
1.0000000
1.0000000
0.7470946
1.0000000
0.7470946

22

4.7 Feature correlations

To test the correlations of abundance features, or samples, in a pairwise fashion we have imple-
mented correlationTest and correctIndices. The correlationTest function will
calculate basic pearson, spearman, kendall correlation statistics for the rows of the input and
report the associated p-values. If a vector of length ncol(obj) it will also calculate the correlation
of each row with the associated vector.

cors = correlationTest(mouseData[55:60, ], norm = FALSE, log = FALSE)
head(cors)

##
correlation
## Clostridiales:11-Lachnospiraceae:35 -0.02205882
-0.01701180
## Clostridiales:11-Coprobacillus:3
-0.01264304
## Clostridiales:11-Lactobacillales:3
0.57315130
## Clostridiales:11-Enterococcaceae:3
-0.01264304
## Clostridiales:11-Enterococcaceae:4
## Lachnospiraceae:35-Coprobacillus:3
0.24572606
##
p
## Clostridiales:11-Lachnospiraceae:35 7.965979e-01
8.424431e-01
## Clostridiales:11-Coprobacillus:3
8.825644e-01
## Clostridiales:11-Lactobacillales:3
1.663001e-13
## Clostridiales:11-Enterococcaceae:3
8.825644e-01
## Clostridiales:11-Enterococcaceae:4
3.548360e-03
## Lachnospiraceae:35-Coprobacillus:3

Caution: http://www.ncbi.nlm.nih.gov/pubmed/23028285

4.8 Unique OTUs or features

To find features absent from any number of classes the function uniqueFeatures provides a
table of the feature ids, the number of positive features and reads for each group. Thresholding
for the number of positive samples or reads required are options.

cl = pData(mouseData)[["diet"]]
uniqueFeatures(mouseData, cl, nsamples = 10, nreads = 100)

##
## Enterococcaceae:28
## Lachnospiraceae:1453
## Firmicutes:367
## Prevotellaceae:143
## Lachnospiraceae:4122
## Enterococcus:182
## Lachnospiraceae:4347
## Prevotella:79
## Prevotella:81
## Prevotellaceae:433
##
## Enterococcaceae:28
## Lachnospiraceae:1453
## Firmicutes:367
## Prevotellaceae:143

featureIndices Samp. in BK
0
16
0
50
15
0
50
50
71
53

2458
2826
4165
7030
7844
8384
8668
8749
8994
9223

Samp. in Western Reads in BK
0
192
0
109

36
0
32
0

23

505
0
130
100
370
154

## Lachnospiraceae:4122
## Enterococcus:182
## Lachnospiraceae:4347
## Prevotella:79
## Prevotella:81
## Prevotellaceae:433
##
## Enterococcaceae:28
## Lachnospiraceae:1453
## Firmicutes:367
## Prevotellaceae:143
## Lachnospiraceae:4122
## Enterococcus:182
## Lachnospiraceae:4347
## Prevotella:79
## Prevotella:81
## Prevotellaceae:433

0
34
0
0
0
0
Reads in Western
123
0
112
0
0
163
0
0
0
0

24

5 Aggregating counts

Normalization is recommended at the OTU level. However, functions are in place to aggregate
the count matrix (normalized or not), based on a particular user defined level. Using the feature-
Data information in the MRexperiment object, calling aggregateByTaxonomy or aggTax on
a MRexperiment object and declaring particular featureData column name (i.e.
’genus’) will
aggregate counts to the desired level with the aggfun function (default colSums). Possible aggfun
alternatives include colMeans and colMedians.

obj = aggTax(mouseData, lvl = "phylum", out = "matrix")
head(obj[1:5, 1:5])

##
## Actinobacteria
## Bacteroidetes
## Cyanobacteria
## Firmicutes
## NA
##
## Actinobacteria
## Bacteroidetes
## Cyanobacteria
## Firmicutes
## NA

0
486
0
455
5

PM1:20080107 PM1:20080108 PM1:20080114
2
1103
0
1637
5

3
921
0
922
25
PM1:20071211 PM1:20080121
0
818
0
1254
4

37
607
0
772
8

Additionally, aggregating samples can be done using the phenoData information in the MR-
experiment object. Calling aggregateBySample or aggsamp on a MRexperiment object and
declaring a particular phenoData column name (i.e. ’diet’) will aggregate counts with the aggfun
function (default rowMeans). Possible aggfun alternatives include rowSums and rowMedians.

obj = aggSamp(mouseData, fct = "mouseID", out = "matrix")
head(obj[1:5, 1:5])

PM1 PM10

##
## Prevotellaceae:1
## Lachnospiraceae:1
## Unclassified-Screened:1
## Clostridiales:1
## Clostridiales:2

0
0
0
0
0

0 0.00000000
0 0.00000000
0 0.08333333
0 0.00000000
0 0.00000000

PM11 PM12 PM2
0
0
0
0
0

0
0
0
0
0

The aggregateByTaxonomy,aggregateBySample, aggTax aggSamp functions are flex-
ible enough to put in either 1) a matrix with a vector of labels or 2) a MRexperiment object with
a vector of labels or featureData column name. The function can also output either a matrix or
MRexperiment object.

25

6 Visualization of features

To help with visualization and analysis of datasets metagenomeSeq has several plotting func-
tions to gain insight of the dataset’s overall structure and particular individual features. An
initial interactive exploration of the data can be displayed with the display function.

For an overall look at the dataset we provide a number of plots including heatmaps of
feature counts: plotMRheatmap, basic feature correlation structures: plotCorr, PCA/MDS
coordinates of samples or features: plotOrd, rarefaction effects: plotRare and contingency
table style plots: plotBubble.

Other plotting functions look at particular features such as the abundance for a single feature:
plotOTU and plotFeature, or of multiple features at once: plotGenus. Plotting multiple
OTUs with similar annotations allows for additional control of false discoveries.

6.1 Interactive Display

Due to recent advances in the interactiveDisplay package, calling the display function
on MRexperiment objects will bring up a browser to explore your data through several inter-
active visualizations. For more detailed interactive visualizations one might be interested in the
shiny-phyloseq package.

# Calling display on the MRexperiment object will start a
# browser session with interactive plots.

# require(interactiveDisplay) display(mouseData)

6.2 Structural overview

Many studies begin by comparing the abundance composition across sample or feature pheno-
types. Often a first step of data analysis is a heatmap, correlation or co-occurence plot or some
other data exploratory method. The following functions have been implemented to provide a
first step overview of the data:

1. plotMRheatmap - heatmap of abundance estimates (Fig. 4 left)

2. plotCorr - heatmap of pairwise correlations (Fig. 4 right)

3. plotOrd - PCA/CMDS components (Fig. 5 left)

4. plotRare - rarefaction effect (Fig. 5 right)

5. plotBubble - contingency table style plot (see help)

Each of the above can include phenotypic information in helping to explore the data.

Below we show an example of how to create a heatmap and hierarchical clustering of log2
transformed counts for the 200 OTUs with the largest overall variance. Red values indicate
counts close to zero. Row color labels indicate OTU taxonomic class; column color labels
indicate diet (green = high fat, yellow = low fat). Notice the samples cluster by diet in these
cases and there are obvious clusters. We then plot a correlation matrix for the same features.

trials = pData(mouseData)$diet
heatmapColColors = brewer.pal(12, "Set3")[as.integer(factor(trials))]
heatmapCols = colorRampPalette(brewer.pal(9, "RdBu"))(50)

26

Figure 4: Left) Abundance heatmap (plotMRheatmap). Right) Correlation heatmap (plotCorr).

# plotMRheatmap
plotMRheatmap(obj = mouseData, n = 200, cexRow = 0.4, cexCol = 0.4,

trace = "none", col = heatmapCols, ColSideColors = heatmapColColors)

# plotCorr
plotCorr(obj = mouseData, n = 200, cexRow = 0.25, cexCol = 0.25,
trace = "none", dendrogram = "none", col = heatmapCols)

Below is an example of plotting CMDS plots of the data and the rarefaction effect at the

OTU level. None of the data is removed (we recommend removing outliers typically).

cl = factor(pData(mouseData)$diet)

# plotOrd - can load vegan and set distfun = vegdist and
# use dist.method='bray'
plotOrd(mouseData, tran = TRUE, usePCA = FALSE, useDist = TRUE,

bg = cl, pch = 21)

# plotRare
res = plotRare(mouseData, cl = cl, pch = 21, bg = cl)

# Linear fits for plotRare / legend
tmp = lapply(levels(cl), function(lv) lm(res[, "ident"] ˜ res[,

"libSize"] - 1, subset = cl == lv))

for (i in 1:length(levels(cl))) {
abline(tmp[[i]], col = i)

}
legend("topleft", c("Diet 1", "Diet 2"), text.col = c(1, 2),

box.col = NA)

27

PM7:20080303PM12:20080204PM12:20080108PM8:20080108PM6:20080108PM8:20080128PM10:20080211PM10:20080218PM9:20080303PM6:20080225PM5:20080225PM8:20080204PM8:20080218PM9:20080225PM12:20080114PM12:20080218PM8:20080225PM6:20080211PM5:20080128PM6:20080204PM9:20080121PM5:20080211PM10:20080303PM10:20080128PM5:20080121PM6:20080121PM10:20080114PM6:20080128PM7:20080114PM7:20080204PM7:20080211PM7:20080225PM11:20071211PM1:20071211PM9:20071211PM2:20071211PM9:20071217PM7:20071217PM12:20071217PM2:20071217PM6:20071217PM1:20071217PM4:20080114PM1:20080303PM3:20080303PM1:20080107PM2:20080108PM8:20080107PM2:20080107PM3:20080218PM2:20080128PM2:20080114PM2:20080121PM12:20080107PM10:20080107PM11:20080107PM2:20080303PM2:20080211PM1:20080204PM2:20080218PM3:20080211PM11:20080211PM4:20080121PM11:20080225PM1:20080128PM1:20080211PM4:20080211PM11:20080121PM11:20080218PM4:20080128Erysipelotrichaceae:49Coprobacillus:38Alistipes:161Ruminococcaceae:547LachnospiraceaeIncertaeSedis:854Coprobacillus:126Lachnospiraceae:4056Lachnospiraceae:3906Enterococcus:39Ruminococcaceae:541Firmicutes:278Lachnospiraceae:796Ruminococcaceae:374Akkermansia:40Bilophila:37Lachnospiraceae:4244Coprobacillus:58LachnospiraceaeIncertaeSedis:705Clostridiales:1086IncertaeSedisXIII:17Lachnospiraceae:3419LachnospiraceaeIncertaeSedis:1010Clostridiales:536LachnospiraceaeIncertaeSedis:884LachnospiraceaeIncertaeSedis:929Coriobacteriaceae:42ErysipelotrichaceaeIncertaeSedis:255Lachnospiraceae:4248LachnospiraceaeIncertaeSedis:277IncertaeSedisXIII:13Lachnospiraceae:4070Lachnospiraceae:3839Ruminococcaceae:357Lachnospiraceae:4403Ruminococcaceae:230LachnospiraceaeIncertaeSedis:975Lachnospiraceae:4074Lachnospiraceae:4148Clostridiales:313Enterococcus:162LachnospiraceaeIncertaeSedis:1021Ruminococcaceae:469Lachnospiraceae:3410Lactococcus:48Ruminococcaceae:575Lachnospiraceae:2961Dorea:58Bacteroides:265Faecalibacterium:288LachnospiraceaeIncertaeSedis:962Bryantella:94Lachnospiraceae:3509LachnospiraceaeIncertaeSedis:977Sutterella:13Bacteria:4Prevotella:81Prevotella:74Prevotella:83Prevotella:86Lachnospiraceae:4374Bacteroides:667LachnospiraceaeIncertaeSedis:558Lachnospiraceae:4295Parabacteroides:703Lachnospiraceae:3854Lachnospiraceae:3746Lachnospiraceae:3477Bacteroides:1005Prevotellaceae:433Bacteroides:1170Prevotella:72Prevotella:79Lachnospiraceae:4440LachnospiraceaeIncertaeSedis:1016Bacteroides:1084Proteobacteria:26Anaerostipes:38Parabacteroides:745Parabacteroides:592Lachnospiraceae:313Bacteroides:1048Bacteroides:1016Bacteroides:1213Clostridiales:1069Faecalibacterium:231Faecalibacterium:282Bacteroides:868Ruminococcaceae:612Bacteroides:1146Lachnospiraceae:3407Bacteroides:768Lachnospiraceae:685Lachnospiraceae:4347LachnospiraceaeIncertaeSedis:981Lachnospiraceae:3816Anaerotruncus:28LachnospiraceaeIncertaeSedis:790Bacteroides:978Lachnospiraceae:4394Lachnospiraceae:436205101520Value0600014000Color Keyand HistogramCountLachnospiraceaeIncertaeSedis:955LachnospiraceaeIncertaeSedis:1009Ruminococcaceae:541LachnospiraceaeIncertaeSedis:1021Ruminococcaceae:469Lachnospiraceae:2958Enterococcus:153Clostridiales:313Lachnospiraceae:4074Ruminococcaceae:575Lactococcus:48Ruminococcaceae:526Enterococcus:43ErysipelotrichaceaeIncertaeSedis:255Ruminococcaceae:96Clostridiales:1086Ruminococcaceae:634LachnospiraceaeIncertaeSedis:854Ruminococcaceae:643Ruminococcaceae:639LachnospiraceaeIncertaeSedis:1001Coprobacillus:126Lachnospiraceae:4070Ruminococcaceae:357Lachnospiraceae:4047Akkermansia:54Bilophila:37Ruminococcaceae:230Lachnospiraceae:3854Lachnospiraceae:209LachnospiraceaeIncertaeSedis:929Lachnospiraceae:4295Sutterella:13Lachnospiraceae:2700Lachnospiraceae:3233Bacteroides:1005Bacteroidales:72Coprobacillus:38Bacteroides:979LachnospiraceaeIncertaeSedis:867Proteobacteria:26Bacteroides:1048Bacteroides:1116Bacteroides:1016Lachnospiraceae:4378Clostridia:33Lachnospiraceae:3636LachnospiraceaeIncertaeSedis:705Lachnospiraceae:4403Lachnospiraceae:3398Ruminococcaceae:642Alistipes:161Lachnospiraceae:4220LachnospiraceaeIncertaeSedis:558Lachnospiraceae:313LachnospiraceaeIncertaeSedis:1010Parabacteroides:745Lachnospiraceae:3746Coprobacillus:85RuminococcaceaeIncertaeSedis:49Ruminococcaceae:253Coprobacillus:58Bacteroides:655Prevotellaceae:433Prevotella:72Prevotellaceae:143Prevotella:79Bacteria:4Prevotella:83Prevotella:76Prevotella:86Prevotella:74Faecalibacterium:276Lachnospiraceae:4374Firmicutes:340Faecalibacterium:231Faecalibacterium:275Lachnospiraceae:4347Bacteroides:820Bacteroides:768Bacteroides:854LachnospiraceaeIncertaeSedis:981Bacteroides:1021LachnospiraceaeIncertaeSedis:790Lachnospiraceae:3743Lachnospiraceae:685Lachnospiraceae:3816Bacteroides:890Ruminococcus:15Lachnospiraceae:3509Bacteroides:1146Bacteroides:1012Ruminococcaceae:612Lachnospiraceae:3867Clostridiales:1069Clostridiales:1117Bryantella:94Bacteroides:868Lachnospiraceae:4362Lachnospiraceae:4261LachnospiraceaeIncertaeSedis:955LachnospiraceaeIncertaeSedis:1009Ruminococcaceae:541LachnospiraceaeIncertaeSedis:1021Ruminococcaceae:469Lachnospiraceae:2958Enterococcus:153Clostridiales:313Lachnospiraceae:4074Ruminococcaceae:575Lactococcus:48Ruminococcaceae:526Enterococcus:43ErysipelotrichaceaeIncertaeSedis:255Ruminococcaceae:96Clostridiales:1086Ruminococcaceae:634LachnospiraceaeIncertaeSedis:854Ruminococcaceae:643Ruminococcaceae:639LachnospiraceaeIncertaeSedis:1001Coprobacillus:126Lachnospiraceae:4070Ruminococcaceae:357Lachnospiraceae:4047Akkermansia:54Bilophila:37Ruminococcaceae:230Lachnospiraceae:3854Lachnospiraceae:209LachnospiraceaeIncertaeSedis:929Lachnospiraceae:4295Sutterella:13Lachnospiraceae:2700Lachnospiraceae:3233Bacteroides:1005Bacteroidales:72Coprobacillus:38Bacteroides:979LachnospiraceaeIncertaeSedis:867Proteobacteria:26Bacteroides:1048Bacteroides:1116Bacteroides:1016Lachnospiraceae:4378Clostridia:33Lachnospiraceae:3636LachnospiraceaeIncertaeSedis:705Lachnospiraceae:4403Lachnospiraceae:3398Ruminococcaceae:642Alistipes:161Lachnospiraceae:4220LachnospiraceaeIncertaeSedis:558Lachnospiraceae:313LachnospiraceaeIncertaeSedis:1010Parabacteroides:745Lachnospiraceae:3746Coprobacillus:85RuminococcaceaeIncertaeSedis:49Ruminococcaceae:253Coprobacillus:58Bacteroides:655Prevotellaceae:433Prevotella:72Prevotellaceae:143Prevotella:79Bacteria:4Prevotella:83Prevotella:76Prevotella:86Prevotella:74Faecalibacterium:276Lachnospiraceae:4374Firmicutes:340Faecalibacterium:231Faecalibacterium:275Lachnospiraceae:4347Bacteroides:820Bacteroides:768Bacteroides:854LachnospiraceaeIncertaeSedis:981Bacteroides:1021LachnospiraceaeIncertaeSedis:790Lachnospiraceae:3743Lachnospiraceae:685Lachnospiraceae:3816Bacteroides:890Ruminococcus:15Lachnospiraceae:3509Bacteroides:1146Bacteroides:1012Ruminococcaceae:612Lachnospiraceae:3867Clostridiales:1069Clostridiales:1117Bryantella:94Bacteroides:868Lachnospiraceae:4362Lachnospiraceae:4261−100.51Value01000Color Keyand HistogramCountFigure 5: Left) CMDS of features (plotOrd). Right) Rarefaction effect (plotRare).

6.3 Feature specific

Reads clustered with high similarity represent functional or taxonomic units. However, it is pos-
sible that reads from the same organism get clustered into multiple OTUs. Following differential
abundance analysis. It is important to confirm differential abundance. One way to limit false
positives is ensure that the feature is actually abundant (enough positive samples). Another
way is to plot the abundances of features similarly annotated.

1. plotOTU - abundances of a particular feature by group (Fig. 6 left)

2. plotGenus - abundances for several features similarly annotated by group (Fig. 6 right)

3. plotFeature - abundances of a particular feature by group (similar to plotOTU, Fig.

7)

Below we use plotOTU to plot the normalized log(cpt) of a specific OTU annotated as Neis-
seria meningitidis, in particular the 779th row of lungTrim’s count matrix. Using plotGenus
we plot the normalized log(cpt) of all OTUs annotated as Neisseria meningitidis.

It would appear that Neisseria meningitidis is differentially more abundant in nonsmokers.

head(MRtable(fit, coef = 2, taxa = 1:length(fData(lungTrim)$taxa)))

##
## 63
## 779
## 358
## 499
## 25
## 928
##
## 63
## 779

+samples in group 0 +samples in group 1
6
7
1
2
26
11

24
23
24
21
15
2

counts in group 0 counts in group 1 smokingStatusSmoker
-4.031612
-3.958899

1538
1512

11
22

28

−50050−100−50050MDS component: 1MDS component: 2100020003000400050006000300400500600Depth of coverageNumber of detected featuresDiet 1Diet 21
2
1893
91

-2.927686
-2.675306
2.575672
2.574172

390
326
162
4

## 358
## 499
## 25
## 928
adjPvalues
pvalues
##
## 63 3.927097e-11 2.959194e-08
## 779 5.751592e-11 2.959194e-08
## 358 4.339587e-09 8.930871e-07
## 499 1.788697e-07 1.357269e-05
## 25 1.360718e-07 1.272890e-05
## 928 3.544957e-04 1.414122e-03

patients = sapply(strsplit(rownames(pData(lungTrim)), split = "_"),

function(i) {
i[3]

})

pData(lungTrim)$patients = patients
classIndex = list(smoker = which(pData(lungTrim)$SmokingStatus ==

"Smoker"))

classIndex$nonsmoker = which(pData(lungTrim)$SmokingStatus ==

"NonSmoker")

otu = 779

# plotOTU
plotOTU(lungTrim, otu = otu, classIndex, main = "Neisseria meningitidis")

# Now multiple OTUs annotated similarly
x = fData(lungTrim)$taxa[otu]
otulist = grep(x, fData(lungTrim)$taxa)

# plotGenus
plotGenus(lungTrim, otulist, classIndex, labs = FALSE, main = "Neisseria meningitidis")

lablist <- c("S", "NS")
axis(1, at = seq(1, 6, by = 1), labels = rep(lablist, times = 3))

classIndex = list(Western = which(pData(mouseData)$diet == "Western"))
classIndex$BK = which(pData(mouseData)$diet == "BK")
otuIndex = 8770

# par(mfrow=c(1,2))
dates = pData(mouseData)$date
plotFeature(mouseData, norm = FALSE, log = FALSE, otuIndex, classIndex,

col = dates, sortby = dates, ylab = "Raw reads")

29

Figure 6: Left) Abundance plot (plotOTU). Right) Multiple OTU abundances (plotGenus).

Figure 7: Plot of raw abundances

30

02468Neisseria meningitidisGroups of comparisonNormalized log(cpt)smokernonsmoker02468Neisseria meningitidisGroups of comparisonNormalized log(cpt)SNSSNSSNS010203040500100200300400500600700WesternRaw reads0204060800100200300400500600700BKRaw reads7 Summary

metagenomeSeq is specifically designed for sparse high-throughput sequencing experiments
that addresses the analysis of differential abundance for marker-gene survey data. The package,
while designed for marker-gene survey datasets, may be appropriate for other sparse data sets
for which the zero-inflated Gaussian mixture model may apply. If you make use of the statis-
tical method please cite our paper.
If you made use of the manual/software, please cite the
manual/software!

7.1 Citing metagenomeSeq

citation("metagenomeSeq")

Paulson JN, Stine OC, Bravo HC, Pop M (2013).
"Differential abundance analysis for microbial
marker-gene surveys." _Nat Meth_, *advance online
publication*. doi:10.1038/nmeth.2658
<https://doi.org/10.1038/nmeth.2658>,
<http://www.nature.com/nmeth/journal/vaop/ncurrent/abs/nmeth.2658.html>.

Paulson JN, Olson ND, Braccia DJ, Wagner J,
Talukder H, Pop M, Bravo HC (2013). _metagenomeSeq:
Statistical analysis for sparse high-throughput
sequncing._. Bioconductor package,
<http://www.cbcb.umd.edu/software/metagenomeSeq>.

## To cite the original statistical method and
## normalization method implemented in metagenomeSeq use
##
##
##
##
##
##
##
##
## To cite the metagenomeSeq software/vignette guide use
##
##
##
##
##
##
##
## To cite time series analysis/function fitTimeSeries
## use
##
##
##
##
##
##
##
##
## To see these entries in BibTeX format, use
## 'print(<citation>, bibtex=TRUE)', 'toBibtex(.)', or
## set 'options(citation.bibtex.max=999)'.

Paulson* JN, Talukder* H, Bravo HC (2017).
"Longitudinal differential abundance analysis of
marker-gene surveys using smoothing splines."
_biorxiv_. doi:10.1101/099457
<https://doi.org/10.1101/099457>,
<https://www.biorxiv.org/content/10.1101/099457v1>.

7.2 Session Info

sessionInfo()

## R version 4.5.1 Patched (2025-08-23 r88802)

31

LAPACK version 3.12.0

grDevices utils

graphics
base

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##
## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [3] LC_TIME=en_GB
## [5] LC_MONETARY=en_US.UTF-8
## [7] LC_PAPER=en_US.UTF-8
## [9] LC_ADDRESS=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats
## [6] methods
##
## other attached packages:
## [1] biomformat_1.38.0
## [3] metagenomeSeq_1.52.0 RColorBrewer_1.1-3
## [5] glmnet_4.1-10
## [7] limma_3.66.0
## [9] BiocGenerics_0.56.0
## [11] knitr_1.50
##
## loaded via a namespace (and not attached):
## [1] jsonlite_2.0.0
## [3] highr_0.11
## [5] Rcpp_1.1.0
## [7] rhdf5filters_1.22.0 bitops_1.0-9
## [9] parallel_4.5.1
## [11] statmod_1.5.1
## [13] plyr_1.8.9
## [15] iterators_1.0.14
## [17] caTools_1.18.3
## [19] formatR_1.14
## [21] grid_4.5.1
## [23] rhdf5_2.54.0
## [25] evaluate_1.0.5
## [27] survival_3.8-3
## [29] tools_4.5.1

splines_4.5.1
lattice_0.22-7
shape_1.4.6.1
xfun_0.53
Rhdf5lib_1.32.0
foreach_1.5.2
locfit_1.5-9.12
KernSmooth_2.23-26
codetools_0.2-20
matrixStats_1.5.0
gplots_3.2.0

Matrix_1.7-4
Biobase_2.70.0
generics_0.1.4

compiler_4.5.1
gtools_3.9.5
Wrench_1.28.0

gss_2.2-9

datasets

32

8 Appendix

8.1 Appendix A: MRexperiment internals

The S4 class system in R allows for object oriented definitions. metagenomeSeq makes use
of the Biobase package in Bioconductor and their virtual-class, eSet. Building off of eSet,
the main S4 class in metagenomeSeq is termed MRexperiment. MRexperiment is a simple
extension of eSet, adding a single slot, expSummary.

The experiment summary slot is a data frame that includes the depth of coverage and
the normalization factors for each sample. Future datasets can be formated as MRexperi-
ment objects and analyzed with relative ease. A MRexperiment object is created by calling
newMRexperiment, passing the counts, phenotype and feature data as parameters.

We do not include normalization factors or library size in the currently available slot specified
for the sample specific phenotype data. All matrices are organized in the assayData slot. All
phenotype data (disease status, age, etc.) is stored in phenoData and feature data (OTUs,
taxonomic assignment to varying levels, etc.) in featureData. Additional slots are available
for reproducibility and annotation.

8.2 Appendix B: Mathematical model

Defining the class comparison of interest as k(j) = I{j ∈ groupA}. The zero-inflated model
is defined for the continuity-corrected log2 of the count data yij = log2(cij + 1) as a mixture
of a point mass at zero I{0}(yij) and a count distribution fcount(yij; µi, σ2
i ). Given
mixture parameters πj, we have that the density of the zero-inflated Gaussian distribution for
feature i, in sample j with Sj total counts is:

i ) ∼ N (µi, σ2

fzig(yij; θ) = πj(Sj) · I{0}(yij) + (1 − πj(Sj)) · fcount(yij; θ)

(1)

Maximum-likelihood estimates are approximated using an EM algorithm, where we treat
mixture membership ∆ij = 1 if yij is generated from the zero point mass as latent indicator
variables [5]. We make use of an EM algorithm to account for the linear relationship between
sparsity and depth of coverage. The user can specify within the fitZig function a non-default
zero model that accounts for more than simply the depth of coverage (e.g. country, age, any
metadata associated with sparsity, etc.). See Figure 8 for the graphical model.

More information will be included later. For now, please see the online methods in:
http://www.nature.com/nmeth/journal/vaop/ncurrent/full/nmeth.2658.html

8.3 Appendix C: Calculating the proper percentile

To be included: an overview of the two methods implemented for the data driven percentile
calculation and more description below.

The choice of the appropriate quantile given is crucial for ensuring that the normalization
approach does not introduce normalization-related artifacts in the data. At a high level, the
count distribution of samples should all be roughly equivalent and independent of each other up
to this quantile under the assumption that, at this range, counts are derived from a common
distribution.

More information will be included later. For now, please see the online methods in:
http://www.nature.com/nmeth/journal/vaop/ncurrent/full/nmeth.2658.html

33

Figure 8: Graphical model. Green nodes represent observed variables: Sj is the total number of reads in sample
j; kj the case-control status of sample j; and yij the logged normalized counts for feature i in sample j. Yellow
nodes represent counts obtained from each mixture component: counts come from either a spike-mass at zero,
y0
ij, or the “count” distribution, y1
i represent the estimated overall mean, fold-change
and variance of the count distribution component for feature i. πj, is the mixture proportion for sample j which
depends on sequencing depth via a linear model defined by parameters β0 and β1. The expected value of latent
indicator variables ∆ij give the posterior probability of a count being generated from a spike-mass at zero, i.e.
y0
ij. We assume M features and N samples.

ij. Grey nodes b0i, b1i and σ2

34

References

[1] Emily S Charlson, Kyle Bittinger, Andrew R Haas, Ayannah S Fitzgerald, Ian Frank, Anjana
Yadav, Frederic D Bushman, and Ronald G Collman. Topographical continuity of bacterial
populations in the healthy human respiratory tract. American Journal of Respiratory and
Critical Care Medicine, 184, 2011.

[2] Peter J Turnbaugh, Vanessa K Ridaura, Jeremiah J Faith, Federico E Rey, Rob Knight, and
Jeffrey I Gordon. The effect of diet on the human gut microbiome: a metagenomic analysis
in humanized gnotobiotic mice. Science translational medicine, 1(6):6ra14, 2009.

[3] Consortium HMP. A framework for human microbiome research. Nature, 486(7402), 2012.

[4] Gordon K Smyth. Limma: linear models for microarray data. Number October. Springer,

2005.

[5] A P Dempster, N M Laird, and D B Rubin. Maximum likelihood from incomplete data via
the em algorithm. Journal of the Royal Statistical Society Series B Methodological, 39(1):1–
38, 1977.

35

