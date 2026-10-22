# sickle CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sickle_pe | PASS |  |
| sickle_se | PASS |  |

## sickle_se

### Tool Description
Single-end windowed adaptive trimming of FASTQ files using quality.

### Metadata
- **Docker Image**: biocontainers/sickle:v1.33-1b1-deb_cv1
- **Homepage**: https://github.com/najoshi/sickle
- **Package**: https://anaconda.org/channels/bioconda/packages/sickle/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: sickle se [options] -f <fastq sequence file> -t <quality type> -o <trimmed fastq file>

Options:
-f, --fastq-file, Input fastq file (required)
-t, --qual-type, Type of quality values (solexa (CASAVA < 1.3), illumina (CASAVA 1.3 to 1.7), sanger (which is CASAVA >= 1.8)) (required)
-o, --output-file, Output trimmed fastq file (required)
-q, --qual-threshold, Threshold for trimming based on average quality in a window. Default 20.
-l, --length-threshold, Threshold to keep a read based on length after trimming. Default 20.
-x, --no-fiveprime, Don't do five prime trimming.
-n, --trunc-n, Truncate sequences at position of first N.
-g, --gzip-output, Output gzipped files.
--quiet, Don't print out any trimming information
--help, display this help and exit
--version, output version information and exit
```

## sickle_pe

### Tool Description
Paired-end windowed adaptive trimming of FASTQ files using quality.

### Metadata
- **Docker Image**: biocontainers/sickle:v1.33-1b1-deb_cv1
- **Homepage**: https://github.com/najoshi/sickle
- **Package**: https://anaconda.org/channels/bioconda/packages/sickle/overview
- **Validation**: PASS

### Original Help Text
```text

```

