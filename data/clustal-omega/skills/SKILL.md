---
name: clustal-omega
description: Clustal Omega is a scalable multiple sequence alignment tool that performs high-accuracy alignments of large genomic or proteomic datasets. Use when user asks to align multiple sequences, merge existing profiles, add new sequences to a seed alignment, or perform HMM-guided alignment.
homepage: https://github.com/hybsearch/clustalo
---


# clustal-omega

## Overview

Clustal Omega is a scalable and highly accurate multiple sequence alignment tool that succeeds ClustalW. It utilizes the HHalign engine and an enhanced mBed clustering algorithm to achieve O(N log N) scaling, making it suitable for massive genomic or proteomic datasets. Use this skill to perform progressive alignments, maintain fixed columns in existing profiles while adding new data, or leverage external profile alignment (EPA) via HMMs.

## Common CLI Patterns

### Basic Multiple Sequence Alignment
To align a set of unaligned sequences (typically in FASTA format):
```bash
clustalo -i sequences.fa -o aligned_output.fa --outfmt=fa
```

### Aligning Two Existing Profiles
To merge two pre-aligned files while keeping their internal columns fixed:
```bash
clustalo --p1 profile1.msf --p2 profile2.msf -o merged_alignment.fa
```

### Adding Sequences to an Existing Alignment
To add new sequences to a "seed" alignment without changing the relative positioning of the original alignment:
```bash
clustalo -i new_sequences.fa --p1 seed_alignment.msf -o combined.fa
```

### HMM-Guided Alignment (External Profile Alignment)
To use a pre-calculated HMM (HMMER2 or HMMER3 format) to guide the alignment of new sequences:
```bash
clustalo -i sequences.fa --hmm-in model.hmm -o hmm_guided_alignment.fa
```

## Expert Tips and Best Practices

- **Sequence Type Auto-detection**: While Clustal Omega usually guesses the sequence type correctly, you can force it using `-t {Protein, RNA, DNA}` to avoid errors in ambiguous datasets.
- **Handling Pre-aligned Input**: If your input file (`-i`) is already aligned but you want to re-align it from scratch, use the `--dealign` flag. By default, Clustal Omega will try to use existing gap information to build a guide HMM.
- **Forcing Profile Mode**: If you have a collection of sequences that are all the same length but contain no gaps, the tool may not recognize them as a profile. Use `--is-profile` to force the tool to treat the input as a fixed alignment.
- **Format Support**: The tool supports multiple formats including `a2m`, `clustal`, `msf`, `phylip`, `selex`, `stockholm`, and `vienna`. Use `--infmt` and `--outfmt` if you need to convert between formats during the alignment process.
- **Large Datasets**: For extremely large datasets, ensure your input is in FASTA format as it is the most memory-efficient for the initial mBed clustering phase.

## Reference documentation
- [Clustal Omega README](./references/github_com_hybsearch_clustalo.md)