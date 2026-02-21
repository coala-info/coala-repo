---
name: checkqc
description: The `checkqc` tool is a specialized utility for the rapid quality assessment of Illumina sequencing runs.
homepage: https://www.github.com/Molmed/checkQC
---

# checkqc

## Overview
The `checkqc` tool is a specialized utility for the rapid quality assessment of Illumina sequencing runs. It automates the process of checking runfolders against predefined quality thresholds, providing immediate feedback on whether a run should be accepted or flagged for troubleshooting. It is particularly useful in automated pipelines to prevent the processing of low-quality data.

## Core Usage Patterns

### Basic Quality Check
To perform a standard QC check on an Illumina runfolder using default configurations:
```bash
checkqc <RUNFOLDER_PATH>
```
The tool will identify the instrument type (e.g., NovaSeq, MiSeq, HiSeq) and apply the relevant default thresholds.

### JSON Output for Automation
For integration with other scripts or for programmatic parsing of QC results, use the `--json` flag. This sends the structured report to `stdout` while keeping logs on `stderr`:
```bash
checkqc --json <RUNFOLDER_PATH>
```

### Custom Quality Thresholds
If your project requires specific quality standards different from the defaults, provide a custom configuration file:
```bash
checkqc --config_file <PATH_TO_CONFIG> <RUNFOLDER_PATH>
```
*Tip: To get a template for customization, run `checkqc` without a config; the log will display the path to the system's default YAML config file.*

## Expert Tips & Best Practices
- **Exit Status Monitoring**: `checkqc` emits a non-zero exit status if any "Fatal QC errors" are found. Always check `$?` in shell scripts to decide whether to proceed with demultiplexing or secondary analysis.
- **Supported Instruments**: The tool natively supports HiSeqX, HiSeq2500, iSeq, MiSeq, NovaSeq, and NovaSeq X Plus.
- **Handler Awareness**: Pay attention to the "Enabled handlers" section in the output. Common handlers include:
    - `ClusterPFHandler`: Checks if the number of clusters passing filter is sufficient.
    - `Q30Handler`: Ensures the percentage of bases with quality scores above 30 meets the threshold.
    - `ErrorRateHandler`: Monitors the alignment error rate.
    - `ReadsPerSampleHandler`: Validates that individual samples have received enough coverage.
- **Environment**: Ensure Python 3.10+ is active. If the tool is missing, it is most easily installed via `conda install -c bioconda checkqc`.

## Reference documentation
- [checkQC GitHub Repository](./references/github_com_Molmed_checkQC.md)
- [Bioconda checkqc Overview](./references/anaconda_org_channels_bioconda_packages_checkqc_overview.md)