---
name: qualifilter
description: QualiFilter is a command-line utility that streamlines the post-processing of MultiQC data.
homepage: https://github.com/buhlentozini/QualiFilter
---

# qualifilter

## Overview

QualiFilter is a command-line utility that streamlines the post-processing of MultiQC data. It transforms raw tabular summaries into clean, actionable QC matrices. Use this tool to standardize QC reporting across sequencing samples, especially when you need to enforce specific quality gates—such as minimum coverage or maximum contamination—and generate simplified TSV/CSV outputs for downstream analysis.

## Command-Line Usage

### Basic Execution
To generate a QC report with specific pass/fail thresholds:
```bash
qualifilter --input multiqc_data.tabular --thresholds '{"Total_reads":1000000, "Coverage_gte_10x_pct":90}' --outdir qc_results
```

### Metric Selection and Inspection
If you only need a subset of available metrics, use the `--attributes` flag. To see what metrics are available in your specific input file first, use the `--list` flag.
```bash
# List available columns
qualifilter --input multiqc_data.tabular --list

# Filter for specific metrics
qualifilter --input multiqc_data.tabular --attributes "Sample,Total_reads,Coverage_gte_10x_pct,Contam_pct"
```

### Advanced Metrics and Formatting
*   **Derived Reads**: Use `--derive_reads` to calculate specific counts like `MTB_reads` and `Unclassified_reads` based on percentage hits.
*   **Rounding**: Control numerical precision (default is 2) using the `--round` flag.
```bash
qualifilter -i multiqc_data.tabular --derive_reads --round 4 -o high_precision_results
```

## Best Practices

*   **Threshold Syntax**: Ensure the `--thresholds` argument is a valid JSON string wrapped in single quotes to prevent shell interpretation of curly braces.
*   **Scaling Awareness**: QualiFilter automatically handles MultiQC's "millions" scaling for `Total_reads` and `Mapped_reads`. When setting thresholds, use the raw integer value (e.g., `1000000` for 1 million).
*   **Configuration Overrides**: For complex projects with custom column naming or specific "allowed" column lists, use a configuration file with `--config`. This is more maintainable than long CLI strings for repetitive workflows.
*   **Log Monitoring**: Always check `qc_tool.log` in the output directory if samples are failing unexpectedly; the tool logs warnings for missing columns or data type mismatches.

## Reference documentation
- [QualiFilter GitHub README](./references/github_com_buhlentozini_QualiFilter.md)
- [QualiFilter Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_qualifilter_overview.md)