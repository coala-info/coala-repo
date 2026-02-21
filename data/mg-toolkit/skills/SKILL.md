---
name: mg-toolkit
description: The `mg-toolkit` is a specialized command-line interface and Python library for interacting with the MGnify platform.
homepage: https://github.com/EBI-metagenomics/emg-toolkit
---

# mg-toolkit

## Overview
The `mg-toolkit` is a specialized command-line interface and Python library for interacting with the MGnify platform. It streamlines the process of fetching large-scale metagenomic datasets, allowing users to download original sample metadata, search non-redundant protein databases, and retrieve specific analysis result groups (like functional or taxonomic analyses) across entire studies.

## Core CLI Commands

### 1. Metadata Retrieval
To download the original metadata for a specific study or sequence accession into a CSV file:
```bash
mg-toolkit original_metadata -a <ACCESSION>
```
*Example:* `mg-toolkit original_metadata -a ERP001736`

### 2. Bulk Downloading Results
The `bulk_download` command is the most powerful feature for retrieving analysis files for an entire study.

**Basic bulk download:**
```bash
mg-toolkit bulk_download -a <ACCESSION> -o <OUTPUT_PATH>
```

**Filtering by Pipeline Version:**
MGnify studies are often analyzed with multiple pipeline versions. Use the `-p` flag to specify a version (e.g., 1.0, 4.1, 5.0).
```bash
mg-toolkit bulk_download -a ERP009703 -p 4.0
```

**Filtering by Result Group:**
Use the `-g` flag to download only specific types of data. Note that some groups are version-dependent:
- `statistics`: All versions.
- `functional_analysis`: All versions.
- `taxonomic_analysis_ssu_rrna`: Pipeline >= 4.0.
- `pathways_and_systems`: Pipeline >= 5.0.

*Example (Functional analysis only):*
```bash
mg-toolkit bulk_download -a ERP009703 -g functional_analysis
```

### 3. Sequence Searching
Search MGnify's non-redundant protein database using HMMER:
```bash
mg-toolkit sequence_search -seq <INPUT_FASTA> -out <OUTPUT_CSV> -db <DATABASE>
```
**Available Databases:**
- `full`: Full length sequences (default).
- `all`: All sequences.
- `partial`: Partial sequences.

## Best Practices and Tips
- **Debug Mode:** Use the `-d` flag before the positional command to print debugging information if a download or search fails.
- **Metadata Persistence:** The bulk downloader automatically stores a `.tsv` file containing all metadata for every file it downloads, ensuring provenance is maintained.
- **Accession Formats:** Ensure accessions are publicly available in MGnify (e.g., ERP001736, SRP000319).
- **Python Integration:** While primarily a CLI tool, you can use the underlying modules for custom scripts, though the API is subject to change.
  ```python
  from mg_toolkit.metadata import OriginalMetadata
  meta = OriginalMetadata('ERP001736')
  meta.fetch_metadata()
  ```

## Reference documentation
- [MGnify API toolkit](./references/github_com_EBI-Metagenomics_emg-toolkit.md)
- [mg-toolkit Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mg-toolkit_overview.md)