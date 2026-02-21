---
name: drep
description: dRep is a specialized tool for the de-replication of microbial genomes.
homepage: https://github.com/MrOlm/drep
---

# drep

## Overview
dRep is a specialized tool for the de-replication of microbial genomes. It streamlines the process of grouping similar genomes (clustering) and selecting a single "best" representative for each group based on assembly quality metrics like completeness and contamination. It utilizes a two-step clustering approach: a rapid primary clustering using Mash, followed by a high-resolution secondary clustering using algorithms like ANIm or fastANI.

## Core Workflows

### 1. Dependency Verification
Before running analysis, ensure all genomic alignment and quality assessment tools are available:
```bash
dRep check_dependencies
```

### 2. Genome Comparison
Use this to visualize the relationship between genomes without performing de-replication:
```bash
dRep compare output_directory -g path/to/genomes/*.fasta
```

### 3. Full De-replication
This is the standard workflow to identify clusters and select representative genomes:
```bash
dRep dereplicate output_directory -g path/to/genomes/*.fasta
```

## CLI Best Practices and Tips

### Resource Management
*   **Parallelization**: Use the `-p` flag to specify the number of processors. dRep is highly parallelizable, especially during the secondary clustering phase.
*   **Memory Constraints**: If working with thousands of genomes and encountering memory errors during Mash, use the `--low_ram_primary_clustering` flag.

### Quality-Based Selection
*   **CheckM Integration**: dRep can automatically run CheckM to determine genome quality. Ensure CheckM is in your path or provide pre-computed results using `--genomeInfo`.
*   **Scoring Criteria**: By default, dRep scores genomes based on: `completeness - 5*contamination + 0.5*log10(N50) + 0.5*log10(size) + 0.1*centrality`. You can customize these weights using the `-conW`, `-compW`, etc., flags.

### Clustering Thresholds
*   **Secondary Clustering**: The default Average Nucleotide Identity (ANI) threshold for secondary clustering is 99% (`-sa 0.99`). Adjust this based on your definition of a "strain" or "species" (e.g., 0.95 for species-level de-replication).
*   **Algorithm Choice**: Use `--S_algorithm` to switch between `ANIm` (default, accurate but slower) and `fastANI` (faster for very large datasets).

### Handling Large Datasets
*   If the process stalls on large genome sets, check the `dRep.log` file in the output directory for specific alignment failures.
*   Ensure your input genome files have unique names, as dRep uses filenames as the primary identifiers.

## Reference documentation
- [drep - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_drep_overview.md)
- [GitHub - MrOlm/drep: Rapid comparison and dereplication of genomes](./references/github_com_MrOlm_drep.md)