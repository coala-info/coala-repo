# vkmz CWL Generation Report

## vkmz_tabular

### Tool Description
Parses tabular files for mass spectrometry data.

### Metadata
- **Docker Image**: quay.io/biocontainers/vkmz:1.4.6--py_0
- **Homepage**: https://github.com/HegemanLab/VKMZ
- **Package**: https://anaconda.org/channels/bioconda/packages/vkmz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vkmz/overview
- **Total Downloads**: 20.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/HegemanLab/VKMZ
- **Stars**: N/A
### Original Help Text
```text
usage: vkmz tabular [-h] --input INPUT --error [ERROR] --output [OUTPUT]
                    [--json] [--sql] [--metadata] [--database [DATABASE]]
                    [--prefix [PREFIX]] [--polarity {positive,negative}]
                    [--neutral] [--alternate] [--impute-charge]

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        Path to tabular file.
  --error [ERROR], -e [ERROR]
                        Mass error of MS data in parts-per-million
  --output [OUTPUT], -o [OUTPUT]
                        Specify output file path
  --json, -j            Set JSON flag to save JSON output
  --sql, -s             Set SQL flag to save SQL output
  --metadata, -m        Set metadata flag to save argument metadata
  --database [DATABASE], -db [DATABASE]
                        Define path to custom database of known formula-mass
                        pairs
  --prefix [PREFIX]     Define path prefix to support files ("d3.html" and
                        database directory)
  --polarity {positive,negative}, -p {positive,negative}
                        Set flag to force polarity of all features to positive
                        or negative
  --neutral, -n         Set flag if input data contains neutral feature mass
                        instead of mz
  --alternate, -a       Set flag to keep features with multiple predictions
  --impute-charge, --impute
                        Set flag to impute "1" for missing charge information
```


## vkmz_w4m-xcms

### Tool Description
Process XCMS data with various metadata and output options.

### Metadata
- **Docker Image**: quay.io/biocontainers/vkmz:1.4.6--py_0
- **Homepage**: https://github.com/HegemanLab/VKMZ
- **Package**: https://anaconda.org/channels/bioconda/packages/vkmz/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vkmz w4m-xcms [-h] --data-matrix [DATA_MATRIX] --sample-metadata
                     [SAMPLE_METADATA] --variable-metadata [VARIABLE_METADATA]
                     --error [ERROR] --output [OUTPUT] [--json] [--sql]
                     [--metadata] [--database [DATABASE]] [--prefix [PREFIX]]
                     [--polarity {positive,negative}] [--neutral]
                     [--alternate] [--impute-charge]

optional arguments:
  -h, --help            show this help message and exit
  --data-matrix [DATA_MATRIX], -xd [DATA_MATRIX]
                        Path to XCMS data matrix file
  --sample-metadata [SAMPLE_METADATA], -xs [SAMPLE_METADATA]
                        Path to XCMS sample metadata file
  --variable-metadata [VARIABLE_METADATA], -xv [VARIABLE_METADATA]
                        Path to XCMS variable metadata file
  --error [ERROR], -e [ERROR]
                        Mass error of MS data in parts-per-million
  --output [OUTPUT], -o [OUTPUT]
                        Specify output file path
  --json, -j            Set JSON flag to save JSON output
  --sql, -s             Set SQL flag to save SQL output
  --metadata, -m        Set metadata flag to save argument metadata
  --database [DATABASE], -db [DATABASE]
                        Define path to custom database of known formula-mass
                        pairs
  --prefix [PREFIX]     Define path prefix to support files ("d3.html" and
                        database directory)
  --polarity {positive,negative}, -p {positive,negative}
                        Set flag to force polarity of all features to positive
                        or negative
  --neutral, -n         Set flag if input data contains neutral feature mass
                        instead of mz
  --alternate, -a       Set flag to keep features with multiple predictions
  --impute-charge, --impute
                        Set flag to impute "1" for missing charge information
```


## vkmz_formula

### Tool Description
Parses a tabular formula file and outputs results in various formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/vkmz:1.4.6--py_0
- **Homepage**: https://github.com/HegemanLab/VKMZ
- **Package**: https://anaconda.org/channels/bioconda/packages/vkmz/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vkmz formula [-h] --input INPUT --output [OUTPUT] [--json] [--sql]
                    [--metadata] [--database [DATABASE]] [--prefix [PREFIX]]
                    [--polarity {positive,negative}] [--neutral] [--alternate]
                    [--impute-charge]

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        Path to tabular formula file.
  --output [OUTPUT], -o [OUTPUT]
                        Specify output file path
  --json, -j            Set JSON flag to save JSON output
  --sql, -s             Set SQL flag to save SQL output
  --metadata, -m        Set metadata flag to save argument metadata
  --database [DATABASE], -db [DATABASE]
                        Define path to custom database of known formula-mass
                        pairs
  --prefix [PREFIX]     Define path prefix to support files ("d3.html" and
                        database directory)
  --polarity {positive,negative}, -p {positive,negative}
                        Set flag to force polarity of all features to positive
                        or negative
  --neutral, -n         Set flag if input data contains neutral feature mass
                        instead of mz
  --alternate, -a       Set flag to keep features with multiple predictions
  --impute-charge, --impute
                        Set flag to impute "1" for missing charge information
```


## Metadata
- **Skill**: generated
