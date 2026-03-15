# [Picard](index.html)

[![Build Status](https://travis-ci.org/broadinstitute/picard.svg?branch=master)](https://travis-ci.org/broadinstitute/picard)

A set of command line tools (in Java) for manipulating high-throughput sequencing (HTS) data and formats such as SAM/BAM/CRAM and VCF.

[View the Project on GitHub broadinstitute/picard](https://github.com/broadinstitute/picard)

* [Latest Jar **Release**](https://github.com/broadinstitute/picard/releases/latest)
* [Source Code **ZIP File**](https://github.com/broadinstitute/picard/zipball/master)
* [Source Code **TAR Ball**](https://github.com/broadinstitute/picard/tarball/master)
* [View On **GitHub**](https://github.com/broadinstitute/picard)

Picard is a set of command line tools for manipulating high-throughput sequencing (HTS) data and formats such as SAM/BAM/CRAM and VCF.
These file formats are defined in the [Hts-specs](http://samtools.github.io/hts-specs/) repository.
See especially the [SAM specification](http://samtools.github.io/hts-specs/SAMv1.pdf) and the [VCF specification](http://samtools.github.io/hts-specs/VCFv4.3.pdf).

Note that the information on this page is targeted at end-users.
For developers, the source code, building instructions and implementation/development resources are available on [GitHub](https://github.com/broadinstitute/picard).

The Picard toolkit is open-source under the [MIT license](https://tldrlegal.com/license/mit-license) and free for all uses.

Enjoy!

## Quick Start

### Download Software

The Picard command-line tools are provided as a single executable jar file.
You can download the jar file from the  [Latest Release](https://github.com/broadinstitute/picard/releases/latest) project page on Github.
The file name will be **picard.jar**.

### Install

Open the downloaded package and place the folder containing the jar file in a convenient directory on your hard drive (or server). Unlike C-compiled programs such as Samtools, Picard cannot simply be added to your PATH, so we recommend setting up an [environment variable](http://www.tutorialspoint.com/unix/unix-environment.htm) to act as a shortcut.

For the tools to run properly, you must have Java 1.8 installed. To check your java version by open your terminal application and run the following command:

```
java -version
```

If the output looks something like `java version "1.8.x"`, you are good to go. If not, you may need to update your version; see the [Oracle Java website](http://www.oracle.com/technetwork/java/javase/downloads/index.html) to download the latest JDK.

### Test Installation

To test that you can run Picard tools, run the following command in your terminal application, providing either the full path to the picard.jar file:

```
java -jar /path/to/picard.jar -h
```

or the environment variable that you set up as a shortcut (here we are using `$PICARD`):

```
java -jar $PICARD -h
```

You should see a complete list of all the tools in the Picard toolkit. If you don't, read on to the section on Getting Help.

### Use Picard Tools

The tools, which are all listed further below, are invoked as follows:

```
java jvm-args -jar picard.jar PicardToolName OPTION1=value1 OPTION2=value2...
```

See the [Tool Documentation](command-line-overview.html) for details on the [Picard command syntax](command-line-overview.html#CommandSyntax) and [standard options](command-line-overview.html#StandardOptions) as well as a complete [list of tools](command-line-overview.html#Tools) with usage recommendations, options, and example commands.

## Getting Help

Picard is supported through the [GATK Forums](http://gatkforums.broadinstitute.org/gatk). [Register now](http://gatkforums.broadinstitute.org/gatk/entry/register?Target=categories%2Fgatk-support-forum) and you can [ask questions and report problems](http://gatkforums.broadinstitute.org/gatk/post/question) that you might encounter while using Picard and related tools such as GATK (for source code-related questions, post an issue on [Github](https://github.com/broadinstitute/picard/issues) instead), with the following guidelines:

### Before Asking For Help

Before posting to the Forum, please do the following:

* Try the [latest version of Picard](https://github.com/broadinstitute/picard/releases/latest).
* See if your problem is covered discussed in
  the [Frequently Asked Questions](http://broadinstitute.github.io/picard/faq.html).
* Search the [GATK Forums](http://gatkforums.broadinstitute.org/gatk) to see if a similar problem has previously been discussed there.
* Run
  Picard [ValidateSamFile](command-line-overview.html#ValidateSamFile) with MODE=SUMMARY on your input SAM or BAM file (if applicable). Attempt to resolve or at least understand any problems reported.

### When Asking For Help

When asking a question about a problem, please include the following:

* Command line(s) you ran
* Program console output and metrics files. Repetitive console output may be abbreviated
* Entire stack trace if one was produced
* Version of JVM you are using (obtained by running 'java -version')

## Additional Resources

* [Detailed tool documentation](command-line-overview.html#Overview)
* [Description of output of metrics programs](picard-metric-definitions.html)
* [SAM differences in Picard](sam-differences.html)
* [Explain SAM flags](explain-flags.html)
* [Explain Base Qualities](explain-qualities.html)
* [Javadoc](http://broadinstitute.github.io/picard/javadoc/picard/index.html)

## Full list of Picard tools

* [AddCommentsToBam](command-line-overview.html#AddCommentsToBam)* [AddOrReplaceReadGroups](command-line-overview.html#AddOrReplaceReadGroups)* [BaitDesigner](command-line-overview.html#BaitDesigner)* [BamToBfq](command-line-overview.html#BamToBfq)* [BamIndexStats](command-line-overview.html#BamIndexStats)* [BedToIntervalList](command-line-overview.html#BedToIntervalList)* [BuildBamIndex](command-line-overview.html#BuildBamIndex)* [CalculateReadGroupChecksum](command-line-overview.html#CalculateReadGroupChecksum)* [CleanSam](command-line-overview.html#CleanSam)* [CollectAlignmentSummaryMetrics](command-line-overview.html#CollectAlignmentSummaryMetrics)* [CollectBaseDistributionByCycle](command-line-overview.html#CollectBaseDistributionByCycle)* [CollectGcBiasMetrics](command-line-overview.html#CollectGcBiasMetrics)* [CollectHiSeqXPfFailMetrics](command-line-overview.html#CollectHiSeqXPfFailMetrics)* [CollectHsMetrics](command-line-overview.html#CollectHsMetrics)* [CollectIlluminaBasecallingMetrics](command-line-overview.html#CollectIlluminaBasecallingMetrics)* [CollectIlluminaLaneMetrics](command-line-overview.html#CollectIlluminaLaneMetrics)* [CollectInsertSizeMetrics](command-line-overview.html#CollectInsertSizeMetrics)* [CollectJumpingLibraryMetrics](command-line-overview.html#CollectJumpingLibraryMetrics)* [CollectMultipleMetrics](command-line-overview.html#CollectMultipleMetrics)* [CollectOxoGMetrics](command-line-overview.html#CollectOxoGMetrics)* [CollectQualityYieldMetrics](command-line-overview.html#CollectQualityYieldMetrics)* [CollectRawWgsMetrics](command-line-overview.html#CollectRawWgsMetrics)* [CollectTargetedPcrMetrics](command-line-overview.html#CollectTargetedPcrMetrics)* [CollectRnaSeqMetrics](command-line-overview.html#CollectRnaSeqMetrics)* [CollectRrbsMetrics](command-line-overview.html#CollectRrbsMetrics)* [CollectSequencingArtifactMetrics](command-line-overview.html#CollectSequencingArtifactMetrics)* [CollectVariantCallingMetrics](command-line-overview.html#CollectVariantCallingMetrics)* [CollectWgsMetrics](command-line-overview.html#CollectWgsMetrics)* [CollectWgsMetricsWithNonZeroCoverage](command-line-overview.html#CollectWgsMetricsWithNonZeroCoverage)* [CompareMetrics](command-line-overview.html#CompareMetrics)* [CompareSAMs](command-line-overview.html#CompareSAMs)* [ConvertSequencingArtifactToOxoG](command-line-overview.html#ConvertSequencingArtifactToOxoG)* [CreateSequenceDictionary](command-line-overview.html#CreateSequenceDictionary)* [DownsampleSam](command-line-overview.html#DownsampleSam)* [ExtractIlluminaBarcodes](command-line-overview.html#ExtractIlluminaBarcodes)* [EstimateLibraryComplexity](command-line-overview.html#EstimateLibraryComplexity)* [FastqToSam](command-line-overview.html#FastqToSam)* [FifoBuffer](command-line-overview.html#FifoBuffer)* [FindMendelianViolations](command-line-overview.html#FindMendelianViolations)* [CrosscheckFingerprints](command-line-overview.html#CrosscheckFingerprints)* [ClusterCrosscheckMetrics](command-line-overview.html#ClusterCrosscheckMetrics)* [CheckFingerprint](command-line-overview.html#CheckFingerprint)* [FilterSamReads](command-line-overview.html#FilterSamReads)* [FilterVcf](command-line-overview.html#FilterVcf)* [FixMateInformation](command-line-overview.html#FixMateInformation)* [GatherBamFiles](command-line-overview.html#GatherBamFiles)* [GatherVcfs](command-line-overview.html#GatherVcfs)* [GenotypeConcordance](command-line-overview.html#GenotypeConcordance)* [IlluminaBasecallsToFastq](command-line-overview.html#IlluminaBasecallsToFastq)* [IlluminaBasecallsToSam](command-line-overview.html#IlluminaBasecallsToSam)* [CheckIlluminaDirectory](command-line-overview.html#CheckIlluminaDirectory)* [CheckTerminatorBlock](command-line-overview.html#CheckTerminatorBlock)* [IntervalListTools](command-line-overview.html#IntervalListTools)* [LiftOverIntervalList](command-line-overview.html#LiftOverIntervalList)* [LiftoverVcf](command-line-overview.html#LiftoverVcf)* [MakeSitesOnlyVcf](command-line-overview.html#MakeSitesOnlyVcf)* [MarkDuplicates](command-line-overview.html#MarkDuplicates)* [MarkDuplicatesWithMateCigar](command-line-overview.html#MarkDuplicatesWithMateCigar)* [MeanQualityByCycle](command-line-overview.html#MeanQualityByCycle)* [MergeBamAlignment](command-line-overview.html#MergeBamAlignment)* [MergeSamFiles](command-line-overview.html#MergeSamFiles)* [MergeVcfs](command-line-overview.html#MergeVcfs)* [NormalizeFasta](command-line-overview.html#NormalizeFasta)* [PositionBasedDownsampleSam](command-line-overview.html#PositionBasedDownsampleSam)* [ExtractSequences](command-line-overview.html#ExtractSequences)* [QualityScoreDistribution](command-line-overview.html#QualityScoreDistribution)* [RenameSampleInVcf](command-line-overview.html#RenameSampleInVcf)* [ReorderSam](command-line-overview.html#ReorderSam)* [ReplaceSamHeader](command-line-overview.html#ReplaceSamHeader)* [RevertSam](command-line-overview.html#RevertSam)* [RevertOriginalBaseQualitiesAndAddMateCigar](command-line-overview.html#RevertOriginalBaseQualitiesAndAddMateCigar)* [SamFormatConverter](command-line-overview.html#SamFormatConverter)* [SamToFastq](command-line-overview.html#SamToFastq)* [ScatterIntervalsByNs](command-line-overview.html#ScatterIntervalsByNs)* [SetNmMdAndUqTags](command-line-overview.html#SetNmMdAndUqTags)* [SortSam](command-line-overview.html#SortSam)* [SortVcf](command-line-overview.html#SortVcf)* [SplitSamByLibrary](command-line-overview.html#SplitSamByLibrary)* [UmiAwareMarkDuplicatesWithMateCigar](command-line-overview.html#UmiAwareMarkDuplicatesWithMateCigar)* [UpdateVcfSequenceDictionary](command-line-overview.html#UpdateVcfSequenceDictionary)* [VcfFormatConverter](command-line-overview.html#VcfFormatConverter)* [MarkIlluminaAdapters](command-line-overview.html#MarkIlluminaAdapters)* [SplitVcfs](command-line-overview.html#SplitVcfs)* [ValidateSamFile](command-line-overview.html#ValidateSamFile)* [ViewSam](command-line-overview.html#ViewSam)* [VcfToIntervalList](command-line-overview.html#VcfToIntervalList)

Project maintained by [broadinstitute](https://github.com/broadinstitute)

Hosted on GitHub Pages — Theme by [orderedlist](https://github.com/orderedlist)