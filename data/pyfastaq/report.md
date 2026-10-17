# pyfastaq CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pyfastaq_fastaq_acgtn_only | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_count_sequences | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_deinterleave | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_fasta_to_fastq | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_filter | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_interleave | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_reverse_complement | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_scaffolds_to_contigs | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_sort_by_name | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_sort_by_size | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_strip_illumina_suffix | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_to_fake_qual | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_to_fasta | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_to_random_subset | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_to_unique_by_id | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_translate | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |
| pyfastaq_fastaq_trim_Ns_at_end | Failed | image problem: every fastaq subcommand stops with NameError: name 'pyfastaq' is not defined (exec scoping in the image's Python 3.13) |

## pyfastaq_fastaq_acgtn_only

### Tool Description
Replaces any character that is not one of acgtACGTnN with an N

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq acgtn_only [options] <infile> <outfile>

Replaces any character that is not one of acgtACGTnN with an N

positional arguments:
  infile      Name of input file
  outfile     Name of output file

options:
  -h, --help  show this help message and exit
```

## pyfastaq_fastaq_trim_Ns_at_end

### Tool Description
Trims any Ns off each sequence in input file. Does nothing to gaps in the middle, just trims the ends

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq trim_Ns_at_end <infile> <outfile>

Trims any Ns off each sequence in input file. Does nothing to gaps in the
middle, just trims the ends

positional arguments:
  infile      Name of input file
  outfile     Name of output file

options:
  -h, --help  show this help message and exit
```

## pyfastaq_fastaq_strip_illumina_suffix

### Tool Description
Strips /1 or /2 off the end of every read name

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq strip_illumina_suffix <infile> <outfile>

positional arguments:
  infile      Name of input file
  outfile     Name of output file

options:
  -h, --help  show this help message and exit
```

## pyfastaq_fastaq_filter

### Tool Description
Filters a sequence file by sequence length and/or by name matching a regular expression

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq filter [options] <infile> <outfile>

Filters a sequence file by sequence length and/or by name matching a regular
expression

positional arguments:
  infile               Name of input file to be filtered
  outfile              Name of output file

options:
  -h, --help           show this help message and exit
  --min_length INT     Minimum length of sequence to keep [0]
  --max_length INT     Maximum length of sequence to keep [inf]
  --regex REGEX        If given, only reads with a name matching the regular
                       expression will be kept
  --ids_file FILENAME  If given, only reads whose ID is in th given file will
                       be used. One ID per line of file.
  -v, --invert         Only keep sequences that do not match the filters
  --check_comments     Search the header comments also for the given regex.
                       Can only be specified with --regex

Mate file for read pairs options:
  --mate_in FILENAME   Name of mates input file. If used, must also provide
                       --mate_out
  --mate_out FILENAME  Name of mates output file
  --both_mates_pass    By default, if either mate passes filter, then both
                       reads output. Use this flag to require that both reads
                       of a pair pass the filter
```

## pyfastaq_fastaq_sort_by_size

### Tool Description
Sorts sequences in length order

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq sort_by_size [options] <infile> <outfile>

positional arguments:
  infile         Name of input file
  outfile        Name of output file

options:
  -h, --help     show this help message and exit
  -r, --reverse  Sort by shortest first instead of the default of longest
                 first
```

## pyfastaq_fastaq_sort_by_name

### Tool Description
Sorts sequences in lexographical (name) order

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq sort_by_name <infile> <outfile>

positional arguments:
  infile      Name of input file
  outfile     Name of output file

options:
  -h, --help  show this help message and exit
```

## pyfastaq_fastaq_to_unique_by_id

### Tool Description
Removes duplicate sequences from input file, based on their names. If the same name is found more than once, then the longest sequence is kept. Order of sequences is preserved in output

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq to_unique_by_id <infile> <outfile>

Removes duplicate sequences from input file, based on their names. If the same
name is found more than once, then the longest sequence is kept. Order of
sequences is preserved in output

positional arguments:
  infile      Name of input file
  outfile     Name of output file

options:
  -h, --help  show this help message and exit
```

## pyfastaq_fastaq_interleave

### Tool Description
Interleaves two files, output is alternating between fwd/rev reads

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq interleave <infile_1> <infile_2> <outfile>

positional arguments:
  infile_1           Name of first input file
  infile_2           Name of second input file
  outfile            Name of output file of interleaved reads

options:
  -h, --help         show this help message and exit
  --suffix1 SUFFIX1  Suffix to add to all names from infile_1 (if suffix not
                     already present)
  --suffix2 SUFFIX2  Suffix to add to all names from infile_2 (if suffix not
                     already present)
```

## pyfastaq_fastaq_deinterleave

### Tool Description
Deinterleaves sequence file, so that reads are written alternately between two output files

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq deinterleave [options] <infile> <out_fwd> <out_rev>

Deinterleaves sequence file, so that reads are written alternately between two
output files

positional arguments:
  infile       Name of fasta/q file to be deinterleaved
  out_fwd      Name of output fasta/q file of forwards reads
  out_rev      Name of output fasta/q file of reverse reads

options:
  -h, --help   show this help message and exit
  --fasta_out  Use this to write output as fasta (default is same as input)
```

## pyfastaq_fastaq_to_fasta

### Tool Description
to_fasta

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq to_fasta [options] <infile> <outfile>

positional arguments:
  infile                Name of input file. Can be any of FASTA, FASTQ, GFF3,
                        EMBL, GBK, Phylip
  outfile               Name of output file

options:
  -h, --help            show this help message and exit
  -l, --line_length LINE_LENGTH
                        Number of bases on each sequence line of output file.
                        Set to zero for no linebreaks in sequences [60]
  -s, --strip_after_whitespace
                        Remove everything after first whitespace in every
                        sequence name
  -u, --check_unique    Die if any of the output sequence names are not unique
```

## pyfastaq_fastaq_fasta_to_fastq

### Tool Description
Convert FASTA and .qual to FASTQ

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq fasta_to_fastq <fasta in> <qual in> <fastq out>

positional arguments:
  fasta in    Name of input FASTA file
  qual in     Name of input quality scores file
  fastq out   Name of output FASTQ file

options:
  -h, --help  show this help message and exit
```

## pyfastaq_fastaq_scaffolds_to_contigs

### Tool Description
Creates a file of contigs from a file of scaffolds - i.e. breaks at every gap in the input

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq scaffolds_to_contigs [options] <infile> <outfile>

Creates a file of contigs from a file of scaffolds - i.e. breaks at every gap
in the input

positional arguments:
  infile            Name of input file
  outfile           Name of output contigs file

options:
  -h, --help        show this help message and exit
  --number_contigs  Use this to enumerate contig names 1,2,3,... within each
                    scaffold
```

## pyfastaq_fastaq_count_sequences

### Tool Description
Prints the number of sequences in input file to stdout

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq count_sequences <infile>

Prints the number of sequences in input file to stdout

positional arguments:
  infile      Name of input file

options:
  -h, --help  show this help message and exit
```

## pyfastaq_fastaq_to_random_subset

### Tool Description
Takes a random subset of reads from a sequence file and optionally the corresponding read from a mates file.  Output is interleaved if mates file given

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq to_random_subset [options] <infile> <outfile> <percent>

Takes a random subset of reads from a sequence file and optionally the
corresponding read from a mates file. Output is interleaved if mates file
given

positional arguments:
  infile                Name of input file
  outfile               Name of output file
  FLOAT                 Per cent probability of keeping any given read (pair)
                        in [0,100]

options:
  -h, --help            show this help message and exit
  --mate_file MATE_FILE
                        Name of mates file
  --seed INT            Seed for random number generator. If not given,
                        python's default is used
```

## pyfastaq_fastaq_to_fake_qual

### Tool Description
Make fake quality scores file

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq to_fake_qual [options] <infile> <outfile>

positional arguments:
  infile           Name of input file
  outfile          Name of output file

options:
  -h, --help       show this help message and exit
  -q, --qual QUAL  Quality score to assign to all bases [40]
```

## pyfastaq_fastaq_reverse_complement

### Tool Description
Reverse complement all sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq reverse_complement <infile> <outfile>

positional arguments:
  infile      Name of input file
  outfile     Name of output file

options:
  -h, --help  show this help message and exit
```

## pyfastaq_fastaq_translate

### Tool Description
Translates all sequences in input file. Output is always FASTA format

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
- **Homepage**: https://github.com/sanger-pathogens/Fastaq
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastaq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastaq translate [options] <infile> <outfile>

Translates all sequences in input file. Output is always FASTA format

positional arguments:
  infile           Name of file to be translated
  outfile          Name of output FASTA file

options:
  -h, --help       show this help message and exit
  --frame {0,1,2}  Frame to translate [0]
```

## Metadata
- **Skill**: generated
