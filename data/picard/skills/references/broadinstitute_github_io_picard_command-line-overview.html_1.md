# [Picard](index.html)

[![Build Status](https://travis-ci.org/broadinstitute/picard.svg?branch=master)](https://travis-ci.org/broadinstitute/picard)

A set of command line tools (in Java) for manipulating high-throughput sequencing (HTS) data and formats such as SAM/BAM/CRAM and VCF.

[View the Project on GitHub broadinstitute/picard](https://github.com/broadinstitute/picard)

* [Latest Jar **Release**](https://github.com/broadinstitute/picard/releases/latest)
* [Source Code **ZIP File**](https://github.com/broadinstitute/picard/zipball/master)
* [Source Code **TAR Ball**](https://github.com/broadinstitute/picard/tarball/master)
* [View On **GitHub**](https://github.com/broadinstitute/picard)

## Command Line Overview

This page provides detailed documentation on the Picard command-line syntax and standard options as well as a complete list of tools, usage recommendations, options, and example commands.

See the [Quick Start](index.html#QuickStart) documentation for instructions on how to obtain and set up the tools if you haven't already.

### Command Syntax

The tools are invoked as follows:

```
java jvm-args -jar picard.jar PicardToolName \
	OPTION1=value1 \
	OPTION2=value2
```

The backslashes at the end of each line except the last are used to allow formatting the command line on multiple lines. The command above could also be written on a single line; however in the documentation we usually format command to display on multiple lines for clarity.

`jvm-args` are arguments that are specific to Java, not Picard. We do not provide guidance for specifying JVM (Java Virtual Machine) arguments except for specifying memory: most of the commands are designed to run in 2GB of JVM, so we recommend using the JVM argument `-Xmx2g`.

`PicardToolName` refers to the name of the tool you want to run. It must always be the first argument after the jar file path. Some examples include: CollectAlignmentSummaryMetrics, BuildBamIndex, and CreateSequenceDictionary. The tools and their respective options are described in detail below.

`OPTIONs` can be any of the Standard Options listed first below, and/or any of the tool-specific options listed for each tool. Argument values can be filenames, strings (of alphanumeric characters), enumerated values, floats (decimal numbers), integers, or boolean (true/false). Options frequently have a value that is set be default but can be modified by specifying a different value in the command line.

For example, `INPUT=input.bam` specifies a file, where `INPUT` is the `OPTION` and `input.bam` is the value indicating what file to use. As another example, `STRANDSPECIFICITY=NONE` specifies the argument `STRANDSPECIFICITY` for which the documentation enumerates acceptable values: `NONE`, `FIRST_READ_TRANSCRIPTION_STRAND`, and `SECOND_READ_TRANSCRIPTION_STRAND`.

### Usage Example

Here's a typical example where we run CollectAlignmentSummaryMetrics, a quality control tool that takes a reference file and a input file containing sequencing data, and outputs some quality control metrics.

```
java -jar picard.jar CollectAlignmentSummaryMetrics \
	REFERENCE=my_data/reference.fasta \
	INPUT=my_data/input.bam \
	OUTPUT=results/output.txt
```

Note that values for arguments that specify files must include appropriate file paths, either absolute or relative to the working directory. In this example we are reading in input data from a subdirectory called `my_data` and writing outputs to another subdirectory called `results`.

## Standard Options

The following standard options are relevant to most Picard tools:

| Option | Description |
| --- | --- |
| --help | Displays options specific to this tool. |
| --stdhelp | Displays options specific to this tool AND options common to all Picard command line tools. |
| --version | Displays program version. |
| TMP\_DIR (File) | Default value: null. This option may be specified 0 or more times. |
| VERBOSITY (LogLevel) | Control verbosity of logging. Default value: INFO. This option can be set to 'null' to clear the default value. Possible values: {ERROR, WARNING, INFO, DEBUG} |
| QUIET (Boolean) | Whether to suppress job-summary info on System.err. Default value: false. This option can be set to 'null' to clear the default value. Possible values: {true, false} |
| VALIDATION\_STRINGENCY (ValidationStringency) | Validation stringency for all SAM files read by this program. Setting stringency to SILENT can improve performance when processing a BAM file in which variable-length data (read, qualities, tags) do not otherwise need to be decoded. Default value: STRICT. This option can be set to 'null' to clear the default value. Possible values: {STRICT, LENIENT, SILENT} |
| COMPRESSION\_LEVEL (Integer) | Compression level for all compressed files created (e.g. BAM and GELI). Default value: 5. This option can be set to 'null' to clear the default value. |
| MAX\_RECORDS\_IN\_RAM (Integer) | When writing SAM files that need to be sorted, this will specify the number of records stored in RAM before spilling to disk. Increasing this number reduces the number of file handles needed to sort a SAM file, and increases the amount of RAM needed. Default value: 500000. This option can be set to 'null' to clear the default value. |
| CREATE\_INDEX (Boolean) | Whether to create a BAM index when writing a coordinate-sorted BAM file. Default value: false. This option can be set to 'null' to clear the default value. Possible values: {true, false} |
| CREATE\_MD5\_FILE (Boolean) | Whether to create an MD5 digest for any BAM or FASTQ files created. Default value: false. This option can be set to 'null' to clear the default value. Possible values: {true, false} |
| REFERENCE\_SEQUENCE (File) | Reference sequence file. Default value: null. |
| GA4GH\_CLIENT\_SECRETS (String) | Google Genomics API client\_secrets.json file path. Default value: client\_secrets.json. This option can be set to 'null' to clear the default value. |
| USE\_JDK\_DEFLATER (Boolean) | Use the JDK Deflater instead of the Intel Deflater for writing compressed output Default value: false. This option can be set to 'null' to clear the default value. Possible values: {true, false} |
| USE\_JDK\_INFLATER (Boolean) | Use the JDK Inflater instead of the Intel Inflater for reading compressed input Default value: false. This option can be set to 'null' to clear the default value. Possible values: {true, false} |

## Tool-Specific Documentation

Below, you will find detailed documentation of **all the options that are specific to each tool**. Keep in mind that some tools may require one or more of the standard options listed below; this is usually specified in the tool description. For the many tools that collect quality control metrics, documentation of what the metrics mean and how they are calculated is provided on the [Picard Metrics Definitions](picard-metric-definitions.html) page.

Be sure to consult the [Frequently Asked Questions (FAQ)](http://broadinstitute.github.io/picard/faq.html) page for useful information about typical problems you may encounter while using Picard tools.

### AddCommentsToBam

Adds comments to the header of a BAM file.This tool makes a copy of the input bam file, with a modified header that includes the comments specified at the command line (prefixed by @CO). Use double quotes to wrap comments that include whitespace or special characters.

Note that this tool cannot be run on SAM files.

#### Usage example:

```
java -jar picard.jar AddCommentsToBam \
      I=input.bam \
      O=modified_bam.bam \
      C=comment_1 \
      C="comment 2"
```

---

| Option | Description |
| --- | --- |
| INPUT (File) | Input BAM file to add a comment to the header Required. |
| OUTPUT (File) | Output BAM file to write results Required. |
| COMMENT (String) | Comments to add to the BAM file Default value: null. This option may be specified 0 or more times. |

### AddOrReplaceReadGroups

Replace read groups in a BAM file.This tool enables the user to replace all read groups in the INPUT file with a single new read group and assign all reads to this read group in the OUTPUT BAM file.

For more information about read groups, see the [GATK Dictionary entry.](https://www.broadinstitute.org/gatk/guide/article?id=6472)

 This tool accepts INPUT BAM and SAM files or URLs from the Global Alliance for Genomics and Health (GA4GH) (see http://ga4gh.org/#/documentation).

#### Usage example:

```
java -jar picard.jar AddOrReplaceReadGroups \
      I=input.bam \
      O=output.bam \
      RGID=4 \
      RGLB=lib1 \
      RGPL=illumina \
      RGPU=unit1 \
      RGSM=20
```

---

| Option | Description |
| --- | --- |
| INPUT (String) | Input file (BAM or SAM or a GA4GH url). Required. |
| OUTPUT (File) | Output file (BAM or SAM). Required. |
| SORT\_ORDER (SortOrder) | Optional sort order to output in. If not supplied OUTPUT is in the same order as INPUT. Default value: null. Possible values: {unsorted, queryname, coordinate, duplicate, unknown} |
| RGID (String) | Read Group ID Default value: 1. This option can be set to 'null' to clear the default value. |
| RGLB (String) | Read Group library Required. |
| RGPL (String) | Read Group platform (e.g. illumina, solid) Required. |
| RGPU (String) | Read Group platform unit (eg. run barcode) Required. |
| RGSM (String) | Read Group sample name Required. |
| RGCN (String) | Read Group sequencing center name Default value: null. |
| RGDS (String) | Read Group description Default value: null. |
| RGDT (Iso8601Date) | Read Group run date Default value: null. |
| RGPI (Integer) | Read Group predicted insert size Default value: null. |
| RGPG (String) | Read Group program group Default value: null. |
| RGPM (String) | Read Group platform model Default value: null. |

### BaitDesigner

Designs oligonucleotide baits for hybrid selection reactions.

This tool is used to design custom bait sets for hybrid selection experiments. The following files are input into BaitDesigner: a (TARGET) interval list indicating the sequences of interest, e.g. exons with their respective coordinates, a reference sequence, and a unique identifier string (DESIGN\_NAME).

The tool will output interval\_list files of both bait and target sequences as well as the actual bait sequences in FastA format. At least two baits are output for each target sequence, with greater numbers for larger intervals. Although the default values for both bait size (120 bases) nd offsets (80 bases) are suitable for most applications, these values can be customized. Offsets represent the distance between sequential baits on a contiguous stretch of target DNA sequence.

The tool will also output a pooled set of 55,000 (default) oligonucleotides representing all of the baits redundantly. This redundancy achieves a uniform concentration of oligonucleotides for synthesis by a vendor as well as equal numbersof each bait to prevent bias during the hybrid selection reaction.

#### Usage example:

```
java -jar picard.jar BaitDesigner \
      TARGET=targets.interval_list \
      DESIGN_NAME=new_baits \
      R=reference_sequence.fasta
```

---

| Option | Description |
| --- | --- |
| TARGETS (File) | The file with design parameters and targets Required. |
| DESIGN\_NAME (String) | The name of the bait design Required. |
| REFERENCE\_SEQUENCE (File) | The reference sequence fasta file Required. |
| LEFT\_PRIMER (String) | The left amplification primer to prepend to all baits for synthesis Default value: ATCGCACCAGCGTGT. This option can be set to 'null' to clear the default value. |
| RIGHT\_PRIMER (String) | The right amplification primer to prepend to all baits for synthesis Default value: CACTGCGGCTCCTCA. This option can be set to 'null' to clear the default value. |
| DESIGN\_STRATEGY (DesignStrategy) | The design strategy to use to layout baits across each target Default value: FixedOffset. This option can be set to 'null' to clear the default value. Possible values: {CenteredConstrained, FixedOffset, Simple} |
| BAIT\_SIZE (Integer) | The length of each individual bait to design Default value: 120. This option can be set to 'null' to clear the default value. |
| MINIMUM\_BAITS\_PER\_TARGET (Integer) | The minimum number of baits to design per target. Default value: 2. This option can be set to 'null' to clear the default value. |
| BAIT\_OFFSET (Integer) | The desired offset between the start of one bait and the start of another bait for the same target. Default value: 80. This option can be set to 'null' to clear the default value. |
| PADDING (Integer) | Pad the input targets by this amount when designing baits. Padding is applied on both sides in this amount. Default value: 0. This option can be set to 'null' to clear the default value. |
| REPEAT\_TOLERANCE (Integer) | Baits that have more than REPEAT\_TOLERANCE soft or hard masked bases will not be allowed Default value: 50. This option can be set to 'null' to clear the default value. |
| POOL\_SIZE (Integer) | The size of pools or arrays for synthesis. If no pool files are desired, can be set to 0. Default value: 55000. This option can be set to 'null' to clear the default value. |
| FILL\_POOLS (Boolean) | If true, fill up the pools with alternating fwd and rc copies of all baits. Equal copies of all baits will always be maintained Default value: true. This option can be set to 'null' to clear the default value. Possible values: {true, false} |
| DESIGN\_ON\_TARGET\_STRAND (Boolean) | If true design baits on the strand of the target feature, if false always design on the + strand of the genome. Default value: false. This option can be set to 'null' to clear the default value. Possible values: {true, false} |
| MERGE\_NEARBY\_TARGETS (Boolean) | If true merge targets that are 'close enough' that designing against a merged target would be more efficient. Default value: true. This option can be set to 'null' to clear the default value. Possible values: {true, false} |
| OUTPUT\_AGILENT\_FILES (Boolean) | If true also output .design.txt files per pool with one line per bait sequence Default value: true. This option can be set to 'null' to clear the default value. Possible values: {true, false} |
| OUTPUT\_DIRECTORY (File) | The output directory. If not provided then the DESIGN\_NAME will be used as the output directory Default value: null. |

### BamToBfq

Create BFQ files from a BAM file for use by the maq aligner. BFQ is a binary version of the FASTQ file format. This tool creates bfq files from a BAM file for use by the maq aligner.

#### Usage example:

```
java -jar picard.jar BamToBfq \
      I=input.bam \
      ANALYSIS_DIR=analysis_dir \
      OUTPUT_FILE_PREFIX=output_file_1 \
      PAIRED_RUN=false
```

---

| Option | Description |
| --- | --- |
| INPUT (File) | The BAM file to parse. Required. |
| ANALYSIS\_DIR (File) | The analysis directory for the binary output file. Required. |
| FLOWCELL\_BARCODE (String) | Flowcell barcode (e.g. 30PYMAAXX). Required. Cannot be 