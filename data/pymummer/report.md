# pymummer CWL Generation Report

## pymummer_nucmer

### Tool Description
nucmer generates nucleotide alignments between two mutli-FASTA input files. The out.delta output file lists the distance between insertions and deletions that produce maximal scoring alignments between each sequence. The show-* utilities know how to read this format.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymummer:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/pymummer
- **Package**: https://anaconda.org/channels/bioconda/packages/pymummer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pymummer/overview
- **Total Downloads**: 65.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/pymummer
- **Stars**: N/A
### Original Help Text
```text
USAGE: nucmer  [options]  <Reference>  <Query>

  DESCRIPTION:
    nucmer generates nucleotide alignments between two mutli-FASTA input
    files. The out.delta output file lists the distance between insertions
    and deletions that produce maximal scoring alignments between each
    sequence. The show-* utilities know how to read this format.

  MANDATORY:
    Reference       Set the input reference multi-FASTA filename
    Query           Set the input query multi-FASTA filename

  OPTIONS:
    --mum           Use anchor matches that are unique in both the reference
                    and query
    --mumcand       Same as --mumreference
    --mumreference  Use anchor matches that are unique in in the reference
                    but not necessarily unique in the query (default behavior)
    --maxmatch      Use all anchor matches regardless of their uniqueness

    -b|breaklen     Set the distance an alignment extension will attempt to
                    extend poor scoring regions before giving up (default 200)
    --[no]banded    Enforce absolute banding of dynamic programming matrix
                    based on diagdiff parameter EXPERIMENTAL (default no)
    -c|mincluster   Sets the minimum length of a cluster of matches (default 65)
    --[no]delta     Toggle the creation of the delta file (default --delta)
    --depend        Print the dependency information and exit
    -D|diagdiff     Set the maximum diagonal difference between two adjacent
                    anchors in a cluster (default 5)
    -d|diagfactor   Set the maximum diagonal difference between two adjacent
                    anchors in a cluster as a differential fraction of the gap
                    length (default 0.12)
    --[no]extend    Toggle the cluster extension step (default --extend)
    -f
    --forward       Use only the forward strand of the Query sequences
    -g|maxgap       Set the maximum gap between two adjacent matches in a
                    cluster (default 90)
    -h
    --help          Display help information and exit
    -l|minmatch     Set the minimum length of a single match (default 20)
    -o
    --coords        Automatically generate the original NUCmer1.1 coords
                    output file using the 'show-coords' program
    --[no]optimize  Toggle alignment score optimization, i.e. if an alignment
                    extension reaches the end of a sequence, it will backtrack
                    to optimize the alignment score instead of terminating the
                    alignment at the end of the sequence (default --optimize)
    -p|prefix       Set the prefix of the output files (default "out")
    -r
    --reverse       Use only the reverse complement of the Query sequences
    --[no]simplify  Simplify alignments by removing shadowed clusters. Turn
                    this option off if aligning a sequence to itself to look
                    for repeats (default --simplify)
    -V
    --version       Display the version information and exit
```


## pymummer_delta-filter

### Tool Description
Reads a delta alignment file from either nucmer or promer and filters the alignments based on the command-line switches, leaving only the desired alignments which are output to stdout in the same delta format as the input.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymummer:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/pymummer
- **Package**: https://anaconda.org/channels/bioconda/packages/pymummer/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: delta-filter  [options]  <deltafile>

-1            1-to-1 alignment allowing for rearrangements
              (intersection of -r and -q alignments)
-g            1-to-1 global alignment not allowing rearrangements
-h            Display help information
-i float      Set the minimum alignment identity [0, 100], default 0
-l int        Set the minimum alignment length, default 0
-m            Many-to-many alignment allowing for rearrangements
              (union of -r and -q alignments)
-q            Maps each position of each query to its best hit in
              the reference, allowing for reference overlaps
-r            Maps each position of each reference to its best hit
              in the query, allowing for query overlaps
-u float      Set the minimum alignment uniqueness, i.e. percent of
              the alignment matching to unique reference AND query
              sequence [0, 100], default 0
-o float      Set the maximum alignment overlap for -r and -q options
              as a percent of the alignment length [0, 100], default 100

  Reads a delta alignment file from either nucmer or promer and
filters the alignments based on the command-line switches, leaving
only the desired alignments which are output to stdout in the same
delta format as the input. For multiple switches, order of operations
is as follows: -i -l -u -q -r -g -m -1. If an alignment is excluded
by a preceding operation, it will be ignored by the succeeding
operations.
  An important distinction between the -g option and the -1 and -m
options is that -g requires the alignments to be mutually consistent
in their order, while the -1 and -m options are not required to be
mutually consistent and therefore tolerate translocations,
inversions, etc. In general cases, the -m option is the best choice,
however -1 can be handy for applications such as SNP finding which
require a 1-to-1 mapping. Finally, for mapping query contigs, or
sequencing reads, to a reference genome, use -q.
```


## pymummer_show-coords

### Tool Description
Output is to stdout, and consists of a list of coordinates, percent identity, and other useful information regarding the alignment data contained in the .delta file used as input.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymummer:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/pymummer
- **Package**: https://anaconda.org/channels/bioconda/packages/pymummer/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: show-coords  [options]  <deltafile>

-b          Merges overlapping alignments regardless of match dir
            or frame and does not display any idenitity information.
-B          Switch output to btab format
-c          Include percent coverage information in the output
-d          Display the alignment direction in the additional
            FRM columns (default for promer)
-g          Deprecated option. Please use 'delta-filter' instead
-h          Display help information
-H          Do not print the output header
-I float    Set minimum percent identity to display
-k          Knockout (do not display) alignments that overlap
            another alignment in a different frame by more than 50%
            of their length, AND have a smaller percent similarity
            or are less than 75% of the size of the other alignment
            (promer only)
-l          Include the sequence length information in the output
-L long     Set minimum alignment length to display
-o          Annotate maximal alignments between two sequences, i.e.
            overlaps between reference and query sequences
-q          Sort output lines by query IDs and coordinates
-r          Sort output lines by reference IDs and coordinates
-T          Switch output to tab-delimited format

  Input is the .delta output of either the "nucmer" or the
"promer" program passed on the command line.
  Output is to stdout, and consists of a list of coordinates,
percent identity, and other useful information regarding the
alignment data contained in the .delta file used as input.
  NOTE: No sorting is done by default, therefore the alignments
will be ordered as found in the <deltafile> input.
```


## pymummer_show-snps

### Tool Description
Output is to stdout, and consists of a list of SNPs (or amino acid substitutions for promer) with positions and other useful info.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymummer:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/pymummer
- **Package**: https://anaconda.org/channels/bioconda/packages/pymummer/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: show-snps  [options]  <deltafile>

-C            Do not report SNPs from alignments with an ambiguous
              mapping, i.e. only report SNPs where the [R] and [Q]
              columns equal 0 and do not output these columns
-h            Display help information
-H            Do not print the output header
-I            Do not report indels
-l            Include sequence length information in the output
-q            Sort output lines by query IDs and SNP positions
-r            Sort output lines by reference IDs and SNP positions
-S            Specify which alignments to report by passing
              'show-coords' lines to stdin
-T            Switch to tab-delimited format
-x int        Include x characters of surrounding SNP context in the
              output, default 0

  Input is the .delta output of either the nucmer or promer program
passed on the command line.
  Output is to stdout, and consists of a list of SNPs (or amino acid
substitutions for promer) with positions and other useful info.
Output will be sorted with -r by default and the [BUFF] column will
always refer to the sequence whose positions have been sorted. This
value specifies the distance from this SNP to the nearest mismatch
(end of alignment, indel, SNP, etc) in the same alignment, while the
[DIST] column specifies the distance from this SNP to the nearest
sequence end. SNPs for which the [R] and [Q] columns are greater than
0 should be evaluated with caution, as these columns specify the
number of other alignments which overlap this position. Use -C to
assure SNPs are only reported from unique alignment regions.
```

