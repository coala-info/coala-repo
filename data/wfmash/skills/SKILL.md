---
name: wfmash
description: wfmash is a high-performance DNA sequence aligner designed for large-scale genomic datasets. Use when user asks to align DNA sequences to a reference, perform all-vs-all sequence alignment, conduct approximate mapping, build pangenome graphs, or perform synteny-aware scaffolding.
homepage: https://github.com/ekg/wfmash
metadata:
  docker_image: "quay.io/biocontainers/wfmash:0.24.2--h27bdcc9_0"
---

# wfmash

## Overview
wfmash is a high-performance DNA sequence aligner designed for large-scale genomic datasets. It combines MashMap3 for efficient homology mapping with WFA for base-level accuracy. This skill provides the necessary command-line patterns to execute reference-based mapping, all-vs-all alignments, and synteny-aware scaffolding. It is particularly useful for building pangenome graphs where high-divergence handling and computational efficiency are required.

## Core Workflows

### Basic Alignment
To align a query set against a reference and produce a PAF (Pairwise Mapping Format) file:
```bash
wfmash reference.fa query.fa > alignment.paf
```

### All-vs-All Alignment
To align a set of sequences against themselves (common in pangenome graph construction):
```bash
wfmash sequences.fa > all_vs_all.paf
```

### Approximate Mapping (Fast)
If base-level alignment is not required (e.g., for initial homology screening), use `-m` to skip the WFA stage. This significantly increases speed and allows for larger segment lengths:
```bash
wfmash -m reference.fa query.fa > mappings.paf
```

## Expert Configuration

### Handling Sequence Divergence
wfmash uses an automated identity threshold based on the input's ANI (Average Nucleotide Identity) distribution.
- **Default**: `ani50` (the median).
- **Manual Percent**: `-p 85` (sets a fixed 85% identity threshold).
- **ANI Presets**: Use `-p ani25` for higher sensitivity (lower identity) or `-p ani75` for higher stringency.
- **Offsets**: Fine-tune with `-p ani50-5` (median minus 5%).

### Pangenome & PanSN Filtering
When working with PanSN-formatted FASTA files (e.g., `Sample#Hap#Contig`), use the group prefix delimiter to avoid self-alignments within the same genome:
```bash
wfmash -Y '#' pangenome.fa > pangenome_aln.paf
```

### Scaffolding and Synteny
For large, complex genomes, use scaffolding to filter out spurious matches and focus on syntenic regions:
- `-S [INT]`: Minimum scaffold length (default 10k).
- `-D [INT]`: Max distance from scaffold anchors (default 100k).
- `-j [INT]`: Max gap for scaffold chaining (default 100k).

### Performance Tuning
- **Threading**: Use `-t` to specify CPU cores.
- **Indexing**: For repetitive runs, save the index to avoid re-calculation:
  ```bash
  # Write index
  wfmash -W index.idx reference.fa query.fa
  # Read index
  wfmash -I index.idx reference.fa query.fa
  ```
- **Segment Size**: Adjust `-w` (window size, default 1k) and `-s` (sketch size) to balance sensitivity and memory usage.

## Output Formats
- **PAF (Default)**: Standard pairwise alignment format.
- **SAM**: Use `-a` for Sequence Alignment Map format.
- **MD Tag**: Use `-d` to include the MD string for mismatch/deletion tracking.

## Reference documentation
- [wfmash GitHub README](./references/github_com_waveygang_wfmash.md)