---
name: geodl
description: geodl automates the retrieval and renaming of raw sequencing data from GEO or ENA using metadata to provide descriptive filenames. Use when user asks to download FASTQ files from GEO or ENA accessions, fetch sequencing data using specific sample IDs, or rename SRR files using experimental sample names.
homepage: https://github.com/jduc/geoDL
metadata:
  docker_image: "quay.io/biocontainers/geodl:1.0b5.1--py36_0"
---

# geodl

## Overview

`geodl` is a specialized utility for bioinformaticians that automates the retrieval of raw sequencing data. While the Gene Expression Omnibus (GEO) is the primary repository for functional genomics metadata, the actual FASTQ files are often hosted on the SRA or ENA. `geodl` bridges this gap by using GEO or ENA accessions to fetch metadata from the EMBL-EBI/ENA servers, identifying the correct FTP download links, and downloading the files via `wget`. A key feature is its ability to automatically rename downloaded files using experimental sample names (GSM titles) instead of generic Run accessions (SRR numbers).

## Usage Patterns

### Basic Download from GEO
To download all FASTQ files associated with a GEO Series (GSE) accession:
```bash
geoDL geo GSE13373
```

### Download from ENA
If you already have the ENA study accession (e.g., PRJEB, ERP, or SRP numbers), use the `ena` mode:
```bash
geoDL ena PRJEB13373
```

### Selective Sample Downloading
To download only specific samples from a large series, use the `--samples` (or `-s`) flag followed by the GSM accessions:
```bash
geoDL geo GSE13373 --samples GSM00001 GSM00003
```

### Using Local Metadata
If you have already downloaded a metadata file from ENA and want to use it to drive the download and renaming process:
```bash
geoDL meta my_metadata.txt
```

### Customizing File Names
By default, `geodl` uses the "Submitter's sample name" for renaming. To use a different column from the ENA metadata for file naming:
```bash
geoDL meta my_metadata.txt --colname run_alias
```

## Best Practices and Tips

- **Perform a Dry Run**: Before starting a massive download, use the `--dry` flag. This prints the `wget` commands that would be executed without actually downloading the data, allowing you to verify the file names and links.
  ```bash
  geoDL geo GSE13373 --dry
  ```
- **Dependencies**: Ensure `wget` is installed on your system path, as `geodl` relies on it for the actual file transfer.
- **Beta Status**: Be aware that `geodl` is often updated to handle changes in the ENA website structure. If a download fails, verify that the ENA/EMBL-EBI website is accessible.
- **Installation**: The most reliable way to install the tool is via Bioconda:
  ```bash
  conda install -c bioconda geodl
  ```

## Reference documentation
- [geodl - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_geodl_overview.md)
- [jduc/geoDL: Download FASTQ files from GEO with ease](./references/github_com_jduc_geoDL.md)