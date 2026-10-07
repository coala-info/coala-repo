# deacon CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| deacon_filter | PASS |  |
| deacon_index_build | PASS |  |
| deacon_index_diff | PASS |  |
| deacon_index_dump | PASS |  |
| deacon_index_fetch | Not completed | Fetching needs network access and downloads a multi-gigabyte prebuilt human index, too large for this test. |
| deacon_index_info | PASS |  |
| deacon_index_intersect | PASS |  |
| deacon_index_union | PASS |  |

## deacon_filter

### Tool Description
Retain or deplete sequence records with sufficient minimizer hits to an indexed query

### Metadata
- **Docker Image**: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
- **Homepage**: https://github.com/bede/deacon
- **Package**: https://anaconda.org/channels/bioconda/packages/deacon/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deacon/overview
- **Total Downloads**: 9.7K
- **Last updated**: 2025-11-21
- **GitHub**: https://github.com/bede/deacon
- **Stars**: N/A

### Original Help Text
```text
Retain or deplete sequence records with sufficient minimizer hits to an indexed query

Usage: deacon filter [OPTIONS] <INDEX> [INPUT] [INPUT2]

Arguments:
  <INDEX>   Path to minimizer index file
  [INPUT]   Optional path to fastx file (or - for stdin) [default: -]
  [INPUT2]  Optional path to second paired fastx file (or - for interleaved stdin)

Options:
  -a, --abs-threshold <ABS_THRESHOLD>
          Minimum absolute number of minimizer hits for a match [default: 2]
  -r, --rel-threshold <REL_THRESHOLD>
          Minimum relative proportion (0.0-1.0) of minimizer hits for a match [default: 0.01]
  -p, --prefix-length <PREFIX_LENGTH>
          Search only the first N nucleotides per sequence (0 = entire sequence) [default: 0]
  -d, --deplete
          Discard matching sequences (invert filtering behaviour)
  -R, --rename
          Replace sequence headers with incrementing numbers
      --rename-random
          Replace sequence headers with incrementing numbers and random suffixes
  -o, --output <OUTPUT>
          Path to output fastx file (stdout if not specified; detects .gz and .zst)
  -O, --output2 <OUTPUT2>
          Optional path to second paired output fastx file (detects .gz and .zst)
  -s, --summary <SUMMARY>
          Path to JSON summary output file
  -t, --threads <THREADS>
          Number of threads (0 = auto) [default: 8]
      --compression-threads <COMPRESSION_THREADS>
          Number of threads used for output compression (0 = auto) [default: 0]
      --compression-level <COMPRESSION_LEVEL>
          Output compression level (1-9 for gz & xz; 1-22 for zstd) [default: 2]
      --debug
          Output sequences with minimizer hits to stderr
  -q, --quiet
          Suppress progress reporting
  -h, --help
          Print help
```

## deacon_index_build

### Tool Description
Index minimizers contained within a fastx file

### Metadata
- **Docker Image**: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
- **Homepage**: https://github.com/bede/deacon
- **Package**: https://anaconda.org/channels/bioconda/packages/deacon/overview
- **Validation**: PASS

### Original Help Text
```text
Index minimizers contained within a fastx file

Usage: deacon index build [OPTIONS] <INPUT>

Arguments:
  <INPUT>  Path to input fastx file (or - for stdin; supports gz, zst and xz compression)

Options:
  -k <KMER_LENGTH>
          K-mer length used for indexing (k+w-1 must be <= 96 and odd) [default: 31]
  -w <WINDOW_SIZE>
          Minimizer window size used for indexing [default: 15]
  -o, --output <OUTPUT>
          Path to output file (stdout if not specified)
  -t, --threads <THREADS>
          Number of execution threads (0 = auto) [default: 8]
  -q, --quiet
          Suppress sequence header output
  -e, --entropy-threshold <ENTROPY_THRESHOLD>
          Minimum scaled entropy threshold for k-mer filtering (0.0-1.0) [default: 0.0]
  -h, --help
          Print help
```

## deacon_index_union

### Tool Description
Combine multiple minimizer indexes (A ∪ B…)

### Metadata
- **Docker Image**: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
- **Homepage**: https://github.com/bede/deacon
- **Package**: https://anaconda.org/channels/bioconda/packages/deacon/overview
- **Validation**: PASS

### Original Help Text
```text
Combine multiple minimizer indexes (A ∪ B…)

Usage: deacon index union [OPTIONS] <INPUTS>...

Arguments:
  <INPUTS>...  Path(s) to one or more index file(s)

Options:
  -o, --output <OUTPUT>  Path to output file (stdout if not specified)
  -h, --help             Print help
```

## deacon_index_intersect

### Tool Description
Intersect multiple minimizer indexes (A ∩ B…)

### Metadata
- **Docker Image**: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
- **Homepage**: https://github.com/bede/deacon
- **Package**: https://anaconda.org/channels/bioconda/packages/deacon/overview
- **Validation**: PASS

### Original Help Text
```text
Intersect multiple minimizer indexes (A ∩ B…)

Usage: deacon index intersect [OPTIONS] <INPUTS>...

Arguments:
  <INPUTS>...  Path(s) to two or more index file(s)

Options:
  -o, --output <OUTPUT>  Path to output file (stdout if not specified)
  -h, --help             Print help
```

## deacon_index_diff

### Tool Description
Subtract minimizers in one index from another (A - B)

### Metadata
- **Docker Image**: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
- **Homepage**: https://github.com/bede/deacon
- **Package**: https://anaconda.org/channels/bioconda/packages/deacon/overview
- **Validation**: PASS

### Original Help Text
```text
Subtract minimizers in one index from another (A - B)

Usage: deacon index diff [OPTIONS] <FIRST> <SECOND>

Arguments:
  <FIRST>   Path to first index file
  <SECOND>  Path to second index file or FASTX file (or - for stdin when using FASTX)

Options:
  -k, --kmer-length <KMER_LENGTH>  K-mer length (required if second argument is FASTX file, 1-32)
  -w, --window-size <WINDOW_SIZE>  Window size (required if second argument is FASTX file)
  -t, --threads <THREADS>          Number of execution threads (0 = auto) [default: 8]
  -o, --output <OUTPUT>            Path to output file (stdout if not specified)
  -h, --help                       Print help
```

## deacon_index_dump

### Tool Description
Dump minimizer index to fasta

### Metadata
- **Docker Image**: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
- **Homepage**: https://github.com/bede/deacon
- **Package**: https://anaconda.org/channels/bioconda/packages/deacon/overview
- **Validation**: PASS

### Original Help Text
```text
Dump minimizer index to fasta

Usage: deacon index dump [OPTIONS] <INDEX>

Arguments:
  <INDEX>  Path to index file

Options:
  -o, --output <OUTPUT>  Path to output file (stdout if not specified)
  -h, --help             Print help
```

## deacon_index_info

### Tool Description
Show index information

### Metadata
- **Docker Image**: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
- **Homepage**: https://github.com/bede/deacon
- **Package**: https://anaconda.org/channels/bioconda/packages/deacon/overview
- **Validation**: PASS

### Original Help Text
```text
Show index information

Usage: deacon index info <INDEX>

Arguments:
  <INDEX>  Path to index file

Options:
  -h, --help  Print help
```

## deacon_index_fetch

### Tool Description
Fetch a pre-built index from remote storage

### Metadata
- **Docker Image**: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
- **Homepage**: https://github.com/bede/deacon
- **Package**: https://anaconda.org/channels/bioconda/packages/deacon/overview
- **Validation**: PASS

### Original Help Text
```text
Fetch a pre-built index from remote storage

Usage: deacon index fetch [OPTIONS] [INDEX_NAME]

Arguments:
  [INDEX_NAME]  Index name (e.g., panhuman-1) [default: panhuman-1]

Options:
  -k <KMER_LENGTH>       K-mer length [default: 31]
  -w <WINDOW_SIZE>       Minimizer window size [default: 15]
  -o, --output <OUTPUT>  Path to output file (default: ./)
  -h, --help             Print help
```

## Metadata
- **Skill**: generated
