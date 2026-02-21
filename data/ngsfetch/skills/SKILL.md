---
name: ngsfetch
description: ngsfetch is a command-line utility designed to streamline the acquisition of genomic data from public archives.
homepage: https://github.com/NaotoKubota/ngsfetch
---

# ngsfetch

## Overview
ngsfetch is a command-line utility designed to streamline the acquisition of genomic data from public archives. By integrating the metadata resolution of `ffq` with the high-performance parallel downloading capabilities of `aria2c`, it provides a robust workflow for bioinformaticians. The tool automates the discovery of download URLs, performs multi-connection transfers, and ensures data integrity through mandatory MD5 checksum verification.

## Usage Patterns

### Basic Data Retrieval
To fetch a dataset, specify the accession ID and the target output directory. The tool will automatically resolve the metadata and begin the download.
`ngsfetch -i <ACCESSION_ID> -o <OUTPUT_DIRECTORY>`

### Maximizing Download Throughput
For large datasets, use the `-p` flag to specify the number of parallel processes. The tool supports a maximum of 16 concurrent processes to optimize bandwidth usage:
`ngsfetch -i SRP175008 -o ./downloads/SRP175008 -p 16`

### Improving Reliability on Unstable Networks
If you encounter network timeouts or metadata retrieval errors, increase the number of retry attempts:
`ngsfetch -i GSE52856 -o ./data --attempts 5`

## Expert Tips and Best Practices
- **Supported Accessions**: Ensure you are using valid study-level accessions from GEO (GSE), SRA (SRP), or EMBL-EBI (ERP).
- **Environment Requirements**: This tool requires a Linux environment for `md5sum` verification. Ensure `aria2` and `ffq` are installed in your path.
- **Monitoring Progress**: Use the `-v` (verbose) flag to see detailed logs of the metadata fetching process and the status of individual file downloads.
- **Integrity Verification**: ngsfetch automatically verifies files after download. If a file fails the MD5 check, the tool will attempt to re-download it based on your `--attempts` setting.

## Reference documentation
- [ngsfetch GitHub Repository](./references/github_com_NaotoKubota_ngsfetch.md)
- [ngsfetch Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ngsfetch_overview.md)