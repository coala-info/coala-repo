# ncbitk CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ncbitk | PASS | Tested --status with a local assembly summary (the tool's own test file): counts match (100 new genomes; 27 for Buchnera_aphidicola). The rsync update mode was not run. |

## ncbitk

### Tool Description
Sync your collection with the latest assembly versions or download the latest assembly summary and taxonomy dump.

### Metadata
- **Docker Image**: quay.io/biocontainers/ncbitk:1.0a17--py_0
- **Homepage**: https://github.com/andrewsanchez/NCBITK
- **Package**: https://anaconda.org/channels/bioconda/packages/ncbitk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ncbitk/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/andrewsanchez/NCBITK
- **Stars**: N/A
### Original Help Text
```text
Usage: ncbitk [OPTIONS] GENBANK [SPECIES]...

Options:
  --update / --no-update          Sync your collection with the latest
                                  assembly versions
  --update-assembly / --local-assembly
                                  Download the latest assembly summary and
                                  taxonomy dumpOr use your local copies.
  --from-file FILENAME
  --status                        Show the current status of your genome
                                  collection
  --help                          Show this message and exit.
```

