# fq CWL Generation Report

## fq_filter

### Tool Description
Filters a FASTQ file

### Metadata
- **Docker Image**: quay.io/biocontainers/fq:0.12.0--h9ee0642_0
- **Homepage**: https://github.com/stjude-rust-labs/fq
- **Package**: https://anaconda.org/channels/bioconda/packages/fq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fq/overview
- **Total Downloads**: 15.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/stjude-rust-labs/fq
- **Stars**: N/A
### Original Help Text
```text
Filters a FASTQ file

Usage: fq filter [OPTIONS] --dsts <DSTS> [SRCS]...

Arguments:
  [SRCS]...  FASTQ sources

Options:
      --names <NAMES>
          Allowlist of record names
      --sequence-pattern <SEQUENCE_PATTERN>
          Keep records that have sequences that match the given regular expression
      --dsts <DSTS>
          Filtered FASTQ destinations
  -h, --help
          Print help
  -V, --version
          Print version
```


## fq_generate

### Tool Description
Generates a random FASTQ file pair

### Metadata
- **Docker Image**: quay.io/biocontainers/fq:0.12.0--h9ee0642_0
- **Homepage**: https://github.com/stjude-rust-labs/fq
- **Package**: https://anaconda.org/channels/bioconda/packages/fq/overview
- **Validation**: PASS

### Original Help Text
```text
Generates a random FASTQ file pair

Usage: fq generate [OPTIONS] <R1_DST> <R2_DST>

Arguments:
  <R1_DST>  Read 1 destination. Output will be gzipped if ends in `.gz`
  <R2_DST>  Read 2 destination. Output will be gzipped if ends in `.gz`

Options:
  -s, --seed <SEED>                  Seed to use for the random number generator
  -n, --record-count <RECORD_COUNT>  Number of records to generate [default: 10000]
      --read-length <READ_LENGTH>    Number of bases in the sequence [default: 101]
  -h, --help                         Print help
  -V, --version                      Print version
```


## fq_lint

### Tool Description
Validates a FASTQ file pair

### Metadata
- **Docker Image**: quay.io/biocontainers/fq:0.12.0--h9ee0642_0
- **Homepage**: https://github.com/stjude-rust-labs/fq
- **Package**: https://anaconda.org/channels/bioconda/packages/fq/overview
- **Validation**: PASS

### Original Help Text
```text
Validates a FASTQ file pair

Usage: fq lint [OPTIONS] <R1_SRC> [R2_SRC]

Arguments:
  <R1_SRC>
          Read 1 source. Accepts both raw and gzipped FASTQ inputs

  [R2_SRC]
          Read 2 source. Accepts both raw and gzipped FASTQ inputs

Options:
      --lint-mode <LINT_MODE>
          Panic on first error or log all errors
          
          [default: panic]
          [possible values: panic, log]

      --single-read-validation-level <SINGLE_READ_VALIDATION_LEVEL>
          Only use single read validators up to a given level
          
          [default: high]
          [possible values: low, medium, high]

      --paired-read-validation-level <PAIRED_READ_VALIDATION_LEVEL>
          Only use paired read validators up to a given level
          
          [default: high]
          [possible values: low, medium, high]

      --disable-validator <DISABLE_VALIDATOR>
          Disable validators by code. Use multiple times to disable more than one

      --record-definition-separator <RECORD_DEFINITION_SEPARATOR>
          Define a record definition separator.
          
          This is used to strip the definition from a record name.
          
          [default: '/' and ' ']

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```


## fq_subsample

### Tool Description
Outputs a subset of records

### Metadata
- **Docker Image**: quay.io/biocontainers/fq:0.12.0--h9ee0642_0
- **Homepage**: https://github.com/stjude-rust-labs/fq
- **Package**: https://anaconda.org/channels/bioconda/packages/fq/overview
- **Validation**: PASS

### Original Help Text
```text
Outputs a subset of records

Usage: fq subsample [OPTIONS] --r1-dst <R1_DST> <--probability <PROBABILITY>|--record-count <RECORD_COUNT>> <R1_SRC> [R2_SRC]

Arguments:
  <R1_SRC>  Read 1 source. Accepts both raw and gzipped FASTQ inputs
  [R2_SRC]  Read 2 source. Accepts both raw and gzipped FASTQ inputs

Options:
  -p, --probability <PROBABILITY>    The probability a record is kept, as a percentage (0.0, 1.0). Cannot be used with `record-count`
  -n, --record-count <RECORD_COUNT>  The exact number of records to keep. Cannot be used with `probability`
  -s, --seed <SEED>                  Seed to use for the random number generator
      --r1-dst <R1_DST>              Read 1 destination. Output will be gzipped if ends in `.gz`
      --r2-dst <R2_DST>              Read 2 destination. Output will be gzipped if ends in `.gz`
  -h, --help                         Print help
  -V, --version                      Print version
```

