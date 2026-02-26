---
name: crossfilt
description: CrossFilt addresses reference bias in comparative genomics by filtering for reciprocal alignments between species. Use when user asks to lift alignments between species, split large BAM files for processing, or filter for reciprocal reads with unambiguous orthology.
homepage: https://github.com/kennethabarr/CrossFilt
---


# crossfilt

## Overview

CrossFilt addresses the challenge of "reference bias" in comparative genomics. When comparing two species, reads from one species may align better to their own reference genome than the other, leading to false signals of differential expression or accessibility. 

This skill provides the procedural knowledge to execute the CrossFilt pipeline: lifting alignments from a target species to a query species, realigning them, and then filtering for "reciprocal" reads—those that map back to the original coordinates and gene tags. This ensures that only reads with unambiguous orthology are used in downstream analysis.

## Installation and Setup

Install via Bioconda for the most stable environment:

```bash
conda install bioconda::crossfilt
```

The tool requires `STAR`, `htseq-count`, and `samtools` for the full reciprocal mapping workflow.

## Core Workflow Commands

### 1. Lifting Alignments
Use `crossfilt-lift` to convert BAM coordinates and sequences from the target species to the query species.

```bash
crossfilt-lift -i input.bam -o output_prefix -c species1_to_species2.over.chain.gz -t target.fasta -q query.fasta
```

**Expert Tips:**
- **Input Requirements**: Input BAM files must be sorted and indexed (`samtools sort` and `samtools index`).
- **Paired-End Data**: Always include the `-p` flag for paired-end reads to ensure both mates are processed together.
- **Performance**: By default, the tool tries all chains if the best one fails. Use the `-b` flag to only attempt the best chain; this is ~10% faster but may reduce successfully lifted reads by ~5%.

### 2. Splitting Large Files
Because `crossfilt-lift` can be memory-intensive (storing chains for chromosomes), split large BAM files into smaller chunks.

```bash
crossfilt-split -i input.bam -o split_prefix -n 4 -p --file-size 1000000
```

- Use `-f` to specify a fixed number of files or `-s` for a specific number of reads per file.
- The tool ensures paired-end mates stay in the same chunk.

### 3. Filtering Reciprocal Reads
After realigning the lifted reads to the query genome and lifting them back, use `crossfilt-filter` to identify reads that returned to their original position and identity.

```bash
crossfilt-filter -t gene_id -x original_lifted.bam realigned_back.bam > filtered_results.bam
```

- **Tag Comparison**: Use `-t` to specify which BAM tags (e.g., `gene_id` from htseq-count) must match between the two files.
- **XF Tag**: Use the `-x` flag as a shortcut to compare the `XF` tag commonly used by aligners like STAR.
- **Multithreading**: Use `-@ [threads]` to speed up compression/decompression during the filtering stage.

## Best Practices

1. **Memory Management**: If you encounter memory issues, split your BAM files by chromosome or use `crossfilt-split`. The tool's memory footprint scales with the number of chromosomes present in the BAM file.
2. **Coordinate Consistency**: Ensure the FASTA files used in `crossfilt-lift` exactly match the versions used to generate the original BAM and the UCSC chain file.
3. **Single-Cell Data**: For 10x Genomics data, use the `bamtofastq` utility from 10x to convert lifted BAMs back to FASTQ for realignment while preserving cell barcodes.

## Reference documentation
- [CrossFilt GitHub Repository](./references/github_com_kennethabarr_CrossFilt.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_crossfilt_overview.md)