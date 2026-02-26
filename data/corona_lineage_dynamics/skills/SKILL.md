---
name: corona_lineage_dynamics
description: This tool processes SARS-CoV-2 metadata to calculate lineage frequencies and generate interactive trajectory visualizations. Use when user asks to analyze Pangolin lineage dynamics, visualize genomic surveillance data, or identify predominant lineages based on frequency thresholds.
homepage: https://github.com/hzi-bifo/corona_lineage_dynamics
---


# corona_lineage_dynamics

## Overview
The `corona_lineage_dynamics` tool is designed for genomic surveillance of SARS-CoV-2. It processes GISAID metadata files to calculate the frequency of various Pangolin lineages and generates interactive HTML visualizations of their trajectories. This skill should be used when you need to transform raw metadata into interpretable reports that highlight which lineages are becoming predominant based on a user-defined frequency threshold.

## Command Line Usage

The primary interface for the tool (when installed via Bioconda) is the `corona_lineage_dynamics` command. If using the source code or Singularity container, the entry point is typically the `SDPlots_lineages_local.sh` script.

### Standard Syntax
```bash
corona_lineage_dynamics <MetadataFile> <MonthsFile> <OutputFolder> <Threshold>
```

### Positional Arguments
1.  **MetadataFile**: The TSV metadata file downloaded from GISAID.
2.  **MonthsFile**: A text file listing the months to be analyzed (one per line, e.g., `2023-01`).
3.  **OutputFolder**: The directory where the tool will store generated reports and intermediate data.
4.  **Threshold**: A floating-point value (0.0 to 1.0) representing the frequency threshold for a lineage to be considered predominant. For SARS-CoV-2, a value of `0.1` is standard.

## Best Practices and Tips

### Input Preparation
*   **Months File**: Ensure your months file matches the date format used in the GISAID metadata (typically `YYYY-MM`).
*   **Aliases**: While not always a required positional argument for the main command, having an `aliases.tsv` file in your working directory or `testdata` folder helps the tool expand lineage names correctly.
*   **Directory Management**: Always create your output directory (`mkdir -p outputs`) before running the command. If re-running an analysis, clear the previous contents of the output folder to prevent data conflicts.

### Execution Environment
*   **Internet Connectivity**: The pipeline uses `curl` and `wget` to fetch updated lineage information. While it can run offline, an active connection ensures the lineage definitions are up-to-date.
*   **Resource Monitoring**: Processing large GISAID metadata files (millions of rows) can be memory-intensive. Ensure your environment has sufficient RAM for C++ based regex processing.

### Interpreting Outputs
The tool generates several interactive HTML files in the output directory. Key files include:
*   `[Country]_continuous.interactive.html`: Shows lineage trajectories over time.
*   `[Country]_corrected.interactive.html`: Provides adjusted frequency views.
*   `[Country].interactive.html`: Standard frequency plots.

## Common CLI Patterns

**Running with the Bioconda package:**
```bash
corona_lineage_dynamics data/gisaid_metadata.tsv config/months.txt results/ 0.1
```

**Running via Singularity:**
```bash
singularity exec corona_lineage_dynamics_latest.sif /opt/corona_lineage_dynamics/SDPlots_lineages_local.sh metadata.tsv months.txt output/ 0.1
```

**Testing with simulated data:**
If you are unsure if the installation is correct, use the provided test data:
```bash
corona_lineage_dynamics testdata/metadata.tsv testdata/months.txt outputs 0.1
```

## Reference documentation
- [corona_lineage_dynamics GitHub Repository](./references/github_com_hzi-bifo_corona_lineage_dynamics.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_corona_lineage_dynamics_overview.md)