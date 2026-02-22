# alphafill CWL Generation Report

## alphafill_server

### Tool Description
AlphaFill is a tool to process AlphaFold structures by filling in missing compounds. It can create indices from PDB files or process AlphaFill structures.

### Metadata
- **Docker Image**: quay.io/biocontainers/alphafill:2.2.0--haf24da9_0
- **Homepage**: https://alphafill.eu
- **Package**: https://anaconda.org/channels/bioconda/packages/alphafill/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/alphafill/overview
- **Total Downloads**: 353
- **Last updated**: 2025-07-27
- **GitHub**: https://github.com/PDB-REDO/alphafill
- **Stars**: 110
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Unknown command "server"

usage: alphafill command [options]

where command is one of

    create-index   Create a FastA file based on data in the PDB files
                   (A FastA file is required to process files)
    process        Process an AlphaFill structure

The following options are always recognized:

  --version                       Show version number
  -v [ --verbose ]                Show verbose output
  -h [ --help ]                   Display help message
  --quiet                         Do not produce warnings or status messages
  --config arg (=alphafill.conf)  Configuration file to use
```

