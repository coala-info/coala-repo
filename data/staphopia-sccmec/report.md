# staphopia-sccmec CWL Generation Report

## staphopia-sccmec

### Tool Description
Determine SCCmec Type/SubType

### Metadata
- **Docker Image**: quay.io/biocontainers/staphopia-sccmec:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/staphopia/staphopia-sccmec
- **Package**: https://anaconda.org/channels/bioconda/packages/staphopia-sccmec/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/staphopia-sccmec/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/staphopia/staphopia-sccmec
- **Stars**: N/A
### Original Help Text
```text
usage: staphopia-sccmec [-h] [--assembly ASSEMBLY|ASSEMBLY_DIR|STAPHOPIA_DIR]
                        [--staphopia STAPHOPIA_DIR] [--sccmec SCCMEC_DATA]
                        [--ext STR] [--hamming] [--json] [--debug] [--depends]
                        [--test] [--citation] [--version]

Determine SCCmec Type/SubType

optional arguments:
  -h, --help            show this help message and exit

Options:

  --assembly ASSEMBLY|ASSEMBLY_DIR|STAPHOPIA_DIR
                        Input assembly (FASTA format), directory of assemblies
                        to predict SCCmec. (Cannot be used with --staphopia)
  --staphopia STAPHOPIA_DIR
                        Input directory of samples processed by Staphopia.
                        (Cannot be used with --assembly)
  --sccmec SCCMEC_DATA  Directory where SCCmec reference data is stored
                        (Default: /usr/local/share/staphopia-sccmec/data).
  --ext STR             Extension used by assemblies. (Default: fna)
  --hamming             Report the hamming distance of each type.
  --json                Report the output as JSON (Default: tab-delimited)
  --debug               Print debug related text.
  --depends             Verify dependencies are installed/found.
  --test                Run with example test data.
  --citation            Print citation information for using Staphopia SCCmec
  --version             show program's version number and exit
```

