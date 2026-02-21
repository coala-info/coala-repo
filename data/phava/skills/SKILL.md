---
name: phava
description: PhaVa (Phase Variation) is a specialized bioinformatics tool designed to identify "invertons"—genomic segments flanked by inverted repeats that can flip their orientation.
homepage: https://github.com/patrickwest/PhaVa
---

# phava

## Overview
PhaVa (Phase Variation) is a specialized bioinformatics tool designed to identify "invertons"—genomic segments flanked by inverted repeats that can flip their orientation. This process, known as phase variation, is common in bacterial genomes for regulating gene expression. The tool works by identifying potential inverted repeats in a reference genome and then using long-read sequencing data (e.g., Oxford Nanopore or PacBio) to quantify the frequency of the inverted state relative to the original reference.

## Installation and Testing
Install PhaVa via bioconda:
```bash
conda install phava -c bioconda -c conda-forge
```

Verify the installation with the built-in test suite:
```bash
phava test
```

## Core Workflows

### The Three-Step Manual Workflow
For maximum control or when processing multiple read sets against the same reference, use the modular commands. All steps must share the same output directory (`-d`).

1.  **Locate**: Identify potential inverted repeats (IRs) in the reference.
    ```bash
    phava locate -i reference.fasta -d output_dir
    ```
2.  **Create**: Generate the inverted versions of the identified regions.
    ```bash
    phava create -i reference.fasta -d output_dir
    ```
3.  **Ratio**: Map long reads to the original and inverted references to calculate inversion frequency.
    ```bash
    phava ratio -r reads.fastq -d output_dir
    ```

### The Automated Workflow
To run the entire pipeline (locate, create, and ratio) in a single command:
```bash
phava variation_wf -i reference.fasta -r reads.fastq -d output_dir
```

## Expert Tips and Best Practices

### Gene Annotation Integration
To determine if an inversion affects specific genes, provide a gene annotation file (GFF format) during the `create` or `variation_wf` step. It is recommended to use Prodigal for generating these annotations.
```bash
# Example using Prodigal and PhaVa
prodigal -i genome.fasta -f gff -o genome.gff
phava create -i genome.fasta --genes genome.gff --genesFormat gff -d output_dir
```

### Recommended Filtering
PhaVa identifies any inverton with at least one reverse-oriented read. For high-confidence results, apply the following filters to the output TSV files:
*   **Minimum Reverse Read Count**: $\ge 3$ reads.
*   **Minimum Inversion Percentage**: $\ge 3\%$ of total reads.

### Efficiency for Multiple Samples
The `locate` and `create` steps are reference-dependent but read-independent. If you have multiple sequencing datasets for the same organism:
1.  Run `locate` and `create` once.
2.  Run `ratio` separately for each `.fastq` file using the same `-d` directory.

## Reference documentation
- [PhaVa GitHub Repository](./references/github_com_patrickwest_PhaVa.md)
- [Bioconda PhaVa Overview](./references/anaconda_org_channels_bioconda_packages_phava_overview.md)