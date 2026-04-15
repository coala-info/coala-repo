---
name: shapemapper
description: ShapeMapper automates the processing of raw sequencing data into RNA reactivity profiles by identifying chemical adducts through mutational profiling. Use when user asks to process SHAPE-MaP or DMS-MaP data, calculate RNA chemical probing reactivities, or align mutational profiling reads to a reference sequence.
homepage: https://github.com/Weeks-UNC/shapemapper2
metadata:
  docker_image: "quay.io/biocontainers/shapemapper:1.2--py27_0"
---

# shapemapper

## Overview
ShapeMapper 2 is a specialized bioinformatics pipeline designed for Mutational Profiling (MaP) experiments. It automates the complex workflow of converting raw sequencing data into structural information by identifying chemical adducts (detected as internal mutations during reverse transcription). It handles read trimming, merging, alignment, and statistical normalization to produce reactivity profiles that indicate the conformational flexibility of each nucleotide in an RNA molecule.

## Core Command Line Usage

The basic syntax for a standard SHAPE-MaP experiment requires three experimental samples and a reference sequence:

```bash
shapemapper --target target_sequences.fa \
            --modified --R1 mod_R1.fastq --R2 mod_R2.fastq \
            --untreated --R1 unt_R1.fastq --R2 unt_R2.fastq \
            --denatured --R1 den_R1.fastq --R2 den_R2.fastq \
            --name experiment_prefix
```

### Input Sample Types
*   `--modified`: RNA treated with a SHAPE or DMS reagent.
*   `--untreated` (or `--unmodified`): Control RNA treated with DMSO or solvent only. Used to subtract background noise.
*   `--denatured`: Control RNA modified under denaturing conditions. Used to account for local sequence-dependent mutation rate variations.

### Common Parameters
*   `--target`: FASTA file containing DNA sequences (use 'T', not 'U').
*   `--dms`: Enables DMS-specific mode. Optimizes normalization for DMS-MaP data (typically collected using Marathon or TGIRT enzymes).
*   `--name`: Prefixes all output files. Essential for organizing multiple runs in the same directory.
*   `--out`: Specifies the output folder (default: `shapemapper_out`).

## Advanced Workflows and Best Practices

### Handling Primers and Amplicons
If using directed primers rather than random hexamers, you must account for primer-binding sites to avoid biased reactivity data.
*   **FASTA Masking**: Use lowercase characters in your `--target` FASTA file to indicate primer-binding regions. ShapeMapper will exclude these positions from the final reactivity profile.
*   **Amplicon Mode**: Use `--amplicon` to require reads to align near expected primer locations.
*   **Multiple Primers**: If using multiple primer pairs, provide a primer file:
    ```bash
    shapemapper --target target.fa --amplicon --primers primers.txt ...
    ```
    *The `primers.txt` format: Forward_Sequence Reverse_Sequence (one pair per line).*

### Alignment Optimization
*   **Large Sequences**: For RNAs longer than 3,000–4,000 nucleotides, use `--star-aligner` instead of the default Bowtie2 for better performance.
*   **Sequence Correction**: If the experimental RNA sequence might differ from the reference (e.g., SNPs or mutations), use `--correct-seq` with the untreated sample to identify and update the reference sequence before reactivity calculation.

### Quality Control and Troubleshooting
*   **Random Primers**: If using random primers, set `--random-primer-len <n>` (usually 6). This excludes mutations within `n+1` nucleotides of the 3' end of a read to prevent artifacts.
*   **Log Files**: Always check `<name>_shapemapper_log.txt` for heuristic quality control checks, which flag issues like low read depth or high background mutation rates.
*   **STAR Segfaults**: If STAR fails on WSL2 or specific HPC environments, try the `--rerun-on-star-segfault` flag.

## Reference documentation
- [ShapeMapper 2 Main Repository](./references/github_com_Weeks-UNC_shapemapper2.md)