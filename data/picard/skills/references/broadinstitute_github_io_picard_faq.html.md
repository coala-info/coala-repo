# [Picard](index.html)

[![Build Status](https://travis-ci.org/broadinstitute/picard.svg?branch=master)](https://travis-ci.org/broadinstitute/picard)

A set of command line tools (in Java) for manipulating high-throughput sequencing (HTS) data and formats such as SAM/BAM/CRAM and VCF.

[View the Project on GitHub broadinstitute/picard](https://github.com/broadinstitute/picard)

* [Latest Jar **Release**](https://github.com/broadinstitute/picard/releases/latest)
* [Source Code **ZIP File**](https://github.com/broadinstitute/picard/zipball/master)
* [Source Code **TAR Ball**](https://github.com/broadinstitute/picard/tarball/master)
* [View On **GitHub**](https://github.com/broadinstitute/picard)

## Frequently Asked Questions

**Q:** What does this flag value mean?

**A:**
Use this convenient web-based utility: [**explain-flags**](http://broadinstitute.github.io/picard/explain-flags.html).

**Q:** A Picard tool that sorts its output SAM/BAM file is taking a very long time and/or running out of memory. What can I do?

**A:** Picard tools that sort their output (e.g. SortSam, MergeSamFiles if the inputs are not all sorted in the same order as the output) will run faster when given more RAM, and told to store more alignment records in memory before writing to a temporary file. You can give the program more memory by increasing the size of the Java heap with the -Xmx argument. If your operating system imposes a hard memory limit on a process, a rule of thumb is to set the -Xmx value no higher than 2GB less than the hard memory limit. Even if your system does not set a hard memory limit, if you set the -Xmx value much greater than the available RAM on the computer, excessive swapping will hurt performance. The Picard MAX\_RECORDS\_IN\_RAM option controls the number of records to store in RAM before writing to a temporary file when producing sorted output. The optimal setting for this option depends on a number of factors, including:

* Read length
* Tag content, e.g. OQ and E2 tags can be large
* SAM input generally has larger memory footprint than BAM input, but if validation stringency is not silent, then BAM can actually be larger
* Setting variable-length attributes onto a record read from a BAM file can expand its memory footprint even if validation stringency is silent
* Different Picard tools have varying RAM requirements separate from the RAM needed for sorting

A rule of thumb for reads of ~100bp is to set MAX\_RECORDS\_IN\_RAM to be 250,000 reads per each GB given to the -Xmx parameter for SortSam. *Thanks to Keiran Raine for performing the experiments to arrive at these numbers.*

**Q:** A Picard tool complains that CIGAR M operator maps off the end of reference. I want this record to be treated as valid despite the fact that the alignment end is greater than the length of the reference sequence.

**A:** Picard validation errors may be turned into warnings by passing the command line argument *VALIDATION\_STRINGENCY=LENIENT*. Picard validation messages may be suppressed completely with *VALIDATION\_STRINGENCY=SILENT*.

Another option is to use the [**CleanSam**](http://broadinstitute.github.io/picard/command-line-overview.html#CleanSam) tool to soft-clip these reads so they don't map off the end of the reference e.g.

```
java -jar picard.jar CleanSam
```

**Q:** How does MarkDuplicates work?

**A:** The [**MarkDuplicates**](http://broadinstitute.github.io/picard/command-line-overview.html#MarkDuplicates) tool finds the 5' coordinates and mapping orientations of each read pair (single-end data is also handled). It takes all clipping into account as well as any gaps or jumps in the alignment. Matches all read pairs using the 5' coordinates and their orientations. It marks all but the "best" pair as duplicates, where "best" is defined as the read pair having the highest sum of base qualities of bases with Q ≥ 15.

If your reads have been divided into separate BAMs by chromosome, inter-chromosomal pairs will not be identified, but [**MarkDuplicates**](http://broadinstitute.github.io/picard/command-line-overview.html#MarkDuplicates) will not fail due to inability to find the mate pair for a read.

For a comprehensive discussion of how to use the [**MarkDuplicates**](http://broadinstitute.github.io/picard/command-line-overview.html#MarkDuplicates) tool, please see the following [**tutorial**](https://www.broadinstitute.org/gatk/guide/article?id=6747).

**Q:** MarkDuplicates takes a long time. Is something wrong?

**A:** Not necessarily. [**MarkDuplicates**](http://broadinstitute.github.io/picard/command-line-overview.html#MarkDuplicates) is very memory-intensive. This is required in order to detect interchromosomal duplication. At Broad, we run [**MarkDuplicates**](http://broadinstitute.github.io/picard/command-line-overview.html#MarkDuplicates) with 2GB Java heap (java -Xmx2g) and 10GB hard memory limit. Some example run times:

* An 8.6GB file (63M records) took about 1 hours
* A 20GB file (133M records) took about 2.5 hours

Increasing the amount of RAM allocated to MarkDuplicates (the -Xmx value) will improve the speed somewhat. Note that if you have a hard memory limit, this needs to be increased also. One workaround for large datasets involves marking duplicates for different libraries independently and subsequently merging the marked files.

**Q:** What is the difference between MarkDuplicates and samtools rmdup?

**A:** The main difference is that Samtools rmdup does not remove interchromosomal duplicates while Picard's [**MarkDuplicates**](http://broadinstitute.github.io/picard/command-line-overview.html#MarkDuplicates) does.

**Q:** What is the meaning of the histogram produced by MarkDuplicates?

**A:** [**MarkDuplicates**](http://broadinstitute.github.io/picard/command-line-overview.html#MarkDuplicates) estimates the return on investment for sequencing a library to a higher coverage than the observed coverage. The first column is the coverage multiple, and the second column is the multiple of additional actual coverage for the given coverage multiple. The first row (1x, i.e. the actual amount of sequencing done) should have ROI of approximately 1. The next row estimates the ROI for twice as much sequencing of the library. As one increases the amount of sequencing for a library, the ROI for additional sequencing diminishes because more and more of the reads are duplicates.

**Q:** MarkDuplicates (or ValidateSamFile) produces the error "Value was put into PairInfoMap more than once." What should I do?

**A:** Many aligners produce output that is not up to Picard standards, e.g. an aligner might not output unmapped reads, might drop some important tags, might not set mate information correctly, might produce multiple primary alignments, etc. To address this problem, [**MergeBamAlignment**](http://broadinstitute.github.io/picard/command-line-overview.html#MergeBamAlignment) is designed to merge an aligned BAM produced directly by an aligner with an unmapped BAM. The input aligned BAM will not necessarily meet Picard validation standards but the output of MergeBamAlignment should work properly with other Picard tools. If you do not have an unmapped BAM because the input to your aligner is in FASTQ format, you can create one with [**FastqToSam**](http://broadinstitute.github.io/picard/command-line-overview.html#FastqToSam).

**Q:** How do MarkDuplicates and EstimateLibraryComplexity estimate library size?

**A:** Please see documentation at [**EstimateLibraryComplexity**](http://broadinstitute.github.io/picard/command-line-overview.html#EstimateLibraryComplexity) and [**MarkDuplicates**](http://broadinstitute.github.io/picard/command-line-overview.html#MarkDuplicates) for overviews of these tools.

**Q:** Why does a Picard tool use so many threads?

**A:** This can be caused by the garbage collection (GC) method of Java when used on 64 bit Java. By default the JVM switches to 'server' settings when on 64 bit, which automatically implements parallel GC and will use as many cores as it can get its hands on. To get around this, we define the number of threads we allow Java for GC by specifying -XX:ParallelGCThreads=<number of threads>. An alternative approach is to turn off Parallel GC by specifying -XX:+UseSerialGC. However, we found this process to be sub-optimal since a full GC sweep is the only type performed, which seems to take much longer than parallel GC. In many cases, it is not required (parallel GC employs ~7 different types of GC). See [**here**](http://java.sun.com/javase/technologies/hotspot/vmoptions.jsp) for further details of the tunable parameters.

**Q:** I sorted my file with samtools sort. Why does a Picard tool complain that the file is not sorted?

**A:** Samtools sort does not change the SAM file header to indicate that the file is sorted. Some Picard tools (CollectAlignmentSummaryMetrics, MarkDuplicates, MergeSamFiles) have an ASSUME\_SORTED option. If you put ASSUME\_SORTED=true on the command line, the program will assume that the input SAM or BAM is sorted appropriately. Alternately, you can use Picard's [**SortSam**](http://broadinstitute.github.io/picard/command-line-overview.html#SortSam) instead of samtools sort to adjust the sort order of your output file. The possible sorting options are: unsorted, queryname, coordinate, duplicate. Finally, you can capture the text header using Picard's [**ViewSam**](http://broadinstitute.github.io/picard/command-line-overview.html#ViewSam), edit the header in a text editor, and then create a new BAM with Picard's [**ReplaceSamHeader**](http://broadinstitute.github.io/picard/command-line-overview.html#ReplaceSamHeader). The downside of this last alternative is that currently replacing the header requires writing a copy of the input BAM, rather than editing in place. Whatever method is used, we always recommend that you validate your BAM/SAM file using Picard's [**ValidateSamFile**](http://broadinstitute.github.io/picard/command-line-overview.html#ValidateSamFile) prior to moving forward with your analysis.

**Q:** Can Picard tools read from stdin and write to stdout?

**A:** Most Picard tools can do this. To read from stdin, specify /dev/stdin as the input file. To write to stdout, specify /dev/stdout as the output file, and also add the option QUIET=true to suppress other messages that otherwise would be written to stdout. Not that Picard determines whether to write in SAM or BAM format by examining the file extension of the output file. Since /dev/stdout ends in neither .sam nor .bam, Picard defaults to writing in BAM format. Some Picard tools, e.g. MarkDuplicates, cannot read their input from stdin, because it makes multiple passes over the input file. When writing a BAM to stdout so that it can be read by another program, passing the argument COMPRESSION\_LEVEL=0 to the program writing the BAM to stdout can reduce unnecessary computation.

**Q:** Why am I getting errors from Picard like "MAPQ should be 0 for unmapped read" or "CIGAR should have zero elements for unmapped read?"

**A:** BWA can produce SAM records that are marked as unmapped but have non-zero MAPQ and/or non-"\*" CIGAR. Typically this is because BWA found an alignment for the read that hangs off the end of the reference sequence. Picard considers such input to be invalid. In general, this error can be suppressed in Picard tools by passing VALIDATION\_STRINGENCY=LENIENT or VALIDATION\_STRINGENCY=SILENT. For [**ValidateSamFile**](http://broadinstitute.github.io/picard/command-line-overview.html#ValidateSamFile), you can pass the arguments IGNORE=INVALID\_MAPPING\_QUALITY IGNORE=INVALID\_CIGAR.

**Q:** I'm getting a warning message from CollectGcBiasMetrics. It says *In arrows(metrics$GC, metrics$NORMALIZED\_COVERAGE - metrics$ERROR\_BAR\_WIDTH, :zero-length arrow is of indeterminate angle and so skipped*. Is this a problem?

**A:** This warning message can be ignored. R is trying to write error bars with length 0, because there are no reads with a particular GC content.

**Q:** How should I cite Picard in my manuscript?

**A:** Currently there is no Picard paper. However, you can cite the website, [**http://broadinstitute.github.io/picard**](http://broadinstitute.github.io/picard).

**Q:** What is the format of an interval list file?

**A:** Description of this format can be found in the [**IntervalList documentation**](http://samtools.github.io/htsjdk/javadoc/htsjdk/htsjdk/samtools/util/IntervalList.html).

**Q:** How should I invoke a Picard tool from within my Java program? I call the main() method of the Picard tool, but System.exit() is called when it finishes, which is not what I want.

**A:** If you want to invoke a Picard tool from within your java program, but not have it exit, use the following command: *int returnValue = new PicardProgram().instanceMain(argv);*. Make sure to check the return value from this call. If it returns non-zero, an error has occurred. For more help with development questions, please ask on the Github repo.

**Q:** I'm getting java.io.FileNotFoundException: (Too many open files). What should I do?

**A:** There are several things you can do: 1) On Unix systems, the allowed number of open files can be increased. Typing the script *ulimit -n* will show you how many open files a process is allowed to have. You can ask your system administrator to increase that number. 2) Many Picard tools use temporary files to sort. You can increase the value of the *MAX\_RECORDS\_IN\_RAM* command-line parameter in order to tell Picard to store more records in fewer files in order to reduce the number of open files. This will, however, increase memory consumption. 3) MarkDuplicates has the command-line parameter *MAX\_FILE\_HANDLES\_FOR\_READ\_ENDS\_MAP*. By reducing this number, you reduce the number of concurrently open files (trading off execution speed).

**Q:** What is Snappy and how do I use it?

**A:** Snappy is a compression library that can be invoked as an option in some Picard tools. See [**Using Snappy in Picard**](http://broadinstitute.github.io/picard/using-snappy-in-picard.html) for details.

**Q:** Where can I find an appropriate file to give to the RIBOSOMAL\_INTERVALS argument of CollectRnaSeqMetrics?

**A:** First, this file is not required. If not provided, CollectRnaSeqMetrics will not be able to identify bases as ribosomal, so they will fall into one of the other categories in the [**metrics output**](http://broadinstitute.github.io/picard/picard-metric-definitions.html#RnaSeqMetrics). There is no public distribution of ribosomal RNA interval lists. However, you may create your own or copy and paste from this site: [**ribosomal\_intervals**](https://gist.github.com/slowkow/b11c28796508f03cdf4b) . If you are using a build other than hg19 for your analysis, you can use Picard's [**LiftOverIntervalList**](http://broadinstitute.github.io/picard/command-line-overview.html#LiftOverIntervalList)  to lift over the file to a different build.

If 