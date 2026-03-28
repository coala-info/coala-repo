# seqfu CWL Generation Report

## seqfu_bases

### Tool Description
Print the DNA bases, and %GC content, in the input files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Total Downloads**: 162.6K
- **Last updated**: 2025-12-23
- **GitHub**: https://github.com/quadram-institute-bioscience/seqfu
- **Stars**: N/A
### Original Help Text
```text
Usage: bases [options] [<inputfile> ...]

Print the DNA bases, and %GC content, in the input files

Options:
  -c, --raw-counts       Print counts and not ratios
  -t, --thousands        Print thousands separator
  -a, --abspath          Print absolute path 
  -b, --basename         Print the basename of the file
  -n, --nice             Print terminal table
  -d, --digits INT       Number of digits to print [default: 2]
  -H, --header           Print header
  -v, --verbose          Verbose output
  --debug                Debug output
  --help                 Show this help
```


## seqfu_check

### Tool Description
Check the integrity of FASTQ files, returns non zero
  if an error occurs. Will print a table with a report.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seqfu check [options] <FQFILE> [<REV>]
       seqfu check [options] --dir <FQDIR>

  Check the integrity of FASTQ files, returns non zero
  if an error occurs. Will print a table with a report.

  Input is a single dataset:
    <FQFILE>                   the forward read file
    <REV>                      the reverse read file
  or a directory of FASTQ files (--dir):
    <FQDIR>                    the directory containing the FASTQ files

  Options:
    -d, --deep                 Perform a deep check of the file and will not 
                               lsupport multiline Sanger FASTQ [default: false]
    -n, --no-paired            Disable autodetection of second pair
    -s, --safe-exit            Exit with 0 even if errors are found
    -q, --quiet                Do not print infos, just exit status
    -v, --verbose              Verbose output 
    -t, --thousands            Print numbers with thousands separator
    --debug                    Debug output
    -h, --help                 Show this help
```


## seqfu_count

### Tool Description
Count sequences in paired-end aware format

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: count [options] [<inputfile> ...]

Count sequences in paired-end aware format

Options:
  -a, --abs-path         Print absolute paths
  -b, --basename         Print only filenames
  -u, --unpair           Print separate records for paired end files
  -f, --for-tag R1       Forward tag [default: auto]
  -r, --rev-tag R2       Reverse tag [default: auto]
  -t, --threads INT      Working threads [default: 4]
  -v, --verbose          Verbose output
  -h, --help             Show this help
```


## seqfu_deinterleave

### Tool Description
interleave FASTQ files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
ilv: interleave FASTQ files

  Usage: dei [options] -o basename <interleaved-fastq>

  -o --output-basename "str"     save output to output_R1.fq and output_R2.fq
  -f --for-ext "R1"              extension for R1 file [default: _R1.fq]
  -r --rev-ext "R2"              extension for R2 file [default: _R2.fq]
  -c --check                     enable careful mode (check sequence names and numbers)
  -v --verbose                   print verbose output

  -s --strip-comments            skip comments
  -p --prefix "string"           rename sequences (append a progressive number)

notes:
    use "-" as input filename to read from STDIN

example:

    dei -o newfile file.fq
```


## seqfu_derep

### Tool Description
Dereplicate sequences based on their content.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: derep [options] [<inputfile> ...]

Options:
  -k, --keep-name              Do not rename sequence (see -p), but use the first sequence name
  -i, --ignore-size            Do not count 'size=INT;' annotations (they will be stripped in any case)
  -m, --min-size=MIN_SIZE      Print clusters with size equal or bigger than INT sequences [default: 0]
  -p, --prefix=PREFIX          Sequence name prefix [default: seq]
  -5, --md5                    Use MD5 as sequence name (overrides other parameters)
  -j, --json=JSON_FILE         Save dereplication metadata to JSON file
  -s, --separator=SEPARATOR    Sequence name separator [default: .]
  -w, --line-width=LINE_WIDTH  FASTA line width (0: unlimited) [default: 0]
  -l, --min-length=MIN_LENGTH  Discard sequences shorter than MIN_LEN [default: 0]
  -x, --max-length=MAX_LENGTH  Discard sequences longer than MAX_LEN [default: 0]
  -c, --size-as-comment        Print cluster size as comment, not in sequence name
  --add-len                    Add length to sequence
  -v, --verbose                Print verbose messages
  -h, --help                   Show this help
```


## seqfu_interleave

### Tool Description
interleave FASTQ files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
ilv: interleave FASTQ files

  Usage: ilv [options] -1 <forward-pair> [-2 <reverse-pair>]

  -f --for-tag <tag-1>       string identifying forward files [default: auto]
  -r --rev-tag <tag-2>       string identifying reverse files [default: auto]
  -o --output <outputfile>   save file to <out-file> instead of STDOUT
  -c --check                 enable careful mode (check sequence names and numbers)
  -v --verbose               print verbose output

  -s --strip-comments        skip comments
  -p --prefix "string"       rename sequences (append a progressive number)

guessing second file:
  by default <forward-pair> is scanned for _R1. and substitute with _R2.
  if this fails, the patterns _1. and _2. are tested.

example:

    ilv -1 file_R1.fq > interleaved.fq
```


## seqfu_lanes

### Tool Description
This tool supports up to 8 lanes of Illumina-formatted output files.
Merged lane output files will be in an uncompressed format.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lanes [options] -o <outdir> <input_directory>

NOTE: This tool supports up to 8 lanes of Illumina-formatted output files.
Merged lane output files will be in an uncompressed format.

Options:
  -o, --outdir DIR           Output directory
  -e, --extension STR        File extension [default: .fastq]
  -s, --file-separator STR   Field separator in filenames [default: _]
  --comment-separator STR    String separating sequence name and its comment [default: TAB]
  -v, --verbose              Verbose output 
  -h, --help                 Show this help
```


## seqfu_list

### Tool Description
Print sequences that are present in a list file, which can contains leading ">" or "@" characters. Duplicated entries in the list will be ignored.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: list [options] <LIST> <FASTQ>...

Print sequences that are present in a list file, which
can contains leading ">" or "@" characters.
Duplicated entries in the list will be ignored.

Other options:
  -c, --with-comments    Include comments in the list file
  -p, --partial-match    Allow partial matches (UNSUPPORTED)
  -m, --min-len INT      Skip entries smaller than INT [default: 1]

  -v, --verbose          Verbose output
  -r, --report           Print report of found sequences
  --help                 Show this help
```


## seqfu_metadata

### Tool Description
Prepare mapping files from directory containing FASTQ files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
  metadata [options] [<dir>...]
  metadata formats

Prepare mapping files from directory containing FASTQ files

Options:
  -1, --for-tag STR      String found in filename of forward reads [default: _R1]
  -2, --rev-tag STR      String found in filename of forward reads [default: _R2]
  -s, --split STR        Separator used in filename to identify the sample ID [default: _]
  --pos INT...           Which part of the filename is the Sample ID [default: 1]

  -f, --format TYPE      Output format: dadaist, irida, manifest,... list to list [default: manifest]
  -p, --add-path         Add the reads absolute path as column 
  -c, --counts           Add the number of reads as a property column (experimental)
  -t, --threads INT      Number of simultaneously opened files (legacy: ignored) 
  --pe                   Enforce paired-end reads (not supported)
  --ont                  Long reads (Oxford Nanopore) [default: false]

  GLOBAL OPTIONS
  --abs                  Force absolute path
  --basename             Use basename instead of full path
  --force-tsv            Force '\t' separator, otherwise selected by the format
  --force-csv            Force ',' separator, otherwise selected by the format
  -R, --rand-meta INT    Add a random metadata column with INT categories

  FORMAT SPECIFIC OPTIONS
  -P, --project INT      Project ID (only for irida)
  --meta-split STR       Separator in the SampleID to extract metadata, used in MetaPhage [default: _]
  --meta-part INT        Which part of the SampleID to extract metadata, used in MetaPhage [default: 1]
  --meta-default STR     Default value for metadata, used in MetaPhage [default: Cond]

  -v, --verbose          Verbose output
  --debug                Debug output
  -h, --help             Show this help
```


## seqfu_rotate

### Tool Description
Rotate the sequences of one or more sequence files using 
  coordinates or motifs.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
    fu-rotate [options] -i POS [<fastq-file>...]
    fu-rotate [options] -m STR [<fastq-file>...]

  Rotate the sequences of one or more sequence files using 
  coordinates or motifs.

  Position based:
    -i, --start-pos POS        Restart from base POS, where 1 is the first base [default: 1]
  
  Motif based:
    -m, --motif STR            Rotate sequences using motif STR as the new start,
                               where STR is a string of bases
    -s, --skip-unmached        If a motif is provided, skip sequences that do not
                               match the motif
    -r, --revcomp              Also scan for reverse complemented motif

  Other options:
    -v, --verbose              Verbose output
    -h, --help                 Show this help
```


## seqfu_sort

### Tool Description
Sort sequences by size printing only unique sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sort [options] [<inputfile> ...]

 Sort sequences by size printing only unique sequences

Options:
  -p, --prefix STRING    Sequence prefix 
  -s, --strip-comments   Remove sequence comments
  --asc                  Ascending order
  -v, --verbose          Verbose output
  -h, --help             Show this help
```


## seqfu_stats

### Tool Description
Print statistics about input files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: stats [options] [<inputfile> ...]

Options:
  -a, --abs-path         Print absolute paths
  -b, --basename         Print only filenames
  -n, --nice             Print nice terminal table
  -j, --json             Print json (EXPERIMENTAL)
  -s, --sort-by KEY      Sort by KEY from: filename, counts, n50, tot, avg, min, max
                         descending for values, ascending for filenames [default: none]
  -r, --reverse          Reverse sort order
  -t, --thousands        Add thousands separator (only tabbed/nice output)
  --csv                  Separate output by commas instead of tabs
  --gc                   Also print %GC
  --index                Also print contig index (L50, L90)
  --multiqc FILE         Saves a MultiQC report to FILE (suggested: name_mqc.txt)
  --precision INT        Number of decimal places to round to [default: 2]
  --noheader             Do not print header
  -v, --verbose          Verbose output
  -h, --help             Show this help
```


## seqfu_tofasta

### Tool Description
Convert various sequence formats to FASTA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tofasta [options] <inputfile>...

Convert various sequence formats to FASTA format.

Supported formats:
  - FASTA, FASTQ (Sanger, Illumina, Solexa)
  - GenBank, EMBL
  - GFF (with embedded sequences)
  - GFA (Graphical Fragment Assembly)
  - Clustal, Stockholm (multiple sequence alignments)

Options:
  -n, --replace-iupac    Replace non-IUPAC characters with 'N'
  -l, --to-lowercase     Convert sequences to lowercase
  -u, --to-uppercase     Convert sequences to uppercase
  -o, --output FILE      Write output to FILE (default: stdout)
                         Note: checks for duplicate IDs across all files
  -v, --verbose          Print progress information to stderr
  -h, --help             Show this help

Notes:
  - Input files can be gzip compressed (.gz)
  - When using -o/--output, duplicate sequence IDs will cause an error
  - Without -o/--output, sequences are written to stdout
  - Use only one of -l or -u (uppercase takes precedence)
```


## seqfu_cat

### Tool Description
Concatenate multiple FASTA or FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cat [options] [<inputfile> ...]

Concatenate multiple FASTA or FASTQ files.

Options:
  -k, --skip STEP        Print one sequence every STEP [default: 0]
  --skip-first INT       Skip the first INT records [default: -1]
  --jump-to STR          Start from the record after the one named STR
                         (overrides --skip-first)
  --print-last           Print the name of the last sequence to STDERR (Last:NAME)

Sequence name:
  -p, --prefix STRING    Rename sequences with prefix + incremental number
  -z, --strip-name       Remove the original sequence name
  -a, --append STRING    Append this string to the sequence name [default: ]
  --sep STRING           Sequence name fields separator [default: _]

  -b, --basename         Prepend file basename to the sequence name (before prefix)
  --split CHAR           Split basename at this char [default: .]
  --part INT             After splitting the basename, take this part [default: 1]
  --basename-sep STRING  Separate basename from the rest with this [default: _]
  --zero-pad INT         Zero pad the counter to INT digits [default: 0]

Sequence comments:
  -s, --strip-comments   Remove original sequence comments
  --comment-sep CHAR     Comment separator [default:  ]
  --add-len              Add 'len=LENGTH' to the comments
  --add-initial-len      Add 'original_len=LENGTH' to the comments
  --add-gc               Add 'gc=%GC' to the comments
  --add-initial-gc       Add 'original_gc=%GC' to the comments
  --add-name             Add 'original_name=INITIAL_NAME' to the comments
  --add-ee               Add 'ee=EXPECTED_ERROR' to the comments
  --add-initial-ee       Add 'original_ee=EXPECTED_ERROR' to the comments

Filtering:
  -n, --max-ns INT       Discard sequences with more than INT Ns [default: -1]
  -m, --min-len INT      Discard sequences shorter than INT [default: 1]
  -x, --max-len INT      Discard sequences longer than INT, 0 to ignore [default: 0]
  --max-ee FLOAT         Discard sequences with higher than FLOAT expected error [default: -1.0]
  --trim-front INT       Trim INT base from the start of the sequence [default: 0]
  --trim-tail INT        Trim INT base from the end of the sequence [default: 0]
  --truncate INT         Keep only the first INT bases, 0 to ignore  [default: 0]
                         Negative values to print the last INT bases
  --max-bp INT           Stop printing after INT bases [default: 0]

Output:
  --fasta                Force FASTA output
  --fastq                Force FASTQ output
  --report FILE          Save a report to FILE (original name, new name)
  --list                 Output a list of sequence names
  --long                 Output a list, with sequence name and comments 
  --anvio                Output in Anvio format (-p c_ -s -z --zeropad 12 --report rename_report.txt)
  -q, --fastq-qual INT   FASTQ default quality [default: 33]
  -v, --verbose          Verbose output
  --debug                Debug output
  -h, --help             Show this help
```


## seqfu_grep

### Tool Description
Print sequences selected if they match patterns or contain oligonucleotides using regular expressions.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: grep [options] [<inputfile> ...]

Print sequences selected if they match patterns or contain oligonucleotides
using regular expressions.

Name and comment search:
  -n, --name STRING      String required inside the sequence name (see -f)
  -r, --regex PATTERN    Pattern to be matched in sequence name
  -c, --comment          Also search -n and -r in the comment
  -f, --full             The string or pattern covers the whole name
                         (mainly used without -c)
  -w, --word             The string or pattern is a whole word
  -i, --ignore-case      Ignore case when matching names (is already enabled with regexes)

Sequence search:
  -o, --oligo IUPAC      Oligonucleotide required in the sequence,
                         using ambiguous bases and reverse complement
  -A, --append-pos       Append matching positions to the sequence comment
  --max-mismatches INT   Maximum mismatches allowed [default: 0]
  --min-matches INT      Minimum number of matches [default: oligo-length]

General options:
  -v, --invert-match     Invert match (print sequences that do not match)
  --verbose              Verbose output
  --help                 Show this help
```


## seqfu_head

### Tool Description
Select a number of sequences from the beginning of a file, allowing to select a fraction of the reads (for example to print 100 reads, selecting one every 10).

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: head [options] [<inputfile> ...]

Select a number of sequences from the beginning of a file, allowing
to select a fraction of the reads (for example to print 100 reads,
selecting one every 10).

Options:
  -n, --num NUM          Print the first NUM sequences [default: 10]
  -k, --skip SKIP        Print one sequence every SKIP [default: 0]
  -p, --prefix STRING    Rename sequences with prefix + incremental number
  -s, --strip-comments   Remove comments
  -b, --basename         prepend basename to sequence name
  -v, --verbose          Verbose output
  --print-last           Print the name of the last sequence to STDERR (Last:NAME)
  --fatal                Exit with error if less than NUM sequences are found
  --quiet                Don't print warnings
  --help                 Show this help

Output:
  --fasta                Force FASTA output
  --fastq                Force FASTQ output
  --sep STRING           Sequence name fields separator [default: _]
  -q, --fastq-qual INT   FASTQ default quality [default: 33]
```


## seqfu_rc

### Tool Description
Print the reverse complementary of sequences in files or sequences given as parameters. Can read FASTA/FASTQ also from STDIN, but not naked strings.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rc [options] [<strings-or-files>...] 

Print the reverse complementary of sequences in files or sequences
given as parameters. Can read FASTA/FASTQ also from STDIN, but not
naked strings.

Options:
  -s, --seq-name NAME    Sequence name if coming as string [default: dna]
  -r, --only-rev         Reverse, do not complement
  --strip-comments       Remove sequence comments
  -v, --verbose          Verbose output
  --help                 Show this help
```


## seqfu_tab

### Tool Description
Convert FASTQ to TSV and viceversa. Single end is a 4 columns table (name, comment, seq, qual), paired end have 4 columns for the R1 and 4 columns for the R2. Paired end reads need to be supplied as interleaved.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tabulate [options] [<file>]

Convert FASTQ to TSV and viceversa. Single end is a 4 columns table (name, comment, seq, qual),
paired end have 4 columns for the R1 and 4 columns for the R2. 
Paired end reads need to be supplied as interleaved.
 

Options:
  -i, --interleaved        Input is interleaved (paired-end)
  -d, --detabulate         Convert TSV to FASTQ (if reading from file is autodetected) 
  -c, --comment-sep CHAR   Separator between name and comment (default: tab)
  -s, --field-sep CHAR     Field separator when deinterleaving (default: tab)
  -v, --verbose            Verbose output
  -h, --help               Show this help
```


## seqfu_tail

### Tool Description
Print the last sequences of files

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: tail [options] [<inputfile> ...]

Options:
  -n, --num NUM          Print the first NUM sequences [default: 10]
  -k, --skip SKIP        Print one sequence every SKIP [default: 0]
  -p, --prefix STRING    Rename sequences with prefix + incremental number
  -s, --strip-comments   Remove comments
  -b, --basename         prepend basename to sequence name
  --fasta                Force FASTA output
  --fastq                Force FASTQ output
  --sep STRING           Sequence name fields separator [default: _]
  -q, --fastq-qual INT   FASTQ default quality [default: 33]
  -v, --verbose          Verbose output
  -h, --help             Show this help
```


## seqfu_view

### Tool Description
View a FASTA/FASTQ file for manual inspection, allowing to search for an oligonucleotide.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
- **Homepage**: http://github.com/quadram-institute-bioscience/seqfu/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqfu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: view [options] <inputfile> [<input_reverse>]

View a FASTA/FASTQ file for manual inspection, allowing to search for
an oligonucleotide.

Options:
  -o, --oligo1 OLIGO     Match oligo, with ambiguous IUPAC chars allowed
                         (rev. compl. search is performed), color blue
  -r, --oligo2 OLIGO     Second oligo to be scanned for, color red
  -q, --qual-scale STR   Quality thresholds, seven values
                         separated by columns [default: 3:15:25:28:30:35:40]

  --match-ths FLOAT      Oligo matching threshold [default: 0.75]
  --min-matches INT      Oligo minimum matches [default: 5]
  --max-mismatches INT   Oligo maxmimum mismataches [default: 2]
  --ascii                Encode the quality as ASCII chars (when UNICODE is
                         not available)
  -Q, --qual-chars       Show quality characters instead of bars
  -n, --nocolor          Disable colored output
  --verbose              Show extra information
  -h, --help             Show this help
```


## Metadata
- **Skill**: generated
