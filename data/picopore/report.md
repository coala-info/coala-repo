# picopore CWL Generation Report

## picopore

### Tool Description
A tool for reducing the size of an Oxford Nanopore Technologies dataset without losing any data

### Metadata
- **Docker Image**: quay.io/biocontainers/picopore:1.2.0--pyh8b68c5b_1
- **Homepage**: https://github.com/scottgigante/picopore
- **Package**: https://anaconda.org/channels/bioconda/packages/picopore/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/picopore/overview
- **Total Downloads**: 44.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/scottgigante/picopore
- **Stars**: N/A
### Original Help Text
```text
usage: picopore [-h] --mode {lossless,deep-lossless,raw} [--revert] [--fastq]
                [--summary] [--manual STR] [-v] [-y] [-t INT] [--prefix STR]
                [--skip-root] [--print-every INT]
                [input [input ...]]

A tool for reducing the size of an Oxford Nanopore Technologies dataset without losing any data

See also:
	picopore-realtime	monitors a directory for new reads and compresses them in real time
	picopore-test		compresses to temporary files and checks that all datasets and attributes are equal (lossless modes only)
	picopore-rename		renames groups and datasets within FAST5 files

positional arguments:
  input                 list of directories or fast5 files to shrink

optional arguments:
  -h, --help            show this help message and exit
  --mode {lossless,deep-lossless,raw}
                        choose compression mode
  --revert              reverts files to original size (lossless modes only)
  --fastq, --no-fastq   retain FASTQ data (raw mode only) (Default: --fastq)
  --summary, --no-summary
                        retain summary data (raw mode only) (Default: --no-
                        summary)
  --manual STR          manually remove only groups whose paths contain STR
                        (raw mode only, regular expressions permitted,
                        overrides defaults)
  -v, --version         show version number and exit
  -y                    skip confirm step
  -t INT, --threads INT
                        number of threads (Default: 1)
  --prefix STR          add prefix to output files to prevent overwrite
  --skip-root, --no-skip-root
                        ignore files in root input directories for albacore
                        realtime compression (Default: --no-skip-root)
  --print-every INT     print a dot every approximately INT files, or -1 to
                        silence (Default: 100)
```


## Metadata
- **Skill**: generated

## picopore_picopore-realtime

### Tool Description
A tool for monitoring a directory for new Oxford Nanopore Technologies reads and compressing them in real time without losing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/picopore:1.2.0--pyh8b68c5b_1
- **Homepage**: https://github.com/scottgigante/picopore
- **Package**: https://anaconda.org/channels/bioconda/packages/picopore/overview
- **Validation**: PASS
### Original Help Text
```text
usage: picopore-realtime [-h] --mode {lossless,deep-lossless,raw} [--revert]
                         [--fastq] [--summary] [--manual STR] [-v] [-y]
                         [-t INT] [--prefix STR] [--skip-root]
                         [--print-every INT]
                         [input [input ...]]

A tool for reducing the size of an Oxford Nanopore Technologies dataset without losing any data

"picopore-realtime monitors a directory for new reads and compresses them in real time

positional arguments:
  input                 list of directories or fast5 files to shrink

optional arguments:
  -h, --help            show this help message and exit
  --mode {lossless,deep-lossless,raw}
                        choose compression mode
  --revert              reverts files to original size (lossless modes only)
  --fastq, --no-fastq   retain FASTQ data (raw mode only) (Default: --fastq)
  --summary, --no-summary
                        retain summary data (raw mode only) (Default: --no-
                        summary)
  --manual STR          manually remove only groups whose paths contain STR
                        (raw mode only, regular expressions permitted,
                        overrides defaults)
  -v, --version         show version number and exit
  -y                    skip confirm step
  -t INT, --threads INT
                        number of threads (Default: 1)
  --prefix STR          add prefix to output files to prevent overwrite
  --skip-root, --no-skip-root
                        ignore files in root input directories for albacore
                        realtime compression (Default: --no-skip-root)
  --print-every INT     print a dot every approximately INT files, or -1 to
                        silence (Default: 100)
```

## picopore_picopore-test

### Tool Description
A tool for reducing the size of an Oxford Nanopore Technologies dataset without losing any data. picopore-test compresses to temporary files and checks that all datasets and attributes are equal (lossless modes only).

### Metadata
- **Docker Image**: quay.io/biocontainers/picopore:1.2.0--pyh8b68c5b_1
- **Homepage**: https://github.com/scottgigante/picopore
- **Package**: https://anaconda.org/channels/bioconda/packages/picopore/overview
- **Validation**: PASS
### Original Help Text
```text
usage: picopore-test [-h] --mode {lossless,deep-lossless,raw} [--revert]
                     [--fastq] [--summary] [--manual STR] [-v] [-y] [-t INT]
                     [--prefix STR] [--skip-root] [--print-every INT]
                     [input [input ...]]

A tool for reducing the size of an Oxford Nanopore Technologies dataset without losing any data

"picopore-test compresses to temporary files and checks that all datasets and attributes are equal (lossless modes only)

positional arguments:
  input                 list of directories or fast5 files to shrink

optional arguments:
  -h, --help            show this help message and exit
  --mode {lossless,deep-lossless,raw}
                        choose compression mode
  --revert              reverts files to original size (lossless modes only)
  --fastq, --no-fastq   retain FASTQ data (raw mode only) (Default: --fastq)
  --summary, --no-summary
                        retain summary data (raw mode only) (Default: --no-
                        summary)
  --manual STR          manually remove only groups whose paths contain STR
                        (raw mode only, regular expressions permitted,
                        overrides defaults)
  -v, --version         show version number and exit
  -y                    skip confirm step
  -t INT, --threads INT
                        number of threads (Default: 1)
  --prefix STR          add prefix to output files to prevent overwrite
  --skip-root, --no-skip-root
                        ignore files in root input directories for albacore
                        realtime compression (Default: --no-skip-root)
  --print-every INT     print a dot every approximately INT files, or -1 to
                        silence (Default: 100)
```

