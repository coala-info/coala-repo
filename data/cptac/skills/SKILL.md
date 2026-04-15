---
name: cptac
description: The cptac tool provides a streamlined interface for downloading, managing, and analyzing multi-omics and clinical data from the Clinical Proteomic Tumor Analysis Consortium. Use when user asks to list available cancer datasets, download specific CPTAC data, retrieve proteomics or clinical DataFrames, and perform multi-omics integration or mutation effect analysis.
homepage: http://github.com/PayneLab/cptac
metadata:
  docker_image: "quay.io/biocontainers/cptac:1.5.13--pyhdfd78af_0"
---

# cptac

## Overview
The `cptac` skill provides a streamlined interface for interacting with the Clinical Proteomic Tumor Analysis Consortium (CPTAC) datasets. It automates data downloading, storage, and versioning, delivering multi-omics data directly as pandas DataFrames. This tool is designed for bioinformaticians and researchers who need to perform multi-omics integration, clinical correlation studies, or mutation effect analysis while maintaining data consistency across different cancer types.

## Installation and Setup
Install the package via pip or conda:
```bash
pip install cptac
# OR
conda install bioconda::cptac
```

## Core Workflow Patterns

### 1. Data Discovery and Acquisition
Before loading data, identify available datasets and ensure they are downloaded to your local machine.
```python
import cptac

# List all available cancer datasets
cptac.list_datasets()

# Download a specific dataset (e.g., Endometrial/UCEC)
cptac.download(dataset="ucec")
```

### 2. Loading Cancer Datasets
Datasets are loaded using specific class constructors. Note that the first time a class is instantiated, it may trigger a download if the data is not present.
```python
# Load specific cancer data
en = cptac.Ucec()  # Endometrial
br = cptac.Brca()  # Breast
hn = cptac.Hnscc() # Head and Neck
```

### 3. Accessing Omics and Clinical Data
Each dataset object provides methods to retrieve specific data types as pandas DataFrames.
```python
# Retrieve primary data types
proteomics = en.get_proteomics()
transcriptomics = en.get_transcriptomics()
clinical = en.get_clinical()
mutations = en.get_mutations()
phosphoproteomics = en.get_phosphoproteomics()
```

### 4. Multi-Omics Integration (Joining)
The package includes built-in methods to handle the complexities of joining different data types, such as mapping mutation status to protein abundance.
```python
# Join mutation status with proteomics for a specific gene
joined_data = en.join_omics_to_mutations(
    omics_df_name="proteomics", 
    mutations_genes="TP53"
)

# Join two different omics types
combined = en.join_omics_to_omics(
    df1_name="proteomics", 
    df2_name="transcriptomics", 
    genes1="EGFR", 
    genes2="EGFR"
)
```

## Expert Tips and Best Practices
- **Handle Multi-Indexes**: Many `cptac` DataFrames use multi-indexed columns (e.g., Gene and Database ID). Use `df.columns.get_level_values()` to navigate or flatten them if your downstream analysis tool requires single-level headers.
- **Check Data Versions**: Use `cptac.version()` to check the package version and ensure your local data is up to date, especially when reproducing results from CPTAC publications.
- **Memory Management**: CPTAC datasets can be large. If working with multiple cancer types, delete objects and call `gc.collect()` or restart your kernel to free up RAM.
- **Zenodo API Awareness**: If downloads fail, check the official repository for status updates, as the package relies on Zenodo for data hosting and may occasionally experience API rate limits or connectivity issues.

## Reference documentation
- [Python packaging for CPTAC data](./references/github_com_PayneLab_cptac.md)
- [cptac - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_cptac_overview.md)