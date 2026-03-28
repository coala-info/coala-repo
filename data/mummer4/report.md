# mummer4 CWL Generation Report

## mummer4_nucmer

### Tool Description
generates nucleotide alignments between two mutli-FASTA input files. The out.delta output file lists the distance between insertions and deletions that produce maximal scoring alignments between each sequence. The show-* utilities know how to read this format.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
- **Homepage**: https://mummer4.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer4/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mummer4/overview
- **Total Downloads**: 65.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mummer4/mummer
- **Stars**: N/A
### Original Help Text
```text
Usage: nucmer [options] ref:path qry:path+

nucmer generates nucleotide alignments between two mutli-FASTA input
files. The out.delta output file lists the distance between insertions
and deletions that produce maximal scoring alignments between each
sequence. The show-* utilities know how to read this format.

By default, nucmer uses anchor matches that are unique in in the
reference but not necessarily unique in the query. See --mum and
--maxmatch for different bevahiors.

Options (default value in (), *required):
     --mum                                Use anchor matches that are unique in both the reference and query (false)
     --maxmatch                           Use all anchor matches regardless of their uniqueness (false)
 -b, --breaklen=uint32                    Set the distance an alignment extension will attempt to extend poor scoring regions before giving up (200)
 -c, --mincluster=uint32                  Sets the minimum length of a cluster of matches (65)
 -D, --diagdiff=uint32                    Set the maximum diagonal difference between two adjacent anchors in a cluster (5)
 -d, --diagfactor=double                  Set the maximum diagonal difference between two adjacent anchors in a cluster as a differential fraction of the gap length (0.12)
     --noextend                           Do not perform cluster extension step (false)
 -f, --forward                            Use only the forward strand of the Query sequences (false)
 -g, --maxgap=uint32                      Set the maximum gap between two adjacent matches in a cluster (90)
 -l, --minmatch=uint32                    Set the minimum length of a single exact match (20)
 -L, --minalign=uint32                    Minimum length of an alignment, after clustering and extension (0)
     --nooptimize                         No alignment score optimization, i.e. if an alignment extension reaches the end of a sequence, it will not backtrack to optimize the alignment score and instead terminate the alignment at the end of the sequence (false)
 -r, --reverse                            Use only the reverse complement of the Query sequences (false)
     --nosimplify                         Don't simplify alignments by removing shadowed clusters. Use this option when aligning a sequence to itself to look for repeats (false)
 -p, --prefix=PREFIX                      Write output to PREFIX.delta (out)
     --delta=PATH                         Output delta file to PATH (instead of PREFIX.delta)
     --sam-short=PATH                     Output SAM file to PATH, short format
     --sam-long=PATH                      Output SAM file to PATH, long format
     --save=PREFIX                        Save suffix array to files starting with PREFIX
     --load=PREFIX                        Load suffix array from file starting with PREFIX
     --batch=BASES                        Proceed by batch of chunks of BASES from the reference
 -t, --threads=NUM                        Use NUM threads (2)
 -U, --usage                              Usage
 -h, --help                               This message
     --full-help                          Detailed help
 -V, --version                            Version
```


## mummer4_promer

### Tool Description
promer generates amino acid alignments between two mutli-FASTA DNA input files. The out.delta output file lists the distance between insertions and deletions that produce maximal scoring alignments between each sequence. The show-* utilities know how to read this format. The DNA input is translated into all 6 reading frames in order to generate the output, but the output coordinates reference the original DNA input.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
- **Homepage**: https://mummer4.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer4/overview
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


## mummer4_dnadiff

### Tool Description
Run comparative analysis of two sequence sets using nucmer and its associated utilities with recommended parameters. See MUMmer documentation for a more detailed description of the output. Produces the following output files:

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

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
- **Homepage**: https://mummer4.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer4/overview
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


## mummer4_show-coords

### Tool Description
Output is to stdout, and consists of a list of coordinates, percent identity, and other useful information regarding the alignment data contained in the .delta file used as input.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
- **Homepage**: https://mummer4.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer4/overview
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


## mummer4_show-snps

### Tool Description
Output is to stdout, and consists of a list of SNPs (or amino acid substitutions for promer) with positions and other useful info.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
- **Homepage**: https://mummer4.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer4/overview
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


## mummer4_mummerplot

### Tool Description
mummerplot generates plots of alignment data produced by mummer, nucmer, promer or show-tiling by using the GNU gnuplot utility. After generating the appropriate scripts and datafiles, mummerplot will attempt to run gnuplot to generate the plot. If this attempt fails, a warning will be output and the resulting .gp and .[frh]plot files will remain so that the user may run gnuplot independently. If the attempt succeeds, either an interactive gnuplot window will be spawned (default) or an additional output file will be generated (e.g., .ps or .png depending on the selected terminal with -t). Feel free to edit the resulting gnuplot script (.gp) and rerun gnuplot to change line thinkness, labels, colors, plot size etc.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
- **Homepage**: https://mummer4.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer4/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: mummerplot  [options]  <match file>

  DESCRIPTION:
    mummerplot generates plots of alignment data produced by mummer, nucmer,
    promer or show-tiling by using the GNU gnuplot utility. After generating the
    appropriate scripts and datafiles, mummerplot will attempt to run gnuplot to
    generate the plot. If this attempt fails, a warning will be output and the
    resulting .gp and .[frh]plot files will remain so that the user may run
    gnuplot independently. If the attempt succeeds, either an interactive
    gnuplot window will be spawned (default) or an additional output file will
    be generated (e.g., .ps or .png depending on the selected terminal with -t).
    Feel free to edit the resulting gnuplot script (.gp) and rerun gnuplot to
    change line thinkness, labels, colors, plot size etc.

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
    -t|terminal     Set the output terminal, anything understood by "set
                    terminal", e.g. png, ps) (default: interactive)
    --list-terms    List the available terminals
    -title          Specify the gnuplot plot title (default none)
    -x|xrange       Set the xrange for the plot '[min:max]'
    -y|yrange       Set the yrange for the plot '[min:max]'
    -V
    --version       Display the version information and exit
```


## mummer4_show-tiling

### Tool Description
Output is to stdout, and consists of the predicted location of each aligning query contig as mapped to the reference sequences. These coordinates reference the extent of the entire query contig, even when only a certain percentage of the contig was actually aligned (unless the -a option is used). Columns are, start in ref, end in ref, distance to next contig, length of this contig, alignment coverage, identity, orientation, and ID respectively.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
- **Homepage**: https://mummer4.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer4/overview
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


## mummer4_delta-filter

### Tool Description
Reads a delta alignment file from either nucmer or promer and filters the alignments based on the command-line switches, leaving only the desired alignments which are output to stdout in the same delta format as the input.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
- **Homepage**: https://mummer4.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer4/overview
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


## Metadata
- **Skill**: generated
