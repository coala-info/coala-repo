# binlorry CWL Generation Report

## binlorry

### Tool Description
BinLorry: a tool for binning sequencing reads into files based on header information or read properties.

### Metadata
- **Docker Image**: quay.io/biocontainers/binlorry:1.3.1--py_0
- **Homepage**: https://github.com/rambaut/binlorry
- **Package**: https://anaconda.org/channels/bioconda/packages/binlorry/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/binlorry/overview
- **Total Downloads**: 3.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rambaut/binlorry
- **Stars**: N/A
### Original Help Text
```text
usage: binlorry -i INPUT_PATH [-t CSV_FILE] [-u] -o OUTPUT [-r] [-f]
                [-v VERBOSITY] [--bin-by FIELD [FIELD ...]]
                [--filter-by FILTER [FILTER ...]] [-n MIN] [-x MAX] [-d DELIM]
                [-h] [--version]

BinLorry: a tool for binning sequencing reads into files based on header
information or read properties.

Main options:
  -i INPUT_PATH, --input INPUT_PATH
                          FASTA/FASTQ of input reads or a directory which will
                          be recursively searched for FASTQ files (required).
  -t CSV_FILE, --data CSV_FILE
                          A CSV file with metadata fields for reads or a
                          directory of csv files that will be recursively
                          searched for names corresponding to a matching input
                          FASTA/FASTQ files.
  -u, --unordered_data    The metadata tables are not in the same order as the
                          reads - they will all beloaded and then looked up as
                          needed (slower). (default: False)
  -o OUTPUT, --output OUTPUT
                          Output filename (or filename prefix)
  -r, --out-report        Output a report along with FASTA/FASTQ. (default:
                          False)
  -f, --force-output      Output binned/filtered files even if empty.
                          (default: False)
  -v VERBOSITY, --verbosity VERBOSITY
                          Level of output information: 0 = none, 1 = some, 2 =
                          lots (default: 1)

Binning/Filtering options:
  --bin-by FIELD [FIELD ...]
                          Specify header field(s) to bin the reads by. For
                          multiple fields these will be nested in order
                          specified. e.g. `--bin-by barcode reference`
  --filter-by FILTER [FILTER ...]
                          Specify header field and accepted values to filter
                          the reads by. Multiple instances of this option can
                          be specified. e.g. `--filter-by barcode BC01 BC02--
                          filter-by genotype Type1`
  -n MIN, --min-length MIN
                          Filter the reads by their length, specifying the
                          minimum length.
  -x MAX, --max-length MAX
                          Filter the reads by their length, specifying the
                          maximum length.
  -d DELIM, --header-delimiters DELIM
                          Delimiters to use when searching for key:value pairs
                          in FASTA/FASTQ header. (default: =)

Help:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```

