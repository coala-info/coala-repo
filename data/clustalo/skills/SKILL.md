---
name: clustalo
description: Clustal Omega is a high-performance tool for performing multiple sequence alignments of protein or nucleotide sequences using seeded guide trees and HMM profile-profile techniques. Use when user asks to align multiple sequences, add new sequences to an existing alignment, or convert between bioinformatics file formats like Clustal, Stockholm, and Vienna.
homepage: http://www.clustal.org/omega/
metadata:
  docker_image: "biocontainers/clustalo:v1.2.4-2-deb_cv1"
---

# clustalo

## Overview
Clustal Omega (clustalo) is the latest generation of the Clustal family, designed for high-performance multiple sequence alignment. It utilizes seeded guide trees and HMM profile-profile techniques to provide significantly better scalability than its predecessors (ClustalW/X). This skill provides the necessary command-line patterns to execute alignments, manage large datasets, and convert between bioinformatics file formats.

## Common CLI Patterns

### Basic Alignment
Perform a default alignment of a protein or nucleotide FASTA file:
```bash
clustalo -i sequences.fasta -o aligned_sequences.fasta
```

### Specifying Sequence Type
While clustalo usually auto-detects, you can force the sequence type:
```bash
# For protein sequences
clustalo -i input.fasta --seqtype=Protein -o output.fasta

# For DNA/RNA sequences
clustalo -i input.fasta --seqtype=DNA -o output.fasta
```

### Output Formats
Control the output format using the `--outfmt` flag (default is fasta):
```bash
# Clustal format
clustalo -i input.fasta -o output.aln --outfmt=clu

# Stockholm format
clustalo -i input.fasta -o output.sto --outfmt=st

# VIENNA format
clustalo -i input.fasta -o output.vie --outfmt=vie
```

### Working with Large Datasets
For very large alignments, use multiple processors to speed up the calculation:
```bash
clustalo -i large_input.fasta -o output.fasta --threads=8
```

### Adding Sequences to an Existing Alignment
To add new sequences to a profile (an existing alignment) without re-aligning the original set:
```bash
clustalo --p1 existing_alignment.fasta -i new_sequences.fasta -o combined_alignment.fasta
```

## Expert Tips
- **Memory Management**: For extremely large datasets (10,000+ sequences), use the `--iterative` flag to refine the alignment, though this increases computation time.
- **Distance Matrices**: If you need the distance matrix generated during the alignment process, use `--distmat-out=matrix.txt`.
- **Clustering**: Clustal Omega uses mBed for clustering, which is very fast. If you have a pre-computed guide tree, you can provide it with `--guidetree-in=tree.txt` to save time.
- **Verbosity**: Use `-v` or `-vv` to monitor progress during long-running alignments to ensure the process hasn't stalled.

## Reference documentation
- [Clustal Omega Overview](./references/anaconda_org_channels_bioconda_packages_clustalo_overview.md)