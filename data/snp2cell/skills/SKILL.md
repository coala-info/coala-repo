---
name: snp2cell
description: snp2cell maps GWAS results onto cell-type-specific regulatory landscapes using network propagation to identify gene programs driving specific traits. Use when user asks to map genetic variants to cellular functions, interpret the functional impact of non-coding variants, or run network propagation on gene regulatory networks.
homepage: https://github.com/Teichlab/snp2cell
---

# snp2cell

## Overview
`snp2cell` is a bioinformatics tool designed to bridge the gap between genetic variants (SNPs) and cellular function. It maps GWAS (Genome-Wide Association Study) results onto cell-type-specific regulatory landscapes. By utilizing network propagation on a base gene regulatory network, the tool identifies which gene programs are most likely driving a specific trait within a particular cell population. This is particularly useful for interpreting the functional impact of non-coding variants discovered in GWAS.

## Core Workflow
The standard `snp2cell` workflow involves three primary data inputs:
1.  **GWAS Summary Statistics**: Typically processed into scores (e.g., fGWAS scores).
2.  **Single-Cell Data**: Gene expression profiles or differential expression groups.
3.  **Base GRN**: A networkx-compatible graph representing known gene interactions.

### CLI Usage Patterns
The command line interface provides a streamlined way to execute the integration pipeline.

**Basic Help and Setup**
```bash
# View all available options and subcommands
snp2cell --help

# Enable shell autocompletion (Bash example)
snp2cell --install-completion bash
source ~/.bashrc
```

**Running the Analysis**
While the CLI is available, the tool is frequently used as a Python module for maximum flexibility. When using the CLI or Python API, ensure your GWAS scores are properly formatted (often requiring log-scale transformation for better propagation results).

### Python API Best Practices
For complex analyses, importing `snp2cell` as a module is recommended:

```python
import snp2cell
import scanpy as sc
import networkx as nx

# Initialize the SNP2CELL object
# Note: Ensure de_groups are stored as copies to prevent unintended modifications
s2c = snp2cell.SNP2CELL(
    adata=my_adata, 
    grn=my_networkx_graph,
    gwas_scores=my_scores
)

# Load fGWAS scores
# The rbf_table_path is optional in newer versions (v0.3.0+)
s2c.load_fgwas_scores(scores_path="path/to/scores.txt", use_log_scale=True)

# Run network propagation and permutation testing
s2c.run_propagation(n_permutations=1000)
```

### Expert Tips
*   **Memory Management**: Ensure your system has enough RAM to hold the single-cell AnnData object and the networkx graph simultaneously.
*   **Parallelization**: `snp2cell` can utilize multiple CPUs. When running permutations, specify the number of cores to significantly reduce computation time.
*   **Score Ordering**: When plotting results, use the optional parameters for score ordering to highlight the most significant trait-cell type associations.
*   **Logging**: If debugging, check the logs. Recent versions (v0.3.0+) have refactored logging where detailed information is moved to the `DEBUG` level to keep the standard output clean.



## Subcommands

| Command | Description |
|---------|-------------|
| snp2cell add-score | Add scores for network nodes to the s2c object and propagate the scores across the network. |
| snp2cell combine-scores | Assuming that both a SNP score and DE scores have been added to the s2c object, combine SNP score with DE scores and compute statistics. |
| snp2cell contrast-scores | Add a new score that is a contrast of two scores, propagate it across the network and calculate statistics based on random permutations. |
| snp2cell export-locations | Save the genomic locations of network nodes in the s2c object to a tsv file. |
| snp2cell score-de | Add an anndata object to the s2c object, find differentially expressed genes and propagate the gene scores across the network. Then the DE scores and previously computed SNP scores are combined and statistics are computed based on random permutations. |
| snp2cell score-snp | Add fGWAS scores for network nodes based on GWAS summary statistics. Then propagate the scores across the network and calculate statistics based on random permutations. All calculated information will be saved in the s2c object. |
| snp2cell_create-gene2pos-mapping | Create a gene to genomic position mapping. |

## Reference documentation
- [snp2cell README](./references/github_com_Teichlab_snp2cell_blob_main_README.md)
- [fGWAS Scores Notebook](./references/github_com_Teichlab_snp2cell_blob_main_docs_source_snp2cell_fgwas_scores.ipynb.md)
- [Toy Example Notebook](./references/github_com_Teichlab_snp2cell_blob_main_docs_source_toy_example.ipynb.md)