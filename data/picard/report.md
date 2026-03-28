# picard CWL Generation Report

## Runtime validation summary

| Tool | Runtime | Data used | Reason (if fail) |
|------|---------|-----------|------------------|
| picard_MarkDuplicates | PASS | plan:test.bam | — |


## picard_CheckIlluminaDirectory

### Tool Description
Asserts the validity for specified Illumina basecalling data. This tool will check that the basecall directory and the internal files are available, exist, and are reasonably sized for every tile and cycle.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Total Downloads**: 2.8M
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/broadinstitute/picard
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CheckIlluminaDirectory [arguments]

Asserts the validity for specified Illumina basecalling data.  <p>This tool will check that the basecall directory and
the internal files are available, exist, and are reasonably sized for every tile and cycle.  Reasonably sized means
non-zero sized for files that exist per tile and equal size for binary files that exist per cycle or per tile. If
DATA_TYPES {Position, BaseCalls, QualityScores, PF, or Barcodes} are not specified, then the default data types used by
IlluminaBasecallsToSam are used.  CheckIlluminaDirectory DOES NOT check that the individual records in a file are
well-formed. If there are errors, the number of errors is written in a file called 'errors.count' in the working
directory</p><h4>Usage example:</h4> <pre>java -jar picard.jar CheckIlluminaDirectory \<br />     
BASECALLS_DIR=/BaseCalls/  \<br />      READ_STRUCTURE=25T8B25T \<br />      LANES=1 \<br />      DATA_TYPES=BaseCalls
</pre><hr />
Version:3.4.0


Required Arguments:

--BASECALLS_DIR,-B <File>     The basecalls output directory.   Required. 

--LANES,-L <Integer>          The number of the lane(s) to check.   This argument must be specified at least once.
                              Required. 

--READ_STRUCTURE,-RS <String> A description of the logical structure of clusters in an Illumina Run, i.e. a description
                              of the structure IlluminaBasecallsToSam assumes the  data to be in. It should consist of
                              integer/character pairs describing the number of cycles and the type of those cycles (B
                              for Sample Barcode, M for molecular barcode, T for Template, and S for skip).  E.g. If the
                              input data consists of 80 base clusters and we provide a read structure of "28T8M8B8S28T"
                              then the sequence may be split up into four reads:
                              * read one with 28 cycles (bases) of template
                              * read two with 8 cycles (bases) of molecular barcode (ex. unique molecular barcode)
                              * read three with 8 cycles (bases) of sample barcode
                              * 8 cycles (bases) skipped.
                              * read four with 28 cycles (bases) of template
                              The skipped cycles would NOT be included in an output SAM/BAM file or in read groups
                              therein. Note:  If you want to check whether or not a future IlluminaBasecallsToSam or
                              ExtractIlluminaBarcodes run will fail then be sure to use the exact same READ_STRUCTURE
                              that you would pass to these programs for this run.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DATA_TYPES,-DT <IlluminaDataType>
                              The data types that should be checked for each tile/cycle.  If no values are provided then
                              the data types checked are those required by IlluminaBaseCallsToSam (which is a superset
                              of those used in ExtractIlluminaBarcodes).  These data types vary slightly depending on
                              whether or not the run is barcoded so READ_STRUCTURE should be the same as that which will
                              be passed to IlluminaBasecallsToSam.  If this option is left unspecified then both
                              ExtractIlluminaBarcodes and IlluminaBaseCallsToSam should complete successfully UNLESS the
                              individual records of the files themselves are spurious.  This argument may be specified 0
                              or more times. Default value: null. Possible values: {Position, BaseCalls, QualityScores,
                              PF, Barcodes} 

--FAKE_FILES,-F <Boolean>     A flag to determine whether or not to create fake versions of the missing files.  Default
                              value: false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--LINK_LOCS,-X <Boolean>      A flag to create symlinks to the loc file for the X Ten for each tile. @deprecated It is
                              no longer necessary to create locs file symlinks.  Default value: false. Possible values:
                              {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TILE_NUMBERS,-T <Integer>   The number(s) of the tile(s) to check.   This argument may be specified 0 or more times.
                              Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument BASECALLS_DIR was missing: Argument 'BASECALLS_DIR' is required
```


## picard_CollectIlluminaBasecallingMetrics

### Tool Description
Collects Illumina Basecalling metrics for a sequencing run. This tool will produce per-barcode and per-lane basecall metrics for each sequencing run. Mean values for each metric are determined using data from all of the tiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectIlluminaBasecallingMetrics [arguments]

Collects Illumina Basecalling metrics for a sequencing run.  <p>This tool will produce per-barcode and per-lane basecall
metrics for each sequencing run.  Mean values for each metric are determined using data from all of the tiles.  This
tool requires the following data, LANE(#), BASECALLS_DIR, READ_STRUCTURE, and an input file listing the sample barcodes.
Program will provide metrics including: the total numbers of bases, reads, and clusters, as well as the fractions of
each bases, reads, and clusters that passed Illumina quality filters (PF) both per barcode and per lane.  For additional
information on Illumina's PF quality metric, please see the corresponding <a
href='https://www.broadinstitute.org/gatk/guide/article?id=6329'>GATK Dictionary entry</a>.</p> <p>The input
barcode_list.txt file is a file containing all of the sample and molecular barcodes and can be obtained from the <a
href='http://broadinstitute.github.io/picard/command-line-overview.html#ExtractIlluminaBarcodes'>ExtractIlluminaBarcodes</a>
tool.  </p>Note: Metrics labeled as percentages are actually expressed as fractions!  <h4>Usage example:</h4><pre>java
-jar picard.jar CollectIlluminaBasecallingMetrics \<br />      BASECALLS_DIR=/BaseCalls/ \<br />      LANE=001 \<br />  
READ_STRUCTURE=25T8B25T \<br />      INPUT=barcode_list.txt </pre><p>Please see the CollectIlluminaBasecallingMetrics <a
href='http://broadinstitute.github.io/picard/picard-metric-definitions.html#IlluminaBasecallingMetrics'>definitions</a>
for a complete description of the metrics produced by this tool.  </p><hr />
Version:3.4.0


Required Arguments:

--BASECALLS_DIR,-B <File>     The Illumina basecalls output directory from which data are read  Required. 

--LANE,-L <Integer>           The lane whose data will be read  Required. 

--READ_STRUCTURE,-RS <String> A description of the logical structure of clusters in an Illumina Run, i.e. a description
                              of the structure IlluminaBasecallsToSam assumes the  data to be in. It should consist of
                              integer/character pairs describing the number of cycles and the type of those cycles (B
                              for Sample Barcode, M for molecular barcode, T for Template, and S for skip).  E.g. If the
                              input data consists of 80 base clusters and we provide a read structure of "28T8M8B8S28T"
                              then the sequence may be split up into four reads:
                              * read one with 28 cycles (bases) of template
                              * read two with 8 cycles (bases) of molecular barcode (ex. unique molecular barcode)
                              * read three with 8 cycles (bases) of sample barcode
                              * 8 cycles (bases) skipped.
                              * read four with 28 cycles (bases) of template
                              The skipped cycles would NOT be included in an output SAM/BAM file or in read groups
                              therein.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--BARCODES_DIR,-BCD <File>    The barcodes directory with _barcode.txt files (generated by ExtractIlluminaBarcodes). If
                              not set, use BASECALLS_DIR.   Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INPUT,-I <File>             The file containing barcodes to expect from the run - barcodeData.#  Default value: null. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--OUTPUT,-O <File>            The file to which the collected metrics are written  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument BASECALLS_DIR was missing: Argument 'BASECALLS_DIR' is required
```


## picard_CollectIlluminaLaneMetrics

### Tool Description
Collects Illumina lane metrics for the given BaseCalling analysis directory. This tool produces quality control metrics on cluster density for each lane of an Illumina flowcell. This tool takes Illumina TileMetrics data and places them into directories containing lane- and phasing-level metrics.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectIlluminaLaneMetrics [arguments]

Collects Illumina lane metrics for the given BaseCalling analysis directory.This tool produces quality control metrics
on cluster density for each lane of an Illumina flowcell. This tool takes Illumina TileMetrics data and places them into
directories containing lane- and phasing-level metrics. In this context, phasing refers to the fraction of molecules
that fall behind or jump ahead (prephasing) during a read cycle.<h4>Usage example:</h4><pre>java -jar picard.jar
CollectIlluminaLaneMetrics \<br />      RUN_DIR=test_run \<br />      OUTPUT_DIRECTORY=Lane_output_metrics \<br />     
OUTPUT_PREFIX=experiment1 \<br />      READ_STRUCTURE=25T8B25T </pre><p>Please see the CollectIlluminaLaneMetrics <a
href='http://broadinstitute.github.io/picard/picard-metric-definitions.html#CollectIlluminaLaneMetrics'>definitions</a>
for a complete description of the metrics produced by this tool.</p><hr />
Version:3.4.0


Required Arguments:

--OUTPUT_DIRECTORY <File>     The directory to which the output file will be written  Required. 

--OUTPUT_PREFIX,-O <String>   The prefix to be prepended to the file name of the output file; an appropriate suffix will
                              be applied  Required. 

--RUN_DIRECTORY <File>        The Illumina run directory of the run for which the lane metrics are to be generated 
                              Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--FILE_EXTENSION,-EXT <String>Append the given file extension to all metric file names (ex.
                              OUTPUT.illumina_lane_metrics.EXT). None if null  Default value: null. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_STRUCTURE,-RS <ReadStructure>
                              A description of the logical structure of clusters in an Illumina Run, i.e. a description
                              of the structure IlluminaBasecallsToSam assumes the  data to be in. It should consist of
                              integer/character pairs describing the number of cycles and the type of those cycles (B
                              for Sample Barcode, M for molecular barcode, T for Template, and S for skip).  E.g. If the
                              input data consists of 80 base clusters and we provide a read structure of "28T8M8B8S28T"
                              then the sequence may be split up into four reads:
                              * read one with 28 cycles (bases) of template
                              * read two with 8 cycles (bases) of molecular barcode (ex. unique molecular barcode)
                              * read three with 8 cycles (bases) of sample barcode
                              * 8 cycles (bases) skipped.
                              * read four with 28 cycles (bases) of template
                              The skipped cycles would NOT be included in an output SAM/BAM file or in read groups
                              therein.
                              If not given, will use the RunInfo.xml in the run directory.  Default value: null. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument RUN_DIRECTORY was missing: Argument 'RUN_DIRECTORY' is required
```


## picard_ExtractIlluminaBarcodes

### Tool Description
Tool determines the barcode for each read in an Illumina lane. This tool determines the numbers of reads containing barcode-matching sequences and provides statistics on the quality of these barcode matches.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: ExtractIlluminaBarcodes [arguments]

Tool determines the barcode for each read in an Illumina lane.  <p>This tool determines the numbers of reads containing
barcode-matching sequences and provides statistics on the quality of these barcode matches.</p> <p>Illumina sequences
can contain at least two types of barcodes, sample and molecular (index).  Sample barcodes (B in the read structure) are
used to demultiplex pooled samples while index barcodes (M in the read structure) are used to differentiate multiple
reads of a template when carrying out paired-end sequencing.  Note that this tool only extracts sample (B) and not
molecular barcodes (M).</p><p>Barcodes can be provided in the form of a list (BARCODE_FILE) or a string representing the
barcode (BARCODE).  The BARCODE_FILE contains multiple fields including 'barcode_sequence' (or 'barcode_sequence_1'),
'barcode_sequence_2' (optional), 'barcode_name', and 'library_name'. In contrast, the BARCODE argument is used for runs
with reads containing a single barcode (nonmultiplexed) and can be added directly as a string of text e.g.
BARCODE=CAATAGCG.</p><p>Data is output per lane/tile within the BaseCalls directory with the file name format of
's_{lane}_{tile}_barcode.txt'.  These files contain the following tab-separated columns:<ul> <li>Read subsequence at
barcode position</li><li>Y or N indicating if there was a barcode match</li><li>Matched barcode sequence (empty if read
did not match one of the barcodes)</li>  <li>The number of mismatches if there was a barcode match</li>  <li>The number
of mismatches to the second best barcode if there was a barcode match</li>  </ul>If there is no match but we're close to
the threshold of calling it a match, we output the barcode that would have been matched but in lower case.  Threshold
values can be adjusted to accommodate barcode sequence mismatches from the reads.  The metrics file produced by the
ExtractIlluminaBarcodes program indicates the number of matches (and mismatches) between the barcode reads and the
actual barcodes.  These metrics are provided both per-barcode and per lane and can be found in the BaseCalls
directory.</p><p>For poorly matching barcodes, the order of specification of barcodes can cause arbitrary output
differences.</p><h4>Usage example:</h4> <pre>java -jar picard.jar ExtractIlluminaBarcodes \<br />             
BASECALLS_DIR=/BaseCalls/ \<br />              LANE=1 \<br />          READ_STRUCTURE=25T8B25T \<br />             
BARCODE_FILE=barcodes.txt \<br />              METRICS_FILE=metrics_output.txt </pre>Please see the
ExtractIlluminaBarcodes.BarcodeMetric <a
href='http://broadinstitute.github.io/picard/picard-metric-definitions.html#ExtractIlluminaBarcodes.BarcodeMetric'>definitions</a>
for a complete description of the metrics produced by this tool.</p><hr />
Version:3.4.0


Required Arguments:

--BARCODE <String>            Barcode sequence.  These must be unique, and all the same length.  This cannot be used
                              with reads that have more than one barcode; use BARCODE_FILE in that case.   This argument
                              must be specified at least once. Required.  Cannot be used in conjunction with argument(s)
                              BARCODE_FILE

--BARCODE_FILE <File>         Tab-delimited file of barcode sequences, barcode name and, optionally, library name. 
                              Barcodes must be unique and all the same length.  Column headers must be
                              'barcode_sequence' (or 'barcode_sequence_1'), 'barcode_sequence_2' (optional),
                              'barcode_name', and 'library_name'.  Required.  Cannot be used in conjunction with
                              argument(s) BARCODE

--BASECALLS_DIR,-B <File>     The Illumina basecalls directory.   Required. 

--LANE,-L <Integer>           Lane number. This can be specified multiple times. Reads with the same index in multiple
                              lanes will be added to the same output file.  This argument must be specified at least
                              once. Required. 

--READ_STRUCTURE,-RS <String> A description of the logical structure of clusters in an Illumina Run, i.e. a description
                              of the structure IlluminaBasecallsToSam assumes the  data to be in. It should consist of
                              integer/character pairs describing the number of cycles and the type of those cycles (B
                              for Sample Barcode, M for molecular barcode, T for Template, and S for skip).  E.g. If the
                              input data consists of 80 base clusters and we provide a read structure of "28T8M8B8S28T"
                              then the sequence may be split up into four reads:
                              * read one with 28 cycles (bases) of template
                              * read two with 8 cycles (bases) of molecular barcode (ex. unique molecular barcode)
                              * read three with 8 cycles (bases) of sample barcode
                              * 8 cycles (bases) skipped.
                              * read four with 28 cycles (bases) of template
                              The skipped cycles would NOT be included in an output SAM/BAM file or in read groups
                              therein.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESS_OUTPUTS,-GZIP <Boolean>
                              Compress output FASTQ files using gzip and append a .gz extension to the file names. 
                              Default value: false. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DISTANCE_MODE <DistanceMetric>
                              The distance metric that should be used to compare the barcode-reads and the provided
                              barcodes for finding the best and second-best assignments.  Default value: HAMMING.
                              HAMMING (Hamming distance: The n-th base in the read is compared against the n-th base in
                              the barcode. Unequal bases and low quality bases are considered mismatches. No-call
                              read-bases are not considered mismatches. )
                              LENIENT_HAMMING (Leniant Hamming distance: The n-th base in the read is compared against
                              the n-th base in the barcode. Unequal bases are considered mismatches. No-call read-bases,
                              or those with low quality are not considered mismatches.)
                              FREE (FREE Metric: A Levenshtein-like metric that performs a simple Smith-Waterman with
                              mismatch, gap open, and gap extend costs all equal to 1. Insertions or deletions at the
                              ends of the read or barcode do not count toward the distance. No-call read-bases, or those
                              with low quality are not considered mismatches.)

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INPUT_PARAMS_FILE <File>    The input file that defines parameters for the program. This is the BARCODE_FILE for
                              `ExtractIlluminaBarcodes` or the MULTIPLEX_PARAMS or LIBRARY_PARAMS file for
                              `IlluminaBasecallsToFastq`  or `IlluminaBasecallsToSam`  Default value: null. 

--MAX_MISMATCHES <Integer>    Maximum mismatches for a barcode to be considered a match.  Default value: 1. 

--MAX_NO_CALLS <Integer>      Maximum allowable number of no-calls in a barcode read before it is considered
                              unmatchable.  Default value: 2. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--METRICS_FILE,-M <File>      Per-barcode and per-lane metrics written to this file.  Default value: null. 

--MIN_MISMATCH_DELTA <Integer>Minimum difference between number of mismatches in the best and second best barcodes for a
                              barcode to be considered a match.  Default value: 1. 

--MINIMUM_BASE_QUALITY,-Q <Integer>
                              Minimum base quality. Any barcode bases falling below this quality will be considered a
                              mismatch even if the bases match.  Default value: 0. 

--MINIMUM_QUALITY <Integer>   The minimum quality (after transforming 0s to 1s) expected from reads.  If qualities are
                              lower than this value, an error is thrown. The default of 2 is what the Illumina's spec
                              describes as the minimum, but in practice the value has been observed lower.  Default
                              value: 2. 

--NUM_PROCESSORS <Integer>    Run this many PerTileBarcodeExtractors in parallel.  If NUM_PROCESSORS = 0, number of
                              cores is automatically set to the number of cores available on the machine. If
                              NUM_PROCESSORS < 0 then the number of cores used will be the number available on the
                              machine less NUM_PROCESSORS.  Default value: 1. 

--OUTPUT_DIR <File>           Where to write _barcode.txt files.  By default, these are written to BASECALLS_DIR. 
                              Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument BARCODE_FILE was missing: Argument 'BARCODE_FILE' is required unless one of {[BARCODE]} are provided
```


## picard_IlluminaBasecallsToFastq

### Tool Description
Generate FASTQ file(s) from Illumina basecall read data. This tool generates FASTQ files from data in an Illumina BaseCalls output directory. Separate FASTQ files are created for each template, barcode, and index (molecular barcode) read.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: IlluminaBasecallsToFastq [arguments]

Generate FASTQ file(s) from Illumina basecall read data.  <p>This tool generates FASTQ files from data in an Illumina
BaseCalls output directory.  Separate FASTQ files are created for each template, barcode, and index (molecular barcode)
read.  Briefly, the template reads are the target sequence of your experiment, the barcode sequence reads facilitate
sample demultiplexing, and the index reads help mitigate instrument phasing errors.  For additional information on the
read types, please see the following reference <a
href'=http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3245947/'>here</a>.</p><p>In the absence of sample pooling
(multiplexing) and/or barcodes, then an OUTPUT_PREFIX (file directory) must be provided as the sample identifier.  For
multiplexed samples, a MULTIPLEX_PARAMS file must be specified.  The MULTIPLEX_PARAMS file contains the list of sample
barcodes used to sort template, barcode, and index reads.  It is essentially the same as the BARCODE_FILE used in the<a
href='http://broadinstitute.github.io/picard/command-line-overview.html#ExtractIlluminaBarcodes'>ExtractIlluminaBarcodes</a>
tool.</p>     <p>Barcode matching can be done inline without requiring barcodes files generated by
`ExtractIlluminaBarcode`. By setting MATCH_BARCODES_INLINE to true barcodes will be matched as they are parsed and
converted. Thisdoes not require BARCODES_DIR.</p>     <p>Files from this tool use the following naming format:
{prefix}.{type}_{number}.fastq with the {prefix} indicating the sample barcode, the {type} indicating the types of reads
e.g. index, barcode, or blank (if it contains a template read).  The {number} indicates the read number, either first
(1) or second (2) for paired-end sequencing. </p> <h4>Usage examples:</h4><pre>Example 1: Sample(s) with either no
barcode or barcoded without multiplexing <br />java -jar picard.jar IlluminaBasecallsToFastq \<br />     
READ_STRUCTURE=25T8B25T \<br />      BASECALLS_DIR=basecallDirectory \<br />      LANE=001 \<br />     
OUTPUT_PREFIX=noBarcode.1 \<br />      RUN_BARCODE=run15 \<br />      FLOWCELL_BARCODE=abcdeACXX <br /><br />Example 2:
Multiplexed samples <br />java -jar picard.jar IlluminaBasecallsToFastq \<br />      READ_STRUCTURE=25T8B25T \<br />    
BASECALLS_DIR=basecallDirectory \<br />      LANE=001 \<br />      MULTIPLEX_PARAMS=demultiplexed_output.txt \<br />    
RUN_BARCODE=run15 \<br />      FLOWCELL_BARCODE=abcdeACXX <br /></pre><p>The FLOWCELL_BARCODE is required if emitting
Casava 1.8-style read name headers.</p><hr />
Version:3.4.0


Required Arguments:

--BASECALLS_DIR,-B <File>     The Illumina basecalls directory.   Required. 

--LANE,-L <Integer>           Lane number. This can be specified multiple times. Reads with the same index in multiple
                              lanes will be added to the same output file.  This argument must be specified at least
                              once. Required. 

--MULTIPLEX_PARAMS <File>     Tab-separated file for creating all output FASTQs demultiplexed by barcode for a lane with
                              single IlluminaBasecallsToFastq invocation.  The columns are OUTPUT_PREFIX, and BARCODE_1,
                              BARCODE_2 ... BARCODE_X where X = number of barcodes per cluster (optional).  Row with
                              BARCODE_1 set to 'N' is used to specify an output_prefix for no barcode match.  Required. 
                              Cannot be used in conjunction with argument(s) OUTPUT_PREFIX (O)

--OUTPUT_PREFIX,-O <File>     The prefix for output FASTQs.  Extensions as described above are appended.  Use this
                              option for a non-barcoded run, or for a barcoded run in which it is not desired to
                              demultiplex reads into separate files by barcode.  Required.  Cannot be used in
                              conjunction with argument(s) MULTIPLEX_PARAMS

--READ_STRUCTURE,-RS <String> A description of the logical structure of clusters in an Illumina Run, i.e. a description
                              of the structure IlluminaBasecallsToSam assumes the  data to be in. It should consist of
                              integer/character pairs describing the number of cycles and the type of those cycles (B
                              for Sample Barcode, M for molecular barcode, T for Template, and S for skip).  E.g. If the
                              input data consists of 80 base clusters and we provide a read structure of "28T8M8B8S28T"
                              then the sequence may be split up into four reads:
                              * read one with 28 cycles (bases) of template
                              * read two with 8 cycles (bases) of molecular barcode (ex. unique molecular barcode)
                              * read three with 8 cycles (bases) of sample barcode
                              * 8 cycles (bases) skipped.
                              * read four with 28 cycles (bases) of template
                              The skipped cycles would NOT be included in an output SAM/BAM file or in read groups
                              therein.  Required. 

--RUN_BARCODE <String>        The barcode of the run.  Prefixed to read names.  Required. 


Optional Arguments:

--ADAPTERS_TO_CHECK <IlluminaAdapterPair>
                              Which adapters to look for in the reads. The default value is null, meaning that no
                              adapters will be looked for in the reads.  This argument may be specified 0 or more times.
                              Default value: null. Possible values: {PAIRED_END, INDEXED, SINGLE_END, NEXTERA_V1,
                              NEXTERA_V2, DUAL_INDEXED, FLUIDIGM, TRUSEQ_SMALLRNA, ALTERNATIVE_SINGLE_END} 

--APPLY_EAMSS_FILTER <Boolean>Apply EAMSS filtering to identify inappropriately quality scored bases towards the ends of
                              reads and convert their quality scores to Q2.  Default value: true. Possible values:
                              {true, false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--BARCODES_DIR,-BCD <File>    The barcodes directory with _barcode.txt files (generated by ExtractIlluminaBarcodes). If
                              not set, use BASECALLS_DIR.   Default value: null. 

--COMPRESS_OUTPUTS,-GZIP <Boolean>
                              Compress output FASTQ files using gzip and append a .gz extension to the file names. 
                              Default value: false. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DISTANCE_MODE <DistanceMetric>
                              The distance metric that should be used to compare the barcode-reads and the provided
                              barcodes for finding the best and second-best assignments.  Default value: HAMMING.
                              HAMMING (Hamming distance: The n-th base in the read is compared against the n-th base in
                              the barcode. Unequal bases and low quality bases are considered mismatches. No-call
                              read-bases are not considered mismatches. )
                              LENIENT_HAMMING (Leniant Hamming distance: The n-th base in the read is compared against
                              the n-th base in the barcode. Unequal bases are considered mismatches. No-call read-bases,
                              or those with low quality are not considered mismatches.)
                              FREE (FREE Metric: A Levenshtein-like metric that performs a simple Smith-Waterman with
                              mismatch, gap open, and gap extend costs all equal to 1. Insertions or deletions at the
                              ends of the read or barcode do not count toward the distance. No-call read-bases, or those
                              with low quality are not considered mismatches.)

--FIRST_TILE <Integer>        If set, this is the first tile to be processed (used for debugging).  Note that tiles are
                              not processed in numerical order.  Default value: null. 

--FIVE_PRIME_ADAPTER <String> For specifying adapters other than standard Illumina  Default value: null. 

--FLOWCELL_BARCODE <String>   The barcode of the flowcell that was sequenced; required if emitting Casava1.8-style read
                              name headers  Default value: null. 

--FORCE_GC <Boolean>          If true, call System.gc() periodically.  This is useful in cases in which the -Xmx value
                              passed is larger than the available memory.  Default value: true. Possible values: {true,
                              false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--IGNORE_UNEXPECTED_BARCODES,-INGORE_UNEXPECTED <Boolean>
                              Whether to ignore reads whose barcodes are not found in MULTIPLEX_PARAMS.  Useful when
                              outputting FASTQs for only a subset of the barcodes in a lane.  Default value: false.
                              Possible values: {true, false} 

--INCLUDE_NON_PF_READS,-NONPF <Boolean>
                              Whether to include non-PF reads  Default value: true. Possible values: {true, false} 

--INPUT_PARAMS_FILE <File>    The input file that defines parameters for the program. This is the BARCODE_FILE for
                              `ExtractIlluminaBarcodes` or the MULTIPLEX_PARAMS or LIBRARY_PARAMS file for
                              `IlluminaBasecallsToFastq`  or `IlluminaBasecallsToSam`  Default value: null. 

--MACHINE_NAME <String>       The name of the machine on which the run was sequenced; required if emitting
                              Casava1.8-style read name headers  Default value: null. 

--MATCH_BARCODES_INLINE <Boolean>
                              If true, match barcodes on the fly. Otherwise parse the barcodes from the barcodes file. 
                              Default value: false. Possible values: {true, false} 

--MAX_MISMATCHES <Integer>    Maximum mismatches for a barcode to be considered a match.  Default value: 1. 

--MAX_NO_CALLS <Integer>      Maximum allowable number of no-calls in a barcode read before it is considered
                              unmatchable.  Default value: 2. 

--MAX_READS_IN_RAM_PER_TILE <Integer>
                              Configure SortingCollections to store this many records before spilling to disk. For an
                              indexed run, each SortingCollection gets this value/number of indices. Deprecated: use
                              `MAX_RECORDS_IN_RAM`  Default value: -1. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--METRICS_FILE,-M <File>      Per-barcode and per-lane metrics written to this file.  Default value: null. 

--MIN_MISMATCH_DELTA <Integer>Minimum difference between number of mismatches in the best and second best barcodes for a
                              barcode to be considered a match.  Default value: 1. 

--MIN_TRIMMED_LENGTH <Integer>The minimum length for a trimmed read. If trimming would create a smaller read, then trim
                              to this length instead  Default value: 20. 

--MINIMUM_BASE_QUALITY,-Q <Integer>
                              Minimum base quality. Any barcode bases falling below this quality will be considered a
                              mismatch even if the bases match.  Default value: 0. 

--MINIMUM_QUALITY <Integer>   The minimum quality (after transforming 0s to 1s) expected from reads.  If qualities are
                              lower than this value, an error is thrown. The default of 2 is what the Illumina's spec
                              describes as the minimum, but in practice the value has been observed lower.  Default
                              value: 2. 

--NUM_PROCESSORS <Integer>    The number of threads to run in parallel. If NUM_PROCESSORS = 0, number of cores is
                              automatically set to the number of cores available on the machine. If NUM_PROCESSORS < 0,
                              then the number of cores used will be the number available on the machine less
                              NUM_PROCESSORS.  Default value: 0. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_NAME_FORMAT <ReadNameFormat>
                              The read name header formatting to emit.  Casava1.8 formatting has additional information
                              beyond Illumina, including: the passing-filter flag value for the read, the flowcell name,
                              and the sequencer name.  Default value: CASAVA_1_8. Possible values: {CASAVA_1_8,
                              ILLUMINA} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SORT <Boolean>              If true, the output records are sorted by read name. Otherwise they are output in the same
                              order that the data was produced on the sequencer (ordered by tile and position).  Default
                              value: true. Possible values: {true, false} 

--THREE_PRIME_ADAPTER <String>For specifying adapters other than standard Illumina  Default value: null. 

--TILE_LIMIT <Integer>        If set, process no more than this many tiles (used for debugging).  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--TRIMMING_QUALITY <Integer>  The quality to use as a threshold for trimming.  Default value: null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument OUTPUT_PREFIX was missing: Argument 'OUTPUT_PREFIX' is required unless one of {[MULTIPLEX_PARAMS]} are provided
```


## picard_IlluminaBasecallsToSam

### Tool Description
Transforms raw Illumina sequencing data into an unmapped SAM, BAM or CRAM file. The IlluminaBaseCallsToSam program collects, demultiplexes, and sorts reads across all of the tiles of a lane via barcode to produce an unmapped SAM, BAM or CRAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: IlluminaBasecallsToSam [arguments]

Transforms raw Illumina sequencing data into an unmapped SAM, BAM or CRAM file.<p>The IlluminaBaseCallsToSam program
collects, demultiplexes, and sorts reads across all of the tiles of a lane via barcode to produce an unmapped SAM, BAM
or CRAM file.  An unmapped BAM file is often referred to as a uBAM.  All barcode, sample, and library data is provided
in the LIBRARY_PARAMS file.  Note, this LIBRARY_PARAMS file should be formatted according to the specifications
indicated below.  The following is an example of a properly formatted LIBRARY_PARAMS
file:</p>BARCODE_1	OUTPUT	SAMPLE_ALIAS	LIBRARY_NAME
AAAAAAAA	SA_AAAAAAAA.bam	SA_AAAAAAAA	LN_AAAAAAAA
AAAAGAAG	SA_AAAAGAAG.bam	SA_AAAAGAAG	LN_AAAAGAAG
AACAATGG	SA_AACAATGG.bam	SA_AACAATGG	LN_AACAATGG
N	SA_non_indexed.bam	SA_non_indexed	LN_NNNNNNNN
<p>The BARCODES_DIR file is produced by the <a
href='http://broadinstitute.github.io/picard/command-line-overview.html#ExtractIlluminaBarcodes'>ExtractIlluminaBarcodes</a>
tool for each lane of a flow cell.</p>  <p>Barcode matching can be done inline without requiring barcodes files
generated by `ExtractIlluminaBarcode`. By setting MATCH_BARCODES_INLINE to true barcodes will be matched as they are
parsed and converted. Thisdoes not require BARCODES_DIR.</p>     <h4>Usage example:</h4><pre>java -jar picard.jar
IlluminaBasecallsToSam \<br />      BASECALLS_DIR=/BaseCalls/ \<br />      LANE=001 \<br />      READ_STRUCTURE=25T8B25T
\<br />      RUN_BARCODE=run15 \<br />      IGNORE_UNEXPECTED_BARCODES=true \<br />      LIBRARY_PARAMS=library.params
</pre><hr />
Version:3.4.0


Required Arguments:

--BARCODE_PARAMS <File>       Deprecated (use LIBRARY_PARAMS).  Tab-separated file for creating all output SAM, BAM or
                              CRAM files for barcoded run with single IlluminaBasecallsToSam invocation.  Columns are
                              BARCODE, OUTPUT, SAMPLE_ALIAS, and LIBRARY_NAME.  Row with BARCODE=N is used to specify a
                              file for no barcode match  Required.  Cannot be used in conjunction with argument(s)
                              OUTPUT (O) SAMPLE_ALIAS (ALIAS) LIBRARY_NAME (LIB) LIBRARY_PARAMS

--BASECALLS_DIR,-B <File>     The Illumina basecalls directory.   Required. 

--LANE,-L <Integer>           Lane number. This can be specified multiple times. Reads with the same index in multiple
                              lanes will be added to the same output file.  This argument must be specified at least
                              once. Required. 

--LIBRARY_PARAMS <File>       Tab-separated file for creating all output SAM, BAM or CRAM files for a lane with single
                              IlluminaBasecallsToSam invocation.  The columns are OUTPUT, SAMPLE_ALIAS, and
                              LIBRARY_NAME, BARCODE_1, BARCODE_2 ... BARCODE_X where X = number of barcodes per cluster
                              (optional).  Row with BARCODE_1 set to 'N' is used to specify a file for no barcode match.
                              You may also provide any 2 letter RG header attributes (excluding PU, CN, PL, and DT)  as
                              columns in this file and the values for those columns will be inserted into the RG tag for
                              the SAM, BAM or CRAM file created for a given row.  Required.  Cannot be used in
                              conjunction with argument(s) OUTPUT (O) SAMPLE_ALIAS (ALIAS) LIBRARY_NAME (LIB)
                              BARCODE_PARAMS

--OUTPUT,-O <File>            Deprecated (use LIBRARY_PARAMS).  The output SAM, BAM or CRAM file. Format is determined
                              by extension.  Required.  Cannot be used in conjunction with argument(s) BARCODE_PARAMS
                              LIBRARY_PARAMS

--READ_STRUCTURE,-RS <String> A description of the logical structure of clusters in an Illumina Run, i.e. a description
                              of the structure IlluminaBasecallsToSam assumes the  data to be in. It should consist of
                              integer/character pairs describing the number of cycles and the type of those cycles (B
                              for Sample Barcode, M for molecular barcode, T for Template, and S for skip).  E.g. If the
                              input data consists of 80 base clusters and we provide a read structure of "28T8M8B8S28T"
                              then the sequence may be split up into four reads:
                              * read one with 28 cycles (bases) of template
                              * read two with 8 cycles (bases) of molecular barcode (ex. unique molecular barcode)
                              * read three with 8 cycles (bases) of sample barcode
                              * 8 cycles (bases) skipped.
                              * read four with 28 cycles (bases) of template
                              The skipped cycles would NOT be included in an output SAM/BAM file or in read groups
                              therein.  Required. 

--RUN_BARCODE <String>        The barcode of the run.  Prefixed to read names.  Required. 

--SAMPLE_ALIAS,-ALIAS <String>Deprecated (use LIBRARY_PARAMS).  The name of the sequenced sample  Required.  Cannot be
                              used in conjunction with argument(s) BARCODE_PARAMS LIBRARY_PARAMS

--SEQUENCING_CENTER <String>  The name of the sequencing center that produced the reads.  Used to set the @RG->CN header
                              tag.  Required. 


Optional Arguments:

--ADAPTERS_TO_CHECK <IlluminaAdapterPair>
                              Which adapters to look for in the read.  This argument may be specified 0 or more times.
                              Default value: [INDEXED, DUAL_INDEXED, NEXTERA_V2, FLUIDIGM]. Possible values:
                              {PAIRED_END, INDEXED, SINGLE_END, NEXTERA_V1, NEXTERA_V2, DUAL_INDEXED, FLUIDIGM,
                              TRUSEQ_SMALLRNA, ALTERNATIVE_SINGLE_END} 

--APPLY_EAMSS_FILTER <Boolean>Apply EAMSS filtering to identify inappropriately quality scored bases towards the ends of
                              reads and convert their quality scores to Q2.  Default value: true. Possible values:
                              {true, false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--BARCODE_POPULATION_STRATEGY <PopulateBarcode>
                              When should the sample barcode (as read by the sequencer) be placed on the reads in the BC
                              tag?  Default value: ORPHANS_ONLY. ORPHANS_ONLY (Put barcodes only into the records that
                              were not assigned to any declared barcode.)
                              INEXACT_MATCH (Put barcodes into records for which an exact match with a declared barcode
                              was not found.)
                              ALWAYS (Put barcodes into all the records.)

--BARCODES_DIR,-BCD <File>    The barcodes directory with _barcode.txt files (generated by ExtractIlluminaBarcodes). If
                              not set, use BASECALLS_DIR.   Default value: null. 

--COMPRESS_OUTPUTS,-GZIP <Boolean>
                              Compress output FASTQ files using gzip and append a .gz extension to the file names. 
                              Default value: false. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DISTANCE_MODE <DistanceMetric>
                              The distance metric that should be used to compare the barcode-reads and the provided
                              barcodes for finding the best and second-best assignments.  Default value: HAMMING.
                              HAMMING (Hamming distance: The n-th base in the read is compared against the n-th base in
                              the barcode. Unequal bases and low quality bases are considered mismatches. No-call
                              read-bases are not considered mismatches. )
                              LENIENT_HAMMING (Leniant Hamming distance: The n-th base in the read is compared against
                              the n-th base in the barcode. Unequal bases are considered mismatches. No-call read-bases,
                              or those with low quality are not considered mismatches.)
                              FREE (FREE Metric: A Levenshtein-like metric that performs a simple Smith-Waterman with
                              mismatch, gap open, and gap extend costs all equal to 1. Insertions or deletions at the
                              ends of the read or barcode do not count toward the distance. No-call read-bases, or those
                              with low quality are not considered mismatches.)

--FIRST_TILE <Integer>        If set, this is the first tile to be processed (used for debugging).  Note that tiles are
                              not processed in numerical order.  Default value: null.  Cannot be used in conjunction
                              with argument(s) PROCESS_SINGLE_TILE

--FIVE_PRIME_ADAPTER <String> For specifying adapters other than standard Illumina  Default value: null. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--IGNORE_UNEXPECTED_BARCODES,-IGNORE_UNEXPECTED <Boolean>
                              Whether to ignore reads whose barcodes are not found in LIBRARY_PARAMS.  Useful when
                              outputting SAM, BAM or CRAM files for only a subset of the barcodes in a lane.  Default
                              value: false. Possible values: {true, false} 

--INCLUDE_BARCODE_QUALITY <Boolean>
                              Should the barcode quality be included when the sample barcode is included?  Default
                              value: false. Possible values: {true, false} 

--INCLUDE_BC_IN_RG_TAG <Boolean>
                              Whether to include the barcode information in the @RG->BC header tag. Defaults to false
                              until included in the SAM spec.  Default value: false. Possible values: {true, false} 

--INCLUDE_NON_PF_READS,-NONPF <Boolean>
                              Whether to include non-PF reads  Default value: true. Possible values: {true, false} 

--INPUT_PARAMS_FILE <File>    The input file that defines parameters for the program. This is the BARCODE_FILE for
                              `ExtractIlluminaBarcodes` or the MULTIPLEX_PARAMS or LIBRARY_PARAMS file for
                              `IlluminaBasecallsToFastq`  or `IlluminaBasecallsToSam`  Default value: null. 

--LIBRARY_NAME,-LIB <String>  Deprecated (use LIBRARY_PARAMS).  The name of the sequenced library  Default value: null. 
                              Cannot be used in conjunction with argument(s) BARCODE_PARAMS LIBRARY_PARAMS

--MATCH_BARCODES_INLINE <Boolean>
                              If true, match barcodes on the fly. Otherwise parse the barcodes from the barcodes file. 
                              Default value: false. Possible values: {true, false} 

--MAX_MISMATCHES <Integer>    Maximum mismatches for a barcode to be considered a match.  Default value: 1. 

--MAX_NO_CALLS <Integer>      Maximum allowable number of no-calls in a barcode read before it is considered
                              unmatchable.  Default value: 2. 

--MAX_READS_IN_RAM_PER_TILE <Integer>
                              Configure SortingCollections to store this many records before spilling to disk. For an
                              indexed run, each SortingCollection gets this value/number of indices. Deprecated: use
                              `MAX_RECORDS_IN_RAM`  Default value: -1. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--METRICS_FILE,-M <File>      Per-barcode and per-lane metrics written to this file.  Default value: null. 

--MIN_MISMATCH_DELTA <Integer>Minimum difference between number of mismatches in the best and second best barcodes for a
                              barcode to be considered a match.  Default value: 1. 

--MINIMUM_BASE_QUALITY,-Q <Integer>
                              Minimum base quality. Any barcode bases falling below this quality will be considered a
                              mismatch even if the bases match.  Default value: 0. 

--MINIMUM_QUALITY <Integer>   The minimum quality (after transforming 0s to 1s) expected from reads.  If qualities are
                              lower than this value, an error is thrown. The default of 2 is what the Illumina's spec
                              describes as the minimum, but in practice the value has been observed lower.  Default
                              value: 2. 

--MOLECULAR_INDEX_BASE_QUALITY_TAG <String>
                              The tag to use to store any molecular index base qualities.  If more than one molecular
                              index is found, their qualities will be concatenated and stored here (.i.e. the number of
                              "M" operators in the READ_STRUCTURE)  Default value: QX. 

--MOLECULAR_INDEX_TAG <String>The tag to use to store any molecular indexes.  If more than one molecular index is found,
                              they will be concatenated and stored here.  Default value: RX. 

--NUM_PROCESSORS <Integer>    The number of threads to run in parallel. If NUM_PROCESSORS = 0, number of cores is
                              automatically set to the number of cores available on the machine. If NUM_PROCESSORS < 0,
                              then the number of cores used will be the number available on the machine less
                              NUM_PROCESSORS.  Default value: 0. 

--PLATFORM <String>           The name of the sequencing technology that produced the read.  Default value: ILLUMINA. 

--PROCESS_SINGLE_TILE <Integer>
                              If set, process only the tile number given and prepend the tile number to the output file
                              name.  Default value: null.  Cannot be used in conjunction with argument(s) FIRST_TILE

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_GROUP_ID,-RG <String>  ID used to link RG header record with RG tag in SAM record.  If these are unique in SAM
                              files that get merged, merge performance is better.  If not specified, READ_GROUP_ID will
                              be set to <first 5 chars of RUN_BARCODE>.<LANE> .  Default value: null. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--RUN_START_DATE <Date>       The start date of the run.  Default value: null. 

--SORT <Boolean>              If true, the output records are sorted by read name. Otherwise they are unsorted.  Default
                              value: true. Possible values: {true, false} 

--TAG_PER_MOLECULAR_INDEX <String>
                              The list of tags to store each molecular index.  The number of tags should match the
                              number of molecular indexes.  This argument may be specified 0 or more times. Default
                              value: null. 

--THREE_PRIME_ADAPTER <String>For specifying adapters other than standard Illumina  Default value: null. 

--TILE_LIMIT <Integer>        If set, process no more than this many tiles (used for debugging).  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument OUTPUT was missing: Argument 'OUTPUT' is required unless one of {[BARCODE_PARAMS, LIBRARY_PARAMS]} are provided
```


## picard_MarkIlluminaAdapters

### Tool Description
Reads a SAM/BAM/CRAM file and rewrites it with new adapter-trimming tags. This tool clears any existing adapter-trimming tags (XT:i:) in the optional tag region of the input file. The SAM/BAM/CRAM file must be sorted by query name. Outputs a metrics file histogram showing counts of bases_clipped per read.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: MarkIlluminaAdapters [arguments]

Reads a SAM/BAM/CRAM file and rewrites it with new adapter-trimming tags.  <p>This tool clears any existing
adapter-trimming tags (XT:i:) in the optional tag region of the input file.  The SAM/BAM/CRAM file must be sorted by
query name.</p> <p>Outputs a metrics file histogram showing counts of bases_clipped per read.<h4>Usage
example:</h4><pre>java -jar picard.jar MarkIlluminaAdapters \<br /> INPUT=input.sam \<br />METRICS=metrics.txt </pre><hr
/>
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Undocumented option  Required. 

--METRICS,-M <File>           Histogram showing counts of bases_clipped in how many reads  Required. 


Optional Arguments:

--ADAPTER_TRUNCATION_LENGTH <Integer>
                              Adapters are truncated to this length to speed adapter matching.  Set to a large number to
                              effectively disable truncation.  Default value: 30. 

--ADAPTERS <IlluminaAdapterPair>
                              Which adapters sequences to attempt to identify and clip.  This argument may be specified
                              0 or more times. Default value: [INDEXED, DUAL_INDEXED, PAIRED_END]. Possible values:
                              {PAIRED_END, INDEXED, SINGLE_END, NEXTERA_V1, NEXTERA_V2, DUAL_INDEXED, FLUIDIGM,
                              TRUSEQ_SMALLRNA, ALTERNATIVE_SINGLE_END} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--FIVE_PRIME_ADAPTER <String> For specifying adapters other than standard Illumina  Default value: null. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_ERROR_RATE_PE <Double>  The maximum mismatch error rate to tolerate when clipping paired-end reads.  Default
                              value: 0.1. 

--MAX_ERROR_RATE_SE <Double>  The maximum mismatch error rate to tolerate when clipping single-end reads.  Default
                              value: 0.1. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MIN_MATCH_BASES_PE <Integer>The minimum number of bases to match over (per-read) when clipping paired-end reads. 
                              Default value: 6. 

--MIN_MATCH_BASES_SE <Integer>The minimum number of bases to match over when clipping single-end reads.  Default value:
                              12. 

--NUM_ADAPTERS_TO_KEEP <Integer>
                              If pruning the adapter list, keep only this many adapter sequences when pruning the list
                              (plus any adapters that were tied with the adapters being kept).  Default value: 1. 

--OUTPUT,-O <File>            If output is not specified, just the metrics are generated  Default value: null. 

--PAIRED_RUN,-PE <Boolean>    DEPRECATED. Whether this is a paired-end run. No longer used.  Default value: null.
                              Possible values: {true, false} 

--PRUNE_ADAPTER_LIST_AFTER_THIS_MANY_ADAPTERS_SEEN,-APT <Integer>
                              If looking for multiple adapter sequences, then after having seen this many adapters,
                              shorten the list of sequences. Keep the adapters that were found most frequently in the
                              input so far. Set to -1 if the input has a heterogeneous mix of adapters so shortening is
                              undesirable.  Default value: 100. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--THREE_PRIME_ADAPTER <String>For specifying adapters other than standard Illumina  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_AccumulateQualityYieldMetrics

### Tool Description
Combines multiple QualityYieldMetrics files into a single file. This tool is used in cases where the metrics are calculated separately on shards of the same read-group.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: AccumulateQualityYieldMetrics [arguments]

Combines multiple QualityYieldMetrics files into a single file. This tool is used in cases where the metrics are
calculated separately on shards of the same read-group.
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input QualityYieldMetrics files to merge.  This argument must be specified at least once.
                              Required. 

--OUTPUT,-O <File>            Output QualityYieldMetric file to write.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_AccumulateVariantCallingMetrics

### Tool Description
Combines multiple Variant Calling Metrics files into a single file. This tool is used in cases where the metrics are calculated separately for different (genomic) shards of the same callset and we want to combine them into a single result over the entire callset.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: AccumulateVariantCallingMetrics [arguments]

Combines multiple Variant Calling Metrics files into a single file.  This tool is used in cases where the metrics are
calculated separately for different (genomic) shards of the same callset and we want to combine them into a single
result over the entire callset. The shards are expected to contain the same samples (although it will not fail if they
do not) and to not have been run over overlapping genomic positions.
Version:3.4.0


Required Arguments:

--INPUT,-I <PicardHtsPath>    Paths (except for the file extensions) of Variant Calling Metrics files to read and merge.
                              This argument must be specified at least once. Required. 

--OUTPUT,-O <File>            Path (except for the file extension) of output metrics files to write.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_BamIndexStats

### Tool Description
Generate index statistics from a BAM file. This tool calculates statistics from a BAM index (.bai) file, emulating the behavior of the "samtools idxstats" command. The statistics collected include counts of aligned and unaligned reads as well as all records with no start coordinate.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: BamIndexStats [arguments]

Generate index statistics from a BAM fileThis tool calculates statistics from a BAM index (.bai) file, emulating the
behavior of the "samtools idxstats" command. The statistics collected include counts of aligned and unaligned reads as
well as all records with no start coordinate. The input to the tool is the BAM file name but it must be accompanied by a
corresponding index file.<br /><h4>Usage example:</h4><pre>java -jar picard.jar BamIndexStats \<br />      I=input.bam
\<br />      O=output</pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             A BAM file to process.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CalculateFingerprintMetrics

### Tool Description
Calculate statistics on fingerprints, checking their viability. This tool collects various statistics that pertain to a single fingerprint and reports the results in a metrics file.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CalculateFingerprintMetrics [arguments]

Calculate statistics on fingerprints, checking their viabilityThis tools collects various statistics that pertain to a
single fingerprint (<b>not</b> the comparison, or 'fingerprinting' of two distinct samples) and reports the results in a
metrics file. <p>The statistics collected are p-values, where the null-hypothesis is that the fingerprint is collected
from a non-contaminated, diploid human, whose genotypes are modelled by the probabilities given in the HAPLOTYPE_MAP
file.<p>Please see the FingerprintMetrics <a
href='http://broadinstitute.github.io/picard/picard-metric-definitions.html#FingerprintMetrics'>definitions</a> for a
complete description of the metrics produced by this tool.</p><hr /><p><h3>Example</h3>
<pre>" +
java -jar picard.jar CalculateFingerprintMetrics \
INPUT=sample.bam \
HAPLOTYPE_MAP=fingerprinting_haplotype_database.txt \
OUTPUT=sample.fingerprint_metrics
</pre>

Version:3.4.0


Required Arguments:

--HAPLOTYPE_MAP,-H <File>     The file lists a set of SNPs, optionally arranged in high-LD blocks, to be used for
                              fingerprinting. See
                              https://gatk.broadinstitute.org/hc/en-us/articles/360035531672-Haplotype-map-format for
                              details.  Required. 

--INPUT,-I <String>           One or more input files (SAM/BAM/CRAM or VCF).  This argument must be specified at least
                              once. Required. 

--OUTPUT,-O <File>            The output file to write (Metrics).  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--CALCULATE_BY <DataType>     Specificies which data-type should be used as the basic unit. Fingerprints from readgroups
                              can be "rolled-up" to the LIBRARY, SAMPLE, or FILE level before being used. Fingerprints
                              from VCF can be be examined by SAMPLE or FILE.  Default value: READGROUP. Possible values:
                              {FILE, SAMPLE, LIBRARY, READGROUP} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--GENOTYPE_LOD_THRESHOLD <Double>
                              LOD score threshold for considering a genotype to be definitive.  Default value: 3.0. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--NUMBER_OF_SAMPLING <Integer>Number of randomization trials for calculating the DISCRIMINATORY_POWER metric.  Default
                              value: 100. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CalculateReadGroupChecksum

### Tool Description
Creates a hash code based on the read groups (RG). This tool creates a hash code based on identifying information in the read groups (RG) of a ".BAM" or "SAM" file header. Addition or removal of RGs changes the hash code, enabling the user to quickly determine if changes have been made to the read group information.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CalculateReadGroupChecksum [arguments]

Creates a hash code based on the read groups (RG).  This tool creates a hash code based on identifying information in
the read groups (RG) of a ".BAM" or "SAM" file header.  Addition or removal of RGs changes the hash code, enabling the
user to quickly determine if changes have been made to the read group information. <br /><h4>Usage
example:</h4><pre>java -jar picard.jar CalculateReadGroupChecksum \<br />      I=input.bam</pre>Please see the
AddOrReplaceReadGroups tool documentation for information regarding the addition, subtraction, or merging of read
groups.<hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The input SAM or BAM file.   Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--OUTPUT,-O <File>            The file to which the hash code should be written.  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CheckDuplicateMarking

### Tool Description
This tool checks that all reads with the same queryname have their duplicate marking flags set the same way. NOTE: This tool does NOT check that the duplicate marking is correct. The ONLY thing that it checks is that the 0x400 bit-flags of records with the same queryname are equal.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CheckDuplicateMarking [arguments]

This tool checks that all reads with the same queryname have their duplicate marking flags set the same way. NOTE: This
tool does NOT check that the duplicate marking is correct. The ONLY thing that it checks is that the 0x400 bit-flags of
records with the same queryname are equal.
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input BAM or SAM file to check.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MODE <Mode>                 Which reads of the same name should be checked to have same duplicate marking.  Default
                              value: ALL. ALL (Check all reads.)
                              PRIMARY_ONLY (Check primary alignments.)
                              PRIMARY_MAPPED_ONLY (Check mapped alignments.)
                              PRIMARY_PROPER_PAIR_ONLY (Check mapped alignments.)

--OUTPUT,-O <File>            Output file into which bad querynames will be placed (if not null).  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CheckFingerprint

### Tool Description
Checks the sample identity of the sequence/genotype data in the provided file (SAM/BAM/CRAM or VCF) against a set of known genotypes in the supplied genotype file (in VCF format).

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CheckFingerprint [arguments]

Checks the sample identity of the sequence/genotype data in the provided file (SAM/BAM/CRAM or VCF) against a set of
known genotypes in the supplied genotype file (in VCF format).

<h3>Summary</h3> Computes a fingerprint (essentially, genotype information from different parts of the genome) from the
supplied input file (SAM/BAM/CRAM or VCF) file and compares it to the expected fingerprint genotypes provided. The key
output is a LOD score which represents the relative likelihood of the sequence data originating from the same sample as
the genotypes vs. from a random sample. <br/> Two outputs are produced: <ol> <li>A summary metrics file that gives
metrics of the fingerprint matches when comparing the input to a set of genotypes for the expected sample.  At the
single sample level (if the input was a VCF) or at the read level (lane or index within a lane) (if the input was a
SAM/BAM) </li> <li>A detail metrics file that contains an individual SNP/Haplotype comparison within a fingerprint
comparison.</li> </ol> The metrics files fill the fields of the classes FingerprintingSummaryMetrics and
FingerprintingDetailMetrics. The output files may be specified individually using the SUMMARY_OUTPUT and DETAIL_OUTPUT
options. Alternatively the OUTPUT option may be used instead to give the base of the two output files, with the summary
metrics having a file extension ".fingerprinting_summary_metrics", and the detail metrics having a file extension
".fingerprinting_detail_metrics". <br/> <h3>Example comparing a bam against known genotypes:</h3> <pre>     java -jar
picard.jar CheckFingerprint \
INPUT=sample.bam \
GENOTYPES=sample_genotypes.vcf \
HAPLOTYPE_MAP=fingerprinting_haplotype_database.txt \
OUTPUT=sample_fingerprinting </pre> <br/> <h3>Detailed Explanation</h3>This tool calculates a single number that reports
the LOD score for identity check between the INPUT and the GENOTYPES. A positive value indicates that the data seems to
have come from the same individual or, in other words the identity checks out. The scale is logarithmic (base 10), so a
LOD of 6 indicates that it is 1,000,000 more likely that the data matches the genotypes than not. A negative value
indicates that the data do not match. A score that is near zero is inconclusive and can result from low coverage or
non-informative genotypes. 

The identity check makes use of haplotype blocks defined in the HAPLOTYPE_MAP file to enable it to have higher
statistical power for detecting identity or swap by aggregating data from several SNPs in the haplotype block. This
enables an identity check of samples with very low coverage (e.g. ~1x mean coverage). 

When provided a VCF, the identity check looks at the PL, GL and GT fields (in that order) and uses the first one that it
finds. 
Version:3.4.0


Required Arguments:

--DETAIL_OUTPUT,-D <File>     The text file to which to write detail metrics.  Required.  Cannot be used in conjunction
                              with argument(s) OUTPUT (O)

--GENOTYPES,-G <String>       File of genotypes (VCF) to be used in comparison. May contain any number of genotypes;
                              CheckFingerprint will use only those that are usable for fingerprinting.  Required. 

--HAPLOTYPE_MAP,-H <File>     The file lists a set of SNPs, optionally arranged in high-LD blocks, to be used for
                              fingerprinting. See
                              https://gatk.broadinstitute.org/hc/en-us/articles/360035531672-Haplotype-map-format for
                              details.  Required. 

--INPUT,-I <String>           Input file SAM/BAM/CRAM or VCF.  If a VCF is used, it must have at least one sample.  If
                              there are more than one samples in the VCF, the parameter OBSERVED_SAMPLE_ALIAS must be
                              provided in order to indicate which sample's data to use.  If there are no samples in the
                              VCF, an exception will be thrown.  Required. 

--OUTPUT,-O <String>          The base prefix of output files to write.  The summary metrics will have the file
                              extension '.fingerprinting_summary_metrics' and the detail metrics will have the extension
                              '.fingerprinting_detail_metrics'.  Required.  Cannot be used in conjunction with
                              argument(s) SUMMARY_OUTPUT (S) DETAIL_OUTPUT (D)

--SUMMARY_OUTPUT,-S <File>    The text file to which to write summary metrics.  Required.  Cannot be used in conjunction
                              with argument(s) OUTPUT (O)


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--EXIT_CODE_WHEN_EXPECTED_SAMPLE_NOT_FOUND <Integer>
                              When the expected fingerprint sample is not found in the genotypes file, this exit code is
                              returned.  Default value: 1. 

--EXIT_CODE_WHEN_NO_VALID_CHECKS <Integer>
                              When all LOD score are zero, exit with this value.  Default value: 2. 

--EXPECTED_SAMPLE_ALIAS,-SAMPLE_ALIAS <String>
                              This parameter can be used to specify which sample's genotypes to use from the expected
                              VCF file (the GENOTYPES file).  If it is not supplied, the sample name from the input (VCF
                              or BAM read group header) will be used.  Default value: null. 

--GENOTYPE_LOD_THRESHOLD,-LOD <Double>
                              When counting haplotypes checked and matching, count only haplotypes where the most likely
                              haplotype achieves at least this LOD.  Default value: 5.0. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--IGNORE_READ_GROUPS,-IGNORE_RG <Boolean>
                              If the input is a SAM/BAM/CRAM, and this parameter is true, treat the entire input BAM as
                              one single read group in the calculation, ignoring RG annotations, and producing a single
                              fingerprint metric for the entire BAM.  Default value: false. Possible values: {true,
                              false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--OBSERVED_SAMPLE_ALIAS <String>
                              If the input is a VCF, this parameters used to select which sample's data in the VCF to
                              use.  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CheckTerminatorBlock

### Tool Description
Asserts the provided gzip file's (e.g., BAM) last block is well-formed; RC 100 otherwise

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CheckTerminatorBlock [arguments]

Asserts the provided gzip file's (e.g., BAM) last block is well-formed; RC 100 otherwise
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The block compressed file to check.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_ClusterCrosscheckMetrics

### Tool Description
Clusters the results from a CrosscheckFingerprints run according to the LOD score. Two groups are connected if they have a LOD score greater than the LOD_THRESHOLD. All groups in a cluster are related to each other either directly or indirectly.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: ClusterCrosscheckMetrics [arguments]

<h3>Summary</h3>
Clusters the results from a {@link CrosscheckFingerprints} run according to the LOD score. The resulting metric file can
be used to assist diagnosing results from {@link CrosscheckFingerprints}. It clusters the connectivity graph between the
different groups. Two groups are connected if they have a LOD score greater than the {@link #LOD_THRESHOLD}.

<h3>Details</h3>The results of running {@link CrosscheckFingerprints} can be difficult to analyze, especially when many
groups are related (meaning LOD greater than {@link #LOD_THRESHOLD}) in non-transitive manner (A is related to B, B is
related to C, but A doesn't seem to be related to C.) {@link ClusterCrosscheckMetrics} clusters the metrics from {@link
CrosscheckFingerprints} so that all the groups in a cluster are related to each other either directly, or indirectly
(thus A, B and C would end up in one cluster.) Two samples can only be in two different clusters if all the samples from
these two clusters do not get high LOD scores when compared to each other.

<h3>Example</h3>
<pre>
java -jar picard.jar ClusterCrosscheckMetrics \
INPUT=sample.crosscheck_metrics \
LOD_THRESHOLD=3 \
OUTPUT=sample.clustered.crosscheck_metrics
</pre>

The resulting file, consists of the {@link ClusteredCrosscheckMetric} class and contains the original crosscheck metric
values, for groups that end-up in the same clusters (regardless of LOD score of each comparison). In addition it notes
the {@link ClusteredCrosscheckMetric#CLUSTER} identifier and the size of the cluster (in {@link
ClusteredCrosscheckMetric#CLUSTER_SIZE}.) Groups that do not have high LOD scores with any other group (including
itself!) will not be included in the metric file. Note that cross-group comparisons are not included in the metric file.

Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The cross-check metrics file to be clustered.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--LOD_THRESHOLD,-LOD <Double> LOD score to be used as the threshold for clustering.  Default value: 0.0. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--OUTPUT,-O <File>            Output file to write metrics to. Will write to stdout if null.  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectAlignmentSummaryMetrics

### Tool Description
Produces a summary of alignment metrics from a SAM or BAM file. This tool takes a SAM/BAM file input and produces metrics detailing the quality of the read alignments as well as the proportion of the reads that passed machine signal-to-noise threshold quality filters.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectAlignmentSummaryMetrics [arguments]

<b>Produces a summary of alignment metrics from a SAM or BAM file.</b>  This tool takes a SAM/BAM file input and
produces metrics detailing the quality of the read alignments as well as the proportion of the reads that passed machine
signal-to-noise threshold quality filters. Note that these quality filters are specific to Illumina data; for additional
information, please see the corresponding <a href='https://www.broadinstitute.org/gatk/guide/article?id=6329'>GATK
Dictionary entry</a>. </p><p>Note: Metrics labeled as percentages are actually expressed as fractions!</p><h4>Usage
example:</h4><pre>    java -jar picard.jar CollectAlignmentSummaryMetrics \<br />          R=reference_sequence.fasta
\<br />          I=input.bam \<br />          O=output.txt</pre><p>Please see the CollectAlignmentSummaryMetrics <a
href='http://broadinstitute.github.io/picard/picard-metric-definitions.html#AlignmentSummaryMetrics'>definitions</a> for
a complete description of the metrics produced by this tool.</p><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            The file to write the output to.  Required. 


Optional Arguments:

--ADAPTER_SEQUENCE <String>   List of adapter sequences to use when processing the alignment metrics.  This argument may
                              be specified 0 or more times. Default value:
                              [AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTG,
                              AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT,
                              AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG]. 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true (default), then the sort order in the header file will be ignored.  Default value:
                              true. Possible values: {true, false} 

--COLLECT_ALIGNMENT_INFORMATION <Boolean>
                              A flag to disable the collection of actual alignment information. If false, tool will only
                              count READS, PF_READS, and NOISE_READS. (For backwards compatibility).  Default value:
                              true. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--EXPECTED_PAIR_ORIENTATIONS <PairOrientation>
                              Paired-end reads that do not have this expected orientation will be considered chimeric. 
                              This argument may be specified 0 or more times. Default value: [FR]. Possible values: {FR,
                              RF, TANDEM} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--HISTOGRAM_FILE,-H <File>    If Provided, file to write read-length chart pdf.  Default value: null. 

--IS_BISULFITE_SEQUENCED,-BS <Boolean>
                              Whether the SAM or BAM file consists of bisulfite sequenced reads.  Default value: false.
                              Possible values: {true, false} 

--MAX_INSERT_SIZE <Integer>   Paired-end reads above this insert size will be considered chimeric along with
                              inter-chromosomal pairs.  Default value: 100000. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--METRIC_ACCUMULATION_LEVEL,-LEVEL <MetricAccumulationLevel>
                              The level(s) at which to accumulate metrics.  This argument may be specified 0 or more
                              times. Default value: [ALL_READS]. Possible values: {ALL_READS, SAMPLE, LIBRARY,
                              READ_GROUP} 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <File>Reference sequence file. Note that while this argument isn't required, without it a small
                              subset (MISMATCH-related) of the metrics cannot be calculated. Note also that if a
                              reference sequence is provided, it must be accompanied by a sequence dictionary.  Default
                              value: null. 

--STOP_AFTER <Long>           Stop after processing N reads, mainly for debugging.  Default value: 0. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectArraysVariantCallingMetrics

### Tool Description
CollectArraysVariantCallingMetrics takes a Genotyping Arrays VCF file (as generated by GtcToVcf) and calculates summary and per-sample metrics.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectArraysVariantCallingMetrics [arguments]

CollectArraysVariantCallingMetrics takes a Genotyping Arrays VCF file (as generated by GtcToVcf) and calculates summary
and per-sample metrics. <h4>Usage example:</h4><pre>java -jar picard.jar CollectArraysVariantCallingMetrics \<br />     
INPUT=genotyping_arrays.vcf \<br />      OUTPUT=outputBaseName</pre>
Version:3.4.0


Required Arguments:

--DBSNP <File>                Reference dbSNP file in dbSNP or VCF format.  Required. 

--INPUT,-I <File>             Input vcf file for analysis  Required. 

--OUTPUT,-O <File>            Path (except for the file extension) of output metrics files to write.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--CALL_RATE_PF_THRESHOLD <Double>
                              The Call Rate Threshold for an autocall pass (if the observed call rate is > this value,
                              the sample is considered to be passing)  Default value: 0.98. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--NUM_PROCESSORS <Integer>    Split this task over multiple threads.  If NUM_PROCESSORS = 0, number of cores is
                              automatically set to the number of cores available on the machine. If NUM_PROCESSORS < 0
                              then the number of cores used will be the number available on the machine less
                              NUM_PROCESSORS.  Default value: 0. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SEQUENCE_DICTIONARY,-SD <File>
                              If present, speeds loading of dbSNP file, will look for dictionary in vcf if not present
                              here.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectBaseDistributionByCycle

### Tool Description
Chart the nucleotide distribution per cycle in a SAM or BAM file in order to enable assessment of systematic errors at specific positions in the reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectBaseDistributionByCycle [arguments]

Chart the nucleotide distribution per cycle in a SAM or BAM fileThis tool produces a chart of the nucleotide
distribution per cycle in a SAM or BAM file in order to enable assessment of systematic errors at specific positions in
the reads.<br /><br /><h4>Interpretation notes</h4>Increased numbers of miscalled bases will be reflected in base
distribution changes and increases in the number of Ns.  In general, we expect that for any given cycle, or position
within reads, the relative proportions of A, T, C and G should reflect the AT:GC content of the organism's genome. 
Thus, for all four nucleotides, flattish lines would be expected.  Deviations from this expectation, for example a spike
of A at a particular cycle (position within reads), would suggest a systematic sequencing error.<h4>Note on quality
trimming</h4>In the past, many sequencing data processing workflows included discarding the low-quality tails of reads
by applying hard-clipping at some arbitrary base quality threshold value. This is no longer useful because most
sophisticated analysis tools (such as the GATK variant discovery tools) are quality-aware, meaning that they are able to
take base quality into account when weighing evidence provided by sequencing reads. Unnecessary clipping may interfere
with other quality control evaluations and may lower the quality of analysis results. For example, trimming reduces the
effectiveness of the Base Recalibration (BQSR) pre-processing step of the <a
href='https://www.broadinstitute.org/gatk/guide/best-practices'>GATK Best Practices for Variant Discovery</a>, which
aims to correct some types of systematic biases that affect the accuracy of base quality scores.<p>Note: Metrics labeled
as percentages are actually expressed as fractions!</p><h4>Usage example:</h4><pre>java -jar picard.jar
CollectBaseDistributionByCycle \<br />      CHART=collect_base_dist_by_cycle.pdf \<br />      I=input.bam \<br />     
O=output.txt</pre><hr />
Version:3.4.0


Required Arguments:

--CHART_OUTPUT,-CHART <File>  A file (with .pdf extension) to write the chart to.  Required. 

--INPUT,-I <File>             Input SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            The file to write the output to.  Required. 


Optional Arguments:

--ALIGNED_READS_ONLY <Boolean>If set to true, calculate the base distribution over aligned reads only.  Default value:
                              false. Possible values: {true, false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true (default), then the sort order in the header file will be ignored.  Default value:
                              true. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--PF_READS_ONLY <Boolean>     If set to true, calculate the base distribution over PF reads only (Illumina specific). PF
                              reads are reads that passed the internal quality filters applied by Illumina sequencers. 
                              Default value: false. Possible values: {true, false} 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--STOP_AFTER <Long>           Stop after processing N reads, mainly for debugging.  Default value: 0. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument CHART_OUTPUT was missing: Argument 'CHART_OUTPUT' is required
```


## picard_CollectGcBiasMetrics

### Tool Description
Collect metrics regarding GC bias. This tool collects information about the relative proportions of guanine (G) and cytosine (C) nucleotides in a sample. Regions of high and low G + C content have been shown to interfere with mapping/aligning, ultimately leading to fragmented genome assemblies and poor coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectGcBiasMetrics [arguments]

Collect metrics regarding GC bias. This tool collects information about the relative proportions of guanine (G) and
cytosine (C) nucleotides in a sample.  Regions of high and low G + C content have been shown to interfere with
mapping/aligning, ultimately leading to fragmented genome assemblies and poor coverage in a phenomenon known as 'GC
bias'.  Detailed information on the effects of GC bias on the collection and analysis of sequencing data can be found at
DOI: 10.1371/journal.pone.0062856/.<br /><br /><p>The GC bias statistics are always output in a detailed long-form
version, but a summary can also be produced. Both the detailed metrics and the summary metrics are output as tables
'.txt' files) and an accompanying chart that plots the data ('.pdf' file). </p> <h4>Detailed metrics</h4>The table of
detailed metrics includes GC percentages for each bin (GC), the percentage of WINDOWS corresponding to each GC bin of
the reference sequence, the numbers of reads that start within a particular %GC content bin (READ_STARTS), and the mean
base quality of the reads that correspond to a specific GC content distribution window (MEAN_BASE_QUALITY). 
NORMALIZED_COVERAGE is a relative measure of sequence coverage by the reads at a particular GC content.For each run, the
corresponding reference sequence is divided into bins or windows based on the percentage of G + C content ranging from 0
- 100%.  The percentages of G + C are determined from a defined length of sequence; the default value is set at 100
bases. The mean of the distribution will vary among organisms; human DNA has a mean GC content of 40%, suggesting a
slight preponderance of AT-rich regions.  <br /><br /><h4>Summary metrics</h4>The table of summary metrics captures
run-specific bias information including WINDOW_SIZE, ALIGNED_READS, TOTAL_CLUSTERS, AT_DROPOUT, and GC_DROPOUT.  While
WINDOW_SIZE refers to the numbers of bases used for the distribution (see above), the ALIGNED_READS and TOTAL_CLUSTERS
are the total number of aligned reads and the total number of reads (after filtering) produced in a run. In addition,
the tool produces both AT_DROPOUT and GC_DROPOUT metrics, which indicate the percentage of misaligned reads that
correlate with low (%-GC is &lt; 50%) or high (%-GC is &gt; 50%) GC content respectively.  <br /><br />The percentage of
'coverage' or depth in a GC bin is calculated by dividing the number of reads of a particular GC content by the mean
number of reads of all GC bins.  A number of 1 represents mean coverage, a number less than 1 represents lower than mean
coverage (e.g. 0.5 means half as much coverage as average) while a number greater than 1 represents higher than mean
coverage (e.g. 3.1 means this GC bin has 3.1 times more reads per window than average).  This tool also tracks mean
base-quality scores of the reads within each GC content bin, enabling the user to determine how base quality scores vary
with GC content.  <br /> <br />The chart output associated with this data table plots the NORMALIZED_COVERAGE, the
distribution of WINDOWs corresponding to GC percentages, and base qualities corresponding to each %GC bin.<p>Note:
Metrics labeled as percentages are actually expressed as fractions!</p><h4>Usage Example:</h4><pre>java -jar picard.jar
CollectGcBiasMetrics \<br />      I=input.bam \<br />      O=gc_bias_metrics.txt \<br />      CHART=gc_bias_metrics.pdf
\<br />      S=summary_metrics.txt \<br />      R=reference_sequence.fasta</pre>Please see <a
href='https://broadinstitute.github.io/picard/picard-metric-definitions.html#GcBiasMetrics'>the GcBiasMetrics
documentation</a> for further explanations of each metric.<hr />
Version:3.4.0


Required Arguments:

--CHART_OUTPUT,-CHART <File>  The PDF file to render the chart to.  Required. 

--INPUT,-I <File>             Input SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            The file to write the output to.  Required. 

--SUMMARY_OUTPUT,-S <File>    The text file to write summary metrics to.  Required. 


Optional Arguments:

--ALSO_IGNORE_DUPLICATES <Boolean>
                              Use to get additional results without duplicates. This option allows to gain two plots per
                              level at the same time: one is the usual one and the other excludes duplicates.  Default
                              value: false. Possible values: {true, false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true (default), then the sort order in the header file will be ignored.  Default value:
                              true. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--IS_BISULFITE_SEQUENCED,-BS <Boolean>
                              Whether the SAM or BAM file consists of bisulfite sequenced reads.  Default value: false.
                              Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--METRIC_ACCUMULATION_LEVEL,-LEVEL <MetricAccumulationLevel>
                              The level(s) at which to accumulate metrics.  This argument may be specified 0 or more
                              times. Default value: [ALL_READS]. Possible values: {ALL_READS, SAMPLE, LIBRARY,
                              READ_GROUP} 

--MINIMUM_GENOME_FRACTION,-MGF <Double>
                              For summary metrics, exclude GC windows that include less than this fraction of the
                              genome.  Default value: 1.0E-5. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SCAN_WINDOW_SIZE,-WINDOW_SIZE <Integer>
                              The size of the scanning windows on the reference genome that are used to bin reads. 
                              Default value: 100. 

--STOP_AFTER <Long>           Stop after processing N reads, mainly for debugging.  Default value: 0. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument CHART_OUTPUT was missing: Argument 'CHART_OUTPUT' is required
```


## picard_CollectHiSeqXPfFailMetrics

### Tool Description
Classify PF-Failing reads in a HiSeqX Illumina Basecalling directory into various categories. This tool categorizes the reads that did not pass filter (PF-Failing) into four groups: MISALIGNED, EMPTY, POLYCLONAL, and UNKNOWN.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectHiSeqXPfFailMetrics [arguments]

Classify PF-Failing reads in a HiSeqX Illumina Basecalling directory into various categories.<p>This tool categorizes
the reads that did not pass filter (PF-Failing) into four groups.  These groups are based on a heuristic that was
derived by looking at a few titration experiments. </p><p>After examining the called bases from the first 24 cycles of
each read, the PF-Failed reads are grouped into the following four categories: <ul><li>MISALIGNED - The first 24
basecalls of a read are uncalled (numNs~24).   These types of reads appear to be flow cell artifacts because reads were
only found near tile boundaries and were concentration (library) independent</li> <li>EMPTY - All 24 bases are called
(numNs~0) but the number of bases with quality scores greater than two is less than or equal to eight (numQGtTwo<=8). 
These reads were location independent within the tiles and were inversely proportional to the library
concentration</li><li>POLYCLONAL - All 24 bases were called and numQGtTwo>=12, were independent of their location with
the tiles, and were directly proportional to the library concentration.  These reads are likely the result of PCR
artifacts </li><li>UNKNOWN - The remaining reads that are PF-Failing but did not fit into any of the groups listed
above</li></ul></p>  <p>The tool defaults to the SUMMARY output which indicates the number of PF-Failed reads per tile
and groups them into the categories described above accordingly.</p> <p>A DETAILED metrics option is also available that
subdivides the SUMMARY outputs by the x- y- position of these reads within each tile.  To obtain the DETAILED metric
table, you must add the PROB_EXPLICIT_READS option to your command line and set the value between 0 and 1.  This value
represents the fractional probability of PF-Failed reads to send to output.  For example, if PROB_EXPLICIT_READS=0, then
no metrics will be output.  If PROB_EXPLICIT_READS=1, then it will provide detailed metrics for all (100%) of the reads.
It follows that setting the PROB_EXPLICIT_READS=0.5, will provide detailed metrics for half of the PF-Failed reads.</p>
<p>Note: Metrics labeled as percentages are actually expressed as fractions!</p><h4>Usage example: (SUMMARY
Metrics)</h4> <pre>java -jar picard.jar CollectHiSeqXPfFailMetrics \<br />      BASECALLS_DIR=/BaseCalls/ \<br />     
OUTPUT=/metrics/ \<br />      LANE=001</pre><h4>Usage example: (DETAILED Metrics)</h4><pre>java -jar picard.jar
CollectHiSeqXPfFailMetrics \<br />      BASECALLS_DIR=/BaseCalls/ \<br />      OUTPUT=/Detail_metrics/ \<br />     
LANE=001 \<br />      PROB_EXPLICIT_READS=1</pre>Please see our documentation on the <a
href='https://broadinstitute.github.io/picard/picard-metric-definitions.html#CollectHiSeqXPfFailMetrics.PFFailSummaryMetric'>SUMMARY</a>
and <a
href='https://broadinstitute.github.io/picard/picard-metric-definitions.html#CollectHiSeqXPfFailMetrics.PFFailDetailedMetric'>DETAILED</a>
metrics for comprehensive explanations of the outputs produced by this tool.<hr />
Version:3.4.0


Required Arguments:

--BASECALLS_DIR,-B <File>     The Illumina basecalls directory.   Required. 

--LANE,-L <Integer>           Lane number.  Required. 

--OUTPUT,-O <File>            Basename for metrics file. Resulting file will be <OUTPUT>.pffail_summary_metrics 
                              Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--N_CYCLES <Integer>          Number of cycles to look at. At time of writing PF status gets determined at cycle 24 so
                              numbers greater than this will yield strange results. In addition, PF status is currently
                              determined at cycle 24, so running this with any other value is neither tested nor
                              recommended.  Default value: 24. 

--NUM_PROCESSORS,-NP <Integer>Run this many PerTileBarcodeExtractors in parallel.  If NUM_PROCESSORS = 0, number of
                              cores is automatically set to the number of cores available on the machine. If
                              NUM_PROCESSORS < 0 then the number of cores used will be the number available on the
                              machine less NUM_PROCESSORS.  Default value: 1. 

--PROB_EXPLICIT_READS,-P <Double>
                              The fraction of (non-PF) reads for which to output explicit classification. Output file
                              will be <OUTPUT>.pffail_detailed_metrics (if PROB_EXPLICIT_READS != 0)  Default value:
                              0.0. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument BASECALLS_DIR was missing: Argument 'BASECALLS_DIR' is required
```


## picard_CollectHsMetrics

### Tool Description
Collects hybrid-selection (HS) metrics for a SAM or BAM file. This tool takes a SAM/BAM file input and collects metrics that are specific for sequence datasets generated through hybrid-selection.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectHsMetrics [arguments]

Collects hybrid-selection (HS) metrics for a SAM or BAM file.  <p>This tool takes a SAM/BAM file input and collects
metrics that are specific for sequence datasets generated through hybrid-selection. Hybrid-selection (HS) is the most
commonly used technique to capture exon-specific sequences for targeted sequencing experiments such as exome sequencing;
for more information, please see the corresponding <a
href='http://www.broadinstitute.org/gatk/guide/article?id=6331'>GATK Dictionary entry</a>. </p> <p>This tool requires an
aligned SAM or BAM file as well as bait and target interval files in Picard interval_list format. You should use the
bait and interval files that correspond to the capture kit that was used to generate the capture libraries for
sequencing, which can generally be obtained from the kit manufacturer. If the baits and target intervals are provided in
BED format, you can convert them to the Picard interval_list format using Picard's <a
href='http://broadinstitute.github.io/picard/command-line-overview.html#BedToIntervalList'>BedToInterval</a> tool.
</p><p>If a reference sequence is provided, this program will calculate both AT_DROPOUT and GC_DROPOUT metrics. Dropout
metrics are an attempt to measure the reduced representation of reads, in regions that deviate from 50% G/C content.
This reduction in the number of aligned reads is due to the increased numbers of errors associated with sequencing
regions with excessive or deficient numbers of G/C bases, ultimately leading to poor mapping efficiencies and
lowcoverage in the affected regions. </p><p>If you are interested in getting G/C content and mean sequence depth
information for every target interval, use the PER_TARGET_COVERAGE option. </p><p>Note: Metrics labeled as percentages
are actually expressed as fractions!</p>  <h4>Usage Example:</h4><pre>java -jar picard.jar CollectHsMetrics \<br />     
I=input_reads.bam \<br />      O=output_hs_metrics.txt \<br />      R=reference.fasta \<br />     
BAIT_INTERVALS=bait.interval_list \<br />      TARGET_INTERVALS=target.interval_list</pre> <p>Please see <a
href='http://broadinstitute.github.io/picard/picard-metric-definitions.html#HsMetrics'>CollectHsMetrics</a> for detailed
descriptions of the output metrics produced by this tool.</p><hr />
Version:3.4.0


Required Arguments:

--BAIT_INTERVALS,-BI <File>   An interval list file that contains the locations of the baits used.  This argument must
                              be specified at least once. Required. 

--INPUT,-I <File>             An aligned SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            The output file to write the metrics to.  Required. 

--TARGET_INTERVALS,-TI <File> An interval list file that contains the locations of the targets.  This argument must be
                              specified at least once. Required. 


Optional Arguments:

--ALLELE_FRACTION <Double>    Allele fraction for which to calculate theoretical sensitivity.  This argument may be
                              specified 0 or more times. Default value: [0.001, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.3,
                              0.5]. 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--BAIT_SET_NAME,-N <String>   Bait set name. If not provided it is inferred from the filename of the bait intervals. 
                              Default value: null. 

--CLIP_OVERLAPPING_READS <Boolean>
                              True if we are to clip overlapping reads, false otherwise.  Default value: true. Possible
                              values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--COVERAGE_CAP,-covMax <Integer>
                              Parameter to set a max coverage limit for Theoretical Sensitivity calculations. Default is
                              200.  Default value: 200. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_INDELS <Boolean>    If true count inserted bases as on target and deleted bases as covered by a read.  Default
                              value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--METRIC_ACCUMULATION_LEVEL,-LEVEL <MetricAccumulationLevel>
                              The level(s) at which to accumulate metrics.  This argument may be specified 0 or more
                              times. Default value: [ALL_READS]. Possible values: {ALL_READS, SAMPLE, LIBRARY,
                              READ_GROUP} 

--MINIMUM_BASE_QUALITY,-Q <Integer>
                              Minimum base quality for a base to contribute coverage.  Default value: 20. 

--MINIMUM_MAPPING_QUALITY,-MQ <Integer>
                              Minimum mapping quality for a read to contribute coverage.  Default value: 20. 

--NEAR_DISTANCE <Integer>     The maximum distance between a read and the nearest probe/bait/amplicon for the read to be
                              considered 'near probe' and included in percent selected.  Default value: 250. 

--PER_BASE_COVERAGE <File>    An optional file to output per base coverage information to. The per-base file contains
                              one line per target base and can grow very large. It is not recommended for use with large
                              target sets.  Default value: null. 

--PER_TARGET_COVERAGE <File>  An optional file to output per target coverage information to.  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SAMPLE_SIZE <Integer>       Sample Size used for Theoretical Het Sensitivity sampling. Default is 10000.  Default
                              value: 10000. 

--THEORETICAL_SENSITIVITY_OUTPUT <File>
                              Output for Theoretical Sensitivity metrics where the allele fractions are provided by the
                              ALLELE_FRACTION argument.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument BAIT_INTERVALS was missing: Argument 'BAIT_INTERVALS' is required
```


## picard_CollectIndependentReplicateMetrics

### Tool Description
Estimates the rate of independent replication rate of reads within a bam. This tool estimates the fraction of the input reads which would be marked as duplicates but are actually biological replicates, independent observations of the data.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory


**EXPERIMENTAL FEATURE - USE AT YOUR OWN RISK**

USAGE: CollectIndependentReplicateMetrics [arguments]

Estimates the rate of independent replication rate of reads within a bam. 
<p>This tool estimates the fraction of the input reads which would be marked as duplicates but are actually biological
replicates, independent observations of the data. <p>The tools examines duplicate sets of size 2 and 3 that overlap
known heterozygous sites of the sample. The tool classifies these duplicate sets into heterogeneous and homogeneous sets
(those that contain the two alleles that are present in the variant and those that only contain one of them). From this
the toolestimates the fraction of duplicates that arose from different original molecules, i.e. independently.
<p><h4>Usage example:</h4><pre>java -jar picard.jar CollectIndependentReplicateMetrics \
I=input.bam \
V=input.vcf \
O=output.independent_replicates_metrics \
</pre> 
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input (indexed) BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            Write metrics to this file  Required. 

--VCF,-V <File>               Input VCF file  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--BARCODE_BQ <String>         Barcode Quality SAM tag.  Default value: QX. 

--BARCODE_TAG <String>        Barcode SAM tag.  Default value: RX. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--FILTER_UNPAIRED_READS,-FUR <Boolean>
                              Whether to filter unpaired reads from the input.  Default value: true. Possible values:
                              {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MATRIX_OUTPUT,-MO <File>    Write the confusion matrix (of UMIs) to this file  Default value: null. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MINIMUM_BARCODE_BQ,-MBQ <Integer>
                              minimal value for the base quality of all the bases in a molecular barcode, for it to be
                              used.  Default value: 30. 

--MINIMUM_BQ,-BQ <Integer>    minimal value for the base quality of a base to be used in the estimation.  Default value:
                              17. 

--MINIMUM_GQ,-GQ <Integer>    minimal value for the GQ field in the VCF to use variant site.  Default value: 90. 

--MINIMUM_MQ,-MQ <Integer>    minimal value for the mapping quality of the reads to be used in the estimation.  Default
                              value: 40. 

--PROGRESS_STEP_INTERVAL <Integer>
                              The interval between which progress will be displayed.  Default value: 100000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SAMPLE,-ALIAS <String>      Name of sample to look at in VCF. Can be omitted if VCF contains only one sample.  Default
                              value: null. 

--STOP_AFTER <Integer>        Number of sets to examine before stopping.  Default value: 0. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectInsertSizeMetrics

### Tool Description
Collect metrics about the insert size distribution of a paired-end library. This tool provides useful metrics for validating library construction including the insert size distribution and read orientation of paired-end libraries.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectInsertSizeMetrics [arguments]

Collect metrics about the insert size distribution of a paired-end library. This tool provides useful metrics for
validating library construction including the insert size distribution and read orientation of paired-end
libraries.</p>The expected proportions of these metrics vary depending on the type of library preparation used,
resulting from technical differences between pair-end libraries and mate-pair libraries. For a brief primer on
paired-end sequencing and mate-pair reads, see the <a
href='https://www.broadinstitute.org/gatk/guide/article?id=6327'>GATK Dictionary</a>.<p>The CollectInsertSizeMetrics
tool outputs the percentages of read pairs in each of the three orientations (FR, RF, and TANDEM) as a histogram. In
addition, the insert size distribution is output as both a histogram (.insert_size_Histogram.pdf) and as a data table
(.insert_size_metrics.txt).</p><p>Note: Metrics labeled as percentages are actually expressed as fractions!</p><h4>Usage
example:</h4><pre>java -jar picard.jar CollectInsertSizeMetrics \<br />      I=input.bam \<br />     
O=insert_size_metrics.txt \<br />      H=insert_size_histogram.pdf \<br />      M=0.5</pre>Note: If processing a small
file, set the minimum percentage option (M) to 0.5, otherwise an error may occur. <br /><br />Please see <a
href='https://broadinstitute.github.io/picard/picard-metric-definitions.html#InsertSizeMetrics'>InsertSizeMetrics</a>
for detailed explanations of each metric.<hr />
Version:3.4.0


Required Arguments:

--Histogram_FILE,-H <File>    File to write insert size Histogram chart to.  Required. 

--INPUT,-I <File>             Input SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            The file to write the output to.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true (default), then the sort order in the header file will be ignored.  Default value:
                              true. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DEVIATIONS <Double>         Generate mean, sd and plots by trimming the data down to MEDIAN +
                              DEVIATIONS*MEDIAN_ABSOLUTE_DEVIATION. This is done because insert size data typically
                              includes enough anomalous values from chimeras and other artifacts to make the mean and sd
                              grossly misleading regarding the real distribution.  Default value: 10.0. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--HISTOGRAM_WIDTH,-W <Integer>Explicitly sets the Histogram width, overriding automatic truncation of Histogram tail.
                              Also, when calculating mean and standard deviation, only bins <= Histogram_WIDTH will be
                              included.  Default value: null. 

--INCLUDE_DUPLICATES <Boolean>If true, also include reads marked as duplicates in the insert size histogram.  Default
                              value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--METRIC_ACCUMULATION_LEVEL,-LEVEL <MetricAccumulationLevel>
                              The level(s) at which to accumulate metrics.    This argument may be specified 0 or more
                              times. Default value: [ALL_READS]. Possible values: {ALL_READS, SAMPLE, LIBRARY,
                              READ_GROUP} 

--MIN_HISTOGRAM_WIDTH,-MW <Integer>
                              Minimum width of histogram plots. In the case when the histogram would otherwise
                              betruncated to a shorter range of sizes, the MIN_HISTOGRAM_WIDTH will enforce a minimum
                              range.  Default value: null. 

--MINIMUM_PCT,-M <Float>      When generating the Histogram, discard any data categories (out of FR, TANDEM, RF) that
                              have fewer than this percentage of overall reads. (Range: 0 to 1).  Default value: 0.05. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--STOP_AFTER <Long>           Stop after processing N reads, mainly for debugging.  Default value: 0. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument Histogram_FILE was missing: Argument 'Histogram_FILE' is required
```


## picard_CollectJumpingLibraryMetrics

### Tool Description
Collects high-level metrics about the presence of outward-facing (jumping) and inward-facing (non-jumping) read pairs within a SAM/BAM/CRAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectJumpingLibraryMetrics [arguments]

Collect jumping library metrics. <p>This tool collects high-level metrics about the presence of outward-facing (jumping)
and inward-facing (non-jumping) read pairs within a SAM/BAM/CRAM file.For a brief primer on jumping libraries, see the
GATK <a href='https://www.broadinstitute.org/gatk/guide/article?id=6326'>Dictionary</a></p>.<p>This program gets all
data for computation from the first read in each pair in which the mapping quality (MQ) tag is set with the mate's
mapping quality.  If the MQ tag is not set, then the program assumes that the mate's MQ is greater than or equal to
MINIMUM_MAPPING_QUALITY (default value is 0).</p> <p>Note: Metrics labeled as percentages are actually expressed as
fractions!</p><h4>Usage example:</h4><pre>java -jar picard.jar CollectJumpingLibraryMetrics \<br />      I=input.bam 
\<br />      O=jumping_metrics.txt</pre>Please see the output metrics documentation on <a
href='https://broadinstitute.github.io/picard/picard-metric-definitions.html#JumpingLibraryMetrics'>JumpingLibraryMetrics</a>
for detailed explanations of the output metrics.<hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             BAM file(s) of reads with duplicates marked  This argument must be specified at least
                              once. Required. 

--OUTPUT,-O <File>            File to which metrics should be written  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--CHIMERA_KB_MIN <Integer>    Jumps greater than or equal to the greater of this value or 2 times the mode of the
                              outward-facing pairs are considered chimeras  Default value: 100000. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MINIMUM_MAPPING_QUALITY,-MQ <Integer>
                              Mapping quality minimum cutoff  Default value: 0. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TAIL_LIMIT,-T <Integer>     When calculating mean and stdev stop when the bins in the tail of the distribution contain
                              fewer than mode/TAIL_LIMIT items  Default value: 10000. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectMultipleMetrics

### Tool Description
Collect multiple classes of metrics. This 'meta-metrics' tool runs one or more of the metrics collection modules at the same time to cut down on the time spent reading in data from input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectMultipleMetrics [arguments]

Collect multiple classes of metrics. This 'meta-metrics' tool runs one or more of the metrics collection modules at the
same time to cut down on the time spent reading in data from input files. For each PROGRAM, the tool produces outputs.
The valid values for PROGRAM and the output that would be generated by it are listed in the documentation of the PROGRAM
argument.<p>Currently all programs are run with default options and fixed output extensions, but this may become more
flexible in future. Specifying a reference sequence file is required.</p><p>Note: Metrics labeled as percentages (PCT_*)
are actually expressed as fractions!</p><h4>Usage example (all modules on by default):</h4><pre>java -jar picard.jar
CollectMultipleMetrics \<br />      I=input.bam \<br />      O=multiple_metrics \<br />      R=reference_sequence.fasta
<br /></pre><h4>Usage example (two modules only):</h4>java -jar picard.jar CollectMultipleMetrics \<br />     
I=input.bam \<br />      O=multiple_metrics \<br />      R=reference_sequence.fasta \<br />      PROGRAM=null \<br />   
PROGRAM=QualityScoreDistribution \<br />      PROGRAM=MeanQualityByCycle </pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input SAM or BAM file.  Required. 

--OUTPUT,-O <String>          Base name of output files.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true (default), then the sort order in the header file will be ignored.  Default value:
                              true. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DB_SNP <File>               VCF format dbSNP file, used to exclude regions around known polymorphisms from analysis by
                              some PROGRAMs; PROGRAMs whose CLP doesn't allow for this argument will quietly ignore it. 
                              Default value: null. 

--EXTRA_ARGUMENT <String>     extra arguments to the various tools can be specified using the following
                              format:<PROGRAM>::<ARGUMENT_AND_VALUE> where <PROGRAM> is one of the programs specified in
                              PROGRAM, and <ARGUMENT_AND_VALUE> are the argument and value that you'd like to specify as
                              you would on the command line. For example, to change the HISTOGRAM_WIDTH in
                              CollectInsertSizeMetrics to 200, use:
                              "EXTRA_ARGUMENT=CollectInsertSizeMetrics::HISTOGRAM_WIDTH=200"
                              or, in the new parser:--EXTRA_ARGUMENT "CollectInsertSizeMetrics::--HISTOGRAM_WIDTH 200"
                              (Quotes are required to avoid the shell from separating this into two arguments.) Note
                              that the following arguments cannot be modified on a per-program level: INPUT,
                              REFERENCE_SEQUENCE, ASSUME_SORTED, and STOP_AFTER. Providing them in an EXTRA_ARGUMENT
                              will _not_ result in an error, but they will be silently ignored.   This argument may be
                              specified 0 or more times. Default value: null. 

--FILE_EXTENSION,-EXT <String>Append the given file extension to all metric file names (ex.
                              OUTPUT.insert_size_metrics.EXT). None if null  Default value: null. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--IGNORE_SEQUENCE <String>    If a read maps to a sequence specified with this option, all the bases in the read are
                              counted as ignored bases.  This argument may be specified 0 or more times. Default value:
                              null. 

--INCLUDE_UNPAIRED,-UNPAIRED <Boolean>
                              Include unpaired reads in CollectSequencingArtifactMetrics. If set to true then all paired
                              reads will be included as well - MINIMUM_INSERT_SIZE and MAXIMUM_INSERT_SIZE will be
                              ignored in CollectSequencingArtifactMetrics.  Default value: false. Possible values:
                              {true, false} 

--INTERVALS <File>            An optional list of intervals to restrict analysis to. Only pertains to some of the
                              PROGRAMs. Programs whose stand-alone CLP does not have an INTERVALS argument will silently
                              ignore this argument.  Default value: null. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--METRIC_ACCUMULATION_LEVEL,-LEVEL <MetricAccumulationLevel>
                              The level(s) at which to accumulate metrics.  This argument may be specified 0 or more
                              times. Default value: [ALL_READS]. Possible values: {ALL_READS, SAMPLE, LIBRARY,
                              READ_GROUP} 

--PROGRAM <Program>           Set of metrics programs to apply during the pass through the SAM file.  This argument may
                              be specified 0 or more times. Default value: [CollectAlignmentSummaryMetrics,
                              CollectBaseDistributionByCycle, CollectInsertSizeMetrics, MeanQualityByCycle,
                              QualityScoreDistribution]. CollectAlignmentSummaryMetrics (<b>Produces a summary of
                              alignment metrics from a SAM or BAM file.</b>  Creates output with
                              ".alignment_summary_metrics, .read_length_histogram.pdf" appended to OUTPUT.)
                              CollectInsertSizeMetrics (Collect metrics about the insert size distribution of a
                              paired-end library. Creates output with ".insert_size_metrics, .insert_size_histogram.pdf"
                              appended to OUTPUT.)
                              QualityScoreDistribution (Chart the distribution of quality scores.  Creates output with
                              ".quality_distribution_metrics, .quality_distribution.pdf" appended to OUTPUT.)
                              MeanQualityByCycle (Collect mean quality by cycle.Creates output with
                              ".quality_by_cycle_metrics, .quality_by_cycle.pdf" appended to OUTPUT.)
                              CollectBaseDistributionByCycle (Chart the nucleotide distribution per cycle in a SAM or
                              BAM fileCreates output with ".base_distribution_by_cycle_metrics,
                              .base_distribution_by_cycle.pdf" appended to OUTPUT.)
                              CollectGcBiasMetrics (Collect metrics regarding GC bias. Creates output with
                              ".gc_bias.detail_metrics, .gc_bias.summary_metrics, .gc_bias.pdf" appended to OUTPUT.)
                              RnaSeqMetrics (Produces RNA alignment metrics for a SAM or BAM file.  Creates output with
                              ".rna_metrics, .rna_coverage.pdf" appended to OUTPUT.)
                              CollectSequencingArtifactMetrics (Collect metrics to quantify single-base sequencing
                              artifacts.  Creates output with ".bait_bias_detail_metrics, .bait_bias_summary_metrics,
                              .pre_adapter_detail_metrics, .pre_adapter_summary_metrics, .error_summary_metrics"
                              appended to OUTPUT.)
                              CollectQualityYieldMetrics (Collect metrics about reads that pass quality thresholds and
                              Illumina-specific filters.  Creates output with ".quality_yield_metrics" appended to
                              OUTPUT.)

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REF_FLAT <File>             Gene annotations in refFlat form.  Format described here:
                              http://genome.ucsc.edu/goldenPath/gbdDescriptionsOld.html#RefFlat  Default value: null. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--STOP_AFTER <Integer>        Stop after processing N reads, mainly for debugging.  Default value: 0. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectOxoGMetrics

### Tool Description
Collect metrics to assess oxidative artifacts. This tool collects metrics quantifying the error rate resulting from oxidative artifacts. It calculates the Phred-scaled probability that an alternate base call results from an oxidation artifact based on base context, sequencing read orientation, and characteristic low allelic frequency.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectOxoGMetrics [arguments]

Collect metrics to assess oxidative artifacts.This tool collects metrics quantifying the error rate resulting from
oxidative artifacts. For a brief primer on oxidative artifacts, see <a
href='http://gatkforums.broadinstitute.org/discussion/6328/oxog-oxidative-artifacts'>the GATK Dictionary</a>.<br /><br
/>This tool calculates the Phred-scaled probability that an alternate base call results from an oxidation artifact. This
probability score is based on base context, sequencing read orientation, and the characteristic low allelic frequency. 
Please see the following reference for an in-depth <a
href='http://nar.oxfordjournals.org/content/early/2013/01/08/nar.gks1443'>discussion</a> of the OxoG error rate. 
<p>Lower probability values implicate artifacts resulting from 8-oxoguanine, while higher probability values suggest
that an alternate base call is due to either some other type of artifact or is a real variant.</p><h4>Usage
example:</h4><pre>java -jar picard.jar CollectOxoGMetrics \<br />      I=input.bam \<br />      O=oxoG_metrics.txt \<br
/>      R=reference_sequence.fasta</pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input SAM/BAM/CRAM file for analysis.  Required. 

--OUTPUT,-O <File>            Location of output metrics file to write.  Required. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CONTEXT_SIZE <Integer>      The number of context bases to include on each side of the assayed G/C base.  Default
                              value: 1. 

--CONTEXTS <String>           The optional set of sequence contexts to restrict analysis to. If not supplied all
                              contexts are analyzed.  This argument may be specified 0 or more times. Default value:
                              null. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DB_SNP <File>               VCF format dbSNP file, used to exclude regions around known polymorphisms from analysis. 
                              Default value: null. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_NON_PF_READS,-NON_PF <Boolean>
                              Whether or not to include non-PF reads.  Default value: true. Possible values: {true,
                              false} 

--INTERVALS <File>            An optional list of intervals to restrict analysis to.  Default value: null. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MAXIMUM_INSERT_SIZE,-MAX_INS <Integer>
                              The maximum insert size for a read to be included in analysis. Set of 0 to allow unpaired
                              reads.  Default value: 600. 

--MINIMUM_INSERT_SIZE,-MIN_INS <Integer>
                              The minimum insert size for a read to be included in analysis. Set of 0 to allow unpaired
                              reads.  Default value: 60. 

--MINIMUM_MAPPING_QUALITY,-MQ <Integer>
                              The minimum mapping quality score for a base to be included in analysis.  Default value:
                              30. 

--MINIMUM_QUALITY_SCORE,-Q <Integer>
                              The minimum base quality score for a base to be included in analysis.  Default value: 20. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--STOP_AFTER <Integer>        For debugging purposes: stop after visiting this many sites with at least 1X coverage. 
                              Default value: 2147483647. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--USE_OQ <Boolean>            When available, use original quality scores for filtering.  Default value: true. Possible
                              values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectQualityYieldMetrics

### Tool Description
Collect metrics about reads that pass quality thresholds and Illumina-specific filters. This tool evaluates the overall quality of reads within a bam file containing one read group. The output indicates the total numbers of bases within a read group that pass a minimum base quality score threshold and (in the case of Illumina data) pass Illumina quality filters.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectQualityYieldMetrics [arguments]

Collect metrics about reads that pass quality thresholds and Illumina-specific filters.  This tool evaluates the overall
quality of reads within a bam file containing one read group. The output indicates the total numbers of bases within a
read group that pass a minimum base quality score threshold and (in the case of Illumina data) pass Illumina quality
filters as described in the <a href='https://www.broadinstitute.org/gatk/guide/article?id=6329'>GATK Dictionary
entry</a>. <br /><h4>Note on base quality score options</h4>If the quality score of read bases has been modified in a
previous data processing step such as <a href='https://www.broadinstitute.org/gatk/guide/article?id=44'>GATK Base
Recalibration</a> and an OQ tag is available, this tool can be set to use the OQ value instead of the primary quality
value for the evaluation. <br /><br />Note that the default behaviour of this program changed as of November 6th 2015 to
no longer include secondary and supplemental alignments in the computation. <br /><h4>Usage Example:</h4><pre>java -jar
picard.jar CollectQualityYieldMetrics \<br />       I=input.bam \<br />       O=quality_yield_metrics.txt \<br
/></pre>Please see <a
href='https://broadinstitute.github.io/picard/picard-metric-definitions.html#CollectQualityYieldMetrics.QualityYieldMetrics'>the
QualityYieldMetrics documentation</a> for details and explanations of the output metrics.<hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            The file to write the output to.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true (default), then the sort order in the header file will be ignored.  Default value:
                              true. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--FLOW_MODE <Boolean>         Obsolete. FLOW_MODE support now provided by CollectQualityYieldMetricsFlow  Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_SECONDARY_ALIGNMENTS <Boolean>
                              If true, include bases from secondary alignments in metrics. Setting to true may cause
                              double-counting of bases if there are secondary alignments in the input file.  Default
                              value: false. Possible values: {true, false} 

--INCLUDE_SUPPLEMENTAL_ALIGNMENTS <Boolean>
                              If true, include bases from supplemental alignments in metrics. Setting to true may cause
                              double-counting of bases if there are supplemental alignments in the input file.  Default
                              value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--STOP_AFTER <Long>           Stop after processing N reads, mainly for debugging.  Default value: 0. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--USE_ORIGINAL_QUALITIES,-OQ <Boolean>
                              If available in the OQ tag, use the original quality scores as inputs instead of the
                              quality scores in the QUAL field.  Default value: true. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectQualityYieldMetricsFlow

### Tool Description
Collect metrics about reads that pass quality thresholds from flow based read files. This tool evaluates the overall quality of reads within a bam file containing one read group. The output indicates the total numbers of flows within a read group that pass a minimum base quality score threshold

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory


**EXPERIMENTAL FEATURE - USE AT YOUR OWN RISK**

USAGE: CollectQualityYieldMetricsFlow [arguments]

Collect metrics about reads that pass quality thresholds from flow based read files.  This tool evaluates the overall
quality of reads within a bam file containing one read group. The output indicates the total numbers of flows within a
read group that pass a minimum base quality score threshold <h4>Usage Example:</h4><pre>java -jar picard.jar
CollectQualityYieldMetricsFlow \<br />       I=input.bam \<br />       O=quality_yield_metrics.txt \<br /></pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            The file to write the output to.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true (default), then the sort order in the header file will be ignored.  Default value:
                              true. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_BQ_HISTOGRAM <Boolean>
                              Determines whether to include the flow quality histogram in the metrics file.  Default
                              value: false. Possible values: {true, false} 

--INCLUDE_SECONDARY_ALIGNMENTS <Boolean>
                              If true, include bases from secondary alignments in metrics. Setting to true may cause
                              double-counting of bases if there are secondary alignments in the input file.  Default
                              value: false. Possible values: {true, false} 

--INCLUDE_SUPPLEMENTAL_ALIGNMENTS <Boolean>
                              If true, include bases from supplemental alignments in metrics. Setting to true may cause
                              double-counting of bases if there are supplemental alignments in the input file.  Default
                              value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--STOP_AFTER <Long>           Stop after processing N reads, mainly for debugging.  Default value: 0. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--flow-fill-empty-bins-value <Double>
                              Value to fill the zeros of the matrix with  Default value: 0.0. 

--flow-ignore-t0-tag <Boolean>Ignore t0 tag in the read when create flow matrix (arcane/obsolete)  Default value: false.
                              Possible values: {true, false} 

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectQualityYieldMetricsSNVQ

### Tool Description
Collect SNVQ metrics about reads that pass quality thresholds and other filters (such as vendor fail, etc). This tool evaluates the overall SNVQ quality of reads within a bam file containing one read group.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectQualityYieldMetricsSNVQ [arguments]

Collect SNVQ metrics about reads that pass quality thresholds and other filters (such as vendor fail, etc).  This tool
evaluates the overall SNVQ quality of reads within a bam file containing one read group. The output indicates the total
numbers of bases within a read group that pass a minimum base quality score threshold and (in the case of Illumina data)
pass Illumina quality filters as described in the <a
href='https://www.broadinstitute.org/gatk/guide/article?id=6329'>GATK Dictionary entry</a>. <br /><h4>Usage
Example:</h4><pre>java -jar picard.jar CollectSNVQualityYieldMetrics \<br />       I=input.bam \<br />      
O=quality_yield_metrics.txt \<br /></pre>Please see <a
href='https://broadinstitute.github.io/picard/picard-metric-definitions.html#CollectSNVQualityYieldMetrics.QualityYieldMetrics'>the
QualityYieldMetrics documentation</a> for details and explanations of the output metrics.<hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            The file to write the output to.  Required. 


Optional Arguments:

--ALTERNATE_QUALITY_ATTRIBUTE,-AQA <String>
                              Use an alternative  tag instead of base quality (QUAL) scores   Default value: null. 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true (default), then the sort order in the header file will be ignored.  Default value:
                              true. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_BQ_HISTOGRAM <Boolean>
                              Determines whether to include the base quality histogram in the metrics file.  Default
                              value: false. Possible values: {true, false} 

--INCLUDE_SECONDARY_ALIGNMENTS <Boolean>
                              If true, include bases from secondary alignments in metrics. Setting to true may cause
                              double-counting of bases if there are secondary alignments in the input file.  Default
                              value: false. Possible values: {true, false} 

--INCLUDE_SUPPLEMENTAL_ALIGNMENTS <Boolean>
                              If true, include bases from supplemental alignments in metrics. Setting to true may cause
                              double-counting of bases if there are supplemental alignments in the input file.  Default
                              value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--STOP_AFTER <Long>           Stop after processing N reads, mainly for debugging.  Default value: 0. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectRawWgsMetrics

### Tool Description
Collect whole genome sequencing-related metrics. This tool computes metrics that are useful for evaluating coverage and performance of whole genome sequencing experiments. These metrics include the percentages of reads that pass minimal base- and mapping- quality filters as well as coverage (read-depth) levels.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectRawWgsMetrics [arguments]

Collect whole genome sequencing-related metrics.  This tool computes metrics that are useful for evaluating coverage and
performance of whole genome sequencing experiments. These metrics include the percentages of reads that pass minimal
base- and mapping- quality filters as well as coverage (read-depth) levels. <br /><br />  The histogram output is
optional and for a given run, displays two separate outputs on the y-axis while using a single set of values for the
x-axis.  Specifically, the first column in the histogram table (x-axis) is labeled 'coverage' and represents different
possible coverage depths.  However, it also represents the range of values for the base quality scores and thus should
probably be labeled 'sequence depth and base quality scores'. The second and third columns (y-axes) correspond to the
numbers of bases at a specific sequence depth 'count' and the numbers of bases at a particular base quality score
'baseq_count' respectively.<br /><br />Although similar to the CollectWgsMetrics tool, the default thresholds for
CollectRawWgsMetrics are less stringent.  For example, the CollectRawWgsMetrics have base and mapping quality score
thresholds set to '3' and '0' respectively, while the CollectWgsMetrics tool has the default threshold values set to
'20' (at time of writing).  Nevertheless, both tools enable the user to input specific threshold values.<p>Note: Metrics
labeled as percentages are actually expressed as fractions!</p><h4>Usage example:</h4><pre>java -jar picard.jar
CollectRawWgsMetrics \<br />      I=input.bam \<br />      O=output_raw_wgs_metrics.txt \<br />      R=reference.fasta
\<br />      INCLUDE_BQ_HISTOGRAM=true</pre><hr />Please see <a
href='https://broadinstitute.github.io/picard/picard-metric-definitions.html#CollectWgsMetrics.WgsMetrics'>the
WgsMetrics documentation</a> for detailed explanations of the output metrics.<hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            Output metrics file.  Required. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Required. 


Optional Arguments:

--ALLELE_FRACTION <Double>    Allele fraction for which to calculate theoretical sensitivity.  This argument may be
                              specified 0 or more times. Default value: [0.001, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.3,
                              0.5]. 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--COUNT_UNPAIRED <Boolean>    If true, count unpaired reads, and paired reads with one end unmapped  Default value:
                              false. Possible values: {true, false} 

--COVERAGE_CAP,-CAP <Integer> Treat positions with coverage exceeding this value as if they had coverage at this value
                              (but calculate the difference for PCT_EXC_CAPPED).  Default value: 100000. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_BQ_HISTOGRAM <Boolean>
                              Determines whether to include the base quality histogram in the metrics file.  Default
                              value: false. Possible values: {true, false} 

--INTERVALS <File>            An interval list file that contains the positions to restrict the assessment. Please note
                              that all bases of reads that overlap these intervals will be considered, even if some of
                              those bases extend beyond the boundaries of the interval. The ideal use case for this
                              argument is to use it to restrict the calculation to a subset of (whole) contigs.  Default
                              value: null. 

--LOCUS_ACCUMULATION_CAP <Integer>
                              At positions with coverage exceeding this value, completely ignore reads that accumulate
                              beyond this value (so that they will not be considered for PCT_EXC_CAPPED).  Used to keep
                              memory consumption in check, but could create bias if set too low  Default value: 200000. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MINIMUM_BASE_QUALITY,-Q <Integer>
                              Minimum base quality for a base to contribute coverage. N bases will be treated as having
                              a base quality of negative infinity and will therefore be excluded from coverage
                              regardless of the value of this parameter.  Default value: 3. 

--MINIMUM_MAPPING_QUALITY,-MQ <Integer>
                              Minimum mapping quality for a read to contribute coverage.  Default value: 0. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_LENGTH <Integer>       Average read length in the file. Default is 150.  Default value: 150. 

--SAMPLE_SIZE <Integer>       Sample Size used for Theoretical Het Sensitivity sampling. Default is 10000.  Default
                              value: 10000. 

--STOP_AFTER <Long>           For debugging purposes, stop after processing this many genomic bases.  Default value: -1.

--THEORETICAL_SENSITIVITY_OUTPUT <File>
                              Output for Theoretical Sensitivity metrics.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_FAST_ALGORITHM <Boolean>If true, fast algorithm is used.  Default value: false. Possible values: {true, false} 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectRnaSeqMetrics

### Tool Description
Produces RNA alignment metrics for a SAM or BAM file. This tool takes a SAM/BAM file containing the aligned reads from an RNAseq experiment and produces metrics describing the distribution of the bases within the transcripts.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectRnaSeqMetrics [arguments]

Produces RNA alignment metrics for a SAM or BAM file.  <p>This tool takes a SAM/BAM file containing the aligned reads
from an RNAseq experiment and produces metrics describing the distribution of the bases within the transcripts.  It
calculates the total numbers and the fractions of nucleotides within specific genomic regions including untranslated
regions (UTRs), introns, intergenic sequences (between discrete genes), and peptide-coding sequences (exons). This tool
also determines the numbers of bases that pass quality filters that are specific to Illumina data (PF_BASES).  For more
information please see the corresponding GATK <a
href='https://www.broadinstitute.org/gatk/guide/article?id=6329'>Dictionary</a> entry.</p><p>Other metrics include the
median coverage (depth), the ratios of 5 prime /3 prime-biases, and the numbers of reads with the correct/incorrect
strand designation. The 5 prime /3 prime-bias results from errors introduced by reverse transcriptase enzymes during
library construction, ultimately leading to the over-representation of either the 5 prime or 3 prime ends of
transcripts.  Please see the CollectRnaSeqMetrics <a
href='http://broadinstitute.github.io/picard/picard-metric-definitions.html#RnaSeqMetrics'>definitions</a> for details
on how these biases are calculated. </p><p>The sequence input must be a valid SAM/BAM file containing RNAseq data
aligned by an RNAseq-aware genome aligner such a <a href='http://github.com/alexdobin/STAR'>STAR</a> or <a
href='http://ccb.jhu.edu/software/tophat/index.shtml'>TopHat</a>. The tool also requires a REF_FLAT file, a
tab-delimited file containing information about the location of RNA transcripts, exon start and stop sites, etc. For an
example refFlat file for GRCh38, see refFlat.txt.gz at <a
href='http://hgdownload.cse.ucsc.edu/goldenPath/hg38/database'>http://hgdownload.cse.ucsc.edu/goldenPath/hg38/database</a>.
The first five lines of the tab-limited text file appear as
follows.</p><pre>DDX11L1	NR_046018	chr1	+	11873	14409	14409	14409	3	11873,12612,13220,	12227,12721,14409,WASH7P	NR_024540	chr1	-	14361	29370	29370	29370	11	14361,14969,15795,16606,16857,17232,17605,17914,18267,24737,29320,	14829,15038,15947,16765,17055,17368,17742,18061,18366,24891,29370,DLGAP2-AS1	NR_103863	chr8_KI270926v1_alt	-	33083	35050	35050	35050	3	33083,33761,35028,	33281,33899,35050,MIR570	NR_030296	chr3	+	195699400	195699497	195699497	195699497	1	195699400,	195699497,MIR548A3	NR_030330	chr8	-	104484368	104484465	104484465	104484465	1	104484368,	104484465,</pre><p>Note:
Metrics labeled as percentages are actually expressed as fractions!</p><h4>Usage example:</h4><pre>java -jar picard.jar
CollectRnaSeqMetrics \<br />      I=input.bam \<br />      O=output.RNA_Metrics \<br />      REF_FLAT=ref_flat.txt \<br
/>      STRAND=SECOND_READ_TRANSCRIPTION_STRAND \<br />      RIBOSOMAL_INTERVALS=ribosomal.interval_list</pre>Please see
the CollectRnaSeqMetrics <a
href='http://broadinstitute.github.io/picard/picard-metric-definitions.html#RnaSeqMetrics'>definitions</a> for a
complete description of the metrics produced by this tool.<hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            The file to write the output to.  Required. 

--REF_FLAT <File>             Gene annotations in refFlat form.  Format described here:
                              http://genome.ucsc.edu/goldenPath/gbdDescriptionsOld.html#RefFlat  Required. 

--STRAND_SPECIFICITY,-STRAND <StrandSpecificity>
                              For strand-specific library prep. For unpaired reads, use FIRST_READ_TRANSCRIPTION_STRAND
                              if the reads are expected to be on the transcription strand.  Required. Possible values:
                              {NONE, FIRST_READ_TRANSCRIPTION_STRAND, SECOND_READ_TRANSCRIPTION_STRAND} 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true (default), then the sort order in the header file will be ignored.  Default value:
                              true. Possible values: {true, false} 

--CHART_OUTPUT,-CHART <File>  The PDF file to write out a plot of normalized position vs. coverage.  Default value:
                              null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--END_BIAS_BASES <Integer>    The distance into a transcript over which 5' and 3' bias is calculated.  Default value:
                              100. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--IGNORE_SEQUENCE <String>    If a read maps to a sequence specified with this option, all the bases in the read are
                              counted as ignored bases. These reads are not counted towards any metrics, except for the
                              PF_BASES field.  This argument may be specified 0 or more times. Default value: null. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--METRIC_ACCUMULATION_LEVEL,-LEVEL <MetricAccumulationLevel>
                              The level(s) at which to accumulate metrics.    This argument may be specified 0 or more
                              times. Default value: [ALL_READS]. Possible values: {ALL_READS, SAMPLE, LIBRARY,
                              READ_GROUP} 

--MINIMUM_LENGTH <Integer>    When calculating coverage based values (e.g. CV of coverage) only use transcripts of this
                              length or greater.  Default value: 500. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--RIBOSOMAL_INTERVALS <File>  Location of rRNA sequences in genome, in interval_list format.  If not specified no bases
                              will be identified as being ribosomal.  Format described <a
                              href="http://samtools.github.io/htsjdk/javadoc/htsjdk/htsjdk/samtools/util/IntervalList.html">here</a>:
                              Default value: null. 

--RRNA_FRAGMENT_PERCENTAGE <Double>
                              This percentage of the length of a fragment must overlap one of the ribosomal intervals
                              for a read or read pair to be considered rRNA.  Default value: 0.8. 

--STOP_AFTER <Long>           Stop after processing N reads, mainly for debugging.  Default value: 0. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument REF_FLAT was missing: Argument 'REF_FLAT' is required
```


## picard_CollectRrbsMetrics

### Tool Description
Collects metrics from reduced representation bisulfite sequencing (Rrbs) data. This tool uses reduced representation bisulfite sequencing (Rrbs) data to determine cytosine methylation status across all reads of a genomic DNA sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectRrbsMetrics [arguments]

<b>Collects metrics from reduced representation bisulfite sequencing (Rrbs) data.</b>  <p>This tool uses reduced
representation bisulfite sequencing (Rrbs) data to determine cytosine methylation status across all reads of a genomic
DNA sequence.  For a primer on bisulfite sequencing and cytosine methylation, please see the corresponding <a
href='https://www.broadinstitute.org/gatk/guide/article?id=6330'>GATK Dictionary entry</a>. </p><p>Briefly, bisulfite
reduction converts un-methylated cytosine (C) to uracil (U) bases.  Methylated sites are not converted because they are
resistant to bisulfite reduction.  Subsequent to PCR amplification of the reaction products, bisulfite reduction
manifests as [C -> T (+ strand) or G -> A (- strand)] base conversions.  Thus, conversion rates can be calculated from
the reads as follows: [CR = converted/(converted + unconverted)]. Since methylated cytosines are protected against
Rrbs-mediated conversion, the methylation rate (MR) is as follows:[MR = unconverted/(converted + unconverted) = (1 -
CR)].</p><p>The CpG CollectRrbsMetrics tool outputs three files including summary and detail metrics tables as well as a
PDF file containing four graphs. These graphs are derived from the summary table and include a comparison of conversion
rates for both CpG and non-CpG sites, the distribution of total numbers of CpG sites as a function of the CpG conversion
rates, the distribution of CpG sites by the level of read coverage (depth), and the numbers of reads discarded resulting
from either exceeding the mismatch rate or size (too short).  The detailed metrics table includes the coordinates of all
of the CpG sites for the experiment as well as the conversion rates observed for each site.</p><h4>Usage
example:</h4><pre>java -jar picard.jar CollectRrbsMetrics \<br />      R=reference_sequence.fasta \<br />     
I=input.bam \<br />      M=basename_for_metrics_files</pre><p>Please see the CollectRrbsMetrics <a
href='https://broadinstitute.github.io/picard/picard-metric-definitions.html#RrbsCpgDetailMetrics'>definitions</a> for a
complete description of both the detail and summary metrics produced by this tool.</p><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The SAM/BAM/CRAM file containing aligned reads. Must be coordinate sorted  Required. 

--METRICS_FILE_PREFIX,-M <String>
                              Base name for output files  Required. 

--REFERENCE,-R <File>         The reference sequence fasta file  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true, assume that the input file is coordinate sorted even if the header says
                              otherwise.  Default value: false. Possible values: {true, false} 

--C_QUALITY_THRESHOLD <Integer>
                              Threshold for base quality of a C base before it is considered  Default value: 20. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_MISMATCH_RATE <Double>  Maximum percentage of mismatches in a read for it to be considered, with a range of 0-1 
                              Default value: 0.1. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--METRIC_ACCUMULATION_LEVEL,-LEVEL <MetricAccumulationLevel>
                              The level(s) at which to accumulate metrics.    This argument may be specified 0 or more
                              times. Default value: [ALL_READS]. Possible values: {ALL_READS, SAMPLE, LIBRARY,
                              READ_GROUP} 

--MINIMUM_READ_LENGTH <Integer>
                              Minimum read length  Default value: 5. 

--NEXT_BASE_QUALITY_THRESHOLD <Integer>
                              Threshold for quality of a base next to a C before the C base is considered  Default
                              value: 10. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--SEQUENCE_NAMES <String>     Set of sequence names to consider, if not specified all sequences will be used  This
                              argument may be specified 0 or more times. Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectSamErrorMetrics

### Tool Description
Program to collect error metrics on bases stratified in various ways. To estimate the error rate the tool assumes that all differences from the reference are errors. For this to be a reasonable assumption the tool needs to know the sites at which the sample is actually polymorphic and a confidence interval where the user is relatively certain that the polymorphic sites are known and accurate. These two inputs are provided as a VCF and INTERVALS.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectSamErrorMetrics [arguments]

Program to collect error metrics on bases stratified in various ways.
<p>Sequencing errors come in different 'flavors'. For example, some occur during sequencing while others happen during
library construction, prior to the sequencing. They may be correlated with various aspect of the sequencing experiment:
position in the read, base context, length of insert and so on.
<p>This program collects two different kinds of error metrics (one which attempts to distinguish between pre- and post-
sequencer errors, and on which doesn't) and a collation of 'stratifiers' each of which assigns bases into various bins.
The stratifiers can be used together to generate a composite stratification. <p>For example:<p>The BASE_QUALITY
stratifier will place bases in bins according to their declared base quality. The READ_ORDINALITY stratifier will place
bases in one of two bins depending on whether their read is 'first' or 'second'. One could generate a composite
stratifier BASE_QUALITY:READ_ORDINALITY which will do both stratifications as the same time. 
<p>The resulting metric file will be named according to a provided prefix and a suffix which is generated  automatically
according to the error metric. The tool can collect multiple metrics in a single pass and there should be hardly any
performance loss when specifying multiple metrics at the same time; the default includes a large collection of metrics. 
<p>To estimate the error rate the tool assumes that all differences from the reference are errors. For this to be a
reasonable assumption the tool needs to know the sites at which the sample is actually polymorphic and a confidence
interval where the user is relatively certain that the polymorphic sites are known and accurate. These two inputs are
provided as a VCF and INTERVALS. The program will only process sites that are in the intersection of the interval lists
in the INTERVALS argument as long as they are not polymorphic in the VCF.


Version:3.4.0


Required Arguments:

--INPUT,-I <String>           Input SAM or BAM file.  Required. 

--OUTPUT,-O <File>            Base name for output files. Actual file names will be generated from the basename and
                              suffixes from the ERROR and STRATIFIER by adding a '.' and then
                              error_by_stratifier[_and_stratifier]* where 'error' is ERROR's extension, and 'stratifier'
                              is STRATIFIER's suffix. For example, an ERROR_METRIC of ERROR:BASE_QUALITY:GC_CONTENT will
                              produce an extension '.error_by_base_quality_and_gc'. The suffixes can be found in the
                              documentation for ERROR_VALUE and SUFFIX_VALUE.  Required. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--ERROR_METRICS <String>      Errors to collect in the form of "ERROR(:STRATIFIER)*". To see the values available for
                              ERROR and STRATIFIER look at the documentation for the arguments ERROR_VALUE and
                              STRATIFIER_VALUE.  This argument may be specified 0 or more times. Default value: [ERROR,
                              ERROR:BASE_QUALITY, ERROR:INSERT_LENGTH, ERROR:GC_CONTENT, ERROR:READ_DIRECTION,
                              ERROR:PAIR_ORIENTATION, ERROR:HOMOPOLYMER, ERROR:BINNED_HOMOPOLYMER, ERROR:CYCLE,
                              ERROR:READ_ORDINALITY, ERROR:READ_ORDINALITY:CYCLE, ERROR:READ_ORDINALITY:HOMOPOLYMER,
                              ERROR:READ_ORDINALITY:GC_CONTENT, ERROR:READ_ORDINALITY:PRE_DINUC, ERROR:MAPPING_QUALITY,
                              ERROR:READ_GROUP, ERROR:MISMATCHES_IN_READ, ERROR:ONE_BASE_PADDED_CONTEXT,
                              OVERLAPPING_ERROR, OVERLAPPING_ERROR:BASE_QUALITY, OVERLAPPING_ERROR:INSERT_LENGTH,
                              OVERLAPPING_ERROR:READ_ORDINALITY, OVERLAPPING_ERROR:READ_ORDINALITY:CYCLE,
                              OVERLAPPING_ERROR:READ_ORDINALITY:HOMOPOLYMER,
                              OVERLAPPING_ERROR:READ_ORDINALITY:GC_CONTENT, INDEL_ERROR]. 

--ERROR_VALUE <ErrorType>     A fake argument used to show the options of ERROR (in ERROR_METRICS).  Default value:
                              null. ERROR (Collects the average (SNP) error at the bases provided. Suffix is: 'error'.)
                              OVERLAPPING_ERROR (Only considers bases from the overlapping parts of reads from the same
                              template. For those bases, it calculates the error that can be attributable to
                              pre-sequencing, versus during-sequencing. Suffix is: 'overlapping_error'.)
                              INDEL_ERROR (Collects insertion and deletion errors at the bases provided. Suffix is:
                              'indel_error'.)

--FILE_EXTENSION,-EXT <String>Append the given file extension to all metric file names (ex.
                              OUTPUT.insert_size_metrics.EXT). No extension by default.  Default value: . 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INTERVAL_ITERATOR <Boolean> Iterate through the file assuming it consists of a pre-created subset interval of the full
                              genome.  This enables fast processing of files with reads at disparate parts of the
                              genome.  Requires that the provided VCF file is indexed.   Default value: false. Possible
                              values: {true, false} 

--INTERVALS,-L <File>         Region(s) to limit analysis to. Supported formats are VCF or interval_list. Will
                              *intersect* inputs if multiple are given. When this argument is supplied, the VCF provided
                              must be *indexed*.  This argument may be specified 0 or more times. Default value: null. 

--LOCATION_BIN_SIZE,-LBS <Integer>
                              Size of location bins. Used by the FLOWCELL_X and FLOWCELL_Y stratifiers  Default value:
                              2500. 

--LONG_HOMOPOLYMER,-LH <Integer>
                              Shortest homopolymer which is considered long.  Used by the BINNED_HOMOPOLYMER stratifier.
                              Default value: 6. 

--MAX_LOCI,-MAX <Long>        Maximum number of loci to process (or unlimited if 0).  Default value: 0. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MIN_BASE_Q,-BQ <Integer>    Minimum base quality to include base.  Default value: 20. 

--MIN_MAPPING_Q,-MQ <Integer> Minimum mapping quality to include read.  Default value: 20. 

--PRIOR_Q,-PE <Integer>       The prior error, in phred-scale (used for calculating empirical error rates).  Default
                              value: 30. 

--PROBABILITY,-P <Double>     The probability of selecting a locus for analysis (for downsampling).  Default value: 1.0.

--PROGRESS_STEP_INTERVAL <Integer>
                              The interval between which progress will be displayed.  Default value: 100000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--STRATIFIER_VALUE <Stratifier>
                              A fake argument used to show the options of STRATIFIER (in ERROR_METRICS).  Default value:
                              null. ALL (Puts all bases in the same stratum. Suffix is 'all'.)
                              GC_CONTENT (The GC-content of the read. Suffix is 'gc'.)
                              READ_ORDINALITY (The read ordinality (i.e. first or second). Suffix is 'read_ordinality'.)
                              READ_BASE (the base in the original reading direction. Suffix is 'read_base'.)
                              READ_DIRECTION (The alignment direction of the read (encoded as + or -). Suffix is
                              'read_direction'.)
                              PAIR_ORIENTATION (The read-pair's orientation (encoded as '[FR]1[FR]2'). Suffix is
                              'pair_orientation'.)
                              PAIR_PROPERNESS (The properness of the read-pair's alignment. Looks for indications of
                              chimerism. Suffix is 'pair_proper'.)
                              REFERENCE_BASE (The reference base in the read's direction. Suffix is 'ref_base'.)
                              PRE_DINUC (The read base at the previous cycle, and the current reference base. Suffix is
                              'pre_dinuc'.)
                              POST_DINUC (The read base at the subsequent cycle, and the current reference base. Suffix
                              is 'post_dinuc'.)
                              HOMOPOLYMER_LENGTH (The length of homopolymer the base is part of (only accounts for bases
                              that were read prior to the current base). Suffix is 'homopolymer_length'.)
                              HOMOPOLYMER (The length of homopolymer, the base that the homopolymer is comprised of, and
                              the reference base. Suffix is 'homopolymer_and_following_ref_base'.)
                              BINNED_HOMOPOLYMER (The scale of homopolymer (long or short), the base that the
                              homopolymer is comprised of, and the reference base. Suffix is
                              'binned_length_homopolymer_and_following_ref_base'.)
                              FLOWCELL_TILE (The flowcell and tile where the base was read (taken from the read name).
                              Suffix is 'tile'.)
                              FLOWCELL_Y (The y-coordinate of the read (taken from the read name) Suffix is 'y'.)
                              FLOWCELL_X (The x-coordinate of the read (taken from the read name) Suffix is 'x'.)
                              READ_GROUP (The read-group id of the read. Suffix is 'read_group'.)
                              CYCLE (The machine cycle during which the base was read. Suffix is 'cycle'.)
                              BINNED_CYCLE (The binned machine cycle. Similar to CYCLE, but binned into 5 evenly spaced
                              ranges across the size of the read.  This stratifier may produce confusing results when
                              used on datasets with variable sized reads. Suffix is 'binned_cycle'.)
                              SOFT_CLIPS (The number of softclipped bases the read has. Suffix is 'softclipped_bases'.)
                              INSERT_LENGTH (The insert-size they came from (taken from the TLEN field.) Suffix is
                              'insert_length'.)
                              BASE_QUALITY (The base quality. Suffix is 'base_quality'.)
                              MAPPING_QUALITY (The read's mapping quality. Suffix is 'mapping_quality'.)
                              MISMATCHES_IN_READ (The number of bases in the read that mismatch the reference, excluding
                              the current base.  This stratifier requires the NM tag. Suffix is 'mismatches_in_read'.)
                              ONE_BASE_PADDED_CONTEXT (The current reference base and a one base padded region from the
                              read resulting in a 3-base context. Suffix is 'one_base_padded_context'.)
                              TWO_BASE_PADDED_CONTEXT (The current reference base and a two base padded region from the
                              read resulting in a 5-base context. Suffix is 'two_base_padded_context'.)
                              CONSENSUS (Whether or not duplicate reads were used to form a consensus read.  This
                              stratifier makes use of the aD, bD, and cD tags for duplex consensus reads.  If the reads
                              are single index consensus, only the cD tags are used. Suffix is 'consensus'.)
                              NS_IN_READ (The number of Ns in the read. Suffix is 'ns_in_read'.)
                              INSERTIONS_IN_READ (The number of Insertions in the read cigar. Suffix is
                              'cigar_elements_I_in_read'.)
                              DELETIONS_IN_READ (The number of Deletions in the read cigar. Suffix is
                              'cigar_elements_D_in_read'.)
                              INDELS_IN_READ (The number of INDELs in the read cigar. Suffix is 'indels_in_read'.)
                              INDEL_LENGTH (The number of bases in an indel Suffix is 'indel_length'.)

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VCF,-V <String>             VCF of known variation for sample. program will skip over polymorphic sites in this VCF
                              and avoid collecting data on these loci.  Default value: null. 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectSequencingArtifactMetrics

### Tool Description
Collect metrics to quantify single-base sequencing artifacts. This tool examines two sources of sequencing errors associated with hybrid selection protocols: pre-adapter and bait-bias.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectSequencingArtifactMetrics [arguments]

Collect metrics to quantify single-base sequencing artifacts.  <p>This tool examines two sources of sequencing errors
associated with hybrid selection protocols.  These errors are divided into two broad categories, pre-adapter and
bait-bias.  Pre-adapter errors can arise from laboratory manipulations of a nucleic acid sample e.g. shearing and occur
prior to the ligation of adapters for PCR amplification (hence the name pre-adapter).  </p><p>Bait-bias artifacts occur
during or after the target selection step, and correlate with substitution rates that are 'biased', or higher for sites
having one base on the reference/positive strand relative to sites having the complementary base on that strand.  For
example, during the target selection step, a (G>T) artifact might result in a higher substitution rate at sites with a G
on the positive strand (and C on the negative), relative to sites with the flip (C positive)/(G negative).  This is
known as the 'G-Ref' artifact. </p><p>For additional information on these types of artifacts, please see the
corresponding GATK dictionary entries on <a
href='https://www.broadinstitute.org/gatk/guide/article?id=6333'>bait-bias</a> and <a
href='https://www.broadinstitute.org/gatk/guide/article?id=6332'>pre-adapter artifacts</a>.</p><p>This tool produces
four files; summary and detail metrics files for both pre-adapter and bait-bias artifacts. The detailed metrics show the
error rates for each type of base substitution within every possible triplet base configuration.  Error rates associated
with these substitutions are Phred-scaled and provided as quality scores, the lower the value, the more likely it is
that an alternate base call is due to an artifact. The summary metrics provide likelihood information on the
'worst-case' errors. </p><h4>Usage example:</h4><pre>java -jar picard.jar CollectSequencingArtifactMetrics \<br />    
I=input.bam \<br />     O=artifact_metrics.txt \<br />     R=reference_sequence.fasta</pre>Please see the metrics at the
following links <a
href='http://broadinstitute.github.io/picard/picard-metric-definitions.html#SequencingArtifactMetrics.PreAdapterDetailMetrics'>PreAdapterDetailMetrics</a>,
<a
href='http://broadinstitute.github.io/picard/picard-metric-definitions.html#SequencingArtifactMetrics.PreAdapterSummaryMetrics'>PreAdapterSummaryMetrics</a>,
<a
href='http://broadinstitute.github.io/picard/picard-metric-definitions.html#SequencingArtifactMetrics.BaitBiasDetailMetrics'>BaitBiasDetailMetrics</a>,
and <a
href='http://broadinstitute.github.io/picard/picard-metric-definitions.html#SequencingArtifactMetrics.BaitBiasSummaryMetrics'>BaitBiasSummaryMetrics</a>
for complete descriptions of the output metrics produced by this tool. <hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            The file to write the output to.  Required. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true (default), then the sort order in the header file will be ignored.  Default value:
                              true. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CONTEXT_SIZE <Integer>      The number of context bases to include on each side of the assayed base.  Default value:
                              1. 

--CONTEXTS_TO_PRINT <String>  If specified, only print results for these contexts in the detail metrics output. However,
                              the summary metrics output will still take all contexts into consideration.  This argument
                              may be specified 0 or more times. Default value: null. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DB_SNP <File>               VCF format dbSNP file, used to exclude regions around known polymorphisms from analysis. 
                              Default value: null. 

--FILE_EXTENSION,-EXT <String>Append the given file extension to all metric file names (ex.
                              OUTPUT.pre_adapter_summary_metrics.EXT). None if null  Default value: null. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_DUPLICATES,-DUPES <Boolean>
                              Include duplicate reads. If set to true then all reads flagged as duplicates will be
                              included as well.  Default value: false. Possible values: {true, false} 

--INCLUDE_NON_PF_READS,-NON_PF <Boolean>
                              Whether or not to include non-PF reads.  Default value: false. Possible values: {true,
                              false} 

--INCLUDE_UNPAIRED,-UNPAIRED <Boolean>
                              Include unpaired reads. If set to true then all paired reads will be included as well -
                              MINIMUM_INSERT_SIZE and MAXIMUM_INSERT_SIZE will be ignored.  Default value: false.
                              Possible values: {true, false} 

--INTERVALS <File>            An optional list of intervals to restrict analysis to.  Default value: null. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MAXIMUM_INSERT_SIZE,-MAX_INS <Integer>
                              The maximum insert size for a read to be included in analysis. Set to 0 to have no
                              maximum.  Default value: 600. 

--MINIMUM_INSERT_SIZE,-MIN_INS <Integer>
                              The minimum insert size for a read to be included in analysis.  Default value: 60. 

--MINIMUM_MAPPING_QUALITY,-MQ <Integer>
                              The minimum mapping quality score for a base to be included in analysis.  Default value:
                              30. 

--MINIMUM_QUALITY_SCORE,-Q <Integer>
                              The minimum base quality score for a base to be included in analysis.  Default value: 20. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--STOP_AFTER <Long>           Stop after processing N reads, mainly for debugging.  Default value: 0. 

--TANDEM_READS,-TANDEM <Boolean>
                              Set to true if mate pairs are being sequenced from the same strand, i.e. they're expected
                              to face the same direction.  Default value: false. Possible values: {true, false} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--USE_OQ <Boolean>            When available, use original quality scores for filtering.  Default value: true. Possible
                              values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectTargetedPcrMetrics

### Tool Description
Calculate PCR-related metrics from targeted sequencing data. This tool calculates a set of PCR-related metrics from an aligned SAM or BAM file containing targeted sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectTargetedPcrMetrics [arguments]

Calculate PCR-related metrics from targeted sequencing data. <p>This tool calculates a set of PCR-related metrics from
an aligned SAM or BAM file containing targeted sequencing data. It is appropriate for data produced with multiple
small-target technologies including exome sequencing an custom amplicon panels such as the Illumina <a
href='http://www.illumina.com/content/dam/illumina-marketing/documents/products/datasheets/datasheet_truseq_custom_amplicon.pdf'>TruSeq
Custom Amplicon (TSCA)</a> kit.</p><p>If a reference sequence is provided, AT/GC dropout metrics will be calculated and
the PER_TARGET_COVERAGE  option can be used to output GC content and mean coverage information for each target. The
AT/GC dropout metrics indicate the degree of inadequate coverage of a particular region based on its AT or GC content.
The PER_TARGET_COVERAGE option can be used to output GC content and mean sequence depth information for every target
interval. </p><p>Note: Metrics labeled as percentages are actually expressed as fractions!</p><h4>Usage
Example</h4><pre>java -jar picard.jar CollectTargetedPcrMetrics \<br />       I=input.bam \<br />      
O=output_pcr_metrics.txt \<br />       R=reference.fasta \<br />       AMPLICON_INTERVALS=amplicon.interval_list \<br />
TARGET_INTERVALS=targets.interval_list </pre>Please see the metrics definitions page on <a
href='http://broadinstitute.github.io/picard/picard-metric-definitions.html#TargetedPcrMetrics'>TargetedPcrMetrics</a>
for detailed explanations of the output metrics produced by this tool.<hr />
Version:3.4.0


Required Arguments:

--AMPLICON_INTERVALS,-AI <File>
                              An interval list file that contains the locations of the baits used.  Required. 

--INPUT,-I <File>             An aligned SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            The output file to write the metrics to.  Required. 

--TARGET_INTERVALS,-TI <File> An interval list file that contains the locations of the targets.  This argument must be
                              specified at least once. Required. 


Optional Arguments:

--ALLELE_FRACTION <Double>    Allele fraction for which to calculate theoretical sensitivity.  This argument may be
                              specified 0 or more times. Default value: [0.001, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.3,
                              0.5]. 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--CLIP_OVERLAPPING_READS <Boolean>
                              True if we are to clip overlapping reads, false otherwise.  Default value: false. Possible
                              values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--COVERAGE_CAP,-covMax <Integer>
                              Parameter to set a max coverage limit for Theoretical Sensitivity calculations. Default is
                              200.  Default value: 200. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--CUSTOM_AMPLICON_SET_NAME,-N <String>
                              Custom amplicon set name. If not provided it is inferred from the filename of the
                              AMPLICON_INTERVALS intervals.  Default value: null. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_INDELS <Boolean>    If true count inserted bases as on target and deleted bases as covered by a read.  Default
                              value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--METRIC_ACCUMULATION_LEVEL,-LEVEL <MetricAccumulationLevel>
                              The level(s) at which to accumulate metrics.  This argument may be specified 0 or more
                              times. Default value: [ALL_READS]. Possible values: {ALL_READS, SAMPLE, LIBRARY,
                              READ_GROUP} 

--MINIMUM_BASE_QUALITY,-Q <Integer>
                              Minimum base quality for a base to contribute coverage.  Default value: 0. 

--MINIMUM_MAPPING_QUALITY,-MQ <Integer>
                              Minimum mapping quality for a read to contribute coverage.  Default value: 1. 

--NEAR_DISTANCE <Integer>     The maximum distance between a read and the nearest probe/bait/amplicon for the read to be
                              considered 'near probe' and included in percent selected.  Default value: 250. 

--PER_BASE_COVERAGE <File>    An optional file to output per base coverage information to. The per-base file contains
                              one line per target base and can grow very large. It is not recommended for use with large
                              target sets.  Default value: null. 

--PER_TARGET_COVERAGE <File>  An optional file to output per target coverage information to.  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SAMPLE_SIZE <Integer>       Sample Size used for Theoretical Het Sensitivity sampling. Default is 10000.  Default
                              value: 10000. 

--THEORETICAL_SENSITIVITY_OUTPUT <File>
                              Output for Theoretical Sensitivity metrics where the allele fractions are provided by the
                              ALLELE_FRACTION argument.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument AMPLICON_INTERVALS was missing: Argument 'AMPLICON_INTERVALS' is required
```


## picard_CollectUmiPrevalenceMetrics

### Tool Description
Tally the counts of UMIs in duplicate sets within a bam. This tool collects the Histogram of the number of duplicate sets that contain a given number of UMIs. Understanding this distribution can help understand the role that the UMIs have in the determination of consensus sets, the risk of UMI collisions, and of spurious reads that result from uncorrected UMIs.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory


**EXPERIMENTAL FEATURE - USE AT YOUR OWN RISK**

USAGE: CollectUmiPrevalenceMetrics [arguments]

Tally the counts of UMIs in duplicate sets within a bam. 
<p>This tool collects the Histogram of the number of duplicate sets that contain a given number of UMIs. Understanding
this distribution can help understand the role that the UMIs have in the determination of consensus sets, the risk of
UMI collisions, and of spurious reads that result from uncorrected UMIs.
Version:3.4.0


Required Arguments:

--INPUT,-I <PicardHtsPath>    Input (indexed) BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            Write metrics to this file  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--BARCODE_BQ <String>         Barcode Quality SAM tag.  Default value: BQ. 

--BARCODE_TAG <String>        Barcode SAM tag.  Default value: RX. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--FILTER_UNPAIRED_READS,-FUR <Boolean>
                              Whether to filter unpaired reads from the input.  Default value: true. Possible values:
                              {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MINIMUM_BARCODE_BQ,-BQ <Integer>
                              minimal value for the base quality of all the bases in a molecular barcode, for it to be
                              used.  Default value: 30. 

--MINIMUM_MQ,-MQ <Integer>    minimal value for the mapping quality of the reads to be used in the estimation.  Default
                              value: 30. 

--PROGRESS_STEP_INTERVAL <Integer>
                              The interval between which progress will be displayed.  Default value: 1000000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectVariantCallingMetrics

### Tool Description
Collects per-sample and aggregate (spanning all samples) metrics from the provided VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectVariantCallingMetrics [arguments]

Collects per-sample and aggregate (spanning all samples) metrics from the provided VCF file.
Version:3.4.0


Required Arguments:

--DBSNP <PicardHtsPath>       Reference dbSNP file in dbSNP or VCF format.  Required. 

--INPUT,-I <PicardHtsPath>    Input vcf file for analysis  Required. 

--OUTPUT,-O <File>            Path (except for the file extension) of output metrics files to write.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--GVCF_INPUT <Boolean>        Set to true if running on a single-sample gvcf.  Default value: false. Possible values:
                              {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SEQUENCE_DICTIONARY,-SD <PicardHtsPath>
                              If present, speeds loading of dbSNP file, will look for dictionary in vcf if not present
                              here.  Default value: null. 

--TARGET_INTERVALS,-TI <PicardHtsPath>
                              Target intervals to restrict analysis to.  Default value: null. 

--THREAD_COUNT <Integer>      Undocumented option  Default value: 1. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectWgsMetrics

### Tool Description
Collect metrics about coverage and performance of whole genome sequencing (WGS) experiments. This tool collects metrics about the fractions of reads that pass base- and mapping-quality filters as well as coverage (read-depth) levels for WGS analyses.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectWgsMetrics [arguments]

Collect metrics about coverage and performance of whole genome sequencing (WGS) experiments.<p>This tool collects
metrics about the fractions of reads that pass base- and mapping-quality filters as well as coverage (read-depth) levels
for WGS analyses. Both minimum base- and mapping-quality values as well as the maximum read depths (coverage cap) are
user defined.</p><p>Note: Metrics labeled as percentages are actually expressed as fractions!</p><h4>Usage
Example:</h4><pre>java -jar picard.jar CollectWgsMetrics \<br />       I=input.bam \<br />      
O=collect_wgs_metrics.txt \<br />       R=reference_sequence.fasta </pre>Please see <a
href='https://broadinstitute.github.io/picard/picard-metric-definitions.html#CollectWgsMetrics.WgsMetrics'>CollectWgsMetrics</a>
for detailed explanations of the output metrics.<hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            Output metrics file.  Required. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Required. 


Optional Arguments:

--ALLELE_FRACTION <Double>    Allele fraction for which to calculate theoretical sensitivity.  This argument may be
                              specified 0 or more times. Default value: [0.001, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.3,
                              0.5]. 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--COUNT_UNPAIRED <Boolean>    If true, count unpaired reads, and paired reads with one end unmapped  Default value:
                              false. Possible values: {true, false} 

--COVERAGE_CAP,-CAP <Integer> Treat positions with coverage exceeding this value as if they had coverage at this value
                              (but calculate the difference for PCT_EXC_CAPPED).  Default value: 250. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_BQ_HISTOGRAM <Boolean>
                              Determines whether to include the base quality histogram in the metrics file.  Default
                              value: false. Possible values: {true, false} 

--INTERVALS <File>            An interval list file that contains the positions to restrict the assessment. Please note
                              that all bases of reads that overlap these intervals will be considered, even if some of
                              those bases extend beyond the boundaries of the interval. The ideal use case for this
                              argument is to use it to restrict the calculation to a subset of (whole) contigs.  Default
                              value: null. 

--LOCUS_ACCUMULATION_CAP <Integer>
                              At positions with coverage exceeding this value, completely ignore reads that accumulate
                              beyond this value (so that they will not be considered for PCT_EXC_CAPPED).  Used to keep
                              memory consumption in check, but could create bias if set too low  Default value: 100000. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MINIMUM_BASE_QUALITY,-Q <Integer>
                              Minimum base quality for a base to contribute coverage. N bases will be treated as having
                              a base quality of negative infinity and will therefore be excluded from coverage
                              regardless of the value of this parameter.  Default value: 20. 

--MINIMUM_MAPPING_QUALITY,-MQ <Integer>
                              Minimum mapping quality for a read to contribute coverage.  Default value: 20. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_LENGTH <Integer>       Average read length in the file. Default is 150.  Default value: 150. 

--SAMPLE_SIZE <Integer>       Sample Size used for Theoretical Het Sensitivity sampling. Default is 10000.  Default
                              value: 10000. 

--STOP_AFTER <Long>           For debugging purposes, stop after processing this many genomic bases.  Default value: -1.

--THEORETICAL_SENSITIVITY_OUTPUT <File>
                              Output for Theoretical Sensitivity metrics.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_FAST_ALGORITHM <Boolean>If true, fast algorithm is used.  Default value: false. Possible values: {true, false} 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectWgsMetricsWithNonZeroCoverage

### Tool Description
Collect metrics about coverage and performance of whole genome sequencing (WGS) experiments. This tool collects metrics about the percentages of reads that pass base- and mapping- quality filters as well as coverage (read-depth) levels. This extends CollectWgsMetrics by including metrics related only to sites with non-zero (>0) coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory


**EXPERIMENTAL FEATURE - USE AT YOUR OWN RISK**

USAGE: CollectWgsMetricsWithNonZeroCoverage [arguments]

Collect metrics about coverage and performance of whole genome sequencing (WGS) experiments.  This tool collects metrics
about the percentages of reads that pass base- and mapping- quality filters as well as coverage (read-depth) levels.
Both minimum base- and mapping-quality values as well as the maximum read depths (coverage cap) are user defined.  This
extends CollectWgsMetrics by including metrics related only to siteswith non-zero (>0) coverage.<p>Note: Metrics labeled
as percentages are actually expressed as fractions!</p><h4>Usage Example:</h4><pre>java -jar picard.jar
CollectWgsMetricsWithNonZeroCoverage \<br />       I=input.bam \<br />       O=collect_wgs_metrics.txt \<br />      
CHART=collect_wgs_metrics.pdf  \<br />       R=reference_sequence.fasta </pre>Please see the <a
href='https://broadinstitute.github.io/picard/picard-metric-definitions.html#CollectWgsMetricsWithNonZeroCoverage.WgsMetricsWithNonZeroCoverage'>WgsMetricsWithNonZeroCoverage</a>
documentation for detailed explanations of the output metrics.<hr />
Version:3.4.0


Required Arguments:

--CHART_OUTPUT,-CHART <File>  A file (with .pdf extension) to write the chart to.  Required. 

--INPUT,-I <File>             Input SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            Output metrics file.  Required. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Required. 


Optional Arguments:

--ALLELE_FRACTION <Double>    Allele fraction for which to calculate theoretical sensitivity.  This argument may be
                              specified 0 or more times. Default value: [0.001, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.3,
                              0.5]. 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--COUNT_UNPAIRED <Boolean>    If true, count unpaired reads, and paired reads with one end unmapped  Default value:
                              false. Possible values: {true, false} 

--COVERAGE_CAP,-CAP <Integer> Treat positions with coverage exceeding this value as if they had coverage at this value
                              (but calculate the difference for PCT_EXC_CAPPED).  Default value: 250. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_BQ_HISTOGRAM <Boolean>
                              Determines whether to include the base quality histogram in the metrics file.  Default
                              value: false. Possible values: {true, false} 

--INTERVALS <File>            An interval list file that contains the positions to restrict the assessment. Please note
                              that all bases of reads that overlap these intervals will be considered, even if some of
                              those bases extend beyond the boundaries of the interval. The ideal use case for this
                              argument is to use it to restrict the calculation to a subset of (whole) contigs.  Default
                              value: null. 

--LOCUS_ACCUMULATION_CAP <Integer>
                              At positions with coverage exceeding this value, completely ignore reads that accumulate
                              beyond this value (so that they will not be considered for PCT_EXC_CAPPED).  Used to keep
                              memory consumption in check, but could create bias if set too low  Default value: 100000. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MINIMUM_BASE_QUALITY,-Q <Integer>
                              Minimum base quality for a base to contribute coverage. N bases will be treated as having
                              a base quality of negative infinity and will therefore be excluded from coverage
                              regardless of the value of this parameter.  Default value: 20. 

--MINIMUM_MAPPING_QUALITY,-MQ <Integer>
                              Minimum mapping quality for a read to contribute coverage.  Default value: 20. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_LENGTH <Integer>       Average read length in the file. Default is 150.  Default value: 150. 

--SAMPLE_SIZE <Integer>       Sample Size used for Theoretical Het Sensitivity sampling. Default is 10000.  Default
                              value: 10000. 

--STOP_AFTER <Long>           For debugging purposes, stop after processing this many genomic bases.  Default value: -1.

--THEORETICAL_SENSITIVITY_OUTPUT <File>
                              Output for Theoretical Sensitivity metrics.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_FAST_ALGORITHM <Boolean>If true, fast algorithm is used.  Default value: false. Possible values: {true, false} 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument CHART_OUTPUT was missing: Argument 'CHART_OUTPUT' is required
```


## picard_CompareMetrics

### Tool Description
Compare two metrics files. This tool compares the metrics and histograms generated from metric tools to determine if the generated results are identical. Note that if there are differences in metric values, this tool describes those differences as the change of the second input metric relative to the first.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CompareMetrics [arguments]

Compare two metrics files.This tool compares the metrics and histograms generated from metric tools to determine if the
generated results are identical.  Note that if there are differences in metric values, this tool describes those
differences as the change of the second input metric relative to the first. <br /><br />  <h4>Usage
example:</h4><pre>java -jar picard.jar CompareMetrics \<br />      INPUT=metricfile1.txt \<br />     
INPUT=metricfile2.txt \<br />      METRICS_TO_IGNORE=INSERT_LENGTH \<br />     
METRIC_ALLOWABLE_RELATIVE_CHANGE=HET_HOM_RATIO:0.0005 \<br />      IGNORE_HISTOGRAM_DIFFERENCES=false</pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Metric files to compare.  This argument must be specified at least once. Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--IGNORE_HISTOGRAM_DIFFERENCES,-IHD <Boolean>
                              Ignore any differences between the two metric file's histograms (useful if using the
                              'METRIC_ALLOWABLE_RELATIVE_CHANGE')  Default value: false. Possible values: {true, false} 

--KEY <String>                Columns to use as keys for matching metrics rows that should agree.  If not specified, it
                              is assumed that rows should be in the same order.  This argument may be specified 0 or
                              more times. Default value: null. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--METRIC_ALLOWABLE_RELATIVE_CHANGE,-MARC <String>
                              Metric Allowable Relative Change. A colon separate pair of metric name and an absolute
                              relative change.  For any metric specified here,  when the values are compared between the
                              two files, the program will allow that much relative change between the  two values.  This
                              argument may be specified 0 or more times. Default value: null. 

--METRICS_NOT_REQUIRED,-MNR <String>
                              Metrics which are not required.  Any metrics specified here may be missing from either of
                              the files in the comparison, and this will not affect the result of the comparison.  If
                              metrics specified here are included in both files, their results will not be compared
                              (they will be treated as METRICS_TO_IGNORE.  This argument may be specified 0 or more
                              times. Default value: null. 

--METRICS_TO_IGNORE,-MI <String>
                              Metrics to ignore. Any metrics specified here will be excluded from comparison by the
                              tool.  Note that while the values of these metrics are not compared, if they are missing
                              from either file that will be considered a difference.  Use METRICS_NOT_REQUIRED to
                              specify metrics which can be missing from either file without being considered a
                              difference.  This argument may be specified 0 or more times. Default value: null. 

--OUTPUT,-O <File>            Output file to write comparison results to.  Default value: null. 

--OUTPUT_TABLE <File>         Output file to write table of differences to.  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CompareSAMs

### Tool Description
Compare two input SAM/BAM/CRAM files. This tool initially compares the headers of the input files. If the file headers are comparable, the tool can perform either strict comparisons for which each alignment and the header must be identical, or a more lenient check of "equivalence". Results of comparison are summarised in an output metrics file.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CompareSAMs [arguments]

Compare two input SAM/BAM/CRAM files.  This tool initially compares the headers of the input files.  If the file headers
are comparable, the tool can perform either strict comparisons for which each alignment and the header must be
identical, or a more lenient check of "equivalence", where reads with mapping quality < LOW_MQ_THRESHOLD are allowed to
have different alignments, duplicate marks are allowed to differ to account for ambiguities in selecting the
representative read of a duplicate set, and some differences in headers is allowed.  By default, alignment comparisons,
duplicate marking comparisons, and header comparisons are performed in the strict mode.  Results of comparison are
summarised in  an output metrics file.<h3>Usage example:</h3><h4>CompareSAMs for exact matching:</h4><pre>java -jar
picard.jar CompareSAMs \<br />      file_1.bam \<br />      file_2.bam \<br />      O=comparison.tsv</pre>
<h4>CompareSAMs for "equivalence":</h4>java -jar picard.jar CompareSAMs \<br />      file_1.bam \<br />      file_2.bam
\<br />      LENIENT_LOW_MQ_ALIGNMENT=true \<br />      LENIENT_DUP=true \<br />      O=comparison.tsv</pre>
<h4>CompareSAMs for "equivalence", allow certain differences in header:</h4>java -jar picard.jar CompareSAMs \<br />    
file_1.bam \<br />      file_2.bam \<br />      LENIENT_LOW_MQ_ALIGNMENT=true \<br />      LENIENT_DUP=true \<br />     
LENIENT_HEADER=true \<br />      O=comparison.tsv<hr />
Version:3.4.0


Positional Arguments:

--POSITIONAL (must be first) <File>
                              Exactly two input SAM/BAM/CRAM files to compare to one another.  This argument must be
                              specified at least once. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPARE_MQ <Boolean>        If set to true, generate a histogram for mapping quality concordance between the two SAM
                              files and write it to the output metrics file. In this histogram, an entry of 10 at bin
                              "20,30" means that 10 reads in the left file have mapping quality 20 while those same
                              reads have mapping quality 30 in the right file. The reads are associated based solely on
                              read names and not the mapped position. Only primary alignments are included, but all
                              duplicate reads are counted individually.  Default value: false. Possible values: {true,
                              false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--LENIENT_DUP <Boolean>       Perform lenient checking of duplicate marks.  In this mode, will reduce the number of
                              mismatches by allowing the choice of the representative read in each duplicate set to
                              differ between the input files, as long as the duplicate sets agree.  Default value:
                              false. Possible values: {true, false} 

--LENIENT_HEADER <Boolean>    Perform lenient checking of header.  In this mode, species, assembly, ur, m5, fields of
                              sequence records, and pg fields in the header may all differ. Sequence record length must
                              also be the same.  Default value: false. Possible values: {true, false} 

--LENIENT_LOW_MQ_ALIGNMENT <Boolean>
                              Count reads which have mapping quality below LOW_MQ_THRESHOLD in both files but are mapped
                              to different locations as matches.  By default we count such reads as mismatching. 
                              Default value: false. Possible values: {true, false} 

--LENIENT_UNKNOWN_MQ_ALIGNMENT <Boolean>
                              Count reads for which no mapping quality is available (mapping quality value 255) in both
                              files but are mapped to different locations as matches.  By default we count such reads as
                              mismatching.  Default value: false. Possible values: {true, false} 

--LOW_MQ_THRESHOLD <Integer>  When running in LENIENT_LOW_MQ_ALIGNMENT mode, reads which have mapping quality below this
                              value will be counted as matches. if LENIENT_LOW_MQ_ALIGNMENT is false (default), then
                              this argument has no effect.  Default value: 3. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--OUTPUT,-O <File>            Output file to write comparison results to.  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument Positional Argument was missing: At least 2 positional arguments must be specified.
```


## picard_ConvertHaplotypeDatabaseToVcf

### Tool Description
Convert Haplotype database file to vcf

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: ConvertHaplotypeDatabaseToVcf [arguments]

Convert Haplotype database file to vcf<h3>Examples</h3><pre>java -jar picard.jar ConvertHaplotypeDatabaseToVcf \
-I haplotype_database.txt \
-O haplotype_database.vcf.gz \
-R reference.fasta</pre>
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Haplotype database to be converted to VCF.  Required. 

--OUTPUT,-O <File>            Where to write converted haplotype database VCF.  Required. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_ConvertSequencingArtifactToOxoG

### Tool Description
Extract OxoG metrics from generalized artifacts metrics. This tool extracts 8-oxoguanine (OxoG) artifact metrics from the output of CollectSequencingArtifactsMetrics and converts them to the CollectOxoGMetrics tool's output format.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: ConvertSequencingArtifactToOxoG [arguments]

Extract OxoG metrics from generalized artifacts metrics.  <p>This tool extracts 8-oxoguanine (OxoG) artifact metrics
from the output of CollectSequencingArtifactsMetrics (a tool that provides detailed information on a variety of
artifacts found in sequencing libraries) and converts them to the CollectOxoGMetrics tool's output format. This
conveniently eliminates the need to run CollectOxoGMetrics if we already ran CollectSequencingArtifactsMetrics in our
pipeline. See the documentation for <a
href='http://broadinstitute.github.io/picard/command-line-overview.html#CollectSequencingArtifactsMetrics'>CollectSequencingArtifactsMetrics</a>
and <a
href='http://broadinstitute.github.io/picard/command-line-overview.html#CollectOxoGMetrics'>CollectOxoGMetrics</a> for
additional information on these tools. <p>Note that only the base of the CollectSequencingArtifactsMetrics output file
name is required for the (INPUT_BASE) parameter. For example, if the file name is
artifact_metrics.txt.bait_bias_detail_metrics or artifact_metrics.txt.pre_adapter_detail_metrics, only the file name
base 'artifact_metrics' is required on the command line for this parameter.  An output file called
'artifact_metrics.oxog_metrics' will be generated automatically.  Finally, to run this tool successfully, the
REFERENCE_SEQUENCE must be provided.<p>This command also lets you specify the detail metrics files by name, if files are
not in the usual location or have different names. For example, the arguments PRE_ADAPTER_IN and BAIT_BIAS_IN specify
the file location of the  pre adapter detail metrics and the bait bias detail metrics respectively. If these arguments
are provided then the value of INPUT_BASE is ignored. <h4>Usage example:</h4><pre>java -jar picard.jar
ConvertSequencingArtifactToOxoG \<br />     I=artifact_metrics \<br />     R=reference.fasta</pre>Please see the metrics
definitions page at <a
href='http://broadinstitute.github.io/picard/picard-metric-definitions.html#CollectOxoGMetrics.CpcgMetrics'>ConvertSequencingArtifactToOxoG</a>
for detailed descriptions of the output metrics produced by this tool.<hr />
Version:3.4.0

Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--BAIT_BIAS_IN <File>         The bait bias input file. Defaults to a filename based on the input basename  Default
                              value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INPUT_BASE,-I <File>        Basename of the input artifact metrics file (output by CollectSequencingArtifactMetrics).
                              If this is not  specified, you must specify PRE_ADAPTER_IN and BAIT_BIAS_IN  Default
                              value: null. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--OUTPUT_BASE,-O <File>       Basename for output OxoG metrics. Defaults to same basename as input metrics  Default
                              value: null. 

--OXOG_OUT <File>             File for the output OxoG metrics. Defaults to a filename based on the output basename 
                              Default value: null. 

--PRE_ADAPTER_IN <File>       The pre adapter details input file. Defaults to a filename based on the input basename 
                              Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 

Must specify either INPUT_BASE or PRE_ADAPTER_IN
Must specify either INPUT_BASE or BAIT_BIAS_IN
Must specify either OUTPUT_BASE or OXOG_OUT
```


## picard_CrosscheckFingerprints

### Tool Description
Checks the odds that all data in the set of input files come from the same individual. Can be used to cross-check readgroups, libraries, samples, or files. Acceptable inputs include BAM/SAM/CRAM and VCF/GVCF files. Output delivers LOD scores in the form of a CrosscheckMetric file.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CrosscheckFingerprints [arguments]

Checks the odds that all data in the set of input files come from the same individual. Can be used to cross-check
readgroups, libraries, samples, or files. Acceptable inputs include BAM/SAM/CRAM and VCF/GVCF files. Output delivers LOD
scores in the form of a CrosscheckMetric file. 

<h3>Summary</h3>
CrosscheckFingerprints rapidly checks the odds that all of the genetic data within a set of files come from the same
individual. This is accomplished by selectively sampling from the input files, and determining whether the genotypes of
the specified Groups match to each other. (Groups are defined by the input and the argument CROSSCHECK_BY; they can be
READ_GROUP, LIBRARY, SAMPLE, or FILE.)<br /><br /> Output is generated in the form of a ?molten? (one row per
comparison) CrosscheckMetric file that includes the Logarithm of the Odds (LOD) score, as well as the tumor-aware LOD
score. Tumor-aware LOD scores can be used to assess genotypic identity in the presence of a severe Loss of
Heterozygosity (LOH) with high purity?this could otherwise lead to a failure of the tool to identify samples are from
the same individual. Output is also available as a matrix, to facilitate visual inspection of crosscheck results.<br
/><br /> Metric files can contain many rows of output. We therefore recommend following up CrosscheckFingerprints with a
step using [ClusterCrosscheckMetrics
(Picard)](https://gatk.broadinstitute.org/hc/en-us/articles/360045798972--Tool-Documentation-Index); this tool will
cluster groups together that pass a designated LOD threshold, ensuring that groups within the cluster are related to
each other. <br /><br /> There may be cases where several groups out of a collection of possible groups must be
identified---for example, to link a BAM to its correct sample in a multi-sample VCF. In this case, it would not be
necessary to cross-check the various samples in the VCF against each other, but only to check the identity of the BAM
against the various samples in the VCF. For this application, the SECOND_INPUT argument is provided. With SECOND_INPUT,
CrosscheckFingerprints can do the following: <br /><br /> <ul><li> Independently aggregate data for the input files in
INPUT and SECOND_INPUT. </li><li> Aggregate data at the SAMPLE level. </li><li> Compare samples from INPUT to the same
sample in SECOND_INPUT. </li><li> Disables MATRIX_OUTPUT. </li></ul><br /><br />In some cases, the groups collected may
not have any observations (?reads? for BAM files, or ?calls? for VCF files) at fingerprinting sites. Alternatively, a
sample in INPUT may be missing from SECOND_INPUT. These cases are handled as follows: <br /><br /> <ul><li> If running
in CHECK_SAME_SAMPLES mode with the INPUT and SECOND_INPUT sets of input files: when either set of inputs (1) includes a
sample not found in the other, or (2) contains a sample with no observations at any fingerprinting sites, then an error
will be logged and the tool will return EXIT_CODE_WHEN_MISMATCH. </li><li> If running in any other running mode: when a
group which is being crosschecked does not have any observations at fingerprinting sites, a warning will be logged.
</li></ul><br /><br />Note that, as long as there is at least one comparison in which both files have observations at
fingerprinting sites, the tool will return a ?zero?. However, an error will be logged and the tool will return
EXIT_CODE_WHEN_NO_VALID_CHECKS if all comparisons have at least one side without observations at a fingerprinting site
(ie. all LOD scores are zero). <br /><br /> <hr/><h3>Examples</h3><h4>Check that all the readgroups from a sample match
each other:</h4><pre>    java -jar picard.jar CrosscheckFingerprints \
INPUT=sample.with.many.readgroups.bam \
HAPLOTYPE_MAP=fingerprinting_haplotype_database.txt \
LOD_THRESHOLD=-5 \
OUTPUT=sample.crosscheck_metrics </pre>
<h4>Check that all the readgroups match as expected when providing reads from two samples from the same individual:</h4>
<pre>     java -jar picard.jar CrosscheckFingerprints \
INPUT=sample.one.with.many.readgroups.bam \
INPUT=sample.two.with.many.readgroups.bam \
HAPLOTYPE_MAP=fingerprinting_haplotype_database.txt \
LOD_THRESHOLD=-5 \
EXPECT_ALL_GROUPS_TO_MATCH=true \
OUTPUT=sample.crosscheck_metrics </pre><br /><br /><h4>Detailed Explanation</h4>
This tool calculates the LOD score for identity check between "groups" of data in the INPUT files as defined by the
CROSSCHECK_BY argument. A positive value indicates that the data seems to have come from the same individual or, in
other words the identity checks out. The scale is logarithmic (base 10), so a LOD of 6 indicates that it is 1,000,000
more likely that the data matches the genotypes than not. A negative value indicates that the data do not match. A score
that is near zero is inconclusive and can result from low coverage or non-informative genotypes. <br /><br />Each group
is assigned a sample identifier (for SAM this is taken from the SM tag in the appropriate readgroup header line, for VCF
this is taken from the column label in the file-header. After combining all the data from the same group together, an
all-against-all comparison is performed. Results are categorized as one of EXPECTED_MATCH, EXPECTED_MISMATCH,
UNEXPECTED_MATCH, UNEXPECTED_MISMATCH, or AMBIGUOUS depending on the LOD score and on whether the sample identifiers of
the groups agree: LOD scores that are less than LOD_THRESHOLD are considered mismatches, and those greater than
-LOD_THRESHOLD are matches (between is ambiguous). If the sample identifiers are equal, the groups are expected to
match. They are expected to mismatch otherwise. <br /><br />The identity check makes use of haplotype blocks defined in
the HAPLOTYPE_MAP file to enable it to have higher statistical power for detecting identity or swap by aggregating data
from several SNPs in the haplotype block. This enables an identity check of samples with very low coverage (e.g. ~1x
mean coverage).<br /><br />When provided a VCF, the identity check looks at the PL, GL and GT fields (in that order) and
uses the first one that it finds. 
Version:3.4.0


Required Arguments:

--HAPLOTYPE_MAP,-H <File>     The file lists a set of SNPs, optionally arranged in high-LD blocks, to be used for
                              fingerprinting. See
                              https://gatk.broadinstitute.org/hc/en-us/articles/360035531672-Haplotype-map-format for
                              details.  Required. 

--INPUT,-I <String>           One or more input files (or lists of files) with which to compare fingerprints.  This
                              argument must be specified at least once. Required. 


Optional Arguments:

--ALLOW_DUPLICATE_READS <Boolean>
                              Allow the use of duplicate reads in performing the comparison. Can be useful when
                              duplicate marking has been overly aggressive and coverage is low.  Default value: false.
                              Possible values: {true, false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--CALCULATE_TUMOR_AWARE_RESULTS <Boolean>
                              Specifies whether the Tumor-aware result should be calculated. These are time consuming
                              and can roughly double the runtime of the tool. When crosschecking many groups not
                              calculating the tumor-aware  results can result in a significant speedup.  Default value:
                              true. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--CROSSCHECK_BY <DataType>    Specifies which data-type should be used as the basic comparison unit. Fingerprints from
                              readgroups can be "rolled-up" to the LIBRARY, SAMPLE, or FILE level before being compared.
                              Fingerprints from VCF can be be compared by SAMPLE or FILE.  Default value: READGROUP.
                              Possible values: {FILE, SAMPLE, LIBRARY, READGROUP} 

--CROSSCHECK_MODE <CrosscheckMode>
                              An argument that controls how crosschecking with both INPUT and SECOND_INPUT should occur.
                              Default value: CHECK_SAME_SAMPLE. CHECK_SAME_SAMPLE (In this mode, each sample in INPUT
                              will only be checked against a single corresponding sample in SECOND_INPUT. If a
                              corresponding sample cannot be found, the program will proceed, but report the missing
                              samples and return the value specified in EXIT_CODE_WHEN_MISMATCH. The corresponding
                              samples are those that equal each other, after possible renaming via INPUT_SAMPLE_MAP and
                              SECOND_INPUT_SAMPLE_MAP. In this mode CROSSCHECK_BY must be SAMPLE.)
                              CHECK_ALL_OTHERS (In this mode, each sample in INPUT will be checked against all the
                              samples in SECOND_INPUT.)

--EXIT_CODE_WHEN_MISMATCH <Integer>
                              When one or more mismatches between groups is detected, exit with this value instead of 0.
                              Default value: 1. 

--EXIT_CODE_WHEN_NO_VALID_CHECKS <Integer>
                              When all LOD scores are zero, exit with this value.  Default value: 1. 

--EXPECT_ALL_GROUPS_TO_MATCH <Boolean>
                              Expect all groups' fingerprints to match, irrespective of their sample names.  By default
                              (with this value set to false), groups (readgroups, libraries, files, or samples) with
                              different sample names are expected to mismatch, and those with the same sample name are
                              expected to match.   Default value: false. Possible values: {true, false} 

--GENOTYPING_ERROR_RATE <Double>
                              This argument is DEPRECATED (No longer used in fingerprint checking. Will be removed in a
                              future release.). Assumed genotyping error rate that provides a floor on the probability
                              that a genotype comes from the expected sample. Must be greater than zero.   Default
                              value: 0.01. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INPUT_INDEX_MAP <File>      A tsv with two columns and no header which maps the input files to corresponding indices;
                              to be used when index files are not located next to input files. First column must match
                              the list of inputs.   Default value: null. 

--INPUT_SAMPLE_FILE_MAP <File>A tsv with two columns representing the sample as it should be used for comparisons to
                              SECOND_INPUT (in the first column) and  the source file (in INPUT) for the fingerprint (in
                              the second column). Need only to include the samples that change. Values in column 1
                              should be unique even in union with the remaining unmapped samples. Values in column 2
                              should be unique in the file. Will error if more than one sample is found in a file
                              (multi-sample VCF) pointed to in column 2. Should only be used in the presence of
                              SECOND_INPUT.   Default value: null.  Cannot be used in conjunction with argument(s)
                              INPUT_SAMPLE_MAP

--INPUT_SAMPLE_MAP <File>     A tsv with two columns representing the sample as it appears in the INPUT data (in column
                              1) and the sample as it should be used for comparisons to SECOND_INPUT (in the second
                              column). Need only include the samples that change. Values in column 1 should be unique.
                              Values in column 2 should be unique even in union with the remaining unmapped samples.
                              Should only be used with SECOND_INPUT.   Default value: null.  Cannot be used in
                              conjunction with argument(s) INPUT_SAMPLE_FILE_MAP

--LOD_THRESHOLD,-LOD <Double> If any two groups (with the same sample name) match with a LOD score lower than the
                              threshold the tool will exit with a non-zero code to indicate error. Program will also
                              exit with an error if it finds two groups with different sample name that match with a LOD
                              score greater than -LOD_THRESHOLD.
                              
                              LOD score 0 means equal likelihood that the groups match vs. come from different
                              individuals, negative LOD score -N, mean 10^N time more likely that the groups are from
                              different individuals, and +N means 10^N times more likely that the groups are from the
                              same individual.   Default value: 0.0. 

--LOSS_OF_HET_RATE <Double>   The rate at which a heterozygous genotype in a normal sample turns into a homozygous (via
                              loss of heterozygosity) in the tumor (model assumes independent events, so this needs to
                              be larger than reality).  Default value: 0.5. 

--MATRIX_OUTPUT,-MO <File>    Optional output file to write matrix of LOD scores to. This is less informative than the
                              metrics output and only contains Normal-Normal LOD score (i.e. doesn't account for Loss of
                              Heterozygosity). It is however sometimes easier to use visually.  Default value: null. 
                              Cannot be used in conjunction with argument(s) SECOND_INPUT (SI)

--MAX_EFFECT_OF_EACH_HAPLOTYPE_BLOCK <Double>
                              Maximal effect of any single haplotype block on outcome (-log10 of maximal likelihood
                              difference between the different values for the three possible genotypes).  Default value:
                              3.0. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--NUM_THREADS <Integer>       The number of threads to use to process files and generate fingerprints.  Default value:
                              1. 

--OUTPUT,-O <File>            Optional output file to write metrics to. Default is to write to stdout.  Default value:
                              null. 

--OUTPUT_ERRORS_ONLY <Boolean>If true, then only groups that do not relate to each other as expected will have their
                              LODs reported.  Default value: false. Possible values: {true, false} 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--REQUIRE_INDEX_FILES <Boolean>
                              A boolean value to determine whether input files should only be parsed if index files are
                              available. Without turning this option on, the tool will need to read through the entirety
                              of input files without index files either provided via the INPUT_INDEX_MAP or locally
                              accessible relative to the input, which significantly increases runtime. If set to true
                              and no index is found for a file, an exception will be thrown. This applies for both the
                              INPUT and SECOND_INPUT files.  Default value: false. Possible values: {true, false} 

--SAMPLE_INDIVIDUAL_MAP <File>A tsv with two columns representing the individual with which each sample is associated. 
                              The first column is the sample id, and the second column is the associated individual id. 
                              Values in the first column must be unique. If INPUT_SAMPLE_MAP or SECOND_INPUT_SAMPLE_MAP
                              is also specified, then the values in the first column of this file should be the sample
                              aliases specified in the second columns of INPUT_SAMPLE_MAP and SECOND_INPUT_SAMPLE_MAP,
                              respectively.  When this input is specified, expectations for matches will be based on the
                              equality or inequality of the individual ids associated with two samples, as opposed to
                              the sample ids themselves.  Samples which are not listed in this file will have their
                              sample id used as their individual id, for the purposes of match expectations.  This means
                              that one sample id could be used as the individual id for another sample, but not included
                              in the map itself, and these two samples would be considered to have come from the same
                              individual.  Note that use of this parameter only affects labelling of matches and
                              mismatches as EXPECTED or UNEXPECTED.  It has no affect on how data is grouped for
                              crosschecking.  Default value: null. 

--SECOND_INPUT,-SI <String>   A second set of input files (or lists of files) with which to compare fingerprints. If
                              this option is provided the tool compares each sample in INPUT with the sample from
                              SECOND_INPUT that has the same sample ID. In addition, data will be grouped by SAMPLE
                              regardless of the value of CROSSCHECK_BY. When operating in this mode, each sample in
                              INPUT must also have a corresponding sample in SECOND_INPUT. If this is violated, the tool
                              will proceed to check the matching samples, but report the missing samples and return a
                              non-zero error-code.  This argument may be specified 0 or more times. Default value: null.
                              Cannot be used in conjunction with argument(s) MATRIX_OUTPUT (MO)

--SECOND_INPUT_INDEX_MAP <File>
                              A tsv with two columns and no header which maps the second input files to corresponding
                              indices; to be used when index files are not located next to second input files. First
                              column must match the list of second inputs.   Default value: null. 

--SECOND_INPUT_SAMPLE_MAP <File>
                              A tsv with two columns representing the sample as it appears in the SECOND_INPUT data (in
                              column 1) and the sample as it should be used for comparisons to INPUT (in the second
                              column). Note that in case of unrolling files (file-of-filenames) one would need to
                              reference the final file, i.e. the file that contains the genomic data. Need only include
                              the samples that change. Values in column 1 should be unique. Values in column 2 should be
                              unique even in union with the remaining unmapped samples. Should only be used with
                              SECOND_INPUT.   Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_EstimateLibraryComplexity

### Tool Description
Estimates the numbers of unique molecules in a sequencing library. This tool outputs quality metrics for a sequencing library preparation. Library complexity refers to the number of unique DNA fragments present in a given library.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: EstimateLibraryComplexity [arguments]

Estimates the numbers of unique molecules in a sequencing library.  <p>This tool outputs quality metrics for a
sequencing library preparation.Library complexity refers to the number of unique DNA fragments present in a given
library.  Reductions in complexity resulting from PCR amplification during library preparation will ultimately
compromise downstream analyses via an elevation in the number of duplicate reads.  PCR-associated duplication artifacts
can result from: inadequate amounts of starting material (genomic DNA, cDNA, etc.), losses during cleanups, and size
selection issues.  Duplicate reads can also arise from optical duplicates resulting from sequencing-machine optical
sensor artifacts.</p>  <p>This tool attempts to estimate library complexity from sequence of read pairs alone.  Reads
are sorted by the first N bases (5 by default) of the first read and then the first N bases of the second read of a
pair.   Read pairs are considered to be duplicates if they match each other with no gaps and an overall mismatch rate
less than or equal to MAX_DIFF_RATE (0.03 by default).  Reads of poor quality are filtered out to provide a more
accurate estimate.  The filtering removes reads with any poor quality bases as defined by a read's MIN_MEAN_QUALITY (20
is the default value) across either the first or second read.  Unpaired reads are ignored in this computation.</p>
<p>The algorithm attempts to detect optical duplicates separately from PCR duplicates and excludes these in the
calculation of library size.  Also, since there is no alignment information used in this algorithm, an additional filter
is applied to the data as follows.  After examining all reads, a histogram is built in which the number of reads in a
duplicate set is compared with the number of of duplicate sets.   All bins that contain exactly one duplicate set are
then removed from the histogram as outliers prior to the library size estimation.  </p><h4>Usage example:</h4><pre>java
-jar picard.jar EstimateLibraryComplexity \<br />     I=input.bam \<br />     O=est_lib_complex_metrics.txt</pre>Please
see the documentation for the companion <a
href='https://broadinstitute.github.io/picard/command-line-overview.html#MarkDuplicates'>MarkDuplicates</a> tool.<hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             One or more files to combine and estimate library complexity from. Reads can be mapped or
                              unmapped.  This argument must be specified at least once. Required. 

--OUTPUT,-O <File>            Output file to writes per-library metrics to.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--BARCODE_TAG <String>        Barcode SAM tag (ex. BC for 10X Genomics)  Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_DIFF_RATE <Double>      The maximum rate of differences between two reads to call them identical.  Default value:
                              0.03. 

--MAX_GROUP_RATIO <Integer>   Do not process self-similar groups that are this many times over the mean expected group
                              size. I.e. if the input contains 10m read pairs and MIN_IDENTICAL_BASES is set to 5, then
                              the mean expected group size would be approximately 10 reads.  Default value: 500. 

--MAX_OPTICAL_DUPLICATE_SET_SIZE <Long>
                              This number is the maximum size of a set of duplicate reads for which we will attempt to
                              determine which are optical duplicates.  Please be aware that if you raise this value too
                              high and do encounter a very large set of duplicate reads, it will severely affect the
                              runtime of this tool.  To completely disable this check, set the value to -1.  Default
                              value: 300000. 

--MAX_READ_LENGTH <Integer>   The maximum number of bases to consider when comparing reads (0 means no maximum). 
                              Default value: 0. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 2279706. 

--MIN_GROUP_COUNT <Integer>   Minimum number group count.  On a per-library basis, we count the number of groups of
                              duplicates that have a particular size.  Omit from consideration any count that is less
                              than this value.  For example, if we see only one group of duplicates with size 500, we
                              omit it from the metric calculations if MIN_GROUP_COUNT is set to two.  Setting this to
                              two may help remove technical artifacts from the library size calculation, for example,
                              adapter dimers.  Default value: 2. 

--MIN_IDENTICAL_BASES <Integer>
                              The minimum number of bases at the starts of reads that must be identical for reads to be
                              grouped together for duplicate detection.  In effect total_reads / 4^max_id_bases reads
                              will be compared at a time, so lower numbers will produce more accurate results but
                              consume exponentially more memory and CPU.  Default value: 5. 

--MIN_MEAN_QUALITY <Integer>  The minimum mean quality of the bases in a read pair for the read to be analyzed. Reads
                              with lower average quality are filtered out and not considered in any calculations. 
                              Default value: 20. 

--OPTICAL_DUPLICATE_PIXEL_DISTANCE <Integer>
                              The maximum offset between two duplicate clusters in order to consider them optical
                              duplicates. The default is appropriate for unpatterned versions of the Illumina platform.
                              For the patterned flowcell models, 2500 is moreappropriate. For other platforms and
                              models, users should experiment to find what works best.  Default value: 100. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_NAME_REGEX <String>    MarkDuplicates can use the tile and cluster positions to estimate the rate of optical
                              duplication in addition to the dominant source of duplication, PCR, to provide a more
                              accurate estimation of library size. By default (with no READ_NAME_REGEX specified),
                              MarkDuplicates will attempt to extract coordinates using a split on ':' (see Note below). 
                              Set READ_NAME_REGEX to 'null' to disable optical duplicate detection. Note that without
                              optical duplicate counts, library size estimation will be less accurate. If the read name
                              does not follow a standard Illumina colon-separation convention, but does contain tile and
                              x,y coordinates, a regular expression can be specified to extract three variables:
                              tile/region, x coordinate and y coordinate from a read name. The regular expression must
                              contain three capture groups for the three variables, in order. It must match the entire
                              read name.   e.g. if field names were separated by semi-colon (';') this example regex
                              could be specified      (?:.*;)?([0-9]+)[^;]*;([0-9]+)[^;]*;([0-9]+)[^;]*$ Note that if no
                              READ_NAME_REGEX is specified, the read name is split on ':'.   For 5 element names, the
                              3rd, 4th and 5th elements are assumed to be tile, x and y values.   For 7 element names
                              (CASAVA 1.8), the 5th, 6th, and 7th elements are assumed to be tile, x and y values. 
                              Default value: <optimized capture of last three ':' separated fields as numeric values>. 

--READ_ONE_BARCODE_TAG <String>
                              Read one barcode SAM tag (ex. BX for 10X Genomics)  Default value: null. 

--READ_TWO_BARCODE_TAG <String>
                              Read two barcode SAM tag (ex. BX for 10X Genomics)  Default value: null. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_ExtractFingerprint

### Tool Description
Computes/Extracts the fingerprint genotype likelihoods from the supplied file. It is given as a list of PLs at the fingerprinting sites.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: ExtractFingerprint [arguments]

Computes/Extracts the fingerprint genotype likelihoods from the supplied file.It is given as a list of PLs at the
fingerprinting sites.
Version:3.4.0


Required Arguments:

--HAPLOTYPE_MAP,-H <File>     A file of haplotype information. The file lists a set of SNPs, optionally arranged in
                              high-LD blocks, to be used for fingerprinting. See
                              https://gatk.broadinstitute.org/hc/en-us/articles/360035531672-Haplotype-map-format for
                              details.  Required. 

--INPUT,-I <String>           Input SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            Output fingerprint file (VCF).  Required. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CONTAMINATION,-C <Double>   A value of estimated contamination in the input. A non-zero value will cause the program
                              to provide a better estimate of the fingerprint in the presence of contaminating reads 
                              Default value: 0.0. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--EXTRACT_CONTAMINATION <Boolean>
                              Extract a fingerprint for the contaminating sample (instead of the contaminated sample).
                              Setting to true changes the effect of SAMPLE_ALIAS when null. It names the sample in the
                              VCF <SAMPLE>-contaminant, using the SM value from the SAM header.  Default value: false.
                              Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--LOCUS_MAX_READS <Integer>   The maximum number of reads to use as evidence for any given locus. This is provided as a
                              way to limit the effect that any given locus may have.  Default value: 50. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--SAMPLE_ALIAS <String>       The sample alias to associate with the resulting fingerprint. When null, <SAMPLE> is
                              extracted from the input file and "<SAMPLE>" is used. If argument
                              EXTRACT_CONTAMINATION=true the resulting samplename will be "<SAMPLE>-contamination" (if
                              not provided).  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--EXTRACT_NON_REPRESENTATIVES_TOO <Boolean>
                              When true, code will extract variants for every snp in the haplotype database, not only
                              the representative one.  Default value: false. Possible values: {true, false} 

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_IdentifyContaminant

### Tool Description
Computes the fingerprint genotype likelihoods from the supplied SAM/BAM file and a contamination estimate. The fingerprint is provided for the contamination (by default) for the main sample. It is given as a list of PLs at the fingerprinting sites.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: IdentifyContaminant [arguments]

Computes the fingerprint genotype likelihoods from the supplied SAM/BAM file and a contamination estimate.NOTA BENE: the
fingerprint is provided for the contamination (by default) for the main sample. It is given as a list of PLs at the
fingerprinting sites.
Version:3.4.0


Required Arguments:

--HAPLOTYPE_MAP,-H <File>     A file of haplotype information. The file lists a set of SNPs, optionally arranged in
                              high-LD blocks, to be used for fingerprinting. See
                              https://gatk.broadinstitute.org/hc/en-us/articles/360035531672-Haplotype-map-format for
                              details.  Required. 

--INPUT,-I <String>           Input SAM or BAM file.  Required. 

--OUTPUT,-O <File>            Output fingerprint file (VCF).  Required. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CONTAMINATION,-C <Double>   A value of estimated contamination in the input.   Default value: 0.0. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--EXTRACT_CONTAMINATED <Boolean>
                              Extract a fingerprint for the contaminated sample (instead of the contaminant). Setting to
                              true changes the effect of SAMPLE_ALIAS when null. It names the sample in the VCF
                              <SAMPLE>, using the SM value from the SAM header.  Default value: false. Possible values:
                              {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--LOCUS_MAX_READS <Integer>   The maximum number of reads to use as evidence for any given locus. This is provided as a
                              way to limit the effect that any given locus may have.  Default value: 200. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--SAMPLE_ALIAS <String>       The sample alias to associate with the resulting fingerprint. When null, <SAMPLE> is
                              extracted from the input file and "<SAMPLE>-contamination" is used.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_LiftOverHaplotypeMap

### Tool Description
Lifts over a haplotype database from one reference to another. Based on UCSC liftOver. Uses a UCSC chain file to guide the liftOver.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: LiftOverHaplotypeMap [arguments]

Lifts over a haplotype database from one reference to another. Based on UCSC liftOver.
Uses a UCSC chain file to guide the liftOver.
Version:3.4.0


Required Arguments:

--CHAIN <File>                Chain file that guides LiftOver. (UCSC format)  Required. 

--INPUT,-I <File>             Haplotype database to be lifted over.  Required. 

--OUTPUT,-O <File>            Where to write lifted-over haplotype database.  Required. 

--SEQUENCE_DICTIONARY,-SD <File>
                              Sequence dictionary to write into the output haplotype database. (Any file from which a
                              dictionary is extractable.)  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_MeanQualityByCycle

### Tool Description
Collect mean quality by cycle. This tool generates a data table and chart of mean quality by cycle from a BAM file. It is intended to be used on a single lane or a read group's worth of data, but can be applied to merged BAMs if needed.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: MeanQualityByCycle [arguments]

Collect mean quality by cycle.This tool generates a data table and chart of mean quality by cycle from a BAM file. It is
intended to be used on a single lane or a read group's worth of data, but can be applied to merged BAMs if needed. <br
/><br />This metric gives an overall snapshot of sequencing machine performance. For most types of sequencing data, the
output is expected to show a slight reduction in overall base quality scores towards the end of each read. Spikes in
quality within reads are not expected and may indicate that technical problems occurred during sequencing.<br /><br
/><p>Note: Metrics labeled as percentages are actually expressed as fractions!</p><h4>Usage example:</h4><pre>java -jar
picard.jar MeanQualityByCycle \<br />      I=input.bam \<br />      O=mean_qual_by_cycle.txt \<br />     
CHART=mean_qual_by_cycle.pdf</pre><hr />
Version:3.4.0


Required Arguments:

--CHART_OUTPUT,-CHART <File>  A file (with .pdf extension) to write the chart to.  Required. 

--INPUT,-I <File>             Input SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            The file to write the output to.  Required. 


Optional Arguments:

--ALIGNED_READS_ONLY <Boolean>If set to true, calculate mean quality over aligned reads only.  Default value: false.
                              Possible values: {true, false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true (default), then the sort order in the header file will be ignored.  Default value:
                              true. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--PF_READS_ONLY <Boolean>     If set to true calculate mean quality over PF reads only.  Default value: false. Possible
                              values: {true, false} 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--STOP_AFTER <Long>           Stop after processing N reads, mainly for debugging.  Default value: 0. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument CHART_OUTPUT was missing: Argument 'CHART_OUTPUT' is required
```


## picard_QualityScoreDistribution

### Tool Description
Chart the distribution of quality scores. This tool is used for determining the overall 'quality' for a library in a given run. It outputs a chart and tables indicating the range of quality scores and the total numbers of bases corresponding to those scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: QualityScoreDistribution [arguments]

Chart the distribution of quality scores.  <p>This tool is used for determining the overall 'quality' for a library in a
given run. To that effect, it outputs a chart and tables indicating the range of quality scores and the total numbers of
bases corresponding to those scores. Options include plotting the distribution of all of the reads, only the aligned
reads, or reads that have passed the Illumina Chastity filter thresholds as described <a
href='https://www.broadinstitute.org/gatk/guide/article?id=6329'>here</a>.</p><h4>Note on base quality score
options</h4>If the quality score of read bases has been modified in a previous data processing step such as GATK  <a
href='https://www.broadinstitute.org/gatk/guide/article?id=44'>Base Recalibration</a> and an OQ tag is available, this
tool can be set to plot the OQ value as well as the primary quality value for the evaluation. <br /><p>Note: Metrics
labeled as percentages are actually expressed as fractions!</p><h4>Usage Example:</h4><pre>java -jar picard.jar
QualityScoreDistribution \<br />      I=input.bam \<br />      O=qual_score_dist.txt \<br />     
CHART=qual_score_dist.pdf</pre><hr />
Version:3.4.0


Required Arguments:

--CHART_OUTPUT,-CHART <File>  A file (with .pdf extension) to write the chart to.  Required. 

--INPUT,-I <File>             Input SAM/BAM/CRAM file.  Required. 

--OUTPUT,-O <File>            The file to write the output to.  Required. 


Optional Arguments:

--ALIGNED_READS_ONLY <Boolean>If set to true calculate mean quality over aligned reads only.  Default value: false.
                              Possible values: {true, false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true (default), then the sort order in the header file will be ignored.  Default value:
                              true. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_NO_CALLS <Boolean>  If set to true, include quality for no-call bases in the distribution.  Default value:
                              false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--PF_READS_ONLY,-PF <Boolean> If set to true calculate mean quality over PF reads only.  Default value: false. Possible
                              values: {true, false} 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--STOP_AFTER <Long>           Stop after processing N reads, mainly for debugging.  Default value: 0. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument CHART_OUTPUT was missing: Argument 'CHART_OUTPUT' is required
```


## picard_ValidateSamFile

### Tool Description
Validates a SAM/BAM/CRAM file relative to the SAM format specification. Reports on troubleshooting errors like improper formatting, faulty alignments, incorrect flag values, etc.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: ValidateSamFile [arguments]

Validates a SAM/BAM/CRAM file.<p>This tool reports on the validity of a SAM/BAM/CRAM file relative to the SAM format
specification.  This is useful for troubleshooting errors encountered with other tools that may be caused by improper
formatting, faulty alignments, incorrect flag values, etc. </p> <p>By default, the tool runs in VERBOSE mode and will
exit after finding 100 errors and output them to the console (stdout). Therefore, it is often more practical to run this
tool initially using the MODE=SUMMARY option.  This mode outputs a summary table listing the numbers of all 'errors' and
'warnings'.</p> <p>When fixing errors in your file, it is often useful to prioritize the severe validation errors and
ignore the errors/warnings of lesser concern.  This can be done using the IGNORE and/or IGNORE_WARNINGS arguments.  For
helpful suggestions on error prioritization, please follow this link to obtain additional documentation on <a
href='https://www.broadinstitute.org/gatk/guide/article?id=7571'>ValidateSamFile</a>.</p><p>After identifying and fixing
your 'warnings/errors', we recommend that you rerun this tool to validate your SAM/BAM file prior to proceeding with
your downstream analysis.  This will verify that all problems in your file have been addressed.</p><h3>Usage
example:</h3><pre>java -jar picard.jar ValidateSamFile \<br />      I=input.bam \<br />      MODE=SUMMARY</pre><p>To
obtain a complete list with descriptions of both 'ERROR' and 'WARNING' messages, please see our additional <a
href='https://www.broadinstitute.org/gatk/guide/article?id=7571'>documentation</a> for this tool.</p><hr />Return codes
depend on the errors/warnings discovered:<p>-1 failed to complete execution
0  ran successfully
1  warnings but no errors
2  errors and warnings
3  errors but no warnings
Version:3.4.0


Required Arguments:

--INPUT,-I <PicardHtsPath>    Input SAM/BAM/CRAM file  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--IGNORE <Type>               List of validation error types to ignore.  This argument may be specified 0 or more times.
                              Default value: null. Possible values: {INVALID_QUALITY_FORMAT, INVALID_FLAG_PROPER_PAIR,
                              INVALID_FLAG_MATE_UNMAPPED, MISMATCH_FLAG_MATE_UNMAPPED, INVALID_FLAG_MATE_NEG_STRAND,
                              MISMATCH_FLAG_MATE_NEG_STRAND, INVALID_FLAG_FIRST_OF_PAIR, INVALID_FLAG_SECOND_OF_PAIR,
                              PAIRED_READ_NOT_MARKED_AS_FIRST_OR_SECOND, INVALID_FLAG_NOT_PRIM_ALIGNMENT,
                              INVALID_FLAG_SUPPLEMENTARY_ALIGNMENT, INVALID_FLAG_READ_UNMAPPED, INVALID_INSERT_SIZE,
                              INVALID_MAPPING_QUALITY, INVALID_CIGAR, ADJACENT_INDEL_IN_CIGAR, INVALID_MATE_REF_INDEX,
                              MISMATCH_MATE_REF_INDEX, INVALID_REFERENCE_INDEX, INVALID_ALIGNMENT_START,
                              MISMATCH_MATE_ALIGNMENT_START, MATE_FIELD_MISMATCH, INVALID_TAG_NM, MISSING_TAG_NM,
                              MISSING_HEADER, MISSING_SEQUENCE_DICTIONARY, MISSING_READ_GROUP, RECORD_OUT_OF_ORDER,
                              READ_GROUP_NOT_FOUND, RECORD_MISSING_READ_GROUP, INVALID_INDEXING_BIN,
                              MISSING_VERSION_NUMBER, INVALID_VERSION_NUMBER, TRUNCATED_FILE,
                              MISMATCH_READ_LENGTH_AND_QUALS_LENGTH, EMPTY_READ, CIGAR_MAPS_OFF_REFERENCE,
                              MISMATCH_READ_LENGTH_AND_E2_LENGTH, MISMATCH_READ_LENGTH_AND_U2_LENGTH,
                              E2_BASE_EQUALS_PRIMARY_BASE, BAM_FILE_MISSING_TERMINATOR_BLOCK, UNRECOGNIZED_HEADER_TYPE,
                              POORLY_FORMATTED_HEADER_TAG, HEADER_TAG_MULTIPLY_DEFINED,
                              HEADER_RECORD_MISSING_REQUIRED_TAG, HEADER_TAG_NON_CONFORMING_VALUE, INVALID_DATE_STRING,
                              TAG_VALUE_TOO_LARGE, INVALID_INDEX_FILE_POINTER, INVALID_PREDICTED_MEDIAN_INSERT_SIZE,
                              DUPLICATE_READ_GROUP_ID, MISSING_PLATFORM_VALUE, INVALID_PLATFORM_VALUE,
                              DUPLICATE_PROGRAM_GROUP_ID, MATE_NOT_FOUND, MATES_ARE_SAME_END,
                              MISMATCH_MATE_CIGAR_STRING, MATE_CIGAR_STRING_INVALID_PRESENCE,
                              INVALID_UNPAIRED_MATE_REFERENCE, INVALID_UNALIGNED_MATE_START, MISMATCH_CIGAR_SEQ_LENGTH,
                              MISMATCH_SEQ_QUAL_LENGTH, MISMATCH_FILE_SEQ_DICT, QUALITY_NOT_STORED, DUPLICATE_SAM_TAG,
                              CG_TAG_FOUND_IN_ATTRIBUTES, REF_SEQ_TOO_LONG_FOR_BAI, HEADER_TAG_INVALID_KEY} 

--IGNORE_WARNINGS <Boolean>   If true, only report errors and ignore warnings.  Default value: false. Possible values:
                              {true, false} 

--INDEX_VALIDATION_STRINGENCY <IndexValidationStringency>
                              If set to anything other than IndexValidationStringency.NONE and input is a BAM file with
                              an index file, also validates the index at the specified stringency. Until VALIDATE_INDEX
                              is retired, VALIDATE INDEX and INDEX_VALIDATION_STRINGENCY must agree on whether to
                              validate the index.  Default value: EXHAUSTIVE. Possible values: {EXHAUSTIVE,
                              LESS_EXHAUSTIVE, NONE} 

--IS_BISULFITE_SEQUENCED,-BISULFITE <Boolean>
                              Whether the input file consists of bisulfite sequenced reads. If so, C->T is not counted
                              as an error in computing the value of the NM tag.  Default value: false. Possible values:
                              {true, false} 

--MAX_OPEN_TEMP_FILES <Integer>
                              Relevant for a coordinate-sorted file containing read pairs only. Maximum number of file
                              handles to keep open when spilling mate info to disk. Set this number a little lower than
                              the per-process maximum number of file that may be open. This number can be found by
                              executing the 'ulimit -n' command on a Unix system.  Default value: 8000. 

--MAX_OUTPUT,-MO <Integer>    The maximum number of lines output in verbose mode  Default value: 100. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MODE,-M <Mode>              Mode of output  Default value: VERBOSE. Possible values: {VERBOSE, SUMMARY} 

--OUTPUT,-O <PicardHtsPath>   Output file or standard out if missing  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SKIP_MATE_VALIDATION,-SMV <Boolean>
                              If true, this tool will not attempt to validate mate information. In general cases, this
                              option should not be used.  However, in cases where samples have very high duplication or
                              chimerism rates (> 10%), the mate validation process often requires extremely large
                              amounts of memory to run, so this flag allows you to forego that check.  Default value:
                              false. Possible values: {true, false} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATE_INDEX <Boolean>    DEPRECATED.  Use INDEX_VALIDATION_STRINGENCY instead.  If true and input is a BAM file
                              with an index file, also validates the index.  Until this parameter is retired VALIDATE
                              INDEX and INDEX_VALIDATION_STRINGENCY must agree on whether to validate the index. 
                              Default value: true. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_ViewSam

### Tool Description
Very simple command that just reads a SAM or BAM file and writes out the header and each record to standard out. When an (optional) intervals file is specified, only records overlapping those intervals will be output.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: ViewSam [arguments]

Very simple command that just reads a SAM or BAM file andwrites out the header and each record to standard out. When an
(optional) intervalsfile is specified, only records overlapping those intervals will be output.
All reads, just the aligned reads, or just the unaligned reads can be printed out bysetting AlignmentStatus accordingly.
The SAM or BAM header can be printed out separatelyusing HEADER_ONLY. Only the alignment records can be printed using
RECORDS_ONLY.However, HEADER_ONLY and RECORDS_ONLY cannot both be specified at one time.<p><h4>Usage example:
</h4><pre>java -jar picard.jar ViewSam  <br />      I=sample.bam  <br />      HEADER_ONLY=true</pre>
Version:3.4.0


Required Arguments:

--ALIGNMENT_STATUS <AlignmentStatus>
                              Print out all reads, just the aligned reads or just the unaligned reads.  Required.
                              Possible values: {Aligned, Unaligned, All} 

--INPUT,-I <String>           The SAM or BAM file or GA4GH url to view.  Required. 

--PF_STATUS <PfStatus>        Print out all reads, just the PF reads or just the non-PF reads.  Required. Possible
                              values: {PF, NonPF, All} 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--HEADER_ONLY <Boolean>       Print the SAM header only.  Default value: false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INTERVAL_LIST <File>        An intervals file used to restrict what records are output.  Default value: null. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--RECORDS_ONLY <Boolean>      Print the alignment records only.  Default value: false. Possible values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_BpmToNormalizationManifestCsv

### Tool Description
BpmToNormalizationManifestCsv takes an Illumina BPM (Bead Pool Manifest) file and generates an Illumina-formatted bpm.csv file from it. A bpm.csv is a file that was generated by an old version of Illumina's Autocall software. Since it contained normalization IDs (needed to calculate normalized intensities), it came into use in several programs notably zCall (https://github.com/jigold/zCall).

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: BpmToNormalizationManifestCsv [arguments]

BpmToNormalizationManifestCsv takes an Illumina BPM (Bead Pool Manifest) file and generates an Illumina-formatted
bpm.csv file from it. A bpm.csv is a file that was generated by an old version of Illumina's Autocall software. Since it
contained normalization IDs (needed to calculate normalized intensities), it came into use in several programs notably
zCall (https://github.com/jigold/zCall).<h4>Usage example:</h4><pre>java -jar picard.jar BpmToNormalizationManifestCsv
\<br />      INPUT=input.bpm \<br />      CLUSTER_FILE=input.egt \<br />      OUTPUT=output.bpm.csv</pre>
Version:3.4.0


Required Arguments:

--CLUSTER_FILE,-CF <File>     An Illumina cluster file (egt)  Required. 

--INPUT,-I <File>             The Illumina Bead Pool Manifest (.bpm) file  Required. 

--OUTPUT,-O <File>            The output (bpm.csv) file to write.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CombineGenotypingArrayVcfs

### Tool Description
CombineGenotypingArrayVcfs takes one or more VCF files, as generated by GtcToVcf and combines them into a single VCF. The input VCFs must have the same sequence dictionary and same list of variant loci. The input VCFs must not share sample Ids.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CombineGenotypingArrayVcfs [arguments]

CombineGenotypingArrayVcfs takes one or more VCF files, as generated by GtcToVcf and combines them into a single VCF.
The input VCFs must have the same sequence dictionary and same list of variant loci. The input VCFs must not share
sample Ids. <h4>Usage example:</h4><pre>java -jar picard.jar CombineGenotypingArrayVcfs \<br />      INPUT=input1.vcf
\<br />      INPUT=input2.vcf \<br />      OUTPUT=output.vcf</pre>
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input VCF file(s).  This argument must be specified at least once. Required. 

--OUTPUT,-O <File>            Output VCF file.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: true. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CompareGtcFiles

### Tool Description
CompareGtcFiles takes two Illumina GTC file and compares their contents to ensure that fields expected to be the same are in fact the same. This will exclude any variable field, such as a date. The GTC files must be generated on the same chip type.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CompareGtcFiles [arguments]

CompareGtcFiles takes two Illumina GTC file and compares their contents to ensure that fields expected to be the same
are in fact the same.  This will exclude any variable field, such as a date. The GTC files must be generated on the same
chip type. <h4>Usage example:</h4><pre>java -jar picard.jar CompareGtcFiles \<br />      INPUT=input1.gtc \<br />     
INPUT=input2.gtc \<br />      BPM_FILE=chip_name.bpm \<br /></pre>
Version:3.4.0


Required Arguments:

--ILLUMINA_BEAD_POOL_MANIFEST_FILE,-BPM_FILE <File>
                              The Illumina Bead Pool Manifest (.bpm) file  Required. 

--INPUT,-I <File>             GTC input files to compare.  This argument must be specified at least once. Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CreateBafRegressMetricsFile

### Tool Description
CreateBafRegressMetricsFile takes an output file as generated by the bafRegress tool and creates a picard metrics file. BAFRegress is a software that detects and estimates sample contamination using B allele frequency data from Illumina genotyping arrays using a regression model.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CreateBafRegressMetricsFile [arguments]

CreateBafRegressMetricsFile takes an output file as generated by the bafRegress tool and creates a picard metrics file.
BAFRegress <a href='https://genome.sph.umich.edu/wiki/BAFRegress'>bafRegress</a> is a software that detects and
estimates sample contamination using B allele frequency data from Illumina genotyping arrays using a regression
model.<h4>Usage example:</h4><pre>java -jar picard.jar CreateBafRegressMetricsFile \<br />     
INPUT=bafRegress.output.txt \<br />      OUTPUT=outputBaseName</pre>
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The output of bafRegress (typically captured stdout).  Required. 

--OUTPUT,-O <File>            Basename for the metrics file that will be written. Resulting file will be
                              <OUTPUT>.bafregress_metrics  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CreateExtendedIlluminaManifest

### Tool Description
CreateExtendedIlluminaManifest takes an Illumina manifest file (this is the text version of an Illumina '.bpm' file) and creates an 'extended' version of this text file by adding fields that facilitate VCF generation by downstream tools. As part of generating this extended version of the manifest, the tool may mark loci as 'FAIL' if they do not pass validation.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CreateExtendedIlluminaManifest [arguments]

CreateExtendedIlluminaManifest takes an Illumina manifest file (this is the text version of an Illumina '.bpm' file) And
creates an 'extended' version of this text file by adding fields that facilitate VCF generation by downstream tools. As
part of generating this extended version of the manifest, the tool may mark loci as 'FAIL' if they do not pass
validation. <h4>Usage example:</h4><pre>java -jar picard.jar CreateExtendedIlluminaManifest \<br />      --INPUT
illumina_chip_manifest.csv \<br />      --OUTPUT illumina_chip_manifest.extended.csv \<br />      --REPORT_FILE
illumina_chip_manifest.report.txt \<br />      --CLUSTER_FILE illumina_chip_manifest.egt \<br />     
--REFERENCE_SEQUENCE reference.fasta \<br />      --TB 37 \<br /></pre>Some Illumina manifest files have records that
are not consistently on the the build that this tool supports (currently Build 37).  To assist with migrating these
records to Build 37, you can provide a liftover chain file and CreateExtendedIlluminaManifest will attempt to lift these
records from the indicated build to Build 37. If you do not provide a liftover file, or there are records on builds
other than the liftover file that you have provided, then those records will be marked as 'FAIL' in the extended
manifest. <h4>Usage example with liftover:<h4><pre>java -jar picard.jar CreateExtendedIlluminaManifest \<br />     
--INPUT illumina_chip_manifest.csv \<br />      --OUTPUT illumina_chip_manifest.extended.csv \<br />      --REPORT_FILE
illumina_chip_manifest.report.txt \<br />      --CLUSTER_FILE illumina_chip_manifest.egt \<br />     
--REFERENCE_SEQUENCE reference.fasta \<br />      --TB 37 \<br />      --SB 36 \<br />      --SR build36_reference.fasta
\<br />      --SC build36ToBuild37_liftover.chain \<br /></pre>  (that will lifover any records found on build 36 to
build 37 using the build36ToBuild37 liftover file 
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             This is the text version of the Illumina .bpm file  Required. 

--OUTPUT,-O <File>            The name of the extended manifest to be written.  Required. 

--REFERENCE_SEQUENCE,-R <File>The reference sequence (fasta) for the TARGET genome build.  Required. 

--REPORT_FILE,-RF <File>      The name of the the report file  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--BAD_ASSAYS_FILE,-BAF <File> The name of the the 'bad assays file'. This is a subset version of the extended manifest,
                              containing only unmappable assays  Default value: null. 

--CLUSTER_FILE,-CF <File>     The Standard (Hapmap-trained) cluster file (.egt) from Illumina. If there are duplicate
                              assays at a site, this is used to decide which is the 'best' (non-filtered in generated
                              VCFs) by choosing the assay with the best GenTrain scores)  Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DBSNP_FILE,-DBSNP <File>    Reference dbSNP file in VCF format.  Default value: null. 

--FLAG_DUPLICATES,-FD <Boolean>
                              Flag duplicates in the extended manifest.  If this is set and there are multiple passing
                              assays at the same site (same locus and alleles) then all but one will be marked with the
                              'DUPE' flag in the extended manifest. The one that is not marked as 'DUPE' will be the one
                              with the highest Gentrain score as read from the cluster file.  Default value: true.
                              Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--SUPPORTED_BUILD,-SB <String>A supported build. The order of the input must match the order for
                              SUPPORTED_REFERENCE_FILE and SUPPORTED_CHAIN_FILE. This is the name of the build as
                              specified in the 'GenomeBuild' column of the Illumina manifest file.  This argument may be
                              specified 0 or more times. Default value: null. 

--SUPPORTED_CHAIN_FILE,-SC <File>
                              A chain file that maps from SUPPORTED_BUILD -> TARGET_BUILD. Must provide a corresponding
                              supported reference file.  This argument may be specified 0 or more times. Default value:
                              null. 

--SUPPORTED_REFERENCE_FILE,-SR <File>
                              A reference file for the provided SUPPORTED_BUILD. This is the reference file that
                              corresponds to the 'SUPPORTED_BUILD' as specified above.  This argument may be specified 0
                              or more times. Default value: null. 

--TARGET_BUILD,-TB <String>   The target build.  This specifies the reference for which the extended manifest will be
                              generated. Currently this tool only supports Build 37 (Genome Reference Consortium Human
                              Build 37 (GRCh37)). If entries are found in the Illumina manifest that are on this build
                              they will be used with the coordinate specified in the manifest, If there are entries
                              found on other builds, they will be marked as failed in the extended manifest UNLESS the
                              build and liftover information (SUPPORTED_BUILD, SUPPORTED_REFERENCE_FILE, and
                              SUPPORTED_CHAIN_FILE) is supplied.  Default value: 37. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CreateVerifyIDIntensityContaminationMetricsFile

### Tool Description
CreateVerifyIDIntensityContaminationMetricsFile takes an output file as generated by the VerifyIDIntensity tool and creates a picard metrics file. VerifyIDIntensity is a tool for detecting and estimating sample contamination of Illumina genotyping array data.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CreateVerifyIDIntensityContaminationMetricsFile [arguments]

CreateVerifyIDIntensityContaminationMetricsFile takes an output file as generated by the VerifyIDIntensity tool and
creates a picard metrics file. VerifyIDIntensity <a
href='https://genome.sph.umich.edu/wiki/VerifyIDintensity'>VerifyIDintensity</a> is a tool for detecting and estimating
sample contamination of Illumina genotyping array data.<h4>Usage example:</h4><pre>java -jar picard.jar
CreateVerifyIDIntensityContaminationMetricsFile \<br />      INPUT=VerifyIDIntensityOutput.txt \<br />     
OUTPUT=outputBaseName</pre>
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The output of VerifyIDIntensity(typically captured stdout).  Required. 

--OUTPUT,-O <File>            Basename for the metrics file that will be written. Resulting file will be
                              <OUTPUT>.verifyidintensity_metrics  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_GtcToVcf

### Tool Description
GtcToVcf takes an Illumina GTC file and converts it to a VCF file using several supporting files. A GTC file is an Illumina-specific file containing called genotypes in AA/AB/BB format. A VCF, aka Variant Calling Format, is a text file for storing how a sequenced sample differs from the reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: GtcToVcf [arguments]

GtcToVcf takes an Illumina GTC file and converts it to a VCF file using several supporting files. A GTC file is an
Illumina-specific file containing called genotypes in AA/AB/BB format. <a
href='https://github.com/Illumina/BeadArrayFiles/blob/develop/docs/GTC_File_Format_v5.pdf'></a> A VCF, aka Variant
Calling Format, is a text file for storing how a sequenced sample differs from the reference genome. <a
href='http://software.broadinstitute.org/software/igv/book/export/html/184'></a><h4>Usage example:</h4><pre>java -jar
picard.jar GtcToVcf \<br />      INPUT=input.gtc \<br />      REFERENCE_SEQUENCE=reference.fasta \<br />     
OUTPUT=output.vcf \<br />      EXTENDED_ILLUMINA_MANIFEST=chip_name.extended.csv \<br />      CLUSTER_FILE=chip_name.egt
\<br />      ILLUMINA_BEAD_POOL_MANIFEST_FILE=chip_name.bpm \<br />      SAMPLE_ALIAS=my_sample_alias \<br /></pre>
Version:3.4.0


Required Arguments:

--CLUSTER_FILE,-CF <File>     An Illumina cluster file (egt)  Required. 

--EXTENDED_ILLUMINA_MANIFEST,-MANIFEST <File>
                              An Extended Illumina Manifest file (csv).  This is an extended version of the Illumina
                              manifest it contains additional reference-specific fields  Required. 

--ILLUMINA_BEAD_POOL_MANIFEST_FILE,-BPM_FILE <File>
                              The Illumina Bead Pool Manifest (.bpm) file  Required. 

--INPUT,-I <File>             GTC file to be converted  Required. 

--OUTPUT,-O <File>            The output VCF file to write.  Required. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Required. 

--SAMPLE_ALIAS <String>       The sample alias  Required. 


Optional Arguments:

--ANALYSIS_VERSION_NUMBER <Integer>
                              The analysis version of the data used to generate this VCF  Default value: null. 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DO_NOT_ALLOW_CALLS_ON_ZEROED_OUT_ASSAYS <Boolean>
                              Causes the program to fail if it finds a case where there is a call on an assay that is
                              flagged as 'zeroed-out' in the Illumina cluster file.  Default value: false. Possible
                              values: {true, false} 

--EXPECTED_GENDER,-E_GENDER <String>
                              The expected gender for this sample.  Default value: null. 

--FINGERPRINT_GENOTYPES_VCF_FILE,-FP_VCF <File>
                              The fingerprint VCF for this sample  Default value: null. 

--GENDER_GTC,-G_GTC <File>    An optional GTC file that was generated by calling the chip using a cluster file designed
                              to optimize gender calling.  Default value: null. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--PIPELINE_VERSION <String>   The version of the pipeline used to generate this VCF  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_MergePedIntoVcf

### Tool Description
MergePedIntoVcf takes a single-sample ped file output from zCall and merges into a single-sample vcf file using several supporting files.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: MergePedIntoVcf [arguments]

MergePedIntoVcf takes a single-sample ped file output from zCall and merges into a single-sample vcf file using several
supporting files.A VCF, aka Variant Calling Format, is a text file for storing how a sequenced sample differs from the
reference genome. <a href='https://samtools.github.io/hts-specs/VCFv4.2.pdf'></a>A PED file is a whitespace-separated
text file for storing genotype information. <a href='http://zzz.bwh.harvard.edu/plink/data.shtml#ped'></a>A MAP file is
a whitespace-separated text file for storing information about genetic distance. <a
href='http://zzz.bwh.harvard.edu/plink/data.shtml#map'></a>A zCall thresholds file is a whitespace-separated text file
for storing the thresholds for genotype clustering for a SNP as determined by zCall.<a
href='https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3463112/#SEC2title'></a><h4>Usage example:</h4><pre>java -jar
picard.jar MergePedIntoVcf \<br />      VCF=input.vcf \<br />      PED=zcall.output.ped \<br />     
MAP=zcall.output.map \<br />      ZCALL_T_FILE=zcall.thresholds.7.txt \<br />      OUTPUT=output.vcf <br /></pre>
Version:3.4.0


Required Arguments:

--MAP_FILE,-MAP <File>        MAP file for the PED file.  Required. 

--ORIGINAL_VCF,-VCF <File>    The vcf containing the original autocall genotypes.  Required. 

--OUTPUT,-O <File>            The output VCF file to write with merged genotype calls.  Required. 

--PED_FILE,-PED <File>        PED file to be merged into VCF.  Required. 

--ZCALL_THRESHOLDS_FILE,-ZCALL_T_FILE <File>
                              The zcall thresholds file.  Required. 

--ZCALL_VERSION <String>      The version of zcall used  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument ORIGINAL_VCF was missing: Argument 'ORIGINAL_VCF' is required
```


## picard_VcfToAdpc

### Tool Description
VcfToAdpc takes a VCF, as generated by GtcToVcf and generates an Illumina 'adpc.bin' file from it. An adpc.bin file is a binary file containing genotyping array intensity data that can be exported by Illumina's GenomeStudio and Beadstudio analysis tools. The adpc.bin file is used as an input to VerifyIDintensity a tool for detecting and estimating sample contamination of Illumina genotyping array data.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: VcfToAdpc [arguments]

VcfToAdpc takes a VCF, as generated by GtcToVcf and generates an Illumina 'adpc.bin' file from it. An adpc.bin file is a
binary file containing genotyping array intensity data that can be exported by Illumina's GenomeStudio and Beadstudio
analysis tools. The adpc.bin file is used as an input to <a
href='https://genome.sph.umich.edu/wiki/VerifyIDintensity'>VerifyIDintensity</a> a tool for detecting and estimating
sample contamination of Illumina genotyping array data. If more than one VCF is used, they must all have the same number
of loci.<h4>Usage example:</h4><pre>java -jar picard.jar VcfToAdpc \<br />      VCF=input.vcf \<br />     
OUTPUT=output.adpc.bin \<br />      SAMPLES_FILE=output.samples.txt \<br />      NUM_MARKERS_FILE=output.num_markers.txt
\<br /></pre>
Version:3.4.0


Required Arguments:

--NUM_MARKERS_FILE,-NMF <File>A text file into which the number of loci in the VCF will be written. This is useful for
                              calling verifyIDIntensity.  Required. 

--OUTPUT,-O <File>            The output (adpc.bin) file to write.  Required. 

--SAMPLES_FILE,-SF <File>     A text file into which the names of the samples will be written. These will be in the same
                              order as the data in the adpc.bin file.  Required. 

--VCF <File>                  One or more VCF files containing array intensity data.  This argument must be specified at
                              least once. Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument VCF was missing: Argument 'VCF' is required
```


## picard_BedToIntervalList

### Tool Description
Converts a BED file to a Picard Interval List. This tool provides easy conversion from BED to the Picard interval_list format which is required by many Picard processing tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: BedToIntervalList [arguments]

Converts a BED file to a Picard Interval List.  This tool provides easy conversion from BED to the Picard interval_list
format which is required by many Picard processing tools. Note that the coordinate system of BED files is such that the
first base or position in a sequence is numbered "0", while in interval_list files it is numbered "1".<br /><br />BED
files contain sequence data displayed in a flexible format that includes nine optional fields, in addition to three
required fields within the annotation tracks. The required fields of a BED file include:<pre>     chrom - The name of
the chromosome (e.g. chr20) or scaffold (e.g. scaffold10671) <br />     chromStart - The starting position of the
feature in the chromosome or scaffold. The first base in a chromosome is numbered "0" <br />     chromEnd - The ending
position of the feature in the chromosome or scaffold.  The chromEnd base is not included in the display of the feature.
For example, the first 100 bases of a chromosome are defined as chromStart=0, chromEnd=100, and span the bases numbered
0-99.</pre>In each annotation track, the number of fields per line must be consistent throughout a data set. For
additional information regarding BED files and the annotation field options, please see:
http://genome.ucsc.edu/FAQ/FAQformat.html#format1.<br /> <br /> Interval_list files contain sequence data distributed
into intervals. The interval_list file format is relatively simple and reflects the SAM alignment format to a degree.  A
SAM style header must be present in the file that lists the sequence records against which the intervals are described. 
After the header, the file then contains records, one per line in plain text format with the following values
tab-separated::<pre>      -Sequence name (SN) - The name of the sequence in the file for identification purposes, can be
chromosome number e.g. chr20 <br />      -Start position - Interval start position (starts at +1) <br />      -End
position - Interval end position (1-based, end inclusive) <br />      -Strand - Indicates +/- strand for the interval
(either + or -) <br />      -Interval name - (Each interval should have a unique name) </pre><br/>This tool requires a
sequence dictionary, provided with the SEQUENCE_DICTIONARY or SD argument. The value given to this argument can be any
of the following:<pre>    - A file with .dict extension generated using Picard's CreateSequenceDictionaryTool</br>    -
A reference.fa or reference.fasta file with a reference.dict in the same directory</br>    - Another IntervalList with
@SQ lines in the header from which to generate a dictionary</br>    - A VCF that contains #contig lines from which to
generate a sequence dictionary</br>    - A SAM or BAM file with @SQ lines in the header from which to generate a
dictionary</br></pre><h4>Usage example:</h4><pre>java -jar picard.jar BedToIntervalList \<br />      I=input.bed \<br />
O=list.interval_list \<br />      SD=reference_sequence.dict</pre><br /> <br /> <hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The input BED file  Required. 

--OUTPUT,-O <File>            The output Picard Interval List  Required. 

--SEQUENCE_DICTIONARY,-SD <File>
                              The sequence dictionary, or BAM/VCF/IntervalList from which a dictionary can be extracted.
                              Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--KEEP_LENGTH_ZERO_INTERVALS <Boolean>
                              If true, write length zero intervals in input bed file to resulting interval list file. 
                              Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SORT <Boolean>              If true, sort the output interval list before writing it.  Default value: true. Possible
                              values: {true, false} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--UNIQUE <Boolean>            If true, unique the output interval list by merging overlapping regions, before writing it
                              (implies sort=true).  Default value: false. Possible values: {true, false} 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_IntervalListToBed

### Tool Description
Converts an Picard IntervalList file to a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: IntervalListToBed [arguments]

Converts an Picard IntervalList file to a BED file.
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input IntervalList file.  Required. 

--OUTPUT,-O <File>            Output BED file.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SCORE <Integer>             The score, between 0-1000, to output for each interval in the BED file.  Default value:
                              500. 

--SORT <Boolean>              If true, sort the interval list prior to outputting as BED file.  Default value: true.
                              Possible values: {true, false} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_IntervalListTools

### Tool Description
A tool for performing various IntervalList manipulations including sorting, merging, subtracting, padding, and other set-theoretic operations. Both IntervalList and VCF files are accepted as input.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: IntervalListTools [arguments]

A tool for performing various IntervalList manipulations <h3>Summary</h3>This tool offers multiple interval list file
manipulation capabilities, including: sorting, merging, subtracting, padding, and other set-theoretic operations. The
default action is to merge and sort the intervals provided in the INPUTs. Other options, e.g. interval subtraction, are
controlled by the arguments.<br />Both IntervalList and VCF files are accepted as input. IntervalList should be denoted
with the extension .interval_list, while a VCF must have one of .vcf, .vcf.gz, .bcf When VCF file is used as input, each
variant is translated into an using its reference allele or the END INFO annotation (if present) to determine the extent
of the interval. 
IntervalListTools can also "scatter" the resulting interval-list into many interval-files. This can be useful for
creating multiple interval lists for scattering an analysis over.

<h3>Details</h3> The IntervalList file format is designed to help the users avoid mixing references when supplying
intervals and other genomic data to a single tool. A SAM style header must be present at the top of the file. After the
header, the file then contains records, one per line in text format with the followingvalues tab-separated: 

- Sequence name (SN) 
- Start position (1-based)
- End position (1-based, inclusive)
- Strand (either + or -)
- Interval name (ideally unique names for intervals)

The coordinate system is 1-based, closed-ended so that the first base in a sequence has position 1, and both the start
and the end positions are included in an interval.

Example interval list file<pre>@HD	VN:1.0
@SQ	SN:chr1	LN:501
@SQ	SN:chr2	LN:401
chr1	1	100	+	starts at the first base of the contig and covers 100 bases
chr2	100	100	+	interval with exactly one base
</pre>

<h3>Usage Examples</h3><h4>1. Combine the intervals from two interval lists:</h4><pre>java -jar picard.jar
IntervalListTools \
ACTION=CONCAT \
I=input.interval_list \
I=input_2.interval_list \
O=new.interval_list</pre> <h4>2. Combine the intervals from two interval lists, sorting the resulting in list and
merging overlapping and abutting intervals:</h4> <pre> java -jar picard.jar IntervalListTools \
ACTION=CONCAT \
SORT=true \
UNIQUE=true \
I=input.interval_list \
I=input_2.interval_list \
O=new.interval_list </pre> <h4>3. Subtract the intervals in SECOND_INPUT from those in INPUT</h4> <pre> java -jar
picard.jar IntervalListTools \
ACTION=SUBTRACT \
I=input.interval_list \
SI=input_2.interval_list \
O=new.interval_list </pre> <h4>4. Find bases that are in either input1.interval_list or input2.interval_list, and also
in input3.interval_list:</h4> <pre> java -jar picard.jar IntervalListTools \
ACTION=INTERSECT \
I=input1.interval_list \
I=input2.interval_list \
SI=input3.interval_list \
O=new.interval_list </pre> <h4>5. Combine overlapping intervals but NOT abutting intervals:</h4> <pre> java -jar
picard.jar IntervalListTools \
ACTION=UNION \
DONT_MERGE_ABUTTING=true \
I=input1.interval_list \
O=new.interval_list </pre>
Version:3.4.0


Required Arguments:

--INPUT,-I <PicardHtsPath>    One or more interval lists. If multiple interval lists are provided the output is
                              theresult of merging the inputs. Supported formats are interval_list and VCF.If file
                              extension is unrecognized, assumes file is interval_listFor standard input (stdin), write
                              /dev/stdin as the input file  This argument must be specified at least once. Required. 


Optional Arguments:

--ACTION <Action>             Action to take on inputs.  Default value: CONCAT. CONCAT (The concatenation of all the
                              intervals in all the INPUTs, no sorting or merging of overlapping/abutting intervals
                              implied. Will result in a possibly unsorted list unless requested otherwise.)
                              UNION (Like CONCATENATE but with UNIQUE and SORT implied, the result being the set-wise
                              union of all INPUTS, with overlapping and abutting intervals merged into one.)
                              INTERSECT (The sorted and merged set of all loci that are contained in all of the INPUTs.)
                              SUBTRACT (Subtracts the intervals in SECOND_INPUT from those in INPUT. The resulting loci
                              are those in INPUT that are not in SECOND_INPUT.)
                              SYMDIFF (Results in loci that are in INPUT or SECOND_INPUT but are not in both.)
                              OVERLAPS (Outputs the entire intervals from INPUT that have bases which overlap any
                              interval from SECOND_INPUT. Note that this is different than INTERSECT in that each
                              original interval is either emitted in its entirety, or not at all.)

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--BREAK_BANDS_AT_MULTIPLES_OF,-BRK <Integer>
                              If set to a positive value will create a new interval list with the original intervals
                              broken up at integer multiples of this value. Set to 0 to NOT break up intervals.  Default
                              value: 0. 

--COMMENT <String>            One or more lines of comment to add to the header of the output file (as @CO lines in the
                              SAM header).  This argument may be specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--COUNT_OUTPUT <PicardHtsPath>File to which to print count of bases or intervals in final output interval list.  When
                              not set, value indicated by OUTPUT_VALUE will be printed to stdout.  If this parameter is
                              set, OUTPUT_VALUE must not be NONE.  Default value: null. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DONT_MERGE_ABUTTING <Boolean>
                              If false, do not merge abutting intervals (keep them separate). Note: abutting intervals
                              are combined by default with the UNION action.  Default value: false. Possible values:
                              {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_FILTERED <Boolean>  Whether to include filtered variants in the vcf when generating an interval list from vcf.
                              Default value: false. Possible values: {true, false} 

--INVERT <Boolean>            Produce the inverse list of intervals, that is, the regions in the genome that are
                              <br>not</br> covered by any of the input intervals. Will merge abutting intervals first.
                              Output will be sorted.  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--OUTPUT,-O <PicardHtsPath>   The output interval list file to write (if SCATTER_COUNT == 1) or the directory into which
                              to write the scattered interval sub-directories (if SCATTER_COUNT > 1).  Default value:
                              null. 

--OUTPUT_VALUE <Output>       What value to output to COUNT_OUTPUT file or stdout (for scripting).  If COUNT_OUTPUT is
                              provided, this parameter must not be NONE.  Default value: NONE. Possible values: {NONE,
                              BASES, INTERVALS} 

--PADDING <Integer>           The amount to pad each end of the intervals by before other operations are undertaken.
                              Negative numbers are allowed and indicate intervals should be shrunk. Resulting intervals
                              < 0 bases long will be removed. Padding is applied to the interval lists (both INPUT and
                              SECOND_INPUT, if provided) <b> before </b> the ACTION is performed.  Default value: 0. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SCATTER_CONTENT <Integer>   When scattering with this argument, each of the resultant files will (ideally) have this
                              amount of 'content', which  means either base-counts or interval-counts depending on
                              SUBDIVISION_MODE. When provided, overrides SCATTER_COUNT  Default value: null. 

--SCATTER_COUNT <Integer>     The number of files into which to scatter the resulting list by locus; in some situations,
                              fewer intervals may be emitted.    Default value: 1. 

--SECOND_INPUT,-SI <PicardHtsPath>
                              Second set of intervals for SUBTRACT and DIFFERENCE operations.  This argument may be
                              specified 0 or more times. Default value: null. 

--SORT <Boolean>              If true, sort the resulting interval list by coordinate.  Default value: true. Possible
                              values: {true, false} 

--SUBDIVISION_MODE,-M <IntervalListScatterMode>
                              The mode used to scatter the interval list.  Default value: INTERVAL_SUBDIVISION.
                              INTERVAL_SUBDIVISION (Scatter the interval list into similarly sized interval lists (by
                              base count), breaking up intervals as needed.)
                              BALANCING_WITHOUT_INTERVAL_SUBDIVISION (Scatter the interval list into similarly sized
                              interval lists (by base count), but without breaking up intervals.)
                              BALANCING_WITHOUT_INTERVAL_SUBDIVISION_WITH_OVERFLOW (Scatter the interval list into
                              similarly sized interval lists (by base count), but without breaking up intervals. Will
                              overflow current interval list so that the remaining lists will not have too many bases to
                              deal with.)
                              INTERVAL_COUNT (Scatter the interval list into similarly sized interval lists (by interval
                              count, not by base count). Resulting interval lists will contain the same number of
                              intervals except for the last, which contains the remainder.)
                              INTERVAL_COUNT_WITH_DISTRIBUTED_REMAINDER (Scatter the interval list into similarly sized
                              interval lists (by interval count, not by base count). Resulting interval lists will
                              contain similar number of intervals.)

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--UNIQUE <Boolean>            If true, merge overlapping and adjacent intervals to create a list of unique intervals.
                              Implies SORT=true.  Default value: false. Possible values: {true, false} 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_LiftOverIntervalList

### Tool Description
Lifts over an interval list from one reference build to another. This tool adjusts the coordinates in an interval list on one reference to its homologous interval list on another reference, based on a chain file that describes the correspondence between the two references.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: LiftOverIntervalList [arguments]

Lifts over an interval list from one reference build to another. This tool adjusts the coordinates in an interval list
on one reference to its homologous interval list on another reference, based on a chain file that describes the
correspondence between the two references. It is based on the UCSC LiftOver tool (see:
http://genome.ucsc.edu/cgi-bin/hgLiftOver) and uses a UCSC chain file to guide its operation. It accepts a Picard
interval_list file as an input. See IntervalListTools documentation for information on interval_list format.Note: for
lifting over VCF files use LiftoverVcf tool. 

<h3>Usage example:</h3>java -jar picard.jar LiftOverIntervalList \
I=input.interval_list \
O=output.interval_list \
SD=reference_sequence.dict \
CHAIN=build.chain</pre>
<h3>Return codes</h3>
If all the intervals lifted over successfully, program will return 0. It will return 1 otherwise.

<h3>Caveats</h3>
An interval is "lifted" in its entirety, but it might intersect (a "hit") with multiple chain-blocks. Instead of placing
the interval in multiple hits, it is lifted over using the first hit that passes the threshold of MIN_LIFTOVER_PCT. For
large enough MIN_LIFTOVER_PCT this is non-ambiguous, but if one uses small values of MIN_LIFTOVER_PCT (perhaps in order
to increase the rate of successful hits...) the liftover could end up going to the smaller of two good hits. On the
other hand, if none of the hits pass the threshold a warning will be emitted and the interval will not be lifted.
Version:3.4.0


Required Arguments:

--CHAIN <File>                Chain file that guides the LiftOver process.  Required. 

--INPUT,-I <File>             The input interval list to be lifted over.  Required. 

--OUTPUT,-O <File>            The output interval list file.  Required. 

--SEQUENCE_DICTIONARY,-SD <File>
                              Sequence dictionary to place in the output interval list. (This should be any file from
                              which the dictionary of the target reference can be extracted.)  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MIN_LIFTOVER_PCT <Double>   Minimum percentage of bases in each input interval that must map to output interval for
                              liftover of that interval to occur. If the program fails to find a good target for an
                              interval, a warning will be emitted and the interval will be dropped from the output.  
                              Default value: 0.95. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--REJECT <File>               Interval List file for intervals that were rejected  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_FifoBuffer

### Tool Description
Acts as a large memory buffer between processes that are connected with unix pipes for the case that one or more processes produces or consumes their input or output in bursts. By inserting a large memory buffer between such processes each process can run at full speed and the bursts can be smoothed out by the memory buffer.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: FifoBuffer [arguments]

Acts as a large memory buffer between processes that are connected with unix pipes for the case that one or more
processes produces or consumes their input or output in bursts.  By inserting a large memory buffer between such
processes each process can run at full speed and the bursts can be smoothed out by the memory buffer.

<h3>Example</h3>
java -jar SamToFastq.jar \
F=my.fastq \
INTERLEAVE=true |
java -jar FifoBuffer |
bwa mem -t 8 \dev\stdin output.bam

Version:3.4.0

Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--BUFFER_SIZE <Integer>       The size of the memory buffer in bytes.  Default value: 536870912. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DEBUG_FREQUENCY <Integer>   How frequently, in seconds, to report debugging statistics. Set to zero for never. 
                              Default value: 0. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--IO_SIZE <Integer>           The size, in bytes, to read/write atomically to the input and output streams.  Default
                              value: 65536. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--NAME <String>               Name to use for Fifo in debugging statements.  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: true. Possible values:
                              {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false}
```


## picard_SortGff

### Tool Description
This tool sorts a gff3 file by coordinates, so that it can be indexed. It additionally adds flush directives where possible, which can significantly reduce the memory footprint of downstream tools. Sorting of multiple contigs can be specified by a sequence dictionary; if no sequence dictionary is specified, contigs are sorted lexicographically.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: SortGff [arguments]

<h3> Summary </h3>
<p> This tool sorts a gff3 file by coordinates, so that it can be indexed.
It additionally adds flush directives where possible, which can significantly reduce the memory footprint of downstream
tools.
Sorting of multiple contigs can be specified by a sequence dictionary; if no sequence dictionary is specified, contigs
are sorted lexicographically. </p>

<h3> Usage Examples </h3>
<h4> 1. Sort gff3 file, add flush directives.  Contigs will be sorted lexicographically.</h4>
<pre>
java -jar picard.jar SortGff
I=input.gff3
O=output.gff3
</pre>

<h4> 2. Sort gff3 file, add flush directives.  Contigs will be sorted according to order of sequence dictionary</h4>
<pre>
java -jar picard.jar SortGff
I=input.gff3
O=output.gff3
SD=dictionary.dict
</pre>
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input Gff3 file to sort.  Required. 

--OUTPUT,-O <File>            Sorted Gff3 output file.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--nRecordsInMemory <Integer>  Number of records to hold in memory before spilling to disk  Default value: 50000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SEQUENCE_DICTIONARY,-SD <File>
                              Dictionary to sort contigs by.  If dictionary is not provided, contigs are sorted
                              lexicographically.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_AddCommentsToBam

### Tool Description
Adds comments to the header of a BAM file. This tool makes a copy of the input bam file, with a modified header that includes the comments specified at the command line (prefixed by @CO).

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: AddCommentsToBam [arguments]

Adds comments to the header of a BAM file.This tool makes a copy of the input bam file, with a modified header that
includes the comments specified at the command line (prefixed by @CO). Use double quotes to wrap comments that include
whitespace or special characters. <br /><br />Note that this tool cannot be run on SAM files.<br /><h4>Usage
example:</h4><pre>java -jar picard.jar AddCommentsToBam \<br />      I=input.bam \<br />      O=modified_bam.bam \<br />
C=comment_1 \<br />      C="comment 2"</pre><hr />
Version:3.4.0


Required Arguments:

--COMMENT,-C <String>         Comments to add to the BAM file  This argument must be specified at least once. Required. 

--INPUT,-I <File>             Input BAM file to add a comment to the header  Required. 

--OUTPUT,-O <File>            Output BAM file to write results  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_AddOATag

### Tool Description
This tool takes in an aligned SAM or BAM and adds the OA tag to every aligned read unless an interval list is specified, where it only adds the tag to reads that fall within the intervals in the interval list. This can be useful if you are about to realign but want to keep the original alignment information as a separate tag.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: AddOATag [arguments]

This tool takes in an aligned SAM or BAM and adds the OA tag to every aligned read unless an interval list is specified,
where it only adds the tag to reads that fall within the intervals in the interval list. This can be useful if you are
about to realign but want to keep the original alignment information as a separate tag.<br /><h4>Usage
example:</h4><pre>java -jar picard.jar AddOATag \<br />      L=some_picard.interval_list \<br />      I=sorted.bam \<br
/>      O=fixed.bam <br /></pre>
Version:3.4.0


Required Arguments:

--INPUT,-I <String>           SAM or BAM input file  Required. 

--OUTPUT,-O <String>          SAM or BAM file to write merged result to  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INTERVAL_LIST,-L <File>     If provided, only records that overlap given interval list will have the OA tag added. 
                              Default value: null. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_AddOrReplaceReadGroups

### Tool Description
Assigns all the reads in a file to a single new read-group.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: AddOrReplaceReadGroups [arguments]

Assigns all the reads in a file to a single new read-group.

This tool accepts INPUT BAM and SAM files or URLs from the <a href="http://ga4gh.org/#/documentation">Global Alliance
for Genomics and Health (GA4GH)</a>.
<h3>Usage example:</h3>
java -jar picard.jar AddOrReplaceReadGroups \
I=input.bam \
O=output.bam \
RGID=4 \
RGLB=lib1 \
RGPL=ILLUMINA \
RGPU=unit1 \
RGSM=20

<h3>Caveats</h3>
The value of the tags must adhere (according to the <a
href="https://samtools.github.io/hts-specs/SAMv1.pdf">SAM-spec</a>) with the regex <code>'^[ -~]+$'</code> (one or more
characters from the ASCII range 32 through 126). In particular &lt;Space&gt; is the only non-printing character allowed.

The program enables only the wholesale assignment of all the reads in the INPUT to a single read-group. If your file
already has reads assigned to multiple read-groups, the original RG value will be lost. 

For more information about read-groups, see the <a href='https://www.broadinstitute.org/gatk/guide/article?id=6472'>GATK
Dictionary entry.</a>
Version:3.4.0


Required Arguments:

--INPUT,-I <String>           Input file (BAM or SAM or a GA4GH url).  Required. 

--OUTPUT,-O <File>            Output file (SAM, BAM or CRAM).  Required. 

--RGLB,-LB <String>           Read-Group library  Required. 

--RGPL,-PL <String>           Read-Group platform (e.g. ILLUMINA, SOLID)  Required. 

--RGPU,-PU <String>           Read-Group platform unit (eg. run barcode)  Required. 

--RGSM,-SM <String>           Read-Group sample name  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--RGCN,-CN <String>           Read-Group sequencing center name  Default value: null. 

--RGDS,-DS <String>           Read-Group description  Default value: null. 

--RGDT,-DT <Iso8601Date>      Read-Group run date  Default value: null. 

--RGFO,-FO <String>           Read-Group flow order  Default value: null. 

--RGID,-ID <String>           Read-Group ID  Default value: 1. 

--RGKS,-KS <String>           Read-Group key sequence  Default value: null. 

--RGPG,-PG <String>           Read-Group program group  Default value: null. 

--RGPI,-PI <Integer>          Read-Group predicted insert size  Default value: null. 

--RGPM,-PM <String>           Read-Group platform model  Default value: null. 

--SORT_ORDER,-SO <SortOrder>  Optional sort order to output in. If not supplied OUTPUT is in the same order as INPUT. 
                              Default value: null. Possible values: {unsorted, queryname, coordinate, duplicate,
                              unknown} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_BamToBfq

### Tool Description
Converts a BAM file into a BFQ (binary fastq formatted) file. The BFQ format is the input format to some tools like Maq aligner.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: BamToBfq [arguments]

<p>Converts a BAM file into a BFQ (binary fastq formatted) file.</p><p>The BFQ format is the input format to some tools
like Maq aligner.</p><h3>Input</h3><p>A single BAM file to convert</p><h3>Output</h3><p>One or two FASTQ files depending
on whether the BAM file contains single- or paired-end sequencing data. You must indicate the output directory that will
contain these files (<code>ANALYSIS_DIR</code>) and the output file name prefix
(<code>OUTPUT_FILE_PREFIX</code>).</p><h3>Usage example:</h3><pre>java -jar picard.jar BamToBfq \
I=input.bam \
ANALYSIS_DIR=output_dir \
OUTPUT_FILE_PREFIX=output_name \
PAIRED_RUN=false</pre><hr />
Version:3.4.0


Required Arguments:

--ANALYSIS_DIR <File>         The analysis directory for the binary output file.   Required. 

--FLOWCELL_BARCODE,-F <String>Flowcell barcode (e.g. 30PYMAAXX).    Required.  Cannot be used in conjunction with
                              argument(s) OUTPUT_FILE_PREFIX

--INPUT,-I <File>             The BAM file to parse.  Required. 

--OUTPUT_FILE_PREFIX <String> Prefix for all output files  Required.  Cannot be used in conjunction with argument(s)
                              FLOWCELL_BARCODE (F) LANE (L)

--PAIRED_RUN,-PE <Boolean>    Whether this is a paired-end run.   Required. Possible values: {true, false} 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--BASES_TO_WRITE <Integer>    The number of bases from each read to write to the bfq file.  If this is non-null, then
                              only the first BASES_TO_WRITE bases from each read will be written.  Default value: null. 

--CLIP_ADAPTERS <Boolean>     Whether to clip adapters from the reads  Default value: true. Possible values: {true,
                              false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_NON_PF_READS,-NONPF <Boolean>
                              Whether to include non-PF reads  Default value: false. Possible values: {true, false} 

--LANE,-L <Integer>           Lane number.   Default value: null.  Cannot be used in conjunction with argument(s)
                              OUTPUT_FILE_PREFIX

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_CHUNK_SIZE,-CHUNK <Integer>
                              Number of reads to break into individual groups for alignment  Default value: 2000000. 

--READ_NAME_PREFIX <String>   Prefix to be stripped off the beginning of all read names  (to make them short enough to
                              run in Maq)  Default value: null.  Cannot be used in conjunction with argument(s)
                              RUN_BARCODE (RB)

--READS_TO_ALIGN,-NUM <Integer>
                              Number of reads to align (null = all).  Default value: null. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--RUN_BARCODE,-RB <String>    Deprecated option; use READ_NAME_PREFIX instead  Default value: null.  Cannot be used in
                              conjunction with argument(s) READ_NAME_PREFIX

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_BuildBamIndex

### Tool Description
Generates a BAM index ".bai" file. This tool creates an index file for the input BAM that allows fast look-up of data in a BAM file, like an index on a database. Note that this tool cannot be run on SAM files, and that the input BAM file must be sorted in coordinate order.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: BuildBamIndex [arguments]

Generates a BAM index ".bai" file.  This tool creates an index file for the input BAM that allows fast look-up of data
in a BAM file, lke an index on a database. Note that this tool cannot be run on SAM files, and that the input BAM file
must be sorted in coordinate order.<h4>Usage example:</h4><pre>java -jar picard.jar BuildBamIndex \<br />     
I=input.bam</pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <PicardHtsPath>    A BAM file or GA4GH URL to process. Must be sorted in coordinate order.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--OUTPUT,-O <File>            The BAM index file. Defaults to x.bai if INPUT is x.bam, otherwise INPUT.bai.
                              If INPUT is a URL and OUTPUT is unspecified, defaults to a file in the current directory. 
                              Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CleanSam

### Tool Description
Cleans a SAM/BAM/CRAM files, soft-clipping beyond-end-of-reference alignments and setting MAPQ to 0 for unmapped reads

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CleanSam [arguments]

Cleans a SAM/BAM/CRAM files, soft-clipping beyond-end-of-reference alignments and setting MAPQ to 0 for unmapped reads
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input SAM/BAM/CRAM file to be cleaned.  Required. 

--OUTPUT,-O <File>            Where to write cleaned file.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_CollectDuplicateMetrics

### Tool Description
Collect Duplicate metrics from marked file. This tool only collects the duplicate metrics from a file that has already been duplicate-marked.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CollectDuplicateMetrics [arguments]

Collect Duplicate metrics from marked file.
This tool only collects the duplicate metrics from a file that has already been duplicate-marked. The resulting metrics
file will always have a READ_PAIR_OPTICAL_DUPLICATES=0 and as a result the ESTIMATED_LIBRARY_SIZE will be slightly
incorrect. 
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input SAM/BAM/CRAM file.  Required. 

--METRICS_FILE,-M <File>      File to write duplication metrics to.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true (default), then the sort order in the header file will be ignored.  Default value:
                              true. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--STOP_AFTER <Long>           Stop after processing N reads, mainly for debugging.  Default value: 0. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument METRICS_FILE was missing: Argument 'METRICS_FILE' is required
```


## picard_DownsampleSam

### Tool Description
Downsample a SAM or BAM file. This tool applies a downsampling algorithm to a SAM or BAM file to retain only a (deterministically random) subset of the reads. Reads from the same template (e.g. read-pairs, secondary and supplementary reads) are all either kept or discarded as a unit.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: DownsampleSam [arguments]

Downsample a SAM or BAM file.This tool applies a downsampling algorithm to a SAM or BAM file to retain only a
(deterministically random) subset of the reads. Reads from the same template (e.g. read-pairs, secondary and
supplementary reads) are all either kept or discarded as a unit, with the goal of retaining readsfrom PROBABILITY *
input templates. The results will contain approximately PROBABILITY * input reads, however for very small PROBABILITIES
this may not be the case.
A number of different downsampling strategies are supported using the STRATEGY option:

ConstantMemory:
Downsamples a stream or file of SAMRecords using a hash-projection strategy such that it can run in constant memory. The
downsampling is stochastic, and therefore the actual retained proportion will vary around the requested proportion. Due
to working in fixed memory this strategy is good for large inputs, and due to the stochastic nature the accuracy of this
strategy is highest with a high number of output records, and diminishes at low output volumes.
HighAccuracy:
Attempts (but does not guarantee) to provide accuracy up to a specified limit. Accuracy is defined as emitting a
proportion of reads as close to the requested proportion as possible. In order to do so this strategy requires memory
that is proportional to the number of template names in the incoming stream of reads, and will thus require large
amounts of memory when running on large input files.
Chained:
Attempts to provide a compromise strategy that offers some of the advantages of both the ConstantMemory and HighAccuracy
strategies. Uses a ConstantMemory strategy to downsample the incoming stream to approximately the desired proportion,
and then a HighAccuracy strategy to finish. Works in a single pass, and will provide accuracy close to (but often not as
good as) HighAccuracy while requiring memory proportional to the set of reads emitted from the ConstantMemory strategy
to the HighAccuracy strategy. Works well when downsampling large inputs to small proportions (e.g. downsampling hundreds
of millions of reads and retaining only 2%. Should be accurate 99.9% of the time when the input contains more than
50,000 templates (read names). For smaller inputs, HighAccuracy is recommended instead.
<h3>Usage examples:</h3>
<h4>Downsample file, keeping about 10% of the reads</h4>

java -jar picard.jar DownsampleSam \
I=input.bam \
O=downsampled.bam \
P=0.2

<h3>Downsample file, keeping about 2% of the reads </h3>

java -jar picard.jar DownsampleSam \
I=input.bam \
O=downsampled.bam \
STRATEGY=Chained \
P=0.02 \
ACCURACY=0.0001

<h3>Downsample file, keeping about 0.001% of the reads (may require more memory)</h3>

java -jar picard.jar DownsampleSam \
I=input.bam \
O=downsampled.bam \
STRATEGY=HighAccuracy \
P=0.00001 \
ACCURACY=0.0000001

Version:3.4.0


Required Arguments:

--INPUT,-I <PicardHtsPath>    The input SAM or BAM file to downsample.  Required. 

--OUTPUT,-O <PicardHtsPath>   The output, downsampled, SAM, BAM or CRAM file to write.  Required. 


Optional Arguments:

--ACCURACY,-A <Double>        The accuracy that the downsampler should try to achieve if the selected strategy supports
                              it. Note that accuracy is never guaranteed, but some strategies will attempt to provide
                              accuracy within the requested bounds.Higher accuracy will generally require more memory. 
                              Default value: 1.0E-4. 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--METRICS_FILE,-M <PicardHtsPath>
                              The metrics file (of type QualityYieldMetrics) which will contain information about the
                              downsampled file.  Default value: null. 

--PROBABILITY,-P <Double>     The probability of keeping any individual read, between 0 and 1.  Default value: 1.0. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--RANDOM_SEED,-R <Integer>    Random seed used for deterministic results. Setting to null will cause multiple
                              invocations to produce different results.  The header if the file will be checked for any
                              previous runs of DownsampleSam.  If DownsampleSam has been run before on this data with
                              the same seed, the seed will be updated in a deterministic fashion so the DownsampleSam
                              will perform correctly, and still deterministically.  Default value: 1. 

--REFERENCE_SEQUENCE <PicardHtsPath>
                              The reference sequence file.  Default value: null. 

--STRATEGY,-S <Strategy>      The downsampling strategy to use. See usage for discussion.  Default value:
                              ConstantMemory. Possible values: {HighAccuracy, ConstantMemory, Chained} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_FastqToSam

### Tool Description
Converts a FASTQ file to an unaligned BAM or SAM file. Output read records will contain the original base calls and quality scores will be translated depending on the base quality score encoding: FastqSanger, FastqSolexa and FastqIllumina.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: FastqToSam [arguments]

<p>Converts a FASTQ file to an unaligned BAM or SAM file.</p><p>Output read records will contain the original base calls
and quality scores will be translated depending on the base quality score encoding: FastqSanger, FastqSolexa and
FastqIllumina.</p><p>There are also arguments to provide values for SAM header and read attributes that are not present
in FASTQ (e.g see RG or SM below).</p><h3>Inputs</h3><p>One FASTQ file name for single-end or two for pair-end
sequencing input data. These files might be in gzip compressed format (when file name is ending with
".gz").</p><p>Alternatively, for larger inputs you can provide a collection of FASTQ files indexed by their name (see
USE_SEQUENTIAL_FASTQ for details below).</p><p>By default, this tool will try to guess the base quality score encoding.
However you can indicate it explicitly using the QUALITY_FORMAT argument, and must do so if inputs are not a regular
file (e.g. stdin).</p><h3>Output</h3><p>A single unaligned BAM or SAM file. By default, the records are sorted by query
(read) name.</p><h3>Usage examples</h3><h4>Example 1:</h4><p>Single-end sequencing FASTQ file conversion. All reads are
annotated as belonging to the "rg0013" read group that in turn is part of the sample "sample001".</p><pre>java -jar
picard.jar FastqToSam \
F1=input_reads.fastq \
O=unaligned_reads.bam \
SM=sample001 \
RG=rg0013</pre><h4>Example 2:</h4><p>Similar to example 1 above, but for paired-end sequencing.</p><pre>java -jar
picard.jar FastqToSam \
F1=forward_reads.fastq \
F2=reverse_reads.fastq \
O=unaligned_read_pairs.bam \
SM=sample001 \
RG=rg0013</pre><hr />
Version:3.4.0


Required Arguments:

--FASTQ,-F1 <PicardHtsPath>   Input fastq file (optionally gzipped) for single end data, or first read in paired end
                              data.  Required. 

--OUTPUT,-O <File>            Output BAM/SAM/CRAM file.   Required. 

--SAMPLE_NAME,-SM <String>    Sample name to insert into the read group header  Required. 


Optional Arguments:

--ALLOW_AND_IGNORE_EMPTY_LINES <Boolean>
                              Allow (and ignore) empty lines  Default value: false. Possible values: {true, false} 

--ALLOW_EMPTY_FASTQ <Boolean> Allow empty input fastq  Default value: false. Possible values: {true, false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMMENT,-CO <String>        Comment(s) to include in the merged output file's header.  This argument may be specified
                              0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DESCRIPTION,-DS <String>    Inserted into the read group header  Default value: null. 

--FASTQ2,-F2 <PicardHtsPath>  Input fastq file (optionally gzipped) for the second read of paired end data.  Default
                              value: null. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--LIBRARY_NAME,-LB <String>   The library name to place into the LB attribute in the read group header  Default value:
                              null. 

--MAX_Q <Integer>             Maximum quality allowed in the input fastq.  An exception will be thrown if a quality is
                              greater than this value.  Default value: 93. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MIN_Q <Integer>             Minimum quality allowed in the input fastq.  An exception will be thrown if a quality is
                              less than this value.  Default value: 0. 

--PLATFORM,-PL <String>       The platform type (e.g. ILLUMINA, SOLID) to insert into the read group header  Default
                              value: null. 

--PLATFORM_MODEL,-PM <String> Platform model to insert into the group header (free-form text providing further details
                              of the platform/technology used)  Default value: null. 

--PLATFORM_UNIT,-PU <String>  The platform unit (often run_barcode.lane) to insert into the read group header  Default
                              value: null. 

--PREDICTED_INSERT_SIZE,-PI <Integer>
                              Predicted median insert size, to insert into the read group header  Default value: null. 

--PROGRAM_GROUP,-PG <String>  Program group to insert into the read group header.  Default value: null. 

--QUALITY_FORMAT,-V <FastqQualityFormat>
                              A value describing how the quality values are encoded in the input FASTQ file.  Either
                              Solexa (phred scaling + 66), Illumina (phred scaling + 64) or Standard (phred scaling +
                              33).  If input is from a regular file and this value is not specified, the quality format
                              will be detected automatically. If input is not from a regular file, this value is
                              required.  Default value: null. Possible values: {Solexa, Illumina, Standard} 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_GROUP_NAME,-RG <String>Read group name  Default value: A. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--RUN_DATE,-DT <Iso8601Date>  Date the run was produced, to insert into the read group header  Default value: null. 

--SEQUENCING_CENTER,-CN <String>
                              The sequencing center from which the data originated  Default value: null. 

--SORT_ORDER,-SO <SortOrder>  The sort order for the output BAM/SAM/CRAM file.  Default value: queryname. Possible
                              values: {unsorted, queryname, coordinate, duplicate, unknown} 

--STRIP_UNPAIRED_MATE_NUMBER <Boolean>
                              Deprecated (No longer used). If true and this is an unpaired fastq any occurrence of '/1'
                              or '/2' will be removed from the end of a read name.  Default value: false. Possible
                              values: {true, false} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--USE_SEQUENTIAL_FASTQS <Boolean>
                              Use sequential fastq files with the suffix <prefix>_###.fastq[.gz]. The files should be
                              named:
                              <prefix>_001.<extension>, <prefix>_002.<extension>, ..., <prefix>_XYZ.<extension>
                              Use the *first* file for the --FASTQ argument, e.g., --FASTQ <prefix>_001.<extension>.
                              If paired end, use the *first* read2 file for the --FASTQ2 argument, e.g.,
                              <R2_prefix>_001.<extension>.
                              Example: combine and convert 4 single end fastqs with filenames:
                              RUNNAME_S8_L005_R1_001.fastq
                              RUNNAME_S8_L005_R1_002.fastq
                              RUNNAME_S8_L005_R1_003.fastq
                              RUNNAME_S8_L005_R1_004.fastq
                              Run command with --FASTQ RUNNAME_S8_L005_R1_001.fastq --USE_SEQUENTIAL_FASTQS true 
                              Default value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument FASTQ was missing: Argument 'FASTQ' is required
```


## picard_FilterSamReads

### Tool Description
Subsets reads from a SAM/BAM/CRAM file by applying one of several filters. Takes a SAM/BAM/CRAM file and subsets it by either excluding or only including certain reads such as aligned or unaligned reads, specific reads based on a list of reads names, an interval list, by Tag Values (type Z / String values only), or using a JavaScript script.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: FilterSamReads [arguments]

Subsets reads from a SAM/BAM/CRAM file by applying one of several filters.
Takes a SAM/BAM/CRAM file and subsets it by either excluding or only including certain reads such as aligned or
unaligned reads, specific reads based on a list of reads names, an interval list, by Tag Values (type Z / String values
only), or using a JavaScript script.
<br /><h3>Usage example:</h3><h4>Filter by queryname</h4><pre>java -jar picard.jar FilterSamReads \<br />      
I=input.bam \ <br />       O=output.bam \ <br />       READ_LIST_FILE=read_names.txt \ <br />     
FILTER=includeReadList</pre> <h4>Filter by interval</h4><pre>java -jar picard.jar FilterSamReads \ <br />      
I=input.bam \ <br />       O=output.bam \ <br />       INTERVAL_LIST=regions.interval_list \ <br/>     
FILTER=includePairedIntervals</pre> <h4>Filter by Tag Value (type Z / String values only)</h4><pre>java -jar picard.jar
FilterSamReads \ <br />       I=input.bam \ <br />       O=output.bam \ <br />       TAG=CR \ <br/>     
TAG_VALUE=TTTGTCATCTCGAGTA \ <br/>      FILTER=includeTagValues</pre> <h4>Filter reads having a soft clip on the
beginning of the read larger than 2 bases with a JavaScript script</h4><pre>cat <<EOF > script.js <br/>/** reads having
a soft clip larger than 2 bases in beginning of read*/ <br/>function accept(rec) {   <br/>    if
(rec.getReadUnmappedFlag()) return false; <br/>    var cigar = rec.getCigar(); <br/>    if (cigar == null) return false;
<br/>    var ce = cigar.getCigarElement(0); <br/>    return ce.getOperator().name() == "S" && ce.length() > 2; <br/>}
<br /><br />accept(record); <br/>EOF <br/><br/>java -jar picard.jar FilterSamReads \ <br />       I=input.bam \ <br />  
O=output.bam \ <br />       JAVASCRIPT_FILE=script.js \ <br/>      FILTER=includeJavascript</pre> 
Version:3.4.0


Required Arguments:

--FILTER <Filter>             Which filter to use.  Required. includeAligned (Output aligned reads only. INPUT
                              SAM/BAM/CRAM must be in queryname SortOrder. (Note: first and second of paired reads must
                              both be aligned to be included in OUTPUT.))
                              excludeAligned (Output Unmapped reads only. INPUT SAM/BAM/CRAM must be in queryname
                              SortOrder. (Note: first and second of pair must both be aligned to be excluded from
                              OUTPUT.))
                              includeReadList (Output reads with names contained in READ_LIST_FILE. See READ_LIST_FILE
                              for more detail.)
                              excludeReadList (Output reads with names *not* contained in READ_LIST_FILE. See
                              READ_LIST_FILE for more detail.)
                              includeJavascript (Output reads that have been accepted by the JAVASCRIPT_FILE script,
                              that is, reads for which the value of the script is true. See the JAVASCRIPT_FILE argument
                              for more detail. )
                              includePairedIntervals (Output reads that overlap with an interval from INTERVAL_LIST (and
                              their mate). INPUT must be coordinate sorted.)
                              includeTagValues (Output reads that have a value of tag TAG that is contained in the
                              values for TAG_VALUES)
                              excludeTagValues (Output reads that do not have a value of tag TAG that is contained in
                              the values for TAG_VALUES)

--INPUT,-I <File>             The SAM/BAM/CRAM file that will be filtered.  Required. 

--OUTPUT,-O <File>            SAM/BAM/CRAM file for resulting reads.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INTERVAL_LIST,-IL <File>    Interval List File containing intervals that will be included in the OUTPUT when using
                              FILTER=includePairedIntervals  Default value: null. 

--JAVASCRIPT_FILE,-JS <File>  Filters the INPUT with a javascript expression using the java javascript-engine, when
                              using FILTER=includeJavascript.  The script puts the following variables in the script
                              context: 
                              'record' a SamRecord (
                              https://samtools.github.io/htsjdk/javadoc/htsjdk/htsjdk/samtools/SAMRecord.html ) and 
                              'header' a SAMFileHeader (
                              https://samtools.github.io/htsjdk/javadoc/htsjdk/htsjdk/samtools/SAMFileHeader.html ).
                              all the public members of SamRecord and SAMFileHeader are accessible. A record is accepted
                              if the last value of the script evaluates to true.  Default value: null. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_LIST_FILE,-RLF <File>  File containing reads that will be included in or excluded from the OUTPUT SAM/BAM/CRAM
                              file, when using FILTER=includeReadList or FILTER=excludeReadList.  Default value: null. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SORT_ORDER,-SO <SortOrder>  SortOrder of the OUTPUT file, otherwise use the SortOrder of the INPUT file.  Default
                              value: null. Possible values: {unsorted, queryname, coordinate, duplicate, unknown} 

--TAG,-T <String>             The tag to select from input SAM/BAM  Default value: null. 

--TAG_VALUE,-TV <String>      The tag value(s) to filter by  This argument may be specified 0 or more times. Default
                              value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 

--WRITE_READS_FILES <Boolean> Create <OUTPUT>.reads file containing names of reads from INPUT and OUTPUT (for debugging
                              purposes.)  Default value: false. Possible values: {true, false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_FixMateInformation

### Tool Description
Verify mate-pair information between mates and fix if needed. This tool ensures that all mate-pair information is in sync between each read and its mate pair. If no OUTPUT file is supplied then the output is written to a temporary file and then copied over the INPUT file (with the original placed in a .old file.) Reads marked with the secondary alignment flag are written to the output file unchanged. However supplementary reads are corrected so that they point to the primary, non-supplemental mate record.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: FixMateInformation [arguments]

Verify mate-pair information between mates and fix if needed.This tool ensures that all mate-pair information is in sync
between each read and its mate pair.  If no OUTPUT file is supplied then the output is written to a temporary file and
then copied over the INPUT file (with the original placed in a .old file.)  Reads marked with the secondary alignment
flag are written to the output file unchanged. However <b>supplementary</b> reads are corrected so that they point to
the primary, non-supplemental mate record.

<h3>Usage example</h3>

java -jar picard.jar FixMateInformation \
I=input.bam \
O=fixed_mate.bam \
ADD_MATE_CIGAR=true

<h3>Caveats</h3>
The program should run with fairly limited memory unless there are many mate pairs that are missing or far apart from
each other in the file, as it keeps track of the unmatched mates.
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The SAM/BAM/CRAM input files to check and fix. Multiple files will be merged and sorted. 
                              This argument must be specified at least once. Required. 


Optional Arguments:

--ADD_MATE_CIGAR,-MC <Boolean>Adds the mate CIGAR tag (MC) if true, does not if false.  Default value: true. Possible
                              values: {true, false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true, assume that the input file is queryname sorted, even if the header says
                              otherwise.  Default value: false. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--IGNORE_MISSING_MATES <Boolean>
                              If true, ignore missing mates, otherwise will throw an exception when missing mates are
                              found.  Default value: true. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--OUTPUT,-O <File>            The output file to write to. If no output file is supplied, the input file is overwritten
                              (only available with single input file).  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SORT_ORDER,-SO <SortOrder>  Optional sort order if the OUTPUT file should be sorted differently than the INPUT file. 
                              Default value: null. Possible values: {unsorted, queryname, coordinate, duplicate,
                              unknown} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_GatherBamFiles

### Tool Description
Concatenate efficiently BAM files that resulted from a scattered parallel analysis. This tool performs a rapid 'gather' or concatenation on BAM files. This is often needed in operations that have been run in parallel across genomics regions by scattering their execution across computing nodes and cores thus resulting in smaller BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: GatherBamFiles [arguments]

<p>Concatenate efficiently BAM files that resulted from a scattered parallel analysis.</p><p>This tool performs a rapid
"gather" or concatenation on BAM files. This is often needed in operations that have been run in parallel across
genomics regions by scattering their execution across computing nodes and cores thus resulting in smaller BAM
files.</p><p>This tool does not support SAM files</p><h3>Inputs</h3><p>A list of BAM files to combine using the INPUT
argument. These files must be provided in the order that they should be concatenated.</p><h3>Output</h3><p>A single BAM
file. The header is copied from the first input file.</p><h3>Usage example:</h3><pre>java -jar picard.jar GatherBamFiles
\
I=input1.bam \
I=input2.bam \
O=gathered_files.bam</pre><h3>Notes</h3><p>Operates via copying of the gzip blocks directly for speed but also supports
generation of an MD5 on the output and indexing of the output BAM file.</p><hr/>
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Two or more SAM/BAM/CRAM files or text files containing lists of SAM/BAM/CRAM files (one
                              per line).  This argument must be specified at least once. Required. 

--OUTPUT,-O <File>            The output SAM/BAM/CRAM file to write.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_MarkDuplicates

### Tool Description
Identifies duplicate reads. This tool locates and tags duplicate reads in a SAM, BAM or CRAM file, where duplicate reads are defined as originating from a single fragment of DNA. MarkDuplicates also produces a metrics file indicating the numbers of duplicates for both single- and paired-end reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: MarkDuplicates [arguments]

Identifies duplicate reads.  <p>This tool locates and tags duplicate reads in a SAM, BAM or CRAM file, where duplicate
reads are defined as originating from a single fragment of DNA.  Duplicates can arise during sample preparation e.g.
library construction using PCR.  See also <a
href='https://broadinstitute.github.io/picard/command-line-overview.html#EstimateLibraryComplexity'>EstimateLibraryComplexity</a>
for additional notes on PCR duplication artifacts.  Duplicate reads can also result from a single amplification cluster,
incorrectly detected as multiple clusters by the optical sensor of the sequencing instrument.  These duplication
artifacts are referred to as optical duplicates.</p><p>The MarkDuplicates tool works by comparing sequences in the 5
prime positions of both reads and read-pairs in a SAM/BAM file.  A BARCODE_TAG option is available to facilitate
duplicate marking using molecular barcodes.  After duplicate reads are collected, the tool differentiates the primary
and duplicate reads using an algorithm that ranks reads by the sums of their base-quality scores (default method). Note
that this is different from directly checking if the sequences match, which MarkDuplicates does not do.</p>  <p>The
tool's main output is a new SAM, BAM or CRAM file, in which duplicates have been identified in the SAM flags field for
each read.  Duplicates are marked with the hexadecimal value of 0x0400, which corresponds to a decimal value of 1024. 
If you are not familiar with this type of annotation, please see the following <a
href='https://www.broadinstitute.org/gatk/blog?id=7019'>blog post</a> for additional information.</p><p>Although the
bitwise flag annotation indicates whether a read was marked as a duplicate, it does not identify the type of duplicate. 
To do this, a new tag called the duplicate type (DT) tag was recently added as an optional output in  the 'optional
field' section of a SAM/BAM/CRAM file.  Invoking the TAGGING_POLICY option, you can instruct the program to mark all the
duplicates (All), only the optical duplicates (OpticalOnly), or no duplicates (DontTag).  The records within the output
of a SAM/BAM/CRAM file will have values for the 'DT' tag (depending on the invoked TAGGING_POLICY), as either
library/PCR-generated duplicates (LB), or sequencing-platform artifact duplicates (SQ).  This tool uses the
READ_NAME_REGEX and the OPTICAL_DUPLICATE_PIXEL_DISTANCE options as the primary methods to identify and differentiate
duplicate types.  Set READ_NAME_REGEX to null to skip optical duplicate detection, e.g. for RNA-seq or other data where
duplicate sets are extremely large and estimating library complexity is not an aim.  Note that without optical duplicate
counts, library size estimation will be inaccurate.</p> <p>MarkDuplicates also produces a metrics file indicating the
numbers of duplicates for both single- and paired-end reads.</p>  <p>The program can take either coordinate-sorted or
query-sorted inputs, however the behavior is slightly different.  When the input is coordinate-sorted, unmapped mates of
mapped records and supplementary/secondary alignments are not marked as duplicates.  However, when the input is
query-sorted (actually query-grouped), then unmapped mates and secondary/supplementary reads are not excluded from the
duplication test and can be marked as duplicate reads.</p>  <p>If desired, duplicates can be removed using the
REMOVE_DUPLICATE and REMOVE_SEQUENCING_DUPLICATES options.</p><h4>Usage example:</h4><pre>java -jar picard.jar
MarkDuplicates \<br />      I=input.bam \<br />      O=marked_duplicates.bam \<br />     
M=marked_dup_metrics.txt</pre>Please see <a
href='http://broadinstitute.github.io/picard/picard-metric-definitions.html#DuplicationMetrics'>MarkDuplicates</a> for
detailed explanations of the output metrics.<hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <String>           One or more input SAM, BAM or CRAM files to analyze. Must be coordinate sorted.  This
                              argument must be specified at least once. Required. 

--METRICS_FILE,-M <File>      File to write duplication metrics to  Required. 

--OUTPUT,-O <File>            The output file to write marked records to  Required. 


Optional Arguments:

--ADD_PG_TAG_TO_READS <Boolean>
                              Add PG tag to each read in a SAM or BAM  Default value: true. Possible values: {true,
                              false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORT_ORDER,-ASO <SortOrder>
                              If not null, assume that the input file has this order even if the header says otherwise. 
                              Default value: null. Possible values: {unsorted, queryname, coordinate, duplicate,
                              unknown}  Cannot be used in conjunction with argument(s) ASSUME_SORTED (AS)

--ASSUME_SORTED,-AS <Boolean> If true, assume that the input file is coordinate sorted even if the header says
                              otherwise. Deprecated, used ASSUME_SORT_ORDER=coordinate instead.  Default value: false.
                              Possible values: {true, false}  Cannot be used in conjunction with argument(s)
                              ASSUME_SORT_ORDER (ASO)

--BARCODE_TAG <String>        Barcode SAM tag (ex. BC for 10X Genomics)  Default value: null. 

--CLEAR_DT <Boolean>          Clear DT tag from input SAM records. Should be set to false if input SAM doesn't have this
                              tag.  Default true  Default value: true. Possible values: {true, false} 

--COMMENT,-CO <String>        Comment(s) to include in the output file's header.  This argument may be specified 0 or
                              more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DUPLEX_UMI <Boolean>        Treat UMIs as being duplex stranded.  This option requires that the UMI consist of two
                              equal length strings that are separated by a hyphen (e.g. 'ATC-GTC'). Reads are considered
                              duplicates if, in addition to standard definition, have identical normalized UMIs.  A UMI
                              from the 'bottom' strand is normalized by swapping its content around the hyphen (eg.
                              ATC-GTC becomes GTC-ATC).  A UMI from the 'top' strand is already normalized as it is.
                              Both reads from a read pair considered top strand if the read 1 unclipped 5' coordinate is
                              less than the read 2 unclipped 5' coordinate. All chimeric reads and read fragments are
                              treated as having come from the top strand. With this option is it required that the
                              BARCODE_TAG hold non-normalized UMIs. Default false.  Default value: false. Possible
                              values: {true, false} 

--DUPLICATE_SCORING_STRATEGY,-DS <ScoringStrategy>
                              The scoring strategy for choosing the non-duplicate among candidates.  Default value:
                              SUM_OF_BASE_QUALITIES. Possible values: {SUM_OF_BASE_QUALITIES,
                              TOTAL_MAPPED_REFERENCE_LENGTH, RANDOM} 

--FLOW_DUP_STRATEGY <FLOW_DUPLICATE_SELECTION_STRATEGY>
                              Use specific quality summing strategy for flow based reads. Two strategies are available:
                              FLOW_QUALITY_SUM_STRATEG: The selects the read with the best total homopolymer quality.
                              FLOW_END_QUALITY_STRATEGY: The strategy selects the read with the best homopolymer quality
                              close to the end (10 bases) of the read.  The latter strategy is recommended for samples
                              with high duplication rate   Default value: FLOW_QUALITY_SUM_STRATEGY. Possible values:
                              {FLOW_QUALITY_SUM_STRATEGY, FLOW_END_QUALITY_STRATEGY} 

--FLOW_EFFECTIVE_QUALITY_THRESHOLD <Integer>
                              Threshold for considering a quality value high enough to be included when calculating
                              FLOW_QUALITY_SUM_STRATEGY calculation.  Default value: 15. 

--FLOW_MODE <Boolean>         enable parameters and behavior specific to flow based reads.  Default value: false.
                              Possible values: {true, false} 

--FLOW_Q_IS_KNOWN_END <Boolean>
                              Treat position of read trimming based on quality as the known end (relevant for flow based
                              reads). Default false - if the read is trimmed on quality its end is not defined and the
                              read is duplicate of any read starting at the same place.  Default value: false. Possible
                              values: {true, false} 

--FLOW_SKIP_FIRST_N_FLOWS <Integer>
                              Skip first N flows, starting from the read's start, when considering duplicates. Useful
                              for flow based reads where sometimes there is noise in the first flows (for this argument,
                              "read start" means 5' end).  Default value: 0. 

--FLOW_UNPAIRED_END_UNCERTAINTY <Integer>
                              Maximal difference of the read end position that counted as equal. Useful for flow based
                              reads where the end position might vary due to sequencing errors. (for this argument,
                              "read end" means 3' end)  Default value: 0. 

--FLOW_UNPAIRED_START_UNCERTAINTY <Integer>
                              Maximal difference of the read start position that counted as equal. Useful for flow based
                              reads where the end position might vary due to sequencing errors. (for this argument,
                              "read start" means 5' end in the direction of sequencing)  Default value: 0. 

--FLOW_USE_END_IN_UNPAIRED_READS <Boolean>
                              Make the end location of single end read be significant when considering duplicates, in
                              addition to the start location, which is always significant (i.e. require single-ended
                              reads to start andend on the same position to be considered duplicate) (for this argument,
                              "read end" means 3' end).  Default value: false. Possible values: {true, false} 

--FLOW_USE_UNPAIRED_CLIPPED_END <Boolean>
                              Use position of the clipping as the end position, when considering duplicates (or use the
                              unclipped end position) (for this argument, "read end" means 3' end).  Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_FILE_HANDLES_FOR_READ_ENDS_MAP,-MAX_FILE_HANDLES <Integer>
                              Maximum number of file handles to keep open when spilling read ends to disk. Set this
                              number a little lower than the per-process maximum number of file that may be open. This
                              number can be found by executing the 'ulimit -n' command on a Unix system.  Default value:
                              8000. 

--MAX_OPTICAL_DUPLICATE_SET_SIZE <Long>
                              This number is the maximum size of a set of duplicate reads for which we will attempt to
                              determine which are optical duplicates.  Please be aware that if you raise this value too
                              high and do encounter a very large set of duplicate reads, it will severely affect the
                              runtime of this tool.  To completely disable this check, set the value to -1.  Default
                              value: 300000. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MAX_SEQUENCES_FOR_DISK_READ_ENDS_MAP,-MAX_SEQS <Integer>
                              This option is obsolete. ReadEnds will always be spilled to disk.  Default value: 50000. 

--MOLECULAR_IDENTIFIER_TAG <String>
                              SAM tag to uniquely identify the molecule from which a read was derived.  Use of this
                              option requires that the BARCODE_TAG option be set to a non null value.  Default null. 
                              Default value: null. 

--OPTICAL_DUPLICATE_PIXEL_DISTANCE <Integer>
                              The maximum offset between two duplicate clusters in order to consider them optical
                              duplicates. The default is appropriate for unpatterned versions of the Illumina platform.
                              For the patterned flowcell models, 2500 is moreappropriate. For other platforms and
                              models, users should experiment to find what works best.  Default value: 100. 

--PROGRAM_GROUP_COMMAND_LINE,-PG_COMMAND <String>
                              Value of CL tag of PG record to be created. If not supplied the command line will be
                              detected automatically.  Default value: null. 

--PROGRAM_GROUP_NAME,-PG_NAME <String>
                              Value of PN tag of PG record to be created.  Default value: MarkDuplicates. 

--PROGRAM_GROUP_VERSION,-PG_VERSION <String>
                              Value of VN tag of PG record to be created. If not specified, the version will be detected
                              automatically.  Default value: null. 

--PROGRAM_RECORD_ID,-PG <String>
                              The program record ID for the @PG record(s) created by this program. Set to null to
                              disable PG record creation.  This string may have a suffix appended to avoid collision
                              with other program record IDs.  Default value: MarkDuplicates. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_NAME_REGEX <String>    MarkDuplicates can use the tile and cluster positions to estimate the rate of optical
                              duplication in addition to the dominant source of duplication, PCR, to provide a more
                              accurate estimation of library size. By default (with no READ_NAME_REGEX specified),
                              MarkDuplicates will attempt to extract coordinates using a split on ':' (see Note below). 
                              Set READ_NAME_REGEX to 'null' to disable optical duplicate detection. Note that without
                              optical duplicate counts, library size estimation will be less accurate. If the read name
                              does not follow a standard Illumina colon-separation convention, but does contain tile and
                              x,y coordinates, a regular expression can be specified to extract three variables:
                              tile/region, x coordinate and y coordinate from a read name. The regular expression must
                              contain three capture groups for the three variables, in order. It must match the entire
                              read name.   e.g. if field names were separated by semi-colon (';') this example regex
                              could be specified      (?:.*;)?([0-9]+)[^;]*;([0-9]+)[^;]*;([0-9]+)[^;]*$ Note that if no
                              READ_NAME_REGEX is specified, the read name is split on ':'.   For 5 element names, the
                              3rd, 4th and 5th elements are assumed to be tile, x and y values.   For 7 element names
                              (CASAVA 1.8), the 5th, 6th, and 7th elements are assumed to be tile, x and y values. 
                              Default value: <optimized capture of last three ':' separated fields as numeric values>. 

--READ_ONE_BARCODE_TAG <String>
                              Read one barcode SAM tag (ex. BX for 10X Genomics)  Default value: null. 

--READ_TWO_BARCODE_TAG <String>
                              Read two barcode SAM tag (ex. BX for 10X Genomics)  Default value: null. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--REMOVE_DUPLICATES <Boolean> If true do not write duplicates to the output file instead of writing them with
                              appropriate flags set.  Default value: false. Possible values: {true, false} 

--REMOVE_SEQUENCING_DUPLICATES <Boolean>
                              If true remove 'optical' duplicates and other duplicates that appear to have arisen from
                              the sequencing process instead of the library preparation process, even if
                              REMOVE_DUPLICATES is false. If REMOVE_DUPLICATES is true, all duplicates are removed and
                              this option is ignored.  Default value: false. Possible values: {true, false} 

--SORTING_COLLECTION_SIZE_RATIO <Double>
                              This number, plus the maximum RAM available to the JVM, determine the memory footprint
                              used by some of the sorting collections.  If you are running out of memory, try reducing
                              this number.  Default value: 0.25. 

--TAG_DUPLICATE_SET_MEMBERS <Boolean>
                              If a read appears in a duplicate set, add two tags. The first tag, DUPLICATE_SET_SIZE_TAG
                              (DS), indicates the size of the duplicate set. The smallest possible DS value is 2 which
                              occurs when two reads map to the same portion of the reference only one of which is marked
                              as duplicate. The second tag, DUPLICATE_SET_INDEX_TAG (DI), represents a unique identifier
                              for the duplicate set to which the record belongs. This identifier is the index-in-file of
                              the representative read that was selected out of the duplicate set.  Default value: false.
                              Possible values: {true, false} 

--TAGGING_POLICY <DuplicateTaggingPolicy>
                              Determines how duplicate types are recorded in the DT optional attribute.  Default value:
                              DontTag. Possible values: {DontTag, OpticalOnly, All} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:test.bam
- **Example job**: `picard_MarkDuplicates_job.json`

## picard_MarkDuplicatesWithMateCigar

### Tool Description
Identifies duplicate reads, accounting for mate CIGAR. This tool locates and tags duplicate reads (both PCR and optical) in a BAM, SAM or CRAM file, where duplicate reads are defined as originating from the same original fragment of DNA, taking into account the CIGAR string of read mates.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: MarkDuplicatesWithMateCigar [arguments]

Identifies duplicate reads, accounting for mate CIGAR.  This tool locates and tags duplicate reads (both PCR and
optical) in a BAM, SAM or CRAM file, where duplicate reads are defined as originating from the same original fragment of
DNA, taking into account the CIGAR string of read mates. <br /><br />It is intended as an improvement upon the original
MarkDuplicates algorithm, from which it differs in several ways, includingdifferences in how it breaks ties. It may be
the most effective duplicate marking program available, as it handles all cases including clipped and gapped alignments
and locates duplicate molecules using mate cigar information. However, please note that it is not yet used in the
Broad's production pipeline, so use it at your own risk. <br /><br />Note also that this tool will not work with
alignments that have large gaps or deletions, such as those from RNA-seq data.  This is due to the need to buffer small
genomic windows to ensure integrity of the duplicate marking, while large skips (ex. skipping introns) in the alignment
records would force making that window very large, thus exhausting memory. <br /><p>Note: Metrics labeled as percentages
are actually expressed as fractions!</p><h4>Usage example:</h4><pre>java -jar picard.jar MarkDuplicatesWithMateCigar
\<br />      I=input.bam \<br />      O=mark_dups_w_mate_cig.bam \<br />     
M=mark_dups_w_mate_cig_metrics.txt</pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <String>           One or more input SAM, BAM or CRAM files to analyze. Must be coordinate sorted.  This
                              argument must be specified at least once. Required. 

--METRICS_FILE,-M <File>      File to write duplication metrics to  Required. 

--OUTPUT,-O <File>            The output file to write marked records to  Required. 


Optional Arguments:

--ADD_PG_TAG_TO_READS <Boolean>
                              Add PG tag to each read in a SAM or BAM  Default value: true. Possible values: {true,
                              false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORT_ORDER,-ASO <SortOrder>
                              If not null, assume that the input file has this order even if the header says otherwise. 
                              Default value: null. Possible values: {unsorted, queryname, coordinate, duplicate,
                              unknown}  Cannot be used in conjunction with argument(s) ASSUME_SORTED (AS)

--ASSUME_SORTED,-AS <Boolean> If true, assume that the input file is coordinate sorted even if the header says
                              otherwise. Deprecated, used ASSUME_SORT_ORDER=coordinate instead.  Default value: false.
                              Possible values: {true, false}  Cannot be used in conjunction with argument(s)
                              ASSUME_SORT_ORDER (ASO)

--BLOCK_SIZE <Integer>        The block size for use in the coordinate-sorted record buffer.  Default value: 100000. 

--COMMENT,-CO <String>        Comment(s) to include in the output file's header.  This argument may be specified 0 or
                              more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DUPLICATE_SCORING_STRATEGY,-DS <ScoringStrategy>
                              The scoring strategy for choosing the non-duplicate among candidates.  Default value:
                              TOTAL_MAPPED_REFERENCE_LENGTH. Possible values: {SUM_OF_BASE_QUALITIES,
                              TOTAL_MAPPED_REFERENCE_LENGTH, RANDOM} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_OPTICAL_DUPLICATE_SET_SIZE <Long>
                              This number is the maximum size of a set of duplicate reads for which we will attempt to
                              determine which are optical duplicates.  Please be aware that if you raise this value too
                              high and do encounter a very large set of duplicate reads, it will severely affect the
                              runtime of this tool.  To completely disable this check, set the value to -1.  Default
                              value: 300000. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MINIMUM_DISTANCE <Integer>  The minimum distance to buffer records to account for clipping on the 5' end of the
                              records. For a given alignment, this parameter controls the width of the window to search
                              for duplicates of that alignment. Due to 5' read clipping, duplicates do not necessarily
                              have the same 5' alignment coordinates, so the algorithm needs to search around the
                              neighborhood. For single end sequencing data, the neighborhood is only determined by the
                              amount of clipping (assuming no split reads), thus setting MINIMUM_DISTANCE to twice the
                              sequencing read length should be sufficient. For paired end sequencing, the neighborhood
                              is also determined by the fragment insert size, so you may want to set MINIMUM_DISTANCE to
                              something like twice the 99.5% percentile of the fragment insert size distribution (see
                              CollectInsertSizeMetrics). Or you can set this number to -1 to use either a) twice the
                              first read's read length, or b) 100, whichever is smaller. Note that the larger the
                              window, the greater the RAM requirements, so you could run into performance limitations if
                              you use a value that is unnecessarily large.  Default value: -1. 

--OPTICAL_DUPLICATE_PIXEL_DISTANCE <Integer>
                              The maximum offset between two duplicate clusters in order to consider them optical
                              duplicates. The default is appropriate for unpatterned versions of the Illumina platform.
                              For the patterned flowcell models, 2500 is moreappropriate. For other platforms and
                              models, users should experiment to find what works best.  Default value: 100. 

--PROGRAM_GROUP_COMMAND_LINE,-PG_COMMAND <String>
                              Value of CL tag of PG record to be created. If not supplied the command line will be
                              detected automatically.  Default value: null. 

--PROGRAM_GROUP_NAME,-PG_NAME <String>
                              Value of PN tag of PG record to be created.  Default value: MarkDuplicatesWithMateCigar. 

--PROGRAM_GROUP_VERSION,-PG_VERSION <String>
                              Value of VN tag of PG record to be created. If not specified, the version will be detected
                              automatically.  Default value: null. 

--PROGRAM_RECORD_ID,-PG <String>
                              The program record ID for the @PG record(s) created by this program. Set to null to
                              disable PG record creation.  This string may have a suffix appended to avoid collision
                              with other program record IDs.  Default value: MarkDuplicates. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_NAME_REGEX <String>    MarkDuplicates can use the tile and cluster positions to estimate the rate of optical
                              duplication in addition to the dominant source of duplication, PCR, to provide a more
                              accurate estimation of library size. By default (with no READ_NAME_REGEX specified),
                              MarkDuplicates will attempt to extract coordinates using a split on ':' (see Note below). 
                              Set READ_NAME_REGEX to 'null' to disable optical duplicate detection. Note that without
                              optical duplicate counts, library size estimation will be less accurate. If the read name
                              does not follow a standard Illumina colon-separation convention, but does contain tile and
                              x,y coordinates, a regular expression can be specified to extract three variables:
                              tile/region, x coordinate and y coordinate from a read name. The regular expression must
                              contain three capture groups for the three variables, in order. It must match the entire
                              read name.   e.g. if field names were separated by semi-colon (';') this example regex
                              could be specified      (?:.*;)?([0-9]+)[^;]*;([0-9]+)[^;]*;([0-9]+)[^;]*$ Note that if no
                              READ_NAME_REGEX is specified, the read name is split on ':'.   For 5 element names, the
                              3rd, 4th and 5th elements are assumed to be tile, x and y values.   For 7 element names
                              (CASAVA 1.8), the 5th, 6th, and 7th elements are assumed to be tile, x and y values. 
                              Default value: <optimized capture of last three ':' separated fields as numeric values>. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--REMOVE_DUPLICATES <Boolean> If true do not write duplicates to the output file instead of writing them with
                              appropriate flags set.  Default value: false. Possible values: {true, false} 

--SKIP_PAIRS_WITH_NO_MATE_CIGAR <Boolean>
                              Skip record pairs with no mate cigar and include them in the output.  Default value: true.
                              Possible values: {true, false} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_MergeBamAlignment

### Tool Description
Merge alignment data from a SAM or BAM with data in an unmapped BAM file. A command-line tool for merging BAM/SAM alignment info from a third-party aligner with the data in an unmapped BAM file, producing a third BAM file that has alignment data (from the aligner) and all the remaining data from the unmapped BAM.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: MergeBamAlignment [arguments]

Merge alignment data from a SAM or BAM with data in an unmapped BAM file.  <h3>Summary</h3>
A command-line tool for merging BAM/SAM alignment info from a third-party aligner with the data in an unmapped BAM file,
producing a third BAM file that has alignment data (from the aligner) and all the remaining data from the unmapped BAM.

Quick note: this is <b>not</b> a tool for taking multiple sam files and creating a bigger file by merging them. For that
use-case, see {@link MergeSamFiles}.

<h3>Details</h3>
Many alignment tools (still!) require fastq format input. The unmapped bam may contain useful information that will be
lost in the conversion to fastq (meta-data like sample alias, library, barcodes, etc., and read-level tags.)

This tool takes an unaligned bam with meta-data, and the aligned bam produced by calling {@link SamToFastq} and then
passing the result to an aligner/mapper. It produces a new SAM file that includes all aligned and unaligned reads and
also carries forward additional read attributes from the unmapped BAM (attributes that are otherwise lost in the process
of converting to fastq). The resulting file will be valid for use by Picard and GATK tools.

The output may be coordinate-sorted, in which case the tags, NM, MD, and UQ will be calculated and populated, or
query-name sorted, in which case the tags will not be calculated or populated.

<h3>Usage example:</h3>

java -jar picard.jar MergeBamAlignment \
ALIGNED=aligned.bam \
UNMAPPED=unmapped.bam \
O=merge_alignments.bam \
R=reference_sequence.fasta

<h3>Note about required arguments</h3>
The aligned reads must be specified using either the ALIGNED_BAM or READ1_ALIGNED_BAM and READ2_ALIGNED_BAM arguments. 
Without aligned reads specified in one of those manners, the tool will not run.<h3>Caveats</h3>
This tool has been developing for a while and many arguments have been added to it over the years. You may be
particularly interested in the following (partial) list:
<ul>
<li>CLIP_ADAPTERS -- Whether to (soft-)clip the ends of the reads that are identified as belonging to adapters</li>
<li>IS_BISULFITE_SEQUENCE -- Whether the sequencing originated from bisulfite sequencing, in which case NM will be
calculated differently</li>
<li>ALIGNER_PROPER_PAIR_FLAGS -- Use if the aligner that was used cannot be trusted to set the "Proper pair" flag and
then the tool will set this flag based on orientation and distance between pairs.</li>
<li>ADD_MATE_CIGAR -- Whether to use this opportunity to add the MC tag to each read.</li>
<li>UNMAP_CONTAMINANT_READS (and MIN_UNCLIPPED_BASES) -- Whether to identify extremely short alignments (with clipping
on both sides) as cross-species contamination and unmap the reads.</li>
</ul>

Version:3.4.0


Required Arguments:

--OUTPUT,-O <File>            Merged SAM or BAM file to write to.  Required. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Required. 

--UNMAPPED_BAM,-UNMAPPED <File>
                              Original SAM or BAM file of unmapped reads, which must be in queryname order.  Reads MUST
                              be unmapped.  Required. 


Optional Arguments:

--ADD_MATE_CIGAR,-MC <Boolean>Adds the mate CIGAR tag (MC) if true, does not if false.  Default value: true. Possible
                              values: {true, false} 

--ADD_PG_TAG_TO_READS <Boolean>
                              Add PG tag to each read in a SAM or BAM  Default value: true. Possible values: {true,
                              false} 

--ALIGNED_BAM,-ALIGNED <File> SAM or BAM file(s) with alignment data.  This argument may be specified 0 or more times.
                              Default value: null.  Cannot be used in conjunction with argument(s) READ1_ALIGNED_BAM
                              (R1_ALIGNED) READ2_ALIGNED_BAM (R2_ALIGNED)

--ALIGNED_READS_ONLY <Boolean>Whether to output only aligned reads.    Default value: false. Possible values: {true,
                              false} 

--ALIGNER_PROPER_PAIR_FLAGS <Boolean>
                              Use the aligner's idea of what a proper pair is rather than computing in this program. 
                              Default value: false. Possible values: {true, false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ATTRIBUTES_TO_REMOVE <String>
                              Attributes from the alignment record that should be removed when merging.  This overrides
                              ATTRIBUTES_TO_RETAIN if they share common tags.  This argument may be specified 0 or more
                              times. Default value: null. 

--ATTRIBUTES_TO_RETAIN <String>
                              Reserved alignment attributes (tags starting with X, Y, or Z) that should be brought over
                              from the alignment data when merging.  This argument may be specified 0 or more times.
                              Default value: null. 

--ATTRIBUTES_TO_REVERSE,-RV <String>
                              Attributes on negative strand reads that need to be reversed.  This argument may be
                              specified 0 or more times. Default value: [OQ, U2]. 

--ATTRIBUTES_TO_REVERSE_COMPLEMENT,-RC <String>
                              Attributes on negative strand reads that need to be reverse complemented.  This argument
                              may be specified 0 or more times. Default value: [E2, SQ]. 

--CLIP_ADAPTERS <Boolean>     Whether to clip adapters where identified.  Default value: true. Possible values: {true,
                              false} 

--CLIP_OVERLAPPING_READS <Boolean>
                              For paired reads, clip the 3' end of each read if necessary so that it does not extend
                              past the 5' end of its mate.  Reads are first soft clipped so that the 3' aligned end of
                              each read does not extend past the 5' aligned end of its mate.  If
                              HARD_CLIP_OVERLAPPING_READS is also true, then reads are additionally hard clipped so that
                              the 3' unclipped end of each read does not extend past the 5' unclipped end of its mate. 
                              Hard clipped bases and their qualities are stored in the XB and XQ tags, respectively. 
                              Default value: true. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--EXPECTED_ORIENTATIONS,-ORIENTATIONS <PairOrientation>
                              The expected orientation of proper read pairs. Replaces JUMP_SIZE  This argument may be
                              specified 0 or more times. Default value: null. Possible values: {FR, RF, TANDEM}  Cannot
                              be used in conjunction with argument(s) JUMP_SIZE (JUMP)

--HARD_CLIP_OVERLAPPING_READS <Boolean>
                              If true, hard clipping will be applied to overlapping reads.  By default, soft clipping is
                              used.  Default value: false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_SECONDARY_ALIGNMENTS <Boolean>
                              If false, do not write secondary alignments to output.  Default value: true. Possible
                              values: {true, false} 

--IS_BISULFITE_SEQUENCE <Boolean>
                              Whether the lane is bisulfite sequence (used when calculating the NM tag).  Default value:
                              false. Possible values: {true, false} 

--JUMP_SIZE,-JUMP <Integer>   The expected jump size (required if this is a jumping library). Deprecated. Use
                              EXPECTED_ORIENTATIONS instead  Default value: null.  Cannot be used in conjunction with
                              argument(s) EXPECTED_ORIENTATIONS (ORIENTATIONS)

--MATCHING_DICTIONARY_TAGS <String>
                              List of Sequence Records tags that must be equal (if present) in the reference dictionary
                              and in the aligned file. Mismatching tags will cause an error if in this list, and a
                              warning otherwise.  This argument may be specified 0 or more times. Default value: [M5,
                              LN]. 

--MAX_INSERTIONS_OR_DELETIONS,-MAX_GAPS <Integer>
                              The maximum number of insertions or deletions permitted for an alignment to be included.
                              Alignments with more than this many insertions or deletions will be ignored. Set to -1 to
                              allow any number of insertions or deletions.  Default value: 1. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MIN_UNCLIPPED_BASES <Integer>
                              If UNMAP_CONTAMINANT_READS is set, require this many unclipped bases or else the read will
                              be marked as contaminant.  Default value: 32. 

--PAIRED_RUN,-PE <Boolean>    DEPRECATED. This argument is ignored and will be removed.  Default value: true. Possible
                              values: {true, false} 

--PRIMARY_ALIGNMENT_STRATEGY <PrimaryAlignmentStrategy>
                              Strategy for selecting primary alignment when the aligner has provided more than one
                              alignment for a pair or fragment, and none are marked as primary, more than one is marked
                              as primary, or the primary alignment is filtered out for some reason. For all strategies,
                              ties are resolved arbitrarily.  Default value: BestMapq. BestMapq (Expects that multiple
                              alignments will be correlated with HI tag, and prefers the pair of alignments with the
                              largest MAPQ, in the absence of a primary selected by the aligner.)
                              EarliestFragment (Prefers the alignment which maps the earliest base in the read. Note
                              that EarliestFragment may not be used for paired reads.)
                              BestEndMapq (Appropriate for cases in which the aligner is not pair-aware, and does not
                              output the HI tag. It simply picks the alignment for each end with the highest MAPQ, and
                              makes those alignments primary, regardless of whether the two alignments make sense
                              together.)
                              MostDistant (Appropriate for a non-pair-aware aligner. Picks the alignment pair with the
                              largest insert size. If all alignments would be chimeric, it picks the alignments for each
                              end with the best MAPQ. )

--PROGRAM_GROUP_COMMAND_LINE,-PG_COMMAND <String>
                              The command line of the program group (if not supplied by the aligned file).  Default
                              value: null. 

--PROGRAM_GROUP_NAME,-PG_NAME <String>
                              The name of the program group (if not supplied by the aligned file).  Default value: null.

--PROGRAM_GROUP_VERSION,-PG_VERSION <String>
                              The version of the program group (if not supplied by the aligned file).  Default value:
                              null. 

--PROGRAM_RECORD_ID,-PG <String>
                              The program group ID of the aligner (if not supplied by the aligned file).  Default value:
                              null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ1_ALIGNED_BAM,-R1_ALIGNED <File>
                              SAM or BAM file(s) with alignment data from the first read of a pair.  This argument may
                              be specified 0 or more times. Default value: null.  Cannot be used in conjunction with
                              argument(s) ALIGNED_BAM (ALIGNED)

--READ1_TRIM,-R1_TRIM <Integer>
                              The number of bases trimmed from the beginning of read 1 prior to alignment  Default
                              value: 0. 

--READ2_ALIGNED_BAM,-R2_ALIGNED <File>
                              SAM or BAM file(s) with alignment data from the second read of a pair.  This argument may
                              be specified 0 or more times. Default value: null.  Cannot be used in conjunction with
                              argument(s) ALIGNED_BAM (ALIGNED)

--READ2_TRIM,-R2_TRIM <Integer>
                              The number of bases trimmed from the beginning of read 2 prior to alignment  Default
                              value: 0. 

--SORT_ORDER,-SO <SortOrder>  The order in which the merged reads should be output.  Default value: coordinate. Possible
                              values: {unsorted, queryname, coordinate, duplicate, unknown} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--UNMAP_CONTAMINANT_READS,-UNMAP_CONTAM <Boolean>
                              Detect reads originating from foreign organisms (e.g. bacterial DNA in a non-bacterial
                              sample),and unmap + label those reads accordingly.  Default value: false. Possible values:
                              {true, false} 

--UNMAPPED_READ_STRATEGY <UnmappingReadStrategy>
                              How to deal with alignment information in reads that are being unmapped (e.g. due to
                              cross-species contamination.) Currently ignored unless UNMAP_CONTAMINANT_READS = true.
                              Note that the DO_NOT_CHANGE strategy will actually reset the cigar and set the mapping
                              quality on unmapped reads since otherwisethe result will be an invalid record. To force no
                              change use the DO_NOT_CHANGE_INVALID strategy.  Default value: DO_NOT_CHANGE. Possible
                              values: {COPY_TO_TAG, DO_NOT_CHANGE, DO_NOT_CHANGE_INVALID, MOVE_TO_TAG} 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument UNMAPPED_BAM was missing: Argument 'UNMAPPED_BAM' is required
```


## picard_MergeSamFiles

### Tool Description
Merges multiple SAM/BAM/CRAM (and/or) files into a single file. This tool is used for combining SAM/BAM/CRAM (and/or) files from different runs or read groups into a single file, similarly to the "merge" function of Samtools.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: MergeSamFiles [arguments]

Merges multiple SAM/BAM/CRAM (and/or) files into a single file.  This tool is used for combining SAM/BAM/CRAM (and/or)
files from different runs or read groups into a single file, similarly to the "merge" function of Samtools
(http://www.htslib.org/doc/samtools.html).  <br /><br />Note that to prevent errors in downstream processing, it is
critical to identify/label read groups appropriately. If different samples contain identical read group IDs, this tool
will avoid collisions by modifying the read group IDs to be unique. For more information about read groups, see the <a
href='https://www.broadinstitute.org/gatk/guide/article?id=6472'>GATK Dictionary entry.</a> <br /><br /><br /><h4>Usage
example:</h4><pre>java -jar picard.jar MergeSamFiles \<br />      I=input_1.bam \<br />      I=input_2.bam \<br />     
O=output_merged_files.bam</pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <String>           SAM/BAM/CRAM input file  This argument must be specified at least once. Required. 

--OUTPUT,-O <File>            SAM/BAM/CRAM file to write merged result to  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORTED,-AS <Boolean> If true, assume that the input files are in the same sort order as the requested output
                              sort order, even if their headers say otherwise.  Default value: false. Possible values:
                              {true, false} 

--COMMENT,-CO <String>        Comment(s) to include in the merged output file's header.  This argument may be specified
                              0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INTERVALS,-RGN <File>       An interval list file that contains the locations of the positions to merge. Assume sam
                              are sorted and indexed. The resulting file will contain alignments that may overlap with
                              genomic regions outside the requested region. Unmapped reads are discarded.  Default
                              value: null. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MERGE_SEQUENCE_DICTIONARIES,-MSD <Boolean>
                              Merge the sequence dictionaries  Default value: false. Possible values: {true, false} 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SORT_ORDER,-SO <SortOrder>  Sort order of output file  Default value: coordinate. Possible values: {unsorted,
                              queryname, coordinate, duplicate, unknown} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--USE_THREADING <Boolean>     Option to create a background thread to encode, compress and write to disk the output
                              file. The threaded version uses about 20% more CPU and decreases runtime by ~20% when
                              writing out a compressed BAM/CRAM file.  Default value: false. Possible values: {true,
                              false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_PositionBasedDownsampleSam

### Tool Description
Class to downsample a SAM/BAM/CRAM file based on the position of the read in a flowcell. As with DownsampleSam, all the reads with the same queryname are either kept or dropped as a unit.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: PositionBasedDownsampleSam [arguments]

<h3>Summary</h3>
Class to downsample a SAM/BAM/CRAM file based on the position of the read in a flowcell. As with DownsampleSam, all the
reads with the same queryname are either kept or dropped as a unit.

<h3>Details</h3>
The downsampling is _not_ random (and there is no random seed). It is deterministically determined by the position of
each read within its tile. Specifically, it draws an ellipse that covers a FRACTION of the total tile's area and of all
the edges of the tile. It uses this area to determine whether to keep or drop the record. Since reads with the same name
have the same position (mates, secondary and supplemental alignments), the decision will be the same for all of them.
The main concern of this downsampling method is that due to "optical duplicates" downsampling randomly can create a
result that has a different optical duplicate rate, and therefore a different estimated library size (when running
MarkDuplicates). This method keeps (physically) close read together, so that (except for reads near the boundary of the
circle) optical duplicates are kept or dropped as a group. By default the program expects the read names to have 5 or 7
fields separated by colons (:) and it takes the last two to indicate the x and y coordinates of the reads within the
tile whence it was sequenced. See DEFAULT_READ_NAME_REGEX for more detail. The program traverses the INPUT twice: first
to find out the size of each of the tiles, and next to perform the downsampling. Downsampling invalidates the duplicate
flag because duplicate reads before downsampling may not all remain duplicated after downsampling. Thus, the default
setting also removes the duplicate information. 

Example

java -jar picard.jar PositionBasedDownsampleSam \
I=input.bam \
O=downsampled.bam \
FRACTION=0.1

Caveats

Note 1: This method is <b>technology and read-name dependent</b>. If the read-names do not have coordinate information
embedded in them, or if your BAM contains reads from multiple technologies (flowcell versions, sequencing machines) this
will not work properly. It has been designed to work with Illumina technology and reads-names. Consider modifying {@link
#READ_NAME_REGEX} in other cases. 

Note 2: The code has been designed to simulate, as accurately as possible, sequencing less, <b>not</b> for getting an
exact downsampled fraction (Use {@link DownsampleSam} for that.) In particular, since the reads may be distributed
non-evenly within the lanes/tiles, the resulting downsampling percentage will not be accurately determined by the input
argument FRACTION. 

Note 3:Consider running {@link MarkDuplicates} after downsampling in order to "expose" the duplicates whose
representative has been downsampled away.

Note 4:The downsampling assumes a uniform distribution of reads in the flowcell. Input already downsampled with
PositionBasedDownsampleSam violates this assumption. To guard against such input, PositionBasedDownsampleSam always
places a PG record in the header of its output, and aborts whenever it finds such a PG record in its input.
Version:3.4.0


Required Arguments:

--FRACTION,-F <Double>        The (approximate) fraction of reads to be kept, between 0 and 1.  Required. 

--INPUT,-I <File>             The input SAM/BAM/CRAM file to downsample.  Required. 

--OUTPUT,-O <File>            The output, downsampled, SAM/BAM/CRAM file.  Required. 


Optional Arguments:

--ALLOW_MULTIPLE_DOWNSAMPLING_DESPITE_WARNINGS <Boolean>
                              Allow downsampling again despite this being a bad idea with possibly unexpected results. 
                              Default value: false. Possible values: {true, false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_NAME_REGEX <String>    Use these regular expressions to parse read names in the input SAM file. Read names are
                              parsed to extract three variables: tile/region, x coordinate and y coordinate. The x and y
                              coordinates are used to determine the downsample decision. Set this option to null to
                              disable optical duplicate detection, e.g. for RNA-seq The regular expression should
                              contain three capture groups for the three variables, in order. It must match the entire
                              read name. Note that if the default regex is specified, a regex match is not actually
                              done, but instead the read name is split on colons (:). For 5 element names, the 3rd, 4th
                              and 5th elements are assumed to be tile, x and y values. For 7 element names (CASAVA 1.8),
                              the 5th, 6th, and 7th elements are assumed to be tile, x and y values.  Default value:
                              <optimized capture of last three ':' separated fields as numeric values>. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--REMOVE_DUPLICATE_INFORMATION <Boolean>
                              Determines whether the duplicate tag should be reset since the downsampling requires
                              re-marking duplicates.  Default value: true. Possible values: {true, false} 

--STOP_AFTER <Long>           Stop after processing N reads, mainly for debugging.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_ReorderSam

### Tool Description
Reorders reads in a SAM/BAM/CRAM file to match the contig ordering in a provided reference file, as determined by exact name matching of contigs. Reads mapped to contigs absent in the new reference are unmapped.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: ReorderSam [arguments]

Not to be confused with SortSam which sorts a file with a valid sequence dictionary, ReorderSam reorders reads in a
SAM/BAM/CRAM file to match the contig ordering in a provided reference file, as determined by exact name matching of
contigs.  Reads mapped to contigs absent in the new reference are unmapped. Runs substantially faster if the input is an
indexed BAM file.
Example

java -jar picard.jar ReorderSam \
INPUT=sample.bam \
OUTPUT=reordered.bam \
SEQUENCE_DICTIONARY=reference_with_different_order.dict

Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input file (SAM/BAM/CRAM) to extract reads from.  Required. 

--OUTPUT,-O <File>            Output file (SAM/BAM/CRAM) to write extracted reads to.  Required. 

--SEQUENCE_DICTIONARY,-SD <File>
                              A Sequence Dictionary for the OUTPUT file (can be read from one of the following file
                              types (SAM, BAM, CRAM, VCF, BCF, Interval List, Fasta, or Dict)  Required. 


Optional Arguments:

--ALLOW_CONTIG_LENGTH_DISCORDANCE,-U <Boolean>
                              If true, then permits mapping from a read contig to a new reference contig with the same
                              name but a different length.  Highly dangerous, only use if you know what you are doing. 
                              Default value: false. Possible values: {true, false} 

--ALLOW_INCOMPLETE_DICT_CONCORDANCE,-S <Boolean>
                              If true, allows only a partial overlap of the original contigs with the new reference
                              sequence contigs.  By default, this tool requires a corresponding contig in the new
                              reference for each read contig  Default value: false. Possible values: {true, false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_ReplaceSamHeader

### Tool Description
Replaces the SAMFileHeader in a SAM/BAM/CRAM file. This tool makes it possible to replace the header of a SAM/BAM/CRAM file with the header of another file, or a header block that has been edited manually (in a stub SAM file). The sort order (@SO) of the two input files must be the same.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: ReplaceSamHeader [arguments]

Replaces the SAMFileHeader in a SAM/BAM/CRAM file.  This tool makes it possible to replace the header of a SAM/BAM/CRAM
file with the header of anotherfile, or a header block that has been edited manually (in a stub SAM file). The sort
order (@SO) of the two input files must be the same.<br /><br />Note that validation is minimal, so it is up to the user
to ensure that all the elements referred to in the SAMRecords are present in the new header. <br /><h4>Usage
example:</h4><pre>java -jar picard.jar ReplaceSamHeader \<br />      I=input_1.bam \<br />      HEADER=input_2.bam \<br
/>      O=bam_with_new_head.bam</pre><hr />
Version:3.4.0


Required Arguments:

--HEADER <File>               SAM/BAM/CRAM file from which SAMFileHeader will be read.  Required. 

--INPUT,-I <File>             SAM/BAM/CRAM file from which SAMRecords will be read.  Required. 

--OUTPUT,-O <File>            header from HEADER file will be written to this file, followed by records from INPUT file 
                              Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_RevertOriginalBaseQualitiesAndAddMateCigar

### Tool Description
Reverts the original base qualities and adds the mate cigar tag to read-group files.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: RevertOriginalBaseQualitiesAndAddMateCigar [arguments]

Reverts the original base qualities and adds the mate cigar tag to read-group files.
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The input SAM/BAM/CRAM file to revert the state of.  Required. 

--OUTPUT,-O <File>            The output SAM/BAM/CRAM file to create.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: true. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              true. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MAX_RECORDS_TO_EXAMINE <Integer>
                              The maximum number of records to examine to determine if we can exit early and not output,
                              given that there are a no original base qualities (if we are to restore) and mate cigars
                              exist. Set to 0 to never skip the file.  Default value: 10000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--RESTORE_ORIGINAL_QUALITIES,-OQ <Boolean>
                              True to restore original qualities from the OQ field to the QUAL field if available. 
                              Default value: true. Possible values: {true, false} 

--SORT_ORDER,-SO <SortOrder>  The sort order to create the reverted output file with.By default, the sort order will be
                              the same as the input.  Default value: null. Possible values: {unsorted, queryname,
                              coordinate, duplicate, unknown} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_RevertSam

### Tool Description
Reverts SAM/BAM/CRAM files to a previous state. This tool removes or restores certain properties of the SAM records, including alignment information, which can be used to produce an unmapped BAM (uBAM) from a previously aligned BAM.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: RevertSam [arguments]

Reverts SAM/BAM/CRAM files to a previous state.  This tool removes or restores certain properties of the SAM records,
including alignment information, which can be used to produce an unmapped BAM (uBAM) from a previously aligned BAM. It
is also capable of restoring the original quality scores of a BAM file that has already undergone base quality score
recalibration (BQSR) if theoriginal qualities were retained.
<h3>Examples</h3>
<h4>Example with single output:</h4>
java -jar picard.jar RevertSam \
I=input.bam \
O=reverted.bam

<h4>Example outputting by read group with output map:</h4>
java -jar picard.jar RevertSam \
I=input.bam \
OUTPUT_BY_READGROUP=true \
OUTPUT_MAP=reverted_bam_paths.tsv

Will output a BAM/SAM file per read group.
<h4>Example outputting by read group without output map:</h4>
java -jar picard.jar RevertSam \
I=input.bam \
OUTPUT_BY_READGROUP=true \
O=/write/reverted/read/group/bams/in/this/dir

Will output one file per read group. Output format can be overridden with the OUTPUT_BY_READGROUP_FILE_FORMAT option.
Note: If the program fails due to a validation error, consider setting the VALIDATION_STRINGENCY option to LENIENT or
SILENT if the failures are expected to be obviated by the reversion process (e.g. invalid alignment information will be
obviated when the REMOVE_ALIGNMENT_INFORMATION option is used).

Version:3.4.0


Required Arguments:

--INPUT,-I <PicardHtsPath>    The input SAM/BAM/CRAM file to revert the state of.  Required. 

--OUTPUT,-O <PicardHtsPath>   The output SAM/BAM/CRAM file to create, or an output directory if OUTPUT_BY_READGROUP is
                              true.  Required.  Cannot be used in conjunction with argument(s) OUTPUT_MAP (OM)

--OUTPUT_MAP,-OM <PicardHtsPath>
                              Tab separated file with two columns, READ_GROUP_ID and OUTPUT, providing file mapping only
                              used if OUTPUT_BY_READGROUP is true.  Required.  Cannot be used in conjunction with
                              argument(s) OUTPUT (O)


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ATTRIBUTE_TO_CLEAR <String> When removing alignment information, the set of optional tags to remove.  This argument
                              may be specified 0 or more times. Default value: [NM, UQ, PG, MD, MQ, SA, MC, AS]. 

--ATTRIBUTE_TO_REVERSE,-RV <String>
                              Attributes on negative strand reads that need to be reversed.  This argument may be
                              specified 0 or more times. Default value: [OQ, U2]. 

--ATTRIBUTE_TO_REVERSE_COMPLEMENT,-RC <String>
                              Attributes on negative strand reads that need to be reverse complemented.  This argument
                              may be specified 0 or more times. Default value: [E2, SQ]. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--KEEP_FIRST_DUPLICATE <Boolean>
                              If SANITIZE=true keep the first record when we find more than one record with the same
                              name for R1/R2/unpaired reads respectively. For paired end reads, keeps only the first R1
                              and R2 found respectively, and discards all unpaired reads. Duplicates do not refer to the
                              duplicate flag in the FLAG field, but instead reads with the same name.  Default value:
                              false. Possible values: {true, false} 

--LIBRARY_NAME,-LIB <String>  The library name to use in the reverted output file.  This will override the existing
                              sample alias in the file and is used only if all the read groups in the input file have
                              the same library name.  Default value: null. 

--MAX_DISCARD_FRACTION <Double>
                              If SANITIZE=true and higher than MAX_DISCARD_FRACTION reads are discarded due to
                              sanitization then the program will exit with an Exception instead of exiting cleanly.
                              Output BAM will still be valid.  Default value: 0.01. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--OUTPUT_BY_READGROUP,-OBR <Boolean>
                              When true, outputs each read group in a separate file.  Default value: false. Possible
                              values: {true, false} 

--OUTPUT_BY_READGROUP_FILE_FORMAT,-OBRFF <FileType>
                              When using OUTPUT_BY_READGROUP, the output file format can be set to a certain format. 
                              Default value: dynamic. sam (Generate SAM files.)
                              bam (Generate BAM files.)
                              cram (Generate CRAM files.)
                              dynamic (Generate files based on the extention of INPUT.)

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--REMOVE_ALIGNMENT_INFORMATION <Boolean>
                              Remove all alignment information from the file.  Default value: true. Possible values:
                              {true, false} 

--REMOVE_DUPLICATE_INFORMATION <Boolean>
                              Remove duplicate read flags from all reads.  Note that if this is false and
                              REMOVE_ALIGNMENT_INFORMATION==true,  the output may have the unusual but sometimes
                              desirable trait of having unmapped reads that are marked as duplicates.  Default value:
                              true. Possible values: {true, false} 

--RESTORE_HARDCLIPS,-RHC <Boolean>
                              When true, restores reads and qualities of records with hard-clips containing XB and XQ
                              tags.  Default value: true. Possible values: {true, false} 

--RESTORE_ORIGINAL_QUALITIES,-OQ <Boolean>
                              True to restore original qualities from the OQ field to the QUAL field if available. 
                              Default value: true. Possible values: {true, false} 

--SAMPLE_ALIAS,-ALIAS <String>The sample alias to use in the reverted output file.  This will override the existing
                              sample alias in the file and is used only if all the read groups in the input file have
                              the same sample alias.  Default value: null. 

--SANITIZE <Boolean>          WARNING: This option is potentially destructive. If enabled will discard reads in order to
                              produce a consistent output BAM. Reads discarded include (but are not limited to) paired
                              reads with missing mates, duplicated records, records with mismatches in length of bases
                              and qualities. This option can only be enabled if the output sort order is queryname and
                              will always cause sorting to occur.  Default value: false. Possible values: {true, false} 

--SORT_ORDER,-SO <SortOrder>  The sort order to create the reverted output file with.  Default value: queryname.
                              Possible values: {unsorted, queryname, coordinate, duplicate, unknown} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_SamFormatConverter

### Tool Description
Convert a BAM file to a SAM file, or SAM to BAM. Input and output formats are determined by file extension.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: SamFormatConverter [arguments]

Convert a BAM file to a SAM file, or SAM to BAM.
Input and output formats are determined by file extension.
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The SAM/BAM/CRAM file to parse.  Required. 

--OUTPUT,-O <File>            The SAM/BAM/CRAM output file.   Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_SamToFastq

### Tool Description
Converts a SAM/BAM/CRAM file to FASTQ. Extracts read sequences and qualities from the input SAM/BAM/CRAM file and writes them into the output file in Sanger FASTQ format.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: SamToFastq [arguments]

Converts a SAM/BAM/CRAM file to FASTQ.Extracts read sequences and qualities from the input SAM/BAM/CRAM file and writes
them into the output file in Sanger FASTQ format. See <a href="http://maq.sourceforge.net/fastq.shtml">MAQ FASTQ
specification</a> for details. This tool can be used by way of a pipe to run BWA MEM on unmapped BAM (uBAM) files
efficiently.</p><p>In the RC mode (default is True), if the read is aligned and the alignment is to the reverse strand
on the genome, the read's sequence from input SAM file will be reverse-complemented prior to writing it to FASTQ in
order restore correctly the original read sequence as it was generated by the sequencer.</p><p>Note: This tool works
with both coordinate-sorted and name-sorted inputs. Although mates come with the same order in both FASTQ files, the
behavior is different between coordinate-sorted versus name-sorted BAM files. Name-sorted BAM files will produce the
very same FASTQs generated from the sequencer, whereas coordinate-sorted BAMs will result in a scrambled FASTQ file
where mates match but the reads are not sorted by name. This may result in slightly different outcomes when used with
non-deterministic mappers such as BWA.</p><br /><h4>Usage example:</h4><pre>java -jar picard.jar SamToFastq <br />    
I=input.bam<br />     FASTQ=output.fastq</pre><hr />
Version:3.4.0


Required Arguments:

--FASTQ,-F <File>             Output FASTQ file (single-end fastq or, if paired, first end of the pair FASTQ). 
                              Required.  Cannot be used in conjunction with argument(s) OUTPUT_PER_RG (OPRG)
                              COMPRESS_OUTPUTS_PER_RG (GZOPRG) OUTPUT_DIR (ODIR)

--INPUT,-I <File>             Input SAM/BAM/CRAM file to extract reads from  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--CLIPPING_ACTION,-CLIP_ACT <String>
                              The action that should be taken with clipped reads: 'X' means the reads and qualities
                              should be trimmed at the clipped position; 'N' means the bases should be changed to Ns in
                              the clipped region; and any integer means that the base qualities should be set to that
                              value in the clipped region.  Default value: null. 

--CLIPPING_ATTRIBUTE,-CLIP_ATTR <String>
                              The attribute that stores the position at which the SAM record should be clipped  Default
                              value: null. 

--CLIPPING_MIN_LENGTH,-CLIP_MIN <Integer>
                              When performing clipping with the CLIPPING_ATTRIBUTE and CLIPPING_ACTION parameters,
                              ensure that the resulting reads after clipping are at least CLIPPING_MIN_LENGTH bases
                              long. If the original read is shorter than CLIPPING_MIN_LENGTH then the original read
                              length will be maintained.  Default value: 0. 

--COMPRESS_OUTPUTS_PER_RG,-GZOPRG <Boolean>
                              Compress output FASTQ files per read group using gzip and append a .gz extension to the
                              file names.  Default value: false. Possible values: {true, false}  Cannot be used in
                              conjunction with argument(s) FASTQ (F) SECOND_END_FASTQ (F2) UNPAIRED_FASTQ (FU)

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_NON_PF_READS,-NON_PF <Boolean>
                              Include non-PF reads from the SAM file into the output FASTQ files. PF means 'passes
                              filtering'. Reads whose 'not passing quality controls' flag is set are non-PF reads. See
                              GATK Dictionary for more info.  Default value: false. Possible values: {true, false} 

--INCLUDE_NON_PRIMARY_ALIGNMENTS <Boolean>
                              If true, include non-primary alignments in the output.  Support of non-primary alignments
                              in SamToFastq is not comprehensive, so there may be exceptions if this is set to true and
                              there are paired reads with non-primary alignments.  Default value: false. Possible
                              values: {true, false} 

--INTERLEAVE,-INTER <Boolean> Will generate an interleaved fastq if paired, each line will have /1 or /2 to describe
                              which end it came from  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--OUTPUT_DIR,-ODIR <File>     Directory in which to output the FASTQ file(s).  Used only when OUTPUT_PER_RG is true. 
                              Default value: null.  Cannot be used in conjunction with argument(s) FASTQ (F)

--OUTPUT_PER_RG,-OPRG <Boolean>
                              Output a FASTQ file per read group (two FASTQ files per read group if the group is
                              paired).  Default value: false. Possible values: {true, false}  Cannot be used in
                              conjunction with argument(s) FASTQ (F) SECOND_END_FASTQ (F2) UNPAIRED_FASTQ (FU)

--QUALITY,-Q <Integer>        End-trim reads using the phred/bwa quality trimming algorithm and this quality.  Default
                              value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--RE_REVERSE,-RC <Boolean>    Re-reverse bases and qualities of reads with negative strand flag set before writing them
                              to FASTQ  Default value: true. Possible values: {true, false} 

--READ1_MAX_BASES_TO_WRITE,-R1_MAX_BASES <Integer>
                              The maximum number of bases to write from read 1 after trimming. If there are fewer than
                              this many bases left after trimming, all will be written.  If this value is null then all
                              bases left after trimming will be written.  Default value: null. 

--READ1_TRIM,-R1_TRIM <Integer>
                              The number of bases to trim from the beginning of read 1.  Default value: 0. 

--READ2_MAX_BASES_TO_WRITE,-R2_MAX_BASES <Integer>
                              The maximum number of bases to write from read 2 after trimming. If there are fewer than
                              this many bases left after trimming, all will be written.  If this value is null then all
                              bases left after trimming will be written.  Default value: null. 

--READ2_TRIM,-R2_TRIM <Integer>
                              The number of bases to trim from the beginning of read 2.  Default value: 0. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--RG_TAG,-RGT <String>        The read group tag (PU or ID) to be used to output a FASTQ file per read group.  Default
                              value: PU. 

--SECOND_END_FASTQ,-F2 <File> Output FASTQ file (if paired, second end of the pair FASTQ).  Default value: null.  Cannot
                              be used in conjunction with argument(s) OUTPUT_PER_RG (OPRG) COMPRESS_OUTPUTS_PER_RG
                              (GZOPRG)

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--UNPAIRED_FASTQ,-FU <File>   Output FASTQ file for unpaired reads; may only be provided in paired-FASTQ mode  Default
                              value: null.  Cannot be used in conjunction with argument(s) OUTPUT_PER_RG (OPRG)
                              COMPRESS_OUTPUTS_PER_RG (GZOPRG)

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_SamToFastqWithTags

### Tool Description
Converts a SAM or BAM file to FASTQ alongside FASTQs created from tags. Extracts read sequences and qualities from the input SAM/BAM file and SAM/BAM tags and writes them into the output file in Sanger FASTQ format.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: SamToFastqWithTags [arguments]

Converts a SAM or BAM file to FASTQ alongside FASTQs created from tags. Extracts read sequences and qualities from the
input SAM/BAM file and SAM/BAM tags and writes them into the output file in Sanger FASTQ format. See <a
href="http://maq.sourceforge.net/fastq.shtml">MAQ FASTQ specification</a> for details.<br /> <br />The following example
will create two FASTQs from tags.  One will be converted with the base sequence coming from the "CR" tag and base
quality from the "CY" tag.  The other fastq will be converted with the base sequence coming from the "CB" and "UR" tags
concatenated together with no separator (not specified on command line) with the base qualities coming from the "CY" and
"UY" tags concatenated together.  The two files will be named CR.fastq and CB_UR.fastq.<br /><pre>java -jar picard.jar
SamToFastqWithTags <br />     I=input.bam<br />     FASTQ=output.fastq<br />     SEQUENCE_TAG_GROUP=CR<br />    
QUALITY_TAG_GROUP=CY<br />     SEQUENCE_TAG_GROUP="CB,UR"<br />     QUALITY_TAG_GROUP="CY,UY"</pre><hr />
Version:3.4.0


Required Arguments:

--FASTQ,-F <File>             Output FASTQ file (single-end fastq or, if paired, first end of the pair FASTQ). 
                              Required.  Cannot be used in conjunction with argument(s) OUTPUT_PER_RG (OPRG)
                              COMPRESS_OUTPUTS_PER_RG (GZOPRG) OUTPUT_DIR (ODIR)

--INPUT,-I <File>             Input SAM/BAM/CRAM file to extract reads from  Required. 

--SEQUENCE_TAG_GROUP,-STG <String>
                              List of comma separated tag values to extract from Input SAM/BAM to be used as read
                              sequence  This argument must be specified at least once. Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--CLIPPING_ACTION,-CLIP_ACT <String>
                              The action that should be taken with clipped reads: 'X' means the reads and qualities
                              should be trimmed at the clipped position; 'N' means the bases should be changed to Ns in
                              the clipped region; and any integer means that the base qualities should be set to that
                              value in the clipped region.  Default value: null. 

--CLIPPING_ATTRIBUTE,-CLIP_ATTR <String>
                              The attribute that stores the position at which the SAM record should be clipped  Default
                              value: null. 

--CLIPPING_MIN_LENGTH,-CLIP_MIN <Integer>
                              When performing clipping with the CLIPPING_ATTRIBUTE and CLIPPING_ACTION parameters,
                              ensure that the resulting reads after clipping are at least CLIPPING_MIN_LENGTH bases
                              long. If the original read is shorter than CLIPPING_MIN_LENGTH then the original read
                              length will be maintained.  Default value: 0. 

--COMPRESS_OUTPUTS_PER_RG,-GZOPRG <Boolean>
                              Compress output FASTQ files per read group using gzip and append a .gz extension to the
                              file names.  Default value: false. Possible values: {true, false}  Cannot be used in
                              conjunction with argument(s) FASTQ (F) SECOND_END_FASTQ (F2) UNPAIRED_FASTQ (FU)

--COMPRESS_OUTPUTS_PER_TAG_GROUP,-GZOPTG <Boolean>
                              Compress output FASTQ files per Tag grouping using gzip and append a .gz extension to the
                              file names.  Default value: false. Possible values: {true, false} 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_NON_PF_READS,-NON_PF <Boolean>
                              Include non-PF reads from the SAM file into the output FASTQ files. PF means 'passes
                              filtering'. Reads whose 'not passing quality controls' flag is set are non-PF reads. See
                              GATK Dictionary for more info.  Default value: false. Possible values: {true, false} 

--INCLUDE_NON_PRIMARY_ALIGNMENTS <Boolean>
                              If true, include non-primary alignments in the output.  Support of non-primary alignments
                              in SamToFastq is not comprehensive, so there may be exceptions if this is set to true and
                              there are paired reads with non-primary alignments.  Default value: false. Possible
                              values: {true, false} 

--INTERLEAVE,-INTER <Boolean> Will generate an interleaved fastq if paired, each line will have /1 or /2 to describe
                              which end it came from  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--OUTPUT_DIR,-ODIR <File>     Directory in which to output the FASTQ file(s).  Used only when OUTPUT_PER_RG is true. 
                              Default value: null.  Cannot be used in conjunction with argument(s) FASTQ (F)

--OUTPUT_PER_RG,-OPRG <Boolean>
                              Output a FASTQ file per read group (two FASTQ files per read group if the group is
                              paired).  Default value: false. Possible values: {true, false}  Cannot be used in
                              conjunction with argument(s) FASTQ (F) SECOND_END_FASTQ (F2) UNPAIRED_FASTQ (FU)

--QUALITY,-Q <Integer>        End-trim reads using the phred/bwa quality trimming algorithm and this quality.  Default
                              value: null. 

--QUALITY_TAG_GROUP,-QTG <String>
                              List of comma separated tag values to extract from Input SAM/BAM to be used as read
                              qualities  This argument may be specified 0 or more times. Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--RE_REVERSE,-RC <Boolean>    Re-reverse bases and qualities of reads with negative strand flag set before writing them
                              to FASTQ  Default value: true. Possible values: {true, false} 

--READ1_MAX_BASES_TO_WRITE,-R1_MAX_BASES <Integer>
                              The maximum number of bases to write from read 1 after trimming. If there are fewer than
                              this many bases left after trimming, all will be written.  If this value is null then all
                              bases left after trimming will be written.  Default value: null. 

--READ1_TRIM,-R1_TRIM <Integer>
                              The number of bases to trim from the beginning of read 1.  Default value: 0. 

--READ2_MAX_BASES_TO_WRITE,-R2_MAX_BASES <Integer>
                              The maximum number of bases to write from read 2 after trimming. If there are fewer than
                              this many bases left after trimming, all will be written.  If this value is null then all
                              bases left after trimming will be written.  Default value: null. 

--READ2_TRIM,-R2_TRIM <Integer>
                              The number of bases to trim from the beginning of read 2.  Default value: 0. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--RG_TAG,-RGT <String>        The read group tag (PU or ID) to be used to output a FASTQ file per read group.  Default
                              value: PU. 

--SECOND_END_FASTQ,-F2 <File> Output FASTQ file (if paired, second end of the pair FASTQ).  Default value: null.  Cannot
                              be used in conjunction with argument(s) OUTPUT_PER_RG (OPRG) COMPRESS_OUTPUTS_PER_RG
                              (GZOPRG)

--TAG_GROUP_SEPERATOR,-SEP <String>
                              List of any sequences (e.g. 'AACCTG`) to put in between each comma separated list of
                              sequence tags in each SEQUENCE_TAG_GROUP (STG)  This argument may be specified 0 or more
                              times. Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--UNPAIRED_FASTQ,-FU <File>   Output FASTQ file for unpaired reads; may only be provided in paired-FASTQ mode  Default
                              value: null.  Cannot be used in conjunction with argument(s) OUTPUT_PER_RG (OPRG)
                              COMPRESS_OUTPUTS_PER_RG (GZOPRG)

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument SEQUENCE_TAG_GROUP was missing: Argument 'SEQUENCE_TAG_GROUP' is required
```


## picard_SetNmMdAndUqTags

### Tool Description
This tool takes in a coordinate-sorted SAM/BAM/CRAM and calculates the NM, MD, and UQ tags by comparing with the reference. This may be needed when MergeBamAlignment was run with SORT_ORDER other than 'coordinate' and thus could not fix these tags then. The input must be coordinate sorted in order to run. If specified, the MD and NM tags can be ignored and only the UQ tag be set.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: SetNmMdAndUqTags [arguments]

This tool takes in a coordinate-sorted SAM/BAM/CRAM and calculatesthe NM, MD, and UQ tags by comparing with the
reference.<br />This may be needed when MergeBamAlignment was run with SORT_ORDER other than 'coordinate' and thuscould
not fix these tags then. The input must be coordinate sorted in order to run. If specified,the MD and NM tags can be
ignored and only the UQ tag be set.<br /><h4>Usage example:</h4><pre>java -jar picard.jar SetNmMDAndUqTags \<br />     
I=sorted.bam \<br />      O=fixed.bam \<br /></pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The SAM/BAM/CRAM file to fix.  Required. 

--OUTPUT,-O <File>            The fixed SAM/BAM/CRAM output file.   Required. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--IS_BISULFITE_SEQUENCE <Boolean>
                              Whether the file contains bisulfite sequence (used when calculating the NM tag).  Default
                              value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--SET_ONLY_UQ <Boolean>       Only set the UQ tag, ignore MD and NM.  Default value: false. Possible values: {true,
                              false} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_SimpleMarkDuplicatesWithMateCigar

### Tool Description
Examines aligned records in the supplied SAM/BAM/CRAM file to locate duplicate molecules. All records are then written to the output file with the duplicate records flagged.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory


**EXPERIMENTAL FEATURE - USE AT YOUR OWN RISK**

USAGE: SimpleMarkDuplicatesWithMateCigar [arguments]

Examines aligned records in the supplied SAM/BAM/CRAM file to locate duplicate molecules. All records are then written
to the output file with the duplicate records flagged.
Version:3.4.0


Required Arguments:

--INPUT,-I <String>           One or more input SAM, BAM or CRAM files to analyze. Must be coordinate sorted.  This
                              argument must be specified at least once. Required. 

--METRICS_FILE,-M <File>      File to write duplication metrics to  Required. 

--OUTPUT,-O <File>            The output file to write marked records to  Required. 


Optional Arguments:

--ADD_PG_TAG_TO_READS <Boolean>
                              Add PG tag to each read in a SAM or BAM  Default value: true. Possible values: {true,
                              false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORT_ORDER,-ASO <SortOrder>
                              If not null, assume that the input file has this order even if the header says otherwise. 
                              Default value: null. Possible values: {unsorted, queryname, coordinate, duplicate,
                              unknown}  Cannot be used in conjunction with argument(s) ASSUME_SORTED (AS)

--ASSUME_SORTED,-AS <Boolean> If true, assume that the input file is coordinate sorted even if the header says
                              otherwise. Deprecated, used ASSUME_SORT_ORDER=coordinate instead.  Default value: false.
                              Possible values: {true, false}  Cannot be used in conjunction with argument(s)
                              ASSUME_SORT_ORDER (ASO)

--BARCODE_TAG <String>        Barcode SAM tag (ex. BC for 10X Genomics)  Default value: null. 

--CLEAR_DT <Boolean>          Clear DT tag from input SAM records. Should be set to false if input SAM doesn't have this
                              tag.  Default true  Default value: true. Possible values: {true, false} 

--COMMENT,-CO <String>        Comment(s) to include in the output file's header.  This argument may be specified 0 or
                              more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DUPLEX_UMI <Boolean>        Treat UMIs as being duplex stranded.  This option requires that the UMI consist of two
                              equal length strings that are separated by a hyphen (e.g. 'ATC-GTC'). Reads are considered
                              duplicates if, in addition to standard definition, have identical normalized UMIs.  A UMI
                              from the 'bottom' strand is normalized by swapping its content around the hyphen (eg.
                              ATC-GTC becomes GTC-ATC).  A UMI from the 'top' strand is already normalized as it is.
                              Both reads from a read pair considered top strand if the read 1 unclipped 5' coordinate is
                              less than the read 2 unclipped 5' coordinate. All chimeric reads and read fragments are
                              treated as having come from the top strand. With this option is it required that the
                              BARCODE_TAG hold non-normalized UMIs. Default false.  Default value: false. Possible
                              values: {true, false} 

--DUPLICATE_SCORING_STRATEGY,-DS <ScoringStrategy>
                              The scoring strategy for choosing the non-duplicate among candidates.  Default value:
                              SUM_OF_BASE_QUALITIES. Possible values: {SUM_OF_BASE_QUALITIES,
                              TOTAL_MAPPED_REFERENCE_LENGTH, RANDOM} 

--FLOW_DUP_STRATEGY <FLOW_DUPLICATE_SELECTION_STRATEGY>
                              Use specific quality summing strategy for flow based reads. Two strategies are available:
                              FLOW_QUALITY_SUM_STRATEG: The selects the read with the best total homopolymer quality.
                              FLOW_END_QUALITY_STRATEGY: The strategy selects the read with the best homopolymer quality
                              close to the end (10 bases) of the read.  The latter strategy is recommended for samples
                              with high duplication rate   Default value: FLOW_QUALITY_SUM_STRATEGY. Possible values:
                              {FLOW_QUALITY_SUM_STRATEGY, FLOW_END_QUALITY_STRATEGY} 

--FLOW_EFFECTIVE_QUALITY_THRESHOLD <Integer>
                              Threshold for considering a quality value high enough to be included when calculating
                              FLOW_QUALITY_SUM_STRATEGY calculation.  Default value: 15. 

--FLOW_MODE <Boolean>         enable parameters and behavior specific to flow based reads.  Default value: false.
                              Possible values: {true, false} 

--FLOW_Q_IS_KNOWN_END <Boolean>
                              Treat position of read trimming based on quality as the known end (relevant for flow based
                              reads). Default false - if the read is trimmed on quality its end is not defined and the
                              read is duplicate of any read starting at the same place.  Default value: false. Possible
                              values: {true, false} 

--FLOW_SKIP_FIRST_N_FLOWS <Integer>
                              Skip first N flows, starting from the read's start, when considering duplicates. Useful
                              for flow based reads where sometimes there is noise in the first flows (for this argument,
                              "read start" means 5' end).  Default value: 0. 

--FLOW_UNPAIRED_END_UNCERTAINTY <Integer>
                              Maximal difference of the read end position that counted as equal. Useful for flow based
                              reads where the end position might vary due to sequencing errors. (for this argument,
                              "read end" means 3' end)  Default value: 0. 

--FLOW_UNPAIRED_START_UNCERTAINTY <Integer>
                              Maximal difference of the read start position that counted as equal. Useful for flow based
                              reads where the end position might vary due to sequencing errors. (for this argument,
                              "read start" means 5' end in the direction of sequencing)  Default value: 0. 

--FLOW_USE_END_IN_UNPAIRED_READS <Boolean>
                              Make the end location of single end read be significant when considering duplicates, in
                              addition to the start location, which is always significant (i.e. require single-ended
                              reads to start andend on the same position to be considered duplicate) (for this argument,
                              "read end" means 3' end).  Default value: false. Possible values: {true, false} 

--FLOW_USE_UNPAIRED_CLIPPED_END <Boolean>
                              Use position of the clipping as the end position, when considering duplicates (or use the
                              unclipped end position) (for this argument, "read end" means 3' end).  Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_FILE_HANDLES_FOR_READ_ENDS_MAP,-MAX_FILE_HANDLES <Integer>
                              Maximum number of file handles to keep open when spilling read ends to disk. Set this
                              number a little lower than the per-process maximum number of file that may be open. This
                              number can be found by executing the 'ulimit -n' command on a Unix system.  Default value:
                              8000. 

--MAX_OPTICAL_DUPLICATE_SET_SIZE <Long>
                              This number is the maximum size of a set of duplicate reads for which we will attempt to
                              determine which are optical duplicates.  Please be aware that if you raise this value too
                              high and do encounter a very large set of duplicate reads, it will severely affect the
                              runtime of this tool.  To completely disable this check, set the value to -1.  Default
                              value: 300000. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MAX_SEQUENCES_FOR_DISK_READ_ENDS_MAP,-MAX_SEQS <Integer>
                              This option is obsolete. ReadEnds will always be spilled to disk.  Default value: 50000. 

--MOLECULAR_IDENTIFIER_TAG <String>
                              SAM tag to uniquely identify the molecule from which a read was derived.  Use of this
                              option requires that the BARCODE_TAG option be set to a non null value.  Default null. 
                              Default value: null. 

--OPTICAL_DUPLICATE_PIXEL_DISTANCE <Integer>
                              The maximum offset between two duplicate clusters in order to consider them optical
                              duplicates. The default is appropriate for unpatterned versions of the Illumina platform.
                              For the patterned flowcell models, 2500 is moreappropriate. For other platforms and
                              models, users should experiment to find what works best.  Default value: 100. 

--PROGRAM_GROUP_COMMAND_LINE,-PG_COMMAND <String>
                              Value of CL tag of PG record to be created. If not supplied the command line will be
                              detected automatically.  Default value: null. 

--PROGRAM_GROUP_NAME,-PG_NAME <String>
                              Value of PN tag of PG record to be created.  Default value:
                              SimpleMarkDuplicatesWithMateCigar. 

--PROGRAM_GROUP_VERSION,-PG_VERSION <String>
                              Value of VN tag of PG record to be created. If not specified, the version will be detected
                              automatically.  Default value: null. 

--PROGRAM_RECORD_ID,-PG <String>
                              The program record ID for the @PG record(s) created by this program. Set to null to
                              disable PG record creation.  This string may have a suffix appended to avoid collision
                              with other program record IDs.  Default value: MarkDuplicates. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_NAME_REGEX <String>    MarkDuplicates can use the tile and cluster positions to estimate the rate of optical
                              duplication in addition to the dominant source of duplication, PCR, to provide a more
                              accurate estimation of library size. By default (with no READ_NAME_REGEX specified),
                              MarkDuplicates will attempt to extract coordinates using a split on ':' (see Note below). 
                              Set READ_NAME_REGEX to 'null' to disable optical duplicate detection. Note that without
                              optical duplicate counts, library size estimation will be less accurate. If the read name
                              does not follow a standard Illumina colon-separation convention, but does contain tile and
                              x,y coordinates, a regular expression can be specified to extract three variables:
                              tile/region, x coordinate and y coordinate from a read name. The regular expression must
                              contain three capture groups for the three variables, in order. It must match the entire
                              read name.   e.g. if field names were separated by semi-colon (';') this example regex
                              could be specified      (?:.*;)?([0-9]+)[^;]*;([0-9]+)[^;]*;([0-9]+)[^;]*$ Note that if no
                              READ_NAME_REGEX is specified, the read name is split on ':'.   For 5 element names, the
                              3rd, 4th and 5th elements are assumed to be tile, x and y values.   For 7 element names
                              (CASAVA 1.8), the 5th, 6th, and 7th elements are assumed to be tile, x and y values. 
                              Default value: <optimized capture of last three ':' separated fields as numeric values>. 

--READ_ONE_BARCODE_TAG <String>
                              Read one barcode SAM tag (ex. BX for 10X Genomics)  Default value: null. 

--READ_TWO_BARCODE_TAG <String>
                              Read two barcode SAM tag (ex. BX for 10X Genomics)  Default value: null. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--REMOVE_DUPLICATES <Boolean> If true do not write duplicates to the output file instead of writing them with
                              appropriate flags set.  Default value: false. Possible values: {true, false} 

--REMOVE_SEQUENCING_DUPLICATES <Boolean>
                              If true remove 'optical' duplicates and other duplicates that appear to have arisen from
                              the sequencing process instead of the library preparation process, even if
                              REMOVE_DUPLICATES is false. If REMOVE_DUPLICATES is true, all duplicates are removed and
                              this option is ignored.  Default value: false. Possible values: {true, false} 

--SORTING_COLLECTION_SIZE_RATIO <Double>
                              This number, plus the maximum RAM available to the JVM, determine the memory footprint
                              used by some of the sorting collections.  If you are running out of memory, try reducing
                              this number.  Default value: 0.25. 

--TAG_DUPLICATE_SET_MEMBERS <Boolean>
                              If a read appears in a duplicate set, add two tags. The first tag, DUPLICATE_SET_SIZE_TAG
                              (DS), indicates the size of the duplicate set. The smallest possible DS value is 2 which
                              occurs when two reads map to the same portion of the reference only one of which is marked
                              as duplicate. The second tag, DUPLICATE_SET_INDEX_TAG (DI), represents a unique identifier
                              for the duplicate set to which the record belongs. This identifier is the index-in-file of
                              the representative read that was selected out of the duplicate set.  Default value: false.
                              Possible values: {true, false} 

--TAGGING_POLICY <DuplicateTaggingPolicy>
                              Determines how duplicate types are recorded in the DT optional attribute.  Default value:
                              DontTag. Possible values: {DontTag, OpticalOnly, All} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_SortSam

### Tool Description
This tool sorts the input SAM or BAM file by coordinate, queryname (QNAME), or some other property of the SAM record.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: SortSam [arguments]

This tool sorts the input SAM or BAM file by coordinate, queryname (QNAME), or some other property of the SAM record.
The SortOrder of a SAM/BAM/CRAM file is found in the SAM file header tag @HD in the field labeled SO.  <p> For a
coordinate sorted SAM/BAM/CRAM file, read alignments are sorted first by the reference sequence name (RNAME) field using
the reference sequence dictionary (@SQ tag).  Alignments within these subgroups are secondarily sorted using the
left-most mapping position of the read (POS).  Subsequent to this sorting scheme, alignments are listed
arbitrarily.</p><p> For queryname-sorted alignments, the tool orders records deterministically by queryname field
followed by record strand orientation flag, primary record flag, and secondary alignment flag. This ordering may change
in future versions. </p><hr /><hr /><h4>Usage example:</h4><pre>java -jar picard.jar SortSam \<br />      I=input.bam
\<br />      O=sorted.bam \<br />      SORT_ORDER=coordinate</pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The SAM, BAM or CRAM file to sort.  Required. 

--OUTPUT,-O <File>            The sorted SAM, BAM or CRAM output file.   Required. 

--SORT_ORDER,-SO <SortOrder>  Sort order of output file.   Required. queryname (Sorts according to the readname. This
                              will place read-pairs and other derived reads (secondary and supplementary) adjacent to
                              each other. Note that the readnames are compared lexicographically, even though they may
                              include numbers. In paired reads, Read1 sorts before Read2.)
                              coordinate (Sorts primarily according to the SEQ and POS fields of the record. The
                              sequence will sorted according to the order in the sequence dictionary, taken from from
                              the header of the file. Within each reference sequence, the reads are sorted by the
                              position. Unmapped reads whose mates are mapped will be placed near their mates. Unmapped
                              read-pairs are placed after all the mapped reads and their mates.)
                              duplicate (Sorts the reads so that duplicates reads are adjacent. Required that the
                              mate-cigar (MC) tag is present. The resulting will be sorted by library, unclipped 5-prime
                              position, orientation, and mate's unclipped 5-prime position.)


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_SplitSamByLibrary

### Tool Description
Takes a SAM/BAM/CRAM file and separates all the reads into one output file per library name. Reads that do not have a read group specified or whose read group does not have a library name are written to a file called 'unknown.'

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: SplitSamByLibrary [arguments]

Takes a SAM/BAM/CRAM file and separates all the reads into one output file per library name.  Reads that do not have a
read group specified or whose read group does not have a library name are written to a file called 'unknown.' The format
(SAM/BAM/CRAM) of the  output files matches that of the input file.<br /><h4>Usage example:</h4><pre>java -jar
picard.jar SplitSamByLibrary <br />      I=input_reads.bam <br />      O=/output/directory/ <br /></pre>
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The SAM, BAM of CRAM file to be split.   Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--OUTPUT,-O <File>            The directory where the per-library output files should be written (defaults to the
                              current directory).   Default value: /.. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_SplitSamByNumberOfReads

### Tool Description
Splits a SAM/BAM/CRAM file to multiple files. This tool splits the input query-grouped SAM/BAM/CRAM file into multiple files while maintaining the sort order. This can be used to split a large unmapped input in order to parallelize alignment. It will traverse the input twice unless TOTAL_READS_IN_INPUT is provided.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: SplitSamByNumberOfReads [arguments]

Splits a SAM/BAM/CRAM file to multiple files.This tool splits the input query-grouped SAM/BAM/CRAM file into multiple
files while maintaining the sort order. This can be used to split a large unmapped input in order to parallelize
alignment. It will traverse the input twice unless TOTAL_READS_IN_INPUT is provided. Output type (and extension) will
agreewith that of the input.<br /><h4>Usage example:</h4><pre>java -jar picard.jar SplitSamByNumberOfReads \<br />    
I=paired_unmapped_input.bam \<br />     OUTPUT=out_dir \ <br />     TOTAL_READS_IN_INPUT=800000000 \ <br />    
SPLIT_TO_N_READS=48000000</pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input SAM/BAM/CRAM file to split  Required. 

--OUTPUT,-O <File>            Directory in which to output the split BAM files.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--OUT_PREFIX <String>         Output files will be named <OUT_PREFIX>_N.EXT, where N enumerates the output file and EXT
                              is the same as that of the input.  Default value: shard. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SPLIT_TO_N_FILES,-N_FILES <Integer>
                              Split to N files.  Default value: 0.  Cannot be used in conjunction with argument(s)
                              SPLIT_TO_N_READS (N_READS)

--SPLIT_TO_N_READS,-N_READS <Integer>
                              Split to have approximately N reads per output file. The actual number of reads per output
                              file will vary by no more than the number of output files * (the maximum number of reads
                              with the same queryname - 1).  Default value: 0.  Cannot be used in conjunction with
                              argument(s) SPLIT_TO_N_FILES (N_FILES)

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--TOTAL_READS_IN_INPUT,-TOTAL_READS <Long>
                              Total number of reads in the input file. If this is not provided, the input will be read
                              twice, the first time to get a count of the total reads.  Default value: 0. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_UmiAwareMarkDuplicatesWithMateCigar

### Tool Description
Identifies duplicate reads using information from read positions and UMIs. This tool locates and tags duplicate reads in a BAM or SAM file, where duplicate reads are defined as originating from a single fragment of DNA. It is based on the MarkDuplicatesWithMateCigar tool, with added logic to leverage Unique Molecular Identifier (UMI) information.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory


**EXPERIMENTAL FEATURE - USE AT YOUR OWN RISK**

USAGE: UmiAwareMarkDuplicatesWithMateCigar [arguments]

Identifies duplicate reads using information from read positions and UMIs. <p>This tool locates and tags duplicate reads
in a BAM or SAM file, where duplicate reads aredefined as originating from a single fragment of DNA. It is based on the
{@link MarkDuplicatesWithMateCigar} tool, with added logicto leverage Unique Molecular Identifier (UMI)
information.</p><p>It makes use of the fact that duplicate sets with UMIs can be broken up into subsets based
oninformation contained in the UMI.  In addition to assuming that all members of a duplicate set must have the same
start and end position, it imposes thatthey must also have sufficiently similar UMIs. In this context, 'sufficiently
similar' is parameterized by the command lineargument MAX_EDIT_DISTANCE_TO_JOIN, which sets the edit distance between
UMIs that will be considered to be part of the sameoriginal molecule. This logic allows for sequencing errors in
UMIs.</p><p> If UMIs contain dashes, the dashes will be ignored. If UMIs contain Ns, these UMIs will not contribute to
UMI metricsassociated with each record. If the MAX_EDIT_DISTANCE_TO_JOIN allows, UMIs with Ns will be included in the
duplicate set andthe UMI metrics associated with each duplicate set. Ns are counted as an edit distance from other bases
{ATCG}, but are notconsidered different from each other.</p><p>This tool is NOT intended to be used on data without
UMIs; for marking duplicates in non-UMI data, see {@link MarkDuplicates} or{@link MarkDuplicatesWithMateCigar}. Mixed
data (where some reads have UMIs and others do not) is not supported.</p><p>Note also that this tool will not work with
alignments that have large gaps or deletions, such as those from RNA-seq data.This is due to the need to buffer small
genomic windows to ensure integrity of the duplicate marking, while large skips(ex. skipping introns) in the alignment
records would force making that window very large, thus exhausting memory. </p><p>Note: Metrics labeled as percentages
are actually expressed as fractions!</p><h4>Usage example:</h4><pre>java -jar picard.jar
UmiAwareMarkDuplicatesWithMateCigar <br />      I=input.bam <br />      O=output.bam <br />     
M=output_duplicate_metrics.txt <br />      UMI_METRICS=output_umi_metrics.txt</pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <String>           One or more input SAM, BAM or CRAM files to analyze. Must be coordinate sorted.  This
                              argument must be specified at least once. Required. 

--METRICS_FILE,-M <File>      File to write duplication metrics to  Required. 

--OUTPUT,-O <File>            The output file to write marked records to  Required. 

--UMI_METRICS_FILE,-UMI_METRICS <File>
                              UMI Metrics  Required. 


Optional Arguments:

--ADD_PG_TAG_TO_READS <Boolean>
                              Add PG tag to each read in a SAM or BAM  Default value: true. Possible values: {true,
                              false} 

--ALLOW_MISSING_UMIS <Boolean>FOR TESTING ONLY: allow for missing UMIs if data doesn't have UMIs. This option is
                              intended to be used ONLY for testing the code. Use MarkDuplicatesWithMateCigar if data has
                              no UMIs. Mixed data (where some reads have UMIs and others do not) is not supported. 
                              Default value: false. Possible values: {true, false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--ASSUME_SORT_ORDER,-ASO <SortOrder>
                              If not null, assume that the input file has this order even if the header says otherwise. 
                              Default value: null. Possible values: {unsorted, queryname, coordinate, duplicate,
                              unknown}  Cannot be used in conjunction with argument(s) ASSUME_SORTED (AS)

--ASSUME_SORTED,-AS <Boolean> If true, assume that the input file is coordinate sorted even if the header says
                              otherwise. Deprecated, used ASSUME_SORT_ORDER=coordinate instead.  Default value: false.
                              Possible values: {true, false}  Cannot be used in conjunction with argument(s)
                              ASSUME_SORT_ORDER (ASO)

--BARCODE_TAG <String>        Barcode SAM tag (ex. BC for 10X Genomics)  Default value: null. 

--CLEAR_DT <Boolean>          Clear DT tag from input SAM records. Should be set to false if input SAM doesn't have this
                              tag.  Default true  Default value: true. Possible values: {true, false} 

--COMMENT,-CO <String>        Comment(s) to include in the output file's header.  This argument may be specified 0 or
                              more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DUPLEX_UMI <Boolean>        Treat UMIs as being duplex stranded.  This option requires that the UMI consist of two
                              equal length strings that are separated by a hyphen (e.g. 'ATC-GTC'). Reads are considered
                              duplicates if, in addition to standard definition, have identical normalized UMIs.  A UMI
                              from the 'bottom' strand is normalized by swapping its content around the hyphen (eg.
                              ATC-GTC becomes GTC-ATC).  A UMI from the 'top' strand is already normalized as it is.
                              Both reads from a read pair considered top strand if the read 1 unclipped 5' coordinate is
                              less than the read 2 unclipped 5' coordinate. All chimeric reads and read fragments are
                              treated as having come from the top strand. With this option is it required that the
                              BARCODE_TAG hold non-normalized UMIs. Default false.  Default value: false. Possible
                              values: {true, false} 

--DUPLICATE_SCORING_STRATEGY,-DS <ScoringStrategy>
                              The scoring strategy for choosing the non-duplicate among candidates.  Default value:
                              SUM_OF_BASE_QUALITIES. Possible values: {SUM_OF_BASE_QUALITIES,
                              TOTAL_MAPPED_REFERENCE_LENGTH, RANDOM} 

--FLOW_DUP_STRATEGY <FLOW_DUPLICATE_SELECTION_STRATEGY>
                              Use specific quality summing strategy for flow based reads. Two strategies are available:
                              FLOW_QUALITY_SUM_STRATEG: The selects the read with the best total homopolymer quality.
                              FLOW_END_QUALITY_STRATEGY: The strategy selects the read with the best homopolymer quality
                              close to the end (10 bases) of the read.  The latter strategy is recommended for samples
                              with high duplication rate   Default value: FLOW_QUALITY_SUM_STRATEGY. Possible values:
                              {FLOW_QUALITY_SUM_STRATEGY, FLOW_END_QUALITY_STRATEGY} 

--FLOW_EFFECTIVE_QUALITY_THRESHOLD <Integer>
                              Threshold for considering a quality value high enough to be included when calculating
                              FLOW_QUALITY_SUM_STRATEGY calculation.  Default value: 15. 

--FLOW_MODE <Boolean>         enable parameters and behavior specific to flow based reads.  Default value: false.
                              Possible values: {true, false} 

--FLOW_Q_IS_KNOWN_END <Boolean>
                              Treat position of read trimming based on quality as the known end (relevant for flow based
                              reads). Default false - if the read is trimmed on quality its end is not defined and the
                              read is duplicate of any read starting at the same place.  Default value: false. Possible
                              values: {true, false} 

--FLOW_SKIP_FIRST_N_FLOWS <Integer>
                              Skip first N flows, starting from the read's start, when considering duplicates. Useful
                              for flow based reads where sometimes there is noise in the first flows (for this argument,
                              "read start" means 5' end).  Default value: 0. 

--FLOW_UNPAIRED_END_UNCERTAINTY <Integer>
                              Maximal difference of the read end position that counted as equal. Useful for flow based
                              reads where the end position might vary due to sequencing errors. (for this argument,
                              "read end" means 3' end)  Default value: 0. 

--FLOW_UNPAIRED_START_UNCERTAINTY <Integer>
                              Maximal difference of the read start position that counted as equal. Useful for flow based
                              reads where the end position might vary due to sequencing errors. (for this argument,
                              "read start" means 5' end in the direction of sequencing)  Default value: 0. 

--FLOW_USE_END_IN_UNPAIRED_READS <Boolean>
                              Make the end location of single end read be significant when considering duplicates, in
                              addition to the start location, which is always significant (i.e. require single-ended
                              reads to start andend on the same position to be considered duplicate) (for this argument,
                              "read end" means 3' end).  Default value: false. Possible values: {true, false} 

--FLOW_USE_UNPAIRED_CLIPPED_END <Boolean>
                              Use position of the clipping as the end position, when considering duplicates (or use the
                              unclipped end position) (for this argument, "read end" means 3' end).  Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_EDIT_DISTANCE_TO_JOIN <Integer>
                              Largest edit distance that UMIs must have in order to be considered as coming from
                              distinct source molecules.  Default value: 1. 

--MAX_FILE_HANDLES_FOR_READ_ENDS_MAP,-MAX_FILE_HANDLES <Integer>
                              Maximum number of file handles to keep open when spilling read ends to disk. Set this
                              number a little lower than the per-process maximum number of file that may be open. This
                              number can be found by executing the 'ulimit -n' command on a Unix system.  Default value:
                              8000. 

--MAX_OPTICAL_DUPLICATE_SET_SIZE <Long>
                              This number is the maximum size of a set of duplicate reads for which we will attempt to
                              determine which are optical duplicates.  Please be aware that if you raise this value too
                              high and do encounter a very large set of duplicate reads, it will severely affect the
                              runtime of this tool.  To completely disable this check, set the value to -1.  Default
                              value: 300000. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MAX_SEQUENCES_FOR_DISK_READ_ENDS_MAP,-MAX_SEQS <Integer>
                              This option is obsolete. ReadEnds will always be spilled to disk.  Default value: 50000. 

--MOLECULAR_IDENTIFIER_TAG <String>
                              SAM tag to uniquely identify the molecule from which a read was derived.  Use of this
                              option requires that the BARCODE_TAG option be set to a non null value.  Default null. 
                              Default value: null. 

--OPTICAL_DUPLICATE_PIXEL_DISTANCE <Integer>
                              The maximum offset between two duplicate clusters in order to consider them optical
                              duplicates. The default is appropriate for unpatterned versions of the Illumina platform.
                              For the patterned flowcell models, 2500 is moreappropriate. For other platforms and
                              models, users should experiment to find what works best.  Default value: 100. 

--PROGRAM_GROUP_COMMAND_LINE,-PG_COMMAND <String>
                              Value of CL tag of PG record to be created. If not supplied the command line will be
                              detected automatically.  Default value: null. 

--PROGRAM_GROUP_NAME,-PG_NAME <String>
                              Value of PN tag of PG record to be created.  Default value:
                              UmiAwareMarkDuplicatesWithMateCigar. 

--PROGRAM_GROUP_VERSION,-PG_VERSION <String>
                              Value of VN tag of PG record to be created. If not specified, the version will be detected
                              automatically.  Default value: null. 

--PROGRAM_RECORD_ID,-PG <String>
                              The program record ID for the @PG record(s) created by this program. Set to null to
                              disable PG record creation.  This string may have a suffix appended to avoid collision
                              with other program record IDs.  Default value: MarkDuplicates. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--READ_NAME_REGEX <String>    MarkDuplicates can use the tile and cluster positions to estimate the rate of optical
                              duplication in addition to the dominant source of duplication, PCR, to provide a more
                              accurate estimation of library size. By default (with no READ_NAME_REGEX specified),
                              MarkDuplicates will attempt to extract coordinates using a split on ':' (see Note below). 
                              Set READ_NAME_REGEX to 'null' to disable optical duplicate detection. Note that without
                              optical duplicate counts, library size estimation will be less accurate. If the read name
                              does not follow a standard Illumina colon-separation convention, but does contain tile and
                              x,y coordinates, a regular expression can be specified to extract three variables:
                              tile/region, x coordinate and y coordinate from a read name. The regular expression must
                              contain three capture groups for the three variables, in order. It must match the entire
                              read name.   e.g. if field names were separated by semi-colon (';') this example regex
                              could be specified      (?:.*;)?([0-9]+)[^;]*;([0-9]+)[^;]*;([0-9]+)[^;]*$ Note that if no
                              READ_NAME_REGEX is specified, the read name is split on ':'.   For 5 element names, the
                              3rd, 4th and 5th elements are assumed to be tile, x and y values.   For 7 element names
                              (CASAVA 1.8), the 5th, 6th, and 7th elements are assumed to be tile, x and y values. 
                              Default value: <optimized capture of last three ':' separated fields as numeric values>. 

--READ_ONE_BARCODE_TAG <String>
                              Read one barcode SAM tag (ex. BX for 10X Genomics)  Default value: null. 

--READ_TWO_BARCODE_TAG <String>
                              Read two barcode SAM tag (ex. BX for 10X Genomics)  Default value: null. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--REMOVE_DUPLICATES <Boolean> If true do not write duplicates to the output file instead of writing them with
                              appropriate flags set.  Default value: false. Possible values: {true, false} 

--REMOVE_SEQUENCING_DUPLICATES <Boolean>
                              If true remove 'optical' duplicates and other duplicates that appear to have arisen from
                              the sequencing process instead of the library preparation process, even if
                              REMOVE_DUPLICATES is false. If REMOVE_DUPLICATES is true, all duplicates are removed and
                              this option is ignored.  Default value: false. Possible values: {true, false} 

--SORTING_COLLECTION_SIZE_RATIO <Double>
                              This number, plus the maximum RAM available to the JVM, determine the memory footprint
                              used by some of the sorting collections.  If you are running out of memory, try reducing
                              this number.  Default value: 0.25. 

--TAG_DUPLICATE_SET_MEMBERS <Boolean>
                              If a read appears in a duplicate set, add two tags. The first tag, DUPLICATE_SET_SIZE_TAG
                              (DS), indicates the size of the duplicate set. The smallest possible DS value is 2 which
                              occurs when two reads map to the same portion of the reference only one of which is marked
                              as duplicate. The second tag, DUPLICATE_SET_INDEX_TAG (DI), represents a unique identifier
                              for the duplicate set to which the record belongs. This identifier is the index-in-file of
                              the representative read that was selected out of the duplicate set.  Default value: false.
                              Possible values: {true, false} 

--TAGGING_POLICY <DuplicateTaggingPolicy>
                              Determines how duplicate types are recorded in the DT optional attribute.  Default value:
                              DontTag. Possible values: {DontTag, OpticalOnly, All} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--UMI_TAG_NAME <String>       Tag name to use for UMI  Default value: RX. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument UMI_METRICS_FILE was missing: Argument 'UMI_METRICS_FILE' is required
```


## picard_BaitDesigner

### Tool Description
Designs oligonucleotide baits for hybrid selection reactions. This tool is used to design custom bait sets for hybrid selection experiments. It outputs interval_list files of both bait and target sequences as well as the actual bait sequences in FastA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: BaitDesigner [arguments]

Designs oligonucleotide baits for hybrid selection reactions.<p>This tool is used to design custom bait sets for hybrid
selection experiments. The following files are input into BaitDesigner: a (TARGET) interval list indicating the
sequences of interest, e.g. exons with their respective coordinates, a reference sequence, and a unique identifier
string (DESIGN_NAME). </p><p>The tool will output interval_list files of both bait and target sequences as well as the
actual bait sequences in FastA format. At least two baits are output for each target sequence, with greater numbers for
larger intervals. Although the default values for both bait size  (120 bases) nd offsets (80 bases) are suitable for
most applications, these values can be customized. Offsets represent the distance between sequential baits on a
contiguous stretch of target DNA sequence. </p><p>The tool will also output a pooled set of 55,000 (default)
oligonucleotides representing all of the baits redundantly. This redundancy achieves a uniform concentration of
oligonucleotides for synthesis by a vendor as well as equal numbersof each bait to prevent bias during the hybrid
selection reaction. </p><h4>Usage example:</h4><pre>java -jar picard.jar BaitDesigner \<br />     
TARGET=targets.interval_list \<br />      DESIGN_NAME=new_baits \<br />      R=reference_sequence.fasta </pre> <hr />
Version:3.4.0


Required Arguments:

--DESIGN_NAME <String>        The name of the bait design  Required. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Required. 

--TARGETS,-T <File>           The file with design parameters and targets  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--BAIT_OFFSET <Integer>       The desired offset between the start of one bait and the start of another bait for the
                              same target.  Default value: 80. 

--BAIT_SIZE <Integer>         The length of each individual bait to design  Default value: 120. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DESIGN_ON_TARGET_STRAND <Boolean>
                              If true design baits on the strand of the target feature, if false always design on the +
                              strand of the genome.  Default value: false. Possible values: {true, false} 

--DESIGN_STRATEGY <DesignStrategy>
                              The design strategy to use to layout baits across each target  Default value: FixedOffset.
                              Possible values: {CenteredConstrained, FixedOffset, Simple} 

--FILL_POOLS <Boolean>        If true, fill up the pools with alternating fwd and rc copies of all baits. Equal copies
                              of all baits will always be maintained  Default value: true. Possible values: {true,
                              false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--LEFT_PRIMER <String>        The left amplification primer to prepend to all baits for synthesis  Default value:
                              ATCGCACCAGCGTGT. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MERGE_NEARBY_TARGETS <Boolean>
                              If true merge targets that are 'close enough' that designing against a merged target would
                              be more efficient.  Default value: true. Possible values: {true, false} 

--MINIMUM_BAITS_PER_TARGET <Integer>
                              The minimum number of baits to design per target.  Default value: 2. 

--OUTPUT_AGILENT_FILES <Boolean>
                              If true also output .design.txt files per pool with one line per bait sequence  Default
                              value: true. Possible values: {true, false} 

--OUTPUT_DIRECTORY,-O <File>  The output directory. If not provided then the DESIGN_NAME will be used as the output
                              directory  Default value: null. 

--PADDING <Integer>           Pad the input targets by this amount when designing baits. Padding is applied on both
                              sides in this amount.  Default value: 0. 

--POOL_SIZE <Integer>         The size of pools or arrays for synthesis. If no pool files are desired, can be set to 0. 
                              Default value: 55000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REPEAT_TOLERANCE <Integer>  Baits that have more than REPEAT_TOLERANCE soft or hard masked bases will not be allowed 
                              Default value: 50. 

--RIGHT_PRIMER <String>       The right amplification primer to prepend to all baits for synthesis  Default value:
                              CACTGCGGCTCCTCA. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument TARGETS was missing: Argument 'TARGETS' is required
```


## picard_CreateSequenceDictionary

### Tool Description
Creates a sequence dictionary for a reference sequence. This tool creates a sequence dictionary file (with ".dict" extension) from a reference sequence provided in FASTA format, which is required by many processing and analysis tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: CreateSequenceDictionary [arguments]

Creates a sequence dictionary for a reference sequence.  This tool creates a sequence dictionary file (with ".dict"
extension) from a reference sequence provided in FASTA format, which is required by many processing and analysis tools.
The output file contains a header but no SAMRecords, and the header contains only sequence records.<br /><br />The
reference sequence can be gzipped (both .fasta and .fasta.gz are supported).<h4>Usage example:</h4><pre>java -jar
picard.jar CreateSequenceDictionary \ <br />      R=reference.fasta \ <br />      O=reference.dict</pre><hr />
Version:3.4.0


Required Arguments:

--REFERENCE,-R <PicardHtsPath>Input reference fasta or fasta.gz  Required. 


Optional Arguments:

--ALT_NAMES,-AN <File>        Optional file containing the alternative names for the contigs. Tools may use this
                              information to consider different contig notations as identical (e.g: 'chr1' and '1'). The
                              alternative names will be put into the appropriate @AN annotation for each contig. No
                              header. First column is the original name, the second column is an alternative name. One
                              contig may have more than one alternative name.  Default value: null. 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--GENOME_ASSEMBLY,-AS <String>Put into AS field of sequence dictionary entry if supplied  Default value: null. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--NUM_SEQUENCES <Integer>     Stop after writing this many sequences.  For testing.  Default value: 2147483647. 

--OUTPUT,-O <PicardHtsPath>   Output SAM file containing only the sequence dictionary. By default it will use the base
                              name of the input reference with the .dict extension  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--SPECIES,-SP <String>        Put into SP field of sequence dictionary entry  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--TRUNCATE_NAMES_AT_WHITESPACE <Boolean>
                              Make sequence name the first word from the > line in the fasta file.  By default the
                              entire contents of the > line is used, excluding leading and trailing whitespace.  Default
                              value: true. Possible values: {true, false} 

--URI,-UR <String>            Put into UR field of sequence dictionary entry.  If not supplied, input reference file is
                              used  Default value: null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument REFERENCE was missing: Argument 'REFERENCE' is required
```


## picard_ExtractSequences

### Tool Description
Subsets intervals from a reference sequence to a new FASTA file. This tool takes a list of intervals, reads the corresponding subsquences from a reference FASTA file and writes them to a new FASTA file as separate records.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: ExtractSequences [arguments]

Subsets intervals from a reference sequence to a new FASTA file.This tool takes a list of intervals, reads the
corresponding subsquences from a reference FASTA file and writes them to a new FASTA file as separate records. Note that
the reference FASTA file must be accompanied by an index file and the interval list must be provided in Picard list
format. The names provided for the intervals will be used to name the corresponding records in the output file.<br
/><h4>Usage example:</h4><pre>java -jar picard.jar ExtractSequences \<br />     
INTERVAL_LIST=regions_of_interest.interval_list \<br />      R=reference.fasta \<br />     
O=extracted_IL_sequences.fasta</pre><hr />
Version:3.4.0


Required Arguments:

--INTERVAL_LIST <File>        Interval list describing intervals to be extracted from the reference sequence.  Required.

--OUTPUT,-O <File>            Output FASTA file.  Required. 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--LINE_LENGTH <Integer>       Maximum line length for sequence data.  Default value: 80. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INTERVAL_LIST was missing: Argument 'INTERVAL_LIST' is required
```


## picard_NonNFastaSize

### Tool Description
Counts the number of non-N bases in a fasta file. This tool takes any FASTA-formatted file and counts the number of non-N bases in it. Note that it requires that the fasta file have associated index (.fai) and dictionary (.dict) files.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: NonNFastaSize [arguments]

Counts the number of non-N bases in a fasta file.This tool takes any FASTA-formatted file and counts the number of non-N
bases in it.Note that it requires that the fasta file have associated index (.fai) and dictionary (.dict) files.<br
/><h4>Usage example:</h4><pre>java -jar picard.jar NonNFastaSize \<br />      I=input_sequence.fasta \<br />     
O=count.txt</pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The input FASTA file.  Required. 

--OUTPUT,-O <File>            The output file in which to record the count.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INTERVALS <File>            An interval list file that contains the locations of the positions to assess.  If not
                              provided, the entire reference will be used  Default value: null. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_NormalizeFasta

### Tool Description
Normalizes lines of sequence in a FASTA file to be of the same length. This tool takes any FASTA-formatted file and reformats the sequence to ensure that all of the sequence record lines are of the same length (with the exception of the last line).

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: NormalizeFasta [arguments]

Normalizes lines of sequence in a FASTA file to be of the same length.This tool takes any FASTA-formatted file and
reformats the sequence to ensure that all of the sequence record lines are of the same length (with the exception of the
last line). Although the default setting is 100 bases per line, a custom line_length can be specified by the user. In
addition, record names can be truncated at the first instance of a whitespace character to ensure downstream
compatibility.<br /><h4>Usage example:</h4><pre>java -jar picard.jar NormalizeFasta \<br />      I=input_sequence.fasta
\<br />      O=normalized_sequence.fasta</pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The input FASTA file to normalize.  Required. 

--OUTPUT,-O <File>            The output FASTA file to write.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--LINE_LENGTH <Integer>       The line length to be used for the output FASTA file.  Default value: 100. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--TRUNCATE_SEQUENCE_NAMES_AT_WHITESPACE <Boolean>
                              Truncate sequence names at first whitespace.  Default value: false. Possible values:
                              {true, false} 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_ScatterIntervalsByNs

### Tool Description
Writes an interval list created by splitting a reference at Ns. A Program for breaking up a reference into intervals of alternating regions of N and ACGT bases. Used for creating a broken-up interval list that can be used for scattering a variant-calling pipeline in a way that will not cause problems at the edges of the intervals.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: ScatterIntervalsByNs [arguments]

Writes an interval list created by splitting a reference at Ns.A Program for breaking up a reference into intervals of
alternating regions of N and ACGT bases.<br/><br/><br/>Used for creating a broken-up interval list that can be used for
scattering a variant-calling pipeline in a way that will not cause problems at the edges of the intervals. By using
large enough N blocks (so that the tools will not be able to anchor on both sides) we can be assured that the results of
scattering and gathering the variants with the resulting interval list will be the same as calling with one large
region.
<br/><h3>Input</h3>- A reference file to use for creating the intervals (needs to have index and dictionary next to it.)
- Which type of intervals to emit in the output (Ns only, ACGT only or both.)
- An integer indicating the largest number of Ns in a contiguous block that will be "tolerated" and not converted into
an N block.

<h3>Output</h3>- An interval list (with a SAM header) where the names of the intervals are labeled (either N-block or
ACGT-block) to indicate what type of block they define.

<h3>Usage example</h3><h4>Create an interval list of intervals that do not contain any N blocks for use with haplotype
caller on short reads</h4><pre>java -jar picard.jar ScatterIntervalsByNs \
REFERENCE=reference_sequence.fasta \
OUTPUT_TYPE=ACGT \
OUTPUT=output.interval_list
</pre>


Version:3.4.0


Required Arguments:

--OUTPUT,-O <File>            Output file for interval list.  Required. 

--REFERENCE,-R <File>         Reference sequence to use. Note: this tool requires that the reference fasta has both an
                              associated index and a dictionary.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MAX_TO_MERGE,-N <Integer>   Maximal number of contiguous N bases to tolerate, thereby continuing the current ACGT
                              interval.  Default value: 1. 

--OUTPUT_TYPE,-OT <OutputType>Type of intervals to output.  Default value: BOTH. Possible values: {N, ACGT, BOTH} 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument OUTPUT was missing: Argument 'OUTPUT' is required
```


## picard_FindMendelianViolations

### Tool Description
Takes in VCF or BCF and a pedigree file and looks for high confidence calls where the genotype of the offspring is incompatible with the genotypes of the parents.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: FindMendelianViolations [arguments]

Takes in VCF or BCF and a pedigree file and looks for high confidence calls where the genotype of the offspring is
incompatible with the genotypes of the parents.  
Key features:
- Checks for regular MVs in diploid regions and invalid transmissions in haploid regions (using the declared gender of
the offspring in the pedigree file to determine how to deal with the male and female chromosomes.)
- Outputs metrics about the different kinds of MVs found.
- Can output a per-trio VCF with violations; INFO field will indicate the type of violation in the MV field
<h3>Example</h3>
java -jar picard.jar FindMendelianViolations\
I=input.vcf \
TRIO=pedigree.fam \
O=report.mendelian_violation_metrics \
MIN_DP=20
<h3>Caveates</h3>
<h4>Assumptions</h4>
The tool assumes the existence of FORMAT fields AD, DP, GT, GQ, and PL. 
<h4>Ignored Variants</h4>
This tool ignores variants that are:
- Not SNPs
- Filtered
- Multiallelic (i.e., trio has more than 2 alleles)
- Within the SKIP_CHROMS contigs
<h4>PseudoAutosomal Region</h4>
This tool assumes that variants in the PAR will be mapped onto the female chromosome, and will treat variants in that
region as as autosomal. The mapping to female requires that the PAR in the male chromosome be masked so that the aligner
maps reads to single contig. This is normally done for the public releases of the human reference. The tool has default
values for PAR that are sensible for humans on either build b37 or hg38.

Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input VCF or BCF with genotypes.  Required. 

--OUTPUT,-O <File>            Output metrics file.  Required. 

--TRIOS,-PED <File>           File of Trio information in PED format (with no genotype columns).  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--FEMALE_CHROMS <String>      List of possible names for female sex chromosome(s)  This argument may be specified 0 or
                              more times. Default value: [chrX, X]. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MALE_CHROMS <String>        List of possible names for male sex chromosome(s)  This argument may be specified 0 or
                              more times. Default value: [chrY, Y]. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MIN_DP,-DP <Integer>        Minimum depth in each sample to consider possible mendelian violations.  Default value: 0.

--MIN_GQ,-GQ <Integer>        Minimum genotyping quality (or non-ref likelihood) to perform tests.  Default value: 30. 

--MIN_HET_FRACTION,-MINHET <Double>
                              Minimum allele balance at sites that are heterozygous in the offspring.  Default value:
                              0.3. 

--PSEUDO_AUTOSOMAL_REGIONS,-PAR <String>
                              List of chr:start-end for pseudo-autosomal regions on the female sex chromosome. Defaults
                              to HG19/b37 & HG38 coordinates.  This argument may be specified 0 or more times. Default
                              value: [X:154931044-155260560, X:60001-2699520, chrX:10001-2781479,
                              chrX:155701383-156030895]. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SKIP_CHROMS <String>        List of chromosome names to skip entirely.  This argument may be specified 0 or more
                              times. Default value: [MT, chrM]. 

--TAB_MODE <Boolean>          If true then fields need to be delimited by a single tab. If false the delimiter is one or
                              more whitespace characters. Note that tab mode does not strictly follow the PED spec 
                              Default value: false. Possible values: {true, false} 

--THREAD_COUNT <Integer>      The number of threads that will be used to collect the metrics.   Default value: 1. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VCF_DIR <File>              If provided, output per-family VCFs of mendelian violations into this directory.  Default
                              value: null. 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_GenotypeConcordance

### Tool Description
Calculates the concordance between genotype data of one sample in each of two VCFs - truth (or reference) vs. calls. The concordance is broken into separate results sections for SNPs and indels. Summary and detailed statistics are reported.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: GenotypeConcordance [arguments]

Calculates the concordance between genotype data of one sample in each of two VCFs - truth (or reference) vs.
calls.<h3>Summary</h3>Calculates the concordance between genotype data of one sample in each of two VCFs - one being
considered the truth (or reference) the other being the call.  The concordance is broken into separate results sections
for SNPs and indels.  Summary and detailed statistics are reported.

<h3>Details</h3>
This tool evaluates the concordance between genotype calls for a sample in different callsets where one is being
considered as the "truth" (aka standard, or reference) and the other as the "call" that is being evaluated for accuracy.
The Comparison can be restricted to a confidence interval which is typically used in order to enable proper assessment
of False Positives and the False-Positive Rate (FPR).

<h3>Usage example</h3>
<h4>Compare two VCFs within a confidence region</h4>

java -jar picard.jar GenotypeConcordance \
CALL_VCF=input.vcf \
CALL_SAMPLE=sample_name \
O=gc_concordance.vcf \
TRUTH_VCF=truth_set.vcf \
TRUTH_SAMPLE=sample_in_truth \
INTERVALS=confident.interval_list \
MISSING_SITES_HOM_REF = true

<h3>Output Metrics:</h3>
Output metrics consists of GenotypeConcordanceContingencyMetrics, GenotypeConcordanceSummaryMetrics, and
GenotypeConcordanceDetailMetrics.  For each set of metrics, the data is broken into separate sections for SNPs and
INDELs.  Note that only SNP and INDEL variants are considered, MNP, Symbolic, and Mixed classes  of variants are not
included.

- GenotypeConcordanceContingencyMetrics enumerate the constituents of each contingent in a callset including
true-positive(TP), true-negative (TN), false-positive (FP), and false-negative (FN) calls.
Seehttp://broadinstitute.github.io/picard/picard-metric-definitions.html#GenotypeConcordanceContingencyMetrics for more
details.
- GenotypeConcordanceDetailMetrics include the numbers of SNPs and INDELs for each contingent genotype as well as
thenumber of validated genotypes.
Seehttp://broadinstitute.github.io/picard/picard-metric-definitions.html#GenotypeConcordanceDetailMetrics for more
details.- GenotypeConcordanceSummaryMetrics provide specific details for the variant caller performance on a callset
including:values for sensitivity, specificity, and positive predictive values.
Seehttp://broadinstitute.github.io/picard/picard-metric-definitions.html#GenotypeConcordanceSummaryMetrics for more
details.

Useful definitions applicable to alleles and genotypes:

Truthset - A callset (typically in VCF format) containing variant calls and genotypes that have been cross-validatedwith
multiple technologies e.g. Genome In A Bottle Consortium (GIAB) (https://sites.stanford.edu/abms/giab)
TP - True-positives are variant sites that match against the truth-set
FP - False-positives are reference sites miscalled as variant
FN - False-negatives are variant sites miscalled as reference
TN - True-negatives are correctly called as reference
Validated genotypes - are TP sites where the exact genotype (HET or HOM-VAR) appears in the truth-set

<h3>VCF Output:</h3>
- The concordance state will be stored in the CONC_ST tag in the INFO field
- The truth sample name will be "truth" and call sample name will be "call"
Version:3.4.0


Required Arguments:

--CALL_VCF,-CV <PicardHtsPath>The VCF containing the call sample  Required. 

--OUTPUT,-O <File>            Basename for the three metrics files that are to be written. Resulting files will be
                              <OUTPUT>.genotype_concordance_summary_metrics,
                              <OUTPUT>.genotype_concordance_detail_metrics, and
                              <OUTPUT>.genotype_concordance_contingency_metrics.  Required. 

--TRUTH_VCF,-TV <PicardHtsPath>
                              The VCF containing the truth sample  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--CALL_SAMPLE,-CS <String>    The name of the call sample within the call VCF. Not required if only one sample exists. 
                              Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--IGNORE_FILTER_STATUS <Boolean>
                              Default is false. If true, filter status of sites will be ignored so that we include
                              filtered sites when calculating genotype concordance.   Default value: false. Possible
                              values: {true, false} 

--INTERSECT_INTERVALS <Boolean>
                              If true, multiple interval lists will be intersected. If false multiple lists will be
                              unioned.  Default value: true. Possible values: {true, false} 

--INTERVALS <PicardHtsPath>   One or more interval list files that will be used to limit the genotype concordance.  Note
                              - if intervals are specified, the VCF files must be indexed.  This argument may be
                              specified 0 or more times. Default value: null. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MIN_DP <Integer>            Genotypes below this depth will have genotypes classified as LowDp.  Default value: 0. 

--MIN_GQ <Integer>            Genotypes below this genotype quality will have genotypes classified as LowGq.  Default
                              value: 0. 

--MISSING_SITES_HOM_REF,-MISSING_HOM <Boolean>
                              Default is false, which follows the GA4GH Scheme. If true, missing sites in the truth set
                              will be treated as HOM_REF sites and sites missing in both the truth and call sets will be
                              true negatives. Useful when hom ref sites are left out of the truth set. This flag can
                              only be used with a high confidence interval list.  Default value: false. Possible values:
                              {true, false} 

--OUTPUT_ALL_ROWS <Boolean>   If true, output all rows in detailed statistics even when count == 0.  When false only
                              output rows with non-zero counts.  Default value: false. Possible values: {true, false} 

--OUTPUT_VCF <Boolean>        Output a VCF annotated with concordance information.  Default value: false. Possible
                              values: {true, false} 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--TRUTH_SAMPLE,-TS <String>   The name of the truth sample within the truth VCF. Not required if only one sample exists.
                              Default value: null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--USE_VCF_INDEX <Boolean>     If true, use the VCF index, else iterate over the entire VCF.  Default value: false.
                              Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument TRUTH_VCF was missing: Argument 'TRUTH_VCF' is required
```


## picard_FilterVcf

### Tool Description
Applies one or more hard filters to a VCF file to filter out genotypes and variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: FilterVcf [arguments]

Applies one or more hard filters to a VCF file to filter out genotypes and variants.
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The INPUT VCF or BCF file.  Required. 

--OUTPUT,-O <File>            The output VCF or BCF.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: true. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--JAVASCRIPT_FILE,-JS <File>  Filters a VCF file with a javascript expression interpreted by the java javascript engine.
                              The script puts the following variables in the script context:  'variant' a VariantContext
                              (
                              https://samtools.github.io/htsjdk/javadoc/htsjdk/htsjdk/variant/variantcontext/VariantContext.html
                              ) and  'header' a VCFHeader (
                              https://samtools.github.io/htsjdk/javadoc/htsjdk/htsjdk/variant/vcf/VCFHeader.html ). Last
                              value of the script should be a boolean to tell whether we should accept or reject the
                              record.  Default value: null. 

--MAX_FS <Double>             The maximum phred scaled fisher strand value before a site will be filtered out.  Default
                              value: 1.7976931348623157E308. 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--MIN_AB <Double>             The minimum allele balance acceptable before filtering a site. Allele balance is
                              calculated for heterozygotes as the number of bases supporting the least-represented
                              allele over the total number of base observations. Different heterozygote genotypes at the
                              same locus are measured independently. The locus is filtered if any allele balance is
                              below the limit.  Default value: 0.0. 

--MIN_DP <Integer>            The minimum sequencing depth supporting a genotype before the genotype will be filtered
                              out.  Default value: 0. 

--MIN_GQ <Integer>            The minimum genotype quality that must be achieved for a sample otherwise the genotype
                              will be filtered out.  Default value: 0. 

--MIN_QD <Double>             The minimum QD value to accept or otherwise filter out the variant.  Default value: 0.0. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_FixVcfHeader

### Tool Description
Replaces or fixes a VCF header. This tool will either replace the header in the input VCF file (INPUT) with the given VCF header (HEADER) or will attempt to fill in any field definitions that are missing in the input header by examining the variants in the input VCF file (INPUT).

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: FixVcfHeader [arguments]

Replaces or fixes a VCF header.This tool will either replace the header in the input VCF file (INPUT) with the given VCF
header (HEADER) or will attempt to fill in any field definitions that are missing in the input header by examining the
variants in the input VCF file (INPUT).  In the latter case, this tool will perform two passes over the input VCF, and
any FILTER, INFO, and FORMAT fields found in the VCF records but not found in the input VCF header will be added to the
output VCF header with dummy descriptions.<br /><h4>Replace header usage example:</h4><pre>java -jar picard.jar
FixVcfHeader \<br />     I=input.vcf \<br />     O=fixed.vcf \<br />     HEADER=header.vcf</pre><h4>Fix header usage
example:</h4><pre>java -jar picard.jar FixVcfHeader \<br />     I=input.vcf \<br />     O=fixed.vcf \<br /></pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <PicardHtsPath>    The input VCF/BCF file.  Required. 

--OUTPUT,-O <File>            The output VCF/BCF file.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--CHECK_FIRST_N_RECORDS,-N <Integer>
                              Check only the first N records when searching for missing INFO and FORMAT fields.  Default
                              value: -1. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--ENFORCE_SAME_SAMPLES <Boolean>
                              Enforce that the samples are the same (and in the same order) when replacing the VCF
                              header.  Default value: true. Possible values: {true, false} 

--HEADER,-H <PicardHtsPath>   The replacement VCF header.  Default value: null. 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_GatherVcfs

### Tool Description
Gathers multiple VCF files from a scatter operation into a single VCF file. Input files must be supplied in genomic order and must not have events at overlapping positions.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: GatherVcfs [arguments]

Gathers multiple VCF files from a scatter operation into a single VCF file. Input files must be supplied in genomic
order and must not have events at overlapping positions.
Version:3.4.0


Required Arguments:

--INPUT,-I <HtsPath>          Input VCF file(s).  This argument must be specified at least once. Required. 

--OUTPUT,-O <File>            Output VCF file.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMMENT,-CO <String>        Comment(s) to include in the merged output file's header.  This argument may be specified
                              0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: true. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--REORDER_INPUT_BY_FIRST_VARIANT,-RI <Boolean>
                              If 'true' the program will reorder INPUT according to the genomic location of the first
                              variant in each file. this is useful since the order of variants in each file in INPUT
                              come from non overlapping regions  but the order of the files in INPUT is untrusted. 
                              Default value: false. Possible values: {true, false} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_LiftoverVcf

### Tool Description
Lifts over a VCF file from one reference build to another, producing a properly headered, sorted and indexed VCF in one go.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: LiftoverVcf [arguments]

Lifts over a VCF file from one reference build to another.  <h3>Summary</h3>
Tool for "lifting over" a VCF from one genome build to another, producing a properly headered, sorted and indexed VCF in
one go.

<h3>Details</h3>
This tool adjusts the coordinates of variants within a VCF file to match a new reference. The output file will be sorted
and indexed using the target reference build. To be clear, REFERENCE_SEQUENCE should be the <em>target</em> reference
build (that is, the "new" one). The tool is based on the UCSC LiftOver tool (see
http://genome.ucsc.edu/cgi-bin/hgLiftOver) and uses a UCSC chain file to guide its operation.

For each variant, the tool will look for the target coordinate, reverse-complement and left-align the variant if needed,
and, in the case that the reference and alternate alleles of a SNP have been swapped in the new genome build, it will
adjust the SNP, and correct AF-like INFO fields and the relevant genotypes.

<h3>Example</h3>
java -jar picard.jar LiftoverVcf \
I=input.vcf \
O=lifted_over.vcf \
CHAIN=b37tohg38.chain \
REJECT=rejected_variants.vcf \
R=reference_sequence.fasta

<h3>Caveats</h3>
<h4>Rejected Records</h4>
Records may be rejected because they cannot be lifted over or because of sequence incompatibilities between the source
and target reference genomes.  Rejected records will be emitted to the REJECT file using the source genome build
coordinates. The reason for the rejection will be stated in the FILTER field, and more detail may be placed in the INFO
field.
<h4>Memory Use</h4>
LiftOverVcf sorts the output using a "SortingCollection" which relies on MAX_RECORDS_IN_RAM to specify how many (vcf)
records to hold in memory before "spilling" to disk. The default value is reasonable when sorting SAM files, but not for
VCFs as there is no good default due to the dependence on the number of samples and amount of information in the INFO
and FORMAT fields. Consider lowering to 100,000 or even less if you have many genotypes.

Version:3.4.0


Required Arguments:

--CHAIN,-C <File>             The liftover chain file. See https://genome.ucsc.edu/goldenPath/help/chain.html for a
                              description of chain files.  See http://hgdownload.soe.ucsc.edu/downloads.html#terms for
                              where to download chain files.  Required. 

--INPUT,-I <File>             The input VCF/BCF file to be lifted over.  Required. 

--OUTPUT,-O <File>            The output location for the lifted over VCF/BCF.  Required. 

--REFERENCE_SEQUENCE,-R <File>The reference sequence (fasta) for the TARGET genome build (i.e., the new one.  The fasta
                              file must have an accompanying sequence dictionary (.dict file).  Required. 

--REJECT <File>               File to which to write rejected records.  Required. 


Optional Arguments:

--ALLOW_MISSING_FIELDS_IN_HEADER <Boolean>
                              Allow INFO and FORMAT in the records that are not found in the header  Default value:
                              false. Possible values: {true, false} 

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--DISABLE_SORT <Boolean>      Output VCF file will be written on the fly but it won't be sorted and indexed.  Default
                              value: false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--LIFTOVER_MIN_MATCH <Double> The minimum percent match required for a variant to be lifted.  Default value: 1.0. 

--LOG_FAILED_INTERVALS,-LFI <Boolean>
                              If true, intervals failing due to match below LIFTOVER_MIN_MATCH will be logged as a
                              warning to the console.  Default value: true. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--RECOVER_SWAPPED_REF_ALT <Boolean>
                              If the REF allele of the lifted site does not match the target genome, that variant is
                              normally rejected. For bi-allelic SNPs, if this is set to true and the ALT allele equals
                              the new REF allele, the REF and ALT alleles will be swapped.  This can rescue some
                              variants; however, do this carefully as some annotations may become invalid, such as any
                              that are alelle-specifc.  See also TAGS_TO_REVERSE and TAGS_TO_DROP.  Default value:
                              false. Possible values: {true, false} 

--TAGS_TO_DROP <String>       INFO field annotations that should be deleted when swapping reference with variant
                              alleles.  This argument may be specified 0 or more times. Default value: [MAX_AF]. 

--TAGS_TO_REVERSE <String>    INFO field annotations that behave like an Allele Frequency and should be transformed with
                              x->1-x when swapping reference with variant alleles.  This argument may be specified 0 or
                              more times. Default value: [AF]. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 

--WARN_ON_MISSING_CONTIG,-WMC <Boolean>
                              Warn on missing contig.  Default value: false. Possible values: {true, false} 

--WRITE_ORIGINAL_ALLELES <Boolean>
                              Write the original alleles for lifted variants to the INFO field.  If the alleles are
                              identical, this attribute will be omitted.  Default value: false. Possible values: {true,
                              false} 

--WRITE_ORIGINAL_POSITION <Boolean>
                              Write the original contig/position for lifted variants to the INFO field.  Default value:
                              false. Possible values: {true, false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_MakeSitesOnlyVcf

### Tool Description
This tool reads a VCF/VCF.gz/BCF and removes all genotype information from it while retaining all site level information, including annotations based on genotypes (e.g. AN, AF). Output can be any supported variant format including .vcf, .vcf.gz or .bcf.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: MakeSitesOnlyVcf [arguments]

This tool reads a VCF/VCF.gz/BCF and removes all genotype information from it while retainingall site level information,
including annotations based on genotypes (e.g. AN, AF). Output can beany supported variant format including .vcf,
.vcf.gz or .bcf. <br /><br /><h4>Usage example:</h4><pre>java -jar picard.jar MakeSitesOnlyVcf \ <br />     
INPUT=input_variants.vcf \ <br />      OUTPUT=output_variants.vcf</pre>
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input VCF or BCF containing genotype and site-level information.  Required. 

--OUTPUT,-O <File>            Output VCF or BCF file containing only site-level information.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: true. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SAMPLE,-S <String>          Names of one or more samples to include in the output VCF.  This argument may be specified
                              0 or more times. Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_MakeVcfSampleNameMap

### Tool Description
Creates a TSV from sample name to VCF/GVCF path, with one line per input. Input VCF/GVCFs must contain a header describing exactly one sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: MakeVcfSampleNameMap [arguments]

Creates a TSV from sample name to VCF/GVCF path, with one line per input.
Input VCF/GVCFs must contain a header describing exactly one sample.
<h4>Usage example:</h4><pre>    java -jar picard.jar MakeVcfSampleNameMap \
INPUT=sample1.vcf.gz \
INPUT=sample2.vcf.gz \
OUTPUT=cohort.sample_map</pre>
Version:3.4.0


Required Arguments:

--INPUT,-I <String>           One or more input VCFs to extract sample names from.  This argument must be specified at
                              least once. Required. 

--OUTPUT,-O <File>            Output file to write the sample-name map to.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_MergeVcfs

### Tool Description
Combines multiple variant files into a single variant file.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: MergeVcfs [arguments]

<p>Combines multiple variant files into a single variant file.</p><h3>Inputs</h3><ul>      <li>One or more input file in
VCF format (can be gzipped, i.e. ending in ".vcf.gz", or binary compressed, i.e. ending in ".bcf").</li>     
<li>Optionally a sequence dictionary file (typically name ending in .dict) if the input VCF does not contain a         
complete contig list and if the output index is to be created (true by default).</li>  </ul>  <p>  The input variant
data must adhere to the following rules:</p>     <ul>         <li>If there are samples, those must be the same across
all input files.</li>         <li>Input file headers must be contain compatible declarations for common annotations
(INFO, FORMAT fields) and filters.</li>         <li>Input files variant records must be sorted by their contig and
position following the sequence dictionary provided         or the header contig list.</li>     </ul> <p>You can either
directly specify the list of files by specifying <code>INPUT</code> multiple times, or provide a list     in a file with
name ending in ".list" to <code>INPUT</code>.</p> <h3>Outputs</h3> <p>A VCF sorted (i) according to the dictionary and
(ii) by coordinate.</p> <h3>Usage examples</h3> <h4>Example 1:</h4> <p>We combine several variant files in different
formats, where at least one of them contains the contig list in its header.</p> <pre>java -jar picard.jar MergeVcfs \
I=input_variants.01.vcf \
I=input_variants.02.vcf.gz \
O=output_variants.vcf.gz</pre> <h4>Example 2:</h4> <p>Similar to example 1 but we use an input list file to specify the
input files:</p> <pre>java -jar picard.jar MergeVcfs \
I=input_variant_files.list \
O=output_variants.vcf.gz</pre><hr/>
Version:3.4.0


Required Arguments:

--INPUT,-I <PicardHtsPath>    VCF or BCF input files (File format is determined by file extension), or a file having a
                              '.list' suffix containing the path to the files, one per line.  This argument must be
                              specified at least once. Required. 

--OUTPUT,-O <File>            The merged VCF or BCF file. File format is determined by file extension.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMMENT,-CO <String>        Comment(s) to include in the merged output file's header.  This argument may be specified
                              0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: true. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SEQUENCE_DICTIONARY,-D <PicardHtsPath>
                              The index sequence dictionary to use instead of the sequence dictionary in the input files
                              Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_RenameSampleInVcf

### Tool Description
This tool enables the user to rename a sample in either a VCF or BCF file. It is intended to change the name of a sample in a VCF prior to merging with VCF files in which one or more samples have similar names. Note that the input VCF file must be single-sample VCF and that the NEW_SAMPLE_NAME is required.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: RenameSampleInVcf [arguments]

This tool enables the user to rename a sample in either a VCF or BCF file.  It is intended to change the name of a
sample in a VCF prior to merging with VCF files in which one or more samples have similar names. Note that the input VCF
file must be single-sample VCF and that the NEW_SAMPLE_NAME is required.<br /><br /><h4>Usage example:</h4><pre>java
-jar picard.jar RenameSampleInVcf \<br />      INPUT=input_variants.vcf \<br />      OUTPUT=output_variants.vcf \<br /> 
NEW_SAMPLE_NAME=sample</pre><h4> Notes </h4><br />The input VCF (or BCF) <i>must</i> be single-sample.
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input single sample VCF or BCF file.  Required. 

--NEW_SAMPLE_NAME <String>    New name to give sample in output VCF.  Required. 

--OUTPUT,-O <File>            Output single sample VCF.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--OLD_SAMPLE_NAME <String>    Existing name of sample in VCF; if provided, asserts that that is the name of the extant
                              sample name  Default value: null. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_SortVcf

### Tool Description
Sorts one or more VCF files. This tool sorts the records in VCF files according to the order of the contigs in the header/sequence dictionary and then by coordinate. It can accept an external sequence dictionary. If no external dictionary is supplied, the VCF file headers of multiple inputs must have the same sequence dictionaries.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: SortVcf [arguments]

Sorts one or more VCF files.  This tool sorts the records in VCF files according to the order of the contigs in the
header/sequence dictionary and then by coordinate. It can accept an external sequence dictionary. If no external
dictionary is supplied, the VCF file headers of multiple inputs must have the same sequence dictionaries.<br /><br />If
running on multiple inputs (originating from e.g. some scatter-gather runs), the input files must contain the same
sample names in the same column order. <br /><h4>Usage example:</h4><pre>java -jar picard.jar SortVcf \<br />     
I=vcf_1.vcf \<br />      I=vcf_2.vcf \<br />      O=sorted.vcf</pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input VCF(s) to be sorted. Multiple inputs must have the same sample names (in order) 
                              This argument must be specified at least once. Required. 

--OUTPUT,-O <File>            Output VCF to be written.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: true. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SEQUENCE_DICTIONARY,-SD <File>
                              Undocumented option  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_SplitVcfs

### Tool Description
Splits SNPs and INDELs into separate files. This tool reads in a VCF or BCF file and writes out the SNPs and INDELs it contains to separate files. The headers of the two output files will be identical and index files will be created for both outputs. If records other than SNPs or INDELs are present, set the STRICT option to "false", otherwise the tool will raise an exception and quit.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: SplitVcfs [arguments]

Splits SNPs and INDELs into separate files.  This tool reads in a VCF or BCF file and writes out the SNPs and INDELs it
contains to separate files. The headers of the two output files will be identical and index files will be created for
both outputs. If records other than SNPs or INDELs are present, set the STRICT option to "false", otherwise the tool
will raise an exception and quit. <br /><h4>Usage example:</h4><pre>java -jar picard.jar SplitVcfs \<br />     
I=input.vcf \<br />      SNP_OUTPUT=snp.vcf \<br />      INDEL_OUTPUT=indel.vcf \<br />      STRICT=false</pre><hr />
Version:3.4.0


Required Arguments:

--INDEL_OUTPUT <File>         The VCF or BCF file to which indel records should be written. The file format is
                              determined by file extension.  Required. 

--INPUT,-I <PicardHtsPath>    The VCF or BCF input file  Required. 

--SNP_OUTPUT <File>           The VCF or BCF file to which SNP records should be written. The file format is determined
                              by file extension.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: true. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--SEQUENCE_DICTIONARY,-D <PicardHtsPath>
                              The index sequence dictionary to use instead of the sequence dictionaries in the input
                              files  Default value: null. 

--STRICT <Boolean>            If true an exception will be thrown if an event type other than SNP or indel is
                              encountered  Default value: true. Possible values: {true, false} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_UpdateVcfSequenceDictionary

### Tool Description
Takes a VCF and a second file that contains a sequence dictionary and updates the VCF with the new sequence dictionary.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: UpdateVcfSequenceDictionary [arguments]

Takes a VCF and a second file that contains a sequence dictionary and updates the VCF with the new sequence dictionary.
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             Input VCF  Required. 

--OUTPUT,-O <File>            Output VCF to be written.  Required. 

--SEQUENCE_DICTIONARY,-SD <File>
                              A Sequence Dictionary (can be read from one of the following file types (SAM, BAM, VCF,
                              BCF, Interval List, Fasta, or Dict)  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_VcfFormatConverter

### Tool Description
Converts VCF to BCF or BCF to VCF. This tool converts files between the plain-text VCF format and its binary compressed equivalent, BCF. Input and output formats are determined by file extensions specified in the file names.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: VcfFormatConverter [arguments]

Converts VCF to BCF or BCF to VCF.  This tool converts files between the plain-text VCF format and its binary compressed
equivalent, BCF. Input and output formats are determined by file extensions specified in the file names. For best
results, it is recommended to ensure that an index file is present and set the REQUIRE_INDEX option to true.<br
/><h4>Usage example:</h4><pre>java -jar picard.jar VcfFormatConverter \<br />      I=input.vcf \<br />      O=output.bcf
\<br />      REQUIRE_INDEX=true</pre><hr />
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The BCF or VCF input file.  Required. 

--OUTPUT,-O <File>            The BCF or VCF output file name.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: true. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--REQUIRE_INDEX <Boolean>     Fail if an index is not available for the input VCF/BCF  Default value: true. Possible
                              values: {true, false} 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## picard_VcfToIntervalList

### Tool Description
This tool creates a Picard Interval List from a VCF or BCF. It is important that the file extension is included as the file format is determined by the file extension. Variants that were filtered can be included in the output interval list by setting INCLUDE_FILTERED to true.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/picard: line 5: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
USAGE: VcfToIntervalList [arguments]

This tool creates a Picard Interval List from a VCF or BCF. It is important that the file extension is included as the
file format is determined by the fileextension. Variants that were filtered can be included in the output interval list
by settingINCLUDE_FILTERED to true.<p><h4>Usage example:</h4><pre>java -jar picard.jar VcfToIntervalList <br />     
I=sample.vcf <br />      O=sample.interval_list <br /></pre>
Version:3.4.0


Required Arguments:

--INPUT,-I <File>             The BCF or VCF input file. The file format is determined by file extension.  Required. 

--OUTPUT,-O <File>            The output Picard Interval List.  Required. 


Optional Arguments:

--arguments_file <File>       read one or more arguments files and add them to the command line  This argument may be
                              specified 0 or more times. Default value: null. 

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value: 5. 

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM output.  Default
                              value: false. Possible values: {true, false} 

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.    Default value:
                              false. Possible values: {true, false} 

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} 

--INCLUDE_FILTERED,-IF <Boolean>
                              Include variants that were filtered in the output interval list.  Default value: false.
                              Possible values: {true, false} 

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of records stored
                              in RAM before spilling to disk. Increasing this number reduces the number of file handles
                              needed to sort the file, and increases the amount of RAM needed.  Default value: 500000. 

--QUIET <Boolean>             Whether to suppress job-summary info on System.err.  Default value: false. Possible
                              values: {true, false} 

--REFERENCE_SEQUENCE,-R <PicardHtsPath>
                              Reference sequence file.  Default value: null. 

--TMP_DIR <File>              One or more directories with space available to be used by this program for temporary
                              storage of working files  This argument may be specified 0 or more times. Default value:
                              null. 

--USE_JDK_DEFLATER,-use_jdk_deflater <Boolean>
                              Use the JDK Deflater instead of the Intel Deflater for writing compressed output  Default
                              value: false. Possible values: {true, false} 

--USE_JDK_INFLATER,-use_jdk_inflater <Boolean>
                              Use the JDK Inflater instead of the Intel Inflater for reading compressed input  Default
                              value: false. Possible values: {true, false} 

--VALIDATION_STRINGENCY <ValidationStringency>
                              Validation stringency for all SAM files read by this program.  Setting stringency to
                              SILENT can improve performance when processing a BAM file in which variable-length data
                              (read, qualities, tags) do not otherwise need to be decoded.  Default value: STRICT.
                              Possible values: {STRICT, LENIENT, SILENT} 

--VARIANT_ID_METHOD <VARIANT_ID_TYPES>
                              Controls the naming of the resulting intervals. When set to CONCAT_ALL (the default), each
                              resulting interval will be named the concatenation of the variant ID fields (if present),
                              or 'interval-<number>' (if not) with a pipe '|' separator. If set to USE_FIRST, only the
                              first name will be used.  Default value: CONCAT_ALL. Possible values: {CONCAT_ALL,
                              USE_FIRST} 

--VERBOSITY <LogLevel>        Control verbosity of logging.  Default value: INFO. Possible values: {ERROR, WARNING,
                              INFO, DEBUG} 

--version <Boolean>           display the version number for this tool  Default value: false. Possible values: {true,
                              false} 


Advanced Arguments:

--showHidden <Boolean>        display hidden arguments  Default value: false. Possible values: {true, false} 


Argument INPUT was missing: Argument 'INPUT' is required
```


## Metadata
- **Validation-run**: PASS
- **Skill**: generated
