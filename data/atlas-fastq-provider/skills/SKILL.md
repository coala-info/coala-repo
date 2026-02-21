---
name: atlas-fastq-provider
description: The `atlas-fastq-provider` is a specialized utility designed to simplify the process of fetching raw sequencing data for bioinformatics pipelines.
homepage: https://github.com/ebi-gene-expression-group/atlas-fastq-provider
---

# atlas-fastq-provider

## Overview

The `atlas-fastq-provider` is a specialized utility designed to simplify the process of fetching raw sequencing data for bioinformatics pipelines. Rather than manually managing downloads, this tool provides a unified interface to retrieve files from various sources while handling protocol-specific logic (such as ENA's FTP/HTTP/SSH endpoints or HCA's Azul API). It ensures that files are placed in the correct target locations with consistent naming, and it can perform "dry-run" validations to confirm data availability before a workflow begins execution.

## Core CLI Usage

### Fetching Individual FASTQ Files
The `fetchFastq.sh` script is the primary tool for single-file retrieval.

```bash
# Basic download from a URI
fetchFastq.sh -f ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR188/006/ERR1888646/ERR1888646_1.fastq.gz -t ERR1888646_1.fastq.gz

# Fetch from ENA using an accession and specific method
fetchFastq.sh -f ERR1888646_1.fastq.gz -t target_file.fastq.gz -m http

# Link from a local directory instead of downloading
fetchFastq.sh -f ERR1888646_1.fastq.gz -t local_link.fastq.gz -s /path/to/local/storage
```

### Bulk Library Downloads
To retrieve all FASTQ files associated with a specific ENA library/run accession:

```bash
fetchEnaLibraryFastqs.sh -l ERR1888646 -d /path/to/output_directory
```

### Human Cell Atlas (HCA) Retrieval
The tool supports a pseudo-URI format for HCA bundles:

```bash
fetchFastq.sh -f hca://<bundle_uuid>/<file_name> -t output.fastq.gz
```

## Expert Tips and Best Practices

### 1. Pre-flight Validation
Use the `-v` flag to check if a file exists at the source without actually performing the download. This is highly recommended for pipeline "validation" steps to catch missing data early.
```bash
fetchFastq.sh -v -f <uri> -t <target>
```

### 2. Optimization with "Auto" Method
By default, the tool uses `-m auto`. This triggers a "probe" that tests FTP, SSH, and HTTP endpoints to determine the fastest available method. The results are cached in a probe file (defined by `PROBE_UPDATE_FREQ_MINS` in config) to speed up subsequent requests.

### 3. Internal EBI Usage (SSH)
For users within the EBI network with appropriate privileges, SSH is often the fastest retrieval method. Ensure the `ENA_SSH_USER` environment variable is set:
```bash
export ENA_SSH_USER=your_username
fetchFastq.sh -f ERR1888646_1.fastq.gz -t output.fastq.gz -m ssh
```

### 4. Handling Interleaved Files
If you encounter interleaved FASTQ files, the package includes a `deinterleave_fastq.sh` utility to split them into paired-end files.

### 5. Configuration Overrides
While the tool uses a default `atlas-fastq-provider-config.sh`, you can provide a custom configuration file using the `-c` flag to override variables like `ENA_RETRIES` or `FETCH_FREQ_MILLIS`.

## Reference documentation
- [Main README and Usage Guide](./references/github_com_ebi-gene-expression-group_atlas-fastq-provider_blob_develop_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_atlas-fastq-provider_overview.md)