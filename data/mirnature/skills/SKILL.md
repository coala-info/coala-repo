---
name: mirnature
description: miRNAture is a computational pipeline for the bona fide annotation and structural validation of animal miRNAs in genomic sequences. Use when user asks to annotate miRNAs, perform structural validation of miRNA candidates, or identify miRNA precursors using homology and covariance models.
homepage: https://github.com/Bierinformatik/miRNAture
---


# mirnature

## Overview
miRNAture is a computational pipeline designed for the "bona fide" annotation of animal miRNAs. It bridges the gap between simple sequence similarity searches and complex structural validation. By integrating tools like BLAST, nhmmer, and the INFERNAL package, it identifies miRNA candidates and subjects them to rigorous structural evaluation—including minimum free energy (MFE) analysis and family-specific alignment via MIRfix. This ensures that identified sequences are not just sequence-similar, but structurally viable miRNA precursors.

## Installation and Environment
The most reliable way to use mirnature is via a dedicated Conda environment to manage its Perl and bioinformatics dependencies.

```bash
# Create and activate the environment
mamba create -n mirnature mirnature
conda activate mirnature
```

## Core Workflow and CLI Usage
To run the full pipeline, you must provide a target genome and a pre-calculated dataset containing the necessary HMMs and Covariance Models (CMs).

### Standard Execution Pattern
```bash
miRNAture -stage complete \
  -dataF <path_to_precalculated_data> \
  -speG <target_genome.fasta> \
  -speN <species_name> \
  -speT <species_tag> \
  -w <output_directory> \
  -m <mode> \
  -blastq <queries_folder>
```

### Key Parameters
- `-stage`: Use `complete` for the full pipeline (Homology + Validation + Annotation).
- `-dataF`: Path to the required pre-calculated dataset (HMMs/CMs). Version 1.1 recommends the curated miRBase v.22.1 dataset.
- `-speG`: The input DNA sequence (multi-fasta genome or contigs).
- `-speN` / `-speT`: Species name and a short tag used for naming output files.
- `-m`: Execution mode (e.g., search strategy).
- `-blastq`: Folder containing the query sequences for the initial BLAST search.

## Expert Tips and Best Practices
- **Dataset Selection**: Always use the latest pre-calculated dataset (compatible with v1.1) to ensure you are searching against the most current curated metazoan miRNA families.
- **Structural Validation**: If you have existing miRNA candidates from small RNA-seq, you can use mirnature's evaluation stages to perform structural sanity checks and correct mature sequence positions.
- **Output Interpretation**:
    - Check `miRNAture_summary_*.txt` first for a high-level overview of detected families.
    - Use the `Final_miRNA_evaluation/Tables/` directory for detailed evidence supporting each individual candidate.
    - The GFF3 and BED files are ready for immediate upload to genome browsers like IGV or UCSC.
- **Performance**: For large genomes, ensure your environment has sufficient memory for the INFERNAL (cmsearch) stage, which is computationally intensive compared to the initial BLAST/nhmmer passes.

## Reference documentation
- [miRNAture GitHub Repository](./references/github_com_Bierinformatik_miRNAture.md)
- [Bioconda mirnature Package Overview](./references/anaconda_org_channels_bioconda_packages_mirnature_overview.md)