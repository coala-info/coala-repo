# fqtools CWL Generation Report

## fqtools_view

### Tool Description
View FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fqtools/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-07-08
- **GitHub**: https://github.com/alastair-droop/fqtools
- **Stars**: N/A
### Original Help Text
```text
View FASTQ files.

view options:
  -h               Show this help message and exit.
  -k               Preserve secondary headers (if present).
  -o STEM          Output file stem (default "output%").
  FILE             The fastq file(s) to view.

STEM:
    The file stem to use for output files (without file extension). Any
    instances of the single character specified using the -p global argument
    will be replaced with the pair number, or removed for single output
    files. If the -o option is not specified, single file output will
    be written to stdout and paired file output to the default stem (output%).

FILE:
    If no input file is specified, input will be read from stdin.
```


## fqtools_head

### Tool Description
View the first reads in FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
View the first reads in FASTQ files.

view options:
  -h               Show this help message and exit.
  -k               Preserve secondary headers (if present).
  -n NUMBER        The number of reads to display (default 10).
  -o STEM          Output file stem (default "output%").
  FILE             The fastq file(s) to view.

NUMBER:
    The number of reads to return from the top of the file(s).

STEM:
    The file stem to use for output files (without file extension). Any
    instances of the single character specified using the -p global argument
    will be replaced with the pair number, or removed for single output
    files. If the -o option is not specified, single file output will
    be written to stdout and paired file output to the default stem (output%).

FILE:
    If no input file is specified, input will be read from stdin.
```


## fqtools_count

### Tool Description
Count FASTQ file reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Count FASTQ file reads.

count options:
  -h               Show this help message and exit.
  FILE             The fastq file(s) to count.

FILE:
    If no input file is specified, input will be read from stdin.
```


## fqtools_header

### Tool Description
View FASTQ file header data.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
View FASTQ file header data.

header options:
  -h               Show this help message and exit.
  FILE             The fastq file(s) to view.

FILE:
    If no input file is specified, input will be read from stdin.
```


## fqtools_sequence

### Tool Description
View FASTQ file sequence data.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
View FASTQ file sequence data.

sequence options:
  -h               Show this help message and exit.
  FILE             The fastq file(s) to view.

FILE:
    If no input file is specified, input will be read from stdin.
```


## fqtools_quality

### Tool Description
View FASTQ file quality data.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
View FASTQ file quality data.

quality options:
  -h               Show this help message and exit.
  FILE             The fastq file(s) to view.

FILE:
    If no input file is specified, input will be read from stdin.
```


## fqtools_header2

### Tool Description
View FASTQ file secondary header data.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
View FASTQ file secondary header data.

secondary header options:
  -h               Show this help message and exit.
  FILE             The fastq file(s) to view.

FILE:
    If no input file is specified, input will be read from stdin.
```


## fqtools_fasta

### Tool Description
Convert FASTQ files to FASTA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Convert FASTQ files to FASTA format.

fasta options:
  -h               Show this help message and exit.
  -l LENGTH        Maximum number of sequence characters per line.
  -o STEM          Output file stem (default "output%").
  FILE             The fastq file(s) to view.

LENGTH:
The maximum number of sequence characters per line. If not specified,
no line wrapping is performed.
    If no input file is specified, input will be read from stdin.

STEM:
    The file stem to use for output files (without file extension). Any
    instances of the single character specified using the -p global argument
    will be replaced with the pair number, or removed for single output
    files. If the -o option is not specified, single file output will
    be written to stdout and paired file output to the default stem (output%).

FILE:
    If no input file is specified, input will be read from stdin.
```


## fqtools_basetab

### Tool Description
Tabulate FASTQ base frequencies.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Tabulate FASTQ base frequencies.

basetab options:
  -h               Show this help message and exit.
  -a               Show all valid base frequencies, even if zero.
  -s               Sort returned base frequencies (otherwise alphabetical).
  FILE             The fastq file(s) to count.

FILE:
    If no input file is specified, input will be read from stdin.
```


## fqtools_qualtab

### Tool Description
Tabulate FASTQ quality character frequencies.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Tabulate FASTQ quality character frequencies.

basetab options:
  -h               Show this help message and exit.
  FILE             The fastq file(s) to count.
FILE:
    If no input file is specified, input will be read from stdin.

The output depends on the specified quality type (-q). If no quality
type is specified, then the ASCII characters in the quality strings
are tabulated for all possible characters (33-127). If a quality type
is specified, the quality score and approximate probability of error
are returned for only the valid characters.
```


## fqtools_lengthtab

### Tool Description
Tabulate FASTQ read lengths.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Tabulate FASTQ read lengths.

lengthtab options:
  -h               Show this help message and exit.
  FILE             The fastq file(s) to count.
FILE:
    If no input file is specified, input will be read from stdin.
```


## fqtools_type

### Tool Description
Attempt to guess the FASTQ quality encoding type.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Attempt to guess the FASTQ quality encoding type.

type options:
  -h               Show this help message and exit.
  FILE             The fastq file(s) to count.

FILE:
    If no input file is specified, input will be read from stdin.

The file type is guessed from the quality data as follows:
  1) if MIN(offset) < 59 then the file is fastq-sanger encoded;
  2) if 59 <= MIN(offset) < 64 then the file is fastq-solexa encoded;
  3) otherwise, the file is fastq-illumina encoded.
```


## fqtools_validate

### Tool Description
Validate FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Validate FASTQ file.

validate options:
  -h               Show this help message and exit.
  FILE             The fastq file(s) to count.

FILE:
    If no input file is specified, input will be read from stdin.
```


## fqtools_find

### Tool Description
Find FASTQ reads containing specific sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Find FASTQ reads containing specific sequences.

view options:
  -h               Show this help message and exit.
  -k               Preserve secondary headers (if present).
  -a               Require all sequences for a match.
  -s SEQUENCE      Sequence to match against.
  -f SEQ_FILE      Read match sequences from file.
  -o STEM          Output file stem (default "output%").
  FILE             The fastq file(s) to view.

SEQUENCE:
    An exact sequence to look for in the read. Multiple sequences are
    permitted. If -a is specified, all specified sequences must be present
    for a read to match, otherwise the presence of any one is sufficient.
    If no sequences are specified, all reads are returned.

SEQ_FILE:
    If specified with -f, sequences are read one per line from file.
    Empty lines are ignored.
STEM:
    The file stem to use for output files (without file extension). Any
    instances of the single character specified using the -p global argument
    will be replaced with the pair number, or removed for single output
    files. If the -o option is not specified, single file output will
    be written to stdout and paired file output to the default stem (output%).

FILE:
    If no input file is specified, input will be read from stdin.
```


## fqtools_trim

### Tool Description
View FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
View FASTQ files.

view options:
  -h               Show this help message and exit.
  -k               Preserve secondary headers (if present).
  -o STEM          Output file stem (default "output%").
  -s LENGTH        Trim LENGTH bases from the read start.
  -l LENGTH        Trim the read to a maximum length of LENGTH.
  FILE             The fastq file(s) to view.

STEM:
    The file stem to use for output files (without file extension). Any
    instances of the single character specified using the -p global argument
    will be replaced with the pair number, or removed for single output
    files. If the -o option is not specified, single file output will
    be written to stdout and paired file output to the default stem (output%).

FILE:
    If no input file is specified, input will be read from stdin.

LENGTH:
    If LENGTH is not specified, no trimming is performed.
```


## fqtools_qualmap

### Tool Description
Translate quality values using a mapping file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
- **Homepage**: https://github.com/alastair-droop/fqtools
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Translate quality values using a mapping file.

qualmap options:
  -h               Show this help message and exit.
  -k               Preserve secondary headers (if present).
  -o STEM          Output file stem (default "output%").
  MAP              The mapping file to use (see below)
  FILE             The fastq file(s) to view.

STEM:
    The file stem to use for output files (without file extension). Any
    instances of the single character specified using the -p global argument
    will be replaced with the pair number, or removed for single output
    files. If the -o option is not specified, single file output will
    be written to stdout and paired file output to the default stem (output%).

MAP:
    The base quality translation table. This should be a text file with a single
    line containing 94 characters. These will correspond to the valid quality
    characters from '!' to '~'. Any characters outside that range will be clipped

FILE:
    If no input file is specified, input will be read from stdin.
```

