# pyfastx CWL Generation Report

## pyfastx_index

### Tool Description
Build index for fasta or fastq files

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
- **Homepage**: https://github.com/lmdu/pyfastx
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastx/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyfastx/overview
- **Total Downloads**: 203.4K
- **Last updated**: 2026-01-24
- **GitHub**: https://github.com/lmdu/pyfastx
- **Stars**: N/A
### Original Help Text
```text
usage: pyfastx index [-h] [-f] fastx [fastx ...]

positional arguments:
  fastx       fasta or fastq file, gzip support

options:
  -h, --help  show this help message and exit
  -f, --full  build full index, base composition will be calculated
```


## pyfastx_stat

### Tool Description
Show statistics for fasta or fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
- **Homepage**: https://github.com/lmdu/pyfastx
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfastx stat [-h] fastx [fastx ...]

positional arguments:
  fastx       fasta or fastq file, gzip support

options:
  -h, --help  show this help message and exit
```


## pyfastx_split

### Tool Description
Split a fasta or fastq file into multiple smaller files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
- **Homepage**: https://github.com/lmdu/pyfastx
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfastx split [-h] (-n int | -c int) [-o str] fastx

positional arguments:
  fastx                 fasta or fastq file, gzip support

options:
  -h, --help            show this help message and exit
  -n int                split a fasta/q file into N new files with even size
  -c int                split a fasta/q file into multiple files containing
                        the same sequence counts
  -o str, --out-dir str
                        output directory, default is current folder
```


## pyfastx_fq2fa

### Tool Description
Converts FASTQ to FASTA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
- **Homepage**: https://github.com/lmdu/pyfastx
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfastx fq2fa [-h] [-o str] fastx

positional arguments:
  fastx                 fastq file, gzip support

options:
  -h, --help            show this help message and exit
  -o str, --out-file str
                        output file, default: output to stdout
```


## pyfastx_subseq

### Tool Description
Extract subsequences from FASTA/FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
- **Homepage**: https://github.com/lmdu/pyfastx
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfastx subseq [-h] [-r str | -b str] [-o str] fastx [region ...]

positional arguments:
  fastx                 input fasta file, gzip support
  region                format is chr:start-end, start and end position is
                        1-based, multiple regions were separated by space

options:
  -h, --help            show this help message and exit
  -r str, --region-file str
                        tab-delimited file, one region per line, both start
                        and end position are 1-based
  -b str, --bed-file str
                        tab-delimited BED file, 0-based start position and
                        1-based end position
  -o str, --out-file str
                        output file, default: output to stdout
```


## pyfastx_sample

### Tool Description
Sample sequences from a FASTA or FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
- **Homepage**: https://github.com/lmdu/pyfastx
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfastx sample [-h] (-n int | -p float) [-s int] [--sequential-read]
                      [-o str]
                      fastx

positional arguments:
  fastx                 fasta or fastq file, gzip support

options:
  -h, --help            show this help message and exit
  -n int                number of sequences to be sampled
  -p float              proportion of sequences to be sampled, 0~1
  -s int, --seed int    random seed, default is the current system time
  --sequential-read     start sequential reading, particularly suitable for
                        sampling large numbers of sequences
  -o str, --out-file str
                        output file, default: output to stdout
```


## pyfastx_extract

### Tool Description
Extract sequences from FASTA/FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
- **Homepage**: https://github.com/lmdu/pyfastx
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfastx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfastx extract [-h] [-l str] [--reverse-complement] [--out-fasta]
                       [-o str] [--sequential-read]
                       fastx [name ...]

positional arguments:
  fastx                 fasta or fastq file, gzip support
  name                  sequence name or read name, multiple names were
                        separated by space

options:
  -h, --help            show this help message and exit
  -l str, --list-file str
                        a file containing sequence or read names, one name per
                        line
  --reverse-complement  output reverse complement sequence
  --out-fasta           output fasta format when extract reads from fastq,
                        default output fastq format
  -o str, --out-file str
                        output file, default: output to stdout
  --sequential-read     start sequential reading, particularly suitable for
                        extracting large numbers of sequences
```

