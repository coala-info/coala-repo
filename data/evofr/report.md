# evofr CWL Generation Report

## evofr_prepare-data

### Tool Description
Prepare data for evofr analysis using a configuration file and optional overrides.

### Metadata
- **Docker Image**: quay.io/biocontainers/evofr:0.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/blab/evofr
- **Package**: https://anaconda.org/channels/bioconda/packages/evofr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/evofr/overview
- **Total Downloads**: 54.3K
- **Last updated**: 2026-02-12
- **GitHub**: https://github.com/blab/evofr
- **Stars**: N/A
### Original Help Text
```text
usage: evofr prepare-data [-h] --config CONFIG [--seq-counts SEQ_COUNTS]
                          [--cases CASES]
                          [--output-seq-counts OUTPUT_SEQ_COUNTS]
                          [--output-cases OUTPUT_CASES]

options:
  -h, --help            show this help message and exit
  --config CONFIG       Path to YAML configuration file
  --seq-counts SEQ_COUNTS
                        Optional override: input sequence counts TSV
  --cases CASES         Optional override: input case counts TSV (optional)
  --output-seq-counts OUTPUT_SEQ_COUNTS
                        Optional override: output sequence counts TSV
  --output-cases OUTPUT_CASES
                        Optional override: output case counts TSV (optional)
```


## evofr_run-model

### Tool Description
Run an evofr model using a configuration file and optional data overrides.

### Metadata
- **Docker Image**: quay.io/biocontainers/evofr:0.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/blab/evofr
- **Package**: https://anaconda.org/channels/bioconda/packages/evofr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: evofr run-model [-h] --config CONFIG [--export-path EXPORT_PATH]
                       [--seq-path SEQ_PATH] [--cases-path CASES_PATH]
                       [--pivot PIVOT]

options:
  -h, --help            show this help message and exit
  --config CONFIG       Path to YAML configuration file
  --export-path EXPORT_PATH
                        Optional export directory override
  --seq-path SEQ_PATH   Optional sequence data override
  --cases-path CASES_PATH
                        Optional case data override
  --pivot PIVOT         Optional variant pivot override
```


## Metadata
- **Skill**: generated
