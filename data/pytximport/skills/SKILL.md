---
name: pytximport
description: pytximport summarizes transcript-level quantification data to the gene level for downstream statistical analysis. Use when user asks to summarize abundance estimates to the gene level, generate transcript-to-gene maps, or import quantification data from tools like Salmon and Kallisto.
homepage: https://pytximport.readthedocs.io/en/latest/start.html
metadata:
  docker_image: "quay.io/biocontainers/pytximport:0.12.0--pyhdfd78af_0"
---

# pytximport

## Overview
`pytximport` is the Python implementation of the R Bioconductor package `tximport`. It serves as the essential bridge between transcript-level quantification tools (pseudoaligners) and gene-level statistical analysis. Use this skill to summarize abundance estimates to the gene level while accounting for transcript length changes across samples, which improves the accuracy of gene-level differential expression.

## Core Workflows

### 1. Generating Transcript-to-Gene Maps
Before importing counts, you must map transcript IDs to gene IDs.

**From a GTF file (CLI):**
```bash
pytximport create-map -i ./annotation.gtf -o tx2gene.csv
```

**From BioMart (Python):**
```python
from pytximport.utils import create_transcript_gene_map
# Supports "human", "mouse", etc.
tx2gene = create_transcript_gene_map(species="human")
```

### 2. Importing Quantification Data
The tool supports various quantification methods. Specify the `data_type` (e.g., `salmon`, `kallisto`, `rsem`).

**Command Line Interface:**
```bash
pytximport -i sample1/quant.sf -i sample2/quant.sf \
           -t salmon \
           -m tx2gene.csv \
           -o gene_counts.csv \
           -c length_scaled_tpm
```

**Python API:**
```python
from pytximport import tximport

files = ["sample1/quant.sf", "sample2/quant.sf"]
results = tximport(
    file_paths=files,
    data_type="salmon",
    transcript_gene_map=tx2gene,
    counts_from_abundance="length_scaled_tpm"
)
# results is a dictionary containing 'counts', 'abundance', and 'length'
```

## Expert Tips & Best Practices

### Selecting the Scaling Method (`-c` / `counts_from_abundance`)
The choice of scaling significantly impacts downstream analysis:
*   **`length_scaled_tpm`**: Recommended for **Differential Gene Expression (DGE)**. It generates count-scale data that is corrected for changes in average transcript length across samples.
*   **`scaled_tpm`**: Recommended for **Differential Transcript Expression (DTE)**.
*   **`dtu_scaled_tpm`**: Recommended for **Differential Isoform Usage (DTU)** analysis.
*   **None (default)**: Returns raw counts. Only use this if you are certain transcript length bias is not an issue.

### Handling Versioned IDs
If your quantification files use versioned IDs (e.g., `ENST00000394444.5`) but your map uses base IDs (`ENST00000394444`), use the `ignore_transcript_version` flag:
```python
results = tximport(..., ignore_transcript_version=True)
```

### Integration with scverse
To use results directly with `scanpy` or other `scverse` tools, export to `.h5ad` format:
```bash
pytximport -i ... -o results.h5ad -of h5ad
```

### RSEM Specifics
When working with RSEM, you can import pre-summarized gene-level counts directly using the `-gl` (gene-level) flag, though summarizing from transcript-level via `pytximport` is generally preferred for consistency.

## Reference documentation
- [pytximport Quick Start](./references/pytximport_complextissue_com_en_latest_start.html.md)