# checkqc CWL Generation Report

## checkqc

### Tool Description
checkQC is a command line utility designed to quickly gather and assess quality control metrics from an Illumina sequencing run. It is highly customizable and which quality controls modules should be run for a particular run type should be specified in the provided configuration file.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkqc:4.0.7--pyhdfd78af_0
- **Homepage**: https://www.github.com/Molmed/checkQC
- **Package**: https://anaconda.org/channels/bioconda/packages/checkqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/checkqc/overview
- **Total Downloads**: 18.9K
- **Last updated**: 2025-04-28
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: checkqc [OPTIONS] RUNFOLDER

  checkQC is a command line utility designed to quickly gather and assess
  quality control metrics from an Illumina sequencing run. It is highly
  customizable and which quality controls modules should be run for a
  particular run type should be specified in the provided configuration file.

Options:
  --config PATH              Path to the checkQC configuration file
  --json                     Print the results of the run as json to stdout
  --downgrade-errors TEXT    Downgrade errors to warnings for a specific
                             handler, can be used multiple times
  --use-closest-read-length  Use the closest read length if the read length
                             used isn't specified in the config
  --version                  Show the version and exit.
  --help                     Show this message and exit.
```

