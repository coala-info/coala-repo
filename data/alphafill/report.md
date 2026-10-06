# alphafill CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| alphafill_create-index | PASS | Upstream mini PDB-REDO test set (1cbs, 2cbs, 3cbs) gives 3 entity sequences; CWL fixed: --pdb-fasta is an output name, config made required. |
| alphafill_process | PASS | Upstream test model AF-P29373: first hit 1CBS chain A with retinoic acid (REA) transplanted, as the upstream test expects; CWL fixed: output name and outputs added, config made required. |
| alphafill_rebuild-db | Failed | not a usable tool: alphafill 2.2.0 has no rebuild-db command (only create-index and process); the file wraps bare alphafill with a command string and no data inputs or outputs. |
| alphafill_server | Failed | not a usable tool: alphafill 2.2.0 in this image has no server command (only create-index and process); the file wraps bare alphafill with a command string and no data inputs or outputs. |

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


## Metadata
- **Skill**: generated
