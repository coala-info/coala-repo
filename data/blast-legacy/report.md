# blast-legacy CWL Generation Report

## blast-legacy

### Tool Description
FAIL to generate CWL: blast-legacy not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/blast-legacy:2.2.26--h9ee0642_3
- **Homepage**: http://blast.ncbi.nlm.nih.gov
- **Package**: https://anaconda.org/channels/bioconda/packages/blast-legacy/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/blast-legacy/overview
- **Total Downloads**: 175.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: blast-legacy not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: blast-legacy not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## blast-legacy_formatdb

### Tool Description
Format protein or nucleotide databases for BLAST

### Metadata
- **Docker Image**: quay.io/biocontainers/blast-legacy:2.2.26--h9ee0642_3
- **Homepage**: http://blast.ncbi.nlm.nih.gov
- **Package**: https://anaconda.org/channels/bioconda/packages/blast-legacy/overview
- **Validation**: PASS
### Original Help Text
```text
formatdb 2.2.26   arguments:

  -t  Title for database file [String]  Optional
  -i  Input file(s) for formatting [File In]  Optional
  -l  Logfile name: [File Out]  Optional
    default = formatdb.log
  -p  Type of file
         T - protein   
         F - nucleotide [T/F]  Optional
    default = T
  -o  Parse options
         T - True: Parse SeqId and create indexes.
         F - False: Do not parse SeqId. Do not create indexes.
 [T/F]  Optional
    default = F
  -a  Input file is database in ASN.1 format (otherwise FASTA is expected)
         T - True, 
         F - False.
 [T/F]  Optional
    default = F
  -b  ASN.1 database in binary mode
         T - binary, 
         F - text mode.
 [T/F]  Optional
    default = F
  -e  Input is a Seq-entry [T/F]  Optional
    default = F
  -n  Base name for BLAST files [String]  Optional
  -v  Database volume size in millions of letters [Integer]  Optional
    default = 4000
  -s  Create indexes limited only to accessions - sparse [T/F]  Optional
    default = F
  -V  Verbose: check for non-unique string ids in the database [T/F]  Optional
    default = F
  -L  Create an alias file with this name
        use the gifile arg (below) if set to calculate db size
        use the BLAST db specified with -i (above) [File Out]  Optional
  -F  Gifile (file containing list of gi's) [File In]  Optional
  -B  Binary Gifile produced from the Gifile specified above [File Out]  Optional
  -T  Taxid file to set the taxonomy ids in ASN.1 deflines [File In]  Optional
```

## blast-legacy_blastall

### Tool Description
Legacy BLAST search tool

### Metadata
- **Docker Image**: quay.io/biocontainers/blast-legacy:2.2.26--h9ee0642_3
- **Homepage**: http://blast.ncbi.nlm.nih.gov
- **Package**: https://anaconda.org/channels/bioconda/packages/blast-legacy/overview
- **Validation**: PASS
### Original Help Text
```text
blastall 2.2.26   arguments:

  -p  Program Name [String]
  -d  Database [String]
    default = nr
  -i  Query File [File In]
    default = stdin
  -e  Expectation value (E) [Real]
    default = 10.0
  -m  alignment view options:
0 = pairwise,
1 = query-anchored showing identities,
2 = query-anchored no identities,
3 = flat query-anchored, show identities,
4 = flat query-anchored, no identities,
5 = query-anchored no identities and blunt ends,
6 = flat query-anchored, no identities and blunt ends,
7 = XML Blast output,
8 = tabular, 
9 tabular with comment lines
10 ASN, text
11 ASN, binary [Integer]
    default = 0
    range from 0 to 11
  -o  BLAST report Output File [File Out]  Optional
    default = stdout
  -F  Filter query sequence (DUST with blastn, SEG with others) [String]
    default = T
  -G  Cost to open a gap (-1 invokes default behavior) [Integer]
    default = -1
  -E  Cost to extend a gap (-1 invokes default behavior) [Integer]
    default = -1
  -X  X dropoff value for gapped alignment (in bits) (zero invokes default behavior)
      blastn 30, megablast 20, tblastx 0, all others 15 [Integer]
    default = 0
  -I  Show GI's in deflines [T/F]
    default = F
  -q  Penalty for a nucleotide mismatch (blastn only) [Integer]
    default = -3
  -r  Reward for a nucleotide match (blastn only) [Integer]
    default = 1
  -v  Number of database sequences to show one-line descriptions for (V) [Integer]
    default = 500
  -b  Number of database sequence to show alignments for (B) [Integer]
    default = 250
  -f  Threshold for extending hits, default if zero
      blastp 11, blastn 0, blastx 12, tblastn 13
      tblastx 13, megablast 0 [Real]
    default = 0
  -g  Perform gapped alignment (not available with tblastx) [T/F]
    default = T
  -Q  Query Genetic code to use [Integer]
    default = 1
  -D  DB Genetic code (for tblast[nx] only) [Integer]
    default = 1
  -a  Number of processors to use [Integer]
    default = 1
  -O  SeqAlign file [File Out]  Optional
  -J  Believe the query defline [T/F]
    default = F
  -M  Matrix [String]
    default = BLOSUM62
  -W  Word size, default if zero (blastn 11, megablast 28, all others 3) [Integer]
    default = 0
  -z  Effective length of the database (use zero for the real size) [Real]
    default = 0
  -K  Number of best hits from a region to keep. Off by default.
If used a value of 100 is recommended.  Very high values of -v or -b is also suggested [Integer]
    default = 0
  -P  0 for multiple hit, 1 for single hit (does not apply to blastn) [Integer]
    default = 0
  -Y  Effective length of the search space (use zero for the real size) [Real]
    default = 0
  -S  Query strands to search against database (for blast[nx], and tblastx)
       3 is both, 1 is top, 2 is bottom [Integer]
    default = 3
  -T  Produce HTML output [T/F]
    default = F
  -l  Restrict search of database to list of GI's [String]  Optional
  -U  Use lower case filtering of FASTA sequence [T/F]  Optional
  -y  X dropoff value for ungapped extensions in bits (0.0 invokes default behavior)
      blastn 20, megablast 10, all others 7 [Real]
    default = 0.0
  -Z  X dropoff value for final gapped alignment in bits (0.0 invokes default behavior)
      blastn/megablast 100, tblastx 0, all others 25 [Integer]
    default = 0
  -R  PSI-TBLASTN checkpoint file [File In]  Optional
  -n  MegaBlast search [T/F]
    default = F
  -L  Location on query sequence [String]  Optional
  -A  Multiple Hits window size, default if zero (blastn/megablast 0, all others 40 [Integer]
    default = 0
  -w  Frame shift penalty (OOF algorithm for blastx) [Integer]
    default = 0
  -t  Length of the largest intron allowed in a translated nucleotide sequence when linking multiple distinct alignments. (0 invokes default behavior; a negative value disables linking.) [Integer]
    default = 0
  -B  Number of concatenated queries, for blastn and tblastn [Integer]  Optional
    default = 0
  -V  Force use of the legacy BLAST engine [T/F]  Optional
    default = F
  -C  Use composition-based score adjustments for blastp or tblastn:
      As first character:
      D or d: default (equivalent to T)
      0 or F or f: no composition-based statistics
      2 or T or t: Composition-based score adjustments as in Bioinformatics 21:902-911,
      1: Composition-based statistics as in NAR 29:2994-3005, 2001
          2005, conditioned on sequence properties
      3: Composition-based score adjustment as in Bioinformatics 21:902-911,
          2005, unconditionally
      For programs other than tblastn, must either be absent or be D, F or 0.
           As second character, if first character is equivalent to 1, 2, or 3:
      U or u: unified p-value combining alignment p-value and compositional p-value in round 1 only
 [String]
    default = D
  -s  Compute locally optimal Smith-Waterman alignments (This option is only
      available for gapped tblastn.) [T/F]
    default = F
```

## blast-legacy_megablast

### Tool Description
megablast 2.2.26: a tool for fast alignment of highly similar sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/blast-legacy:2.2.26--h9ee0642_3
- **Homepage**: http://blast.ncbi.nlm.nih.gov
- **Package**: https://anaconda.org/channels/bioconda/packages/blast-legacy/overview
- **Validation**: PASS
### Original Help Text
```text
megablast 2.2.26   arguments:

  -d  Database [String]
    default = nr
  -i  Query File [File In]
  -e  Expectation value [Real]
    default = 10.0
  -m  alignment view options:
0 = pairwise,
1 = query-anchored showing identities,
2 = query-anchored no identities,
3 = flat query-anchored, show identities,
4 = flat query-anchored, no identities,
5 = query-anchored no identities and blunt ends,
6 = flat query-anchored, no identities and blunt ends,
7 = XML Blast output,
8 = tabular, 
9 tabular with comment lines,
10 ASN, text
11 ASN, binary [Integer]
    default = 0
    range from 0 to 11
  -o  BLAST report Output File [File Out]  Optional
    default = stdout
  -F  Filter query sequence [String]
    default = T
  -X  X dropoff value for gapped alignment (in bits) [Integer]
    default = 20
  -I  Show GI's in deflines [T/F]
    default = F
  -q  Penalty for a nucleotide mismatch [Integer]
    default = -3
  -r  Reward for a nucleotide match [Integer]
    default = 1
  -v  Number of database sequences to show one-line descriptions for (V) [Integer]
    default = 500
  -b  Number of database sequence to show alignments for (B) [Integer]
    default = 250
  -D  Type of output:
0 - alignment endpoints and score,
1 - all ungapped segments endpoints,
2 - traditional BLAST output,
3 - tab-delimited one line format,
4 - incremental text ASN.1,
5 - incremental binary ASN.1 [Integer]
    default = 2
  -a  Number of processors to use [Integer]
    default = 1
  -O  ASN.1 SeqAlign file; must be used in conjunction with -D2 option [File Out]  Optional
  -J  Believe the query defline [T/F]  Optional
    default = F
  -M  Maximal total length of queries for a single search [Integer]
    default = 5000000
  -W  Word size (length of best perfect match) [Integer]
    default = 28
  -z  Effective length of the database (use zero for the real size) [Real]
    default = 0
  -Y  Effective length of the search space (use zero for the real size) [Real]
    default = 0
  -P  Maximal number of positions for a hash value (set to 0 to ignore) [Integer]
    default = 0
  -S  Query strands to search against database: 3 is both, 1 is top, 2 is bottom [Integer]
    default = 3
  -T  Produce HTML output [T/F]
    default = F
  -l  Restrict search of database to list of GI's [String]  Optional
  -G  Cost to open a gap (-1 invokes default behavior) [Integer]
    default = -1
  -E  Cost to extend a gap (-1 invokes default behavior) [Integer]
    default = -1
  -s  Minimal hit score to report (0 for default behavior) [Integer]
    default = 0
  -Q  Masked query output, must be used in conjunction with -D 2 option [File Out]  Optional
  -f  Show full IDs in the output (default - only GIs or accessions) [T/F]
    default = F
  -U  Use lower case filtering of FASTA sequence [T/F]  Optional
    default = F
  -R  Report the log information at the end of output [T/F]  Optional
    default = F
  -p  Identity percentage cut-off [Real]
    default = 0
  -L  Location on query sequence [String]  Optional
  -A  Multiple Hits window size; default is 0 (i.e. single-hit extensions) or 40 for discontiguous template (negative number overrides this) [Integer]
    default = 0
  -y  X dropoff value for ungapped extension [Integer]
    default = 10
  -Z  X dropoff value for dynamic programming gapped extension [Integer]
    default = 50
  -t  Length of a discontiguous word template (contiguous word if 0) [Integer]
    default = 0
  -g  Make discontiguous megablast generate words for every base of the database (mandatory with the current BLAST engine) [T/F]  Optional
    default = T
  -n  Use non-greedy (dynamic programming) extension for affine gap scores [T/F]  Optional
    default = F
  -N  Type of a discontiguous word template (0 - coding, 1 - optimal, 2 - two simultaneous [Integer]
    default = 0
  -H  Maximal number of HSPs to save per database sequence (0 = unlimited) [Integer]
    default = 0
  -V  Force use of the legacy BLAST engine [T/F]  Optional
    default = F
```

