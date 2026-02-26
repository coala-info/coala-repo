# calitas CWL Generation Report

## calitas_AlignToReference

### Tool Description
Performs glocal alignment of query sequence to a window on the reference. Input should be a tab-delimited file with the following columns (with headers):

  * id: the ID of the query sequence; optional - if not present the sequence itself is used
  * query: the query sequence to be aligned
  * chrom: the chromosome to align to
  * position: the center of the window to align the query to

The query sequence may be a mixture of upper and lower case sequence. The lower case sequence (generally used for the
PAM sequence) is scored differently than upper-case sequence, with higher match and mismatch values, to make mismatches
in lower-case regions less common.

If all three of '--max-guide-diffs', '--max-pam-mismatches' and '--max-overlap' are specified then all alignments that
meet the given criteria for a query will be emitted. If none of the three parameters are provided, the single best
alignment of each query will be reported. If some but not all three parameters are specified then an error will be
generated.

The '--window-size' parameter can be used to control the size of the window (centered on the position given for each
query) that the queries will be aligned to. E.g. if a window size of 60bp is given, the target sequence is position +/- 
30bp. If '--window-size' is not given, it will be defaulted to 2 * length(query) for each query.

### Metadata
- **Docker Image**: quay.io/biocontainers/calitas:1.0--hdfd78af_1
- **Homepage**: https://github.com/editasmedicine/calitas
- **Package**: https://anaconda.org/channels/bioconda/packages/calitas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/calitas/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/editasmedicine/calitas
- **Stars**: N/A
### Original Help Text
```text
[31mUSAGE:[0m [1m[31mcalitas[0m [31m[calitas arguments] [command name] [command arguments][0m
[31mVersion: 20210222-6ef8fef[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[31m
[1m[31mcalitas[0m [31mArguments:[0m
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
                              [36mValidation stringency for SAM/BAM reading. [32m[Optional].[0m [32mOptions: STRICT,
                              LENIENT, SILENT.[0m
[0m
[1m[31mAlignToReference[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mPerforms glocal alignment of query sequence to a window on the reference. Input should be a tab-delimited file with the
following columns (with headers):

  * id: the ID of the query sequence; optional - if not present the sequence itself is used
  * query: the query sequence to be aligned
  * chrom: the chromosome to align to
  * position: the center of the window to align the query to

The query sequence may be a mixture of upper and lower case sequence. The lower case sequence (generally used for the
PAM sequence) is scored differently than upper-case sequence, with higher match and mismatch values, to make mismatches
in lower-case regions less common.

If all three of '--max-guide-diffs', '--max-pam-mismatches' and '--max-overlap' are specified then all alignments that
meet the given criteria for a query will be emitted. If none of the three parameters are provided, the single best
alignment of each query will be reported. If some but not all three parameters are specified then an error will be
generated.

The '--window-size' parameter can be used to control the size of the window (centered on the position given for each
query) that the queries will be aligned to. E.g. if a window size of 60bp is given, the target sequence is position +/-
30bp. If '--window-size' is not given, it will be defaulted to 2 * length(query) for each query.
[0m[31m
[1m[31mAlignToReference[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i FilePath, --input=FilePath[0m [36mInput file of sequence queries and approximate positions. [32m[0m
[0m[33m-r PathToFasta, --ref=PathToFasta[0m
                              [36mReference genome fasta, must be indexed with faidx. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-o FilePath, --output=FilePath[0m[36mOutput file to write. [32m[Default: /dev/stdout].[0m [32m[0m
[0m[32m-w Int, --window-size=Int[0m     [36mWindow size to align to. [32m[Optional].[0m [32m[0m
[0m[32m-d Int, --max-guide-diffs=Int[0m [36mMaximum number of differences (mms+gaps) between guide and genome. [32m[Optional].[0m
                              [32m[0m
[0m[32m-p Int, --max-pam-mismatches=Int[0m
                              [36mMaximum mismatches in the PAM. [32m[Optional].[0m [32m[0m
[0m[32m-g Int, --max-gaps-between-guide-and-pam=Int[0m
                              [36mMaximum gap bases between guide and PAM [32m[Default: 3].[0m [32m[0m
[0m[32m-D Int, --max-total-diffs=Int[0m [36mMaximum total diffs in alignments. [32m[Optional].[0m [32m[0m
[0m[32m-O Int, --max-overlap=Int[0m     [36mMaximum overlap allowed between alignments on the same strand. [32m[Optional].[0m
                              [32m[0m
[0m[32m-m Int, --guide-mismatch-net-cost=Int[0m
                              [36mNet cost of going from a match to a mismatch in the guide. [32m[Default: -120].[0m
                              [32m[0m
[0m[32m-M Int, --pam-mismatch-net-cost=Int[0m
                              [36mNet cost of going from a match to a mismatch in the PAM. [32m[Default: -260].[0m
                              [32m[0m
[0m[32m-b Int, --genome-gap-net-cost=Int[0m
                              [36mNet cost of a 1bp gap in the genome. [32m[Default: -122].[0m [32m[0m
[0m[32m-B Int, --guide-gap-net-cost=Int[0m
                              [36mNet cost of a 1bp gap in the guide. [32m[Default: -121].[0m [32m[0m
[0m[32m-t Int, --threads=Int[0m         [36mThreads to use for alignments. [32m[Default: 8].[0m [32m[0m
[0m
[1m[31mException: UserException
Error: Argument 'input' is required.[0m
```


## calitas_PairwiseAlignSequences

### Tool Description
Performs pairwise alignment of sequences. Input is a file with two sequences per line, separated by whitespace.
Sequences may be composed of DNA and RNA bases and ambiguity codes. No headers are required or expected.

Designed for performing glocal alignment of guides to larger sequences (i.e. global alignment of the query to a local
portion of the target.)

The query sequence may be a mixture of upper and lower case sequence, with lower-case bases used for the PAM at one end
of the sequence or the other.

The target sequences (second on each line) should be all upper case and will be made upper-case if they are not
already.

### Metadata
- **Docker Image**: quay.io/biocontainers/calitas:1.0--hdfd78af_1
- **Homepage**: https://github.com/editasmedicine/calitas
- **Package**: https://anaconda.org/channels/bioconda/packages/calitas/overview
- **Validation**: PASS

### Original Help Text
```text
[31mUSAGE:[0m [1m[31mcalitas[0m [31m[calitas arguments] [command name] [command arguments][0m
[31mVersion: 20210222-6ef8fef[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[31m
[1m[31mcalitas[0m [31mArguments:[0m
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
                              [36mValidation stringency for SAM/BAM reading. [32m[Optional].[0m [32mOptions: STRICT,
                              LENIENT, SILENT.[0m
[0m
[1m[31mPairwiseAlignSequences[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mPerforms pairwise alignment of sequences. Input is a file with two sequences per line, separated by whitespace.
Sequences may be composed of DNA and RNA bases and ambiguity codes. No headers are required or expected.

Designed for performing glocal alignment of guides to larger sequences (i.e. global alignment of the query to a local
portion of the target.)

The query sequence may be a mixture of upper and lower case sequence, with lower-case bases used for the PAM at one end
of the sequence or the other.

The target sequences (second on each line) should be all upper case and will be made upper-case if they are not
already.
[0m[31m
[1m[31mPairwiseAlignSequences[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i FilePath, --input=FilePath[0m [36mInput file of sequence pairs. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-o FilePath, --output=FilePath[0m[36mOutput file to write. [32m[Default: /dev/stdout].[0m [32m[0m
[0m[32m-t Int, --threads=Int[0m         [36mThreads to use for alignments. [32m[Default: 8].[0m [32m[0m
[0m[32m-g Int, --max-gaps-between-guide-and-pam=Int[0m
                              [36mMaximum gap bases between guide and PAM [32m[Default: 3].[0m [32m[0m
[0m[32m-O Int, --max-overlap=Int[0m     [36mMaximum overlap allowed between alignments on the same strand. [32m[Default: 10].[0m
                              [32m[0m
[0m[32m-m Int, --guide-mismatch-net-cost=Int[0m
                              [36mNet cost of going from a match to a mismatch in the guide. [32m[Default: -120].[0m
                              [32m[0m
[0m[32m-M Int, --pam-mismatch-net-cost=Int[0m
                              [36mNet cost of going from a match to a mismatch in the PAM. [32m[Default: -260].[0m
                              [32m[0m
[0m[32m-b Int, --genome-gap-net-cost=Int[0m
                              [36mNet cost of a 1bp gap in the genomic/target sequence. [32m[Default: -122].[0m [32m[0m
[0m[32m-B Int, --guide-gap-net-cost=Int[0m
                              [36mNet cost of a 1bp gap in the guide. [32m[Default: -121].[0m [32m[0m
[0m
[1m[31mException: UserException
Error: Argument 'input' is required.[0m
```


## calitas_PrepareVcf

### Tool Description
Prepares a VCF for optimal use by SearchReference. Does the following:

  * Removes variants and alleles below an allele frequency threshold
  * Remove all INFO fields except for allele-frequency
  * Removes any genotypes that are present
  * Optionally fixes up the contig lines in the VCF
  * Optionally adds 'chr' prefixes to chromosome names 1-22, X and Y

Multiple input VCFs can be given but they must be disjoint (i.e. not have variants over the same regions of the
genome), and wil be merged to create a single output VCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/calitas:1.0--hdfd78af_1
- **Homepage**: https://github.com/editasmedicine/calitas
- **Package**: https://anaconda.org/channels/bioconda/packages/calitas/overview
- **Validation**: PASS

### Original Help Text
```text
[31mUSAGE:[0m [1m[31mcalitas[0m [31m[calitas arguments] [command name] [command arguments][0m
[31mVersion: 20210222-6ef8fef[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[31m
[1m[31mcalitas[0m [31mArguments:[0m
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
                              [36mValidation stringency for SAM/BAM reading. [32m[Optional].[0m [32mOptions: STRICT,
                              LENIENT, SILENT.[0m
[0m
[1m[31mPrepareVcf[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mPrepares a VCF for optimal use by SearchReference. Does the following:

  * Removes variants and alleles below an allele frequency threshold
  * Remove all INFO fields except for allele-frequency
  * Removes any genotypes that are present
  * Optionally fixes up the contig lines in the VCF
  * Optionally adds 'chr' prefixes to chromosome names 1-22, X and Y

Multiple input VCFs can be given but they must be disjoint (i.e. not have variants over the same regions of the
genome), and wil be merged to create a single output VCF.
[0m[31m
[1m[31mPrepareVcf[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i PathToVcf+, --input=PathToVcf+[0m
                              [36mOne or more input VCFs [32m[0m
[0m[33m-o PathToVcf, --output=PathToVcf[0m
                              [36mThe output VCF to create. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-f Double, --min-af=Double[0m    [36mThe minimum allele frequency of variants to retain. [32m[Default: 0.01].[0m [32m[0m
[0m[32m-d FilePath, --dict=FilePath[0m  [36mAn optional sequence dictionary to use to override contig lines. [32m[Optional].[0m
                              [32m[0m
[0m[32m-c [[true|false]], --add-chr-prefix[[=true|false]][0m
                              [36mIf true, add 'chr' to chroms 1-22, X and Y. [32m[Default: true].[0m [32m[0m
[0m
[1m[31mException: MissingArgumentException
Error: Argument 'input' must be specified at least once.[0m
```


## calitas_SearchReference

### Tool Description
Searches a reference sequence for alignments of a guide+PAM.

### Metadata
- **Docker Image**: quay.io/biocontainers/calitas:1.0--hdfd78af_1
- **Homepage**: https://github.com/editasmedicine/calitas
- **Package**: https://anaconda.org/channels/bioconda/packages/calitas/overview
- **Validation**: PASS

### Original Help Text
```text
[31mUSAGE:[0m [1m[31mcalitas[0m [31m[calitas arguments] [command name] [command arguments][0m
[31mVersion: 20210222-6ef8fef[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[31m
[1m[31mcalitas[0m [31mArguments:[0m
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
                              [36mValidation stringency for SAM/BAM reading. [32m[Optional].[0m [32mOptions: STRICT,
                              LENIENT, SILENT.[0m
[0m
[1m[31mSearchReference[0m
[37m------------------------------------------------------------------------------------------------------------------------
[0m[36mSearches a reference sequence for alignments of a guide+PAM.

The search is performed in a sequential manner, first finding all candidate alignments of the guide without the PAM,
and then extending those alignments to include an optional PAM. The search may be performed without a PAM (i.e.
PAMless), with a single PAM or with multiple PAMs. When multiple PAMs are provided the first PAM must be provided as
part of the guide, with subsequent PAM being provided via '--auxillary-pams'. When extending alignments each PAM is
considered, and the extension with the best PAM alignment is retained. Best is defined by maximizing score; when scores
are equal PAMs earlier in the list will be preferred. All PAM sequences must be specified in lower case, while
protospacer sequence must be upper case. E.g.:

--guide ATCGATCGATAGACTGCATnrg --auxiliary-pams nnrg kgg
The scoring system is, by default, setup to guarantee that all alignments within the thresholds defined by a)
'--max-guide-diffs', b) '--max-pam-mismatches' and c) '--max-gaps-between-guide-and-pam', will be discovered for
reasonable values of those parameters and for query sequences of 20-40bp (i.e. common protospacer + PAM lengths). Great
care must be taken when adjusting scoring parameters in order not to void this guarantee. Scoring is controlled via
four major parameters:

  1. '--guide-mismatch-net-cost': the net cost of converting a match to a mismatch within the alignment.
  2. '--pam-mismatch-net-cost': as above, but for mismatches within the PAM
  3. '--genome-gap-net-cost': the cost of any 1bp gap in the genome (a.k.a. a 1bp bulge in the guide)
  4. '--guide-gap-net-cost': the cost of any 1bp gap in the guide (a.k.a. a 1bp bulge in the genome)

For longer gaps the cost is simply gap length multiplied by the appropriate net cost. The 'net' in each name refers to
the fact that unlike traditional aligner scores these scores factor in the possible loss of a match in addition to the
introduction of a mismatch or gap. The default values of these cost parameters are set such that mismatches are
preferred to gaps in the guide which are in turn preferred to gaps in the genome. In addition mismatches in the PAM, by
default, are slightly more than twice as expensive as mismatches in the guide. If changes to these parameters are
desired it is important that the following be true:

  min_cost = min(guide_mismatch_net_cost, guide_gap_net_cost, genome_gap_net_cost)
  max_cost = max(guide_mismatch_net_cost, guide_gap_net_cost, genome_gap_net_cost)
  (max-guide-diffs + 1) * min_cost > max-guide-diffs * max_cost

If the constraint above is violated then the aligner may prefer alignments with too many differences, and then filter
those out and as a result not report alignments that are within the bounds specified!

Care should be taken when setting the limits on mismatches and gaps. Different results will be obtained by running
with, e.g. '--max-guide-diffs=5 --max-pam-mismatches=1' and the post-filtering vs. running directly with
'--max-guide-diffs=3 --max-pam-mismatches=1'. For example, with the former settings the aligner may prefer to emit an
alignment with 4 mismatches in the guide and 0 mismatches in the PAM in preference to a competing alignment with 3
mismatches in the guide and 1 mismatch in the PAM. The latter settings will, on the other hand, emit the 3+1 mismatch
alignment. These concerns can be alleviated by setting '--max-overlap' to some value much larger than the guide length
(e.g. 100), causing all overlapping alignments to be emitted.
[0m[31m
[1m[31mSearchReference[0m [31mArguments:[0m
[0m[37m------------------------------------------------------------------------------------------------------------------------
[0m[33m-i String, --guide=String[0m     [36mGuide with PAM, PAM must be lower case. [32m[0m
[0m[33m-I String, --guide-id=String[0m  [36mID of the guide. [32m[0m
[0m[33m-r PathToFasta, --ref=PathToFasta[0m
                              [36mReference genome fasta. [32m[0m
[0m[32m-h [[true|false]], --help[[=true|false]][0m
                              [36mDisplay the help message. [32m[Default: false].[0m [32m[0m
[0m[32m--version[[=true|false]][0m      [36mDisplay the version number for this tool. [32m[Default: false].[0m [32m[0m
[0m[32m-x String*, --auxiliary-pams=String*[0m
                              [36mAdditional PAM sequences. Must be lower case. [32m[Optional].[0m [32m[0m
[0m[32m-v PathToVcf, --variants=PathToVcf[0m
                              [36mOptional VCF of variants to merge into the genome. [32m[Optional].[0m [32m[0m
[0m[32m-V Int, --max-variants=Int[0m    [36mExclude clusters of this more than this many variants. [32m[Default: 16].[0m [32m[0m
[0m[32m-o FilePath, --output=FilePath[0m[36mOutput file to write. [32m[Default: /dev/stdout].[0m [32m[0m
[0m[32m-t Int, --threads=Int[0m         [36mThreads to use for alignments. [32m[Default: 8].[0m [32m[0m
[0m[32m-w Int, --window-size=Int[0m     [36mWindow size to align to. [32m[Default: 1000].[0m [32m[0m
[0m[32m-d Int, --max-guide-diffs=Int[0m [36mMaximum number of differences (mms+gaps) between guide and genome. [32m[Default: 5].[0m
                              [32m[0m
[0m[32m-p Int, --max-pam-mismatches=Int[0m
                              [36mMaximum mismatches in the PAM. [32m[Default: 1].[0m [32m[0m
[0m[32m-g Int, --max-gaps-between-guide-and-pam=Int[0m
                              [36mMaximum gap bases between guide and PAM [32m[Default: 3].[0m [32m[0m
[0m[32m-D Int, --max-total-diffs=Int[0m [36mMaximum total diffs in alignments. [32m[Optional].[0m [32m[0m
[0m[32m-O Int, --max-overlap=Int[0m     [36mMaximum overlap allowed between alignments on the same strand. [32m[Default: 10].[0m
                              [32m[0m
[0m[32m-m Int, --guide-mismatch-net-cost=Int[0m
                              [36mNet cost of going from a match to a mismatch in the guide. [32m[Default: -120].[0m
                              [32m[0m
[0m[32m-M Int, --pam-mismatch-net-cost=Int[0m
                              [36mNet cost of going from a match to a mismatch in the PAM. [32m[Default: -260].[0m
                              [32m[0m
[0m[32m-b Int, --genome-gap-net-cost=Int[0m
                              [36mNet cost of a 1bp gap in the genome. [32m[Default: -122].[0m [32m[0m
[0m[32m-B Int, --guide-gap-net-cost=Int[0m
                              [36mNet cost of a 1bp gap in the guide. [32m[Default: -121].[0m [32m[0m
[0m[32m-c String, --chrom=String[0m     [36mExamine only the named chromosome. [32m[Optional].[0m [32m[0m
[0m
[1m[31mException: UserException
Error: Argument 'guide' is required.[0m
```

