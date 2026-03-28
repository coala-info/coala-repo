# sqt CWL Generation Report

## sqt_align

### Tool Description
Compare two strings

### Metadata
- **Docker Image**: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
- **Homepage**: https://github.com/tdjsnelling/sqtracker
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sqt/overview
- **Total Downloads**: 34.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tdjsnelling/sqtracker
- **Stars**: N/A
### Original Help Text
```text
INFO: Could not open font file /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf
usage: sqt align [-h] [--semiglobal] [--max-error-rate MAX_ERROR_RATE]
                 [--reverse-complement] [--merge]
                 sequence1 sequence2

Compare two strings

positional arguments:
  sequence1             Sequence or path to FASTA file. If FASTA, only the
                        first sequence is used.
  sequence2             Sequence or path to FASTA file. If FASTA, only the
                        first sequence is used.

optional arguments:
  -h, --help            show this help message and exit
  --semiglobal, --overlap
                        Run a semi-global alignment (for detecting overlaps).
                        Default: global alignment.
  --max-error-rate MAX_ERROR_RATE, -e MAX_ERROR_RATE
                        Switch to cutadapt algorithm (also enables
                        --semiglobal). No alignment will be printed.
  --reverse-complement, --rc
                        Run the alignment also with the reverse-complement of
                        the second sequence
  --merge               Output a merged sequence (also enables --semiglobal)
sqt align: error: the following arguments are required: sequence1, sequence2
```


## sqt_bam2fastq

### Tool Description
Extract all reads from a BAM file that map to a certain location, but try hard to extract them even if hard clipping is used.

### Metadata
- **Docker Image**: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
- **Homepage**: https://github.com/tdjsnelling/sqtracker
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO: Could not open font file /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf
usage: sqt bam2fastq [-h] [--missing-quality MISSING_QUALITY] [-L BED-FILE]
                     SAM/BAM [region [region ...]]

Extract all reads from a BAM file that map to a certain location, but try hard
to extract them even if hard clipping is used.

TODO reverse-complementarity is ignored
TODO behavior when no region is given is not well documented

positional arguments:
  SAM/BAM               Name of a SAM or BAM file
  region                Region

optional arguments:
  -h, --help            show this help message and exit
  --missing-quality MISSING_QUALITY
                        Quality value to use if an entry does not have
                        qualities (default: 40)
  -L BED-FILE, --bed BED-FILE
                        BED file with regions
sqt bam2fastq: error: the following arguments are required: SAM/BAM, region
```


## sqt_fastxmod

### Tool Description
Modify FASTA and FASTQ files by picking subsets and modifying individual entries.

### Metadata
- **Docker Image**: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
- **Homepage**: https://github.com/tdjsnelling/sqtracker
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO: Could not open font file /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf
usage: sqt fastxmod [-h] [--names FILE] [--not-names FILE] [-q CUTOFF]
                    [--substitute PROB] [--length LENGTH] [-m LENGTH]
                    [--max-errors ERRORS] [--allowed-characters CHARS]
                    [--reverse-complement] [--upper | --lower]
                    [--constant-quality QUALITY] [--fasta] [--unique-names]
                    [--limit N] [--width WIDTH] [--seed SEED]
                    FASTA/FASTQ

Modify FASTA and FASTQ files by picking subsets and modifying individual entries.

Possible modifications:
- Pick a subset of records (given by name). With lots of names, this is faster
  than 'grep -A 3 --no-group-separator -f readnames.txt file.fastq' magic, which
  may be used with FASTQ files.
  If the record name ends in '/1' or '/2', these two charecter are ignored when
  comparing to the names in the file.
- Trim low-quality ends
- Trim reads to a given length
- Discard reads shorter than a given length
- Discard reads in which the expected number of errors exceeds a threshold
- Discard reads that contain characters other than those in a given set.
- Reverse-complement each read
- Make sequence characters upper- or lowercase
- Convert from FASTA to FASTQ by assigning a fixed quality value to all bases
- Convert from FASTQ to FASTA by dropping all quality values
- Make read names unique
- Pick only the first N sequences.

Modifications are done in the order in which they are listed above.
The result is written to standard output.

The algorithm for quality trimming is the same as the one used by BWA:
- Subtract the cutoff value from all qualities.
- Compute partial sums from all indices to the end of the sequence.
- Trim sequence at the index at which the sum is minimal.

positional arguments:
  FASTA/FASTQ           input FASTA or FASTQ file

optional arguments:
  -h, --help            show this help message and exit
  --names FILE          Keep only records whose name occurs in FILE (one per
                        line)
  --not-names FILE      Discard records whose name occurs in FILE (one per
                        line)
  -q CUTOFF, --cutoff CUTOFF
                        Quality cutoff. Only when input format is FASTQ
  --substitute PROB     Randomly substitute bases at probability PROB.
                        Default: 0
  --length LENGTH, -l LENGTH
                        Shorten records to LENGTH (default: do not shorten)
  -m LENGTH, --minimum-length LENGTH
                        Discard reads shorter than LENGTH
  --max-errors ERRORS   Discard reads whose expected number of errors
                        (computed from quality values) exceeds ERRORS.
  --allowed-characters CHARS
                        Discard reads that contain characters other than those
                        in CHARS. CHARS is case-sensitive. Example: -c
                        ACGTacgt.
  --reverse-complement, -r
                        Reverse-complement each sequence
  --upper               Convert sequence characters to uppercase
  --lower               Convert sequence characters to lowercase
  --constant-quality QUALITY, -c QUALITY
                        Set all quality values to QUALITY. Use this to convert
                        from FASTA to FASTQ.
  --fasta               Always output FASTA (drop qualities if input is FASTQ)
  --unique-names        Make record names unique by appending _1, _2 etc. when
                        necessary
  --limit N, -n N       Pick only the first N sequences (default: all)
  --width WIDTH, -w WIDTH
                        Characters per line in output FASTA (default: 80). Set
                        to 0 to disallow line breaks entirely. This is ignored
                        for FASTQ files.
  --seed SEED           Set random seed for reproducible runs. Relevant when
                        --substitution-rate is used.(default: use different
                        seed each run)
sqt fastxmod: error: argument -h/--help: ignored explicit argument 'elp'
```


## sqt_qgramfreq

### Tool Description
Print q-gram (also called k-mer) frequencies in a FASTA or FASTQ file.

### Metadata
- **Docker Image**: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
- **Homepage**: https://github.com/tdjsnelling/sqtracker
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO: Could not open font file /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf
usage: sqt qgramfreq [-h] [-q Q] FASTA/FASTQ

Print q-gram (also called k-mer) frequencies in a FASTA or FASTQ file.

The result is a list of q-grams and their counts, sorted by counts from
least to most frequent.

positional arguments:
  FASTA/FASTQ  input FASTA or FASTQ file

optional arguments:
  -h, --help   show this help message and exit
  -q Q         length of the q-grams (also called k-mers) (default: 4)
sqt qgramfreq: error: argument -h/--help: ignored explicit argument 'elp'
```


## sqt_chars

### Tool Description
Print the number of characters in a string.

### Metadata
- **Docker Image**: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
- **Homepage**: https://github.com/tdjsnelling/sqtracker
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO: Could not open font file /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf
usage: sqt chars [-h] string

Print the number of characters in a string.

positional arguments:
  string      The string

optional arguments:
  -h, --help  show this help message and exit
sqt chars: error: argument -h/--help: ignored explicit argument 'elp'
```


## sqt_fastagrep

### Tool Description
Search for a IUPAC string in the sequences of a FASTA file.

Prints matching entries in the fasta file to standard output.
If <FASTA> is not provided, read from standard input.

If output is a terminal, the first occurrence of the pattern
in each sequence is highlighted.

### Metadata
- **Docker Image**: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
- **Homepage**: https://github.com/tdjsnelling/sqtracker
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO: Could not open font file /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf
usage: sqt fastagrep [-h] [-d] pattern [fasta]

Search for a IUPAC string in the sequences of a FASTA file.

Prints matching entries in the fasta file to standard output.
If <FASTA> is not provided, read from standard input.

If output is a terminal, the first occurrence of the pattern
in each sequence is highlighted.

positional arguments:
  pattern
  fasta

optional arguments:
  -h, --help         show this help message and exit
  -d, --description  Search the description/comment fields of the FASTA file
                     instead of the sequences. If given, the pattern is
                     interpreted as a regular expression, not as a IUPAC
                     pattern. (default: False)
sqt fastagrep: error: argument -h/--help: ignored explicit argument 'elp'
```


## sqt_readcov

### Tool Description
Print a report for individual reads in a SAM/BAM file.

### Metadata
- **Docker Image**: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
- **Homepage**: https://github.com/tdjsnelling/sqtracker
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO: Could not open font file /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf
usage: sqt readcov [-h] [--minimum-length MINIMUM_LENGTH] [--quality QUALITY]
                   [--minimum-cover-fraction FRACTION]
                   SAM/BAM region

Print a report for individual reads in a SAM/BAM file.

positional arguments:
  SAM/BAM               Name of a SAM or BAM file
  region                Region

optional arguments:
  -h, --help            show this help message and exit
  --minimum-length MINIMUM_LENGTH, -m MINIMUM_LENGTH
                        Minimum read length. Ignore reads that are shorter.
                        Default: 1
  --quality QUALITY, -q QUALITY
                        Minimum mapping quality (default: 0
  --minimum-cover-fraction FRACTION
                        Alignment must cover at least FRACTION of the read to
                        appear in the cover report. (0.01)
sqt readcov: error: the following arguments are required: SAM/BAM, region
```


## sqt_randomseq

### Tool Description
Generate random sequences in FASTA format

### Metadata
- **Docker Image**: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
- **Homepage**: https://github.com/tdjsnelling/sqtracker
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO: Could not open font file /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf
usage: sqt randomseq [-h] [--minimum-length MINIMUM_LENGTH]
                     [--maximum-length MAXIMUM_LENGTH]
                     n

Generate random sequences in FASTA format

positional arguments:
  n                     Number of sequences to generate

optional arguments:
  -h, --help            show this help message and exit
  --minimum-length MINIMUM_LENGTH, -m MINIMUM_LENGTH
  --maximum-length MAXIMUM_LENGTH, -M MAXIMUM_LENGTH
sqt randomseq: error: argument -h/--help: ignored explicit argument 'elp'
```


## sqt_samsetop

### Tool Description
Perform set operation on two SAM/BAM files.

### Metadata
- **Docker Image**: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
- **Homepage**: https://github.com/tdjsnelling/sqtracker
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO: Could not open font file /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf
usage: sqt samsetop [-h] [-s] [-U] [-V] [-r]
                    bampath1 {union,intersection,setminus,symdiff} bampath2
                    [outputpath]

Perform set operation on two SAM/BAM files.

The output BAM file will have the same header as file A.

WARNING: Implementation is neither very fast nor memory efficient.

Possible operations:
  union:        Output union of A and B, abort with error if
                different lines for same read are encountered.
  intersection: Output intersection of A and B, abort with error if
                different lines for same read are encountered.
  setminus:     Outputs all read in A that are not in B.
  symdiff:      Output all reads in A or B but not in both.

positional arguments:
  bampath1              First BAM or SAM file
  {union,intersection,setminus,symdiff}
  bampath2              Second BAM or SAM file
  outputpath            Output BAM or SAM file. If omitted, only print the
                        number of reads that would be written.

optional arguments:
  -h, --help            show this help message and exit
  -s                    Output SAM file instead of BAM file
  -U                    Exclude unmapped reads from file A
  -V                    Exclude unmapped reads from file B
  -r                    Remove trailing "/*" from read names. Useful if one
                        mapper appends "/1" and another does not.
sqt samsetop: error: the following arguments are required: bampath1, operation, bampath2
```


## sqt_bameof

### Tool Description
Check whether the EOF marker is present in BAM files. If it's not, this may be a sign that the BAM file was corrupted.

### Metadata
- **Docker Image**: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
- **Homepage**: https://github.com/tdjsnelling/sqtracker
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO: Could not open font file /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf
usage: sqt bameof [-h] [-q] BAM [BAM ...]

Check whether the EOF marker is present in BAM files.
If it's not, this may be a sign that the BAM file was corrupted.

The exit code is 1 if the marker was present in *all files*.
It is 0 if the marker was missing in any of the files.

BUGS/TODO
- Does not work with uncompressed BAM files.

positional arguments:
  BAM

optional arguments:
  -h, --help   show this help message and exit
  -q, --quiet  Don't print anything, just set the exit code.
sqt bameof: error: argument -h/--help: ignored explicit argument 'elp'
```


## sqt_readlenhisto

### Tool Description
Print and optionally plot a read length histogram of one or more FASTA or FASTQ files. If more than one file is given, a total is also printed.

### Metadata
- **Docker Image**: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
- **Homepage**: https://github.com/tdjsnelling/sqtracker
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO: Could not open font file /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf
usage: sqt readlenhisto [-h] [--zero] [--plot PLOT] [--bins BINS]
                        [--maxy MAXY] [--left LEFT] [--outliers]
                        [--title TITLE]
                        FASTA/FASTQ [FASTA/FASTQ ...]

Print and optionally plot a read length histogram of one or more FASTA or FASTQ
files. If more than one file is given, a total is also printed.

positional arguments:
  FASTA/FASTQ    Input FASTA/FASTQ file(s) (may be gzipped).

optional arguments:
  -h, --help     show this help message and exit
  --zero         Print also rows with a count of zero
  --plot PLOT    Plot to this file (.pdf or .png). If multiple sequence files
                 given, plot only total.
  --bins BINS    Number of bins in the plot. Default: 50
  --maxy MAXY    Maximum y in plot
  --left LEFT    Minimum x in plot
  --outliers     In the plot, summarize outliers greater than the 99.9
                 percentile in a red bar.
  --title TITLE  Plot title. {} is replaced with the input file name. Default:
                 'Read length histogram of {}'
sqt readlenhisto: error: argument -h/--help: ignored explicit argument 'elp'
```


## sqt_cutvect

### Tool Description
Remove vector sequence

### Metadata
- **Docker Image**: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
- **Homepage**: https://github.com/tdjsnelling/sqtracker
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO: Could not open font file /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf
usage: sqt cutvect [-h] vector reads

Remove vector sequence

Limitations:
- Only one vector sequence supported.
- Only the first and last 500 bp of the vector sequence are actually searched for.
- If sequence is circular, vector might not be found.

positional arguments:
  vector      FASTA with vector sequence(s)
  reads       FASTA/FASTQ with read

optional arguments:
  -h, --help  show this help message and exit
sqt cutvect: error: argument -h/--help: ignored explicit argument 'elp'
```


## Metadata
- **Skill**: not generated
