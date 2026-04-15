---
name: srnamapper
description: srnamapper aligns small RNA sequencing reads to a genome using the BWA API. Use when user asks to map sRNA-seq reads, configure alignment parameters for small RNAs, or process multiple samples into merged output files.
homepage: https://github.com/mzytnicki/srnaMapper
metadata:
  docker_image: "quay.io/biocontainers/srnamapper:1.0.12--h577a1d6_0"
---

# srnamapper

## Overview
srnamapper is a specialized tool for aligning small RNA sequencing reads to a genome. It leverages the BWA (Burrows-Wheeler Aligner) API to provide fast and accurate mapping. This skill assists in configuring the alignment parameters, managing multiple input samples, and handling specific sRNA-seq challenges such as multi-mapping reads and low-complexity sequences.

## Installation and Preparation
The tool can be installed via Bioconda or compiled from source.

**Conda Installation:**
```bash
conda install -c bioconda srnamapper
```

**Genome Indexing:**
srnamapper requires a BWA index. Before mapping, generate the index using `bwa index`:
```bash
bwa index -p genome_prefix reference.fasta
```

## Command Line Usage

### Basic Mapping
To map a single FASTQ file to a genome:
```bash
srnamapper -r input.fastq -g genome_prefix -o output.sam
```

### Processing Multiple Samples
You can process multiple files in a single command. By default, you must provide one output file (`-o`) for every input file (`-r`) in the same order.
```bash
srnamapper -r sample1.fastq -r sample2.fastq -g genome -o sample1.sam -o sample2.sam
```

### Merged Output with Counts
Use the `-u` flag to aggregate all mapped reads into a single SAM file. This is particularly useful for downstream differential expression analysis as it includes counts for each sample.
```bash
srnamapper -r sample1.fastq -r sample2.fastq -g genome -o merged_output.sam -u
```

## Parameter Optimization

| Parameter | Description | Best Practice |
|-----------|-------------|---------------|
| `-e <int>` | Max errors | Default is 2. Increase for lower quality data or more divergent species. |
| `-t <int>` | Threads | Increase for faster processing (e.g., `-t 8`). |
| `-n <int>` | Multi-mapping limit | Discards reads mapping more than `n` times (default 5). Adjust based on how you want to handle repetitive elements. |
| `-f <int>` | Low complexity | Threshold for filtering simple sequences (default 6). Higher values are more lenient. |
| `-s <int>` | Random seed | Use for reproducibility when handling ambiguous nucleotides. |

## Expert Tips
- **Ambiguous Bases**: Like BWA, srnamapper converts ambiguous nucleotides (N) in both the genome and the reads to a random nucleotide. Use `-s` to ensure consistent results across runs.
- **Memory Management**: Ensure you have the `zlib` library installed if compiling from source, as it is a requirement for handling compressed FASTQ files.
- **Input Order**: When mapping multiple files without the `-u` flag, the order of `-r` and `-o` flags must match exactly.

## Reference documentation
- [github_com_mzytnicki_srnaMapper.md](./references/github_com_mzytnicki_srnaMapper.md)
- [anaconda_org_channels_bioconda_packages_srnamapper_overview.md](./references/anaconda_org_channels_bioconda_packages_srnamapper_overview.md)