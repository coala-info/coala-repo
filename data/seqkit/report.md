# seqkit CWL Generation Report

## seqkit_faidx

### Tool Description
create the FASTA index file and extract subsequences

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Total Downloads**: 683.8K
- **Last updated**: 2025-12-20
- **GitHub**: https://github.com/shenwei356/seqkit
- **Stars**: N/A
### Original Help Text
```text
create the FASTA index file and extract subsequences

This command is similar with "samtools faidx" but has some extra features:

  1. output full header line with the flag -f
  2. support regular expression as sequence ID with the flag -r
  3. if you have large number of IDs, you can use:
        seqkit faidx seqs.fasta -l IDs.txt

Attention:
  1. The flag -U/--update-faidx is recommended to ensure the .fai file matches the FASTA file.

The definition of region is 1-based and with some custom design.

Examples:

 1-based index    1 2 3 4 5 6 7 8 9 10
negative index    0-9-8-7-6-5-4-3-2-1
           seq    A C G T N a c g t n
           1:1    A
           2:4      C G T
         -4:-2                c g t
         -4:-1                c g t n
         -1:-1                      n
          2:-2      C G T N a c g t
          1:-1    A C G T N a c g t n
          1:12    A C G T N a c g t n
        -12:-1    A C G T N a c g t n

Usage:
  seqkit faidx [flags] <fasta-file> [regions...]

Flags:
  -f, --full-head            print full header line instead of just ID. New fasta index file ending with
                             .seqkit.fai will be created
  -h, --help                 help for faidx
  -i, --ignore-case          ignore case
  -I, --immediate-output     print output immediately, do not use write buffer
  -l, --region-file string   file containing a list of regions
  -U, --update-faidx         update the fasta index file if it exists. Use this if you are not sure
                             whether the fasta file changed
  -r, --use-regexp           IDs are regular expression. But subseq region is not supported here.

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_scat

### Tool Description
real time recursive concatenation and streaming of fastx files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
real time recursive concatenation and streaming of fastx files

Usage:
  seqkit scat [flags] 

Flags:
  -A, --allow-gaps            allow gap character (-) in sequences
  -d, --delta int             minimum size increase in kilobytes to trigger parsing (default 5)
  -D, --drop-time string      Notification drop interval (default "500ms")
  -f, --find-only             concatenate existing files and quit
  -i, --format string         input and output format: fastq or fasta (fastq) (default "fastq")
  -g, --gz-only               only look for gzipped files (.gz suffix)
  -h, --help                  help for scat
  -I, --in-format string      input format: fastq or fasta (fastq)
  -O, --out-format string     output format: fastq or fasta
  -b, --qual-ascii-base int   ASCII BASE, 33 for Phred+33 (default 33)
  -r, --regexp string         regexp for watched files, by default guessed from the input format
  -T, --time-limit string     quit after inactive for this time period
  -p, --wait-pid int          after process with this PID exited (default -1)

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_seq

### Tool Description
transform sequences (extract ID, filter by length, remove gaps, reverse complement...)

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
transform sequences (extract ID, filter by length, remove gaps, reverse complement...)

Usage:
  seqkit seq [flags] 

Flags:
  -k, --color                 colorize sequences - to be piped into "less -R"
  -p, --complement            complement sequence, flag '-v' is recommended to switch on
      --dna2rna               DNA to RNA
  -G, --gap-letters string    gap letters to be removed with -g/--remove-gaps (default "- \t.")
  -h, --help                  help for seq
  -l, --lower-case            print sequences in lower case
  -M, --max-len int           only print sequences shorter than or equal to the maximum length (-1 for
                              no limit) (default -1)
  -R, --max-qual float        only print sequences with average quality less than this limit (-1 for no
                              limit) (default -1)
  -m, --min-len int           only print sequences longer than or equal to the minimum length (-1 for no
                              limit) (default -1)
  -Q, --min-qual float        only print sequences with average quality greater or equal than this limit
                              (-1 for no limit) (default -1)
  -n, --name                  only print names/sequence headers
  -i, --only-id               print IDs instead of full headers
  -q, --qual                  only print qualities
  -b, --qual-ascii-base int   ASCII BASE, 33 for Phred+33 (default 33)
  -g, --remove-gaps           remove gaps letters set by -G/--gap-letters, e.g., spaces, tabs, and
                              dashes (gaps "-" in aligned sequences)
  -r, --reverse               reverse sequence
      --rna2dna               RNA to DNA
  -s, --seq                   only print sequences
  -u, --upper-case            print sequences in upper case
  -v, --validate-seq          validate bases according to the alphabet

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_sliding

### Tool Description
extract subsequences in sliding windows

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
extract subsequences in sliding windows

Usage:
  seqkit sliding [flags] 

Flags:
  -c, --circular          circular genome (same to -C/--circular-genome)
  -C, --circular-genome   circular genome (same to -c/--circular)
  -g, --greedy            greedy mode, i.e., exporting last subsequences even shorter than the windows size
  -h, --help              help for sliding
  -s, --step int          step size
  -S, --suffix string     suffix added to the sequence ID (default "_sliding")
  -W, --window int        window size

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_stats

### Tool Description
simple statistics of FASTA/Q files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
simple statistics of FASTA/Q files

Columns:

  1.  file      input file, "-" for STDIN
  2.  format    FASTA or FASTQ
  3.  type      DNA, RNA, Protein or Unlimit
  4.  num_seqs  number of sequences
  5.  sum_len   number of bases or residues       , with gaps or spaces counted
  6.  min_len   minimal sequence length           , with gaps or spaces counted
  7.  avg_len   average sequence length           , with gaps or spaces counted
  8.  max_len   miximal sequence length           , with gaps or spaces counted
  9.  Q1        first quartile of sequence length , with gaps or spaces counted
  10. Q2        median of sequence length         , with gaps or spaces counted
  11. Q3        third quartile of sequence length , with gaps or spaces counted
  12. sum_gap   number of gaps
  13. N50       N50. https://en.wikipedia.org/wiki/N50,_L50,_and_related_statistics#N50
  14. N50_num   N50_num or L50. https://en.wikipedia.org/wiki/N50,_L50,_and_related_statistics#L50
  15. Q20(%)    percentage of bases with the quality score greater than 20
  16. Q30(%)    percentage of bases with the quality score greater than 30
  17. AvgQual   average quality.
                Attention: It's not the arithmetic average of quartiles (some tools do that).
                How to computate: 1) take the qscore for each base, 2) convert it back to
                an error probability, 3) take the mean of those, 4) and then convert that
                mean error back into a qscore.
                Reference: https://github.com/shenwei356/seqkit/issues/448
  18. GC(%)     percentage of GC content
  19. sum_n     number of ambitious letters (N, n, X, x)

Attention:
  1. Sequence length metrics (sum_len, min_len, avg_len, max_len, Q1, Q2, Q3)
     count the number of gaps or spaces. You can remove them with "seqkit seq -g":
         seqkit seq -g input.fasta | seqkit stats

Tips:
  1. For lots of small files (especially on SDD), use a big value of '-j' to
     parallelize counting.
  2. Extract one metric with csvtk (https://github.com/shenwei356/csvtk):
         seqkit stats -Ta input.fastq.gz | csvtk cut -t -f "Q30(%)" | csvtk del-header

Usage:
  seqkit stats [flags] 

Aliases:
  stats, stat

Flags:
  -N, --N strings            append other N50-like stats as new columns. value range [0, 100], multiple
                             values supported, e.g., -N 50,90 or -N 50 -N 90
  -a, --all                  all statistics, including quartiles of seq length, sum_gap, N50
  -b, --basename             only output basename of files
  -E, --fq-encoding string   fastq quality encoding. available values: 'sanger', 'solexa',
                             'illumina-1.3+', 'illumina-1.5+', 'illumina-1.8+'. (default "sanger")
  -G, --gap-letters string   gap letters (default "- .")
  -h, --help                 help for stats
  -e, --skip-err             skip error, only show warning message
  -S, --skip-file-check      skip input file checking when given files or a file list.
  -i, --stdin-label string   label for replacing default "-" for stdin (default "-")
  -T, --tabular              output in machine-friendly tabular format

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_subseq

### Tool Description
get subsequences by region/gtf/bed, including flanking sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
get subsequences by region/gtf/bed, including flanking sequences.

Attention:
  1. When extracting with BED/GTF from plain text FASTA files, the order of output sequences
     are random. To keep the order, just compress the FASTA file (input.fasta) and use the
     compressed one (input.fasta.gz) as the input.
  2. Use "seqkit grep" for extracting subsets of sequences.
     "seqtk subseq seqs.fasta id.txt" equals to
     "seqkit grep -f id.txt seqs.fasta"

Recommendation:
  1. Use plain FASTA file, so seqkit could utilize FASTA index.
  2. The flag -U/--update-faidx is recommended to ensure the .fai file matches the FASTA file.

The definition of region is 1-based and with some custom design.

Examples:

 1-based index    1 2 3 4 5 6 7 8 9 10
negative index    0-9-8-7-6-5-4-3-2-1
           seq    A C G T N a c g t n
           1:1    A
           2:4      C G T
         -4:-2                c g t
         -4:-1                c g t n
         -1:-1                      n
          2:-2      C G T N a c g t
          1:-1    A C G T N a c g t n
          1:12    A C G T N a c g t n
        -12:-1    A C G T N a c g t n

Usage:
  seqkit subseq [flags] 

Flags:
      --bed string        by tab-delimited BED file
      --chr strings       select limited sequence with sequence IDs when using --gtf or --bed (multiple
                          value supported, case ignored)
  -d, --down-stream int   down stream length
      --feature strings   select limited feature types (multiple value supported, case ignored, only
                          works with GTF)
      --gtf string        by GTF (version 2.2) file
      --gtf-tag string    output this tag as sequence comment (default "gene_id")
  -h, --help              help for subseq
  -f, --only-flank        only return up/down stream sequence
  -r, --region string     by region. e.g 1:12 for first 12 bases, -12:-1 for last 12 bases, 13:-1 for
                          cutting first 12 bases. type "seqkit subseq -h" for more examples
  -R, --region-coord      append coordinates to sequence ID for -r/--region
  -u, --up-stream int     up stream length
  -U, --update-faidx      update the fasta index file if it exists. Use this if you are not sure whether
                          the fasta file changed

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_translate

### Tool Description
translate DNA/RNA to protein sequence (supporting ambiguous bases)

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
translate DNA/RNA to protein sequence (supporting ambiguous bases)

Note:

  1. This command supports codons containing any ambiguous base.
     Please switch on flag -L INT for details. e.g., for standard table:

        ACN -> T
        CCN -> P
        CGN -> R
        CTN -> L
        GCN -> A
        GGN -> G
        GTN -> V
        TCN -> S
        
        MGR -> R
        YTR -> L

Translate Tables/Genetic Codes:

    # https://www.ncbi.nlm.nih.gov/Taxonomy/taxonomyhome.html/index.cgi?chapter=tgencodes

     1: The Standard Code
     2: The Vertebrate Mitochondrial Code
     3: The Yeast Mitochondrial Code
     4: The Mold, Protozoan, and Coelenterate Mitochondrial Code and the Mycoplasma/Spiroplasma Code
     5: The Invertebrate Mitochondrial Code
     6: The Ciliate, Dasycladacean and Hexamita Nuclear Code
     9: The Echinoderm and Flatworm Mitochondrial Code
    10: The Euplotid Nuclear Code
    11: The Bacterial, Archaeal and Plant Plastid Code
    12: The Alternative Yeast Nuclear Code
    13: The Ascidian Mitochondrial Code
    14: The Alternative Flatworm Mitochondrial Code
    16: Chlorophycean Mitochondrial Code
    21: Trematode Mitochondrial Code
    22: Scenedesmus obliquus Mitochondrial Code
    23: Thraustochytrium Mitochondrial Code
    24: Pterobranchia Mitochondrial Code
    25: Candidate Division SR1 and Gracilibacteria Code
    26: Pachysolen tannophilus Nuclear Code
    27: Karyorelict Nuclear
    28: Condylostoma Nuclear
    29: Mesodinium Nuclear
    30: Peritrich Nuclear
    31: Blastocrithidia Nuclear

Usage:
  seqkit translate [flags] 

Flags:
  -x, --allow-unknown-codon                     translate unknown code to 'X'. And you may not use flag
                                                --trim which removes 'X'
  -F, --append-frame                            append frame information to sequence ID
      --clean                                   change all STOP codon positions from the '*' character
                                                to 'X' (an unknown residue)
  -f, --frame strings                           frame(s) to translate, available value: 1, 2, 3, -1, -2,
                                                -3, and 6 for all six frames (default [1])
  -h, --help                                    help for translate
  -M, --init-codon-as-M                         translate initial codon at beginning to 'M'
  -l, --list-transl-table int                   show details of translate table N, 0 for all (default -1)
  -L, --list-transl-table-with-amb-codons int   show details of translate table N (including ambigugous
                                                codons), 0 for all.  (default -1)
  -m, --min-len int                             the minimum length of amino acid sequence
  -s, --out-subseqs                             output individual amino acid subsequences seperated by
                                                the stop symbol "*"
  -e, --skip-translate-errors                   skip errors during translate and output blank sequence
  -T, --transl-table int                        translate table/genetic code, type 'seqkit translate
                                                --help' for more details (default 1)
      --trim                                    remove all 'X' and '*' characters from the right end of
                                                the translation

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_watch

### Tool Description
monitoring and online histograms of sequence features

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
monitoring and online histograms of sequence features

Usage:
  seqkit watch [flags] 

Flags:
  -B, --bins int              number of histogram bins (default -1)
  -W, --delay int             sleep this many seconds after online plotting (default 1)
  -y, --dump                  print histogram data to stderr instead of plotting
  -f, --fields string         target fields, available values: ReadLen, MeanQual, GC, GCSkew (default
                              "ReadLen")
  -h, --help                  help for watch
  -O, --img string            save histogram to this PDF/image file
  -H, --list-fields           print out a list of available fields
  -L, --log                   log10(x+1) transform numeric values
  -x, --pass                  pass through mode (write input to stdout)
  -p, --print-freq int        print/report after this many records (-1 for print after EOF) (default -1)
  -b, --qual-ascii-base int   ASCII BASE, 33 for Phred+33 (default 33)
  -Q, --quiet-mode            supress all plotting to stderr
  -R, --reset                 reset histogram after every report
  -v, --validate-seq          validate bases according to the alphabet

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_convert

### Tool Description
convert FASTQ quality encoding between Sanger, Solexa and Illumina

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
convert FASTQ quality encoding between Sanger, Solexa and Illumina

Usage:
  seqkit convert [flags] 

Flags:
  -d, --dry-run                         dry run
  -f, --force                           for Illumina-1.8+ -> Sanger, truncate scores > 40 to 40
      --from string                     source quality encoding. if not given, we'll guess it
  -h, --help                            help for convert
  -n, --nrecords int                    number of records for guessing quality encoding (default 1000)
  -N, --thresh-B-in-n-most-common int   threshold of 'B' in top N most common quality for guessing
                                        Illumina 1.5. (default 2)
  -F, --thresh-illumina1.5-frac float   threshold of faction of Illumina 1.5 in the leading N records
                                        (default 0.1)
      --to string                       target quality encoding (default "Sanger")

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_fa2fq

### Tool Description
retrieve corresponding FASTQ records by a FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
retrieve corresponding FASTQ records by a FASTA file

Attention:
  1. We assume the FASTA file comes from the FASTQ file,
     so they share sequence IDs, and sequences in FASTA
     should be subseq of sequences in FASTQ file.

Usage:
  seqkit fa2fq [flags] 

Flags:
  -f, --fasta-file string      FASTA file)
  -h, --help                   help for fa2fq
  -P, --only-positive-strand   only search on positive strand

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_fq2fa

### Tool Description
convert FASTQ to FASTA

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
convert FASTQ to FASTA

Usage:
  seqkit fq2fa [flags] 

Flags:
  -h, --help   help for fq2fa

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_fx2tab

### Tool Description
convert FASTA/Q to tabular format, and provide various information,
like sequence length, GC content/GC skew.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
convert FASTA/Q to tabular format, and provide various information,
like sequence length, GC content/GC skew.

Attention:
  1. Fixed three columns (ID, sequence, quality) are outputted for either FASTA
     or FASTQ, except when flag -n/--name is on. This is for format compatibility.
  2. The average quality is not the arithmetic average of quartiles (some tools do that).
     How to computate: 1) take the qscore for each base, 2) convert it back to
     an error probability, 3) take the mean of those, 4) and then convert that
     mean error back into a qscore.
     Reference: https://github.com/shenwei356/seqkit/issues/448

Usage:
  seqkit fx2tab [flags] 

Flags:
  -a, --alphabet               print alphabet letters
  -q, --avg-qual               print average quality of a read
  -B, --base-content strings   print base content. (case ignored, multiple values supported) e.g. -B AT
                               -B N. Note that the denominator is the sequence length
  -C, --base-count strings     print base count. (case ignored, multiple values supported) e.g. -C AT -C N
  -I, --case-sensitive         calculate case sensitive base content/sequence hash
  -g, --gc                     print GC content, i.e., (G+C)/(G+C+A+T)
  -G, --gc-skew                print GC-Skew
  -H, --header-line            print header line
  -h, --help                   help for fx2tab
  -l, --length                 print sequence length
  -n, --name                   only print names (no sequences and qualities)
  -Q, --no-qual                only output two column even for FASTQ file
  -i, --only-id                print ID instead of full head
  -b, --qual-ascii-base int    ASCII BASE, 33 for Phred+33 (default 33)
  -s, --seq-hash               print hash (MD5) of sequence

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_tab2fx

### Tool Description
convert tabular format (first two/three columns) to FASTA/Q format

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
convert tabular format (first two/three columns) to FASTA/Q format

Usage:
  seqkit tab2fx [flags] 

Flags:
  -b, --buffer-size string            size of buffer, supported unit: K, M, G. You need increase the
                                      value when "bufio.Scanner: token too long" error reported (default
                                      "1G")
  -p, --comment-line-prefix strings   comment line prefix (default [#,//])
  -h, --help                          help for tab2fx

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_amplicon

### Tool Description
extract amplicon (or specific region around it) via primer(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
extract amplicon (or specific region around it) via primer(s).

Attention:
  1. Only one (the longest) matching location is returned for every primer pair.
  2. Mismatch is allowed, but the mismatch location (5' or 3') is not controlled.
     You can increase the value of "-j/--threads" to accelerate processing.
     You can switch "-M/--output-mismatches" to append total mismatches and
     mismatches of 5' end and 3' end.
  3. Degenerate bases/residues like "RYMM.." are also supported.
     But do not use degenerate bases/residues in regular expression, you need
     convert them to regular expression, e.g., change "N" or "X"  to ".".

Examples:
  0. no region given.
  
                    F
        -----===============-----
             F             R
        -----=====-----=====-----
             
             ===============         amplicon

  1. inner region (-r x:y).

                    F
        -----===============-----
             1 3 5                    x/y
                      -5-3-1          x/y
             F             R
        -----=====-----=====-----     x:y
        
             ===============          1:-1
             =======                  1:7
               =====                  3:7
                  =====               6:10
                  =====             -10:-6
                     =====           -7:-3
                                     -x:y (invalid)
                    
  2. flanking region (-r x:y -f)
        
                    F
        -----===============-----
         -3-1                        x/y
                            1 3 5    x/y
             F             R
        -----=====-----=====-----
        
        =====                        -5:-1
        ===                          -5:-3
                            =====     1:5
                              ===     3:5
            =================        -1:1
        =========================    -5:5
                                      x:-y (invalid)

Usage:
  seqkit amplicon [flags] 

Flags:
      --bed                    output in BED6+1 format with amplicon as the 7th column
  -f, --flanking-region        region is flanking region
  -F, --forward string         forward primer (5'-primer-3'), degenerate bases allowed
  -h, --help                   help for amplicon
  -I, --immediate-output       print output immediately, do not use write buffer
  -m, --max-mismatch int       max mismatch when matching primers, no degenerate bases allowed
  -P, --only-positive-strand   only search on positive strand
  -M, --output-mismatches      append the total mismatches and mismatches of 5' end and 3' end
  -p, --primer-file string     3- or 2-column tabular primer file, with first column as primer name
  -r, --region string          specify region to return. type "seqkit amplicon -h" for detail
  -R, --reverse string         reverse primer (5'-primer-3'), degenerate bases allowed
  -u, --save-unmatched         also save records that do not match any primer
  -s, --strict-mode            strict mode, i.e., discarding seqs not fully matching (shorter) given
                               region range

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_fish

### Tool Description
look for short sequences in larger sequences using local alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
look for short sequences in larger sequences using local alignment

Attention:
  1. output coordinates are BED-like 0-based, left-close and right-open.
  2. alignment information are printed to STDERR.

Usage:
  seqkit fish [flags] 

Flags:
  -a, --all                      search all
  -p, --aln-params string        alignment parameters in format
                                 "<match>,<mismatch>,<gap_open>,<gap_extend>" (default "4,-4,-2,-1")
  -h, --help                     help for fish
  -i, --invert                   print out references not matching with any query
  -q, --min-qual float           minimum mapping quality (default 5)
  -b, --out-bam string           save aligmnets to this BAM file (memory intensive)
  -x, --pass                     pass through mode (write input to stdout)
  -g, --print-aln                print sequence alignments
  -D, --print-desc               print full sequence header
  -f, --query-fastx string       query fasta
  -F, --query-sequences string   query sequences
  -r, --ranges string            target ranges, for example: ":10,30:40,-20:"
  -s, --stranded                 search + strand only
  -v, --validate-seq             validate bases according to the alphabet

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_grep

### Tool Description
search sequences by ID/name/sequence/sequence motifs, mismatch allowed

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
search sequences by ID/name/sequence/sequence motifs, mismatch allowed

Attention:

  0. By default, we match sequence ID with patterns, use "-n/--by-name"
     for matching full name instead of just ID.
  1. Unlike POSIX/GNU grep, we compare the pattern to the whole target
     (ID/full header) by default. Please switch "-r/--use-regexp" on
     for partly matching.
  2. When searching by sequences, it's partly matching, and both positive
     and negative strands are searched.
     Please switch on "-P/--only-positive-strand" if you would like to
     search only on the positive strand.
     Mismatch is allowed using flag "-m/--max-mismatch", you can increase
     the value of "-j/--threads" to accelerate processing.
  3. Degenerate bases/residues like "RYMM.." are also supported by flag -d.
     But do not use degenerate bases/residues in regular expression, you need
     convert them to regular expression, e.g., change "N" or "X"  to ".".
  4. When providing search patterns (motifs) via flag '-p',
     please use double quotation marks for patterns containing comma, 
     e.g., -p '"A{2,}"' or -p "\"A{2,}\"". Because the command line argument
     parser accepts comma-separated-values (CSV) for multiple values (motifs).
     Patterns in file do not follow this rule.
  5. The order of sequences in result is consistent with that in original
     file, not the order of the query patterns. 
     But for FASTA file, you can use:
        seqkit faidx seqs.fasta --infile-list IDs.txt
  6. For multiple patterns, you can either set "-p" multiple times, i.e.,
     -p pattern1 -p pattern2, or give a file of patterns via "-f/--pattern-file".

Tips:
  1. Empty patterns are allowed. So you can search records with empty ID or sequence.
        seqkit grep    -p "" t.fa     # empty ID
        seqkit grep -s -p "" t.fa     # empty sequence

You can specify the sequence region for searching with the flag -R (--region).
The definition of region is 1-based and with some custom design.

Examples:

 1-based index    1 2 3 4 5 6 7 8 9 10
negative index    0-9-8-7-6-5-4-3-2-1
           seq    A C G T N a c g t n
           1:1    A
           2:4      C G T
         -4:-2                c g t
         -4:-1                c g t n
         -1:-1                      n
          2:-2      C G T N a c g t
          1:-1    A C G T N a c g t n
          1:12    A C G T N a c g t n
        -12:-1    A C G T N a c g t n

Usage:
  seqkit grep [flags] 

Flags:
  -D, --allow-duplicated-patterns   output records multiple times when duplicated patterns are given
  -n, --by-name                     match by full name instead of just ID
  -s, --by-seq                      search subseq on seq. Both positive and negative strand are searched
                                    by default, you might use -P/--only-positive-strand. Mismatch
                                    allowed using flag -m/--max-mismatch
  -c, --circular                    circular genome
  -C, --count                       just print a count of matching records. with the -v/--invert-match
                                    flag, count non-matching records
  -d, --degenerate                  pattern/motif contains degenerate base
      --delete-matched              delete a pattern right after being matched, this keeps the firstly
                                    matched data and speedups when using regular expressions
  -h, --help                        help for grep
  -i, --ignore-case                 ignore case
  -I, --immediate-output            print output immediately, do not use write buffer
  -v, --invert-match                invert the sense of matching, to select non-matching records
  -m, --max-mismatch int            max mismatch when matching by seq. For large genomes like human
                                    genome, using mapping/alignment tools would be faster
  -P, --only-positive-strand        only search on the positive strand
  -p, --pattern strings             search pattern. Multiple values supported: comma-separated (e.g., -p
                                    "p1,p2") OR use -p multiple times (e.g., -p p1 -p p2). Make sure to
                                    quote literal commas, e.g. in regex patterns '"A{2,}"'
  -f, --pattern-file string         pattern file (one record per line)
  -R, --region string               specify sequence region for searching. e.g 1:12 for first 12 bases,
                                    -12:-1 for last 12 bases
  -r, --use-regexp                  patterns are regular expression

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_locate

### Tool Description
locate subsequences/motifs, mismatch allowed

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
locate subsequences/motifs, mismatch allowed

Attention:

  1. Motifs could be EITHER plain sequence containing "ACTGN" OR regular
     expression like "A[TU]G(?:.{3})+?[TU](?:AG|AA|GA)" for ORFs.     
  2. Degenerate bases/residues like "RYMM.." are also supported by flag -d.
     But do not use degenerate bases/residues in regular expression, you need
     convert them to regular expression, e.g., change "N" or "X"  to ".".
  3. When providing search patterns (motifs) via flag '-p',
     please use double quotation marks for patterns containing comma, 
     e.g., -p '"A{2,}"' or -p "\"A{2,}\"". Because the command line argument
     parser accepts comma-separated-values (CSV) for multiple values (motifs).
     Patterns in file do not follow this rule.     
  4. Mismatch is allowed using flag "-m/--max-mismatch",
     you can increase the value of "-j/--threads" to accelerate processing.
  5. When using flag --circular, end position of matched subsequence that 
     crossing genome sequence end would be greater than sequence length.

Usage:
  seqkit locate [flags] 

Flags:
      --bed                    output in BED6 format
  -c, --circular               circular genome. type "seqkit locate -h" for details
  -d, --degenerate             pattern/motif contains degenerate base
      --gtf                    output in GTF format
  -h, --help                   help for locate
  -M, --hide-matched           do not show matched sequences
  -i, --ignore-case            ignore case
  -I, --immediate-output       print output immediately, do not use write buffer
  -s, --max-len-to-show int    show at most X characters for the search pattern or matched sequences
  -m, --max-mismatch int       max mismatch when matching by seq. For large genomes like human genome,
                               using mapping/alignment tools would be faster
  -G, --non-greedy             non-greedy mode, faster but may miss motifs overlapping with others
  -P, --only-positive-strand   only search on positive strand
  -p, --pattern strings        pattern/motif. Multiple values supported: comma-separated (e.g., -p
                               "p1,p2") OR use -p multiple times (e.g., -p p1 -p p2). Make sure to quote
                               literal commas, e.g. in regex patterns '"A{2,}"'
  -f, --pattern-file string    pattern/motif file (FASTA format)
  -F, --use-fmi                use FM-index for much faster search of lots of sequence patterns
  -r, --use-regexp             patterns/motifs are regular expression

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_common

### Tool Description
find common/shared sequences of multiple files by id/name/sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
find common/shared sequences of multiple files by id/name/sequence

Note:
  1. 'seqkit common' is designed to support 2 and MORE files.
  2. When comparing by sequences,
     a) Both positive and negative strands are compared. You can switch on
        -P/--only-positive-strand for considering the positive strand only.
     b) You can switch on -e/--check-embedded-seqs to check embedded sequences.
          e.g, for file A and B, the reverse complement sequence of CCCC from file B
          is a part of TTGGGGTT from file A, we will extract and output GGGG from file A.
          If sequences CCC exist in other files except file A, we will skip it,
          as it is an embedded subsequence of GGGG.
        It is recommended to put the smallest file as the first file, for saving
        memory usage.
  3. For 2 files, 'seqkit grep' is much faster and consumes lesser memory:
       seqkit grep -f <(seqkit seq -n -i small.fq.gz) big.fq.gz # by seq ID
     But note that searching by sequence would be much slower, as it's partly
     string matching.
       seqkit grep -s -f <(seqkit seq -s small.fq.gz) big.fq.gz # much slower!!!!
  4. Some records in one file may have same sequences/IDs. They will ALL be
     retrieved if the sequence/ID was shared in multiple files.
     So the records number may be larger than that of the smallest file.

Usage:
  seqkit common [flags] 

Flags:
  -n, --by-name                match by full name instead of just id
  -s, --by-seq                 match by sequence
  -e, --check-embedded-seqs    check embedded sequences, e.g., if a sequence is part of another one,
                               we'll keep the shorter one
  -h, --help                   help for common
  -i, --ignore-case            ignore case
  -P, --only-positive-strand   only considering the positive strand when comparing by sequence

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_duplicate

### Tool Description
duplicate sequences N times

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
duplicate sequences N times

You may need "seqkit rename" to make the the sequence IDs unique.

Usage:
  seqkit duplicate [flags] 

Aliases:
  duplicate, dup

Flags:
  -h, --help        help for duplicate
  -n, --times int   duplication number (default 1)

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_head

### Tool Description
print the first N FASTA/Q records, or leading records whose total length >= L

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
print the first N FASTA/Q records, or leading records whose total length >= L

For returning the last N records, use:
    seqkit range -r -N:-1 seqs.fasta

Usage:
  seqkit head [flags] 

Flags:
  -h, --help            help for head
  -l, --length string   print leading FASTA/Q records whose total sequence length >= L (supports K/M/G
                        suffix). This flag overrides -n/--number
  -n, --number int      print the first N FASTA/Q records (default 10)

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_head-genome

### Tool Description
print sequences of the first genome with common prefixes in name

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
print sequences of the first genome with common prefixes in name

For a FASTA file containing multiple contigs of strains (see example below),
these's no list of IDs available for retrieving sequences of a certain strain,
while descriptions of each strain share the same prefix.

This command is used to restrieve sequences of the first strain,
i.e., "Vibrio cholerae strain M29".

>NZ_JFGR01000001.1 Vibrio cholerae strain M29 Contig_1, whole genome shotgun sequence
>NZ_JFGR01000002.1 Vibrio cholerae strain M29 Contig_2, whole genome shotgun sequence
>NZ_JFGR01000003.1 Vibrio cholerae strain M29 Contig_3, whole genome shotgun sequence
>NZ_JSTP01000001.1 Vibrio cholerae strain 2012HC-12 NODE_79, whole genome shotgun sequence
>NZ_JSTP01000002.1 Vibrio cholerae strain 2012HC-12 NODE_78, whole genome shotgun sequence

Attention:

  1. Sequences in file should be well organized.

Usage:
  seqkit head-genome [flags] 

Flags:
  -h, --help                    help for head-genome
  -m, --mini-common-words int   minimal shared prefix words (default 1)

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_pair

### Tool Description
match up paired-end reads from two fastq files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
match up paired-end reads from two fastq files

Attention:
1. Orders of headers in the two files should be the same (not shuffled),
   otherwise, it consumes a huge number of memory for buffering reads in memory.
2. Unpaired reads are optional outputted with the flag -u/--save-unpaired.
3. If the flag -O/--out-dir is not given, the output will be saved in the same directory
   of input, with the suffix "paired", e.g., read_1.paired.fq.gz.
   Otherwise, names are kept untouched in the given output directory.
4. Paired gzipped files may be slightly larger than original files, because
   of using a different gzip package/library, don't worry.

Tips:
1. Support for '/1 'and '/2' tags for paired read files generated by platforms like MGI.
   You can simply specify the regular expression for extracting sequence IDs:
     --id-regexp '^(\S+)\/[12]'

Usage:
  seqkit pair [flags] 

Flags:
  -f, --force            overwrite output directory
  -h, --help             help for pair
  -O, --out-dir string   output directory
  -1, --read1 string     (gzipped) read1 file
  -2, --read2 string     (gzipped) read2 file
  -u, --save-unpaired    save unpaired reads if there are

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_range

### Tool Description
print FASTA/Q records in a range (start:end)

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
print FASTA/Q records in a range (start:end)

Examples:
  1. leading 100 records (head -n 100)
      seqkit range -r 1:100
  2. last 100 records (tail -n 100)
      seqkit range -r -100:-1
  3. remove leading 100 records (tail -n +101)
      seqkit range -r 101:-1
  4. other ranges:
      seqkit range -r 10:100
      seqkit range -r -100:-10

Usage:
  seqkit range [flags] 

Flags:
  -h, --help           help for range
  -r, --range string   range. e.g., 1:12 for first 12 records (head -n 12), -12:-1 for last 12 records
                       (tail -n 12)

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_rmdup

### Tool Description
remove duplicated sequences by ID/name/sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
remove duplicated sequences by ID/name/sequence

Attention:
  1. When comparing by sequences, both positive and negative strands are
     compared. Switch on -P/--only-positive-strand for considering the
     positive strand only.
  2. Only the first record is saved for duplicates.

Usage:
  seqkit rmdup [flags] 

Flags:
  -n, --by-name                by full name instead of just id
  -s, --by-seq                 by seq
  -D, --dup-num-file string    file to save numbers and ID lists of duplicated seqs
  -d, --dup-seqs-file string   file to save duplicated seqs
  -h, --help                   help for rmdup
  -i, --ignore-case            ignore case
  -P, --only-positive-strand   only considering positive strand when comparing by sequence

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_sample

### Tool Description
sample sequences by number or proportion.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
sample sequences by number or proportion.

Attention:
1. Do not use '-n' on large FASTQ files, it loads all seqs into memory!
   use 'seqkit sample -p 0.1 seqs.fq.gz | seqkit head -n N' instead!

Usage:
  seqkit sample [flags] 

Flags:
  -h, --help               help for sample
  -n, --number int         sample by number (result may not exactly match), DO NOT use on large FASTQ files.
  -p, --proportion float   sample by proportion
  -s, --rand-seed int      random seed. For paired-end data, use the same seed across fastq files to
                           sample the same read pairs (default 11)
  -2, --two-pass           2-pass mode read files twice to lower memory usage. Not allowed when reading
                           from stdin

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_split

### Tool Description
split sequences into files by name ID, subsequence of given region, part size or number of parts.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
split sequences into files by name ID, subsequence of given region,
part size or number of parts.

If you just want to split by parts or sizes, please use "seqkit split2",
which can apply to paired- and single-end FASTQ.

If you want to split sequences by ID, please use "seqkit split2 -s 1 -N".

If you want to cut a sequence into multiple segments.
  1. For cutting into even chunks, please use 'kmcp utils split-genomes'
     (https://bioinf.shenwei.me/kmcp/usage/#split-genomes).
     E.g., cutting into 4 segments of equal size, with no overlap between adjacent segments:
        kmcp utils split-genomes -m 1 -k 1 --split-number 4 --split-overlap 0 input.fasta -O out
  2. For cutting into multiple chunks of fixed size, please using 'seqkit sliding'.
     E.g., cutting into segments of 40 bp and keeping the last segment which can be shorter than 40 bp.
        seqkit sliding -g -s 40 -W 40 input.fasta -o out.fasta

Attention:
  1. For the two-pass mode (-2/--two-pass), The flag -U/--update-faidx is recommended to
     ensure the .fai file matches the FASTA file.
  2. For splitting by sequence IDs in Windows/MacOS, where the file systems might be case-insensitive,
     output files might be overwritten if they are only different in cases, like Abc and ABC.
     To avoid this, please switch one -I/--ignore-case.

The definition of region is 1-based and with some custom design.

Examples:

 1-based index    1 2 3 4 5 6 7 8 9 10
negative index    0-9-8-7-6-5-4-3-2-1
           seq    A C G T N a c g t n
           1:1    A
           2:4      C G T
         -4:-2                c g t
         -4:-1                c g t n
         -1:-1                      n
          2:-2      C G T N a c g t
          1:-1    A C G T N a c g t n
          1:12    A C G T N a c g t n
        -12:-1    A C G T N a c g t n

Usage:
  seqkit split [flags] 

Flags:
  -i, --by-id                     split squences according to sequence ID
      --by-id-prefix string       file prefix for --by-id
  -p, --by-part int               split sequences into N parts
      --by-part-prefix string     file prefix for --by-part
  -r, --by-region string          split squences according to subsequence of given region. e.g 1:12 for
                                  first 12 bases, -12:-1 for last 12 bases. type "seqkit split -h" for
                                  more examples
      --by-region-prefix string   file prefix for --by-region
  -s, --by-size int               split sequences into multi parts with N sequences
      --by-size-prefix string     file prefix for --by-size
  -d, --dry-run                   dry run, just print message and no files will be created.
  -e, --extension string          set output file extension, e.g., ".gz", ".xz", or ".zst"
  -f, --force                     overwrite output directory
  -h, --help                      help for split
  -I, --ignore-case               ignore case when using -i/--by-id
  -k, --keep-temp                 keep temporary FASTA and .fai file when using 2-pass mode
  -O, --out-dir string            output directory (default value is $infile.split)
  -2, --two-pass                  two-pass mode read files twice to lower memory usage. (only for FASTA
                                  format)
  -U, --update-faidx              update the fasta index file if it exists. Use this if you are not sure
                                  whether the fasta file changed

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_split2

### Tool Description
split sequences into files by part size or number of parts

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
split sequences into files by part size or number of parts

This command supports FASTA and paired- or single-end FASTQ with low memory
occupation and fast speed.

The prefix of output files:
  1. For stdin: stdin
  2. Others: same to the input file
  3. Set via the options: --by-length-prefix, --by-part-prefix, or --by-size-prefix
  4. Use the ID of the first sequence in each subset.
     E.g, 'seqkit split2 --by-size 1 --seqid-as-filename' is equal to
     'seqkit split --by-id', but it's much faster and uses less memory.

The extension of output files:
  1. For stdin: .fast[aq]
  2. Others: same to the input file
  3. Additional extension via the option -e/--extension, e.g.， outputting
     gzipped files for plain text input:
         seqkit split2 -p 2 -O test tests/hairpin.fa -e .gz


If you want to cut a sequence into multiple segments.
  1. For cutting into even chunks, please use 'kmcp utils split-genomes'
     (https://bioinf.shenwei.me/kmcp/usage/#split-genomes).
     E.g., cutting into 4 segments of equal size, with no overlap between adjacent segments:
        kmcp utils split-genomes -m 1 -k 1 --split-number 4 --split-overlap 0 input.fasta -O out
  2. For cutting into multiple chunks of fixed size, please using 'seqkit sliding'.
     E.g., cutting into segments of 40 bp and keeping the last segment which can be shorter than 40 bp.
        seqkit sliding -g -s 40 -W 40 input.fasta -o out.fasta

Usage:
  seqkit split2 [flags] 

Flags:
  -l, --by-length string          split sequences into chunks of >=N bases, supports K/M/G suffix
      --by-length-prefix string   file prefix for --by-length. The placeholder "{read}" is needed for
                                  paired-end files.
  -p, --by-part int               split sequences into N parts with the round robin distribution
      --by-part-prefix string     file prefix for --by-part. The placeholder "{read}" is needed for
                                  paired-end files.
  -s, --by-size int               split sequences into multi parts with N sequences
      --by-size-prefix string     file prefix for --by-size. The placeholder "{read}" is needed for
                                  paired-end files.
  -e, --extension string          set output file extension, e.g., ".gz", ".xz", or ".zst"
  -f, --force                     overwrite output directory
  -h, --help                      help for split2
  -O, --out-dir string            output directory (default value is $infile.split)
  -1, --read1 string              (gzipped) read1 file
  -2, --read2 string              (gzipped) read2 file
  -N, --seqid-as-filename         use the first sequence ID as the file name. E.g., using '-N -s 1' is
                                  equal to 'seqkit split --by-id' but much faster and uses less memory.

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_concat

### Tool Description
concatenate sequences with same ID from multiple files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
concatenate sequences with same ID from multiple files

Attention:
   1. By default, only sequences with IDs that appear in all files are outputted.
      use -f/--full to output all sequences.
      * If you are processing multiple-sequence-alignment results, you can use
        -F/--fill to fill with N bases/residues for IDs missing in some files when
        using -f/--full.
   2. If there are more than one sequences of the same ID, we output the Cartesian
      product of sequences.
   3. Description are also concatenated with a separator (-s/--separator).
   4. Order of sequences with different IDs are random.

Usage:
  seqkit concat [flags] 

Aliases:
  concat, concate

Flags:
  -F, --fill string        fill with N bases/residues for IDs missing in some files when using -f/--full
  -f, --full               keep all sequences, like full/outer join
  -h, --help               help for concat
  -s, --separator string   separator for descriptions of records with the same ID (default "|")

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_mutate

### Tool Description
edit sequence (point mutation, insertion, deletion)

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
edit sequence (point mutation, insertion, deletion)

Attention:

  1. Multiple point mutations (-p/--point) are allowed, but only single
     insertion (-i/--insertion) OR single deletion (-d/--deletion) is allowed.
  2. Point mutation takes place before insertion/deletion.

Notes:

  1. You can choose certain sequences to edit using similar flags in
     'seqkit grep'.

The definition of position is 1-based and with some custom design.

Examples:

 1-based index    1 2 3 4 5 6 7 8 9 10
negative index    0-9-8-7-6-5-4-3-2-1
           seq    A C G T N a c g t n
           1:1    A
           2:4      C G T
         -4:-2                c g t
         -4:-1                c g t n
         -1:-1                      n
          2:-2      C G T N a c g t
          1:-1    A C G T N a c g t n
          1:12    A C G T N a c g t n
        -12:-1    A C G T N a c g t n

Usage:
  seqkit mutate [flags] 

Flags:
  -n, --by-name               [match seqs to mutate] match by full name instead of just id
  -d, --deletion string       deletion mutation: deleting subsequence in a range. e.g., -d 1:2 for
                              deleting leading two bases, -d -3:-1 for removing last 3 bases
  -h, --help                  help for mutate
  -I, --ignore-case           [match seqs to mutate] ignore case of search pattern
  -i, --insertion string      insertion mutation: inserting bases behind of given position, e.g., -i
                              0:ACGT for inserting ACGT at the beginning, -1:* for add * to the end
  -v, --invert-match          [match seqs to mutate] invert the sense of matching, to select
                              non-matching records
  -s, --pattern strings       [match seqs to mutate] search pattern .Multiple values supported:
                              comma-separated (e.g., -p "p1,p2") OR use -p multiple times (e.g., -p p1
                              -p p2). Make sure to quote literal commas, e.g. in regex patterns '"A{2,}"'
  -f, --pattern-file string   [match seqs to mutate] pattern file (one record per line)
  -p, --point strings         point mutation: changing base at given position. e.g., -p 2:C for setting
                              2nd base as C, -p -1:A for change last base as A
  -r, --use-regexp            [match seqs to mutate] search patterns are regular expression

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_rename

### Tool Description
Rename duplicated IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
rename duplicated IDs

Attention:
  1. This command only appends "_N" to duplicated sequence IDs to make them unique.
  2. Use "seqkit replace" for editing sequence IDs/headers using regular expression.

Example:

    $ seqkit seq seqs.fasta 
    >id comment
    actg
    >id description
    ACTG

    $ seqkit rename seqs.fasta
    >id comment
    actg
    >id_2 description
    ACTG

Usage:
  seqkit rename [flags] 

Flags:
  -n, --by-name             check duplication by full name instead of just id
  -f, --force               overwrite output directory
  -h, --help                help for rename
  -m, --multiple-outfiles   write results into separated files for multiple input files
  -O, --out-dir string      output directory (default "renamed")
  -1, --rename-1st-rec      rename the first record as well
  -s, --separator string    separator between original ID/name and the counter (default "_")
  -N, --start-num int       starting count number for *duplicated* IDs/names, should be greater than
                            zero (default 2)

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_replace

### Tool Description
replace name/sequence by regular expression.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
replace name/sequence by regular expression.

Note that the replacement supports capture variables.
e.g. $1 represents the text of the first submatch.
ATTENTION: use SINGLE quote NOT double quotes in *nix OS.

Examples: Adding space to all bases.

    seqkit replace -p "(.)" -r '$1 ' -s

Or use the \ escape character.

    seqkit replace -p "(.)" -r "\$1 " -s

more on: http://bioinf.shenwei.me/seqkit/usage/#replace

Special replacement symbols (only for replacing name not sequence):

    {nr}    Record number, starting from 1
    {uuid}  Random 16-character Universally unique identifier (UUID)
    {fn}    File name
    {fbn}   File base name
    {fbne}  File base name without any extension
    {kv}    Corresponding value of the key (captured variable $n) by key-value file,
            n can be specified by flag -I (--key-capt-idx) (default: 1)
            
Special cases:
  1. If replacements contain '$', 
    a). If using '{kv}', you need use '$$$$' instead of a single '$':
            -r '{kv}' -k <(sed 's/\$/$$$$/' kv.txt)
    b). If not, use '$$':
            -r 'xxx$$xx'

Filtering records to edit:
  You can use flags similar to those in "seqkit grep" to choose partly records to edit.

Usage:
  seqkit replace [flags] 

Flags:
  -s, --by-seq                   replace seq (only FASTA)
      --f-by-name                [target filter] match by full name instead of just ID
      --f-by-seq                 [target filter] search subseq on seq, both positive and negative strand
                                 are searched, and mismatch allowed using flag -m/--max-mismatch
      --f-ignore-case            [target filter] ignore case
      --f-invert-match           [target filter] invert the sense of matching, to select non-matching records
      --f-only-positive-strand   [target filter] only search on positive strand
      --f-pattern strings        [target filter] search pattern (multiple values supported. Attention:
                                 use double quotation marks for patterns containing comma, e.g., -p
                                 '"A{2,}"')
      --f-pattern-file string    [target filter] pattern file (one record per line)
      --f-use-regexp             [target filter] patterns are regular expression
  -h, --help                     help for replace
  -i, --ignore-case              ignore case
  -K, --keep-key                 keep the key as value when no value found for the key (only for
                                 sequence name)
  -U, --keep-untouch             do not change anything when no value found for the key (only for
                                 sequence name)
  -I, --key-capt-idx int         capture variable index of key (1-based) (default 1)
  -m, --key-miss-repl string     replacement for key with no corresponding value
  -k, --kv-file string           tab-delimited key-value file for replacing key with value when using
                                 "{kv}" in -r (--replacement) (only for sequence name)
      --nr-width int             minimum width for {nr} in flag -r/--replacement. e.g., formatting "1"
                                 to "001" by --nr-width 3 (default 1)
  -p, --pattern string           search regular expression
  -r, --replacement string       replacement. supporting capture variables.  e.g. $1 represents the text
                                 of the first submatch (use ${1} instead of $1 when {kv} given!).
                                 ATTENTION: for *nix OS, use SINGLE quote NOT double quotes or use the \
                                 escape character. Record number and file name is also supported by
                                 "{nr}" and "{fn}". Type "csvtk replace -h" for more replacement symbols.

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_restart

### Tool Description
reset start position for circular genome

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
reset start position for circular genome

Examples

    $ echo -e ">seq\nacgtnACGTN"
    >seq
    acgtnACGTN

    $ echo -e ">seq\nacgtnACGTN" | seqkit restart -i 2
    >seq
    cgtnACGTNa

    $ echo -e ">seq\nacgtnACGTN" | seqkit restart -i -2
    >seq
    TNacgtnACG

Usage:
  seqkit restart [flags] 

Aliases:
  restart, rotate

Flags:
  -h, --help            help for restart
  -i, --new-start int   new start position (1-base, supporting negative value counting from the end)
                        (default 1)

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_sana

### Tool Description
sanitize broken single line FASTQ files
Sana is a resilient FASTQ/FASTA parser. Unlike many parsers,
it won't stop at the first error. Instead, it skips malformed records
and continues processing the file.

Sana currently supports this FASTQ dialect:

  - One line for each sequence and quality value

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
sanitize broken single line FASTQ files

Sana is a resilient FASTQ/FASTA parser. Unlike many parsers,
it won't stop at the first error. Instead, it skips malformed records
and continues processing the file.

Sana currently supports this FASTQ dialect:

  - One line for each sequence and quality value

Usage:
  seqkit sana [flags] 

Flags:
  -A, --allow-gaps            allow gap character (-) in sequences
  -i, --format string         input and output format: fastq or fasta (default "fastq")
  -h, --help                  help for sana
  -I, --in-format string      input format: fastq or fasta
  -O, --out-format string     output format: fastq or fasta
  -b, --qual-ascii-base int   ASCII BASE, 33 for Phred+33 (default 33)

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_shuffle

### Tool Description
shuffle sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
shuffle sequences.

By default, all records will be readed into memory.
For FASTA format, use flag -2 (--two-pass) to reduce memory usage. FASTQ not
supported. 

Firstly, seqkit reads the sequence IDs. If the file is not plain FASTA file,
seqkit will write the sequences to temporary files, and create FASTA index.

Secondly, seqkit shuffles sequence IDs and extract sequences by FASTA index.

Attention:
  1. For the two-pass mode (-2/--two-pass), The flag -U/--update-faidx is recommended to
     ensure the .fai file matches the FASTA file.

Usage:
  seqkit shuffle [flags] 

Flags:
  -h, --help            help for shuffle
  -k, --keep-temp       keep temporary FASTA and .fai file when using 2-pass mode
  -s, --rand-seed int   rand seed for shuffle (default 23)
  -2, --two-pass        two-pass mode read files twice to lower memory usage. (only for FASTA format)
  -U, --update-faidx    update the fasta index file if it exists. Use this if you are not sure whether
                        the fasta file changed

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_sort

### Tool Description
sort sequences by id/name/sequence/length.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
sort sequences by id/name/sequence/length.

By default, all records will be readed into memory.
For FASTA format, use flag -2 (--two-pass) to reduce memory usage. FASTQ not
supported.

Firstly, seqkit reads the sequence head and length information.
If the file is not plain FASTA file,
seqkit will write the sequences to temporary files, and create FASTA index.

Secondly, seqkit sorts sequence by head and length information
and extracts sequences by FASTA index.

Attention:
  1. For the two-pass mode (-2/--two-pass), The flag -U/--update-faidx is recommended to
     ensure the .fai file matches the FASTA file.

Usage:
  seqkit sort [flags] 

Flags:
  -b, --by-bases                by non-gap bases
  -l, --by-length               by sequence length
  -n, --by-name                 by full name instead of just id
  -s, --by-seq                  by sequence
  -G, --gap-letters string      gap letters (default "- \t.")
  -h, --help                    help for sort
  -i, --ignore-case             ignore case
  -k, --keep-temp               keep temporary FASTA and .fai file when using 2-pass mode
  -N, --natural-order           sort in natural order, when sorting by IDs/full name
  -r, --reverse                 reverse the result
  -L, --seq-prefix-length int   length of sequence prefix on which seqkit sorts by sequences (0 for
                                whole sequence) (default 10000)
  -2, --two-pass                two-pass mode read files twice to lower memory usage. (only for FASTA format)
  -U, --update-faidx            update the fasta index file if it exists. Use this if you are not sure
                                whether the fasta file changed

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_bam

### Tool Description
monitoring and online histograms of BAM record features

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
monitoring and online histograms of BAM record features

Usage:
  seqkit bam [flags] 

Flags:
  -B, --bins int             number of histogram bins (default -1)
  -N, --bundle int           partition BAM file into loci (-1) or bundles with this minimum size
  -c, --count string         count reads per reference and save to this file
  -W, --delay int            sleep this many seconds after plotting (default 1)
  -y, --dump                 print histogram data to stderr instead of plotting
  -G, --exclude-ids string   exclude records with IDs contained in this file
  -e, --exec-after string    execute command after reporting
  -E, --exec-before string   execute command before reporting
  -f, --field string         target fields
  -g, --grep-ids string      only keep records with IDs contained in this file
  -h, --help                 help for bam
  -C, --idx-count            fast read per reference counting based on the BAM index
  -i, --idx-stat             fast statistics based on the BAM index
  -O, --img string           save histogram to this PDF/image file
  -H, --list-fields          list all available BAM record features
  -L, --log                  log10(x+1) transform numeric values
  -q, --map-qual int         minimum mapping quality
  -x, --pass                 passthrough mode (forward filtered BAM to output)
  -k, --pretty               pretty print certain TSV outputs
  -F, --prim-only            filter out non-primary alignment records
  -p, --print-freq int       print/report after this many records (-1 for print after EOF) (default -1)
  -Q, --quiet-mode           supress all plotting to stderr
  -M, --range-max float      discard record with field (-f) value greater than this flag (default NaN)
  -m, --range-min float      discard record with field (-f) value less than this flag (default NaN)
  -R, --reset                reset histogram after every report
  -Z, --silent-mode          supress TSV output to stderr
  -s, --stat                 print BAM satistics of the input files
  -T, --tool string          invoke toolbox in YAML format (see documentation)
  -@, --top-bam string       save the top -? records to this bam file
  -?, --top-size int         size of the top-mode buffer (default 100)

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_merge-slides

### Tool Description
merge sliding windows generated from seqkit sliding

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
merge sliding windows generated from seqkit sliding

For example,

    ref.contig00001_sliding:454531-454680
    ref.contig00001_sliding:454561-454710
    ref.contig00001_sliding:454591-454740
    ref.contig00002_sliding:362281-362430
    ref.contig00002_sliding:362311-362460
    ref.contig00002_sliding:362341-362490
    ref.contig00002_sliding:495991-496140
    ref.contig00044_sliding:1-150
    ref.contig00044_sliding:31-180
    ref.contig00044_sliding:61-210
    ref.contig00044_sliding:91-240

could be merged into

    ref.contig00001 454530  454740
    ref.contig00002 362280  362490
    ref.contig00002 495990  496140
    ref.contig00044 0       240

Output (BED3 format):
    1. chrom      - chromosome name
    2. chromStart - starting position (0-based)
    3. chromEnd   - ending position (0-based)

Usage:
  seqkit merge-slides [flags] 

Flags:
  -b, --buffer-size string            size of buffer, supported unit: K, M, G. You need increase the
                                      value when "bufio.Scanner: token too long" error reported (default
                                      "1G")
  -p, --comment-line-prefix strings   comment line prefix (default [#,//])
  -h, --help                          help for merge-slides
  -g, --max-gap int                   maximum distance of starting positions of two adjacent regions, 0
                                      for no limitation, 1 for no merging.
  -l, --min-overlap int               minimum overlap of two adjacent regions, recommend
                                      $sliding_step_size - 1. (default 1)
  -r, --regexp string                 regular expression for extract the reference name and window
                                      position. (default "^(.+)_sliding:(\\d+)\\-(\\d+)")

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## seqkit_sum

### Tool Description
compute message digest for all sequences in FASTA/Q files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
- **Homepage**: https://github.com/shenwei356/seqkit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqkit/overview
- **Validation**: PASS

### Original Help Text
```text
compute message digest for all sequences in FASTA/Q files

Attention:
  1. Sequence headers and qualities are skipped, only sequences matter.
  2. The order of sequences records does not matter.
  3. Circular complete genomes are supported with the flag -c/--circular.
     - The same double-stranded genomes with different start positions or
       in reverse complement strand will not affect the result.
     - For single-stranded genomes like ssRNA genomes, use -s/--single-strand.
     - The message digest would change with different values of k-mer size.
  4. Multiple files are processed in parallel (-j/--threads).

Method:
  1. Converting the sequences to low cases, optionally removing gaps (-g).
  2. Computing the hash (xxhash) for all sequences or k-mers of a circular
     complete genome (-c/--circular).
  3. Sorting all hash values, for ignoring the order of sequences.
  4. Computing MD5 digest from the hash values, sequences length, and
     the number of sequences.

Following the seqhash in Poly (https://github.com/TimothyStiles/poly/),
We add meta information to the message digest, with the format of:

    seqkit.<version>_<seq type><seq structure><strand>_<kmer size>_<seq digest>

    <version>:       digest version
    <seq type>:      'D' for DNA, 'R' for RNA, 'P' for protein, 'N' for others
    <seq structure>: 'L' for linear sequence, 'C' for circular genome
    <strand>:        'D' for double-stranded, 'S' for single-stranded
    <kmer size>:     0 for linear sequence, other values for circular genome

Examples:

    seqkit.v0.1_DLS_k0_176250c8d1cde6c385397df525aa1a94    DNA.fq.gz
    seqkit.v0.1_PLS_k0_c244954e4960dd2a1409cd8ee53d92b9    Protein.fasta
    seqkit.v0.1_RLS_k0_0f1fb263f0c05a259ae179a61a80578d    single-stranded RNA.fasta

    seqkit.v0.1_DCD_k31_e59dad6d561f1f1f28ebf185c6f4c183   double-stranded-circular DNA.fasta
    seqkit.v0.1_DCS_k31_dd050490cd62ea5f94d73d4d636b7d60   single-stranded-circular DNA.fasta

Usage:
  seqkit sum [flags] 

Flags:
  -a, --all                  show all information, including the sequences length and the number of sequences
  -b, --basename             only output basename of files
  -c, --circular             the file contains a single cicular genome sequence
  -G, --gap-letters string   gap letters to delete with the flag -g/--remove-gaps (default "- \t.*")
  -h, --help                 help for sum
  -k, --kmer-size int        k-mer size for processing circular genomes (default 1000)
  -g, --remove-gaps          remove gap characters set in the option -G/gap-letters
      --rna2dna              convert RNA to DNA
  -s, --single-strand        only consider the positive strand of a circular genome, e.g., ssRNA virus
                             genomes

Global Flags:
      --alphabet-guess-seq-length int   length of sequence prefix of the first FASTA record based on
                                        which seqkit guesses the sequence type (0 for whole seq)
                                        (default 10000)
      --compress-level int              compression level for gzip, zstd, xz and bzip2. type "seqkit -h"
                                        for the range and default value for each format (default -1)
      --id-ncbi                         FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|
                                        Pseud...
      --id-regexp string                regular expression for parsing ID (default "^(\\S+)\\s?")
  -X, --infile-list string              file of input files list (one file per line), if given, they are
                                        appended to files from cli arguments
  -w, --line-width int                  line width when outputting FASTA format (0 for no wrap) (default 60)
  -o, --out-file string                 out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
      --quiet                           be quiet and do not show extra information
  -t, --seq-type string                 sequence type (dna|rna|protein|unlimit|auto) (for auto, it
                                        automatically detect by the first sequence) (default "auto")
      --skip-file-check                 skip input file checking when given a file list if you believe
                                        these files do exist
  -j, --threads int                     number of CPUs. can also set with environment variable
                                        SEQKIT_THREADS) (default 4)
```


## Metadata
- **Skill**: generated
