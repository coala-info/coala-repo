---
name: lra
description: lra is a specialized alignment tool designed to map long-read sequencing data and assembly contigs to a reference genome with high sensitivity for structural variations. Use when user asks to index a reference genome, align PacBio or Oxford Nanopore reads, map assembly contigs, or identify genomic inversions and structural variants.
homepage: https://github.com/ChaissonLab/LRA
metadata:
  docker_image: "quay.io/biocontainers/lra:1.3.7.2--h5ca1c30_4"
---

# lra

## Overview
lra (Long Read Aligner) is a specialized alignment tool designed for the unique characteristics of single-molecule sequencing (SMS) data. It utilizes a two-tiered seeding strategy—combining global minimizer-based seeds with local refinement using smaller k-mer matches—to achieve high sensitivity in complex genomic regions. While comparable in speed to other long-read aligners, lra is particularly effective at identifying structural variations and inversions that other tools might miss, making it an ideal choice for clinical or comparative genomics workflows focused on SV detection.

## Usage Guidelines

### 1. Indexing the Reference
Before alignment, you must generate a two-tiered index for your reference genome. The indexing parameters are automatically tuned based on the sequencing technology you intend to map.

```bash
# General syntax
lra index -[MODE] <ref.fa>

# Examples by data type
lra index -CCS ref.fa     # For PacBio HiFi/CCS reads
lra index -CLR ref.fa     # For PacBio legacy CLR reads
lra index -ONT ref.fa     # For Oxford Nanopore reads
lra index -CONTIG ref.fa  # For assembly contigs
```

### 2. Aligning Reads
Alignment requires specifying the same mode used during indexing. lra supports FASTA, FASTQ, and BAM input formats.

```bash
# Basic alignment to SAM (default)
lra align -CCS ref.fa reads.fq -t 16 > output.sam

# Output to different formats using the -p flag
lra align -ONT ref.fa reads.fq -p p > output.paf  # PAF format
lra align -ONT ref.fa reads.fq -p b > output.bed  # BED format

# Handling compressed input
zcat reads.fq.gz | lra align -ONT ref.fa /dev/stdin -t 16 -p s > output.sam
```

### 3. Parameter Selection (Modes)
Choosing the correct mode is critical for alignment accuracy:
- **CCS**: Use for high-accuracy PacBio HiFi reads.
- **CLR**: Use for noisier, long PacBio subreads.
- **ONT**: Use for Oxford Nanopore data.
- **CONTIG**: Use for megabase-scale assembly contigs; this mode is optimized for very long, relatively accurate sequences.

### 4. Interpreting Custom Tags
lra includes specialized tags in SAM/PAF output to assist in downstream SV calling:
- `NM`: Total edit distance (mismatches + insertions + deletions).
- `NX`: Number of mismatches.
- `NI` / `ND`: Number of inserted/deleted bases.
- `TI` / `TD`: Number of insertion/deletion events.
- `TP`: Type of alignment (P=Primary, S=Secondary, I=Inversion).
- `AO`: Order of the aligned segment for split-read mappings.

## Best Practices
- **Threading**: Use the `-t` flag to specify CPU cores. lra scales well with increased thread counts.
- **Memory**: Indexing the human genome takes a few minutes; ensure sufficient RAM is available for the two-tiered index (global and local).
- **SV Discovery**: If using lra for structural variant calling, ensure you use the SAM output to preserve the custom tags (`NI`, `ND`, `TP`) which provide more granular detail than standard CIGAR strings for some SV callers.



## Subcommands

| Command | Description |
|---------|-------------|
| lra align | Align reads to a genome. The genome should be indexed using the 'lra index' program. 'reads' may be either fasta, sam, or bam, and multiple input files may be given. |
| lra global | Index global reference |
| lra global | Index global reference for aligning reads |
| lra_global | Index global reference for aligning reads or contigs |

## Reference documentation
- [LRA Main Documentation](./references/github_com_ChaissonLab_LRA.md)
- [LRA Installation and Overview](./references/anaconda_org_channels_bioconda_packages_lra_overview.md)