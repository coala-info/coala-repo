---
name: leviosam
description: LevioSAM translates sequence alignments between different genomic coordinate systems while preserving alignment metadata. Use when user asks to lift over alignments between assemblies, translate coordinates from a variant-aware reference to a standard reference, or update BAM files using VCF or Chain files.
homepage: https://github.com/alshai/levioSAM
---

# leviosam

## Overview

LevioSAM is a specialized tool for the accurate and efficient translation of sequence alignments between different genomic coordinate systems. While traditional liftover tools often struggle with complex variations, LevioSAM is designed to handle insertions, deletions, and substitutions defined in VCF files or assembly-to-assembly differences in Chain files. It allows researchers to align sequencing reads to a "variant-aware" reference (such as a personalized genome or a major-allele reference) to improve mapping accuracy, and then "lift" those alignments back to a standard reference coordinate system without losing alignment metadata like CIGAR strings or MD/NM tags.

## Core Workflows

### VCF-Based Lift-over (Variant-Aware)
Use this workflow when you have aligned reads to a personalized or modified reference created from a VCF.

1.  **Pre-process the VCF**: Always normalize and left-align your VCF to ensure coordinate consistency.
    ```bash
    bcftools norm -f reference.fa input.vcf > normalized.vcf
    ```

2.  **Index/Serialize the VCF**: Convert the VCF into a binary `.lft` index to speed up repeated lift-over tasks.
    ```bash
    leviosam serialize -v normalized.vcf -s <sample_name> -p <output_prefix>
    ```
    *Note: Use `-g 0` or `-g 1` to specify a specific haplotype.*

3.  **Perform the Lift-over**:
    ```bash
    leviosam lift -a aligned_to_alt.bam -l <output_prefix>.lft -p lifted_to_ref -O bam
    ```

### Chain-Based Lift-over (Assembly-to-Assembly)
Use this workflow for lifting alignments between different assembly versions (e.g., hg19 to hg38).

1.  **Index the Chain file**:
    ```bash
    leviosam index -c source_to_dest.chain -p source_to_dest -F dest.fai
    ```

2.  **Perform the Lift-over**:
    ```bash
    leviosam lift -C source_to_dest.clft -a aligned_to_source.bam -p lifted_from_source -O bam
    ```

## Expert Tips and Best Practices

### Efficient Piping
To save disk space and time, pipe aligner output directly into LevioSAM.
```bash
bowtie2 -p 8 -x major_ref_idx -1 R1.fq -2 R2.fq | \
leviosam lift -l major_ref.lft -t 8 -p lifted_output
```

### Handling Alignment Tags
If you need to update the `NM:i` (edit distance) and `MD:Z` (mismatching positions) tags after the lift-over, use the `-m` flag. 
*   **Performance Warning**: Updating tags is significantly faster if the input SAM/BAM file is sorted by coordinate.
*   **Command**: `leviosam lift -m -a input.bam -l map.lft -p output`

### Multithreading
LevioSAM scales well with multiple cores. Always specify the `-t` parameter to match your available CPU resources for both indexing and lifting.

### Input/Output Formats
*   Use `-O bam` to produce compressed binary output directly.
*   To read from standard input, use `-a -` or omit the `-a` flag entirely.



## Subcommands

| Command | Description |
|---------|-------------|
| leviosam | lifting over alignments |
| leviosam collate | Collate alignments to make sure reads are paired |
| leviosam reconcile | Reconcile multiple BAM files into a single BAM file. |
| leviosam_bed | Lift over a BED file |

## Reference documentation
- [LevioSAM Main Repository](./references/github_com_alshai_levioSAM.md)
- [Lift over using a VCF map](./references/github_com_alshai_levioSAM_wiki_Lift-over-using-a-VCF-map.md)
- [Lift over using a chain map](./references/github_com_alshai_levioSAM_wiki_Lift-over-using-a-chain-map.md)
- [Alignment with variant aware reference genomes](./references/github_com_alshai_levioSAM_wiki_Alignment-with-variant-aware-reference-genomes.md)