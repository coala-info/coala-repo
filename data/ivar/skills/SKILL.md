---
name: ivar
description: The `ivar` skill provides procedural knowledge for analyzing viral genomic data, specifically optimized for amplicon-based sequencing (like PrimalSeq).
homepage: https://andersen-lab.github.io/ivar/html/
---

# ivar

## Overview
The `ivar` skill provides procedural knowledge for analyzing viral genomic data, specifically optimized for amplicon-based sequencing (like PrimalSeq). It transforms raw alignments into high-quality variants and consensus genomes by accounting for primer interference and sequencing artifacts common in viral studies.

## Core Workflows

### 1. Primer Trimming and Quality Filtering
Use `ivar trim` to remove primer sequences (based on a BED file) and perform quality-based soft-clipping.
- **Standard Pattern**: `ivar trim -i input.sorted.bam -b primers.bed -p output_prefix -q 20 -m 30`
- **Key Parameters**:
    - `-b`: BED file containing primer positions.
    - `-q`: Minimum quality threshold (sliding window).
    - `-m`: Minimum length to retain a read after trimming.
    - `-e`: (Optional) Include reads that do not overlap with any primers.

### 2. Variant Calling
iVar identifies SNVs and indels by processing the output of `samtools mpileup`.
- **Standard Pattern**: 
  ```bash
  samtools mpileup -aa -A -d 0 -B -Q 0 --reference ref.fa input.bam | ivar variants -p output_prefix -r ref.fa -g annotations.gff
  ```
- **Best Practices**:
    - Always use the `-B` flag in `samtools mpileup` to disable BAQ, as iVar handles quality scores internally.
    - Provide a GFF3 file (`-g`) to enable amino acid translation of identified variants.
    - Adjust `-t` (frequency threshold, default 0.03) for low-frequency variant detection.

### 3. Consensus Generation
Generate a consensus sequence from an aligned BAM file.
- **Standard Pattern**:
  ```bash
  samtools mpileup -aa -A -d 0 -B -Q 0 input.bam | ivar consensus -p output_prefix -n N -t 0.5
  ```
- **Key Parameters**:
    - `-t`: Threshold for calling a base (e.g., 0.5 for majority rule).
    - `-m`: Minimum depth to call a base; positions below this will be filled with the character specified by `-n` (usually 'N').

### 4. Multi-step Pipeline (One-liner)
For efficient processing from alignment to consensus:
```bash
bwa mem ref.fa R1.fq R2.fq | ivar trim -b primers.bed | samtools sort - | samtools mpileup -aa -A -Q 0 -d 0 - | ivar consensus -p consensus_out
```

## Expert Tips
- **Sorting Requirement**: Input BAM files for `ivar trim` must be sorted. Use `samtools sort` before trimming.
- **GFF3 Format**: Ensure GFF files contain "ID" attributes in the attributes column for proper amino acid mapping.
- **RNA Polymerase Slippage**: For viruses like Ebola, add `EditPosition` and `EditSequence` to the GFF attributes to help iVar maintain the correct open reading frame during translation.
- **Variant Filtering**: Use `ivar filtervariants` to find the intersection of variants across multiple replicates to reduce false positives.

## Reference documentation
- [iVar Manual](./references/andersen-lab_github_io_ivar_html_manualpage.html.md)
- [iVar Cookbook](./references/andersen-lab_github_io_ivar_html_cookbookpage.html.md)
- [iVar Installation](./references/andersen-lab_github_io_ivar_html_installpage.html.md)