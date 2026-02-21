---
name: proksee
description: Proksee is a specialized toolkit designed for the assembly and evaluation of microbial genomes.
homepage: https://github.com/proksee-project/proksee-cmd
---

# proksee

## Overview

Proksee is a specialized toolkit designed for the assembly and evaluation of microbial genomes. It provides an automated pipeline that moves from raw sequencing data to refined assemblies through a three-stage process: pre-assembly (filtering and estimation), fast assembly (initial metrics), and expert assembly (high-quality refinement). Use this skill to execute genomic workflows, manage the required reference databases, and generate quality reports for microbial contigs.

## Core Commands

### Database Management
Before running assembly workflows, you must initialize the Mash sketch database used for species estimation.
```bash
proksee updatedb
```

### Genome Assembly
The `assemble` command handles read filtering, assembly, and basic annotation. It supports both paired-end and single-end reads.

**Paired-end reads:**
```bash
proksee assemble -o <output_directory> <FORWARD_FASTQ> <REVERSE_FASTQ>
```

**Single-end reads:**
```bash
proksee assemble -o <output_directory> <FORWARD_FASTQ>
```

### Assembly Evaluation
To assess the quality of an existing assembly (FASTA format) using metrics like N50, contig count, and k-mer multiplicity:
```bash
proksee evaluate -o <output_directory> <CONTIGS_FASTA>
```

## Expert Tips and Best Practices

- **Output Management**: The `-o` (output directory) argument is mandatory for both `assemble` and `evaluate` commands. Proksee will create this directory if it does not exist.
- **Resource Parallelization**: Recent versions of Proksee support parallelization for Mash. Ensure your environment has sufficient threads allocated if processing large datasets or multiple assemblies.
- **Minimum Contig Size**: When evaluating assemblies, Proksee passes user-specified minimum contig sizes to QUAST. Use this to filter out small, uninformative contigs (e.g., <500bp) from your final statistics.
- **Species Estimation**: Proksee uses Mash to estimate information about the reads before assembly. If the species estimation seems incorrect, verify that `proksee updatedb` was run recently to ensure the sketch database is current.
- **Assembly Stages**:
    - **Stage 1 (Pre-Assembly)**: Uses `fastp` for read trimming and `Mash` for estimation.
    - **Stage 2 (Fast Assembly)**: Uses `Skesa` for a rapid initial look at the genome.
    - **Stage 3 (Expert Assembly)**: Uses `SPAdes` for the final high-quality output.

## Reference documentation
- [Proksee Command Line Tools Overview](./references/github_com_proksee-project_proksee-cmd.md)
- [Proksee Bioconda Package](./references/anaconda_org_channels_bioconda_packages_proksee_overview.md)