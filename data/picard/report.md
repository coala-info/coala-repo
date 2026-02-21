# picard CWL Generation Report

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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              inpu...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--BASECALLS_DIR,-B <File>     The Illumina basecalls output directory from whic...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
the threshold of calling it a match, we output the barcode t...
```


## picard_IlluminaBasecallsToFastq

### Tool Description
Generate FASTQ file(s) from Illumina basecall read data. Separate FASTQ files are created for each template, barcode, and index (molecular barcode) read.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
(1) or second (2) for paire...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--BARCODE_PARAMS <File>       Deprecated (use LIBRARY_PARAMS).  Tab-separated file for creating all outpu...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--CREATE_INDEX <B...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--QUIET <Boolean>             Whether to suppress job-sum...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will spe...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              nee...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              specified 0 or ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              in RAM before spilling to disk. Increasi...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
    ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
OU...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--TMP_DIR <File>          ...
```


## picard_ClusterCrosscheckMetrics

### Tool Description
Clusters the results from a CrosscheckFingerprints run according to the LOD score. The resulting metric file can be used to assist diagnosing results from CrosscheckFingerprints. It clusters the connectivity graph between the different groups. Two groups are connected if they have a LOD score greater than the LOD_THRESHOLD.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
itself!) will not be included in the metri...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              AGATCGGAAGAGC...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--help,-h <Boolean>           display the help message  Default value: false. Possible values: {true, false} ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
aims to correct some types of systematic biases that affect the accuracy of base quality scores.<p>Note...
```


## picard_CollectGcBiasMetrics

### Tool Description
Collects information about the relative proportions of guanine (G) and cytosine (C) nucleotides in a sample to assess GC bias.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
slight preponderance of AT-rich regions.  <br /><br /><h4>Summary metrics</h4...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
table, you must add the PROB_EXPLICIT_READS option to your command line and s...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
information for every target interval, use the PER_TARGET_CO...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate so...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--OUTPUT,-O <File>            The file to write ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--CHIMERA_KB_MIN <Integer>    Jumps greater than or equal to the greater of this value or 2 times the mode...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              true. Possi...
```


## picard_CollectOxoGMetrics

### Tool Description
Collect metrics to assess oxidative artifacts. This tool collects metrics quantifying the error rate resulting from oxidative artifacts, calculating the Phred-scaled probability that an alternate base call results from an oxidation artifact based on base context, sequencing read orientation, and characteristic low allelic frequency.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files cre...
```


## picard_CollectQualityYieldMetrics

### Tool Description
Collect metrics about reads that pass quality thresholds and Illumina-specific filters. This tool evaluates the overall quality of reads within a bam file containing one read group.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--arguments_file <File>       read one or more arguments files and add them to the c...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--help,-h <Boolean>           display the help message  Default value: false. Possible values...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--COMPRESSION_LEVEL <Integer> Compre...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
href='htt...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
tab-delimited file containing information about the location of RNA transcripts, exon start and stop sites, e...
```


## picard_CollectRrbsMetrics

### Tool Description
Collects metrics from reduced representation bisulfite sequencing (Rrbs) data. This tool uses Rrbs data to determine cytosine methylation status across all reads of a genomic DNA sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
of the CpG sites for the experiment as well as the conversion rat...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
interval where the user is relatively certain that the polymorphic ...
```


## picard_CollectSequencingArtifactMetrics

### Tool Description
Collect metrics to quantify single-base sequencing artifacts, specifically pre-adapter and bait-bias errors associated with hybrid selection protocols.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
that an alternate base call is due to ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              An interval list file that contains the locatio...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--help,-h <Boolean>           disp...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              needed to sort the file, and incre...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--COMPRESSION_LEVEL <Integer> Compression level for all compressed files created (e.g. BAM and VCF).  Default value...
```


## picard_CollectWgsMetricsWithNonZeroCoverage

### Tool Description
Collect metrics about coverage and performance of whole genome sequencing (WGS) experiments. This tool extends CollectWgsMetrics by including metrics related only to sites with non-zero (>0) coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              specified 0 or more times. Default value: [0.001, 0.005, 0.0...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              Ignore any differences betwe...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--a...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              needed to sort the file, and increases the amount of RAM needed.  Default value:...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
are provided then the value of INPUT_BASE is i...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
each other. <br /><br /> There may be cases where several groups out of a collection of pos...
```


## picard_EstimateLibraryComplexity

### Tool Description
Estimates the numbers of unique molecules in a sequencing library. Library complexity refers to the number of unique DNA fragments present in a given library. Reductions in complexity resulting from PCR amplification during library preparation will ultimately compromise downstream analyses via an elevation in the number of duplicate reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
is applied to the data as follows.  After examining all reads, a histogram is built ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--CREATE_MD5_FILE <Boolean>   Whether to create an MD5 digest for any BAM or FASTQ files created.  ...
```


## picard_IdentifyContaminant

### Tool Description
Computes the fingerprint genotype likelihoods from the supplied SAM/BAM file and a contamination estimate. NOTA BENE: the fingerprint is provided for the contamination (by default) for the main sample. It is given as a list of PLs at the fingerprinting sites.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              false. Possible v...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              in RAM before spilling to disk. Increasing this number reduces the number of...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              true. Possible values: {tr...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--arguments_file <File>       read one or more arguments files and add t...
```


## picard_ValidateSamFile

### Tool Description
Validates a SAM/BAM/CRAM file relative to the SAM format specification. Reports on improper formatting, faulty alignments, incorrect flag values, etc.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
0  ...
```


## picard_ViewSam

### Tool Description
Very simple command that just reads a SAM or BAM file and writes out the header and each record to standard out. When an (optional) intervals file is specified, only records overlapping those intervals will be output. All reads, just the aligned reads, or just the unaligned reads can be printed out by setting AlignmentStatus accordingly.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--C...
```


## picard_BpmToNormalizationManifestCsv

### Tool Description
BpmToNormalizationManifestCsv takes an Illumina BPM (Bead Pool Manifest) file and generates an Illumina-formatted bpm.csv file from it. A bpm.csv is a file that was generated by an old version of Illumina's Autocall software. Since it contained normalization IDs (needed to calculate normalized intensities), it came into use in several programs notably zCall.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--MAX_RECORDS_...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
          ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              in RAM before s...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--MAX_RECORDS_IN_RAM <Integer>When writing files that...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
--REFERENCE_SEQUENCE reference.fasta \<br />      --TB 37 \<br />      --SB 36 \<br />      --SR bui...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

-...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--ANA...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--arguments_file <File>       read one...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--COMPRESSION_LEVEL <Integer> Compress...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
After the header, the file then contains records, one per line in plain text format wi...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--SCORE <Integer>...
```


## picard_IntervalListTools

### Tool Description
A tool for performing various IntervalList manipulations including sorting, merging, subtracting, padding, and other set-theoretic operations.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
chr1	1	100	+	starts at the first base...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--OUT...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              va...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--help,-h <Boolean>           display the help message  Def...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--MAX_RECORDS_IN_RAM <Integer>When writing ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--MAX_RECORDS_IN_RAM <Integer>When wr...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              specif...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              only the first BASES_TO_WRITE bases from each read w...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
            ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              in RAM before spilling to disk. Increasing this number redu...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
and then a High...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--FASTQ,-F1 <PicardHtsPath>   Input fastq file (optionally gzipped)...
```


## picard_FilterSamReads

### Tool Description
Subsets reads from a SAM/BAM/CRAM file by applying one of several filters such as aligned or unaligned reads, specific reads based on a list of reads names, an interval list, by Tag Values, or using a JavaScript script.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
O=output.bam \ <br />       JAV...
```


## picard_FixMateInformation

### Tool Description
Verify mate-pair information between mates and fix if needed. This tool ensures that all mate-pair information is in sync between each read and its mate pair. If no OUTPUT file is supplied then the output is written to a temporary file and then copied over the INPUT file.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--COMPRESSION_LEVEL <Integ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM ou...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
bitwise flag annotation indicates whether a read wa...
```


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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--METRICS_FILE,-M <File>      File to write ...
```


## picard_MergeBamAlignment

### Tool Description
Merge alignment data from a SAM or BAM with data in an unmapped BAM file. Produces a third BAM file that has alignment data (from the aligner) and all the remaining data from the unmapped BAM.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
Without a...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--COMMENT,-CO <String>        Comment(s) to include in the merged output file's header.  This argument may be specified...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

j...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              reference for each re...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              false. ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              given that t...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--OUTPUT_MA...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                  ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--INPUT,-I <File>             Input SAM/BA...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                        ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              Possible values: {true, f...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              coordinate (Sorts primarily according to the SEQ and P...
```


## picard_SplitSamByLibrary

### Tool Description
Takes a SAM/BAM/CRAM file and separates all the reads into one output file per library name. Reads that do not have a read group specified or whose read group does not have a library name are written to a file called 'unknown.' The format (SAM/BAM/CRAM) of the output files matches that of the input file.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              needed to sort the file, and increas...
```


## picard_SplitSamByNumberOfReads

### Tool Description
Splits a SAM/BAM/CRAM file to multiple files. This tool splits the input query-grouped SAM/BAM/CRAM file into multiple files while maintaining the sort order. This can be used to split a large unmapped input in order to parallelize alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--MAX_RECORDS_IN_RAM <Integer>When writing files tha...
```


## picard_UmiAwareMarkDuplicatesWithMateCigar

### Tool Description
Identifies duplicate reads using information from read positions and UMIs. This tool locates and tags duplicate reads in a BAM or SAM file, where duplicate reads are defined as originating from a single fragment of DNA. It leverages Unique Molecular Identifier (UMI) information and allows for sequencing errors in UMIs based on a maximum edit distance.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
alignments tha...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--arguments_file <File>    ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--CREATE_INDEX <Boolean>      Whether to create an index when writing VCF or coordinate sorted BAM outpu...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              false. Possible values: {t...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--MAX_RECORDS_IN_RAM <Integer>When writing files that need to be sorted, this will specify the number of r...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--LINE_LENGTH <Integer>       The line length to be used fo...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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


Optional Ar...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--TRIOS,-PED <File>           File of Trio information in PED format (with ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
true-positive(TP), true-negative (TN), false-positive (FP), and false-negati...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              value of the script...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              value: false. Possible values:...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              needed to sort the file, and increases the amount o...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
records to hold in memory before "spilling" to disk. The...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              in RAM before spilling to disk. Increasing this number reduces the ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              needed to sort ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--MAX_RECORDS_IN_RAM <Integer>When wr...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--help,-h <Boolean>           display ...
```


## picard_SplitVcfs

### Tool Description
Splits SNPs and INDELs into separate files. This tool reads in a VCF or BCF file and writes out the SNPs and INDELs it contains to separate files. The headers of the two output files will be identical and index files will be created for both outputs.

### Metadata
- **Docker Image**: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
- **Homepage**: http://broadinstitute.github.io/picard/
- **Package**: https://anaconda.org/channels/bioconda/packages/picard/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
               ...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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
                              in RAM before spilling to disk. Incre...
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
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
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

--MAX_RECORDS_IN_RA...
```


## Metadata
- **Skill**: generated
