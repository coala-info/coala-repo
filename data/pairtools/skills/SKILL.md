---
name: pairtools
description: pairtools processes paired-end sequence alignments from Hi-C experiments into standardized contact maps. Use when user asks to parse SAM/BAM files into .pairs format, sort pairs, remove duplicates, filter ligation junctions, or generate library statistics.
homepage: https://github.com/mirnylab/pairtools
metadata:
  docker_image: "quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0"
---

# pairtools

## Overview

pairtools is a high-performance command-line suite designed to process paired-end sequence alignments from Hi-C experiments. It transforms raw alignment data (SAM/BAM) into the standardized .pairs format, which is a tab-separated table of ligation junctions. The toolset provides a modular workflow for sorting, deduplicating, and filtering these junctions, enabling researchers to move from mapped reads to high-quality contact maps and statistical summaries of chromosome conformation.

## Core Workflow and CLI Patterns

### 1. Parsing Alignments
The first step is converting SAM/BAM files into .pairs files. You must provide a `.chromsizes` file (a tab-separated file with chromosome names and sizes).

```bash
# Basic parsing
pairtools parse -c genome.chrom.sizes -o output.pairs.gz input.bam

# Parsing with SAM record removal to save space
pairtools parse -c genome.chrom.sizes --drop-sam -o output.pairs.gz input.bam
```

### 2. Sorting Pairs
Most downstream tools require the .pairs file to be sorted by chromosome and position.

```bash
# Sort using multiple processors
pairtools sort --nproc 8 -o sorted.pairs.gz unsorted.pairs.gz
```

### 3. Deduplication
Identify and remove PCR or optical duplicates. It is recommended to use the `--mark-dups` flag to keep the records but tag them.

```bash
# Detect duplicates and generate stats
pairtools dedup --mark-dups --output-stats stats.txt -o deduped.pairs.gz sorted.pairs.gz
```

### 4. Filtering and Selection
Use `pairtools select` to filter pairs based on properties like `pair_type` (e.g., UU for unique-unique), mapping quality, or genomic distance.

```bash
# Select only unique-unique (UU) and unique-rescued (UR) pairs
pairtools select "(pair_type=='UU') or (pair_type=='UR')" -o filtered.pairs.gz input.pairs.gz

# Filter by mapping quality (automatically converted to integers)
pairtools select "(mapq1 >= 30) and (mapq2 >= 30)" -o high_mapq.pairs.gz input.pairs.gz
```

### 5. Generating Statistics
Generate comprehensive reports on the library composition, including the number of cis/trans contacts and duplicate rates.

```bash
pairtools stats -o library_stats.txt input.pairs.gz
```

## Expert Tips and Best Practices

- **Piping for Efficiency**: pairtools is designed for Unix piping. You can chain commands to avoid writing large intermediate files to disk.
  ```bash
  pairtools parse -c chrom.sizes input.bam | pairtools sort --nproc 4 | pairtools dedup -o final.pairs.gz
  ```
- **Compression**: Always use the `.gz` extension for output files. pairtools automatically detects this and uses `bgzip` or `pbgzip` (if available) for compression.
- **Memory Management**: For `pairtools sort`, use the `--max-mem` flag to limit memory usage on shared systems.
- **Complex Walks**: For advanced Hi-C protocols (like multi-contact 3C), use `pairtools parse2` to handle complex walks and chimeric alignments.
- **Flipping**: Use `pairtools flip` to ensure that for every pair, the first side has a lower genomic coordinate than the second side, which is required for consistent contact matrix generation.



## Subcommands

| Command | Description |
|---------|-------------|
| pairtools dedup | Find and remove PCR/optical duplicates. |
| pairtools filterbycov | Remove pairs from regions of high coverage. |
| pairtools flip | Flip pairs to get an upper-triangular matrix. |
| pairtools header | Manipulate the .pairs/.pairsam header |
| pairtools merge | Merge .pairs/.pairsam files. By default, assumes that the files are sorted and maintains the sorting. |
| pairtools parse | Find ligation pairs in .sam data, make .pairs. SAM_PATH : an input .sam/.bam file with paired-end sequence alignments of Hi-C molecules. If the path ends with .bam, the input is decompressed from bam with samtools. By default, the input is read from stdin. |
| pairtools restrict | Assign restriction fragments to pairs. |
| pairtools sample | Select a random subset of pairs in a pairs file. |
| pairtools scaling | Calculate pairs scalings. |
| pairtools select | Select pairs according to some condition. |
| pairtools split | Split a .pairsam file into .pairs and .sam. |
| pairtools stats | Calculate pairs statistics. |
| pairtools_markasdup | Tag all pairs in the input file as duplicates. |
| pairtools_parse2 | Extracts pairs from .sam/.bam data with complex walks, make .pairs. SAM_PATH : an input .sam/.bam file with paired-end or single-end sequence alignments of Hi-C (or Hi-C-like) molecules. If the path ends with .bam, the input is decompressed from bam with samtools. By default, the input is read from stdin. |
| pairtools_phase | Phase pairs mapped to a diploid genome. Diploid genome is the genome with two set of the chromosome variants, where each chromosome has one of two suffixes (phase-suffixes) corresponding to the genome version (phase- suffixes). |
| pairtools_sort | Sort a .pairs/.pairsam file. |

## Reference documentation
- [pairtools README](./references/github_com_open2c_pairtools_blob_master_README.md)
- [pairtools Changelog](./references/github_com_open2c_pairtools_blob_master_CHANGES.md)