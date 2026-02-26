---
name: lsabgc
description: lsaBGC-Pan is a comprehensive workflow designed to explore the evolutionary landscape of biosynthetic gene clusters across microbial genomes. Use when user asks to identify orthologous biosynthetic gene clusters, construct species-level phylogenies, perform comparative genomic analyses, or automate the transition from raw predictions to consolidated evolutionary reports.
homepage: https://github.com/Kalan-Lab/lsaBGC-Pan
---


# lsabgc

## Overview

lsaBGC-Pan is a comprehensive workflow designed to explore the evolutionary landscape of biosynthetic gene clusters across a set of microbial genomes. It streamlines the process of identifying orthologous BGCs (referred to as "evolutionary GCFs"), constructing species-level phylogenies, and performing comparative genomic analyses like association testing and horizontal transfer inference. Use this skill to automate the transition from raw BGC predictions (antiSMASH/GECCO) to consolidated evolutionary reports for a specific genus or species.

## Installation

Install the suite via Bioconda:
```bash
conda install bioconda::lsabgc
```

## Core CLI Patterns

### 1. Standard antiSMASH Analysis
Use this when you have a directory containing antiSMASH results for your genomes.
```bash
lsaBGC-Pan -a AntiSMASH_Results/ -o Pan_Results/ -c 10
```

### 2. Joint antiSMASH and GECCO Analysis
Use this to increase BGC discovery (e.g., in Streptomyces) by combining antiSMASH results with GECCO predictions.
```bash
lsaBGC-Pan -a AntiSMASH_Results/ -o Pan_Results/ -c 10 -rg
```

### 3. GECCO-only Analysis (Bacteria Only)
Use this when starting from raw FASTA genomes without prior antiSMASH runs. Note: This does not work for fungi.
```bash
lsaBGC-Pan -g Directory_of_Genomes_in_FASTA/ -o Pan_Results/ -c 10
```

## Expert Tips and Best Practices

### Genome Scaling and Pre-processing
*   **Dataset Size**: The workflow is optimized for 4 to 200 genomes. If you have more than 200 genomes, use tools like `skDER`, `dRep`, or `PopPunk` to dereplicate or prune your dataset before running lsaBGC-Pan.
*   **Fungal Mode**: Always specify the `-f` flag when working with fungal genomes. This ensures the tool uses OrthoFinder instead of Panaroo and skips GECCO (which is bacteria-specific).

### Orthology Inference Selection
*   **Single Species**: Use Panaroo (default for bacteria) when your genomes belong to a single bacterial species.
*   **Multi-Species/Fungi**: Use OrthoFinder if your dataset spans multiple species or contains fungal genomes.

### Managing the Workflow Break
lsaBGC-Pan includes a recommended "break" after Step 5 to allow for manual parameter tuning:
*   **Step 6a**: Review the clustering results. If the GCFs are too broad or too granular, restart the workflow with adjusted inflation (`-ci`), Jaccard (`-cj`), or syntenic correlation (`-cr`) parameters.
*   **Step 6b**: Assess population designations against the species tree. You can provide a manual populations file (`-mpf`) if the automated core AAI cutoffs do not reflect the biological reality of your samples.
*   **Skip the Break**: If you are confident in default parameters or running in a headless pipeline, use the `--no-break` flag.

### Handling Fragmentation
lsaBGC-Pan is specifically designed to handle incomplete BGCs caused by assembly fragmentation. It attempts to resolve orthologous BGCs across genomes even when they are split across multiple contigs.

## Reference documentation
- [lsaBGC-Pan Repository](./references/github_com_Kalan-Lab_lsaBGC-Pan.md)
- [lsaBGC-Pan Wiki and Usage Guide](./references/github_com_Kalan-Lab_lsaBGC-Pan_wiki.md)