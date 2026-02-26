---
name: teloclip
description: Teloclip is a bioinformatics utility that identifies telomeric motifs in soft-clipped read alignments to extend draft genome assemblies. Use when user asks to filter alignments for telomeric overhangs, extract telomeric sequences, or automatically extend contigs to achieve telomere-to-telomere representations.
homepage: https://github.com/Adamtaranto/teloclip
---


# teloclip

## Overview

Teloclip is a bioinformatics utility designed to bridge the gap between draft genome assemblies and complete, telomere-to-telomere representations. Genome assemblers often stop just before repetitive telomeric regions, resulting in "soft-clipped" alignments where the ends of raw reads do not map to the reference. This skill provides workflows to filter these alignments for telomeric motifs, extract the overhanging sequences, and automatically extend contigs to restore missing chromosomal ends.

## Core Workflows

### 1. Filtering for Telomeric Overhangs
The `filter` command identifies reads that are clipped at the very ends of contigs.

```bash
# Basic filter: requires a reference index (.fai)
teloclip filter --ref-idx ref.fa.fai in.sam > overhangs.sam

# Filter for specific telomeric motifs (e.g., human TTAGGG)
teloclip filter --ref-idx ref.fa.fai --motifs TTAGGG --min-repeats 3 in.sam > telomeric_overhangs.sam
```

### 2. Handling Noisy Long-Read Data
For ONT or older PacBio data with homopolymer errors, use "fuzzy" matching to prevent missing valid telomeres due to sequencing noise.

```bash
# --fuzzy allows motif base counts to vary by +/- 1 (e.g., TTAGGG matches TTTAGG or TTAGGGG)
teloclip filter --ref-idx ref.fa.fai --motifs TTAGGG --fuzzy --min-repeats 5 in.sam
```

### 3. Extracting and Extending
Once filtered, you can extract the sequences or use the `extend` command to automatically patch the assembly.

```bash
# Extract overhanging sequences to FASTA
teloclip extract --ref-idx ref.fa.fai filtered_overhangs.sam --out_dir extracted_telomeres/

# Automatically extend draft contigs using the overhang analysis
teloclip extend --ref-idx ref.fa.fai --ref_fa ref.fa in.sam > extended_assembly.fa
```

## Expert Tips & Best Practices

- **Indexing is Mandatory**: Always run `samtools faidx ref.fa` before using teloclip. The tool requires the `.fai` file to determine exactly where contigs end.
- **Streaming for Efficiency**: To save disk space, pipe directly from `minimap2` into `teloclip`.
  ```bash
  minimap2 -ax map-ont ref.fa reads.fq.gz | teloclip filter --ref-idx ref.fa.fai | samtools sort > telomeric.bam
  ```
- **BAM vs SAM**: Teloclip can process SAM input from stdin. If your data is in BAM format, use `samtools view -h` to provide the necessary headered SAM stream.
- **Motif Orientation**: You only need to provide the canonical motif (e.g., `TTAGGG`). Teloclip automatically checks for the reverse complement (`CCCTAA`).
- **Sub-command Selection**:
    - Use `filter` to browse candidate reads.
    - Use `extract` if you want to perform manual assembly or polishing on the telomeric reads.
    - Use `extend` for an automated "all-in-one" patching workflow.

## Reference documentation
- [Teloclip GitHub Repository](./references/github_com_Adamtaranto_teloclip.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_teloclip_overview.md)