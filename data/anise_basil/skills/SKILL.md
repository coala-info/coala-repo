---
name: anise_basil
description: The anise_basil suite identifies and assembles novel genomic insertion sequences by analyzing structural variant breakpoints and performing localized de novo assembly. Use when user asks to identify insertion sites, filter structural variant candidates, or assemble novel sequences not present in a reference genome.
homepage: https://github.com/seqan/anise_basil
---


# anise_basil

## Overview
The `anise_basil` suite provides a specialized workflow for discovering and characterizing novel genomic sequences. BASIL (Breakpoint Analysis of Structural variants In Large-scale sequencing) identifies candidate insertion sites by analyzing discordant read pairs and clipped alignments. ANISE (Assembly of Novel InSertions) then takes these candidates and performs a localized de novo assembly to reconstruct the full sequence of the insertion. This toolset is particularly effective for identifying large insertions that are not present in the reference genome.

## Command Line Usage

### 1. Breakpoint Detection (BASIL)
Identify potential structural variant sites from a sorted and indexed BAM file.

```bash
basil -ir reference.fa -im alignments.bam -ov breakpoints.vcf
```

### 2. Filtering Candidates
Before assembly, filter the VCF to reduce noise and focus on high-confidence sites. A common heuristic is to require a minimum number of "One-End Anchored" (OEA) reads.

```bash
filter_basil.py -i breakpoints.vcf -o filtered.vcf --min-oea-each-side 10
```

### 3. Insertion Assembly (ANISE)
Assemble the novel sequences at the filtered breakpoint locations.

```bash
anise -ir reference.fa -im alignments.bam -iv filtered.vcf -of assembled_insertions.fa
```

### 4. Post-Processing
ANISE produces a FASTA file containing assembled contigs. Use the provided utility script to extract only the contigs that successfully span the insertion site.

```bash
extract_spanning assembled_insertions.fa > final_insertions.fa
```

## Best Practices and Expert Tips

*   **Input Preparation**: Ensure your BAM file is both sorted and indexed (`samtools index`). BASIL relies on efficient coordinate-based access to identify discordant pairs.
*   **Filtering is Mandatory**: Running ANISE on an unfiltered BASIL VCF is computationally expensive and often leads to poor assembly results due to false positive breakpoints. Always use `filter_basil.py` to tune the sensitivity based on your data's coverage.
*   **Spanning Contigs**: ANISE marks contigs in the FASTA header. Look for `SPANNING=yes`. These represent the most reliable assemblies where the tool successfully connected the left and right flanks of the insertion.
*   **Validation**: Because ANISE assembles sequence both inside and slightly outside the insertion point, you can use tools like BLAT to align the resulting contigs back to the reference. A successful assembly will show a "gap" in the reference alignment corresponding to the size of the insertion.
*   **Memory Management**: For large datasets, BASIL and ANISE can be memory-intensive. Ensure you are running on a system with sufficient RAM, especially when dealing with high-coverage whole-genome sequencing (WGS) data.

## Reference documentation
- [anise_basil Overview](./references/anaconda_org_channels_bioconda_packages_anise_basil_overview.md)
- [anise_basil GitHub Repository](./references/github_com_seqan_anise_basil.md)