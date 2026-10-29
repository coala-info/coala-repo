# mummer CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mummer | Failed | image problem: in mummer 3.23, -mum and -mumreference (the default) segfault or print no matches; only -maxmatch works |
| mummer_combineMUMs | PASS |  |
| mummer_delta-filter | PASS |  |
| mummer_dnadiff | PASS |  |
| mummer_exact-tandems | Failed | image problem: the script needs csh, which is not in the image (shebang '#! -f'), so it exits 127 with 'cannot execute: required file not found'. |
| mummer_mapview | PASS |  |
| mummer_mgaps | PASS |  |
| mummer_mummerplot | Failed | image problem: gnuplot is not installed in the image, so no plot image is made (only the .gp script and .fplot/.rplot data files). |
| mummer_nucmer | Failed | image problem: in mummer 3.23 the default anchors and --mum give an empty delta file or an error; only --maxmatch works (checked: 1 alignment block, correct coordinates). |
| mummer_promer | Failed | image problem: in mummer 3.23 the default anchors give an empty delta file; only --maxmatch works (checked: alignments in 6 frames with 80-95 percent identity). |
| mummer_repeat-match | PASS |  |
| mummer_run-mummer1 | Failed | image problem: the script needs csh, which is not in the image (shebang '#! -f'), so it exits 127 with 'cannot execute: required file not found'. |
| mummer_run-mummer3 | Failed | image problem: the script needs csh, which is not in the image (shebang '#! -f'), so it exits 127 with 'cannot execute: required file not found'. |
| mummer_show-aligns | PASS |  |
| mummer_show-coords | PASS |  |
| mummer_show-diff | PASS |  |
| mummer_show-snps | PASS |  |
| mummer_show-tiling | PASS |  |

## mummer

### Tool Description
Find and output (to stdout) the positions and length of all sufficiently long maximal matches of a substring in <query-file> and <reference-file>

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Total Downloads**: 145.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mummer4/mummer
- **Stars**: N/A
### Original Help Text
```text
Usage: mummer [options] <reference-file> <query-files>

Find and output (to stdout) the positions and length of all
sufficiently long maximal matches of a substring in
<query-file> and <reference-file>

Options:
-mum           compute maximal matches that are unique in both sequences
-mumcand       same as -mumreference
-mumreference  compute maximal matches that are unique in the reference-
               sequence but not necessarily in the query-sequence (default)
-maxmatch      compute all maximal matches regardless of their uniqueness
-n             match only the characters a, c, g, or t
               they can be in upper or in lower case
-l             set the minimum length of a match
               if not set, the default value is 20
-b             compute forward and reverse complement matches
-r             only compute reverse complement matches
-s             show the matching substrings
-c             report the query-position of a reverse complement match
               relative to the original query sequence
-F             force 4 column output format regardless of the number of
               reference sequence inputs
-L             show the length of the query sequences on the header line
-h             show possible options
-help          show possible options
```

## mummer_run-mummer1

### Tool Description
Run the antiquated MUMmer 1 suite on a reference and a query.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: run-mummer1 <fasta reference> <fasta query> <prefix> [-r]

**SEVERELY** antiquated script for running the mummer 1 suite
-r option reverse complements the query sequence, coordinates of the reverse
matches will be relative to the reversed sequence
```

## mummer_run-mummer3

### Tool Description
Run the basic MUMmer 3 suite (mummer, mgaps, combineMUMs) on a reference and a multi-FASTA query.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: run-mummer3 <fasta reference> <multi-fasta query> <prefix>

for running the basic mummer 3 suite, should use nucmer instead when possible
to avoid the confusing reverse coordinate system of the raw programs.

NOTE:  be warned that all reverse matches will then
be relative to the reverse complement of the query sequence.
```

## mummer_mapview

### Tool Description
Convert show-coords or mgaps alignment output into FIG, PDF or PS figures.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: mapview  [options]  <coords file>  [UTR coords]  [CDS coords]

  DESCRIPTION:
    mapview is a utility program for displaying sequence alignments as
    provided by MUMmer, NUCmer, PROmer or Mgaps. mapview takes the output of
    show-coords and converts it to a FIG, PDF or PS file for visual analysis.
    It can also break the output into multiple files for easier viewing and
    printing.

  MANDATORY:
    coords file    The output of 'show-coords -rl[k]' or 'mgaps'

  OPTIONS:
    UTR coords      UTR coordinate file in GFF format
    CDS coords      CDS coordinate file in GFF format

    -d|maxdist      Set the maximum base-pair distance between linked matches
                    (default 50000)
    -f|format       Set the output format to 'pdf', 'ps' or 'fig'
                    (default 'fig')
    -h
    --help          Display help information and exit
    -m|mag          Set the magnification at which the figure is rendered,
                    this is an option for fig2dev which is used to generate
                    the PDF and PS files (default 1.0)
    -n|num          Set the number of output files used to partition the
                    output, this is to avoid generating files that are too
                    large to display (default 10)
    -p|prefix       Set the output file prefix
                    (default "PROMER_graph or NUCMER_graph")
    -v
    --verbose       Verbose logging of the processed files
    -V
    --version       Display the version information and exit
    -x1 coord       Set the lower coordinate bound of the display
    -x2 coord       Set the upper coordinate bound of the display
    -g|ref          If the input file is provided by 'mgaps', set the
                    reference sequence ID (as it appears in the first column
                    of the UTR/CDS coords file)
    -I              Display the name of query sequences
    -Ir             Display the name of reference genes
```

## mummer_exact-tandems

### Tool Description
Find exact tandem repeats in a file involving an exact duplicate of at least the specified length.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE:  exact-tandems <file> <min-match-len>

Find exact tandem repeats in specified file involving an
exact duplicate of at least the specified length
```

## mummer_show-aligns

### Tool Description
Show the pairwise alignments between a reference and a query sequence of a delta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: show-aligns  [options]  <deltafile>  <ref ID>  <qry ID>

-h            Display help information
-q            Sort alignments by the query start coordinate
-r            Sort alignments by the reference start coordinate
-w int        Set the screen width - default is 60
-x int        Set the matrix type - default is 2 (BLOSUM 62),
              other options include 1 (BLOSUM 45) and 3 (BLOSUM 80)
              note: only has effect on amino acid alignments

  Input is the .delta output of either the "nucmer" or the
"promer" program passed on the command line.
  Output is to stdout, and consists of all the alignments between the
query and reference sequences identified on the command line.
  NOTE: No sorting is done by default, therefore the alignments
will be ordered as found in the <deltafile> input.
```

## mummer_combineMUMs

### Tool Description
Combine the MUMs in a gaps file by extending matches off ends and between MUMs.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE:  combineMUMs <RefSequence> <MatchSequences> <GapsFile>

Combines MUMs in <GapsFile> by extending matches off
ends and between MUMs.  <RefSequence> is a fasta file
of the reference sequence.  <MatchSequences> is a
multi-fasta file of the sequences matched against the
reference

Options:
-D      Only output to stdout the difference positions
          and characters
-n      Allow matches only between nucleotides, i.e., ACGTs
-N num  Break matches at <num> or more consecutive non-ACGTs 
-q tag  Used to label query match
-r tag  Used to label reference match
-S      Output all differences in strings
-t      Label query matches with query fasta header
-v num  Set verbose level for extra output
-W file Reset the default output filename witherrors.gaps
-x      Don't output .cover files
-e      Set error-rate cutoff to e (e.g. 0.02 is two percent)
```

## mummer_dnadiff

### Tool Description
Run a comparative analysis of two sequence sets using nucmer and its associated utilities with recommended parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: dnadiff  [options]  <reference>  <query>
    or   dnadiff  [options]  -d <delta file>

  DESCRIPTION:
    Run comparative analysis of two sequence sets using nucmer and its
    associated utilities with recommended parameters. See MUMmer
    documentation for a more detailed description of the
    output. Produces the following output files:

    .report  - Summary of alignments, differences and SNPs
    .delta   - Standard nucmer alignment output
    .1delta  - 1-to-1 alignment from delta-filter -1
    .mdelta  - M-to-M alignment from delta-filter -m
    .1coords - 1-to-1 coordinates from show-coords -THrcl .1delta
    .mcoords - M-to-M coordinates from show-coords -THrcl .mdelta
    .snps    - SNPs from show-snps -rlTHC .1delta
    .rdiff   - Classified ref breakpoints from show-diff -rH .mdelta
    .qdiff   - Classified qry breakpoints from show-diff -qH .mdelta
    .unref   - Unaligned reference IDs and lengths (if applicable)
    .unqry   - Unaligned query IDs and lengths (if applicable)

  MANDATORY:
    reference       Set the input reference multi-FASTA filename
    query           Set the input query multi-FASTA filename
      or
    delta file      Unfiltered .delta alignment file from nucmer

  OPTIONS:
    -d|delta        Provide precomputed delta file for analysis
    -h
    --help          Display help information and exit
    -p|prefix       Set the prefix of the output files (default "out")
    -V
    --version       Display the version information and exit
```

## mummer_promer

### Tool Description
Generate amino acid alignments between two multi-FASTA DNA files and write a delta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: promer  [options]  <Reference>  <Query>

  DESCRIPTION:
    promer generates amino acid alignments between two mutli-FASTA DNA input
    files. The out.delta output file lists the distance between insertions
    and deletions that produce maximal scoring alignments between each
    sequence. The show-* utilities know how to read this format. The DNA
    input is translated into all 6 reading frames in order to generate the
    output, but the output coordinates reference the original DNA input.

  MANDATORY:
    Reference       Set the input reference multi-FASTA DNA file
    Query           Set the input query multi-FASTA DNA file

  OPTIONS:
    --mum           Use anchor matches that are unique in both the reference
                    and query
    --mumcand       Same as --mumreference
    --mumreference  Use anchor matches that are unique in in the reference
                    but not necessarily unique in the query (default behavior)
    --maxmatch      Use all anchor matches regardless of their uniqueness

    -b|breaklen     Set the distance an alignment extension will attempt to
                    extend poor scoring regions before giving up, measured in
                    amino acids (default 60)
    -c|mincluster   Sets the minimum length of a cluster of matches, measured in
                    amino acids (default 20)
    --[no]delta     Toggle the creation of the delta file (default --delta)
    --depend        Print the dependency information and exit
    -d|diagfactor   Set the clustering diagonal difference separation factor
                    (default .11)
    --[no]extend    Toggle the cluster extension step (default --extend)
    -g|maxgap       Set the maximum gap between two adjacent matches in a
                    cluster, measured in amino acids (default 30)
    -h
    --help          Display help information and exit.
    -l|minmatch     Set the minimum length of a single match, measured in amino
                    acids (default 6)
    -m|masklen      Set the maximum bookend masking lenth, measured in amino
                    acids (default 8)
    -o
    --coords        Automatically generate the original PROmer1.1 ".coords"
                    output file using the "show-coords" program
    --[no]optimize  Toggle alignment score optimization, i.e. if an alignment
                    extension reaches the end of a sequence, it will backtrack
                    to optimize the alignment score instead of terminating the
                    alignment at the end of the sequence (default --optimize)

    -p|prefix       Set the prefix of the output files (default "out")
    -V
    --version       Display the version information and exit
    -x|matrix       Set the alignment matrix number to 1 [BLOSUM 45], 2 [BLOSUM
                    62] or 3 [BLOSUM 80] (default 2)
```

## mummer_repeat-match

### Tool Description
Find all maximal exact matches (repeats) in a genome FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE:  repeat-match  [options]  <genome-file>

Find all maximal exact matches in <genome-file>

Options:
 -E    Use exhaustive (slow) search to find matches
 -f    Forward strand only, don't use reverse complement
 -n #  Set minimum exact match length to #
 -t    Only output tandem repeats
 -V #  Set level of verbose (debugging) printing to #
```

## mummer_nucmer

### Tool Description
Generate nucleotide alignments between two multi-FASTA files and write a delta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Validation**: PASS

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

## mummer_show-snps

### Tool Description
Report SNPs (or amino acid substitutions) and indels from a delta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
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

## mummer_mgaps

### Tool Description
Cluster MUMs based on diagonals and separation; reads mummer output from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Validation**: PASS

### Original Help Text
```text
mgaps: invalid option -- '-'
Unrecognized option --
USAGE:  mgaps [-d <DiagDiff>] [-f <DiagFactor>] [-l <MatchLen>]
        [-s <MaxSeparation>]

Clusters MUMs based on diagonals and separation.
Input is from stdin in format produced by mummer.
Ouput goes to stdout.

Options:
-C       Check that fasta header labels alternately have "Reverse"
-d num   Fixed diagonal difference to join matches
-e       Use extent of match (end - start) rather than sum of piece
         lengths to determine length of cluster
-f num   Fraction of separation for diagonal difference
-l num   Minimum length of cluster match
-s num   Maximum separation between matches in cluster
```

## mummer_mummerplot

### Tool Description
Generate plots of mummer, nucmer, promer or show-tiling alignment data with gnuplot.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: mummerplot  [options]  <match file>

  DESCRIPTION:
    mummerplot generates plots of alignment data produced by mummer, nucmer,
    promer or show-tiling by using the GNU gnuplot utility. After generating
    the appropriate scripts and datafiles, mummerplot will attempt to run
    gnuplot to generate the plot. If this attempt fails, a warning will be
    output and the resulting .gp and .[frh]plot files will remain so that the
    user may run gnuplot independently. If the attempt succeeds, either an x11
    window will be spawned or an additional output file will be generated
    (.ps or .png depending on the selected terminal). Feel free to edit the
    resulting gnuplot script (.gp) and rerun gnuplot to change line thinkness,
    labels, colors, plot size etc.

  MANDATORY:
    match file      Set the alignment input to 'match file'
                    Valid inputs are from mummer, nucmer, promer and
                    show-tiling (.out, .cluster, .delta and .tiling)

  OPTIONS:
    -b|breaklen     Highlight alignments with breakpoints further than
                    breaklen nucleotides from the nearest sequence end
    --[no]color     Color plot lines with a percent similarity gradient or
                    turn off all plot color (default color by match dir)
                    If the plot is very sparse, edit the .gp script to plot
                    with 'linespoints' instead of 'lines'
    -c
    --[no]coverage  Generate a reference coverage plot (default for .tiling)
    --depend        Print the dependency information and exit
    -f
    --filter        Only display .delta alignments which represent the "best"
                    hit to any particular spot on either sequence, i.e. a
                    one-to-one mapping of reference and query subsequences
    -h
    --help          Display help information and exit
    -l
    --layout        Layout a .delta multiplot in an intelligible fashion,
                    this option requires the -R -Q options
    --fat           Layout sequences using fattest alignment only
    -p|prefix       Set the prefix of the output files (default 'out')
    -rv             Reverse video for x11 plots
    -r|IdR          Plot a particular reference sequence ID on the X-axis
    -q|IdQ          Plot a particular query sequence ID on the Y-axis
    -R|Rfile        Plot an ordered set of reference sequences from Rfile
    -Q|Qfile        Plot an ordered set of query sequences from Qfile
                    Rfile/Qfile Can either be the original DNA multi-FastA
                    files or lists of sequence IDs, lens and dirs [ /+/-]
    -r|rport        Specify the port to send reference ID and position on
                    mouse double click in X11 plot window
    -q|qport        Specify the port to send query IDs and position on mouse
                    double click in X11 plot window
    -s|size         Set the output size to small, medium or large
                    --small --medium --large (default 'small')
    -S
    --SNP           Highlight SNP locations in each alignment
    -t|terminal     Set the output terminal to x11, postscript or png
                    --x11 --postscript --png (default 'x11')
    -t|title        Specify the gnuplot plot title (default none)
    -x|xrange       Set the xrange for the plot '[min:max]'
    -y|yrange       Set the yrange for the plot '[min:max]'
    -V
    --version       Display the version information and exit
```

## mummer_delta-filter

### Tool Description
Filter the alignments of a nucmer or promer delta file (1-to-1, many-to-many, identity, length, uniqueness).

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
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

## mummer_show-diff

### Tool Description
List structural differences (GAP, DUP, BRK, JMP, INV, SEQ) from a delta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: show-diff  [options]  <deltafile>

-f            Output diff information as AMOS features
-h            Display help information
-H            Do not show header
-q            Show diff information for queries
-r            Show diff information for references (default)

  Outputs a list of structural differences for each sequence in
the reference and query, sorted by position. For a reference
sequence R, and its matching query sequence Q, differences are
categorized as GAP (gap between two mutually consistent alignments),
DUP (inserted duplication), BRK (other inserted sequence), JMP
(rearrangement), INV (rearrangement with inversion), SEQ
(rearrangement with another sequence). The first five columns of
the output are seq ID, feature type, feature start, feature end,
and feature length. Additional columns are added depending on the
feature type. Negative feature lengths indicate overlapping adjacent
alignment blocks.
  IDR GAP gap-start gap-end gap-length-R gap-length-Q gap-diff
  IDR DUP dup-start dup-end dup-length
  IDR BRK gap-start gap-end gap-length
  IDR JMP gap-start gap-end gap-length
  IDR INV gap-start gap-end gap-length
  IDR SEQ gap-start gap-end gap-length prev-sequence next-sequence
Positions always reference the sequence with the given ID. The
sum of the fifth column (ignoring negative values) is the total
amount of inserted sequence. Summing the fifth column after removing
DUP features is total unique inserted sequence. Note that unaligned
sequence are not counted, and could represent additional "unique"
sequences. See documentation for tips on how to interpret these
alignment break features.
```

## mummer_show-coords

### Tool Description
Show alignment coordinates, percent identity and other information from a delta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
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

## mummer_show-tiling

### Tool Description
Predict the tiling path of query contigs on the reference from a delta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
- **Homepage**: https://github.com/mummer4/mummer
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: show-tiling  [options]  <deltafile>

-a            Describe the tiling path by printing the tab-delimited
              alignment region coordinates to stdout
-c            Assume the reference sequences are circular, and allow
              tiled contigs to span the origin
-h            Display help information
-g int        Set maximum gap between clustered alignments [-1, INT_MAX]
              A value of -1 will represent infinity
              (nucmer default = 1000)
              (promer default = -1)
-i float      Set minimum percent identity to tile [0.0, 100.0]
              (nucmer default = 90.0)
              (promer default = 55.0)
-l int        Set minimum length contig to report [-1, INT_MAX]
              A value of -1 will represent infinity
              (common default = 1)
-p file       Output a pseudo molecule of the query contigs to 'file'
-R            Deal with repetitive contigs by randomly placing them
              in one of their copy locations (implies -V 0)
-t file       Output a TIGR style contig list of each query sequence
              that sufficiently matches the reference (non-circular)
-u file       Output the tab-delimited alignment region coordinates
              of the unusable contigs to 'file'
-v float      Set minimum contig coverage to tile [0.0, 100.0]
              (nucmer default = 95.0) sum of individual alignments
              (promer default = 50.0) extent of syntenic region
-V float      Set minimum contig coverage difference [0.0, 100.0]
              i.e. the difference needed to determine one alignment
              is 'better' than another alignment
              (nucmer default = 10.0) sum of individual alignments
              (promer default = 30.0) extent of syntenic region
-x            Describe the tiling path by printing the XML contig
              linking information to stdout

  Input is the .delta output of the nucmer program, run on very
similar sequence data, or the .delta output of the promer program,
run on divergent sequence data.
  Output is to stdout, and consists of the predicted location of
each aligning query contig as mapped to the reference sequences.
These coordinates reference the extent of the entire query contig,
even when only a certain percentage of the contig was actually
aligned (unless the -a option is used). Columns are, start in ref,
end in ref, distance to next contig, length of this contig, alignment
coverage, identity, orientation, and ID respectively.
```

