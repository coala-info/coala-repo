# digestiflow-cli CWL Generation Report

## digestiflow-cli_ingest

### Tool Description
Analyze an Illumina flow cell directory

### Metadata
- **Docker Image**: quay.io/biocontainers/digestiflow-cli:0.5.8--hc234bb7_7
- **Homepage**: https://github.com/bihealth/digestiflow-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/digestiflow-cli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/digestiflow-cli/overview
- **Total Downloads**: 65.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/digestiflow-cli
- **Stars**: N/A
### Original Help Text
```text
digestiflow-cli-ingest 0.5.7
Analyze an Illumina flow cell directory

USAGE:
    digestiflow-cli ingest [FLAGS] [OPTIONS] <FLOWCELL_DIR>...

FLAGS:
        --analyze-adapters          Read adapters from binary base call files
    -n, --dry-run                   Do not perform any modifying operations
        --force-analyze-adapters    Force analysis of adapters even if adapter histogram information is present for all
                                    index reads.
    -h, --help                      Prints help information
        --log-token                 Print authentation token to log file (useful for debugging, possible leaking
                                    security issue)
        --no-register               Whether or not to register flow cell via the API.
        --no-update                 Whether or not to update the flow cell via the API
    -q, --quiet                     Decrease verbosity
        --update-if-state-final     Update flow cell information sequencing is in a final state (e.g., completed or
                                    failed).  Updating index histograms is separate from this.
    -V, --version                   Prints version information
    -v, --verbose                   Increase verbosity

OPTIONS:
        --min-index-fraction <FRAC>        Minimal fraction of reads that must show index for index histogram to be
                                           computed
        --project-uuid <PROJECT_UUID>      The UUID of the project to write to.
        --sample-reads-per-tile <COUNT>    Number of reads to sample per tile
    -t, --threads <COUNT>                  Number of additional threads to use for (de)compression in I/O. [default: 0]

ARGS:
    <FLOWCELL_DIR>...    Path flow cell directory.
```

