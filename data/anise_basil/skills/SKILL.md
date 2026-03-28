---
name: anise_basil
description: The anise_basil toolset discovers and reconstructs novel genomic sequences present in a donor sample but absent from a reference genome. Use when user asks to identify insertion breakpoints, assemble novel sequence insertions, or analyze structural variants from paired-end sequencing data.
homepage: https://github.com/seqan/anise_basil
---

# anise_basil

## Overview

The `anise_basil` toolset is designed for the discovery and characterization of novel genomic sequences that are present in a donor sample but absent from a reference genome. The workflow is split into two primary components: **BASIL** (Breakpoint Analysis and Search for ILlegal insertions), which identifies the genomic coordinates where insertions likely occur, and **ANISE** (Assembler for Novel InSertions), which uses the reads associated with those breakpoints to reconstruct the actual inserted sequence. This skill should be used when analyzing paired-end HTS data to find large structural variants that standard mappers cannot fully resolve.

## Command-Line Workflow

### 1. Pre-processing
Before using BASIL, reads must be mapped to a reference genome and the resulting BAM file must be sorted and indexed.

```bash
# Example using Samtools
samtools sort input.bam -o sorted.bam
samtools index sorted.bam
```

### 2. Breakpoint Detection with BASIL
BASIL analyzes the BAM file for "illegal" read pairs (e.g., one-end anchored reads or discordant pairs) to find tentative insertion sites.

```bash
basil -ir reference.fa -im sorted.bam -ov breakpoints.vcf
```
*   `-ir`: Path to the reference FASTA file.
*   `-im`: Path to the sorted/indexed BAM file.
*   `-ov`: Output VCF file containing candidate breakpoints.

### 3. Filtering Candidate Sites
To reduce noise and improve assembly performance, filter the BASIL VCF file. A common heuristic is to require a minimum number of one-end anchored (OEA) reads on each side of the breakpoint.

```bash
filter_basil.py -i breakpoints.vcf -o filtered.vcf --min-oea-each-side 10
```

### 4. Sequence Assembly with ANISE
ANISE takes the filtered breakpoints and performs a localized assembly to reconstruct the inserted sequence.

```bash
anise -ir reference.fa -im sorted.bam -iv filtered.vcf -of assembly.fa
```
*   `-iv`: Input VCF file (filtered breakpoints).
*   `-of`: Output FASTA file containing assembled contigs.

## Expert Tips and Best Practices

### Identifying High-Confidence Assemblies
ANISE produces a FASTA file where the header lines contain metadata. Look for the `SPANNING=yes` flag. This indicates that the assembly process successfully connected the left and right sides of the breakpoint, representing a complete reconstruction of the insertion.

You can extract these high-confidence contigs using the provided utility script:
```bash
extract_spanning.awk assembly.fa > spanning_contigs.fa
```

### Handling Complex Regions
*   **Repeats**: If the assembly stops prematurely (`STOPPED=no_more_reads` or `STOPPED=repeat`), the insertion may be located within or contain repetitive elements that exceed the library's insert size.
*   **Heuristic Filtering**: For high-coverage data (e.g., 30x-50x), increasing `--min-oea-each-side` in the filtering step can significantly speed up ANISE by ignoring low-support artifacts.

### Validation
Since ANISE assembles sequence both inside and slightly flanking the insertion, you can validate the assembly by aligning the resulting contigs back to the reference using tools like BLAT. A successful assembly will show the flanking regions matching the reference perfectly, separated by the novel inserted sequence.



## Subcommands

| Command | Description |
|---------|-------------|
| anise | Assembly of Novel Inserted SEquence. ANISE will try to assemble the inserted sequences at the sites in IN.vcf and write the assembled sequences to OUT.vcf. |
| basil | Scan SAM/BAM file MAPPING for signatures of structural variations. |
| filter_basil.py | Filter BASIL output VCF. |

## Reference documentation
- [GitHub Repository and Documentation](./references/github_com_seqan_anise_basil.md)