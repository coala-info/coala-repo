---
name: circlator
description: Circlator automates the circularization and start-position standardization of linear draft assembly contigs using corrected long reads. Use when user asks to circularize genome assemblies, fix the start position of circular contigs, or identify overlaps at contig ends.
homepage: https://github.com/sanger-pathogens/circlator
---


# circlator

## Overview

Circlator is a specialized bioinformatics pipeline that automates the process of turning linear draft assembly contigs into circularized sequences. It functions by mapping corrected long reads to the ends of contigs, performing a local re-assembly of those reads to identify overlaps, and merging the new assembly with the original. Beyond circularization, it provides tools to re-orient circular sequences so they begin at a biologically relevant start point, such as the dnaA gene or a user-defined sequence.

## Core Workflows

### 1. Environment Validation
Before running the pipeline, verify that all external dependencies (BWA, SAMtools, MUMmer, Prodigal, and an assembler like SPAdes or Canu) are correctly installed and accessible in your PATH.

```bash
circlator progcheck
```

### 2. Complete Circularization Pipeline
Run the full automated workflow using the `all` command. This executes mapping, re-assembly, merging, cleaning, and start-position fixing in a single call.

```bash
circlator all <assembly.fasta> <corrected_reads.fasta> <output_directory>
```

*   **Input**: Requires a genome assembly in FASTA format and **corrected** PacBio or Nanopore reads (FASTA or FASTQ).
*   **Output**: The primary result is `06.fixstart.fasta` (or similar numbered file depending on the stage) within the output directory.

### 3. Standardizing Start Positions
If you have an assembly that is already circularized but incorrectly oriented, use `fixstart` to reset the start position.

```bash
# First, download a reference dnaA file if needed
circlator get_dnaa dnaa_reference.fasta

# Fix the start position of circular contigs
circlator fixstart <input.fasta> <output_prefix>
```

*   **Logic**: If a dnaA gene is found, it becomes the new start. If not, the tool uses Prodigal to find the gene nearest the center of the contig to use as the start.
*   **Customization**: You can provide your own FASTA file of genes to search for using the `--genes_fa` flag.

### 4. Manual Step Execution
For troubleshooting or fine-grained control, run individual stages of the pipeline:

*   `mapreads`: Map reads to the assembly to identify contig ends.
*   `bam2reads`: Extract the reads that map to the ends for re-assembly.
*   `assemble`: Run the local assembly on the extracted reads.
*   `merge`: Integrate the new local assemblies with the original contigs.
*   `clean`: Remove small or redundant contigs that were fully contained within others.

## Best Practices and Tips

*   **Read Quality**: Circlator performs best with **corrected** long reads. Using raw, high-error-rate reads without prior correction (via tools like Canu or MECAT) often leads to failed circularization.
*   **Assembly Fragmentation**: The input assembly should not be overly fragmented. While Circlator can join contigs, its primary strength is closing the ends of nearly-complete chromosomes and plasmids.
*   **Assembler Choice**: By default, Circlator often looks for SPAdes. If using Canu or another assembler for the internal re-assembly step, ensure it is specified in the options if the default is not found.
*   **Troubleshooting**: If a contig fails to circularize, examine the log files in the output directory. Common reasons include insufficient read coverage at the contig ends or overlaps that are too short to be confidently assembled.

## Reference documentation

- [Circlator GitHub README](./references/github_com_sanger-pathogens_circlator.md)
- [Circlator Wiki](./references/github_com_sanger-pathogens_circlator_wiki.md)
- [Bioconda Circlator Package](./references/anaconda_org_channels_bioconda_packages_circlator_overview.md)