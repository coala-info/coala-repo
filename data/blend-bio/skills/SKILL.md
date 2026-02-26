---
name: blend-bio
description: BLEND is a high-performance alignment tool that uses fuzzy seeding for fast and accurate genome analysis. Use when user asks to find overlapping reads, map long reads to a reference genome, or perform all-vs-all read alignment.
homepage: https://github.com/CMU-SAFARI/BLEND
---


# blend-bio

## Overview
BLEND is a high-performance alignment tool designed to improve the speed and accuracy of genome analysis through a unique fuzzy seeding mechanism. By allowing highly similar seeds to generate the same hash value, BLEND enables approximate matches with a single lookup. It is particularly effective for long-read applications, such as finding overlapping reads (all-vs-all) and read mapping, where it often outperforms minimap2 in both memory efficiency and execution time.

## Installation
The recommended way to install BLEND is via Bioconda:
```bash
conda install -c bioconda blend-bio
```

## Common CLI Patterns

### Finding Overlapping Reads (All-vs-All)
For all-vs-all overlapping of high-accuracy long reads (e.g., PacBio HiFi), use the `ava-hifi` preset.
```bash
blend -x ava-hifi reads.fastq reads.fastq > overlaps.paf
```

### Read Mapping
To map reads to a reference genome, use the `-a` flag to generate SAM output and select the appropriate preset for your sequencing technology.

**For PacBio HiFi/Accurate Long Reads:**
```bash
blend -ax map-hifi ref.fasta reads.fastq > output.sam
```

**For PacBio CLR/Erroneous Long Reads:**
```bash
blend -ax map-pb ref.fasta reads.fastq > output.sam
```

**For Oxford Nanopore (ONT) Reads:**
```bash
blend -ax map-ont ref.fasta reads.fastq > output.sam
```

## Expert Tips and Best Practices

### Tuning Fuzzy Seeding
The primary parameter unique to BLEND is the `--neighbors` option. This controls how many k-mers are combined to generate a single fuzzy seed.
- **Default:** 10
- **Usage:** `--neighbors INT`
- **Tip:** Increasing this value can lead to longer seeds, which may improve specificity in repetitive regions but might impact sensitivity if set too high.

### Handling Large Genomes
Because BLEND is memory-efficient, it is well-suited for large reference genomes. If you encounter performance bottlenecks on repetitive genomes, ensure you are using the latest version which includes optimized filters for maximum seed occurrence.

### Output Formats
- **PAF (Default):** Best for overlapping and quick alignment summaries.
- **SAM (`-a`):** Required if you need CIGAR strings and downstream compatibility with tools like Samtools or GATK.

### Performance Comparison
When working with PacBio HiFi data, BLEND is specifically optimized to be faster and more accurate than minimap2. If your workflow currently uses `minimap2 -x ava-pb`, switching to `blend -x ava-hifi` is recommended for better results.

## Reference documentation
- [BLEND GitHub Repository](./references/github_com_CMU-SAFARI_BLEND.md)
- [Bioconda blend-bio Overview](./references/anaconda_org_channels_bioconda_packages_blend-bio_overview.md)