---
name: tophat
description: TopHat maps RNA-Seq reads to a reference genome, specifically designed to handle reads spanning splice junctions. Use when user asks to map RNA-Seq reads, align RNA-Seq reads, map paired-end RNA-Seq reads, map strand-specific RNA-Seq reads, or align RNA-Seq reads with known annotations.
homepage: http://ccb.jhu.edu/software/tophat
metadata:
  docker_image: "quay.io/biocontainers/tophat:2.1.2--h3e6c209_0"
---

# tophat

## Overview
TopHat is a specialized bioinformatics tool that maps RNA-Seq reads to a reference genome. Unlike standard aligners, it is "splice-aware," meaning it can handle reads that span multiple exons by breaking them into segments and mapping them across introns. It typically uses Bowtie as its underlying alignment engine. While newer tools like HISAT2 or STAR are often preferred for speed, TopHat remains a foundational tool for specific legacy pipelines and detailed junction discovery.

## Core Usage Patterns

### Basic Alignment
The standard command requires a Bowtie index and your sequence files (FastQ).
```bash
tophat [options] <bowtie_index> <reads1.fq,reads2.fq,...> [reads2_1.fq,reads2_2.fq,...]
```

### Common CLI Workflows
- **Paired-end Mapping**: Provide two sets of files.
  ```bash
  tophat -o ./output_dir genome_index reads_1.fastq reads_2.fastq
  ```
- **Using Known Annotations**: Supply a GTF file to improve mapping accuracy at known splice sites.
  ```bash
  tophat -G genes.gtf -o ./output_dir genome_index reads.fastq
  ```
- **Library Type Specification**: Crucial for strand-specific RNA-Seq.
  - `--library-type fr-unstranded` (Standard/Default)
  - `--library-type fr-firststrand` (e.g., dUTP, TruSeq Stranded)
  - `--library-type fr-secondstrand` (e.g., ScriptSeq)

## Expert Tips & Best Practices
- **Resource Management**: Use the `-p` or `--num-threads` flag to utilize multiple CPU cores, as alignment is computationally intensive.
- **Inner Mate Distance**: For paired-end data, provide the expected mean inner distance between mate pairs using `-r` (e.g., `-r 200`).
- **Output Files**: TopHat produces a `accepted_hits.bam` file. Always check the `align_summary.txt` in the output directory to verify mapping percentages and ensure the library type was correctly identified.
- **Indel Discovery**: If looking for insertions or deletions, ensure `--fusion-search` or specific indel flags are enabled, though these increase runtime significantly.
- **Large Introns**: If working with organisms that have exceptionally large introns, adjust `--max-intron-length` (default is 500,000).

## Reference documentation
- [TopHat Overview](./references/anaconda_org_channels_bioconda_packages_tophat_overview.md)
- [TopHat Manual and Documentation](./references/ccb_jhu_edu_software_tophat.md)