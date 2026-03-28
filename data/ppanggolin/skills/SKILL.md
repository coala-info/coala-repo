---
name: ppanggolin
description: PPanGGOLiN is a suite of tools that models microbial species diversity by creating partitioned pangenome graphs using gene presence/absence and genomic neighborhood information. Use when user asks to perform pangenome analysis, annotate and cluster genomes, partition gene families into core or accessory genomes, predict genomic islands and modules, or align sequences to a pangenome.
homepage: https://github.com/labgem/PPanGGOLiN
---

# ppanggolin

## Overview
PPanGGOLiN (Partitioned PanGenome Graph Of Linked Neighbors) is a suite of tools designed to model the diversity of microbial species. Unlike traditional methods that use fixed frequency thresholds to define core and accessory genomes, PPanGGOLiN uses a graphical model and statistical partitioning. This allows it to handle low-quality data like Metagenomic Assembled Genomes (MAGs) and Single-cell Amplified Genomes (SAGs) effectively. It integrates gene presence/absence with genomic neighborhood information to create a Partitioned Pangenome Graph (PPG).

## Core Workflows

### 1. Complete Pangenome Analysis
The `all` subcommand is the most efficient way to run a standard pipeline (annotation, clustering, graph construction, partitioning, and RGP/module prediction).

```bash
ppanggolin all --fasta genomes_list.txt --cpu 8
```

### 2. Input File Preparation
The input file (e.g., `genomes_list.txt`) must be a tab-separated file (TSV) with the following structure:
- **Column 1**: Unique genome name (no spaces).
- **Column 2**: Absolute or relative path to the FASTA file.
- **Optional Columns**: Circular contig identifiers.

If you already have annotations (e.g., from Bakta or Prokka), use `--anno`:
```bash
ppanggolin all --anno annotations_list.txt
```

### 3. Step-by-Step Analysis
For large datasets or custom parameter tuning, run subcommands individually. All steps update a central HDF5 file (`pangenome.h5`).

1. **Annotate**: `ppanggolin annotate --fasta genomes_list.txt`
2. **Cluster**: `ppanggolin cluster -p pangenome.h5`
3. **Graph**: `ppanggolin graph -p pangenome.h5`
4. **Partition**: `ppanggolin partition -p pangenome.h5`
5. **RGP Prediction**: `ppanggolin rgp -p pangenome.h5`

## Specialized Analyses

### Aligning Sequences to a Pangenome
To identify which gene families or partitions a set of external sequences (proteins or nucleotides) belongs to:
```bash
ppanggolin align -p pangenome.h5 --sequences interest.fasta --getinfo
```

### Predicting Genomic Islands (RGPs) and Modules
- **RGPs**: Clusters of variable genes (shell/cloud) that often represent horizontal gene transfer.
- **Spots**: Conserved insertion sites for RGPs across different genomes.
- **Modules**: Groups of co-occurring and colocalized genes within variable regions.

```bash
# Predict modules on an existing pangenome
ppanggolin module -p pangenome.h5
```

## Expert Tips and Best Practices

- **Genome Count**: While PPanGGOLiN can run on as few as 5 genomes, at least **15 genomes** are recommended for the statistical partitioning to be robust.
- **HDF5 Management**: The `pangenome.h5` file is the single source of truth. You can rerun specific steps (like `partition`) with different parameters without restarting the entire pipeline.
- **Memory and CPU**: Use the `--cpu` flag to scale. For very large datasets (thousands of genomes), ensure the temporary directory (default `/tmp`) has sufficient space, or redirect it using `--tmpdir`.
- **Visualization**: Use the `draw` subcommand to generate figures.
  - `ppanggolin draw --pangenome -p pangenome.h5`: Draws the global pangenome graph.
  - `ppanggolin draw --spots -p pangenome.h5`: Visualizes insertion spots.
- **Data Extraction**: Use `ppanggolin write` to export results into human-readable formats (TSV, GFF, FASTA).
  - `ppanggolin write --borders -p pangenome.h5`: Exports genes flanking RGPs.



## Subcommands

| Command | Description |
|---------|-------------|
| ppanggolin | ppanggolin: error: argument : invalid choice: 'ppanggolin' (choose from 'annotate', 'cluster', 'graph', 'partition', 'rarefaction', 'workflow', 'panrgp', 'panmodule', 'all', 'draw', 'write_pangenome', 'write_genomes', 'write_metadata', 'fasta', 'msa', 'metrics', 'align', 'rgp', 'spot', 'module', 'context', 'projection', 'rgp_cluster', 'metadata', 'info', 'utils') |
| ppanggolin align | Align sequences (nucleotides or amino acids) on the pangenome gene families. |
| ppanggolin all | PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement. |
| ppanggolin annotate | PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement. |
| ppanggolin cluster | PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement. |
| ppanggolin context | PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement. |
| ppanggolin draw | PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement. |
| ppanggolin fasta | PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement. |
| ppanggolin graph | PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement. |
| ppanggolin metadata | PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement. |
| ppanggolin metrics | PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement. |
| ppanggolin module | PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement. |
| ppanggolin msa | compute Multiple Sequence Alignment of the gene families in the given partition |
| ppanggolin panmodule | PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement. |
| ppanggolin panrgp | PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement. |
| ppanggolin partition | PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement. |
| ppanggolin projection | Project pangenome annotations onto input genomes. |
| ppanggolin rarefaction | Compute the rarefaction curve of the pangenome |
| ppanggolin rgp | For genomic islands and spots of insertion detection, please cite: Bazin A et al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore their diversity. Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658, https://doi.org/10.1093/bioinformatics/btaa792 |
| ppanggolin rgp_cluster | Cluster RGPs based on gene repertoire relatedness. |
| ppanggolin spot | PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement. |
| ppanggolin utils | Generate a config file with default values for the given subcommand. |
| ppanggolin workflow | PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM team, and distributed under the CeCILL Free Software License Agreement. |
| ppanggolin write_genomes | Write genomes from a pangenome analysis. |
| ppanggolin write_metadata | Write metadata for pangenome elements. |
| ppanggolin write_pangenome | Write pangenome data to various formats. |
| ppanggolin_info | Show information about a pangenome. |

## Reference documentation
- [PPanGGOLiN GitHub Home](./references/github_com_labgem_PPanGGOLiN.md)
- [Quick Usage Guide](./references/github_com_labgem_PPanGGOLiN_wiki_Basic-usage-and-practical-information.md)
- [Step-by-Step Analysis](./references/github_com_labgem_PPanGGOLiN_wiki_PPanGGOLiN---step-by-step-pangenome-analysis.md)
- [Aligning Sequences](./references/github_com_labgem_PPanGGOLiN_wiki_Align.md)
- [Output Formats](./references/github_com_labgem_PPanGGOLiN_wiki_Outputs.md)