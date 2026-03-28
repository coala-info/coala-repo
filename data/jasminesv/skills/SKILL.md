---
name: jasminesv
description: Jasmine consolidates structural variant calls from multiple VCF files using a network-based approach to group analogous variants across samples. Use when user asks to merge structural variant calls, consolidate VCF files from long-read datasets, or refine insertion sequences using sequence identity.
homepage: https://github.com/mkirsche/Jasmine
---

# jasminesv

## Overview

Jasmine (Jointly Accurate SV Merging with Intersample Network Edges) is a specialized tool designed to consolidate structural variant calls from multiple VCF files. Unlike simple position-based mergers, Jasmine represents SVs as a network and employs a minimum spanning forest algorithm to determine the optimal grouping of analogous variants across samples. It is particularly robust for long-read datasets because it can account for sequence similarity in insertions and handle the inherent "fuzziness" of SV breakpoints using sophisticated distance metrics.

## Core Usage Patterns

### Basic Merging
To merge multiple VCFs, first create a plain-text file containing the absolute or relative paths to each input VCF (one per line).

```bash
# Create the file list
ls *.vcf > samples.txt

# Run Jasmine
jasmine file_list=samples.txt out_file=merged.vcf
```

### Distance and Precision Tuning
Jasmine uses Euclidean distance between breakpoints (start, length) by default.
- **Constant Threshold**: Use `max_dist=1000` (default) for a fixed search radius.
- **Proportional Threshold**: Use `max_dist_linear=0.5` to set the distance threshold as a percentage of the variant length (e.g., 50%).
- **Stricter Merging**: Use `--centroid_merging` to ensure every variant in a merged group is close to the group's center, or `--clique_merging` to require all variants in a group to be pairwise mergeable.

### Handling Long-Read Insertions
For high-error long reads, use sequence identity to improve merging accuracy for insertions.
- **Sequence Identity**: Set `min_seq_id=0.7` to require 70% Jaccard similarity (based on k-mers) for merging insertions.
- **Refinement**: Use `--run_iris` to trigger Iris preprocessing, which refines insertion sequences and breakpoints before merging.

### Preprocessing and Postprocessing
- **Duplication Recovery**: Use `--dup_to_ins` if duplications were likely miscalled as insertions due to sequencing errors. This converts them to insertions for merging and reverts them afterward.
- **Specific Call Marking**: Use `--mark_specific` with `spec_reads=10` and `spec_len=50` to flag high-confidence variants that meet specific support and length criteria.

## Expert Tips

- **Input Consistency**: Ensure all input VCFs contain the `SVTYPE` and `SVLEN` INFO fields. If `SVLEN` is missing, Jasmine will attempt to calculate it from REF/ALT or use the `END` coordinate if `--use_end` is specified.
- **Memory Management**: For very large populations, if you encounter memory issues, use the `split_jasmine` utility to process the genome in chunks (by chromosome or interval) and merge the results.
- **Visualization**: Use the `igv_jasmine` executable to generate batch scripts for IGV. This automates the creation of screenshots for merged variants of interest across all samples.
- **Distance Metrics**: If Euclidean distance (L2 norm) is too permissive for your dataset, switch to Manhattan distance (L1 norm) using `kd_tree_norm=1`.



## Subcommands

| Command | Description |
|---------|-------------|
| igv_jasmine | Jasmine IGV Screenshot Maker |
| jasmine | Merge variants from multiple VCF files. |
| jasmine | Merge variants from multiple VCF files. |

## Reference documentation
- [Jasmine User Manual](./references/github_com_mkirsche_Jasmine_wiki_Jasmine-User-Manual.md)
- [Jasmine GitHub Overview](./references/github_com_mkirsche_Jasmine.md)