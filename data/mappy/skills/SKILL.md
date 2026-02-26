---
name: mappy
description: Mappy provides a Python interface for the minimap2 aligner to perform rapid pairwise alignment of genomic and spliced nucleotide sequences. Use when user asks to map long noisy reads, perform splice-aware alignments, find sequence overlaps, or parse FASTA and FASTQ files within a Python pipeline.
homepage: https://github.com/lh3/minimap2
---


# mappy

## Overview
`mappy` is the official Python binding for `minimap2`, a versatile and industry-standard pairwise aligner for genomic and spliced nucleotide sequences. This skill enables the integration of high-speed alignment directly into Python-based bioinformatics pipelines, avoiding the overhead of subprocess calls to the `minimap2` executable. It is specifically designed for mapping long noisy reads (ONT/PacBio), finding overlaps, and performing splice-aware alignments against reference genomes.

## Installation
Install `mappy` via bioconda or pip:
```bash
conda install bioconda::mappy
# OR
pip install mappy
```

## Core Usage Patterns

### Basic Alignment
The primary interface is the `Aligner` class.
```python
import mappy as mp

# Initialize aligner and index the reference
# Use a preset for specific data types (e.g., 'map-ont', 'map-pb', 'sr')
aligner = mp.Aligner("reference.fa", preset="map-ont")
if not aligner: raise Exception("ERROR: failed to load/build index")

# Map a single sequence
seq = "ACGT..." 
for hit in aligner.map(seq):
    print(f"{hit.ctg}\t{hit.r_st}\t{hit.r_en}\t{hit.cigar_str}")
```

### Reading FASTA/FASTQ Files
`mappy` includes a fast sequence parser (`fastx_read`) that handles gzipped files automatically.
```python
for name, seq, qual in mp.fastx_read("reads.fastq.gz"):
    for hit in aligner.map(seq):
        # Process alignment hits
        pass
```

### Using Presets
Always select the appropriate preset to ensure the internal parameters (k-mer size, window size, gap penalties) are optimized for your data:
- `map-ont`: Oxford Nanopore genomic reads.
- `map-pb`: PacBio CLR genomic reads.
- `map-hifi`: PacBio HiFi/CCS genomic reads.
- `sr`: Short genomic paired-end reads.
- `splice`: Long-read spliced alignment (mRNA/cDNA).
- `asm5`: Assembly-to-assembly alignment (~0.1% divergence).
- `ava-ont` / `ava-pb`: All-against-all overlap detection.

## Expert Tips and Best Practices

### Index Persistence
For large genomes (e.g., Human), re-indexing the `.fa` file every time is slow. Save the index to a `.mmi` file using the `minimap2` CLI and load it in `mappy` for near-instant initialization.
```bash
# CLI: Create index
minimap2 -d human.mmi human.fa
```
```python
# Python: Load pre-built index
aligner = mp.Aligner("human.mmi") 
```

### Accessing Alignment Details
The `hit` object returned by `aligner.map()` contains several high-utility attributes:
- `hit.ctg`: Name of the reference contig.
- `hit.r_st` / `hit.r_en`: Reference start and end positions.
- `hit.q_st` / `hit.q_en`: Query start and end positions.
- `hit.mlen`: Number of matching bases in the alignment.
- `hit.blen`: Total length of the alignment (including gaps).
- `hit.mapq`: Mapping quality.
- `hit.is_primary`: Boolean indicating if the alignment is primary.
- `hit.cigar_str`: CIGAR string for base-level alignment.

### Memory Management
When processing millions of reads, ensure the `Aligner` object is initialized once outside the loop. If you need to change parameters (like `k` or `w`), you must create a new `Aligner` instance.

### Spliced Alignment
For RNA-seq, use the `splice` preset. If you have a specific strand preference (e.g., GT-AG signals), use the `extra_flags` or specific parameters if available in the version's constructor to mimic `-uf`.

## Reference documentation
- [Minimap2 GitHub Repository](./references/github_com_lh3_minimap2.md)
- [Mappy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mappy_overview.md)