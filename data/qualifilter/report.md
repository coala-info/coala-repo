# qualifilter CWL Generation Report

## qualifilter

### Tool Description
QualiFilter: A tool that generates a QC report summarizing key quality metrics and sample pass/fail status according to user-defined thresholds

### Metadata
- **Docker Image**: quay.io/biocontainers/qualifilter:1.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/buhlentozini/QualiFilter
- **Package**: https://anaconda.org/channels/bioconda/packages/qualifilter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/qualifilter/overview
- **Total Downloads**: 42
- **Last updated**: 2025-11-26
- **GitHub**: https://github.com/buhlentozini/QualiFilter
- **Stars**: N/A
### Original Help Text
```text
usage: qualifilter [-h] --input INPUT [--attributes ATTRIBUTES]
                   [--thresholds THRESHOLDS] [--round ROUND] [--derive_reads]
                   [--outdir OUTDIR] [--list] [--config CONFIG]

QualiFilter: A tool that generates a QC report summarizing key quality metrics
and sample pass/fail status according to user-defined thresholds

options:
  -h, --help            show this help message and exit
  --input, -i INPUT     MultiQC tabular stats file (TSV)
  --attributes, -a ATTRIBUTES
                        Comma-separated list of columns/metrics to extract
  --thresholds, -t THRESHOLDS
                        JSON string with QC thresholds, e.g. {"Total_reads":10
                        00000,"Coverage_gte_10x_pct":90,"Contam_pct":5}
  --round, -r ROUND     Number of decimals for numeric rounding
  --derive_reads        Calculate derived read metrics from Kraken percentages
  --outdir, -o OUTDIR   Output directory
  --list                List all available columns in the input file and exit
  --config, -c CONFIG   Path to YAML or JSON configuration file (optional).
                        Overrides default allowed columns and rename map.
```

