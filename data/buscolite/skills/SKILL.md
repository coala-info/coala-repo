---
name: buscolite
description: Buscolite is a lightweight alternative to the standard BUSCO (Benchmarking Universal Single-Copy Orthologs) tool.
homepage: https://github.com/nextgenusfs/buscolite
---

# buscolite

## Overview
Buscolite is a lightweight alternative to the standard BUSCO (Benchmarking Universal Single-Copy Orthologs) tool. It is specifically designed for integration into genome annotation pipelines (like Funannotate) where minimal dependencies and deterministic results are required. It supports both genome and protein modes, utilizing `miniprot` or `Augustus` for genome-based predictions and `pyhmmer` for HMM-based protein analysis. It is ideal for users who need rapid completeness statistics or publication-quality summary plots without the complexity of MetaEuk-based workflows.

## Installation
Install via Conda or Pip:
```bash
# Via Bioconda
conda install bioconda::buscolite

# Via Pip
python -m pip install buscolite
```

## Core CLI Usage

### Genome Assembly Analysis
To run analysis on a genome FASTA file using a specific lineage database:
```bash
buscolite -i genome.fasta -o output_dir -m genome -l /path/to/lineage_odb12 -c 8
```
*   `-i`: Input FASTA file.
*   `-o`: Output directory name.
*   `-m`: Mode (`genome` or `proteins`).
*   `-l`: Path to the BUSCO lineage directory (downloaded manually from BUSCO site).
*   `-c`: Number of CPU cores.

### Protein Set Analysis
To evaluate the completeness of a predicted proteome:
```bash
buscolite -i proteins.faa -o output_dir -m proteins -l /path/to/lineage_odb12
```

### Visualization and Comparison
Buscolite provides a dedicated utility for generating SVG plots from the `.json` results.

**Single Sample Plot:**
```bash
buscolite-plot output_dir.buscolite.json -o summary_plot.svg
```

**Multi-Sample Comparison:**
```bash
buscolite-plot sample1.json sample2.json sample3.json -o comparison_results.svg
```

## Expert Tips and Best Practices
*   **Database Preparation**: Buscolite does not have an internal downloader. You must manually download the required lineage (v4, v5, or v12) from the BUSCO database repository before running the tool.
*   **Augustus Compatibility**: If using Augustus-mediated predictions, ensure your environment has a version of Augustus that supports protein profiles (`--proteinprofile`), as some Conda versions are known to have issues with this specific mode.
*   **Why use Buscolite over BUSCO?**: Use Buscolite when you need complete gene models for training ab-initio predictors. Standard BUSCO v5 uses MetaEuk by default, which is faster for stats but often produces incomplete or "lowercase" protein sequences that do not exist in the actual genome.
*   **Integration**: If you are developing Python scripts, you can use the Buscolite API directly to run analyses programmatically, which is the preferred method for eukaryotic gene prediction pipelines.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_nextgenusfs_buscolite.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_buscolite_overview.md)