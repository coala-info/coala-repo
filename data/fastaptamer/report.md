# fastaptamer CWL Generation Report

## fastaptamer_fastaptamer_count

### Tool Description
FASTAptamer-Count serves as the gateway to the FASTAptamer toolkit. For a given .FASTQ input file (or FASTA input file if the -f flag is used), FASTAptamer-Count will determine the number of times each sequence was read, rank and sort sequences by decreasing total reads, and normalize sequence frequency to reads per million.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
- **Homepage**: http://burkelab.missouri.edu/fastaptamer.html
- **Package**: https://anaconda.org/channels/bioconda/packages/fastaptamer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastaptamer/overview
- **Total Downloads**: 3.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
--------------------------------------------------------------------------------
                               FASTAptamer-Count
--------------------------------------------------------------------------------

Usage: fastaptamer_count [-h] [-q] [-v] [-i INFILE] [-o OUTFILE]

    [-h]            = Help screen.
    [-q]            = Suppress STDOUT of run report.
    [-v]            = Display version.
    [-i INFILE]     = input file. REQUIRED (FASTQ unless -f specified).
    [-o OUTFILE]    = FASTA output file. REQUIRED.
    [-f ]           = input file is in FASTA format (otherwise it must be FASTQ)
    [-c CSV_OUT]    = output CSV format (to file CSV_OUT)
    [-u ]           = Create unique sequence ID's

FASTAptamer-Count serves as the gateway to the FASTAptamer toolkit.  For a given
.FASTQ input file (or FASTA input file if the -f flag is used), FASTAptamer-Cou-
nt will determine the number of times each sequence was read, rank and sort seq-
uences by decreasing total reads, and normalize sequence frequency to reads per
million. Output is generated as a non-redundant FASTA file in the following for-
mat for each sequence:

    >RANK-READS-RPM
    SEQUENCE

Where RANK is the relative abundance of the sequence within the population. In
cases where two or more sequences are sampled with equal abundance, FASTAptamer-
Count follows standard competition ranking (e.g., "1-2-2-4" where two sequences
are tied for second).  READS is the raw number of times a sequence was counted.
RPM is "Reads per million," which is a normalized value that allows for compari-
son across populations of varying read depth. RPM is calculated as:

	RPM = (READS/(population size)) x 10^6.

In addition to generating a FASTA output file, FASTAptamer-Count will display a
summary report on the screen (STDOUT) that includes the number of total reads f-
ound in the input file, the number of unique sequences, the file input/output n-
ames and the program execution time. The  summary report can be suppressed by i-
ncluding the optional flag [-q] on the command line.

If the -u flag is used, the FASTA file will have the following format (starting
at the second sequence that has the same rank):

        >RANK(UNIQ)-READS-RPM
        SEQUENCE

Where UNIQ is a numeric label that distinguishes sequences with identical
RANK and READS (and therefore identical RPM too). This label starts at '2' and
increments by one for each new sequence that has the same RANK. This label is r-
eset each time RANK increases.

Summary report (total reads, unique reads, and execution time) is displayed as
STDOUT at program completion unless [-q] is invoked.

If a CSV output filename is given, then a csv file is output with the columns
"rank,sequence,count,cpm,percent".
```


## fastaptamer_fastaptamer_compare

### Tool Description
FASTAptamer-Compare facilitates statistical analysis of two populations by rapidly generating a tab-delimited output file that lists each unique sequence along with RPM (reads per million) in each population file (if available) and log(base 2) of the ratio of their RPM values in each population.
RPM data for both populations can be utilized to generate an XY-scatter plot of sequence distribution across two populations. FASTAptamer-Compare also facilitates the generation of a histogram of the sequence distribution by creating 102 bins for the log(base2) values. This histogram can provide a quick visual comparison of the two populations: distributions centered around 0 indicate similar populations, while distributions shifted to the left or right indicate overall enrichment or depletion.
Input for FASTAptamer-Compare MUST come from FASTAptamer-Count output files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
- **Homepage**: http://burkelab.missouri.edu/fastaptamer.html
- **Package**: https://anaconda.org/channels/bioconda/packages/fastaptamer/overview
- **Validation**: PASS

### Original Help Text
```text
--------------------------------------------------------------------------------
                               FASTAptamer-Compare
--------------------------------------------------------------------------------

Usage: fastaptamer_compare [-h] [-x INFILE] [-y INFILE] [-o OUTFILE] [-q] [-a]
                           [-v]

    [-h]            = Help screen.
    [-x INFILE]     = Input file (from FASTAptamer-Count). REQUIRED.
    [-y INFILE]     = Input file (from FASTAptamer-Count). REQUIRED.
    [-o OUTFILE]    = Plain text output file with tab separated values. REQUIRED
    [-q]            = Quiet mode.  Suppresses standard output of file I/O
                      and execution time.
    [-a]            = Output all sequences, including those present in only
                      one input file.  Default behavior suppresses output
                      of sequences without a match.
    [-v]            = Display version.

FASTAptamer-Compare facilitates statistical analysis of two populations by rapi-
dly generating a tab-delimited output file that lists each unique sequence along
with RPM (reads per million) in each population file (if available) and log(bas-
e 2) of the ratio of their RPM values in each population.

RPM data for both populations can be utilized to generate an XY-scatter plot of
sequence distribution across two populations.  FASTAptamer-Compare also facilit-
ates the generation of a histogram of the sequence distribution by creating 102
bins for the log(base2) values.  This histogram can provide a quick visual comp-
arison of the two populations: distributions centered around 0 indicate similar
populations, while distributions shifted to the left or right indicate overall
enrichment or depletion.

Input for FASTAptamer-Compare MUST come from FASTAptamer-Count output files.
```


## fastaptamer_fastaptamer_cluster

### Tool Description
FASTAptamer-Cluster uses the Levenshtein algorithm to cluster together sequences based on a user-defined edit distance. The most abundant and unclustered sequence is used as the "seed sequence" for which edit distance is calculated from.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
- **Homepage**: http://burkelab.missouri.edu/fastaptamer.html
- **Package**: https://anaconda.org/channels/bioconda/packages/fastaptamer/overview
- **Validation**: PASS

### Original Help Text
```text
--------------------------------------------------------------------------------
                              FASTAptamer-Cluster
--------------------------------------------------------------------------------

Usage: fastaptamer_cluster [-h] [-i INFILE] [-o OUTFILE] [-d #] [-f #] [-q] [-v]

    [-h]            = Help screen.
    [-i INFILE]     = Input file from FASTAptamer-Count. REQUIRED.
    [-o OUTFILE]    = Output file, FASTA format. REQUIRED.
    [-d]            = Edit distance for clustering sequences. REQUIRED.
    [-f]            = Read filter. Only sequences with total reads greater than
                      the value supplied will be clustered.
    [-c]            = Maximum number of clusters to find.
    [-q]            = Quiet mode.  Suppresses standard output of file I/O, numb-
                      er of clusters, cluster size and execution time.
    [-v]            = Display version.

FASTAptamer-Cluster uses the Levenshtein algorithm to cluster together sequences
based on a user-defined edit distance.  The most abundant and unclustered seque-
nce is used as the "seed sequence" for which edit distance is calculated from.
Output is FASTA with the following information on the identifier line for each
sequence entry:

    >Rank-Reads-RPM-Cluster#-RankWithinCluster-EditDistanceFromSeed
    SEQUENCE

To prevent clustering of sequences not highly sampled (and improve execution ti-
me), invoke the read filter and enter a number.  Only sequences with total reads
greater than the number entered will be clustered.

Input for FASTAptamer-Cluster MUST come from a FASTAptamer-Count output file.

PLEASE NOTE: This is a computationally intense program that can take multiple h-
ours to finish depending on the size and complexity of your population. Utilize
the read filter [-f] and/or the maximum number of clusters [-c] to improve ex-
ecution time.
```


## fastaptamer_fastaptamer_enrich

### Tool Description
FASTAptamer-Enrich rapidly calculates fold-enrichment values for each sequence across two or three input files. Output is provided as a tab-delimited plain text file and is formatted to include sequence composition, length, rank, reads, reads per million (RPM), and enrichment values for each sequence. If any files from FASTAptamer-Cluster are provided, output will include cluster information for that population. A threshold filter can be applied to exclude sequences with total reads per million (across all input populations) less than the number entered after the [-f] option. Default behavior is to include all sequences. Enrichment is calculated by dividing reads per million of y/x (and z/y and z/x, if a third input file is specified).

### Metadata
- **Docker Image**: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
- **Homepage**: http://burkelab.missouri.edu/fastaptamer.html
- **Package**: https://anaconda.org/channels/bioconda/packages/fastaptamer/overview
- **Validation**: PASS

### Original Help Text
```text
--------------------------------------------------------------------------------
                               FASTAptamer-Enrich
--------------------------------------------------------------------------------

Usage: fastaptamer_enrich [-h] [-x INFILE] [-y INFILE] [-z INFILE] [-o OUTFILE]
                          [-f #] [-q] [-v]

    [-h]            = Help screen.
    [-x INFILE]     = First input file from FASTAptamer-Count or
                      FASTAptamer-Cluster. REQUIRED.
    [-y INFILE]     = Second input file from FASTAptamer-Count or
                      FASTAptamer-Cluster. REQUIRED.
                      *** For two populations only, use -x and -y. ***
    [-z INFILE]     = Optional third input file from FASTAptamer-Count or
                      FASTAptamer-Cluster.
    [-o OUTFILE]    = Plain text output file with tab separated values. REQUIRED
    [-f]            = Optional reads per million threshold filter.
    [-q]            = Quiet mode.  Suppresses standard output of file I/O,
                      number of matched sequences and execution time.
    [-v]            = Display version.

FASTAptamer-Enrich rapidly calculates fold-enrichment values for each sequence
across two or three input files.  Output is provided as a tab-delimited plain t-
ext file and is formatted to include sequence composition, length, rank, reads,
reads per million (RPM), and enrichment values for each sequence. If any files
from FASTAptamer-Cluster are provided, output will include cluster information
for that population. A threshold filter can be applied to exclude sequences with
total reads per million (across all input populations) less than the number ent-
ered after the [-f] option.  Default behavior is to include all sequences. Enri-
chment is calculated by dividing reads per million of y/x (and z/y and z/x, if a
third input file is specified).

Input for FASTAptamer-Enrich MUST come from FASTAptamer-Count or FASTAptamer-
Cluster output files.
```


## fastaptamer_fastaptamer_search

### Tool Description
FASTAptamer-Search allows users to search for specific patterns within one or more sequence files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
- **Homepage**: http://burkelab.missouri.edu/fastaptamer.html
- **Package**: https://anaconda.org/channels/bioconda/packages/fastaptamer/overview
- **Validation**: PASS

### Original Help Text
```text
--------------------------------------------------------------------------------
                              FASTAptamer-Search
--------------------------------------------------------------------------------

Usage: fastaptamer_search [-i INFILE] [-o OUTFILE] [-p PATTERN]

    [-help]                = Help screen.
    [-i FILENAME]         = Input file; can be used multiple times. REQUIRED.
    [-p PATTERN]        = Sequence pattern to search for; can be used multiple
                          times. REQUIRED.
    [-o FILENAME]       = Output file for search results. If none given, output
                          goes to STDOUT.
    [-highlight]        = Highlight matched portion of sequence in parentheses.
    [-q]                = Suppress summary report.
    [-v]                = Display version.

FASTAptamer-Search allows users to search for specific patterns within one or m-
ore sequence files.

To search through more than one input file, simply use the [-i] flag multiple t-
imes. All input files must use FASTA format.

Similarly, to search for multiple patterns simultaneously, use the [-p] flag as
many times as needed. When searching for multiple patterns, note that partial m-
atches are not returned. For example, entering the following command:

    fastaptamer_search -i FILE1 -i FILE2 -p ATTGCC -p TGGCAT

would search FILE1 and FILE2 for sequences containing both ATTGCC and TGGCAT.

Patterns and input sequence data are case insensitive and T/U are interchangeab-
le. In addition to single bases, patterns can include any of the degenerate base
symbols from IUPAC nucleic acid notation:

    A/T/G/C/U    single bases

    R    puRines (A/G)
    Y    pYrimidines (C/T)
    W    Weak (A/T)
    S    Strong (G/C)
    M    aMino (A/C)
    K    Keto (G/T)

    B    not A
    D    not C
    H    not G
    V    not T

    N    aNy base (not a gap)

For greater visibility, pattern matches can be highlighted by parentheses in the
output by calling the [-highlight] flag.

A summary report is generated after each file's search results and after search
completion. To suppress these reports, enable quiet mode using the [-quiet] flag
```

