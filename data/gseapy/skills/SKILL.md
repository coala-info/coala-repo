---
name: gseapy
description: GSEApy is a Python library for performing biological pathway enrichment analysis including GSEA, ssGSEA, and Enrichr API integration. Use when user asks to perform gene set enrichment analysis, run preranked GSEA, calculate single-sample enrichment scores, or access the Enrichr database.
homepage: https://github.com/zqfang/gseapy
---


# gseapy

## Overview
GSEApy is a high-performance Python library with a Rust-powered core designed for biological pathway analysis. It serves as a native Python implementation of the GSEA desktop tool and a wrapper for the Enrichr API. This skill allows for the seamless integration of enrichment workflows into Python-based bioinformatics pipelines, enabling users to move from expression matrices (Pandas DataFrames) to publication-quality figures and statistical reports without leaving the Python environment or switching to R.

## Core Sub-commands and Usage

GSEApy provides seven primary modules accessible via both CLI and Python API:

1.  **gsea**: Standard GSEA for comparing two groups. Requires an expression file (.txt/FPKM/TPM), a phenotype labeling file (.cls), and a gene set file (.gmt).
2.  **prerank**: GSEA using a pre-ranked list of genes. Requires a ranked list (.rnk) and a gene set file (.gmt).
3.  **ssgsea**: Single-sample GSEA. Calculates enrichment scores for each sample independently.
4.  **gsva**: Gene Set Variation Analysis. An alternative to ssGSEA for calculating sample-wise enrichment.
5.  **enrichr**: Interface for the Enrichr API. Performs enrichment on a simple list of gene symbols against online libraries (e.g., KEGG, GO).
6.  **replot**: Reproduces figures from GSEA Desktop version output.
7.  **biomart**: Utility for converting gene IDs and mapping genomic coordinates.

## CLI Patterns

### Standard GSEA
```bash
gseapy gsea -d expression.txt -c test.cls -g gene_sets.gmt -o output_dir
```

### Preranked Analysis
```bash
gseapy prerank -r gene_list.rnk -g gene_sets.gmt -o output_dir
```

### Enrichr API Call
```bash
gseapy enrichr -i gene_list.txt -g KEGG_2021_Human -o output_dir
```

## Python API Best Practices

### Working with Pandas
GSEApy is optimized for Pandas. You can pass DataFrames directly to avoid writing intermediate files:

```python
import gseapy as gp
import pandas as pd

# For GSEA
gs_res = gp.gsea(data=df, gene_sets='KEGG_2016', cls=sample_groups, outdir='test')

# For Prerank
pre_res = gp.prerank(rnk=ranked_df, gene_sets='GO_Biological_Process_2021', outdir='test')
```

### Finding Gene Set Libraries
To see available libraries for the `enrichr` module:
```python
# List all available Enrichr libraries
names = gp.get_library_name()
```

## Expert Tips

*   **Rust Dependency**: For versions > 0.11.0, a Rust compiler is required for installation via pip. If installation fails, ensure `rustc` is in your PATH or use the Bioconda distribution.
*   **File Formats**: GSEApy maintains strict compatibility with GSEA Desktop formats. Ensure `.cls` files follow the specific three-line format (sample count, group names, and sample assignments).
*   **Memory Efficiency**: When running `ssgsea` or `gsva` on large datasets, use the Python API with DataFrames to minimize I/O overhead.
*   **Visualization**: GSEApy generates `.png` or `.pdf` figures by default. Use the `format` parameter in the API to specify the output type for publication-quality vector graphics.

## Reference documentation
- [GSEApy GitHub Repository](./references/github_com_zqfang_gseapy.md)
- [GSEApy Overview and Installation](./references/anaconda_org_channels_bioconda_packages_gseapy_overview.md)