# bamtools CWL Generation Report

## bamtools_convert

### Tool Description
converts BAM to a number of other formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamtools:2.5.3--he132191_0
- **Homepage**: https://github.com/pezmaster31/bamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bamtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamtools/overview
- **Total Downloads**: 574.2K
- **Last updated**: 2025-05-18
- **GitHub**: https://github.com/pezmaster31/bamtools
- **Stars**: N/A
### Original Help Text
```text
Description: converts BAM to a number of other formats.

Usage: bamtools convert -format <FORMAT> [-in <filename> -in <filename> ... | -list <filelist>] [-out <filename>] [-region <REGION>] [format-specific options]

Input & Output:
  -in <BAM filename>                the input BAM file(s) [stdin]
  -list <filename>                  the input BAM file list, one
                                    line per file
  -out <BAM filename>               the output BAM file [stdout]
  -format <FORMAT>                  the output file format - see
                                    README for recognized formats
  -region <REGION>                  genomic region. Index file is
                                    recommended for better performance, and is
                                    used automatically if it exists. See
                                    'bamtools help index' for more details on
                                    creating one

Pileup Options:
  -fasta <FASTA filename>           FASTA reference file
  -mapqual                          print the mapping qualities

SAM Options:
  -noheader                         omit the SAM header from
                                    output

Help:
  --help, -h                        shows this help text
```


## bamtools_count

### Tool Description
prints number of alignments in BAM file(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/bamtools:2.5.3--he132191_0
- **Homepage**: https://github.com/pezmaster31/bamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bamtools/overview
- **Validation**: PASS

### Original Help Text
```text
Description: prints number of alignments in BAM file(s).

Usage: bamtools count [-in <filename> -in <filename> ... | -list <filelist>] [-region <REGION>]

Input & Output:
  -in <BAM filename>                the input BAM file(s) [stdin]
  -list <filename>                  the input BAM file list, one
                                    line per file
  -region <REGION>                  genomic region. Index file is
                                    recommended for better performance, and is
                                    used automatically if it exists. See
                                    'bamtools help index' for more details on
                                    creating one

Help:
  --help, -h                        shows this help text
```


## bamtools_coverage

### Tool Description
prints coverage data for a single BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamtools:2.5.3--he132191_0
- **Homepage**: https://github.com/pezmaster31/bamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bamtools/overview
- **Validation**: PASS

### Original Help Text
```text
Description: prints coverage data for a single BAM file.

Usage: bamtools coverage [-in <filename>] [-out <filename>]

Input & Output:
  -in <BAM filename>                the input BAM file [stdin]
  -out <filename>                   the output file [stdout]

Help:
  --help, -h                        shows this help text
```


## bamtools_filter

### Tool Description
filters BAM file(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/bamtools:2.5.3--he132191_0
- **Homepage**: https://github.com/pezmaster31/bamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bamtools/overview
- **Validation**: PASS

### Original Help Text
```text
Description: filters BAM file(s).

Usage: bamtools filter [-in <filename> -in <filename> ... | -list <filelist>] [-out <filename> | [-forceCompression]] [-region <REGION>] [ [-script <filename] | [filterOptions] ]

Input & Output:
  -in <BAM filename>                the input BAM file(s) [stdin]
  -list <filename>                  the input BAM file list, one
                                    line per file
  -out <BAM filename>               the output BAM file [stdout]
  -region <REGION>                  only read data from this
                                    genomic region (see documentation for more
                                    details)
  -script <filename>                the filter script file (see
                                    documentation for more details)
  -forceCompression                 if results are sent to stdout
                                    (like when piping to another tool),
                                    default behavior is to leave output
                                    uncompressed. Use this flag to override
                                    and force compression

General Filters:
  -alignmentFlag <int>              keep reads with this *exact*
                                    alignment flag (for more detailed queries,
                                    see below)
  -insertSize <int>                 keep reads with insert size
                                    that matches pattern
  -length <int>                     keep reads with length that
                                    matches pattern
  -mapQuality <[0-255]>             keep reads with map quality
                                    that matches pattern
  -name <string>                    keep reads with name that
                                    matches pattern
  -queryBases <string>              keep reads with motif that
                                    matches pattern
  -tag <TAG:VALUE>                  keep reads with this
                                    key=>value pair

Alignment Flag Filters:
  -isDuplicate <true/false>         keep only alignments that are
                                    marked as duplicate? [true]
  -isFailedQC <true/false>          keep only alignments that
                                    failed QC? [true]
  -isFirstMate <true/false>         keep only alignments marked as
                                    first mate? [true]
  -isMapped <true/false>            keep only alignments that were
                                    mapped? [true]
  -isMateMapped <true/false>        keep only alignments with
                                    mates that mapped [true]
  -isMateReverseStrand <true/false> keep only alignments with mate
                                    on reverse strand? [true]
  -isPaired <true/false>            keep only alignments that were
                                    sequenced as paired? [true]
  -isPrimaryAlignment <true/false>  keep only alignments marked as
                                    primary? [true]
  -isProperPair <true/false>        keep only alignments that
                                    passed PE resolution? [true]
  -isReverseStrand <true/false>     keep only alignments on
                                    reverse strand? [true]
  -isSecondMate <true/false>        keep only alignments marked as
                                    second mate? [true]
  -isSingleton <true/false>         keep only singletons [true]

Help:
  --help, -h                        shows this help text
```


## bamtools_header

### Tool Description
prints header from BAM file(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/bamtools:2.5.3--he132191_0
- **Homepage**: https://github.com/pezmaster31/bamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bamtools/overview
- **Validation**: PASS

### Original Help Text
```text
Description: prints header from BAM file(s).

Usage: bamtools header [-in <filename> -in <filename> ... | -list <filelist>]

Input & Output:
  -in <BAM filename>                the input BAM file(s) [stdin]
  -list <filename>                  the input BAM file list, one
                                    line per file

Help:
  --help, -h                        shows this help text
```


## bamtools_index

### Tool Description
creates index for BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamtools:2.5.3--he132191_0
- **Homepage**: https://github.com/pezmaster31/bamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bamtools/overview
- **Validation**: PASS

### Original Help Text
```text
Description: creates index for BAM file.

Usage: bamtools index [-in <filename>] [-bti]

Input & Output:
  -in <BAM filename>                the input BAM file [stdin]
  -bti                              create (non-standard) BamTools
                                    index file (*.bti). Default behavior is to
                                    create standard BAM index (*.bai)

Help:
  --help, -h                        shows this help text
```


## bamtools_merge

### Tool Description
merges multiple BAM files into one.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamtools:2.5.3--he132191_0
- **Homepage**: https://github.com/pezmaster31/bamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bamtools/overview
- **Validation**: PASS

### Original Help Text
```text
Description: merges multiple BAM files into one.

Usage: bamtools merge [-in <filename> -in <filename> ... | -list <filelist>] [-out <filename> | [-forceCompression]] [-region <REGION>]

Input & Output:
  -in <BAM filename>                the input BAM file(s)
  -list <filename>                  the input BAM file list, one
                                    line per file
  -out <BAM filename>               the output BAM file
  -forceCompression                 if results are sent to stdout
                                    (like when piping to another tool),
                                    default behavior is to leave output
                                    uncompressed. Use this flag to override
                                    and force compression
  -region <REGION>                  genomic region. See README for
                                    more details

Help:
  --help, -h                        shows this help text
```


## bamtools_random

### Tool Description
grab a random subset of alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamtools:2.5.3--he132191_0
- **Homepage**: https://github.com/pezmaster31/bamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bamtools/overview
- **Validation**: PASS

### Original Help Text
```text
Description: grab a random subset of alignments.

Usage: bamtools random [-in <filename> -in <filename> ... | -list <filelist>] [-out <filename>] [-forceCompression] [-n] [-region <REGION>]

Input & Output:
  -in <BAM filename>                the input BAM file [stdin]
  -list <filename>                  the input BAM file list, one
                                    line per file
  -out <BAM filename>               the output BAM file [stdout]
  -region <REGION>                  only pull random alignments
                                    from within this genomic region. Index
                                    file is recommended for better
                                    performance, and is used automatically if
                                    it exists. See 'bamtools help index' for
                                    more details on creating one
  -forceCompression                 if results are sent to stdout
                                    (like when piping to another tool),
                                    default behavior is to leave output
                                    uncompressed. Use this flag to override
                                    and force compression

Settings:
  -n <count>                        number of alignments to grab.
                                    Note - no duplicate checking is performed
                                    [10000]
  -seed <unsigned integer>          random number generator seed
                                    (for repeatable results). Current time is
                                    used if no seed value is provided.

Help:
  --help, -h                        shows this help text
```


## bamtools_resolve

### Tool Description
resolves paired-end reads (marking the IsProperPair flag as needed).

### Metadata
- **Docker Image**: quay.io/biocontainers/bamtools:2.5.3--he132191_0
- **Homepage**: https://github.com/pezmaster31/bamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bamtools/overview
- **Validation**: PASS

### Original Help Text
```text
Description: resolves paired-end reads (marking the IsProperPair flag as needed).

Usage: bamtools resolve <mode> [options] [-in <filename>] [-out <filename> | [-forceCompression] ] [-stats <filename>]

Input & Output:
  -in <BAM filename>                the input BAM file(s) [stdin]
  -out <BAM filename>               the output BAM file [stdout]
  -stats <STATS filename>           input/output stats file,
                                    depending on selected mode (see below).
                                    This file is human-readable, storing
                                    fragment length data generated per read
                                    group, as well as the options used to
                                    configure the -makeStats mode
  -forceCompression                 if results are sent to stdout
                                    (like when piping to another tool),
                                    default behavior is to leave output
                                    uncompressed.Use this flag to override and
                                    force compression. This feature is
                                    disabled in -makeStats mode.

Resolve Modes (must select ONE of the following):
  -makeStats                        generates a fragment-length
                                    stats file from the input BAM. Data is
                                    written to file specified using the -stats
                                    option. MarkPairs Mode Settings are
                                    DISABLED.
  -markPairs                        generates an output BAM with
                                    alignments marked with proper-pair status.
                                    Stats data is read from file specified
                                    using the -stats option. MakeStats Mode
                                    Settings are DISABLED
  -twoPass                          combines the -makeStats &
                                    -markPairs modes into a single command.
                                    However, due to the two-pass nature of
                                    paired-end resolution, piping BAM data via
                                    stdin is DISABLED. You must supply an
                                    explicit input BAM file. Output BAM may be
                                    piped to stdout, however, if desired. All
                                    MakeStats & MarkPairs Mode Settings are
                                    available. The intermediate stats file is
                                    not necessary, but if the -stats options
                                    is used, then one will be generated. You
                                    may find this useful for documentation
                                    purposes.

General Resolve Options (available in all modes):
  -minMQ <unsigned short>           minimum map quality. Used in
                                    -makeStats mode as a heuristic for
                                    determining a mate's uniqueness. Used in
                                    -markPairs mode as a filter for marking
                                    candidate proper pairs.

MakeStats Mode Options (disabled in -markPairs mode):
  -ci <double>                      confidence interval. Set
                                    min/max fragment lengths such that we
                                    capture this fraction of pairs
  -umt <double>                     unused model threshold. The
                                    resolve tool considers 8 possible
                                    orientation models for pairs. The top 2
                                    are selected for later use when actually
                                    marking alignments. This value determines
                                    the cutoff for marking a read group as
                                    ambiguous. Meaning that if the ratio of
                                    the number of alignments from bottom 6
                                    models to the top 2 is greater than this
                                    threshold, then the read group is flagged
                                    as ambiguous. By default, NO alignments
                                    from ambiguous read groups will be marked
                                    as proper pairs. You may override this
                                    behavior with the -force option in
                                    -markPairs mode

MarkPairs Mode Options (disabled in -makeStats mode):
  -force                            forces all read groups to be
                                    marked according to their top 2
                                    'orientation models'. When generating
                                    stats, the 2 (out of 8 possible) models
                                    with the most observations are chosen as
                                    the top models for each read group. If the
                                    remaining 6 models account for more than
                                    some threshold ([default=10%], see -umt),
                                    then the read group is marked as
                                    ambiguous. The default behavior is that
                                    for an ambiguous read group, NONE of its
                                    alignments are marked as proper-pairs. By
                                    setting this option, a read group's
                                    ambiguity flag will be ignored, and all of
                                    its alignments will be compared to the top
                                    2 models.

Help:
  --help, -h                        shows this help text
```


## bamtools_revert

### Tool Description
removes duplicate marks and restores original (non-recalibrated) base qualities.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamtools:2.5.3--he132191_0
- **Homepage**: https://github.com/pezmaster31/bamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bamtools/overview
- **Validation**: PASS

### Original Help Text
```text
Description: removes duplicate marks and restores original (non-recalibrated) base qualities.

Usage: bamtools revert [-in <filename> -in <filename> ...] [-out <filename> | [-forceCompression]] [revertOptions]

Input & Output:
  -in <BAM filename>                the input BAM file [stdin]
  -out <BAM filename>               the output BAM file [stdout]
  -forceCompression                 if results are sent to stdout
                                    (like when piping to another tool),
                                    default behavior is to leave output
                                    uncompressed. Use this flag to override
                                    and force compression

Revert Options:
  -keepDuplicate                    keep duplicates marked
  -keepQualities                    keep base qualities (do not
                                    replace with OQ contents)

Help:
  --help, -h                        shows this help text
```


## bamtools_sort

### Tool Description
sorts a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamtools:2.5.3--he132191_0
- **Homepage**: https://github.com/pezmaster31/bamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bamtools/overview
- **Validation**: PASS

### Original Help Text
```text
Description: sorts a BAM file.

Usage: bamtools sort [-in <filename>] [-out <filename>] [sortOptions]

Input & Output:
  -in <BAM filename>                the input BAM file [stdin]
  -out <BAM filename>               the output BAM file [stdout]

Sorting Methods:
  -byname                           sort by alignment name

Memory Settings:
  -n <count>                        max number of alignments per
                                    tempfile [500000]
  -mem <Mb>                         max memory to use [1024]

Help:
  --help, -h                        shows this help text
```


## bamtools_split

### Tool Description
splits a BAM file on user-specified property, creating a new BAM output file for each value found.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamtools:2.5.3--he132191_0
- **Homepage**: https://github.com/pezmaster31/bamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bamtools/overview
- **Validation**: PASS

### Original Help Text
```text
Description: splits a BAM file on user-specified property, creating a new BAM output file for each value found.

Usage: bamtools split [-in <filename>] [-stub <filename stub>] < -mapped | -paired | -reference [-refPrefix <prefix>] | -tag <TAG> > 

Input & Output:
  -in <BAM filename>                the input BAM file [stdin]
  -refPrefix <string>               custom prefix for splitting by
                                    references. Currently files end with
                                    REF_<refName>.bam. This option allows you
                                    to replace "REF_" with a prefix of your
                                    choosing.
  -tagPrefix <string>               custom prefix for splitting by
                                    tags. Current files end with
                                    TAG_<tagname>_<tagvalue>.bam. This option
                                    allows you to replace "TAG_" with a prefix
                                    of your choosing.
  -stub <filename stub>             prefix stub for output BAM
                                    files (default behavior is to use input
                                    filename, without .bam extension, as
                                    stub). If input is stdin and no stub
                                    provided, a timestamp is generated as the
                                    stub.
  -tagListDelim <string>            delimiter used to separate
                                    values in the filenames generated from
                                    splitting on list-type tags [--]

Split Options:
  -mapped                           split mapped/unmapped
                                    alignments
  -paired                           split single-end/paired-end
                                    alignments
  -reference                        split alignments by reference
  -tag <tag name>                   splits alignments based on all
                                    values of TAG encountered (i.e. -tag RG
                                    creates a BAM file for each read group in
                                    original BAM file)

Help:
  --help, -h                        shows this help text
```


## bamtools_stats

### Tool Description
prints general alignment statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamtools:2.5.3--he132191_0
- **Homepage**: https://github.com/pezmaster31/bamtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bamtools/overview
- **Validation**: PASS

### Original Help Text
```text
Description: prints general alignment statistics.

Usage: bamtools stats [-in <filename> -in <filename> ... | -list <filelist>] [statsOptions]

Input & Output:
  -in <BAM filename>                the input BAM file [stdin]
  -list <filename>                  the input BAM file list, one
                                    line per file

Additional Stats:
  -insert                           summarize insert size data

Help:
  --help, -h                        shows this help text
```


## Metadata
- **Skill**: not generated
