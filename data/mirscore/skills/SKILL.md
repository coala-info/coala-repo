---
name: mirscore
description: miRScore distinguishes high-confidence microRNA loci from other small RNA-producing regions by analyzing structural features and quantitative expression data. Use when user asks to validate novel miRNA annotations, score miRNA candidates based on secondary structure, or execute the miRScore pipeline for plant and animal small RNA-seq data.
homepage: https://github.com/Aez35/miRScore
---


# mirscore

## Overview
miRScore is a specialized bioinformatics tool used to distinguish high-confidence microRNA loci from other small RNA-producing regions. It automates the validation of novel miRNA annotations by analyzing structural features—such as miRNA/miRNA* duplex mismatches, asymmetric bulges, and 3' overhangs—alongside quantitative expression data from small RNA-seq libraries. Use this skill to prepare FASTA/FASTQ inputs, execute the scoring pipeline, and interpret the pass/fail results for plant or animal miRNA candidates.

## Installation
The recommended method is via Bioconda:
```bash
conda install bioconda::mirscore
```

## Core Usage
The basic command requires mature sequences, hairpin precursors, and small RNA-seq data:

```bash
miRScore -mature mature.fa -hairpin hairpin.fa -fastq *.fastq -kingdom plant
```

### Required Arguments
- `-mature`: FASTA file containing mature and star sequences.
- `-hairpin`: FASTA file containing hairpin precursor sequences.
- `-fastq`: List of small RNA-seq libraries (FASTQ/FASTA, can be compressed).
- `-kingdom`: Specify `plant` or `animal` to apply the correct biological criteria.

### Key Options
- `-autotrim`: Automatically trim adapters using `cutadapt`.
- `-trimkey`: Provide a specific adapter sequence for trimming (defaults: `ATH-miR166a` for plants, `HSA-let-7a` for animals).
- `-mm`: Allow up to 1 mismatch in sRNA-seq read mapping (default is 0).
- `-rescue`: Reevaluate failed miRNAs to see if an alternative duplex at the same locus meets all criteria.
- `-out`: Specify the output directory (default: `miRScore_output/`).

## Expert Tips and Best Practices

### Input Preparation
- **Identifier Matching**: The sequence identifier (header) in the `-mature` FASTA must match the identifier in the `-hairpin` FASTA (e.g., `>miR-1` in both). This matching is case-insensitive.
- **Library Strategy**: Avoid using merged libraries if individual replicates are available. miRScore requires at least 10 exact reads in a *single* library to pass the expression threshold; merging can obscure library-specific confidence.
- **Database Formatting**: When using sequences from miRBase or MirGeneDB, ensure the naming schemes are consistent between mature and hairpin files, as these databases often use different suffixes (e.g., `-5p`/`-3p`) that may need manual alignment.

### Validation Criteria
miRScore evaluates candidates based on the following thresholds:
- **Duplex Structure**: < 5 mismatches, <= 3nt in asymmetric bulges, and a 2nt 3' overhang.
- **Secondary Structure**: No secondary stems or large loops in the duplex region.
- **Length**: 20–24nt for plants; 20–26nt for animals.
- **Read Distribution**: At least 75% of reads mapping to the hairpin must originate from the miRNA duplex.
- **Abundance**: At least 10 exact reads must map to the duplex in at least one library.

### Troubleshooting Outputs
- **miRScore_Results.csv**: This is the primary output. Check the "Result" column for Pass/Fail status.
- **Structural Visualization**: miRScore generates secondary structure plots. Review these for candidates that fail due to "secondary stems" to see if the hairpin folding is biologically plausible.

## Reference documentation
- [miRScore GitHub Repository](./references/github_com_Aez35_miRScore.md)
- [miRScore Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mirscore_overview.md)