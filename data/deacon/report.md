# deacon CWL Generation Report

## deacon_index

### Tool Description
Build, inspect, compose and fetch minimizer indexes

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
Build, inspect, compose and fetch minimizer indexes

Usage: deacon index <COMMAND>

Commands:
  build      Index minimizers contained within a fastx file
  union      Combine multiple minimizer indexes (A ∪ B…)
  intersect  Intersect multiple minimizer indexes (A ∩ B…)
  diff       Subtract minimizers in one index from another (A - B)
  dump       Dump minimizer index to fasta
  info       Show index information
  fetch      Fetch a pre-built index from remote storage
  help       Print this message or the help of the given subcommand(s)

Options:
  -h, --help  Print help
```


## deacon_filter

### Tool Description
Retain or deplete sequence records with sufficient minimizer hits to an indexed query

### Metadata
- **Docker Image**: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
- **Homepage**: https://github.com/bede/deacon
- **Package**: https://anaconda.org/channels/bioconda/packages/deacon/overview
- **Validation**: PASS

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


## deacon_server

### Tool Description
Start/stop a server process for reduced latency filtering

### Metadata
- **Docker Image**: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
- **Homepage**: https://github.com/bede/deacon
- **Package**: https://anaconda.org/channels/bioconda/packages/deacon/overview
- **Validation**: PASS

### Original Help Text
```text
Start/stop a server process for reduced latency filtering

Usage: deacon server <COMMAND>

Commands:
  start  Start the server
  stop   Stop the running server
  help   Print this message or the help of the given subcommand(s)

Options:
  -h, --help  Print help
```


## deacon_cite

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
- **Homepage**: https://github.com/bede/deacon
- **Package**: https://anaconda.org/channels/bioconda/packages/deacon/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Bede Constantinides, John Lees, Derrick W Crook.
"Deacon: fast sequence filtering and contaminant depletion"
bioRxiv 2025.06.09.658732
https://doi.org/10.1101/2025.06.09.658732
```

