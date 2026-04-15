---
name: rnanorm
description: rnanorm performs standard RNA-seq normalization techniques including CPM, TPM, FPKM, TMM, and UQ using a pure-Python implementation. Use when user asks to normalize RNA-seq count matrices, adjust for library size or gene length, or account for composition bias using TMM or Upper Quartile methods.
homepage: https://github.com/genialis/RNAnorm
metadata:
  docker_image: "quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1"
---

# rnanorm

## Overview
`rnanorm` is a pure-Python implementation of standard RNA-seq normalization techniques. It eliminates the need for R-based environments when performing routine tasks like library size adjustment or gene length normalization. The tool supports several key methods:
- **Library size adjustment**: CPM (Counts Per Million).
- **Gene length & library size adjustment**: TPM (Transcripts Per Million) and FPKM (Fragments Per Kilobase Million).
- **Composition bias adjustment**: TMM (Trimmed Mean of M-values) and UQ (Upper Quartile).
- **Factor-adjusted counts**: CTF (Counts adjusted with TMM) and CUF (Counts adjusted with UQ).

## Installation
Install the package using pip:
```bash
pip install rnanorm
```

## Command Line Interface (CLI)
The CLI is the fastest way to process expression matrices stored in CSV or TSV files.

### Basic Usage
Normalize a count matrix using CPM:
```bash
rnanorm cpm raw_counts.csv --out normalized_cpm.csv
```

### Handling Gene Lengths (TPM/FPKM)
Methods that account for gene length require either a GTF annotation file or a dedicated gene lengths file.
```bash
# Using a GTF file
rnanorm tpm counts.csv --gtf annotations.gtf > tpm_output.csv

# Using a custom gene lengths file (two columns: gene_id, gene_length)
rnanorm tpm counts.csv --gene-lengths lengths.csv --out tpm_output.csv
```

### Advanced CLI Patterns
- **Piping**: Use standard input and output for integration into shell pipelines.
  ```bash
  cat counts.csv | rnanorm tmm > tmm_output.csv
  ```
- **Overwriting**: By default, the tool will not overwrite existing files. Use the `--force` flag if necessary.
  ```bash
  rnanorm uq counts.csv --force --out existing_file.csv
  ```

## Python API Usage
`rnanorm` is compatible with Scikit-learn, making it easy to integrate into machine learning pipelines.

### Implementation Example
```python
from rnanorm import TPM
import pandas as pd

# Load your data (Genes must be in columns, Samples in rows)
df = pd.read_csv("counts.csv", index_col=0)

# Initialize and transform
# Note: TPM and FPKM require gene length info via GTF or gene_lengths dictionary
tpm_transformer = TPM(gtf_path="path/to/annotations.gtf")
normalized_df = tpm_transformer.fit_transform(df)
```

## Expert Tips and Best Practices
- **Matrix Orientation**: Ensure your input matrix has **genes in columns** and **samples in rows**. This is the inverse of many R-based tools but is the standard for Scikit-learn compatibility.
- **Raw Counts Only**: Always provide raw, non-normalized integer counts as input.
- **Gene Length Calculation**: When providing a custom gene lengths file, ensure lengths are calculated using the "union exon model" for consistency with standard bioinformatics practices.
- **Method Selection**:
    - Use **TPM** for within-sample comparisons (comparing expression of Gene A vs Gene B).
    - Use **TMM** or **UQ** when performing between-sample comparisons to account for composition bias.
    - Use **CTF** or **CUF** if you need normalized counts that maintain the original scale of the data.



## Subcommands

| Command | Description |
|---------|-------------|
| rnanorm cpm | Calculate counts per million (CPM) for RNA-Seq data. |
| rnanorm ctf | Convert count data to TPM format. |
| rnanorm cuf | Normalize RNA-Seq count data using the CUF method. |
| rnanorm fpkm | Calculate FPKM values from gene expression data. |
| rnanorm tmm | Apply TMM normalization to an expression matrix. |
| rnanorm tpm | Compute TPM. |
| rnanorm uq | Performs Upper Quartile Normalization on expression data. |

## Reference documentation
- [RNAnorm GitHub README](./references/github_com_genialis_RNAnorm_blob_main_README.rst.md)