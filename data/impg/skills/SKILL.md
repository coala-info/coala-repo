---
name: impg
description: `impg` (implicit pangenome graphs) is a specialized tool for rapidly navigating genomic variation across populations.
homepage: https://github.com/pangenome/impg
---

# impg

## Overview
`impg` (implicit pangenome graphs) is a specialized tool for rapidly navigating genomic variation across populations. Unlike traditional methods that require building explicit, often computationally expensive pangenome graphs, `impg` treats all-vs-all pairwise alignments as a network. It allows users to project a specific target range (like a disease gene or regulatory element) through this network to find all homologous sequences in seconds.

## Core CLI Patterns

### Basic Region Projection
To find where a specific region aligns across other genomes:
`impg query -a alignments.paf -r seq_name:start-end`

### Transitive Closure Search
To discover all sequences connected to a target range through intermediate alignments (matches of matches), use the `-x` flag. This is essential for finding homology that isn't directly aligned to your reference:
`impg query -a alignments.paf -r seq_name:start-end -x`

### Extracting Sequences and Graphs
When generating sequence-based outputs (FASTA, GFA, MAF), you must provide the underlying sequence files via `--sequence-files` or a `--sequence-list` file:
`impg query -a alignments.paf -r chr1:1000-2000 -o fasta --sequence-files genomes.fa`

Common output formats (`-o`):
- `bed` / `bedpe`: Standard coordinate-based results.
- `fasta`: Homologous sequence extraction.
- `gfa`: Local pangenome graph structure for the queried region.
- `fasta-aln`: POA-based multiple sequence alignment (MSA).

## Expert Tips and Best Practices

### Alignment Requirements
`impg` requires PAF files to have CIGAR strings using `=` (match) and `X` (mismatch) rather than the generic `M`.
- **Minimap2**: Always use the `--eqx` flag.
- **Wfmash**: Generates compatible PAFs by default.

### Performance Optimization
- **Approximate Mode**: For very large datasets using `.1aln` files, use `--approximate` to significantly speed up coordinate projection.
- **Transitive Depth**: Use `-m <int>` to limit the recursion depth of transitive searches. This prevents the search from "blooming" or stalling in highly repetitive genomic regions.
- **Merging**: Use `-d <int>` to merge results within a certain distance, which is helpful for cleaning up fragmented alignments.

### Working with Compressed Data
`impg` natively supports BGZF-compressed PAF files and AGC (Assembled Genome Compressed) archives for efficient sequence storage:
`impg query -a aln.paf.gz -r chr1:1-1000 -o gfa --sequence-files genomes.agc`

### Visualization
To visualize the results of a query, pipe the `fasta-aln` output directly into the provided visualization script:
`impg query -a aln.paf -r chr1:1-1000 -o fasta-aln --sequence-files genomes.fa | python scripts/faln2html.py -i -`

## Reference documentation
- [impg GitHub Repository](./references/github_com_pangenome_impg.md)
- [impg Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_impg_overview.md)