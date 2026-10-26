# varfish-server-worker CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| varfish-server-worker_seqvars_aggregate | PASS |  |
| varfish-server-worker_seqvars_ingest | Not completed | needs a mehari transcript database (large download; the test copy in the repository is a git-lfs stub) |
| varfish-server-worker_seqvars_prefilter | PASS |  |
| varfish-server-worker_seqvars_query | Not completed | needs the worker annotation database and inhouse database (large downloads; test copies are git-lfs stubs) |
| varfish-server-worker_strucvars_aggregate | PASS |  |
| varfish-server-worker_strucvars_ingest | PASS |  |
| varfish-server-worker_strucvars_query | Not completed | needs the worker annotation database (large download; test copy is a git-lfs stub) |
| varfish-server-worker_strucvars_txt-to-bin | PASS |  |

## varfish-server-worker_strucvars_ingest

### Tool Description
Ingest structural variant VCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
- **Homepage**: https://github.com/varfish-org/varfish-server-worker
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-server-worker/overview
- **Validation**: PASS

### Original Help Text
```text
ingest structural variant VCF

Usage: varfish-server-worker strucvars ingest [OPTIONS] --file-date <FILE_DATE> --case-uuid <CASE_UUID> --genomebuild <GENOMEBUILD> --path-ped <PATH_PED> --path-in <PATH_IN> --path-out <PATH_OUT>

Options:
      --file-date <FILE_DATE>          Value to write to `##fileDate`
  -v, --verbose...                     Increase logging verbosity
      --case-uuid <CASE_UUID>          Value to write out for `##x-varfish-case-uuid`
  -q, --quiet...                       Decrease logging verbosity
      --genomebuild <GENOMEBUILD>      The assumed genome build [possible values: grch37, grch38]
      --path-ped <PATH_PED>            Path to the pedigree file
      --path-in <PATH_IN>              Path to input files
      --path-cov-vcf <PATH_COV_VCF>    Path to coverage VCF files from maelstrom; optional
      --path-out <PATH_OUT>            Path to output file
      --min-overlap <MIN_OVERLAP>      Minimal reciprocal overlap to require [default: 0.8]
      --slack-bnd <SLACK_BND>          Slack to use around break-ends [default: 50]
      --slack-ins <SLACK_INS>          Slack to use around insertions [default: 50]
      --rng-seed <RNG_SEED>            Seed for random number generator (UUIDs), if any
      --max-var-count <MAX_VAR_COUNT>  Maximal number of variants to write out; optional
      --id-mapping <ID_MAPPING>        Per-file identifier mapping, either a JSON or @-prefixed path to JSON
  -h, --help                           Print help (see more with '--help')
  -V, --version                        Print version
```

## varfish-server-worker_strucvars_query

### Tool Description
Run query for strucvars.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
- **Homepage**: https://github.com/varfish-org/varfish-server-worker
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-server-worker/overview
- **Validation**: PASS

### Original Help Text
```text
Run query for strucvars

Usage: varfish-server-worker strucvars query [OPTIONS] --genome-release <GENOME_RELEASE> --path-db <PATH_DB> --path-query-json <PATH_QUERY_JSON> --path-input <PATH_INPUT> --path-output <PATH_OUTPUT>

Options:
      --genome-release <GENOME_RELEASE>
          Genome release to assume [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
      --path-db <PATH_DB>
          Path to worker database to use for querying
  -q, --quiet...
          Decrease logging verbosity
      --path-query-json <PATH_QUERY_JSON>
          Path to query JSON file
      --path-input <PATH_INPUT>
          Path to input TSV file
      --path-output <PATH_OUTPUT>
          Path to the output TSV file
      --max-results <MAX_RESULTS>
          Optional maximal number of total records to write out
      --slack-bnd <SLACK_BND>
          Radius around BND sites used when building the database [default: 50]
      --slack-ins <SLACK_INS>
          Radius around INS sites used when building the database [default: 50]
      --min-overlap <MIN_OVERLAP>
          Minimal reciprocal overlap for SVs of the same type, used when building the database [default: 0.8]
      --max-tad-distance <MAX_TAD_DISTANCE>
          Maximal distance to TAD to consider [default: 10000]
      --rng-seed <RNG_SEED>
          Optional seed for RNG
  -h, --help
          Print help (see more with '--help')
  -V, --version
          Print version
```

## varfish-server-worker_strucvars_aggregate

### Tool Description
Build inhouse database.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
- **Homepage**: https://github.com/varfish-org/varfish-server-worker
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-server-worker/overview
- **Validation**: PASS

### Original Help Text
```text
Build inhouse database

Usage: varfish-server-worker strucvars aggregate [OPTIONS] --path-output <PATH_OUTPUT> <PATH_INPUT>...

Arguments:
  <PATH_INPUT>...  Input files to cluster, prefix with `@` to file with line-wise paths

Options:
      --genome-release <GENOME_RELEASE>
          Genome build to use in the build [default: grch37] [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
      --path-output <PATH_OUTPUT>
          Path to output TSV file
  -q, --quiet...
          Decrease logging verbosity
      --min-overlap <MIN_OVERLAP>
          Minimal reciprocal overlap to use (slightly more strict that the normal query value of 0.75) [default: 0.8]
      --slack-bnd <SLACK_BND>
          Padding to use for BNDs [default: 50]
      --slack-ins <SLACK_INS>
          Padding to use for INS [default: 50]
  -h, --help
          Print help (see more with '--help')
```

## varfish-server-worker_seqvars_prefilter

### Tool Description
Prefilter an ingested variant VCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
- **Homepage**: https://github.com/varfish-org/varfish-server-worker
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-server-worker/overview
- **Validation**: PASS

### Original Help Text
```text
prefilter an ingested variant VCF

Usage: varfish-server-worker seqvars prefilter [OPTIONS] --path-in <PATH_IN>

Options:
      --path-in <PATH_IN>  Path to input file
  -v, --verbose...         Increase logging verbosity
      --params <PARAMS>    Prefilter parameters or @ with path to JSONL file
  -q, --quiet...           Decrease logging verbosity
  -h, --help               Print help
  -V, --version            Print version
```

## varfish-server-worker_seqvars_ingest

### Tool Description
Ingest sequence variant VCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
- **Homepage**: https://github.com/varfish-org/varfish-server-worker
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-server-worker/overview
- **Validation**: PASS

### Original Help Text
```text
ingest sequence variant VCF

Usage: varfish-server-worker seqvars ingest [OPTIONS] --file-date <FILE_DATE> --case-uuid <CASE_UUID> --genomebuild <GENOMEBUILD> --path-mehari-db <PATH_MEHARI_DB> --path-ped <PATH_PED> --path-in <PATH_IN> --path-out <PATH_OUT>

Options:
      --file-date <FILE_DATE>
          Value to write to `##fileDate`
  -v, --verbose...
          Increase logging verbosity
      --case-uuid <CASE_UUID>
          The case UUID to write out
  -q, --quiet...
          Decrease logging verbosity
      --genomebuild <GENOMEBUILD>
          The assumed genome build [possible values: grch37, grch38]
      --path-mehari-db <PATH_MEHARI_DB>
          The path to the mehari database
      --path-ped <PATH_PED>
          Path to the pedigree file
      --path-in <PATH_IN>
          Path to input file
      --path-out <PATH_OUT>
          Path to output file
      --max-var-count <MAX_VAR_COUNT>
          Maximal number of variants to write out; optional
      --id-mapping <ID_MAPPING>
          Per-file identifier mapping, either a JSON or @-prefixed path to JSON
  -h, --help
          Print help (see more with '--help')
  -V, --version
          Print version
```

## varfish-server-worker_seqvars_aggregate

### Tool Description
Build/update seqvars inhouse database.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
- **Homepage**: https://github.com/varfish-org/varfish-server-worker
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-server-worker/overview
- **Validation**: PASS

### Original Help Text
```text
build/update seqvars inhouse dabase

Usage: varfish-server-worker seqvars aggregate [OPTIONS] --genomebuild <GENOMEBUILD> --path-out-rocksdb <PATH_OUT_ROCKSDB>

Options:
      --genomebuild <GENOMEBUILD>
          The assumed genome build [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
      --path-out-rocksdb <PATH_OUT_ROCKSDB>
          Path to the output RocksDB
  -q, --quiet...
          Decrease logging verbosity
      --path-input <PATH_INPUT>
          Path to input VCF file(s)
      --cf-counts <CF_COUNTS>
          Column family name for the count data [default: counts]
      --cf-carriers <CF_CARRIERS>
          Column family name for the carrier UUID data [default: carriers]
      --num-threads <NUM_THREADS>
          Set the number of threads to use, defaults to number of cores
      --path-wal-dir <PATH_WAL_DIR>
          Optional path to RocksDB WAL directory
  -h, --help
          Print help (see more with '--help')
  -V, --version
          Print version
```

## varfish-server-worker_seqvars_query

### Tool Description
Run query for seqvars.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
- **Homepage**: https://github.com/varfish-org/varfish-server-worker
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-server-worker/overview
- **Validation**: PASS

### Original Help Text
```text
Run query for seqvars

Usage: varfish-server-worker seqvars query [OPTIONS] --genome-release <GENOME_RELEASE> --path-db <PATH_DB> --path-query-json <PATH_QUERY_JSON> --path-input <PATH_INPUT> --path-output <PATH_OUTPUT>

Options:
      --genome-release <GENOME_RELEASE>
          Genome release to assume [possible values: grch37, grch38]
  -v, --verbose...
          Increase logging verbosity
  -q, --quiet...
          Decrease logging verbosity
      --result-set-id <RESULT_SET_ID>
          Result set ID
      --case-uuid <CASE_UUID>
          The case UUID
      --path-db <PATH_DB>
          Path to worker database to use for querying
      --path-inhouse-db <PATH_INHOUSE_DB>
          Path to inhouse rocksdb folder
      --path-query-json <PATH_QUERY_JSON>
          Path to query JSON file
      --path-input <PATH_INPUT>
          Path to input TSV file
      --path-output <PATH_OUTPUT>
          Path to the output TSV file
      --max-results <MAX_RESULTS>
          Optional maximal number of total records to write out
      --rng-seed <RNG_SEED>
          Optional seed for RNG
      --max-tad-distance <MAX_TAD_DISTANCE>
          Maximal distance to TAD to consider (unused, but required when loading database) [default: 10000]
  -h, --help
          Print help (see more with '--help')
  -V, --version
          Print version
```

## varfish-server-worker_strucvars_txt-to-bin

### Tool Description
Convert to binary protobuf files.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
- **Homepage**: https://github.com/varfish-org/varfish-server-worker
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-server-worker/overview
- **Validation**: PASS

### Original Help Text
```text
Convert to binary protobuf files

Usage: varfish-server-worker strucvars txt-to-bin [OPTIONS] --input-type <INPUT_TYPE> --path-input <PATH_INPUT> --path-output <PATH_OUTPUT>

Options:
      --input-type <INPUT_TYPE>    Input type to convert to binary [possible values: clinvar-sv, strucvar-inhouse, strucvar-db-var, strucvar-dgv, strucvar-dgv-gs, strucvar-exac-cnv, strucvar-g1k, strucvar-gnomad-sv2, strucvar-gnomad-cnv4, strucvar-gnomad-sv4, masked-region, xlink]
  -v, --verbose...                 Increase logging verbosity
      --path-input <PATH_INPUT>    Input file to convert to binary
  -q, --quiet...                   Decrease logging verbosity
      --path-output <PATH_OUTPUT>  Path to output BIN file
  -h, --help                       Print help (see more with '--help')
```

## Metadata
- **Skill**: generated
