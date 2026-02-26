---
name: arborator
description: "Arborator analyzes genomic profiles and metadata for pathogen surveillance and outbreak detection. Use when user asks to identify and cluster pathogen samples, detect outliers, generate dendrograms and clusters, or produce summarized reports of genetic diversity."
homepage: https://pypi.org/project/arborator/
---


# arborator

yaml
name: arborator
description: |
  Tool for operationalized pathogen surveillance and outbreak detection.
  Use when Claude needs to analyze genomic profiles and contextual metadata to:
  - Identify and cluster related pathogen samples based on genetic similarity.
  - Detect outliers within sample groups.
  - Generate dendrograms and flat clusters based on specified genetic distance thresholds.
  - Produce summarized reports of genetic diversity and sample metadata.
  - Facilitate outbreak investigation and surveillance operations.
```
## Overview
Arborator is a command-line tool designed to streamline pathogen surveillance and outbreak detection. It analyzes genomic data (alleles, SNPs, mutations) alongside contextual sample metadata to identify relationships between samples. Arborator can split large datasets, calculate genetic diversity statistics, generate dendrograms and clusters based on thresholds, detect outliers, and provide summarized reports. This makes it invaluable for public health investigations and ongoing surveillance efforts.

## Usage

Arborator is primarily used via its command-line interface. The core functionality involves providing profile (genomic) and metadata files, along with configuration options, to generate analysis outputs.

### Core Command Structure

The general structure of an Arborator command is:

```bash
arborator --profile <profile_file.tsv> --metadata <metadata_file.tsv> --config <config_file.json> --outdir <output_directory> [options]
```

### Key Arguments

*   `--profile` or `-p`: Path to the tab-separated values (`.tsv`) file containing sample genetic profiles (alleles, SNPs, mutations).
*   `--metadata` or `-r`: Path to the `.tsv` file containing contextual sample metadata.
*   `--config` or `-c`: Path to a JSON configuration file for advanced settings and organism-specific operations. This file can override command-line arguments.
*   `--outdir` or `-o`: The directory where all output files will be saved.
*   `--partition_col` or `-a`: The name of the column in the metadata file to use for partitioning data into separate analysis groups (e.g., 'outbreak', 'region').
*   `--id_col` or `-i`: The name of the column in the metadata file that uniquely identifies each sample.
*   `--thresholds` or `-t`: A comma-separated list of genetic distance thresholds to use for clustering. Higher values mean broader clusters. Example: `10,9,8,7,6,5,4,3,2,1`.
*   `--outlier_thresh`: An integer value to designate samples as outliers based on genetic distance.
*   `--min_members` or `-m`: The minimum number of samples required to form a cluster.
*   `--method` or `-e`: The clustering method to use (e.g., 'average').
*   `--n_threads`: The number of threads to use for multithreading.
*   `--force` or `-f`: Overwrite existing output files if they exist.

### Configuration File (`config.json`)

A JSON configuration file allows for more detailed control over Arborator's behavior, including:

*   **Summarizing columns**: Define how metadata columns should be summarized in the output reports (`grouped_metadata_columns`). This includes specifying `data_type` (e.g., 'categorical', 'desc_stats', 'min_max') and custom `label`s for headers.
*   **Line list columns**: Configure which metadata columns are displayed in the detailed output for individual samples (`linelist_columns`).

**Example `config.json` snippet:**

```json
{
  "outlier_thresh": "25",
  "method": "average",
  "thresholds": "500,100,75,50,25,15,10,5,2,1,0",
  "min_members": 2,
  "partition_col": "outbreak",
  "id_col": "sample_id",
  "grouped_metadata_columns": {
    "geo_loc": {
      "data_type": "categorical",
      "label": "Country of collection",
      "display": "True"
    },
    "age": {
      "data_type": "desc_stats",
      "label": "Patient Age (years)",
      "display": "True"
    }
  }
}
```

### Quick Start Example

To run Arborator with the test data included in the repository:

```bash
arborator --profile tests/data/profile.tsv --metadata tests/data/metadata.tsv --config tests/data/config.json --outdir results --id_col id --partition_col outbreak --thresholds 10,9,8,7,6,5,4,3,2,1
```

This command will process the specified profile and metadata files, use the provided configuration, save results to the `results` directory, and partition the data by the 'outbreak' column, using 'id' as the sample identifier. The clustering will be performed using the specified thresholds.

## Expert Tips

*   **Configuration is Key**: For reproducible and complex analyses, leverage the JSON configuration file (`--config`). It allows for precise control over metadata summarization and output formatting, which is crucial for standardized reporting.
*   **Partitioning for Clarity**: Use the `--partition_col` argument effectively to break down large datasets into manageable, biologically relevant groups. This simplifies interpretation and analysis of specific outbreaks or sample sets.
*   **Metadata Quality**: Ensure your metadata file (`--metadata`) is clean and well-structured. The `--id_col` must accurately link samples to their genomic profiles, and columns used for partitioning or summarization should be consistently formatted.
*   **Threshold Tuning**: Experiment with different `--thresholds` to find the optimal genetic distance values for defining clusters relevant to your specific pathogen and outbreak investigation. The provided example thresholds are a good starting point.
*   **Output Directory**: Always specify a dedicated `--outdir` to keep your analysis results organized and separate from input files.
*   **Overwriting**: Use the `--force` flag cautiously when rerunning analyses to ensure you are not unintentionally overwriting important results.

## Reference documentation
- [Arborator Usage and Configuration](./github_com_phac-nml_arborator.md)