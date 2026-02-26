---
name: panacota
description: PanACoTA is a modular suite for high-throughput microbial genomics that automates the workflow from raw genomic data to phylogenetic tree construction. Use when user asks to download and quality control genomes, annotate bacterial sequences, cluster pangenomes, identify persistent gene families, or infer phylogenetic trees for large datasets.
homepage: https://github.com/gem-pasteur/PanACoTA
---


# panacota

## Overview

PanACoTA (PANgenome with Annotations, COre identification, Tree and corresponding Alignments) is a modular suite designed for high-throughput microbial genomics. It streamlines the transition from raw genomic data or NCBI RefSeq identifiers to a fully realized phylogenetic tree based on the persistent genome. The tool is optimized for reproducibility and standardization, making it ideal for analyzing hundreds or thousands of bacterial strains within a single species or genus.

## Core Modules and CLI Usage

PanACoTA is executed using the primary command followed by a specific submodule: `PanACoTA <subcommand> [options]`.

### 1. Prepare (Quality Control)
Downloads genomes from NCBI or uses local files to perform quality control based on Mash distances and assembly metrics.
- **NCBI Download:** `PanACoTA prepare --taxid <NCBI_TaxID> -o <output_dir>`
- **Local Files:** `PanACoTA prepare --db <folder_with_fasta> -o <output_dir>`
- **Tip:** Use the `--cut` parameter to define the Mash distance threshold for filtering out outliers (strains that are too distant or potentially misidentified).

### 2. Annotate
Provides uniform syntactic annotation across the dataset to ensure consistency in pangenome clustering.
- **Usage:** `PanACoTA annotate -d <prepared_dir> -o <output_dir> --prokka`
- **Options:** Supports both `prokka` and `prodigal`. Prokka is generally preferred for comprehensive feature sets.

### 3. Pangenome
Clusters proteins into families using MMseqs2.
- **Usage:** `PanACoTA pangenome -d <annotated_dir> -o <output_dir>`
- **Tip:** Adjust clustering identity thresholds if working with highly diverse species.

### 4. Core/Persistent Genome
Identifies the set of gene families present in a specified percentage of strains (e.g., 95% for "persistent" genome).
- **Usage:** `PanACoTA corepers -p <pangenome_file> -o <output_dir> -t 0.95`
- **Note:** The `-t` (threshold) argument is critical; a value of `1.0` identifies the strict core, while `0.95` allows for missing genes in 5% of strains, which is more robust against assembly/annotation artifacts.

### 5. Align
Aligns the identified persistent gene families.
- **Usage:** `PanACoTA align -c <corepers_file> -o <output_dir> --mafft`
- **Tip:** Use `--amino` to force protein alignments, which can be more accurate for distant relationships.

### 6. Tree
Infers a phylogenetic tree from the concatenated alignments.
- **Usage:** `PanACoTA tree -a <alignment_file> -o <output_dir> --iqtree`
- **Engines:** Supports `iqtree`, `fasttree`, `fastme`, and `quicktree`. Use `fasttree` for very large datasets where IQ-TREE might be computationally prohibitive.

### 7. All (Pipeline Wrapper)
Runs the entire workflow from start to finish using a single command.
- **Usage:** `PanACoTA all --taxid <ID> -o <output_dir> [module_options]`

## Best Practices

- **Environment Management:** Always run PanACoTA in a dedicated Conda environment or via the Singularity image to avoid dependency conflicts with tools like Prokka or Mash.
- **Resource Allocation:** For large-scale pangenomes, ensure the system has sufficient RAM for MMseqs2 and multiple threads for MAFFT/IQ-TREE.
- **Input Validation:** Ensure protein names in custom input files follow the required format (GemBase style) to prevent errors during the pangenome clustering phase.
- **Phylogeny Choice:** For maximum accuracy, use `iqtree` with model selection. For rapid screening of thousands of genomes, `fasttree` is the industry standard.

## Reference documentation
- [PanACoTA GitHub Repository](./references/github_com_gem-pasteur_PanACoTA.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_panacota_overview.md)