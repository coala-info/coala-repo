---
name: hocort
description: "HoCoRT identifies and removes contaminant host sequences from sequencing data by mapping reads against a reference genome using various aligners. Use when user asks to remove host contamination, build reference indexes for mapping, extract specific organism sequences, or filter sequencing reads."
homepage: https://github.com/ignasrum/hocort
---


# hocort

## Overview
HoCoRT (Host Contamination Removal Tool) is a specialized Linux-based utility designed to clean sequencing data by identifying and removing reads belonging to specific "contaminant" organisms, typically the host. It functions as a wrapper for several industry-standard aligners and classifiers, providing a unified interface to map reads against a reference genome and filter the results. By default, it is used to subtract host DNA to reduce file size and improve downstream analysis of microbial or non-host sequences.

## Core Workflows

### 1. Building Indexes
Before filtering, you must create an index for the specific pipeline you intend to use. If you need to remove multiple organisms, concatenate their FASTA files into a single reference before indexing.

```bash
# General syntax
hocort index <pipeline_name> --input genome.fasta --output dir/basename

# Example: Building a Bowtie2 index
hocort index bowtie2 --input human_reference.fasta --output indexes/human
```

### 2. Removing Host Contamination
To remove host sequences, map your reads against the host index and set `--filter true`. This tells HoCoRT to output only the reads that **did not** map to the reference.

```bash
# Paired-end reads (removes host)
hocort map bowtie2 -x indexes/human -i read1.fastq read2.fastq -o clean1.fastq clean2.fastq --filter true

# Single-end reads (removes host)
hocort map bowtie2 -x indexes/human -i input.fastq -o output.fastq --filter true
```

### 3. Extracting Specific Organisms
To do the opposite—extracting only the reads that match your reference—set `--filter false`.

```bash
# Extracting specific sequences matching the index
hocort map bowtie2 -x indexes/target_organism -i input.fastq -o extracted.fastq --filter false
```

## Expert Tips and Best Practices

- **Pipeline Selection**: Choose your pipeline based on the underlying tool's strengths. Use `bowtie2` or `hisat2` for high accuracy with short reads, or `minimap2` for long reads or faster, less sensitive mapping.
- **Compressed Files**: HoCoRT handles `.gz` files natively. Simply use the `.gz` extension in your output filenames to trigger compression, which saves significant disk space.
- **Advanced Tool Configuration**: You can pass raw arguments directly to the underlying aligner using the `-c` or `--config` flag. This is useful for adjusting sensitivity or local vs. end-to-end alignment.
  - Example: `hocort map bowtie2 -c="--very-fast-local" ...`
- **Python Integration**: For complex workflows, HoCoRT can be imported as a Python module. This allows you to capture return codes and programmatically configure options.
  ```python
  import hocort.pipelines.bowtie2 as Bowtie2
  Bowtie2().run(idx, seq1, out1, seq2=seq2, out2=out2, options=["--local"])
  ```



## Subcommands

| Command | Description |
|---------|-------------|
| index | build index/-es for supported tools |
| map | map reads to a reference genome and output mapped/unmapped reads |

## Reference documentation
- [HoCoRT GitHub Repository](./references/github_com_ignasrum_hocort.md)
- [HoCoRT Wiki Home](./references/github_com_ignasrum_hocort_wiki.md)
- [How HoCoRT Works](./references/github_com_ignasrum_hocort_wiki_How-HoCoRT-works.md)