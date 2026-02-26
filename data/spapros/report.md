# spapros CWL Generation Report

## spapros_evaluation

### Tool Description
Create a selection of probesets for an h5ad file.

### Metadata
- **Docker Image**: quay.io/biocontainers/spapros:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/theislab/spapros
- **Package**: https://anaconda.org/channels/bioconda/packages/spapros/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/spapros/overview
- **Total Downloads**: 593
- **Last updated**: 2025-11-24
- **GitHub**: https://github.com/theislab/spapros
- **Stars**: N/A
### Original Help Text
```text
███████ ██████   █████  ██████  ██████   ██████  ███████ 
██      ██   ██ ██   ██ ██   ██ ██   ██ ██    ██ ██      
███████ ██████  ███████ ██████  ██████  ██    ██ ███████ 
     ██ ██      ██   ██ ██      ██   ██ ██    ██      ██ 
███████ ██      ██   ██ ██      ██   ██  ██████  ███████ 
                                                         

Run spapros --help for an overview of all commands

Usage: spapros evaluation [OPTIONS] DATA PROBESET MARKER_FILE
                          [PROBESET_IDS]...

  Create a selection of probesets for an h5ad file.

  Args:     data: Path to the h5ad dataset file     probeset: Path to the
  probeset file     marker_file: Path to the marker file     probeset_ids:
  Several probeset ids     parameters: Path to a yaml file containing
  parameters     output: Output path

Options:
  --parameters PATH
  -o, --output TEXT
  --help             Show this message and exit.
```


## spapros_selection

### Tool Description
Create a selection of probesets for an h5ad file.

### Metadata
- **Docker Image**: quay.io/biocontainers/spapros:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/theislab/spapros
- **Package**: https://anaconda.org/channels/bioconda/packages/spapros/overview
- **Validation**: PASS

### Original Help Text
```text
███████ ██████   █████  ██████  ██████   ██████  ███████ 
██      ██   ██ ██   ██ ██   ██ ██   ██ ██    ██ ██      
███████ ██████  ███████ ██████  ██████  ██    ██ ███████ 
     ██ ██      ██   ██ ██      ██   ██ ██    ██      ██ 
███████ ██      ██   ██ ██      ██   ██  ██████  ███████ 
                                                         

Run spapros --help for an overview of all commands

Usage: spapros selection [OPTIONS] DATA

  Create a selection of probesets for an h5ad file.

  Args:     data: Path to the h5ad file     output: Output path

Options:
  -o, --output TEXT
  --help             Show this message and exit.
```

