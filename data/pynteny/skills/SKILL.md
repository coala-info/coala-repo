---
name: pynteny
description: "Pynteny performs synteny-aware searches in sequence databases to identify specific architectural arrangements of genes. Use when user asks to search for metabolic pathways or operons, define gene orientations and distances, or build a searchable peptide database from assembly data."
homepage: http://github.com/robaina/Pynteny
---


# pynteny

## Overview

Pynteny is a bioinformatics tool designed to perform synteny-aware searches within sequence databases. Unlike standard HMMER searches that look for individual protein domains in isolation, Pynteny allows you to define a specific architectural arrangement of genes—including their relative orientations (strands) and the maximum number of intervening genes between them. This approach is particularly powerful for discovering metabolic pathways, specialized operons, or any functional unit where genomic proximity is a key indicator of biological relevance.

## Core Workflow

The standard Pynteny workflow consists of three main stages: downloading profile HMMs, building a searchable database from assembly data, and executing the synteny search.

### 1. Resource Acquisition
Download the PGAP (Prokaryotic Genome Annotation Pipeline) database or other profile HMM collections to use as your search seeds.

```bash
pynteny download --outdir ./hmms --unpack
```

### 2. Database Construction
Convert raw DNA assembly data (FASTA) into a labeled peptide database. This step uses Prodigal for gene prediction and labels each peptide with its genomic coordinates.

```bash
pynteny build --data assembly.fasta --outfile labeled_peptides.faa
```

### 3. Synteny Search
Query the labeled database using a synteny structure string.

```bash
pynteny search \
  --synteny_struc ">geneA 0 >geneB 2 <geneC" \
  --data labeled_peptides.faa \
  --outdir results/ \
  --hmm_dir ./hmms \
  --gene_ids
```

## Synteny Structure Syntax

The `--synteny_struc` argument is the core of the tool. It uses a specific string format to define the search pattern:

*   **Orientation**: Use `>` for the positive (forward) strand and `<` for the negative (reverse) strand.
*   **Gene Identifier**: The name of the HMM profile (e.g., `pfam00123` or a PGAP ID).
*   **Distance**: An integer representing the **maximum** number of intervening genes allowed between the current gene and the next one in the string.

**Example Pattern**: `">gene_A 0 >gene_B 5 <gene_C"`
*   `gene_A` and `gene_B` must be on the positive strand.
*   `gene_A` and `gene_B` must be strictly consecutive (0 genes between them).
*   `gene_C` must be on the negative strand.
*   There can be at most 5 genes between `gene_B` and `gene_C`.

## Expert Tips and Best Practices

*   **Resolving Paralogs**: If a genome has multiple hits for a specific HMM, Pynteny will only return those that satisfy the spatial constraints of the surrounding genes, effectively filtering out isolated paralogs that lack the required genomic context.
*   **Gene ID Mapping**: Always include the `--gene_ids` flag during a search if you need to map the resulting hits back to specific HMM identifiers in your output tables.
*   **Hardware Compatibility**: Pynteny is optimized for Linux. If running on macOS with ARM64 (M1/M2/M3 chips), you must force the `osx-64` architecture in your conda environment:
    ```bash
    CONDA_SUBDIR=osx-64 conda create -n pynteny python=3.10
    conda activate pynteny
    conda config --env --set subdir osx-64
    conda install -c bioconda pynteny
    ```
*   **Memory Management**: For very large metagenomic assemblies, ensure you have sufficient RAM, as `pynteny build` performs comprehensive ORF prediction and labeling.

## Reference documentation
- [Pynteny GitHub Repository](./references/github_com_robaina_Pynteny.md)
- [Pynteny Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pynteny_overview.md)