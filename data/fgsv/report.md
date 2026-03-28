# fgsv CWL Generation Report

## fgsv_AggregateSvPileup

### Tool Description
Aggregates and merges pileups that are likely to support the same breakpoint.

Takes as input the file of pileups produced by 'SvPileup'. That file contains a list of breakpoints, each consisting of
a chromosome, position and strand for each side of the breakpoint, as well as quantified read support for the
breakpoint.

This tool merges sets of breakpoints that have their left sides on the same chromosome, their right sides on the same
chromosome, the same left and right strands, and their left and right positions both within a length threshold. The
merging behavior is transitive. For example, two breakpoints that are farther apart than the length threshold can be
merged if there is a third breakpoint that is close to both.

'SvPileup' distinguishes between two types of evidence for breakpoint events: split-read evidence, where a breakpoint
occurs within a mapped read, and read-pair evidence, where a breakpoint occurs in the unsequenced insert between two
paired reads. Currently this tool treats both forms of evidence equally, despite the inaccuracy of positions reported
by 'SvPileup' for read-pair evidence.

If a BAM file is provided, each aggregated pileup is annotated with the allele frequency at its left and right
breakends. Allele frequency is defined as the total number of templates supporting constituent breakpoints divided by
the count of the union of templates that cross any constituent breakends. In particular, paired templates that straddle
a breakend are considered to cross the breakend.

If a BED file of target regions is provided, each aggregated pileup is annotated with whether its left and right sides
overlap a target region. Additionally, the names of the overlapping target regions will be annotated, overwriting any
values from the 'SvPileup' input. If no target regions are provided, then the names of the overlapping target regions
are copied from the 'SvPiluep' input (if present).

The output file is a tab-delimited table with one record per aggregated cluster of pileups. Aggregated pileups are
reported with the minimum and maximum (inclusive) coordinates of all pileups in the cluster, a possible putative
structural variant event type supported by the pileups, and the sum of read support from all pileups in the cluster.
Positions in this file are 1-based inclusive positions.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgsv:0.2.1--hdfd78af_1
- **Homepage**: https://github.com/fulcrumgenomics/fgsv
- **Package**: https://anaconda.org/channels/bioconda/packages/fgsv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fgsv/overview
- **Total Downloads**: 10.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fulcrumgenomics/fgsv
- **Stars**: N/A
### Original Help Text
```text
Feb 25, 2026 1:40:19 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgsv/fgsv.jar!/com/intel/gkl/native/libgkl_compression.so
[31mUSAGE:[0m [1m[31mfgsv[0m [31m[fgsv arguments] [command name] [command arguments][0m
[31mVersion: 0.2.1[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[31m
[1m[31mfgsv[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--async-io[[=true|false]][0m     [36mUse asynchronous I/O where possible, e.g. for SAM and BAM files. [32m[Default:
                              false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m--compression=Int[0m             [36mDefault GZIP compression level, BAM compression level. [32m[Default: 5].[0m [32m[0m
[0m[32m--tmp-dir=DirPath[0m             [36mDirectory to use for temporary files. [32m[Default: /tmp].[0m [32m[0m
[0m[32m--log-level=LogLevel[0m          [36mMinimum severity log-level to emit. [32m[Default: Info].[0m [32mOptions: Debug, Info,
                              Warning, Error, Fatal.[0m
[0m[32m--sam-validation-stringency=ValidationStringency[0m
                              [36mValidation stringency for SAM/BAM reading. [32m[Default: SILENT].[0m [32mOptions:
                              STRICT, LENIENT, SILENT.[0m
[0m
[1m[31mAggregateSvPileup[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mAggregates and merges pileups that are likely to support the same breakpoint.

Takes as input the file of pileups produced by 'SvPileup'. That file contains a list of breakpoints, each consisting of
a chromosome, position and strand for each side of the breakpoint, as well as quantified read support for the
breakpoint.

This tool merges sets of breakpoints that have their left sides on the same chromosome, their right sides on the same
chromosome, the same left and right strands, and their left and right positions both within a length threshold. The
merging behavior is transitive. For example, two breakpoints that are farther apart than the length threshold can be
merged if there is a third breakpoint that is close to both.

'SvPileup' distinguishes between two types of evidence for breakpoint events: split-read evidence, where a breakpoint
occurs within a mapped read, and read-pair evidence, where a breakpoint occurs in the unsequenced insert between two
paired reads. Currently this tool treats both forms of evidence equally, despite the inaccuracy of positions reported
by 'SvPileup' for read-pair evidence.

If a BAM file is provided, each aggregated pileup is annotated with the allele frequency at its left and right
breakends. Allele frequency is defined as the total number of templates supporting constituent breakpoints divided by
the count of the union of templates that cross any constituent breakends. In particular, paired templates that straddle
a breakend are considered to cross the breakend.

If a BED file of target regions is provided, each aggregated pileup is annotated with whether its left and right sides
overlap a target region. Additionally, the names of the overlapping target regions will be annotated, overwriting any
values from the 'SvPileup' input. If no target regions are provided, then the names of the overlapping target regions
are copied from the 'SvPiluep' input (if present).

The output file is a tab-delimited table with one record per aggregated cluster of pileups. Aggregated pileups are
reported with the minimum and maximum (inclusive) coordinates of all pileups in the cluster, a possible putative
structural variant event type supported by the pileups, and the sum of read support from all pileups in the cluster.
Positions in this file are 1-based inclusive positions.
[0m[31m
[1m[31mAggregateSvPileup[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i FilePath, --input=FilePath[0m [36mInput text file of pileups generated by SvPileup [32m[0m
[0m[33m-o FilePath, --output=FilePath[0m[36mOutput file [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-b PathToBam, --bam=PathToBam[0m [36mBam file for allele frequency analysis. Must be coordinate sorted version of the file
                              that was input to SvPileup. [32m[Optional].[0m [32m[0m
[0m[32m-f Int, --flank=Int[0m           [36mIf BAM file is provided: distance upstream and downstream of aggregated breakpoint
                              regions to search for mapped templates that overlap breakends. These are the templates
                              that will be partitioned into those supporting the breakpoint vs. reading through it for
                              the allele frequency calculation. Recommended to use at least the max read pair inner
                              distance used by SvPileup. [32m[Default: 1000].[0m [32m[0m
[0m[32m--min-breakpoint-support=Int[0m  [36mIf BAM file is provided: minimum total number of templates supporting an aggregated
                              breakpoint to report allele frequency. Supports speed improvement by avoiding querying
                              and iterating over huge read pileups that contain insufficient support for a breakpoint
                              to be considered interesting. [32m[Default: 10].[0m [32m[0m
[0m[32m--min-frequency=Double[0m        [36mIf BAM file is provided: minimum allele frequency to report. Supports speed improvement
                              by avoiding iterating over huge read pileups that contain insufficient support for a
                              breakpoint to be considered interesting. [32m[Default: 0.001].[0m [32m[0m
[0m[32m-t FilePath, --targets-bed=FilePath[0m
                              [36mOptional BED file of target regions [32m[Optional].[0m [32m[0m
[0m[32m-d Int, --max-dist=Int[0m        [36mDistance threshold below which to cluster breakpoints [32m[Default: 10].[0m [32m[0m
[0m
[1m[31mException: UserException
Error: Argument 'input' is required.[0m
```


## fgsv_FilterAndMerge

### Tool Description
Filters and merges SVPileup output.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgsv:0.2.1--hdfd78af_1
- **Homepage**: https://github.com/fulcrumgenomics/fgsv
- **Package**: https://anaconda.org/channels/bioconda/packages/fgsv/overview
- **Validation**: PASS

### Original Help Text
```text
Feb 25, 2026 1:40:56 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgsv/fgsv.jar!/com/intel/gkl/native/libgkl_compression.so
[31mUSAGE:[0m [1m[31mfgsv[0m [31m[fgsv arguments] [command name] [command arguments][0m
[31mVersion: 0.2.1[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[31m
[1m[31mfgsv[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--async-io[[=true|false]][0m     [36mUse asynchronous I/O where possible, e.g. for SAM and BAM files. [32m[Default:
                              false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m--compression=Int[0m             [36mDefault GZIP compression level, BAM compression level. [32m[Default: 5].[0m [32m[0m
[0m[32m--tmp-dir=DirPath[0m             [36mDirectory to use for temporary files. [32m[Default: /tmp].[0m [32m[0m
[0m[32m--log-level=LogLevel[0m          [36mMinimum severity log-level to emit. [32m[Default: Info].[0m [32mOptions: Debug, Info,
                              Warning, Error, Fatal.[0m
[0m[32m--sam-validation-stringency=ValidationStringency[0m
                              [36mValidation stringency for SAM/BAM reading. [32m[Default: SILENT].[0m [32mOptions:
                              STRICT, LENIENT, SILENT.[0m
[0m
[1m[31mFilterAndMerge[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mFilters and merges SVPileup output.
[0m[31m
[1m[31mFilterAndMerge[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i FilePath, --input=FilePath[0m [36mThe input pileup file from SvPileup [32m[0m
[0m[33m-o FilePath, --output=FilePath[0m[36mThe output filtered and merged SvPileup file [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-m Int, --min-pre=Int[0m         [36mThe minimum # of observations to examine an input site [32m[Default: 1].[0m [32m[0m
[0m[32m-M Int, --min-post=Int[0m        [36mThe minimum # of observations to output a site [32m[Default: 1].[0m [32m[0m
[0m[32m-s Int, --slop=Int[0m            [36mThe maximum # bases between a breakend across adjacent sites [32m[Default: 0].[0m
                              [32m[0m
[0m
[1m[31mException: UserException
Error: Argument 'input' is required.[0m
```


## fgsv_SvPileup

### Tool Description
Collates pileups of reads over breakpoint events.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgsv:0.2.1--hdfd78af_1
- **Homepage**: https://github.com/fulcrumgenomics/fgsv
- **Package**: https://anaconda.org/channels/bioconda/packages/fgsv/overview
- **Validation**: PASS

### Original Help Text
```text
Feb 25, 2026 1:41:30 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgsv/fgsv.jar!/com/intel/gkl/native/libgkl_compression.so
[31mUSAGE:[0m [1m[31mfgsv[0m [31m[fgsv arguments] [command name] [command arguments][0m
[31mVersion: 0.2.1[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[31m
[1m[31mfgsv[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--async-io[[=true|false]][0m     [36mUse asynchronous I/O where possible, e.g. for SAM and BAM files. [32m[Default:
                              false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m--compression=Int[0m             [36mDefault GZIP compression level, BAM compression level. [32m[Default: 5].[0m [32m[0m
[0m[32m--tmp-dir=DirPath[0m             [36mDirectory to use for temporary files. [32m[Default: /tmp].[0m [32m[0m
[0m[32m--log-level=LogLevel[0m          [36mMinimum severity log-level to emit. [32m[Default: Info].[0m [32mOptions: Debug, Info,
                              Warning, Error, Fatal.[0m
[0m[32m--sam-validation-stringency=ValidationStringency[0m
                              [36mValidation stringency for SAM/BAM reading. [32m[Default: SILENT].[0m [32mOptions:
                              STRICT, LENIENT, SILENT.[0m
[0m
[1m[31mSvPileup[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mCollates pileups of reads over breakpoint events.

Outputs
-------

Two output files will be created:

  1. '<output-prefix>.txt': a tab-delimited file describing SV pileups, one line per breakpoint event. The returned
     breakpoint will be canonicalized such that the "left" side of the breakpoint will have the lower (or equal to)
     position on the genome vs. the "right"s side. Positions in this file are 1-based inclusive positions.
  2. '<output-prefix>.bam': a SAM/BAM file containing reads that contain SV breakpoint evidence annotated with SAM tag.

The 'be' SAM tag contains a comma-delimited list of breakpoints to which a given alignment belongs. Each element is
semi-colon delimited, with four fields:

  1. The unique breakpoint identifier (same identifier found in the tab-delimited output).
  2. Either "left" or "right, corresponding to whether the read shows evidence of the genomic left or right side of the
     breakpoint as found in the breakpoint file (i.e. 'left_pos' or 'right_pos').
  3. Either "from" or "into", such that when traversing the breakpoint would read through "from" and then into "into"
     in the sequencing order of the read pair. For a split-read alignment, the "from" contains the aligned portion of the
     read that comes from earlier in the read in sequencing order. For an alignment of a read-pair spanning the
     breakpoint, then "from" should be read-one of the pair and "into" should be read-two of the pair.
  4. The type of breakpoint evidence: either "split_read" for observations of an aligned segment of a single read with
     split alignments, or "read_pair" for observations between reads in a read pair.

As described in the Algorithm Overview below, split-read evidence is favored over across-read-pair evidence. Therefore,
if the template (alignments for a read pair) contain both types of evidence, then the 'be' tag will only be added to
the split-read alignments (i.e. the primary and supplementary alignments of the read in the pair that has split-read
evidence), and will not be found in the mate's alignment.

Example output
--------------

The following shows two breakpoints:

  id left_contig left_pos left_strand right_contig right_pos right_strand split_reads read_pairs total
   1        chr1      100           +         chr2       200            -           1          0     1
   2        chr2      150           -         chr3       500            +           1          0     1

Consider a single fragment read that maps across both the above two breakpoints, so has three split-read alignments.
The first alignment maps on the left side of breakpoint #1, the second alignment maps to both the right side of
breakpoint #1 and the left-side of breakpoint #2, and the third alignment maps to the right side of breakpoint #2. The
SAM records would be as follows:

  r1    0 chr1  50 60   50M100S ... be:Z:1;left;from;split_read
  r1 2064 chr2 150 60 50S50M50S ... be:Z:1;right;into;split_read,2;left;from;split_read
  r1 2048 chr3 500 60   100S50M ... be:Z:2;right;into;split_read

Algorithm Overview
------------------

Putative breakpoints are identified by examining the alignments for each template. The alignments are transformed into
aligned segments in the order they were sequenced. Each aligned segment represents the full genomic span of the mapped
bases. This is performed first for the primary alignments. Next, supplementary alignments are added only if they map
read bases that have not been previously covered by other alignments (see '--min-unique-bases-to-add'). This is
iteratively performed until supplementary alignments have been exhausted.

Next, aligned segments that have overlapping genomic mapped bases are merged into a single aligned segment. In this
case, the two or more read mappings merged are associated with either the left side or right side of that aligned
segment, controlled by examining how close to the end of the new aligned segment the given read mapping occurs (see
'--slop' option). This used to identify which reads traverse "from" and "into" the breakpoint as described above.

Finally, pairs of adjacent aligned segments are examined for evidence of a breakpoint, such that genomic distance
between them beyond either '--max-read-pair-inner-distance' for aligned segments from different read pairs, or
'--max-aligned-segment-inner-distance' for aligned segments from the same read in a pair (i.e. split-read mapping).
Split read evidence will be returned in favor of across-read-pair evidence when both are present.
[0m[31m
[1m[31mSvPileup[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i PathToBam, --input=PathToBam[0m
                              [36mThe input query sorted or grouped BAM [32m[0m
[0m[33m-o PathPrefix, --output=PathPrefix[0m
                              [36mThe output path prefix [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-d Int, --max-read-pair-inner-distance=Int[0m
                              [36mThe maximum inner distance for normal read pair [32m[Default: 1000].[0m [32m[0m
[0m[32m-D Int, --max-aligned-segment-inner-distance=Int[0m
                              [36mThe maximum inner distance between two segments of a split read mapping [32m[Default:
                              100].[0m [32m[0m
[0m[32m-q Int, --min-primary-mapping-quality=Int[0m
                              [36mThe minimum mapping quality for primary alignments [32m[Default: 30].[0m [32m[0m
[0m[32m-Q Int, --min-supplementary-mapping-quality=Int[0m
                              [36mThe minimum mapping quality for supplementary alignments [32m[Default: 18].[0m
                              [32m[0m
[0m[32m-b Int, --min-unique-bases-to-add=Int[0m
                              [36mThe minimum # of uncovered query bases needed to add a supplemental alignment
                              [32m[Default: 20].[0m [32m[0m
[0m[32m-s Int, --slop=Int[0m            [36mThe number of bases of slop to allow when determining which records to track for the left
                              or right side of an aligned segment when merging segments. [32m[Default: 5].[0m
                              [32m[0m
[0m[32m-t FilePath, --targets-bed=FilePath[0m
                              [36mOptional bed file of target regions [32m[Optional].[0m [32m[0m
[0m[32m-T Requirement, --targets-bed-requirement=Requirement[0m
                              [36mRequirement on if each side of the breakpoint must overlap a target. Will always annotate
                              each side of the breakpoint. [32m[Default: AnnotateOnly].[0m [32mOptions:
                              AnnotateOnly, OverlapAny, OverlapBoth.[0m
[0m
[1m[31mException: UserException
Error: Argument 'input' is required.[0m
```


## fgsv_AggregateSvPileupToBedPE

### Tool Description
Convert the output of AggregateSvPileup to BEDPE.

### Metadata
- **Docker Image**: quay.io/biocontainers/fgsv:0.2.1--hdfd78af_1
- **Homepage**: https://github.com/fulcrumgenomics/fgsv
- **Package**: https://anaconda.org/channels/bioconda/packages/fgsv/overview
- **Validation**: PASS

### Original Help Text
```text
Feb 25, 2026 1:42:09 AM com.intel.gkl.NativeLibraryLoader load
INFO: Loading libgkl_compression.so from jar:file:/usr/local/share/fgsv/fgsv.jar!/com/intel/gkl/native/libgkl_compression.so
[31mUSAGE:[0m [1m[31mfgsv[0m [31m[fgsv arguments] [command name] [command arguments][0m
[31mVersion: 0.2.1[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[31m
[1m[31mfgsv[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--async-io[[=true|false]][0m     [36mUse asynchronous I/O where possible, e.g. for SAM and BAM files. [32m[Default:
                              false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m--compression=Int[0m             [36mDefault GZIP compression level, BAM compression level. [32m[Default: 5].[0m [32m[0m
[0m[32m--tmp-dir=DirPath[0m             [36mDirectory to use for temporary files. [32m[Default: /tmp].[0m [32m[0m
[0m[32m--log-level=LogLevel[0m          [36mMinimum severity log-level to emit. [32m[Default: Info].[0m [32mOptions: Debug, Info,
                              Warning, Error, Fatal.[0m
[0m[32m--sam-validation-stringency=ValidationStringency[0m
                              [36mValidation stringency for SAM/BAM reading. [32m[Default: SILENT].[0m [32mOptions:
                              STRICT, LENIENT, SILENT.[0m
[0m
[1m[31mAggregateSvPileupToBedPE[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mConvert the output of AggregateSvPileup to BEDPE.
[0m[31m
[1m[31mAggregateSvPileupToBedPE[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i FilePath, --input=FilePath[0m [36mInput text file of aggregate pileups generated by AggregateSvPileup [32m[0m
[0m[33m-o FilePath, --output=FilePath[0m[36mOutput text file of the aggregate pileups in BEDPE format. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m
[1m[31mException: UserException
Error: Argument 'input' is required.[0m
```


## Metadata
- **Skill**: generated
