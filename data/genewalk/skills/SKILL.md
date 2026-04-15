---
name: genewalk
description: GeneWalk identifies context-specific biological functions of genes by performing random walks on a gene regulatory network to generate embeddings. Use when user asks to prioritize biological processes for a gene list, perform functional genomics analysis beyond standard enrichment, or identify significant GO terms for specific experimental data.
homepage: https://github.com/churchmanlab/genewalk
metadata:
  docker_image: "quay.io/biocontainers/genewalk:1.6.3--pyh7e72e81_0"
---

# genewalk

## Overview

GeneWalk is a specialized tool for functional genomics that goes beyond standard enrichment analysis. It uses random walks on a gene regulatory network to learn vector representations (embeddings) of genes and GO terms. By comparing these embeddings, it identifies which biological functions are most relevant to your specific gene list in a given context. Use this skill to move from a simple list of genes to a prioritized set of biological processes, molecular functions, or cellular components that are statistically significant for your experimental data.

## Installation and Setup

Install GeneWalk via pip or conda:

```bash
# Via pip
pip install genewalk

# Via conda
conda install -c bioconda genewalk
```

To avoid runtime delays, pre-download the required resource files (Pathway Commons, GO, etc.):

```bash
python -m genewalk.resources
```

## Core CLI Usage

The basic command requires a project name, a path to your gene list, and the identifier type used in that list.

```bash
genewalk --project my_experiment --genes de_genes.txt --id_type hgnc_symbol
```

### Supported ID Types
- `hgnc_symbol` (e.g., TP53)
- `hgnc_id` (e.g., 11998)
- `ensembl_id` (e.g., ENSG00000141510)
- `entrez_human` or `entrez_mouse`
- `mgi_id` (Mouse) or `rgd_id` (Rat)
- `custom` (Requires a custom network)

## Advanced Configuration

### Performance Optimization
For large gene lists or faster processing, increase the number of processors:

```bash
genewalk --project context_study --genes genes.txt --id_type hgnc_symbol --nproc 8
```

### Adjusting Statistical Stringency
By default, GeneWalk outputs all similarities. Use `--alpha_fdr` to filter the final statistics table to only include significant results (e.g., FDR < 0.05):

```bash
genewalk --project high_stringency --genes genes.txt --id_type hgnc_symbol --alpha_fdr 0.05
```

### Custom Networks
If you are working with non-model organisms or specific interactomes, provide your own network file:

```bash
genewalk --project custom_net --genes genes.txt --id_type custom --network_source sif_full --network_file my_network.sif
```

## Expert Tips

1. **Project Management**: GeneWalk creates a folder named after your `--project` inside the `--base_folder` (default: `~/genewalk`). Use unique project names to avoid overwriting previous results.
2. **Embedding Dimensions**: If you have a very large gene list (>2500 genes) and see no significant results, consider increasing `--dim_rep` (default: 8). Conversely, for very short lists, decreasing it may help.
3. **Stage-wise Execution**: If a run fails or you want to re-run only the statistics, use the `--stage` argument:
   - `node_vectors`: Generates embeddings.
   - `null_distribution`: Generates the background model.
   - `statistics`: Calculates p-values and FDR.
   - `visual`: Generates plots.
4. **Reproducibility**: Always set a `--random_seed` if you need to generate the exact same p-values across different runs, as the random walk process is inherently stochastic.

## Reference documentation
- [GeneWalk GitHub Repository](./references/github_com_churchmanlab_genewalk.md)
- [Bioconda GeneWalk Overview](./references/anaconda_org_channels_bioconda_packages_genewalk_overview.md)