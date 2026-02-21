---
name: homopolish
description: Homopolish is a specialized bioinformatics tool designed to push genome assembly quality to >Q50 (99.999% accuracy) for viruses, bacteria, and fungi.
homepage: https://github.com/ythuang0522/homopolish
---

# homopolish

## Overview

Homopolish is a specialized bioinformatics tool designed to push genome assembly quality to >Q50 (99.999% accuracy) for viruses, bacteria, and fungi. It addresses the systematic errors inherent in Oxford Nanopore (ONT) and PacBio CLR sequencing by retrieving homologs from closely-related genomes and applying a Support Vector Machine (SVM) for correction. 

For Nanopore data, Homopolish is intended as a final polishing step after initial polishing with tools like Racon and Medaka. For PacBio CLR, it can be applied directly to assemblies produced by Flye.

## Installation and Setup

Homopolish is best managed via Conda or Mamba to handle its dependencies (such as `mash` and `minimap2`).

```bash
# Recommended installation via Mamba
mamba create -n homopolish -c conda-forge -c bioconda -c defaults python=3.8.16 homopolish=0.4.1
conda activate homopolish
```

### Required Resources
Before polishing, you must download the pre-trained models and the appropriate Mash sketches for your organism type.

1.  **Models**: Ensure you have the correct `.pkl` file for your sequencing technology:
    *   `R9.4.pkl`: For Nanopore R9.4 flowcells.
    *   `R10.3.pkl`: For Nanopore R10.3 flowcells.
    *   `pb.pkl`: For PacBio CLR.
2.  **Sketches**: Download and unzip the relevant Mash sketch (Bacteria, Virus, or Fungi) from the official repository links.

## Command Line Usage

### Standard Homopolymer Polishing
Use the `polish` module to correct indel errors. This is the most common use case.

```bash
# Basic command structure
homopolish polish -a draft_assembly.fasta -s bacteria.msh -m R9.4.pkl -o output_dir
```

**Key Arguments:**
*   `-a`: Path to the draft assembly (FASTA).
*   `-s`: Path to the unzipped Mash sketch file.
*   `-m`: Path to the pre-trained SVM model (.pkl).
*   `-o`: Output directory name.
*   `-t`: Number of threads (default is 1; increase for speed).

### Polishing with Local Genomes
If you have specific, high-quality private genomes that are more closely related to your sample than those in the public sketches, use the `-l` flag.

```bash
homopolish polish -a draft_assembly.fasta -l path_to_local_db.fasta -m R9.4.pkl -o output_dir
```

### Correcting Modification-Mediated Errors
Use the `modpolish` module if you have the original ONT reads and suspect errors caused by base modifications.

```bash
# Using FASTQ reads
homopolish modpolish -a draft_assembly.fasta -q reads.fastq -m R9.4.pkl -s bacteria.msh -o output_dir

# Using an existing BAM alignment (faster)
homopolish modpolish -a draft_assembly.fasta -b alignment.bam -m R9.4.pkl -s bacteria.msh -o output_dir
```

## Expert Tips and Best Practices

*   **Workflow Integration**: For ONT, always run `Racon` (usually 4 rounds) followed by `Medaka` before running `Homopolish`. Homopolish is designed to fix the specific residual errors these tools leave behind.
*   **Avoid the Genus Flag**: While `-g` (genus name) is available, it is generally **not recommended**. The automatic search via `-s` (sketch) is more robust as it identifies the most closely-related strains regardless of taxonomic labels.
*   **Memory Management**: Mash sketches for bacteria are large (~3.3GB). Ensure your environment has sufficient RAM to load the sketch into memory during the homolog retrieval phase.
*   **Output Files**: The primary result is named `[input_name]_homopolished.fasta` (or `_modpolished.fasta`). Check the output directory for debug logs if the polishing doesn't significantly change the assembly size or quality.

## Reference documentation
- [Homopolish GitHub Repository](./references/github_com_ythuang0522_homopolish.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_homopolish_overview.md)