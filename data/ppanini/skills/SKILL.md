---
name: ppanini
description: "PPANINI prioritizes microbial genes based on their metagenomic properties. Use when user asks to analyze microbial gene importance from metagenomic data, identify novel and important genes, or generate prioritized gene lists for further analysis."
homepage: http://huttenhower.sph.harvard.edu/ppanini
---


# ppanini

ppanini/
├── SKILL.md
└── references/
    ├── anaconda_org_channels_bioconda_packages_ppanini_overview.md
    └── huttenhower_sph_harvard_edu_ppanini.md
```

```markdown
name: ppanini
description: |
  Prioritizes microbial genes based on their metagenomic properties (prevalence and abundance) using automated data network integration.
  Use when Claude needs to analyze microbial gene importance from metagenomic data, identify novel and important genes, or generate prioritized gene lists for further analysis.
---
## Overview

PPANINI is a computational pipeline designed to prioritize microbial genes by analyzing their prevalence and abundance within metagenomic datasets. It helps identify novel and important genes by integrating data through automated network analysis. The tool generates a ranked list of gene candidates, along with their prevalence, abundance, and a PPANINI score, which can then be used for further visualization and analysis.

## Usage Instructions

PPANINI requires a gene abundance table and can optionally use a gene catalog FASTA file or a UCLUST file for clustering unannotated genes.

### Installation

Install PPANINI using conda:
```bash
conda install bioconda::ppanini
```

### Basic Usage

The most common usage involves providing an input gene table and a FASTA file for gene catalog clustering.

```bash
ppanini -i <genetable.txt> --gene-catalog <samples.fasta> -o <OUTPUT_DIR> --vsearch /path/to/vsearch
```

- `-i <genetable.txt>`: Path to the input gene abundance table.
- `--gene-catalog <samples.fasta>`: Path to the FASTA file containing gene sequences for clustering unannotated genes.
- `-o <OUTPUT_DIR>`: The directory where output files will be saved.
- `--vsearch /path/to/vsearch`: Path to the vsearch executable. This is often required for the clustering step.

### Bypassing Clustering

If your gene abundance table already contains centroids or you wish to skip the clustering step, use the `--bypass-clustering` flag.

```bash
ppanini -i <genetable.txt> --bypass-clustering -o <OUTPUT_DIR>
```

### Using UCLUST Files

If you have pre-defined gene clusters in a UCLUST file, you can provide it directly.

```bash
ppanini -i <stool_gene_centroids_table.txt> --uc <stool_gene_clusters.uc> -o <OUTPUT_DIR>
```

- `--uc <stool_gene_clusters.uc>`: Path to the UCLUST file containing gene centroids.

### Expert Tips

*   **vsearch Path**: Ensure the `--vsearch` path is correctly specified. This is a common point of failure if vsearch is not in your system's PATH or if its location is not explicitly provided.
*   **Gene Catalog vs. UCLUST**: Choose between `--gene-catalog` (for FASTA) and `--uc` (for UCLUST) based on how your gene annotations are structured. If you have representative sequences for clusters, use `--gene-catalog`. If you have pre-computed cluster assignments, use `--uc`.
*   **Output Directory**: Always specify an output directory (`-o`) to keep your results organized.
*   **Input Table Format**: The gene abundance table (`genetable.txt`) should be tab-delimited or space-delimited, with gene identifiers in one column and sample abundances in subsequent columns. Refer to the documentation for exact formatting requirements.

## Reference documentation

- [PPANINI – The Huttenhower Lab](./references/huttenhower_sph_harvard_edu_ppanini.md)
- [ppanini - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ppanini_overview.md)