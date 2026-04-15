---
name: ffq
description: The ffq tool retrieves sequencing metadata and file download links from biological accessions or DOIs. Use when user asks to retrieve sequencing metadata, find file download links for biological accessions, or discover data associated with a DOI.
homepage: https://github.com/pachterlab/ffq
metadata:
  docker_image: "quay.io/biocontainers/ffq:0.3.1--pyhdfd78af_0"
---

# ffq

## Overview
The `ffq` tool is a specialized CLI utility designed to simplify the discovery of sequencing data and its associated metadata. Instead of manually navigating web portals, `ffq` allows you to input a biological accession or a DOI and receive structured JSON output containing metadata for that record and all its downstream children (e.g., fetching all Runs for a Study). It is particularly powerful for generating lists of download URLs for use with tools like `wget`, `curl`, or cloud-specific transfer utilities.

## Core CLI Usage

### Metadata Retrieval
The default behavior returns comprehensive metadata in JSON format.
- **Single Accession**: `ffq [accession]`
- **Multiple Accessions**: `ffq [acc1] [acc2] [acc3]`
- **Supported IDs**: SRA (SRR/SRX/SRS/SRP), ENA (ERR/ERX/ERS/ERP), DDBJ (DRR/DRS/DRX/DRP), GEO (GSE/GSM), ENCODE (ENCSR/ENCSB/ENCSD), Bioproject (CXR), Biosample (SAMN), and DOIs.

### Fetching Download Links
To skip the full metadata and only retrieve file URLs, use the host-specific flags:
- **FTP Links**: `ffq --ftp [accession]` (Best for general use/EBI)
- **AWS S3 Links**: `ffq --aws [accession]` (Best for EC2-based processing)
- **GCP Links**: `ffq --gcp [accession]` (Best for Google Cloud processing)
- **NCBI Links**: `ffq --ncbi [accession]` (Note: NCBI is deprecating some .SRA file links)

### Controlling Search Depth
By default, `ffq` crawls down to the Run (SRR) level. Use `-l` to limit how deep the recursion goes:
- **Level 1**: `ffq -l 1 [accession]` (Returns only the metadata for the specific ID provided)
- **Level 2/3**: Useful for GSE/SRP IDs to stop at the Sample or Experiment level.

### Output Management
- **Save to File**: `ffq -o metadata.json [accession]`
- **Split Batch Output**: `ffq -o [output_directory] --split [accession1] [accession2]`
  - This creates individual `[accession].json` files in the target directory, which is recommended for large-scale data mining to prevent massive single files.

## Expert Tips and Best Practices
- **Paper-to-Data Workflow**: You can provide a DOI directly to `ffq`. It will attempt to find all SRA/GEO studies associated with that publication and return their metadata.
- **Piping to Downloaders**: Combine `ffq` with `jq` to create download scripts:
  `ffq --ftp SRR10668798 | jq -r '.[].url' > links.txt && wget -i links.txt`
- **Handling Large Studies**: When querying large Study accessions (SRP/GSE), always use the `--split` flag and an output directory to manage the volume of metadata effectively.
- **NCBI Warning**: If `--ncbi` returns an empty list, the data may have been moved or the link type is no longer supported; fallback to `--ftp` or `--aws`.

## Reference documentation
- [github_com_pachterlab_ffq.md](./references/github_com_pachterlab_ffq.md)
- [anaconda_org_channels_bioconda_packages_ffq_overview.md](./references/anaconda_org_channels_bioconda_packages_ffq_overview.md)