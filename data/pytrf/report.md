# pytrf CWL Generation Report

## pytrf_findstr

### Tool Description
Finds simple tandem repeats in fasta or fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pytrf:1.4.2--py310h1fe012e_1
- **Homepage**: https://github.com/lmdu/pytrf
- **Package**: https://anaconda.org/channels/bioconda/packages/pytrf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pytrf/overview
- **Total Downloads**: 17.9K
- **Last updated**: 2025-12-01
- **GitHub**: https://github.com/lmdu/pytrf
- **Stars**: N/A
### Original Help Text
```text
usage: pytrf findstr [-h] [-o] [-f] [-r mono di tri tetra penta hexa] fastx

positional arguments:
  fastx                 input fasta or fastq file (gzip support)

options:
  -h, --help            show this help message and exit
  -o , --out-file       output file (default: stdout)
  -f , --out-format     output format, tsv, csv, bed or gff (default: tsv)
  -r mono di tri tetra penta hexa, --repeats mono di tri tetra penta hexa
                        minimum repeats for each STR type (default: 12 7 5 4 4
                        4)
```


## pytrf_findgtr

### Tool Description
Finds tandem repeats in a fasta or fastq file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pytrf:1.4.2--py310h1fe012e_1
- **Homepage**: https://github.com/lmdu/pytrf
- **Package**: https://anaconda.org/channels/bioconda/packages/pytrf/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pytrf findgtr [-h] [-o] [-f] [-m] [-M] [-r] [-l] fastx

positional arguments:
  fastx               input fasta or fastq file (gzip support)

options:
  -h, --help          show this help message and exit
  -o , --out-file     output file (default: stdout)
  -f , --out-format   output format, tsv, csv, bed or gff (default: tsv)
  -m , --min-motif    minimum motif length (default: 10)
  -M , --max-motif    maximum motif length (default: 100)
  -r , --min-repeat   minimum repeat number (default: 3)
  -l , --min-length   minimum repeat length (default: 10)
```


## pytrf_findatr

### Tool Description
Finds tandem repeats in a FASTA or FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pytrf:1.4.2--py310h1fe012e_1
- **Homepage**: https://github.com/lmdu/pytrf
- **Package**: https://anaconda.org/channels/bioconda/packages/pytrf/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pytrf findatr [-h] [-o] [-f] [-m] [-M] [-r] [-l] [-e] [-p] [-x] fastx

positional arguments:
  fastx                 input fasta or fastq file (gzip support)

options:
  -h, --help            show this help message and exit
  -o , --out-file       output file (default: stdout)
  -f , --out-format     output format, tsv, csv, bed or gff (default: tsv)
  -m , --min-motif      minimum motif length (default: 1)
  -M , --max-motif      maximum motif length (default: 6)
  -r , --min-seedrep    minimum repeat number for seed (default: 3)
  -l , --min-seedlen    minimum length for seed (default: 10)
  -e , --max-errors     maximum number of continuous alignment errors
                        (default: 3)
  -p , --min-identity   minimum identity for extending, 0 to 100 (default: 70)
  -x , --max-extend     maximum length allowed to extend (default: 2000)
```


## pytrf_extract

### Tool Description
Extracts sequences from fasta or fastq files based on repeat information.

### Metadata
- **Docker Image**: quay.io/biocontainers/pytrf:1.4.2--py310h1fe012e_1
- **Homepage**: https://github.com/lmdu/pytrf
- **Package**: https://anaconda.org/channels/bioconda/packages/pytrf/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pytrf extract [-h] -r  [-o] [-f] [-l] fastx

positional arguments:
  fastx                 input fasta or fastq file (gzip support)

options:
  -h, --help            show this help message and exit
  -r , --repeat-file    the csv or tsv output file of findatr, findstr or
                        findgtr
  -o , --out-file       output file (default: stdout)
  -f , --out-format     output format, tsv, csv or fasta (default: tsv)
  -l , --flank-length   flanking sequence length (default: 100)
```

