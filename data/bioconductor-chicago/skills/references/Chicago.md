# CHiCAGO Vignette

Jonathan Cairns, Paula Freire-Pritchett, Mikhail Spivakov

#### 31st March, 2016

# Contents

* [1 Introduction](#introduction)
* [2 Workflow](#workflow)
  + [2.1 Input files required](#input-files-required)
  + [2.2 Example workflow](#example-workflow)
  + [2.3 Output plots](#output-plots)
    - [2.3.1 Interpreting the plots](#interpreting-the-plots)
  + [2.4 Output files](#output-files)
    - [2.4.1 ibed format (ends with …ibed):](#ibed-format-ends-with-ibed)
    - [2.4.2 seqmonk format (ends with …seqmonk.txt):](#seqmonk-format-ends-with-seqmonk.txt)
    - [2.4.3 washU\_text format (ends with …washU\_text.txt):](#washu_text-format-ends-with-washu_text.txt)
  + [2.5 Visualising interactions](#visualising-interactions)
  + [2.6 Peak enrichment for features](#peak-enrichment-for-features)
  + [2.7 Further downstream analysis](#further-downstream-analysis)
  + [2.8 The chicagoData object](#cd)

# 1 Introduction

CHiCAGO is a method for detecting statistically significant interaction events in Capture HiC data. This vignette will walk you through a typical CHiCAGO analysis.

A typical Chicago job for two biological replicates of CHi-C data takes 2-3 h wall-clock time (including sample pre-processing from bam files) and uses 50G RAM.

|  |  |
| --- | --- |
| *NOTE* | A wrapper to perform this type of analysis, called *runChicago.R*, is provided as part of *chicagoTools*, which is available from our [Bitbucket repository](https://bitbucket.org/chicagoTeam/chicago/src). Refer to the *chicagoTools* README for more information. |

The statistical foundations of CHiCAGO are presented in a separate paper that is currently available as a preprint (Jonathan Cairns\*, Paula Freire-Pritchett\* et al. [2015](#ref-ChicagoPreprint)). Briefly, CHiCAGO uses a convolution background model accounting for both ‘Brownian collisions’ between fragments (distance-dependent) and ‘technical noise’. It borrows information across interactions (with appropriate normalisation) to estimate these background components separately on different subsets of data. CHiCAGO then uses a p-value weighting procedure based on the expected true positive rates at different distance ranges (estimated from data), with scores representing soft-thresholded -log weighted p-values. The score threshold of 5 is a suggested stringent score threshold for calling significant interactions.

|  |  |
| --- | --- |
| *WARNING* | The data set used in this tutorial comes from the package *PCHiCdata*. This package contains small parts (two chromosomes each) of published Promoter Capture HiC data sets in mouse ESCs (Schoenfelder et al. [2015](#ref-Schoenfelder2015)) and GM12878 cells, derived from human LCLs (Mifsud et al. [2015](#ref-Mifsud2015)) - note that both papers used a different interaction-calling algorithm and we are only reusing raw data from them. Do not use any of these sample input data for purposes other than training. |

In this vignette, we use the GM12878 data (Mifsud et al. [2015](#ref-Mifsud2015)):

```
library(Chicago)
library(PCHiCdata)
```

# 2 Workflow

## 2.1 Input files required

Before you start, you will need:

1. Five restriction map information files (“design files”):

* Restriction map file (.rmap) - a bed file containing coordinates of the restriction fragments. By default, 4 columns: chr, start, end, fragmentID.
* Bait map file (.baitmap) - a bed file containing coordinates of the baited restriction fragments, and their associated annotations. By default, 5 columns: chr, start, end, fragmentID, baitAnnotation. The regions specified in this file, including their fragmentIDs, must be an exact subset of those in the .rmap file. The baitAnnotation is a text field that is used only to annotate the output and plots.
* *nperbin* file (.npb), *nbaitsperbin* file (.nbpb), *proxOE* file (.poe) - Precompute these tables from the .rmap and .baitmap files, using the Python script `makeDesignFiles.py` from *chicagoTools* at our [Bitbucket repository](https://bitbucket.org/chicagoTeam/chicago/src). Refer to the `chicagoTools` README file for more details.

We recommend that you put all five of these files into the same directory (that we refer to as designDir). An example of a valid design folder, for a two-chromosome sample of the GM12878 data used in this vignette, is provided in the PCHiCdata package, as follows.

```
dataPath <- system.file("extdata", package="PCHiCdata")
testDesignDir <- file.path(dataPath, "hg19TestDesign")
dir(testDesignDir)
```

```
## [1] "h19_chr20and21.baitmap" "h19_chr20and21.nbpb"    "h19_chr20and21.npb"
## [4] "h19_chr20and21.poe"     "h19_chr20and21.rmap"
```

|  |  |
| --- | --- |
| *NOTE* | Though we talk about “restriction fragments” throughout, any non-overlapping regions can be defined in .rmap (with a subset of these defined as baits). For example, if one wanted to increase power at the cost of resolution, it is possible to use bins of restriction fragments either throughout, or for some selected regions. However, in the binned fragment framework, we advise setting *removeAdjacent* to *FALSE* - see *?setExperiment* for details on how to do this. |

2. You will also need input data files, which should be in CHiCAGO input format, *.chinput*. You can obtain *.chinput* files from aligned Capture Hi-C BAM files by running `bam2chicago.sh`, available as part of `chicagoTools`. (To obtain BAM files from raw fastq files, use a Hi-C alignment & QC pipeline such as [HiCUP](http://www.bioinformatics.babraham.ac.uk/projects/hicup/).

Example *.chinput* files are provided in the PCHiCdata package, as follows:

```
testDataPath <- file.path(dataPath, "GMchinputFiles")
dir(testDataPath)
```

```
## [1] "GM_rep1.chinput" "GM_rep2.chinput" "GM_rep3.chinput"
```

```
files <- c(
    file.path(testDataPath, "GM_rep1.chinput"),
    file.path(testDataPath, "GM_rep2.chinput"),
    file.path(testDataPath, "GM_rep3.chinput")
  )
```

OPTIONAL: The data set in this vignette requires some additional custom settings, both to ensure that the vignette compiles in a reasonable time and to deal with the artificially reduced size of the data set:

```
settingsFile <- file.path(system.file("extdata", package="PCHiCdata"),
                          "sGM12878Settings", "sGM12878.settingsFile")
```

*Omit this step unless you know which settings you wish to alter*. If you are using non-human samples, or a very unusual cell type, one set of options that you might want to change is the weighting parameters: see [Using different weights](#using-different-weights).

## 2.2 Example workflow

We run CHiCAGO on the test data as follows. First, we create a blank `chicagoData` object, and we tell it where the design files are. For this example, we also provide the optional settings file - in your analysis, you can omit the `settingsFile` argument.

```
library(Chicago)

cd <- setExperiment(designDir = testDesignDir, settingsFile = settingsFile)
```

The properties of `chicagoData` objects are discussed more in [The chicagoData object](#cd).

Next, we read in the input data files:

```
cd <- readAndMerge(files=files, cd=cd)
```

Finally, we run the pipeline with `chicagoPipeline()`:

```
cd <- chicagoPipeline(cd)
```

## 2.3 Output plots

`chicagoPipeline()` produces a number of plots. You can save these to disk by setting the `outprefix` argument in `chicagoPipeline()`.

The plots are as follows (an explanation follows):

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

### 2.3.1 Interpreting the plots

Here, we describe the expected properties of the diagnostic plots.

Note that the diagnostic plots above are computed on the fly using only a small fraction of the full GM12878 dataset. In real-world, genome-wide datasets, more fragment pools will be visible and thus the trends described below should be more pronounced.

1. *Brownian other end factors*: The adjustment made to the mean Brownian read count, estimated in the pools of other ends. (“tlb” refers to the number of trans-chromosomal reads that the other end accumulates in total. “B2B” stands for a “bait-to-bait” interactions).

* The red bars should generally increase in height from left to right.
* The blue bars should be higher than the red bars on average, and should also increase in height from left to right.

2. *Technical noise estimates*: The mean number of technical noise reads expected for other ends and baits, respectively, per pools of fragments. These pools, displayed on the x axis, again refer to the number of trans-chromosomal reads that the fragments accumulate.

* The distributions’ median and variance should trend upwards as we move from left to right.
* In the lower subplot, the bait-to-bait estimates (here, the four bars on the far right) should be higher, on average, than the others. Both groups should also have medians and variances that trend upwards, moving from left to right.

3. *Distance function*: The mean number of Brownian reads expected for an `average` bait, as a function of distance, plotted on a log-log scale.

* The function should monotonically decrease.
* The curve should fit the points reasonably well.

## 2.4 Output files

Two main output methods are provided. Here, we discuss the first: exporting to disk. However, it is also possible to export to a GenomeInteractions object, as described in [Further downstream analysis](#further-downstream-analysis).

You can export the results to disk, using `exportResults()`. (If you use *runChicago.R*, the files appear in ./<results-folder>/data). By default, the function outputs three different output file formats:

```
outputDirectory <- tempdir()
exportResults(cd, file.path(outputDirectory, "vignetteOutput"))
```

```
## Reading the restriction map file...
```

```
## Reading the bait map file...
```

```
## Preparing the output table...
```

```
## Writing out for seqMonk...
```

```
## Writing out interBed...
```

```
## Preprocessing for WashU outputs...
```

```
## Writing out text file for WashU browser upload...
```

Each called interaction is assigned a score that represents how strong CHiCAGO believes the interaction is (formally, it is based on -log(adjusted P-value)). Thus, a larger score represents a stronger interaction. In each case, the score threshold of 5 is applied.

Summary of output files:

### 2.4.1 ibed format (ends with …ibed):

```
##   bait_chr bait_start bait_end                  bait_name otherEnd_chr
## 1       20     119103   138049                    DEFB126           20
## 2       20     119103   138049                    DEFB126           20
## 3       20     161620   170741                    DEFB128           20
## 4       20     233983   239479                    DEFB132           20
## 5       20     268639   284501 AL034548.1;C20orf96;ZCCHC3           20
## 6       20     268639   284501 AL034548.1;C20orf96;ZCCHC3           20
##   otherEnd_start otherEnd_end otherEnd_name N_reads score
## 1         161620       170741       DEFB128      11  5.07
## 2         523682       536237       CSNK2A1       6  6.78
## 3          73978        76092             .      16  5.11
## 4         206075       209203       DEFB129      33  5.96
## 5         293143       304037             .      34  7.35
## 6         304038       305698             .      34  8.94
```

* each row represents an interaction
* first four columns give information about the chromosome, start, end and name of the bait fragment
* next four columns give information about the chromosome, start, end and name of the other end that interacts with the bait fragment
* N\_reads is the number of reads
* score is as defined above

### 2.4.2 seqmonk format (ends with …seqmonk.txt):

```
##   V1     V2     V3      V4 V5   V6
## 1 20 119103 138049 DEFB126 11 5.07
## 2 20 161620 170741 DEFB128 11 5.07
## 3 20 119103 138049 DEFB126  6 6.78
## 4 20 523682 536237 CSNK2A1  6 6.78
## 5 20 161620 170741 DEFB128 16 5.11
## 6 20  73978  76092       . 16 5.11
```

* Can be read by [seqmonk](http://www.bioinformatics.babraham.ac.uk/projects/seqmonk/).
* An interaction is represented by two rows: the first row is the bait, the second the other end. Thus, the file alternates: bait1, otherEnd1, bait2, otherEnd2, …
* Columns are: chromosome, start, end, name, number of reads, interaction score (see above)

### 2.4.3 washU\_text format (ends with …washU\_text.txt):

```
##                    V1                  V2   V3
## 1 chr20,119103,138049 chr20,161620,170741 5.07
## 2 chr20,119103,138049 chr20,523682,536237 6.78
## 3 chr20,161620,170741   chr20,73978,76092 5.11
## 4 chr20,233983,239479 chr20,206075,209203 5.96
## 5 chr20,268639,284501 chr20,293143,304037 7.35
## 6 chr20,268639,284501 chr20,304038,305698 8.94
```

* Can be read by the [WashU browser](http://epigenomegateway.wustl.edu)
* Upload via the “Got text files instead? Upload them from your computer” link.
* Note - Advanced users may wish to export to washU\_track format instead. See the help page for `exportResults()`.

For bait-to-bait interactions, the interaction can be tested either way round (i.e. either fragment can be considered the “bait”). In most output formats, both of these tests are preserved. The exception is washU output, where these scores are consolidated by taking the maximum.

|  |  |
| --- | --- |
| *NOTE* | When comparing interactions detected between multiple replicates, the degree of overlap may appear to be lower than expected. This is due to the undersampled nature of most CHi-C datasets. Sampling error can drive down the sensitivity, particularly for interactions that span large distances and have low read counts. As such, low overlap is not necessarily an indication of a high false discovery rate.    Undersampling needs to be taken into consideration when interpreting CHiCAGO results. In particular, we recommend performing comparisons at the score-level rather than at the level of thresholded interaction calls. Potentially, differential analysis algorithms for sequencing data such as *DESeq2* (Love, Huber, and Anders [2014](#ref-deseq2)) may also be used to formally compare the enrichment at CHiCAGO-detected interactions between conditions at the count level, although power will generally be a limiting factor.    Formal methods such as *sdef* (Blangiardo, Cassese, and Richardson [2010](#ref-sdef)) may provide a more balanced view of the consistency between replicates. Alternatively, additional filtering based on the mean number of reads per detected interaction (e.g. removing calls with N<10 reads) will reduce the impact of undersampling on the observed overlap, but at the cost of decreasing the power to detect longer-range interactions. |

## 2.5 Visualising interactions

The `plotBaits()` function can be used to plot the raw read counts versus linear distance from bait for either specific or random baits, labelling significant interactions in a different colour. By default, 16 random baits are plotted, with interactions within 1 Mb from bait passing the threshold of 5 shown in red and those passing the more lenient threshold of 3 shown in blue.

```
plottedBaitIDs <- plotBaits(cd, n=6)
```

![](data:image/png;base64...)

## 2.6 Peak enrichment for features

`peakEnrichment4Features()` tests the hypothesis that other ends in the CHiCAGO output are enriched for genomic features of interest - for example, histone marks associated with enhancers. We find out how many overlaps are expected under the null hypothesis (i.e. that there is no enrichment) by shuffling the other ends around in the genome, while preserving the overall distribution of distances over which interactions span.

You will need additional files to perform this analysis - namely, a .bed file for each feature. We include ChIP-seq data from the ENCODE consortium (The ENCODE Project Consortium [2012](#ref-encode_integrated_2012)), also restricted to chr20 and chr21. (Data accession numbers: Bernstein lab GSM733752, GSM733772, GSM733708, GSM733664, GSM733771, GSM733758)

First, we find the folder that contains the features, and construct a list of the features to use:

```
featuresFolder <- file.path(dataPath, "GMfeatures")
dir(featuresFolder)
```

```
## [1] "featuresGM.txt"
## [2] "spp.wgEncodeBroadHistoneGm12878CtcfStdAln_chr20and21.narrowPeak"
## [3] "wgEncodeBroadHistoneGm12878H3k27acStdAln_chr20and21.narrowPeak"
## [4] "wgEncodeBroadHistoneGm12878H3k27me3StdAln_chr20and21.narrowPeak"
## [5] "wgEncodeBroadHistoneGm12878H3k4me1StdAln_chr20and21.narrowPeak"
## [6] "wgEncodeBroadHistoneGm12878H3k4me3StdAln_chr20and21.narrowPeak"
## [7] "wgEncodeBroadHistoneGm12878H3k9me3StdAln_chr20and21.narrowPeak"
```

```
featuresFile <- file.path(featuresFolder, "featuresGM.txt")
featuresTable <- read.delim(featuresFile, header=FALSE, as.is=TRUE)
featuresList <- as.list(featuresTable$V2)
names(featuresList) <- featuresTable$V1
featuresList
```

```
## $CTCF
## [1] "spp.wgEncodeBroadHistoneGm12878CtcfStdAln_chr20and21.narrowPeak"
##
## $H3K4me1
## [1] "wgEncodeBroadHistoneGm12878H3k4me1StdAln_chr20and21.narrowPeak"
##
## $H3K4me3
## [1] "wgEncodeBroadHistoneGm12878H3k4me3StdAln_chr20and21.narrowPeak"
##
## $H3k27ac
## [1] "wgEncodeBroadHistoneGm12878H3k27acStdAln_chr20and21.narrowPeak"
##
## $H3K27me3
## [1] "wgEncodeBroadHistoneGm12878H3k27me3StdAln_chr20and21.narrowPeak"
##
## $H3K9me3
## [1] "wgEncodeBroadHistoneGm12878H3k9me3StdAln_chr20and21.narrowPeak"
```

Next, we feed this information into the `peakEnrichment4Features()` function.

As part of the analysis, `peakEnrichment4Features()` takes a distance range (by default, the full distance range over which interactions are observed), and divides it into some number of bins. We must select the number of bins; here, we choose that number to ensure that the bin size is approximately 10kb. If the defaults are changed, a different number of bins is more appropriate. See `?peakEnrichment4Features` for more information.

```
no_bins <- ceiling(max(abs(intData(cd)$distSign), na.rm = TRUE)/1e4)

enrichmentResults <- peakEnrichment4Features(cd, folder=featuresFolder,
              list_frag=featuresList, no_bins=no_bins, sample_number=100)
```

![](data:image/png;base64...)

Note the plot produced by this function. For each feature type, the yellow bar represents the number of features that overlap with interaction other ends. The blue bar represents what would be expected by chance, with a 95% confidence interval for the mean number of overlaps plotted. If the yellow bar lies outside of this interval, we reject the null hypothesis, thus concluding that there is enrichment/depletion of that feature.

The information displayed in the plot is also returned in tabular form (OL = Overlap, SI = Significant Interactions, SD = Standard Deviation, CI = Confidence Interval):

```
enrichmentResults
```

```
##          OLwithSI MeanOLwithSamples SDOLwithSample   LowerCI  HigherCI
## CTCF          349            121.95       9.842574 102.65855 141.24145
## H3K4me1       680            274.97      15.922448 243.76200 306.17800
## H3K4me3       369            136.86      11.426551 114.46396 159.25604
## H3k27ac       464            166.42      12.667608 141.59149 191.24851
## H3K27me3       70             71.46       7.838548  56.09645  86.82355
## H3K9me3       229            120.12      10.318445  99.89585 140.34415
```

## 2.7 Further downstream analysis

We can perform further downstream analysis in R or Bioconductor, using functionality from the *[GenomicInteractions](https://bioconductor.org/packages/3.22/GenomicInteractions)* package. First, we export the significant interactions into a GenomicInteractions object:

```
library(GenomicInteractions)
library(GenomicRanges)
gi <- exportToGI(cd)
```

From here, we can pass the CHiCAGO results through to other Bioconductor functionality. In the following example, we find out which other ends overlap with the H3K4me1 enhancer mark, using ENCODE data. We use *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* to fetch a relevant enhancer mark track from the ENCODE project:

```
library(AnnotationHub)
ah <- AnnotationHub()
hs <- query(ah, c("GRanges", "EncodeDCC", "Homo sapiens", "H3k4me1"))
enhancerTrack <- hs[["AH23254"]]
```

Next, we use the `anchorTwo()` function to extract the other end locations from the GenomicInteractions object (`anchorOne()` would give us the bait locations instead). Note that in this particular instance, the `seqlevels()` also need to be changed before performing the comparison, adding “chr” to make them match those of the annotation.

```
otherEnds <- anchorTwo(gi)
library(GenomeInfoDb)  # for renameSeqlevels()
otherEnds <- renameSeqlevels(otherEnds, c("chr20","chr21"))
```

Finally, we look at which other ends overlap the enhancer marks:

```
findOverlaps(otherEnds, enhancerTrack)
```

```
## Hits object with 4531 hits and 0 metadata columns:
##          queryHits subjectHits
##          <integer>   <integer>
##      [1]         2       40732
##      [2]         2       40735
##      [3]         8       40717
##      [4]         8       40718
##      [5]         9       40721
##      ...       ...         ...
##   [4527]      4161       17634
##   [4528]      4161       17635
##   [4529]      4164       17660
##   [4530]      4164       17661
##   [4531]      4164       17662
##   -------
##   queryLength: 4165 / subjectLength: 109612
```

Further note that the annotation’s genome version should match that of the promoter capture data, namely hg19:

```
hs["AH23254"]$genome
```

```
## [1] "hg19"
```

## 2.8 The chicagoData object

In the above workflows, *cd* is a *chicagoData* object. It contains three elements:

* `intData(cd)` is a *[data.table](https://CRAN.R-project.org/package%3Ddata.table)* (note: not a *data.frame*) that contains information about fragment pairs.
* `settings(cd)` is a list of settings, usually set with the setExperiment() function.
* `params(cd)` is a list of parameters. This list is populated as the pipeline runs, and CHiCAGO estimates them in turn.

A closer look at `intData(cd)`:

```
head(intData(cd), 2)
```

```
## Key: <baitID>
##    baitID otherEndID distbin       s_j otherEndLen distSign isBait2bait   N.1
##     <int>      <int>  <fctr>     <num>       <int>    <int>      <lgcl> <int>
## 1: 403463     403833    <NA> 0.2368791        2579  1652804       FALSE     0
## 2: 403463     403843    <NA> 0.2368791        6302  1690808       FALSE     0
##      N.2   N.3     N refBinMean       s_i   NNb NNboe    tlb      tblb
##    <int> <int> <num>      <num>     <num> <num> <num> <fctr>    <fctr>
## 1:     1     0     1         NA 0.9014785     4     4  [0,1] [  2, 46)
## 2:     1     0     1         NA 0.9987130     4     4  (8,9] [  2, 46)
##           Tmean      Bmean     log.p    log.w     log.q score
##           <num>      <num>     <num>    <num>     <num> <num>
## 1: 0.0004199299 0.08518846 -2.503477 1.406451 -3.909927     0
## 2: 0.0038708177 0.09214475 -2.393987 1.350609 -3.744596     0
```

Columns:

* baitID: ID of baited fragment
* otherEndID: ID of other end fragment
* s\_j: bait-specific scaling factor (Brownian component)
* otherEndLen: The length of the other end fragment
* distSign: The distance from the baited fragment to the other end fragment. Positive and negative values indicate that the other end is, respectively, \(5'\) and \(3'\) of the baited fragment. NA indicates a trans interactions.
* isBait2Bait: TRUE if the other end fragment is also a baited fragment
* N.1, N.2, …: Raw read counts per replicate (see `?mergeSamples`).
* N: Merged count (see `?mergeSamples`) or raw count in the case of single-replicate interaction calling.
* refBinMean: Can be ignored. (see `?normaliseBaits`)
* s\_i: other end-specific scaling factor (Brownian component)
* NNb: “N normalised for baits”, a count scaled up by accounting for s\_j. May be useful for visualization.
* NNboe: “N normalised for baits and other ends”; may be useful for visualization.
* tlb: Class of other end, based on the number of fragments on other chromosomes that have read pairs.
* tblb: As tlb, for the bait fragment.
* Tmean: Expected count from technical noise.
* Bmean: Expected count from Brownian component. (Thus, the expected count under the null hypothesis is Tmean + Bmean.)
* log.p: p-value associated with fragment pair, on log-scale.
* log.w: p-value weight, on log-scale.
* log.q: weighted p-value, on log-scale.
* score: Final CHiCAGO score.

**WARNING:** Many functions in CHiCAGO update `intData(cd)` by reference, which means that `intData(cd)` can change even when you do not explicitly assign to it.
To avoid this behaviour, copy the *chicagoData* object first:

```
newCd = copyCD(cd)
```

##Using different weights

CHiCAGO uses a p-value weighting procedure to upweight proximal interactions and downweight distal interactions. This procedure has four tuning parameters.

The default values of these tuning parameters were calibrated on calls from seven human Macrophage data sets. Provided that your cell type is not too dissimilar to these calibration data, it should be fine to leave the parameters at their default settings. However, if your data set is from a different species or an unusual cell type, you may wish to recalibrate these parameters using data from cell types similar to yours. You can do this with the fitDistCurve.R script in *chicagoTools*, which we demonstrate in this section.

First, run all of the samples through `chicagoPipeline()`, saving each `chicagoData` object in individual .rds files (see `saveRDS()`). Alternatively, if you are using the runChicago.R wrapper, .rds files should be generated automatically.

Second, run the fitDistCurve.R script. As an example, if we had three biological replicates of mESC cells, we might run the following script at the Unix command prompt:

```
Rscript fitDistCurve.R mESC --inputs mESC1.rds,mESC2.rds,mESC3.rds
```

This script produces the file mESC.settingsFile, which you can read in to `modifySettings()` as usual - see the
[Input files required](#input-files-required) section.

Additionally, the script produces a plot (in this case, called mESC\_mediancurveFit.pdf) that can be used to diagnose unreliable estimates. By default, five coloured lines are shown, each representing a parameter estimate from a subset of the data. An unreliable fit is typically diagnosed when the coloured lines are highly dissimilar to each other, and thus the black median line is not representative of them. (Some dissimilarity may be OK, since the median confers robustness.)

For the user’s convenience, a set of precomputed weights are also provided in the package:

```
weightsPath <- file.path(system.file("extdata", package="Chicago"),
                         "weights")
dir(weightsPath)
```

```
## [1] "GM12878-2reps.settings"         "humanMacrophage-7reps.settings"
## [3] "mESC-2reps.settings"
```

For example, to use the GM12878 weights, supply the appropriate settings file to `setExperiment()` as per the following:

```
weightSettings <- file.path(weightsPath, "GM12878-2reps.settings")
cd <- setExperiment(designDir = testDesignDir, settingsFile = weightSettings)
```

##Session info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] GenomeInfoDb_1.46.0               BSgenome.Hsapiens.UCSC.hg19_1.4.3
##  [3] BSgenome_1.78.0                   BiocIO_1.20.0
##  [5] Biostrings_2.78.0                 XVector_0.50.0
##  [7] rtracklayer_1.70.0                AnnotationHub_4.0.0
##  [9] BiocFileCache_3.0.0               dbplyr_2.5.1
## [11] GenomicInteractions_1.44.0        InteractionSet_1.38.0
## [13] SummarizedExperiment_1.40.0       Biobase_2.70.0
## [15] MatrixGenerics_1.22.0             matrixStats_1.5.0
## [17] GenomicRanges_1.62.0              Seqinfo_1.0.0
## [19] IRanges_2.44.0                    S4Vectors_0.48.0
## [21] BiocGenerics_0.56.0               generics_0.1.4
## [23] PCHiCdata_1.37.0                  Chicago_1.38.0
## [25] data.table_1.17.8                 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       rstudioapi_0.17.1        jsonlite_2.0.0
##   [4] magrittr_2.0.4           magick_2.9.0             GenomicFeatures_1.62.0
##   [7] farver_2.1.2             rmarkdown_2.30           vctrs_0.6.5
##  [10] memoise_2.0.1            Rsamtools_2.26.0         RCurl_1.98-1.17
##  [13] base64enc_0.1-3          tinytex_0.57             htmltools_0.5.8.1
##  [16] S4Arrays_1.10.0          progress_1.2.3           curl_7.0.0
##  [19] SparseArray_1.10.0       Formula_1.2-5            sass_0.4.10
##  [22] bslib_0.9.0              htmlwidgets_1.6.4        Gviz_1.54.0
##  [25] httr2_1.2.1              cachem_1.1.0             GenomicAlignments_1.46.0
##  [28] igraph_2.2.1             lifecycle_1.0.4          pkgconfig_2.0.3
##  [31] Matrix_1.7-4             R6_2.6.1                 fastmap_1.2.0
##  [34] digest_0.6.37            colorspace_2.1-2         AnnotationDbi_1.72.0
##  [37] Hmisc_5.2-4              RSQLite_2.4.3            filelock_1.0.3
##  [40] httr_1.4.7               abind_1.4-8              compiler_4.5.1
##  [43] withr_3.0.2              bit64_4.6.0-1            htmlTable_2.4.3
##  [46] S7_0.2.0                 backports_1.5.0          BiocParallel_1.44.0
##  [49] DBI_1.2.3                biomaRt_2.66.0           MASS_7.3-65
##  [52] rappdirs_0.3.3           DelayedArray_0.36.0      rjson_0.2.23
##  [55] tools_4.5.1              foreign_0.8-90           nnet_7.3-20
##  [58] glue_1.8.0               restfulr_0.0.16          grid_4.5.1
##  [61] checkmate_2.3.3          cluster_2.1.8.1          gtable_0.3.6
##  [64] ensembldb_2.34.0         hms_1.1.4                BiocVersion_3.22.0
##  [67] pillar_1.11.1            stringr_1.5.2            dplyr_1.1.4
##  [70] lattice_0.22-7           deldir_2.0-4             bit_4.6.0
##  [73] biovizBase_1.58.0        tidyselect_1.2.1         knitr_1.50
##  [76] gridExtra_2.3            bookdown_0.45            ProtGenerics_1.42.0
##  [79] xfun_0.53                stringi_1.8.7            UCSC.utils_1.6.0
##  [82] lazyeval_0.2.2           yaml_2.3.10              evaluate_1.0.5
##  [85] codetools_0.2-20         cigarillo_1.0.0          interp_1.1-6
##  [88] tibble_3.3.0             BiocManager_1.30.26      cli_3.6.5
##  [91] rpart_4.1.24             jquerylib_0.1.4          dichromat_2.0-0.1
##  [94] Rcpp_1.1.0               png_0.1-8                XML_3.99-0.19
##  [97] parallel_4.5.1           ggplot2_4.0.0            blob_1.2.4
## [100] Delaporte_8.4.2          prettyunits_1.2.0        jpeg_0.1-11
## [103] latticeExtra_0.6-31      AnnotationFilter_1.34.0  bitops_1.0-9
## [106] VariantAnnotation_1.56.0 scales_1.4.0             purrr_1.1.0
## [109] crayon_1.5.3             rlang_1.1.6              KEGGREST_1.50.0
```

##References

Blangiardo, Marta, Alberto Cassese, and Sylvia Richardson. 2010. “sdef: An R Package to Synthesize Lists of Significant Features in Related Experiments.” *BMC Bioinformatics* 11 (1): 270.

Jonathan Cairns\*, Paula Freire-Pritchett\*, Steven W. Wingett, Andrew Dimond, Vincent Plagnol, Daniel Zerbino, Stefan Schoenfelder, Biola-Maria Javierre, Cameron Osborne, Peter Fraser, and Mikhail Spivakov. 2015. “CHiCAGO: Robust Detection of DNA Looping Interactions in Capture Hi-C data.” *bioRxiv*. <https://doi.org/10.1101/028068>.

Love, Michael I, Wolfgang Huber, and Simon Anders. 2014. “Moderated Estimation of Fold Change and Dispersion for Rna-Seq Data with Deseq2.” *Genome Biology* 15 (12): 550. <https://doi.org/10.1186/s13059-014-0550-8>.

Mifsud, Borbala, Filipe Tavares-Cadete, Alice N Young, Robert Sugar, Stefan Schoenfelder, Lauren Ferreira, Steven W Wingett, et al. 2015. “Mapping Long-Range Promoter Contacts in Human Cells with High-Resolution Capture Hi-C.” *Nature Genetics* 47 (6): 598–606.

Schoenfelder, Stefan, Mayra Furlan-Magaril, Borbala Mifsud, Filipe Tavares-Cadete, Robert Sugar, Biola-Maria Javierre, Takashi Nagano, et al. 2015. “The Pluripotent Regulatory Circuitry Connecting Promoters to Their Long-Range Interacting Elements.” *Genome Research* 25 (4): 582–97.

The ENCODE Project Consortium. 2012. “An Integrated Encyclopedia of DNA Elements in the Human Genome.” *Nature* 489 (7414): 57–74.