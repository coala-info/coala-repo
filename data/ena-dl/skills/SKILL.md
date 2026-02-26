---
name: ena-dl
description: ena-dl automates the retrieval of genomic data by querying the ENA Data Warehouse API to identify and download files via Aspera or FTP. Use when user asks to download FASTQ files from ENA, fetch data for specific run, experiment, or study accessions, or organize genomic downloads by sample metadata.
homepage: https://github.com/rpetit3/ena-dl
---


# ena-dl

## Overview
ena-dl is a specialized utility that automates the retrieval of genomic data by querying the ENA Data Warehouse API. Instead of manually searching for FTP links, this tool identifies the correct Aspera or FTP paths for a given accession and manages the download process. It is particularly effective for fetching large batches of data associated with a single study or experiment and offers options to organize or merge files based on sample metadata.

## Installation and Setup
The recommended way to install ena-dl is via Bioconda:
```bash
conda install -c bioconda ena-dl
```

## Core Usage Patterns

### Basic Downloads
To download all FASTQ files associated with an accession, simply provide the ID:
*   **Run Accession**: `ena-dl SRR1178105` (Downloads a single run)
*   **Experiment Accession**: `ena-dl SRX477044` (Downloads all runs for this experiment)
*   **Study Accession**: `ena-dl PRJNA248678` (Downloads every run associated with the study)

### Organizing and Merging Data
When downloading studies or experiments with multiple runs, use grouping flags to organize the output:
*   **Group by Experiment**: `ena-dl PRJNA248678 --group_by_experiment`
*   **Group by Sample**: `ena-dl PRJNA248678 --group_by_sample`
*   **Specify Output Directory**: `ena-dl SRR1178105 --outdir ./raw_data`

### High-Speed Downloads with Aspera
For significantly faster transfer speeds compared to standard FTP, use Aspera Connect:
```bash
ena-dl SRR1178105 --aspera /path/to/ascp
```
*   **Note**: If the private key is not automatically detected, specify it with `--aspera_key`.
*   **Speed Limit**: Control bandwidth usage with `--aspera_speed` (e.g., `--aspera_speed 100M`).

## Expert Tips and Best Practices
*   **Dry Run**: Always use the `--debug` flag first. This will print the files that would be downloaded and their paths without actually starting the transfer, allowing you to verify the accession and grouping logic.
*   **Protocol Fallback**: If you encounter firewall issues with Aspera, use `--ftp_only` to force standard FTP downloads.
*   **Explicit Accession Types**: While the tool usually auto-detects the accession type, you can force it using `--is_study`, `--is_experiment`, or `--is_run` if you encounter ambiguity.
*   **Retry Logic**: For unstable connections, increase the `--max_retry` value (default is 10) to ensure large datasets complete successfully.
*   **Silent Mode**: When running in automated pipelines or scripts, use `--silent` to suppress all output except for critical errors.

## Reference documentation
- [ena-dl GitHub Repository](./references/github_com_rpetit3_ena-dl.md)
- [Bioconda ena-dl Overview](./references/anaconda_org_channels_bioconda_packages_ena-dl_overview.md)