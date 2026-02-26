# sage-proteomics CWL Generation Report

## sage-proteomics_sage

### Tool Description
Sage - Proteomics searching so fast it feels like magic!

### Metadata
- **Docker Image**: quay.io/biocontainers/sage-proteomics:0.14.7--hc1c3326_2
- **Homepage**: https://github.com/lazear/sage
- **Package**: https://anaconda.org/channels/bioconda/packages/sage-proteomics/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sage-proteomics/overview
- **Total Downloads**: 37.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lazear/sage
- **Stars**: N/A
### Original Help Text
```text
Usage: sage [OPTIONS] <parameters> [mzml_paths]...

🔮 Sage 🧙 - Proteomics searching so fast it feels like magic!

Written by Michael Lazear <michaellazear92@gmail.com>
Version 0.14.6

Arguments:
  <parameters>     Path to configuration parameters (JSON file)
  [mzml_paths]...  Paths to mzML files to process. Overrides mzML files listed in the configuration file.

Options:
  -f, --fasta <fasta>
          Path to FASTA database. Overrides the FASTA file specified in the configuration file.
  -o, --output_directory <output_directory>
          Path where search and quant results will be written. Overrides the directory specified in the configuration file.
      --batch-size <batch-size>
          Number of files to load and search in parallel (default = # of CPUs/2)
      --parquet
          Write search output in parquet format instead of tsv
      --annotate-matches
          Write matched fragments output file.
      --write-pin
          Write percolator-compatible `.pin` output files
      --disable-telemetry-i-dont-want-to-improve-sage
          Disable sending telemetry data
  -h, --help
          Print help
  -V, --version
          Print version
```

