---
name: geofetch
description: geofetch is a utility that downloads and standardizes public genomic metadata and raw sequencing files from GEO and SRA into Portable Encapsulated Project format. Use when user asks to fetch metadata, download raw sequencing data from GEO or SRA, PEP-ify public datasets, or standardize repository metadata for downstream analysis.
homepage: https://github.com/pepkit/geofetch/
---


# geofetch

## Overview
`geofetch` is a specialized utility that simplifies the process of acquiring public genomic data. Instead of manually navigating NCBI interfaces, you can use this tool to fetch metadata and raw sequencing files directly via the command line. Its primary value lies in its ability to "PEP-ify" public data—converting messy repository metadata into a clean, standardized format that integrates seamlessly with downstream analysis tools. It supports both GEO (GSE, GSM) and SRA accessions, making it a versatile starting point for secondary data analysis.

## Core CLI Usage and Patterns

### Basic Data Retrieval
To fetch metadata and create a PEP for a specific GEO series:
`geofetch -i GSEXXXXX`

To fetch data for a specific SRA accession:
`geofetch -i SRPXXXXX`

### Metadata Standardization
By default, `geofetch` produces a PEP configuration file and a sample table. This is useful for:
- Combining samples from multiple different projects into a single metadata table.
- Standardizing column names across different GEO submissions.
- Preparing data for tools that consume PEPs (like Looper or Peppy).

### Filtering and Optimization
Before downloading large datasets, use filters to manage disk space and processing time:
- **Filter by size**: Use flags to skip files that are too large for your current infrastructure.
- **Filter by type**: Specify whether you want to process specific file formats (e.g., only SRA files or only supplementary files from GEO).

### Converting to Analysis-Ready Formats
Once metadata is fetched, use the companion command `sraconvert` to transform the downloaded SRA files into usable formats:
- **FASTQ**: `sraconvert --fastq`
- **Unmapped BAM**: `sraconvert --bam`

### Python API Integration
For complex workflows, `geofetch` can be imported as a Python module. This allows for dynamic accession processing within a larger script:
```python
import geofetch
geofetcher = geofetch.Geofetcher()
# Programmatic fetching logic here
```

## Expert Tips
- **Search First**: `geofetch` can be used to search GEO for relevant data before committing to a full download.
- **PEPhub Integration**: Many GEO projects are already pre-processed into PEP format and available on PEPhub. Check the `geo` namespace on PEPhub before running a local fetch to save time and bandwidth.
- **Fast Execution**: The tool is optimized for speed; however, when dealing with hundreds of samples, ensure your network connection is stable as it makes multiple requests to NCBI servers.

## Reference documentation
- [geofetch GitHub Repository](./references/github_com_pepkit_geofetch.md)
- [Bioconda geofetch Overview](./references/anaconda_org_channels_bioconda_packages_geofetch_overview.md)