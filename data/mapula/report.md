# mapula CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mapula_count | PASS |  |
| mapula_merge | PASS |  |

## mapula_count

### Tool Description
Count mapping stats from a SAM/BAM file

### mapula_merge

### Tool Description
Combine .json outputs from mapula count

### Metadata
- **Docker Image**: quay.io/biocontainers/mapula:2.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/epi2me-labs/mapula
- **Package**: https://anaconda.org/channels/bioconda/packages/mapula/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mapula [-h] [-c] [-f] [-n] [...]

Combine .json outputs from mapula count

positional arguments:
              Input .json files from mapula count. (Default: [stdin]).

optional arguments:
  -h, --help  show this help message and exit
  -c          Expected counts CSV. Required columns: reference,expected_count.
  -f          Sets the format(s) in which to output results. [Choices: csv,
              json, all] (Default: csv).
  -n          Prefix of the output files, if there are any.
```

## mapula_merge

### Tool Description
Combine .json outputs from mapula count

### Metadata
- **Docker Image**: quay.io/biocontainers/mapula:2.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/epi2me-labs/mapula
- **Package**: https://anaconda.org/channels/bioconda/packages/mapula/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mapula [-h] [-c] [-f] [-n] [...]

Combine .json outputs from mapula count

positional arguments:
              Input .json files from mapula count. (Default: [stdin]).

optional arguments:
  -h, --help  show this help message and exit
  -c          Expected counts CSV. Required columns: reference,expected_count.
  -f          Sets the format(s) in which to output results. [Choices: csv,
              json, all] (Default: csv).
  -n          Prefix of the output files, if there are any.
```

## Metadata
- **Docker Image**: quay.io/biocontainers/mapula:2.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/epi2me-labs/mapula
- **Package**: https://anaconda.org/channels/bioconda/packages/mapula/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mapula/overview
- **Total Downloads**: 12.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/epi2me-labs/mapula
- **Stars**: N/A
### Original Help Text
```text
usage: mapula [-h] -r [...] [-c] [-p] [-f] [-s  [...]] [-n] [...]

Count mapping stats from a SAM/BAM file

positional arguments:
              Input alignments in SAM format. (Default: [stdin]).

optional arguments:
  -h, --help  show this help message and exit
  -r [ ...]   Reference .fasta file(s).
  -c          Expected counts CSV. Required columns: reference,expected_count.
  -p          Enable relay of input SAM records to stdout.
  -f          If aggregating [-a], output results in this format. [Choices:
              csv, json, all] (Default: csv).
  -s  [ ...]  Change aggregation behaviour to split by these criteria, space
              separated. [Choices: source fasta run_id barcode read_group
              reference] (Default: all).
  -n          Prefix of the output files, if there are any.
```

