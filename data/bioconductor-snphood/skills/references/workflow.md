# Workflow example

Christian Arnold, Pooja Bhat, Judith Zaugg

#### 30 October 2025

#### Abstract

This workflow vignette shows how to use the *SNPhood* package in a real-world example. For this purpose, you will use the *SNPhoodData* package for a more complex analysis to illustrate most of the features from *SNPhood*. Importantly, you will also learn in detail how to work with a *SNPhood* object and what its main functions and properties are. The vignette will be continuously updated whenever new functionality becomes available or when we receive user feedback.

#### Package

SNPhood 1.40.0

# Contents

* [1 Example Workflow](#example-workflow)
  + [1.1 Data check and collection](#data-check-and-collection)
  + [1.2 Setting up *SNPhood*](#setting-up-snphood)
  + [1.3 Quality control](#quality-control)
  + [1.4 Executing the main function](#executing-the-main-function)
  + [1.5 Working with a *SNPhood* object: Extracting and manipulating information and metadata](#working-with-a-snphood-object-extracting-and-manipulating-information-and-metadata)
  + [1.6 Visualizing counts and enrichment](#visualizing-counts-and-enrichment)
  + [1.7 Testing for and visualizing allelic biases](#testing-for-and-visualizing-allelic-biases)
  + [1.8 Cluster analyses](#cluster-analyses)
  + [1.9 Genotype analyses](#genotype-analyses)
  + [1.10 Combined cluster and genotype analyses](#combined-cluster-and-genotype-analyses)
  + [1.11 How to continue?](#how-to-continue)
* [2 Bug Reports, Feature Requests and Contact Information](#bug-reports-feature-requests-and-contact-information)
* [3 References](#references)
* **Appendix**

# 1 Example Workflow

In the following example, you will use data from the *SNPhoodData* package to address the question how many of the previously identified H3K27ac quantitative trait loci (QTLs) for individuals from the Yoruban (YRI) population [1] show allele-specific signal in individuals of European origin (CEU).

First, let’s load the required libraries *SNPhood* and *SNPhoodData*.

```
library(SNPhoodData)
library(SNPhood)
```

## 1.1 Data check and collection

Now let’s check the data you will use for the following analysis:

```
(files = list.files(pattern = "*", system.file("extdata", package = "SNPhoodData"),
    full.names = TRUE))
```

```
##  [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM10847_H3K27AC_1_reconcile.dedup.chr21.bam"
##  [2] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM10847_H3K27AC_1_reconcile.dedup.chr21.bam.bai"
##  [3] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM10847_H3K27AC_2_reconcile.dedup.chr21.bam"
##  [4] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM10847_H3K27AC_2_reconcile.dedup.chr21.bam.bai"
##  [5] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM12890_H3K27AC_1_reconcile.dedup.chr21.bam"
##  [6] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM12890_H3K27AC_1_reconcile.dedup.chr21.bam.bai"
##  [7] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM12890_H3K27AC_2_reconcile.dedup.chr21.bam"
##  [8] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM12890_H3K27AC_2_reconcile.dedup.chr21.bam.bai"
##  [9] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/cisQ.H3K27AC.chr21.txt"
## [10] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/genotypes.vcf.gz"
```

```
fileUserRegions = files[grep(".txt", files)]
fileGenotypes = files[grep("genotypes", files)]
```

The data comprises:

* a file with the user-defined regions (in this case, H3K27ac hQTLs from chromosome 21: cisQ.H3K27AC.chr21.txt)
* H3K27ac ChIP-Seq files in BAM format for two individuals (two replicates each) and corresponding index files for chr21 (SNYDER\_HG19\_\**H3K27AC*\*\_reconcile.dedup.chr21.bam)
* corresponding genotypes for the hQTLs in a gzipped VCF file (genotypes.vcf.gz)

The first two are required to run a *SNPhood* analysis, genotype files are optional.

## 1.2 Setting up *SNPhood*

To set up a *SNPhood* analysis, you first need to create a named list that contains all parameters needed in a *SNPhood* analysis. This can be done by calling the function *getDefaultParameterList*, which generates a default list of parameters. It takes up to two (optional) arguments, which is 1) the path to the user-defined regions file and 2) whether or not the data are paired-end:

```
(par.l = getDefaultParameterList(path_userRegions = fileUserRegions, isPairedEndData = TRUE))
```

```
## $readFlag_isPaired
## [1] TRUE
##
## $readFlag_isProperPair
## [1] TRUE
##
## $readFlag_isUnmappedQuery
## [1] FALSE
##
## $readFlag_hasUnmappedMate
## [1] FALSE
##
## $readFlag_isMinusStrand
## [1] NA
##
## $readFlag_isMateMinusStrand
## [1] NA
##
## $readFlag_isFirstMateRead
## [1] NA
##
## $readFlag_isSecondMateRead
## [1] NA
##
## $readFlag_isNotPrimaryRead
## [1] FALSE
##
## $readFlag_isNotPassingQualityControls
## [1] FALSE
##
## $readFlag_isDuplicate
## [1] FALSE
##
## $readFlag_reverseComplement
## [1] FALSE
##
## $readFlag_simpleCigar
## [1] TRUE
##
## $readFlag_minMapQ
## [1] 0
##
## $path_userRegions
## [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/cisQ.H3K27AC.chr21.txt"
##
## $zeroBasedCoordinates
## [1] FALSE
##
## $regionSize
## [1] 500
##
## $binSize
## [1] 50
##
## $readGroupSpecific
## [1] TRUE
##
## $strand
## [1] "both"
##
## $startOpen
## [1] FALSE
##
## $endOpen
## [1] FALSE
##
## $headerLine
## [1] FALSE
##
## $linesToParse
## [1] -1
##
## $lastBinTreatment
## [1] "delete"
##
## $assemblyVersion
## [1] "hg19"
##
## $effectiveGenomeSizePercentage
## [1] -1
##
## $nCores
## [1] 1
##
## $keepAllReadCounts
## [1] FALSE
##
## $normByInput
## [1] FALSE
##
## $normAmongEachOther
## [1] TRUE
##
## $poolDatasets
## [1] FALSE
```

In many cases the default returned parameter values are a reasonable choice. However, **always check the validity and usefulness of the parameters before starting an analysis** to avoid unreasonable results.

In this example the default value for most parameters is a reasonable choice: the size of the regions (*regionSize* = 500) resulting in an analysis window of 2 \* 500 (5’ and 3’ of the hQTL) + 1 (for the hQTL) = 1001 bp. Often it is useful to do a pilot analysis with only a few regions to explore the data fast. This can be done by setting the parameter *linesToParse* to a value > -1 to indicate the number of lines that should be parsed. Since here we work with only 178 hQTLs on chr21 we keep all of them for the analysis.

There are a few parameters that we have to adjust:
First, we want to pool datasets because there are two replicates for each individual, and combining the datasets will give us more power, for example to detect allelic biases (parameter *poolDatasets*). You also have to carefully check if the start positions in the user regions file are 0-based or 1-based because a shift of one base pair will result in non-sensical results for the genotype distribution of the hQTLs that are determined automatically during the analysis. In this case, start coordinates are 1-based, which is also the default for the parameter *zeroBasedCoordinates*. Our the data are mapped allele-specifically, so perform allele-specific analysis you have to ensure to set the parameter *readGroupSpecific* to TRUE.

*SNPhood* offers a powerful and intuitive way of controlling which reads are considered valid when importing BAM files by means of the various flags that exist (see <https://samtools.github.io/hts-specs/SAMv1.pdf>), in complete analogy to the *[Rsamtools](https://bioconductor.org/packages/3.22/Rsamtools)* package. In essence, for each flag, a corresponding parameter (*readFlag\_*) exists that specifies if the flag has to be set (*TRUE*), not set (*FALSE*) or if is irrelevant (*NA*).

We thus have to check the default values for the various *readFlag\_* parameters. The default values are for paired-end data, and all of our data here are also paired-end, so we can leave them at their default values. Note that the default values disregard any reads that could be problematic. For example, reads that are marked as duplicates (*readFlag\_isDuplicate*), unmapped (either the read itself or its mate - *readFlag\_isUnmappedQuery* and *readFlag\_hasUnmappedMate*), not a primary read (*readFlag\_isNotPrimaryRead*), not (properly) paired (*readFlag\_isPaired* and *readFlag\_isProperPair*) or fail quality controls (*readFlag\_isNotPassingQualityControls*) are discarded. Note that all flags (as specified by the *readFlag* parameters) that are set to NA will be ignored when importing the reads.

Lastly, we adjust the size of each bin within the region and select a smaller value than the default one (*binSize* = 25 instead of 50).

```
# Verify that you do not have zero-based coordinates
par.l$zeroBasedCoordinates
```

```
## [1] FALSE
```

```
par.l$readGroupSpecific
```

```
## [1] TRUE
```

```
par.l$poolDatasets = TRUE
par.l$binSize = 25
```

You are almost done with the preparation, all that is left is to create a data frame to tell *SNPhood* which data to use for the analysis and some additional meta information. For this, you can use another helper function: *collectFiles*. The argument *patternFiles* specifies the folder and file name of input files; wildcards are allowed.

```
patternBAMFiles = paste0(dirname(files[3]), "/*.bam")
(files.df = collectFiles(patternFiles = patternBAMFiles, verbose = TRUE))
```

```
##                                                                                                                     signal
## 1 /home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM10847_H3K27AC_1_reconcile.dedup.chr21.bam
## 2 /home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM10847_H3K27AC_2_reconcile.dedup.chr21.bam
## 3 /home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM12890_H3K27AC_1_reconcile.dedup.chr21.bam
## 4 /home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM12890_H3K27AC_2_reconcile.dedup.chr21.bam
##   input individual genotype
## 1    NA         NA       NA
## 2    NA         NA       NA
## 3    NA         NA       NA
## 4    NA         NA       NA
```

Finally, you assign the names of the individuals in the column “inidivual” to make pooling of the datasets possible. The column input can be ignored because there is no negative control in this analysis due to the fact that the analysis is done allele-specifically and currently, input normalization does not work in this setting (see the main vignette for details). The column genotype can also be ignored for now because (will be integrated later):

```
files.df$individual = c("GM10847", "GM10847", "GM12890", "GM12890")
files.df
```

```
##                                                                                                                     signal
## 1 /home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM10847_H3K27AC_1_reconcile.dedup.chr21.bam
## 2 /home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM10847_H3K27AC_2_reconcile.dedup.chr21.bam
## 3 /home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM12890_H3K27AC_1_reconcile.dedup.chr21.bam
## 4 /home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/SNYDER_HG19_GM12890_H3K27AC_2_reconcile.dedup.chr21.bam
##   input individual genotype
## 1    NA    GM10847       NA
## 2    NA    GM10847       NA
## 3    NA    GM12890       NA
## 4    NA    GM12890       NA
```

## 1.3 Quality control

\*\* As stated explicitly in the main vignette, *SNPhood* is not a designated and sufficient tool for ChIP-Seq QC and has never been designed as such. It is important to assess potential biases such as GC, mapping, contamination or other biases beforehand using dedicated tools both within and outside the Bioconductor framework (see the main vignette for designated QC tools).\*\*

However, *SNPhood* does offer some rudimentary QC controls. Before executing the full pipeline, you will therefore first do a quick QC step to make sure that the datasets do not have any artefacts. For this, you will investigate the correlation of the raw read counts for our regions among the different datasets. The correlation coefficients should be very high among replicate samples and relatively high among different samples.

For this, you run the main function *analyzeSNPhood* with a special argument and afterwards employ the function *plotCorrelationDatasets*. Note that you temporarily reset the value of the parameter *poolDatasets* to also check the correlation among the replicates samples.

```
par.l$poolDatasets = FALSE
SNPhood.o = analyzeSNPhood(par.l, files.df, onlyPrepareForDatasetCorrelation = TRUE,
    verbose = TRUE)
```

```
## Warning in analyzeSNPhood(par.l, files.df, onlyPrepareForDatasetCorrelation =
## TRUE, : Forcing parameter normAmongEachOther to FALSE because either input
## normalization is turned on, only one files is going to be processed, or because
## allele-specific reads are requested
```

```
## Warning in .parseAndProcessUserRegions(par.l, chrSizes.df, verbose = verbose):
## 4 duplicate region removed in file
## /home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/cisQ.H3K27AC.chr21.txt
## out of 178 regions. New number of regions: 174
```

```
## Warning in analyzeSNPhood(par.l, files.df, onlyPrepareForDatasetCorrelation =
## TRUE, : Note that you set the parameter "onlyPrepareForDatasetCorrelation" to
## TRUE. You will not be able to use any functionality except the sample
## correlation plots. For a full analysis, run the function again and set the
## parameter to FALSE.
```

You can now run the correlation analysis on the *SNPhood* object and plot it directly (we could also plot it to a PDF file):

```
SNPhood.o = plotAndCalculateCorrelationDatasets(SNPhood.o, fileToPlot = NULL)
```

![](data:image/png;base64...)

```
corrResults = results(SNPhood.o, type = "samplesCorrelation")
mean(corrResults$corTable[lower.tri(corrResults$corTable)])
```

```
## [1] 0.9177585
```

The correlation values are indeed very high among the replicate samples and also quite high among the individuals. The mean correlation coefficient among the datasets is 0.91, which is very high (note that only the lower triangle matrix of the correlation matrix is used for this, to not bias the analysis). There does not seem to be a problem with the datasets. However, as mentioned repeatedly, this is **not** sufficient for QC and should only be another verification that data quality is high and that biases have been controlled for.

## 1.4 Executing the main function

Now you can execute the full pipeline by setting the parameter *onlyPrepareForDatasetCorrelation* to FALSE again (the default). The execution of the function may take a few minutes and may issue some warnings e.g. indicating missing data and “correcting” inconsistent parameter settings:

```
par.l$poolDatasets = TRUE
SNPhood.o = analyzeSNPhood(par.l, files.df, onlyPrepareForDatasetCorrelation = FALSE,
    verbose = TRUE)
```

```
## Warning in analyzeSNPhood(par.l, files.df, onlyPrepareForDatasetCorrelation =
## FALSE, : Forcing parameter normAmongEachOther to FALSE because either input
## normalization is turned on, only one files is going to be processed, or because
## allele-specific reads are requested
```

```
## Warning in .parseAndProcessUserRegions(par.l, chrSizes.df, verbose = verbose):
## 4 duplicate region removed in file
## /home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/cisQ.H3K27AC.chr21.txt
## out of 178 regions. New number of regions: 174
```

The warnings indicate that 4 duplicate regions have been removed as well as that the parameter *normAmongEachOther* has been set to FALSE because, in this case, reads are read group(allele)-specific (parameter *readGroupSpecific* is set to TRUE).

## 1.5 Working with a *SNPhood* object: Extracting and manipulating information and metadata

Now you can start analyzing the results already, as the main pipeline finished. To familiarize ourselves with the *SNPhood* object let’s first take a look at some of its properties and helper functions. Generally, there are four “entities” stored in a *SNPhood* object: regions, datasets, bins, and read groups. For all of them, methods to extract and alter the stored information exist (see below).

```
SNPhood.o

## Retrieve number of regions, datasets, bins, and read groups
nRegions(SNPhood.o)
nDatasets(SNPhood.o)
nBins(SNPhood.o)
nReadGroups(SNPhood.o)

## Retrieve general annotation of SNPhood object with all its different
## elements
names(annotation(SNPhood.o))
annotation(SNPhood.o)$regions
annotation(SNPhood.o)$files

## Retrieve the parameters that were used for the analysis
head(parameters(SNPhood.o))
names(parameters(SNPhood.o))

## Retrieve annotation of regions
head(annotationRegions(SNPhood.o))

## Retrieve annotation of bins
annotationBins(SNPhood.o)
head(annotationBins2(SNPhood.o, fullAnnotation = TRUE))
SNP_names = c("rs7275860", "rs76473124")
head(annotationBins2(SNPhood.o, regions = 1:10, fullAnnotation = FALSE))
annotationBins2(SNPhood.o, regions = SNP_names, fullAnnotation = TRUE)

## Retrieve annotation of datasets
annotationDatasets(SNPhood.o)
annotationReadGroups(SNPhood.o)

## Extract counts after the binning

# Extract one count matrix from the paternal read group from the first dataset
head(counts(SNPhood.o, type = "binned", readGroup = "paternal", dataset = 1))

# Extract count matrices from all read groups from the first dataset
str(counts(SNPhood.o, type = "binned", readGroup = NULL, dataset = 1))

# Extract count matrices from all read groups from the first dataset (using its
# name)
DataSetName <- annotationDatasets(SNPhood.o)[1]
str(counts(SNPhood.o, type = "binned", readGroup = NULL, dataset = DataSetName))

# Extract count matrices from all read groups from the all dataset
str(counts(SNPhood.o, type = "binned", dataset = NULL))

## Similarly, you can also extract counts before the binning
head(counts(SNPhood.o, type = "unbinned", readGroup = "paternal", dataset = 1))

## If you had enrichments instead of counts, you would employ the enrichments
## method in analogy to counts
enrichment(SNPhood.o, readGroup = "paternal")
```

```
## Warning in .getCounts(SNPhood.o, type = "enrichmentBinned", readGroup,
## dataset): Returning an empty list, could not find the requested data in the
## object. Did you ask for the correct type of data? See also the help pages.
```

You can modify the information stored in a *SNPhood* object:

```
SNPhood.o

## Rename regions, datasets, bins, and read groups
mapping = as.list(paste0(annotationRegions(SNPhood.o), ".newName"))
names(mapping) = annotationRegions(SNPhood.o)
SNPhood_mod.o = renameRegions(SNPhood.o, mapping)

mapping = list("Individual1", "Individual2")
names(mapping) = annotationDatasets(SNPhood.o)
SNPhood_mod.o = renameDatasets(SNPhood.o, mapping)

mapping = list("Bin1_NEW")
names(mapping) = annotationBins(SNPhood.o)[1]
SNPhood_mod.o = renameBins(SNPhood.o, mapping)

mapping = list("a", "b", "c")
names(mapping) = annotationReadGroups(SNPhood.o)
SNPhood_mod.o = renameReadGroups(SNPhood.o, mapping)

## Delete regions, datasets, and read groups (deleting bins is still in
## development)
SNPhood_mod.o = deleteRegions(SNPhood.o, regions = 1:5)
SNPhood_mod.o = deleteRegions(SNPhood.o, regions = c("rs9984805", "rs59121565"))

SNPhood_mod.o = deleteDatasets(SNPhood.o, datasets = 1)
SNPhood_mod.o = deleteDatasets(SNPhood.o, datasets = "GM12890")

# For read groups, we currently support only a name referral
SNPhood_mod.o = deleteReadGroups(SNPhood.o, readGroups = "paternal")

## Merge read groups
SNPhood_merged.o = mergeReadGroups(SNPhood.o)
nReadGroups(SNPhood_merged.o)
annotationReadGroups(SNPhood_merged.o)
```

## 1.6 Visualizing counts and enrichment

Let’s first visualize the number of overlapping reads for the regions before (*plotRegionCounts*) and after binning (*plotBinCounts*) datasets and read groups. The two functions have a number of arguments to make the visualization as flexible as possible. See the help pages for details, we here only touch upon a few parameters:

```
plotBinCounts(SNPhood.o, regions = 2)
```

```
## Warning: `aes_()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`
## ℹ The deprecated feature was likely used in the SNPhood package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the SNPhood package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

```
plotBinCounts(SNPhood.o, regions = 2, plotGenotypeRatio = TRUE, readGroups = c("paternal",
    "maternal"))
```

```
## Warning: Removed 14 rows containing missing values or values outside the scale range
## (`geom_line()`).
```

![](data:image/png;base64...)

```
plotRegionCounts(SNPhood.o, regions = 1:5, plotRegionBoundaries = TRUE, sizePoints = 2,
    plotRegionLabels = TRUE, mergeReadGroupCounts = TRUE)
```

![](data:image/png;base64...)

```
plotRegionCounts(SNPhood.o, regions = NULL, plotChr = "chr21", sizePoints = 2)
```

![](data:image/png;base64...)

We can also create aggregate plots and plot the bin counts for all regions or a subset of regions:

```
plotBinCounts(SNPhood.o, regions = NULL, readGroups = c("paternal", "maternal"))
```

```
## Warning in plotBinCounts(SNPhood.o, regions = NULL, readGroups = c("paternal",
## : Cannot add genotype as the number of regions to plot is 174 and not 1.
```

![](data:image/png;base64...)

## 1.7 Testing for and visualizing allelic biases

We now test for allelic biases. To determine the significance across regions, one can select the lowest p-value for each region. This ensures to select the bin with the most power (which often has the highest number of reads) to detect allelic bias. However, the tests for bins are not independent from one another and the p-values are not adjusted for multiple testing. We therefore implemented a permutation-based procedure to control the false discovery rate (FDR). This option is also enabled by default (parameters *calcBackgroundDistr* and *nRepetitions*).

```
# Run the analysis, perform no time-consuming background calculation for now
SNPhood.o = testForAllelicBiases(SNPhood.o, readGroups = c("paternal", "maternal"),
    calcBackgroundDistr = TRUE, nRepetitions = 100, verbose = FALSE)

# Extract the results of the analysis, again using the results function
names(results(SNPhood.o, type = "allelicBias"))
```

```
## [1] "pValue"           "confIntervalMin"  "confIntervalMax"  "fractionEstimate"
## [5] "background"       "FDR_results"      "parameters"
```

```
head(results(SNPhood.o, type = "allelicBias", elements = "pValue")[[1]], 4)
```

```
##                  bin_1      bin_2      bin_3     bin_4     bin_5     bin_6
## rs75359783  1.00000000 1.00000000 1.00000000 1.0000000 1.0000000 1.0000000
## rs8132276   0.25587508 0.34888888 0.40503225 0.6776395 1.0000000 0.8145294
## rs113783782 0.02127075 0.07681274 0.01921082 0.1184692 0.5488281 0.7539063
## rs7275860   0.50000000 0.50000000 0.62500000 0.3750000 1.0000000 1.0000000
##                  bin_7     bin_8     bin_9     bin_10     bin_11    bin_12
## rs75359783  1.00000000 1.0000000 1.0000000 1.00000000 1.00000000 1.0000000
## rs8132276   1.00000000 1.0000000 0.6290588 0.14346313 0.40487289 1.0000000
## rs113783782 0.03857422 0.1796875 0.1184692 0.05737305 0.03515625 0.1795654
## rs7275860   0.62500000 0.2500000 0.0312500 0.03125000 0.03125000 0.0703125
##                bin_13    bin_14    bin_15    bin_16    bin_17    bin_18
## rs75359783  1.0000000 1.0000000 1.0000000 1.0000000 1.0000000 1.0000000
## rs8132276   1.0000000 0.8238029 0.1670685 0.3017578 0.8238029 0.8238029
## rs113783782 0.2668457 0.5078125 0.3876953 0.5078125 0.6875000 0.6875000
## rs7275860   0.1796875 1.0000000 0.4531250 0.4531250 0.3750000 0.2187500
##                bin_19    bin_20    bin_21   bin_22 bin_23    bin_24    bin_25
## rs75359783  1.0000000 1.0000000 1.0000000 1.000000 1.0000 1.0000000 1.0000000
## rs8132276   0.4048729 0.8318119 0.8238029 1.000000 1.0000 0.5810547 0.1795654
## rs113783782 0.3750000 1.0000000 1.0000000 1.000000 0.6875 1.0000000 0.6875000
## rs7275860   0.1250000 0.4531250 0.4531250 0.453125 0.1250 0.2890625 0.2187500
##                bin_26    bin_27   bin_28  bin_29    bin_30  bin_31     bin_32
## rs75359783  1.0000000 1.0000000 1.000000 1.00000 1.0000000 1.00000 1.00000000
## rs8132276   0.2668457 0.5078125 0.453125 0.37500 1.0000000 1.00000 1.00000000
## rs113783782 0.2890625 0.0390625 0.218750 0.12500 0.1250000 0.21875 0.21875000
## rs7275860   0.0703125 0.2890625 0.453125 0.21875 0.0390625 0.12500 0.00390625
##                   bin_33       bin_34     bin_35     bin_36   bin_37 bin_38
## rs75359783  1.0000000000 1.0000000000 1.00000000 1.00000000 1.000000  1.000
## rs8132276   0.5000000000 1.0000000000 1.00000000 1.00000000 1.000000  1.000
## rs113783782 0.0214843750 0.0117187500 0.00390625 0.00781250 0.015625  0.375
## rs7275860   0.0009765625 0.0004882813 0.00390625 0.00390625 0.015625  0.250
##             bin_39 bin_40
## rs75359783   1.000  1.000
## rs8132276    1.000  1.000
## rs113783782  0.625  0.125
## rs7275860    0.500  0.125
```

```
# Extract the results of the FDR calculation for the first dataset
FDR_dataset1 = results(SNPhood.o, type = "allelicBias", elements = "FDR_results")[[1]]
head(FDR_dataset1, 20)
```

```
##    pValueThreshold         FDR nReal  nSim
## 1           0.0001 0.000000000     5  0.00
## 2           0.0005 0.003322259     6  0.02
## 3           0.0010 0.008264463     6  0.05
## 4           0.0050 0.060402685     7  0.45
## 5           0.0100 0.086757991    10  0.95
## 6           0.0200 0.160206718    13  2.48
## 7           0.0300 0.200000000    14  3.50
## 8           0.0400 0.287622440    16  6.46
## 9           0.0500 0.287974684    18  7.28
## 10          0.0600 0.300441826    19  8.16
## 11          0.0700 0.325908558    23 11.12
## 12          0.0800 0.343365253    24 12.55
## 13          0.0900 0.352051836    24 13.04
## 14          0.1000 0.371398638    24 14.18
## 15          0.1100 0.388067313    24 15.22
## 16          0.1200 0.393056567    25 16.19
## 17          0.1300 0.421233496    32 23.29
## 18          0.1400 0.424874191    32 23.64
## 19          0.1500 0.426086957    33 24.50
## 20          0.1600 0.427679501    33 24.66
```

```
# Extract the results of the FDR calculation for the second dataset
FDR_dataset2 = results(SNPhood.o, type = "allelicBias", elements = "FDR_results")[[2]]
head(FDR_dataset2, 20)
```

```
##    pValueThreshold         FDR nReal  nSim
## 1           0.0001 0.001248439     8  0.01
## 2           0.0005 0.005424955    11  0.06
## 3           0.0010 0.009900990    11  0.11
## 4           0.0050 0.046221570    13  0.63
## 5           0.0100 0.064983637    20  1.39
## 6           0.0200 0.131464666    22  3.33
## 7           0.0300 0.201741655    22  5.56
## 8           0.0400 0.247894103    25  8.24
## 9           0.0500 0.271773959    25  9.33
## 10          0.0600 0.300503637    25 10.74
## 11          0.0700 0.319419238    30 14.08
## 12          0.0800 0.342523860    31 16.15
## 13          0.0900 0.340000000    33 17.00
## 14          0.1000 0.349157734    34 18.24
## 15          0.1100 0.364960777    34 19.54
## 16          0.1200 0.374770136    34 20.38
## 17          0.1300 0.381472957    43 26.52
## 18          0.1400 0.385099385    43 26.93
## 19          0.1500 0.389312977    44 28.05
## 20          0.1600 0.391592920    44 28.32
```

```
maxFDR = 0.1
signThresholdFDR_dataset1 = FDR_dataset1$pValueThreshold[max(which(FDR_dataset1$FDR <
    maxFDR))]
signThresholdFDR_dataset2 = FDR_dataset2$pValueThreshold[max(which(FDR_dataset1$FDR <
    maxFDR))]
```

From the FDR results we see that for both datasets, the FDR is below 10% for p-values < 0.01. For this analysis, 10% is an acceptable number, so we will use this as significance threshold for the upcoming visualization functions.

You can now visualize the results to get an overview of the allelic bias in our dataset. You may start by visualizing the results of the allelic bias analysis across regions or a user-defined genomic range such as the full chromosome 21. For this, the function *plotAllelicBiasResultsOverview* is employed, which either plots the minimum or median p-value for each region in the selected genomic region.

```
plotAllelicBiasResultsOverview(SNPhood.o, regions = NULL, plotChr = "chr21", signThreshold = 0.01,
    pValueSummary = "min")
```

![](data:image/png;base64...)

```
plotAllelicBiasResultsOverview(SNPhood.o, regions = 3:5, plotRegionBoundaries = TRUE,
    plotRegionLabels = TRUE, signThreshold = 0.01, pValueSummary = "min")
```

![](data:image/png;base64...)

The first plot indicates that a considerable amount of regions seems to show an allelic bias. You can then look at the results for the allelic bias analysis in detail for a specific dataset and region with the function *plotAllelicBiasResults*:

```
plots = plotAllelicBiasResults(SNPhood.o, region = 2, signThreshold = 0.01, readGroupColors = c("blue",
    "red", "gray"))
```

```
## Warning: Removed 6 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

```
plots = plotAllelicBiasResults(SNPhood.o, region = 7, signThreshold = 0.01, readGroupColors = c("blue",
    "red", "gray"))
```

```
## Warning: Removed 5 rows containing missing values or values outside the scale range
## (`geom_point()`).
```

![](data:image/png;base64...)

While the first plot shows an example of a region for which no allelic bias can be found, the second one shows significant allelic bias across many bins. In this case, the allelic bias might be caused by the genotype, as paternal and maternal reads have different genotypes (see the legend, A versus C).

## 1.8 Cluster analyses

*SNPhood* provides some clustering functionalities to cluster SNPs based on their local neighbourhood. Let’s try them out. First, you will cluster the counts for the paternal read group (allele) from the first dataset using 2 and 5 clusters, respectively. The function *plotAndClusterMatrix* returns an object of class *SNPhood* so that the clustering results can be accessed directly for subsequent visualization.

```
SNPhood.o = plotAndClusterMatrix(SNPhood.o, readGroup = "paternal", nClustersVec = 2,
    dataset = 1, verbose = FALSE)
```

![](data:image/png;base64...)

```
SNPhood.o = plotAndClusterMatrix(SNPhood.o, readGroup = "paternal", nClustersVec = 5,
    dataset = 1, verbose = FALSE)
```

![](data:image/png;base64...)

```
str(results(SNPhood.o, type = "clustering", elements = "paternal"), list.len = 3)
```

```
## List of 1
##  $ GM10847:List of 2
##   ..$ nClusters2:List of 3
##   .. ..$ clusteringMatrix :List of 1
##   .. .. ..$ :'data.frame':   174 obs. of  41 variables:
##   .. .. .. ..$ cluster: int [1:174] 2 2 2 2 2 2 2 2 2 2 ...
##   .. .. .. ..$ bin_1  : num [1:174] 0.186 -0.309 -0.455 -0.582 -0.908 ...
##   .. .. .. ..$ bin_2  : num [1:174] -0.0705 -0.3092 -0.4548 -0.5823 -0.9081 ...
##   .. .. .. .. [list output truncated]
##   .. ..$ averageSilhouette: num 0.559
##   .. ..$ plots            :List of 1
##   .. .. ..$ :List of 45
##   .. .. .. ..$ formula          :Class 'formula'  language z ~ row * column
##   .. .. .. .. .. ..- attr(*, ".Environment")=<environment: 0x640dce222d38>
##   .. .. .. ..$ as.table         : logi FALSE
##   .. .. .. ..$ aspect.fill      : logi TRUE
##   .. .. .. .. [list output truncated]
##   .. .. .. ..- attr(*, "class")= chr "trellis"
##   ..$ nClusters5:List of 3
##   .. ..$ clusteringMatrix :List of 1
##   .. .. ..$ :'data.frame':   174 obs. of  41 variables:
##   .. .. .. ..$ cluster: int [1:174] 5 5 5 5 5 5 5 4 4 4 ...
##   .. .. .. ..$ bin_1  : num [1:174] 0.186 -0.309 -0.664 0.457 -0.733 ...
##   .. .. .. ..$ bin_2  : num [1:174] -0.0705 -0.3092 -0.6637 -0.3209 -0.7334 ...
##   .. .. .. .. [list output truncated]
##   .. ..$ averageSilhouette: num 0.605
##   .. ..$ plots            :List of 1
##   .. .. ..$ :List of 45
##   .. .. .. ..$ formula          :Class 'formula'  language z ~ row * column
##   .. .. .. .. .. ..- attr(*, ".Environment")=<environment: 0x640dc8ed1848>
##   .. .. .. ..$ as.table         : logi FALSE
##   .. .. .. ..$ aspect.fill      : logi TRUE
##   .. .. .. .. [list output truncated]
##   .. .. .. ..- attr(*, "class")= chr "trellis"
```

You can also plot only a subset of the clusters to remove clusters with invariant regions. Here, let’s only plot clusters 2 to 5 instead of all of them (that is, 1 to 5):

```
SNPhood.o = plotAndClusterMatrix(SNPhood.o, readGroup = "paternal", nClustersVec = 5,
    dataset = 1, clustersToPlot = 2:5, verbose = FALSE)
```

![](data:image/png;base64...)

As you can see, most of the regions have now been removed because they belonged to cluster 1.

To summarize the cluster results and to more easily detect the patterns, you can also calculate the average enrichment across bins per cluster using the function *plotClusterAverage*. Note that this function returns the plots only:

```
p = plotClusterAverage(SNPhood.o, readGroup = "paternal", dataset = 1)
```

```
## Warning in plotClusterAverage(SNPhood.o, readGroup = "paternal", dataset = 1):
## Multiple clustering results found, summarizing all of them. Multiple plots will
## be produced. Specify a filename for the parameter fileToPlot to see them all.
```

![](data:image/png;base64...)![](data:image/png;base64...)

The warning can be ignored here, it simply informs us that multiple plots have been generated even though no file name has been specified. Thus, you may only seem the last plot.

## 1.9 Genotype analyses

Next you can integrate the genotype from external sources for our regions. For this, you first create a data frame to specify which datasets to integrate genotypes with, the path to the VCF file that provides the genotypes, and the name of the column in the VCF file that corresponds to the dataset.

```
(mapping = data.frame(samples = annotationDatasets(SNPhood.o), genotypeFile = rep(fileGenotypes,
    2), sampleName = c("NA10847", "NA12890")))
```

```
##   samples
## 1 GM10847
## 2 GM12890
##                                                                        genotypeFile
## 1 /home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/genotypes.vcf.gz
## 2 /home/biocbuild/bbs-3.22-bioc/R/site-library/SNPhoodData/extdata/genotypes.vcf.gz
##   sampleName
## 1    NA10847
## 2    NA12890
```

```
SNPhood.o = associateGenotypes(SNPhood.o, mapping)
```

Let’s take a look at the imported genotypes to check the uniformity across datasets:

```
p = plotGenotypesPerSNP(SNPhood.o, regions = 1:20)
```

![](data:image/png;base64...)

## 1.10 Combined cluster and genotype analyses

An additional feature that might be useful when performing clustering on several individuals is to group individuals for each SNP according to their genotype, which we divide into “strong” and “weak” genotypes. They are determined based on the signal obtained for the different genotypes. For this, we use the function *plotAndCalculateWeakAndStrongGenotype*. This function can only be executed when read groups have been merged (i.e., when only one read group is present). That’s easy to fix:

```
SNPhood_merged.o = mergeReadGroups(SNPhood.o)
SNPhood_merged.o = plotAndCalculateWeakAndStrongGenotype(SNPhood_merged.o, normalize = TRUE,
    nClustersVec = 3)
```

```
## [[1]]
```

![](data:image/png;base64...)

```
##
## [[1]]
```

![](data:image/png;base64...)

The first plot shows the results for the strong genotype, the second one for the weak genotype.

Note that you now have two *SNPhood* objects in your workspace: One without and one with merged read groups. Because merging read groups is irreversible (see ?mergeReadGroups), we keep both objects in the workspace.

You can now combine clustering and genotype one more time and perform the clustering only on the signal averaged across all high-genotype individuals at each SNP to increase the signal to noise ratio (analogous to the analysis in Figure 6 in Grubert et al. [1]):

```
p = plotGenotypesPerCluster(SNPhood_merged.o, printPlot = FALSE, printBinLabels = TRUE,
    returnOnlyPlotNotObject = TRUE)
p[[1]]
```

```
## [[1]]
```

![](data:image/png;base64...)

## 1.11 How to continue?

From here on, possibilities are endless, and you can further investigate patterns and trends in the data! We hope that the *SNPhood* package is useful for your research and encourage you to contact us if you have any question or feature request!

# 2 Bug Reports, Feature Requests and Contact Information

We value all the feedback that we receive and will try to reply in a timely manner.

Please report any bug that you encounter as well as any feature request that you may have to SNPhood@gmail.com.

# 3 References

# Appendix

[1] Grubert, F., Zaugg, J. B., Kasowski, M., Ursu, O., Spacek, D. V., Martin, A. R., … & Snyder, M. (2015). Genetic Control of Chromatin States in Humans Involves Local and Distal Chromosomal Interactions. Cell, 162(5), 1051-1065.