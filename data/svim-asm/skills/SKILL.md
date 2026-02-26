---
name: svim-asm
description: svim-asm detects large structural variants by comparing assembled genomic contigs to a reference genome. Use when user asks to call structural variants from assemblies, identify genomic rearrangements like deletions or inversions, or process assembly-to-reference alignments.
homepage: https://github.com/eldariont/svim-asm
---


# svim-asm

## Overview
`svim-asm` is a specialized tool for detecting large genomic rearrangements (typically >50bp) by comparing assembled contigs to a reference genome. It identifies five major variant classes: deletions, insertions, tandem duplications, interspersed duplications, and inversions. Unlike the original SVIM tool which handles raw reads, `svim-asm` is optimized for high-quality assembly-to-reference alignments.

## Installation
The recommended installation method is via Conda:
```bash
conda create -n svimasm_env --channel bioconda svim-asm
```

## Core Workflow

### 1. Alignment (minimap2)
`svim-asm` requires specific alignment flags to function correctly. You must use the `--cs` flag to generate the difference string.
*   **Haploid/Single Assembly:**
    ```bash
    minimap2 -a -x asm5 --cs -r2k -t <threads> <reference.fa> <query.fasta> > alignments.sam
    ```
*   **Diploid (Two Haplotypes):** Align each haplotype separately to the same reference.

### 2. Post-processing (samtools)
Alignments must be sorted and indexed before running `svim-asm`.
```bash
samtools sort -m4G -@4 -o alignments.sorted.bam alignments.sam
samtools index alignments.sorted.bam
```

### 3. Variant Calling
*   **Haploid Mode:**
    ```bash
    svim-asm haploid <working_dir> <alignments.sorted.bam> <reference.fa>
    ```
*   **Diploid Mode:**
    ```bash
    svim-asm diploid <working_dir> <hap1.sorted.bam> <hap2.sorted.bam> <reference.fa>
    ```

## CLI Best Practices and Tips

*   **Output Files:** The tool generates `variants.vcf` in the specified working directory. It also produces a histogram of SV lengths (`sv-lengths.png`) which is useful for initial QC.
*   **Tandem Duplications:** In the VCF output, tandem duplications include a `FORMAT:CN` tag indicating the estimated copy number.
*   **Memory Management:** If working with very large genomes, ensure you are using version 1.0.1 or later, as memory consumption was substantially reduced in these versions.
*   **Partitioning:** The default `partition_max_distance` is 1kb. If you are dealing with highly complex regions, you can adjust this via the command line (available in v1.0.2+).
*   **Translocations:** Version 1.0.0+ supports the genotyping of translocation breakpoints (BNDs).

## Common Pitfalls
*   **Missing --cs:** If you forget the `--cs` flag during `minimap2` alignment, `svim-asm` will not be able to identify variants correctly.
*   **Raw Reads:** Do not use `svim-asm` for raw PacBio or Oxford Nanopore reads; use the original `SVIM` tool instead.
*   **Index Files:** Ensure the `.bai` index files are in the same directory as your BAM files; the tool checks for their existence at startup.

## Reference documentation
- [GitHub Repository: eldariont/svim-asm](./references/github_com_eldariont_svim-asm.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_svim-asm_overview.md)