---
name: generax
description: GeneRax infers gene family trees by modeling duplication, transfer, and loss events and can reconcile them with a species tree. Use when user asks to infer gene family trees, reconcile gene trees with species trees, or infer species trees from gene trees.
homepage: https://github.com/benoitmorel/generax
metadata:
  docker_image: "quay.io/biocontainers/generax:2.1.3--hf316886_3"
---

# generax

yaml
name: generax
description: |
  GeneRax is a tool for inferring gene family trees, accounting for gene duplication, transfer, and loss events, and reconciling them with a species tree. It also includes SpeciesRax for inferring species trees from gene trees. Use GeneRax when you need to perform phylogenetic analysis of gene families in the context of evolutionary events like duplication and transfer, or when you need to infer a species tree from gene trees.
```

## Overview

GeneRax is a powerful bioinformatics tool designed for inferring gene family trees. It excels at handling complex evolutionary scenarios by explicitly modeling gene duplication, transfer, and loss events. Furthermore, GeneRax can reconcile these gene family trees with a provided species tree, offering a more accurate phylogenetic picture. A key component, SpeciesRax, is also included for inferring species trees from sets of unrooted gene trees. This skill is for users who need to perform advanced phylogenetic analyses, particularly in evolutionary biology and comparative genomics, where understanding gene family evolution and species relationships is crucial.

## Usage Instructions

GeneRax is primarily a command-line tool. The core functionality involves providing input files that describe your genetic data and evolutionary context.

### Core Inputs:

1.  **Aligned Gene Sequences:** Typically in FASTA format.
2.  **Gene to Species Mapping:** A file that maps each gene to its corresponding species.
3.  **Species Tree:** A rooted, undated species tree, usually in Newick format.

### Installation:

GeneRax can be installed via Bioconda:
```bash
conda install bioconda::generax
```
Alternatively, you can build from source by cloning the repository with `--recursive` and running `./install.sh`.

### Running GeneRax:

The general command structure involves specifying input files and output directories.

**Basic Gene Tree Inference:**

```bash
generax -s <species_tree.nwk> -g <gene_families_dir> -m <gene_to_species_map.tsv> -o <output_dir>
```

*   `-s`: Path to the rooted species tree file (Newick format).
*   `-g`: Directory containing aligned gene families (e.g., FASTA files, one per family).
*   `-m`: Path to the gene to species mapping file.
*   `-o`: Directory where GeneRax will save its output.

**Running SpeciesRax (for species tree inference):**

SpeciesRax is used to infer a species tree from a set of unrooted gene trees.

```bash
speciesrax -g <gene_trees_dir> -o <output_dir>
```

*   `-g`: Directory containing unrooted gene trees (e.g., Newick format).
*   `-o`: Directory for SpeciesRax output.

### Expert Tips:

*   **Parallel Execution:** GeneRax is designed for parallel execution. Ensure your system has MPI configured and available for faster processing on large datasets.
*   **Input File Formats:** Pay close attention to the expected formats for species trees (Newick), gene sequences (FASTA), and gene-to-species mapping (TSV or similar, check documentation for exact column requirements).
*   **Output Interpretation:** GeneRax outputs inferred gene trees, reconciled trees, and detailed event counts (duplications, transfers, losses). SpeciesRax outputs the inferred species tree. Familiarize yourself with the output file structures to effectively interpret the results.
*   **Troubleshooting:** When encountering issues, consult the GeneRax Google Group for community support. Provide your command line, log files, and family files for quicker problem resolution.
*   **Large Datasets:** For very large datasets, consider optimizing input data preparation and leveraging the parallel processing capabilities of GeneRax. The wiki provides guidance on handling large datasets.

## Reference documentation

- [GeneRax Wiki](./references/github_com_benoitmorel_generax_wiki.md)
- [GeneRax GitHub Repository](./references/github_com_benoitmorel_generax.md)
- [GeneRax Overview on Bioconda](./references/anaconda_org_channels_bioconda_packages_generax_overview.md)