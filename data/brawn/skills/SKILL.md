---
name: brawn
description: Brawn is a Python-based alignment tool designed to merge sequences into existing reference alignments using a profile-profile approach and a caching system. Use when user asks to align sequences to a reference, build a reference alignment cache, or insert sequences into an existing protein alignment.
homepage: https://github.com/SJShaw/brawn
metadata:
  docker_image: "quay.io/biocontainers/brawn:1.0.2--pyhdfd78af_0"
---

# brawn

# brawn

## Overview
Brawn is a Python-based alignment tool designed to optimize the process of merging sequences into existing alignments. By mimicking MUSCLE's profile-profile mode and implementing a caching system for reference alignments, it eliminates redundant computational overhead. This makes it ideal for workflows where many individual sequences need to be aligned against the same stable reference set, effectively countering the speed loss typically associated with Python-based bioinformatics tools.

## Command Line Usage

### Building a Reference Cache
The primary advantage of Brawn is its caching mechanism. You should build a cache for any reference alignment that will be used multiple times.
```bash
brawn input.fasta --build-cache reference.cache
```
*Note: Building the initial cache may take up to 10 times longer than a standard run, but subsequent uses will be significantly faster.*

### Aligning with a Reference
You can use either a raw FASTA file or a pre-built cache file as your reference alignment.
```bash
# Using a cache file (Recommended for speed)
brawn query.fasta --reference-alignment reference.cache > output.fasta

# Using a standard FASTA file
brawn query.fasta --reference-alignment reference.fasta > output.fasta
```

## Python API Integration

For programmatic workflows, Brawn provides a direct interface for handling alignments and insertions.

### Profile-Profile Alignment
```python
from brawn import Alignment, combine_alignments

# Load alignments
with open("ref.cache") as h1, open("query.fasta") as h2:
    alignment1 = Alignment.from_cache_file(h1)
    alignment2 = Alignment.from_file(h2)

# Combine and save
result = combine_alignments(alignment1, alignment2)
result.to_file(open("output.fasta", "w"))
```

### Single Sequence Insertion
When inserting a single query into a reference alignment, use `insert_into_alignment` for the full set or `get_aligned_pair` to focus on a specific reference sequence.
```python
from brawn import insert_into_alignment

# query_sequence is a string, alignment is a brawn.Alignment object
aligned_query, aligned_refs_dict = insert_into_alignment(query_sequence, alignment)
```

## Best Practices and Tips
- **Protein Focus**: Brawn is explicitly optimized for protein sequences. While DNA/RNA may work, results are most reliable for protein data.
- **Cache Management**: Always prioritize `.cache` files for large reference sets. If the reference alignment changes, the cache must be rebuilt.
- **Output Handling**: The CLI tool outputs to `stdout` by default. Always use redirection (`>`) or pipes to capture the resulting FASTA data.
- **Accuracy**: While Brawn aims for parity with MUSCLE, minor variations may occur, especially in alignments with low identity scores.

## Reference documentation
- [Brawn GitHub Repository](./references/github_com_SJShaw_brawn.md)
- [Brawn Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_brawn_overview.md)