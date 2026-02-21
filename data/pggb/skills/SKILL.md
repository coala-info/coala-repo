---
name: pggb
description: The PanGenome Graph Builder (`pggb`) is a sophisticated pipeline designed to render a collection of genomes into a single, unified variation graph.
homepage: https://github.com/pangenome/pggb
---

# pggb

## Overview
The PanGenome Graph Builder (`pggb`) is a sophisticated pipeline designed to render a collection of genomes into a single, unified variation graph. Unlike linear reference genomes, pangenome graphs represent all variations—including large structural variants—as paths through a shared graph structure. The pipeline integrates several specialized tools: `wfmash` for all-to-all alignment, `seqwish` for graph induction, `smoothxg` and `gfaffix` for normalization, and `odgi` for visualization. This skill provides the necessary command-line patterns and parameter logic to execute the pipeline effectively.

## Core Workflow and CLI Patterns

### 1. Input Preparation
Before running `pggb`, ensure your sequences are consolidated and indexed.
- **Consolidate**: Combine all sequences into a single FASTA file.
- **Index**: Use `samtools faidx in.fa`.
- **Naming**: Use the **PanSN** naming convention (`[sample]#[haplotype]#[contig]`) to allow `pggb` to automatically detect the number of haplotypes and organize paths.

### 2. Basic Graph Construction
To build a graph with standard parameters (e.g., 9 haplotypes, 5kb segments, 90% identity):
```bash
pggb -i in.fa -o output_dir -n 9 -t 16 -p 90 -s 5k
```

### 3. Variant Calling (VCF)
To generate a VCF report against a specific reference genome included in the graph:
```bash
pggb -i in.fa -o output_dir -n 9 -t 16 -V 'ref_name:1000'
```
*Note: This decomposes variants smaller than or equal to 1000bp.*

### 4. Large-Scale Genomes (Partitioning)
For whole-genome assemblies, it is often more efficient to partition sequences by "communities" (usually chromosomes) before building the full graph:
```bash
partition-before-pggb -i in.fa -o output_dir -n 9 -t 16 -p 90 -s 5k
```
This command generates the specific `pggb` execution strings for each detected community, which can then be run in parallel.

## Parameter Optimization Tips

- **Segment Length (`-s`)**: This is the seed length for the `wfmash` mapper. Larger values (e.g., `10k`, `20k`) increase speed and reduce sensitivity to highly divergent regions, while smaller values (e.g., `1k`, `5k`) are better for more divergent sequences.
- **Pairwise Identity (`-p`)**: Sets the minimum alignment identity. Use higher values (e.g., `95` or `98`) for closely related individuals of the same species to reduce graph complexity.
- **Match Filter (`-k`)**: Use `-k N` to prune matches shorter than N base pairs. This is critical for removing ambiguous alignments that create "hairballs" in the initial graph scaffold.
- **Block Length (`-l`)**: Mappings are initiated from collinear chains of seeds. Adjusting this affects how fragmented or continuous the initial alignments are.

## Output Files
The primary output is a GFAv1 file (usually ending in `*final.gfa`). `pggb` also generates:
- **1D/2D Visualizations**: PNG files created by `odgi` to inspect graph topology.
- **VCF Files**: If `-V` is specified, containing the variant calls relative to the chosen reference.

## Reference documentation
- [pggb GitHub Repository](./references/github_com_pangenome_pggb.md)
- [pggb Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pggb_overview.md)