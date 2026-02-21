---
name: pilon
description: Pilon is a powerful automated tool designed to polish draft genome assemblies and identify genomic variations.
homepage: https://github.com/broadinstitute/pilon/
---

# pilon

## Overview
Pilon is a powerful automated tool designed to polish draft genome assemblies and identify genomic variations. It works by analyzing the inconsistencies between a provided reference FASTA and the evidence provided by aligned sequencing reads (BAM files). Pilon is particularly effective at correcting small-scale errors like single-base differences and small indels, as well as larger events like gap filling and resolving local misassemblies.

## Usage Guidelines

### Core Requirements
To run Pilon, you must provide:
1.  **Input Genome**: A FASTA file of the assembly to be improved.
2.  **Aligned Reads**: One or more BAM files containing reads aligned to the input FASTA. BAM files must be sorted and indexed (using `samtools sort` and `samtools index`).

### Basic Command Pattern
Pilon is a Java-based tool. The standard execution follows this pattern:
```bash
java -Xmx16G -jar pilon.jar --genome genome.fasta --bam alignments.bam --output output_prefix
```
*Note: Adjust `-Xmx` based on your genome size and available RAM; memory exhaustion is a common issue for large genomes.*

### Common CLI Parameters
*   `--genome`: The input FASTA file to be polished.
*   `--bam`: The input BAM file(s). You can specify multiple BAM files or use different flags for different library types.
*   `--output`: Prefix for all output files (e.g., `polished_assembly`).
*   `--vcf`: Generate a VCF file containing the detected variants.
*   `--changes`: Generate a text file listing every change made to the assembly.
*   `--tracks`: Generate coordinate-sorted tracks (e.g., .bed, .wig) for visualization in IGV or GenomeView.
*   `--fix`: Specify which types of errors to fix. Options include `snps`, `indels`, `gaps`, `local`, or `all` (default).

### Handling Different Read Types
Pilon can utilize various sequencing technologies:
*   **Illumina Fragments**: Use `--frags alignments.bam` for paired-end reads with small inserts.
*   **Illumina Jumps**: Use `--jumps alignments.bam` for mate-pair libraries.
*   **Unpaired Reads**: Use `--unpaired alignments.bam`.
*   **Long Reads**: Use `--pacbio alignments.bam` or `--nanopore alignments.bam` (or the experimental `--ont` flag) to provide evidence for long-read polishing.

## Expert Tips and Best Practices

### Memory Management
Pilon is memory-intensive. If you encounter `java.lang.OutOfMemoryError`, increase the heap size using the `-Xmx` flag. For large genomes (e.g., human or large plants), you may need 64GB or more.

### Iterative Polishing
It is often beneficial to run Pilon in multiple rounds. After the first run, re-align your reads to the newly generated `output_prefix.fasta` and run Pilon again. Stop when the number of changes reported in the `--changes` file plateaus.

### Fixing Specific Issues
If you only want to fill gaps without changing the consensus sequence, use `--fix gaps`. Conversely, if you trust your assembly's structure but want to fix base-calling errors, use `--fix snps,indels`.

### Large Collapsed Regions
Pay attention to the standard output. Pilon reports "Large collapsed regions," which often indicate repetitive sequences that are under-represented in the assembly. These areas may require manual inspection or different assembly strategies.

## Reference documentation
- [Home · broadinstitute/pilon Wiki](./references/github_com_broadinstitute_pilon_wiki.md)
- [pilon - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pilon_overview.md)
- [Commits · broadinstitute/pilon](./references/github_com_broadinstitute_pilon_commits_master.md)