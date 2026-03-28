---
name: svim-asm
description: SVIM-asm identifies structural variants larger than 50bp by comparing genome assemblies to a reference. Use when user asks to detect genomic rearrangements from haploid or diploid assemblies, identify insertions and deletions between genomes, or characterize inversions and duplications using assembly-to-reference alignments.
homepage: https://github.com/eldariont/svim-asm
---

# svim-asm

## Overview

SVIM-asm is a specialized tool for identifying structural variants (SVs) larger than 50bp by comparing genome assemblies. Unlike tools designed for raw sequencing reads, SVIM-asm is optimized for genome-to-genome alignments. It is particularly useful for high-quality de novo assemblies where you want to characterize genomic rearrangements, insertions, deletions, and inversions against a reference. It supports both haploid and diploid (two-haplotype) inputs and is significantly faster than read-based callers.

## Execution Workflows

### 1. Alignment Preparation (Recommended)
Before running SVIM-asm, generate sorted and indexed BAM files using `minimap2`. Use the `-x asm5` preset for closely related assemblies (e.g., same species) or `asm10`/`asm20` for more divergent ones.

```bash
# Align assembly to reference
minimap2 -a -x asm5 --cs -r2k -t <threads> <ref.fa> <query.fasta> > alignments.sam

# Sort and index
samtools sort -m4G -@4 -o alignments.sorted.bam alignments.sam
samtools index alignments.sorted.bam
```

### 2. Haploid SV Calling
Use the `haploid` command when comparing a single assembly (or a single haplotype) to a reference.

```bash
svim-asm haploid <working_dir> <alignments.sorted.bam> <reference.fa>
```

### 3. Diploid SV Calling
Use the `diploid` command when you have two separate haplotype assemblies for the same individual. This allows for accurate genotyping of variants across both haplotypes.

```bash
svim-asm diploid <working_dir> <hap1.sorted.bam> <hap2.sorted.bam> <reference.fa>
```

## Expert Tips and Best Practices

- **Input Requirements**: Ensure the BAM file is sorted and indexed. The `--cs` flag in `minimap2` is highly recommended as it provides the long-form cigar string information that SVIM-asm uses for precise breakpoint detection.
- **Variant Classes**: SVIM-asm detects five primary classes:
  - Deletions
  - Insertions
  - Tandem Duplications
  - Interspersed Duplications
  - Inversions
- **Translocations**: As of v1.0.0, the tool supports genotyping of translocation breakpoints (represented as BNDs in the VCF).
- **Output Files**:
  - `variants.vcf`: The primary output containing detected SVs.
  - `sv-lengths.png`: A useful diagnostic plot showing the size distribution of detected variants.
- **Memory Management**: If working with very large genomes, ensure you are using v1.0.1 or later, which significantly reduced memory consumption.
- **Duplication Handling**: If you prefer duplications to be represented as insertions in the VCF, check the command-line help for specific flags added in v0.1.1.



## Subcommands

| Command | Description |
|---------|-------------|
| svim-asm diploid | SVIM-ASM is a tool for structural variant detection in diploid genomes. |
| svim-asm haploid | SVIM-ASM is a tool for structural variant detection in assemblies. This is the haploid mode. |

## Reference documentation

- [SVIM-asm GitHub README](./references/github_com_eldariont_svim-asm_blob_master_README.rst.md)
- [SVIM-asm Overview and Background](./references/github_com_eldariont_svim-asm.md)