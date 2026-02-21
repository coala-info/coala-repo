---
name: rnanorm
description: The `rnanorm` tool provides a robust, Python-native implementation of common RNA-seq normalization techniques.
homepage: https://github.com/genialis/RNAnorm
---

# rnanorm

## Overview
The `rnanorm` tool provides a robust, Python-native implementation of common RNA-seq normalization techniques. It is designed to handle the conversion of raw sequencing counts into units that account for sequencing depth, gene length, or composition biases. Unlike many bioinformatics tools that require R environments (e.g., edgeR), `rnanorm` offers a standalone CLI and a scikit-learn compatible API, making it ideal for Python-based data science workflows.

## Installation
Install via pip or conda:
```bash
pip install rnanorm
# OR
conda install bioconda::rnanorm
```

## Command Line Interface (CLI)
The CLI follows a standard pattern: `rnanorm <method> <input_file> [options]`.

### Input Requirements
- **Format**: Comma-separated (CSV).
- **Orientation**: Genes must be in **columns** and samples in **rows**.
- **Values**: Raw integer counts.

### Common CLI Patterns
- **CPM (Counts Per Million)**:
  `rnanorm cpm counts.csv --out counts_cpm.csv`
- **TPM (Transcripts Per Million)**:
  Requires gene lengths via GTF or a specific lengths file.
  `rnanorm tpm counts.csv --gtf annotations.gtf --out counts_tpm.csv`
  `rnanorm tpm counts.csv --gene-lengths lengths.csv > counts_tpm.csv`
- **TMM (Trimmed Mean of M-values)**:
  `rnanorm tmm counts.csv --out counts_tmm.csv`

### CLI Tips
- **Piping**: Use standard input/output for streaming: `cat counts.csv | rnanorm cpm > output.csv`.
- **Overwriting**: The tool fails if the output file exists. Use `--force` to overwrite.
- **Gene Lengths File**: If not using a GTF, provide a two-column CSV: `gene_id,gene_length`.

## Python API Usage
`rnanorm` classes are compatible with scikit-learn's `fit_transform` pattern.

```python
from rnanorm import TPM
import pandas as pd

# Load your expression data (Samples as rows, Genes as columns)
exp_df = pd.read_csv("counts.csv", index_index=0)

# Initialize and transform
# Use set_output(transform="pandas") to maintain DataFrame structure
tpm_transformer = TPM(gtf_path="annotations.gtf").set_output(transform="pandas")
normalized_df = tpm_transformer.fit_transform(exp_df)
```

## Expert Tips
- **Method Selection**: 
    - Use **TPM** or **FPKM** when you need to compare different genes within the same sample (accounts for gene length).
    - Use **TMM** or **Upper Quartile (UQ)** for differential expression analysis or cross-sample comparisons (accounts for library composition).
- **Data Orientation**: If your data has genes in rows (common in many genomic formats), you must transpose it before passing it to `rnanorm`.
- **Validation**: The TMM and UQ implementations are validated against `edgeR` to ensure scientific consistency with industry-standard R packages.

## Reference documentation
- [RNAnorm GitHub Repository](./references/github_com_genialis_RNAnorm.md)
- [RNAnorm Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rnanorm_overview.md)