---
name: minimap2
description: Minimap2 is a high-performance sequence alignment tool used to map genomic reads or assemblies to a reference. Use when user asks to map long reads, perform spliced RNA-seq alignment, find overlaps for assembly, or align assemblies to one another.
homepage: https://github.com/lh3/minimap2
metadata:
  docker_image: "quay.io/biocontainers/minimap2:2.30--h577a1d6_0"
---

# minimap2

## Overview
Minimap2 is a high-performance sequence alignment tool designed to handle a wide range of genomic data types. It excels at mapping long, error-prone reads and performing large-scale genomic comparisons with significantly higher speed than traditional aligners. It is the industry standard for Oxford Nanopore (ONT) and PacBio data, but also supports short-read mapping and assembly-to-assembly alignment.

## Common CLI Patterns

### Mapping Long Reads to a Reference
For most long-read applications, use the `-a` flag to generate SAM output and the `-x` flag to select the appropriate preset.

*   **Oxford Nanopore (ONT) Genomic:**
    `minimap2 -ax map-ont ref.fa ont_reads.fq > aln.sam`
*   **PacBio HiFi/CCS:**
    `minimap2 -ax map-hifi ref.fa hifi_reads.fq > aln.sam`
*   **PacBio CLR (Noisy):**
    `minimap2 -ax map-pb ref.fa clr_reads.fq > aln.sam`
*   **Nanopore Q20 (v2.27+):**
    `minimap2 -ax lr:hq ref.fa ont_q20.fq > aln.sam`

### Spliced Alignment (RNA-seq)
Minimap2 is highly effective for mapping cDNA or direct RNA reads to a genome while accounting for introns.

*   **General Spliced Alignment:**
    `minimap2 -ax splice ref.fa rna_reads.fa > aln.sam`
*   **Noisy Nanopore Direct RNA:**
    `minimap2 -ax splice -uf -k14 ref.fa reads.fa > aln.sam`
*   **Using Annotated Junctions:**
    `minimap2 -ax splice --junc-bed=anno.bed12 ref.fa query.fa > aln.sam`

### Assembly and Overlap Detection
*   **Assembly-to-Assembly (Intra-species):**
    `minimap2 -cx asm5 asm1.fa asm2.fa > aln.paf`
*   **Find Overlaps (All-vs-All):**
    `minimap2 -x ava-ont reads.fq reads.fq > overlaps.paf`

### Short Read Mapping
*   **Illumina Paired-End:**
    `minimap2 -ax sr ref.fa read1.fq read2.fq > aln.sam`

## Expert Tips and Best Practices

### Efficient Indexing
For large reference genomes (e.g., Human), generate an index file (`.mmi`) once to save time on subsequent runs.
1.  **Create Index:** `minimap2 -d human.mmi human_ref.fa`
2.  **Map using Index:** `minimap2 -ax map-ont human.mmi reads.fq > aln.sam`
*Note: Indexing parameters (like -k or -w) cannot be changed once the index is built.*

### Output Formats
*   **PAF (Pairwise Mapping Format):** The default output. It is tab-delimited and lightweight, providing mapping coordinates without base-level alignment.
*   **SAM:** Use `-a` to generate full alignments.
*   **CIGAR in PAF:** If you need base-level information in PAF format, use the `-c` flag to add the CIGAR string to the `cg` tag.

### Input Handling
Minimap2 natively supports gzip-compressed files. You can pass `.fa.gz` or `.fq.gz` directly without decompressing.

### Performance Tuning
*   **Threading:** Use `-t` to specify the number of CPU threads (e.g., `-t 8`).
*   **Memory:** For very large datasets, minimap2 is generally memory-efficient, but using a pre-built index (`.mmi`) further reduces the peak memory required during the mapping phase.

## Reference documentation
- [Minimap2 GitHub Repository](./references/github_com_lh3_minimap2.md)
- [Minimap2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_minimap2_overview.md)