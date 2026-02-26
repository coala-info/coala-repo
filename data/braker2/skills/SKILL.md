---
name: braker2
description: "BRAKER2 is an automated pipeline for the structural annotation of eukaryotic genomes using GeneMark-EX and AUGUSTUS. Use when user asks to annotate a genome assembly, predict gene structures using RNA-Seq or protein evidence, or train gene prediction models for non-model organisms."
homepage: https://github.com/Gaius-Augustus/BRAKER
---


# braker2

## Overview

BRAKER2 is a bioinformatics pipeline designed to automate the structural annotation of eukaryotic genomes. It orchestrates the training and execution of GeneMark-EX and AUGUSTUS, eliminating the need for manually curated training sets. By integrating extrinsic evidence—specifically RNA-Seq alignments (BAM files) or protein sequences from related species—BRAKER2 generates high-accuracy gene predictions even for non-model organisms. It is the standard tool for researchers moving from a raw genome assembly to a functional annotation.

## Core CLI Patterns

The primary interface for the pipeline is the `braker.pl` script.

### 1. RNA-Seq Mode
Use this when you have high-quality transcriptomic data mapped to your genome.
```bash
braker.pl --genome=genome.fa --bam=RNAseq.bam --softmasking --threads=8
```

### 2. Protein Homology Mode
Use this when RNA-Seq is unavailable, utilizing protein sequences from related species (e.g., OrthoDB).
```bash
braker.pl --genome=genome.fa --prot_seq=proteins.fa --softmasking --threads=8
```

### 3. Combined Mode (RNA-Seq + Protein)
The most robust mode, leveraging both types of extrinsic evidence.
```bash
braker.pl --genome=genome.fa --bam=RNAseq.bam --prot_seq=proteins.fa --softmasking --threads=8
```

### 4. Fungal Genomes
Fungal gene structures (shorter introns, different signal distributions) require a specific flag for GeneMark-ES.
```bash
braker.pl --genome=genome.fa --bam=RNAseq.bam --fungus --softmasking
```

## Expert Tips and Best Practices

### Genome Preparation
*   **Scaffold Names**: Ensure scaffold/contig names in your FASTA are simple (e.g., `>Chr1` or `>scaffold_10`). Avoid special characters like `%`, `&`, or long descriptions with spaces, as these often break the downstream GeneMark or AUGUSTUS parsers.
*   **Softmasking**: Always prefer softmasking (repeats in lowercase) over hardmasking (repeats as `N`). BRAKER2 uses the `--softmasking` flag to allow gene predictors to "see" through repeats while still penalizing them, which prevents truncated gene models.
*   **Assembly Quality**: Avoid including thousands of very short scaffolds (e.g., <1000bp). They increase runtime significantly without improving the training model.

### Execution Control
*   **Resuming Jobs**: If a run fails, use `--useexisting`. BRAKER2 will attempt to skip steps that have already produced valid output files in the working directory.
*   **Alternative Alignment**: If you have already generated hints (e.g., from a different aligner), you can provide them directly using `--hints=hints.gff`.
*   **UTR Prediction**: To predict Untranslated Regions (UTRs), use `--UTR=on`. Note that this requires high-quality, high-coverage RNA-Seq data.

### Common Options
*   `--threads=INT`: Parallelize the AUGUSTUS and GeneMark runs.
*   `--species=NAME`: Specify a species name to save the trained AUGUSTUS parameters for future use.
*   `--busco_lineage`: Use a specific BUSCO lineage to evaluate or guide the training process.

## Reference documentation
- [BRAKER GitHub Repository](./references/github_com_Gaius-Augustus_BRAKER.md)
- [BRAKER Wiki](./references/github_com_Gaius-Augustus_BRAKER_wiki.md)
- [Bioconda BRAKER2 Package](./references/anaconda_org_channels_bioconda_packages_braker2_overview.md)