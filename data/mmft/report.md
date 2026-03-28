# mmft CWL Generation Report

## mmft_len

### Tool Description
Calculate lengths of fasta file records.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
- **Homepage**: https://github.com/ARU-life-sciences/mmft
- **Package**: https://anaconda.org/channels/bioconda/packages/mmft/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mmft/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ARU-life-sciences/mmft
- **Stars**: N/A
### Original Help Text
```text
Calculate lengths of fasta file records.

Usage: mmft len [OPTIONS] [fasta]...

Arguments:
  [fasta]...  Input fasta file path(s).

Options:
  -e, --extract <extract>  Fasta records with a length greater than specified are printed.
  -l, --less               Print records with lengths less than value of extract. Default is greater.
  -h, --help               Print help
  -V, --version            Print version
```


## mmft_gc

### Tool Description
Calculate GC content of fasta file records.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
- **Homepage**: https://github.com/ARU-life-sciences/mmft
- **Package**: https://anaconda.org/channels/bioconda/packages/mmft/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate GC content of fasta file records.

Usage: mmft gc [fasta]...

Arguments:
  [fasta]...  Input fasta file path(s).

Options:
  -h, --help     Print help
  -V, --version  Print version
```


## mmft_n50

### Tool Description
Calculates the N50 statistic for a given FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
- **Homepage**: https://github.com/ARU-life-sciences/mmft
- **Package**: https://anaconda.org/channels/bioconda/packages/mmft/overview
- **Validation**: PASS

### Original Help Text
```text
thread 'main' panicked at src/fasta/n50.rs:59:5:
index out of bounds: the len is 0 but the index is 18446744073709551615
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```


## mmft_regex

### Tool Description
Extract fasta records using regex on headers.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
- **Homepage**: https://github.com/ARU-life-sciences/mmft
- **Package**: https://anaconda.org/channels/bioconda/packages/mmft/overview
- **Validation**: PASS

### Original Help Text
```text
Extract fasta records using regex on headers.

Usage: mmft regex [OPTIONS] --regex <regex> [fasta]...

Arguments:
  [fasta]...  Input fasta file path(s).

Options:
  -r, --regex <regex>  Regex to compile.
  -i, --inverse        Inverse regex match.
  -h, --help           Print help
  -V, --version        Print version
```


## mmft_extract

### Tool Description
Extract (sub)sequence within a fasta file record.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
- **Homepage**: https://github.com/ARU-life-sciences/mmft
- **Package**: https://anaconda.org/channels/bioconda/packages/mmft/overview
- **Validation**: PASS

### Original Help Text
```text
Extract (sub)sequence within a fasta file record.

Usage: mmft extract --region <region> [fasta]...

Arguments:
  [fasta]...  Input fasta file path(s).

Options:
  -r, --region <region>  Numeric region to extract.
  -h, --help             Print help
  -V, --version          Print version
```


## mmft_num

### Tool Description
Calculate number and total base count of fasta file records.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
- **Homepage**: https://github.com/ARU-life-sciences/mmft
- **Package**: https://anaconda.org/channels/bioconda/packages/mmft/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate number and total base count of fasta file records.

Usage: mmft num [fasta]...

Arguments:
  [fasta]...  Input fasta file path(s).

Options:
  -h, --help     Print help
  -V, --version  Print version
```


## mmft_merge

### Tool Description
Merge sequence records within/between fasta files into a single fasta record.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
- **Homepage**: https://github.com/ARU-life-sciences/mmft
- **Package**: https://anaconda.org/channels/bioconda/packages/mmft/overview
- **Validation**: PASS

### Original Help Text
```text
Merge sequence records within/between fasta files into a single fasta record.

Usage: mmft merge [OPTIONS] [fasta]...

Arguments:
  [fasta]...  Input fasta file path(s).

Options:
  -t, --track            Keep track of record indexes in fasta header
      --header <header>  Name of output fasta header.
  -h, --help             Print help
  -V, --version          Print version
```


## mmft_trans

### Tool Description
Translate a fasta into all six frames.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
- **Homepage**: https://github.com/ARU-life-sciences/mmft
- **Package**: https://anaconda.org/channels/bioconda/packages/mmft/overview
- **Validation**: PASS

### Original Help Text
```text
Translate a fasta into all six frames.

Usage: mmft trans [fasta]...

Arguments:
  [fasta]...  Input fasta file path(s).

Options:
  -h, --help     Print help
  -V, --version  Print version
```


## mmft_filter

### Tool Description
Filter sequences on a file of ID's

### Metadata
- **Docker Image**: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
- **Homepage**: https://github.com/ARU-life-sciences/mmft
- **Package**: https://anaconda.org/channels/bioconda/packages/mmft/overview
- **Validation**: PASS

### Original Help Text
```text
Filter sequences on a file of ID's

Usage: mmft filter --file <file> [fasta]...

Arguments:
  [fasta]...  Input fasta file path(s).

Options:
  -f, --file <file>  Name of text file with one ID per line.
  -h, --help         Print help
  -V, --version      Print version
```


## mmft_sample

### Tool Description
Randomly sample records from a fasta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
- **Homepage**: https://github.com/ARU-life-sciences/mmft
- **Package**: https://anaconda.org/channels/bioconda/packages/mmft/overview
- **Validation**: PASS

### Original Help Text
```text
Randomly sample records from a fasta file.

Usage: mmft sample [OPTIONS] [fasta]...

Arguments:
  [fasta]...  Input fasta file path(s).

Options:
  -n, --sample-number <sample-number>  Number of records to sample.
  -s, --sample-size <sample-size>      Target file size for the sampled sequences (e.g. 10Mb, 3Kb, 5Gb)
  -h, --help                           Print help
  -V, --version                        Print version
```


## mmft_reverse

### Tool Description
Reverse complement each record in an input fasta

### Metadata
- **Docker Image**: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
- **Homepage**: https://github.com/ARU-life-sciences/mmft
- **Package**: https://anaconda.org/channels/bioconda/packages/mmft/overview
- **Validation**: PASS

### Original Help Text
```text
Reverse complement each record in an input fasta

Usage: mmft reverse [fasta]...

Arguments:
  [fasta]...  Input fasta file path(s).

Options:
  -h, --help     Print help
  -V, --version  Print version
```


## mmft_min

### Tool Description
Return the lexicographically minimal rotation of fasta file record sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
- **Homepage**: https://github.com/ARU-life-sciences/mmft
- **Package**: https://anaconda.org/channels/bioconda/packages/mmft/overview
- **Validation**: PASS

### Original Help Text
```text
Return the lexicographically minimal rotation of fasta file record sequences.

Usage: mmft min [fasta]...

Arguments:
  [fasta]...  Input fasta file path(s).

Options:
  -h, --help     Print help
  -V, --version  Print version
```


## mmft_split

### Tool Description
Split a fasta into multiple files based on record count.

### Metadata
- **Docker Image**: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
- **Homepage**: https://github.com/ARU-life-sciences/mmft
- **Package**: https://anaconda.org/channels/bioconda/packages/mmft/overview
- **Validation**: PASS

### Original Help Text
```text
Split a fasta into multiple files based on record count.

Usage: mmft split [OPTIONS] --number <number> [fasta]...

Arguments:
  [fasta]...  Input fasta file path(s).

Options:
  -n, --number <number>  Number of records per file.
  -d, --dir <dir>        Output directory for split files. Default is current working directory. [default: .]
  -h, --help             Print help
  -V, --version          Print version
```


## Metadata
- **Skill**: generated
