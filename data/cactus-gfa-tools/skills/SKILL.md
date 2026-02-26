---
name: cactus-gfa-tools
description: This tool provides utilities for converting, filtering, and processing graph-based alignments between GAF and PAF formats. Use when user asks to convert GAF to PAF, filter overlapping alignments, project graph coordinates to stable reference space, or split query contigs by reference coverage.
homepage: https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools
---


# cactus-gfa-tools

## Overview
This skill provides specialized procedures for using the `cactus-gfa-tools` suite. These utilities are essential for bridging the gap between graph-based alignments (GAF) and linear sequence alignments (PAF). Use these tools to prepare data for the Minigraph-Cactus pipeline, filter overlapping alignments, or project graph coordinates back into stable reference sequence space.

## Core Workflows and CLI Patterns

### Converting GAF to PAF
The `gaf2paf` tool converts minigraph output to stable sequence space. Because GAF files do not contain target sequence lengths, you must provide them manually.

**Standard Pattern:**
1. Generate sequence lengths (using `samtools faidx`).
2. Run conversion with the `-l` flag.

```bash
# Generate lengths table
cat ref1.fa.fai ref2.fa.fai > lengths.tsv

# Convert GAF to PAF
gaf2paf input.gaf -l lengths.tsv > output.paf
```

### Working with Unstable Coordinates
For optimal performance in the Minigraph-Cactus pipeline, alignments often need to be in "unstable" coordinates (referencing graph nodes like `s1` rather than contigs like `chr1`).

**Workflow:**
1. Use `gaf2unstable` to generate a node-lengths table and the unstable GAF.
2. Use `gaf2paf` with that specific node-lengths table.

```bash
# Generate unstable GAF and node-lengths
gaf2unstable input.gaf -g graph.gfa -o node-lengths.tsv > unstable.gaf

# Convert to unstable PAF
gaf2paf unstable.gaf -l node-lengths.tsv > unstable.paf
```

### Alignment Filtering
Use `gaffilter` to remove overlapping query intervals using heuristics (MapQ and block length).

*   **Default Behavior:** Keeps a record if it doesn't overlap, is primary, or has significantly higher MapQ/length (2x by default).
*   **PAF Support:** Use the `-p` flag to filter PAF files (requires the `gl` tag from the original GAF).
*   **Sensitivity:** Adjust the ratio threshold with `-r` (default is 2).

```bash
# Filter GAF
gaffilter input.gaf > filtered.gaf

# Filter PAF with custom ratio
gaffilter -p -r 3 input.paf > filtered.paf
```

### Reference-Based Contig Splitting
The `rgfa-split` tool assigns query contigs to reference contigs based on alignment coverage and rGFA tags. This is useful for partitioning pangenome data by chromosome.

1. It assigns graph nodes to the nearest rank-0 (reference) node via BFS.
2. It calculates alignment coverage for query contigs against these reference assignments.
3. It outputs assignments based on the highest alignment coverage.

### Legacy Tool Notes
*   **paf2lastz:** Converts PAF with `cg` cigars to LASTZ cigars. Note that modern Cactus versions handle PAF natively, making this tool largely optional.
*   **mzgaf2paf:** Previously used for minimizer-based conversion. Since `minigraph` now produces cigars with `-c`, use `gaf2paf` instead.

## Expert Tips
*   **Cigars:** Ensure `minigraph` is run with the `-c` flag; otherwise, conversion tools like `gaf2paf` will lack the necessary CIGAR data for valid PAF output.
*   **Sequence Names:** When concatenating `.fai` files for the `-l` parameter, ensure there are no duplicate sequence names across different reference files, as this will cause coordinate mapping errors.
*   **Memory Management:** For very large pangenome graphs, `rgfa-split` performs a Breadth-First Search (BFS) on the graph structure; ensure sufficient RAM is available for the GFA topology.

## Reference documentation
- [Cactus-GFA-Tools GitHub Repository](./references/github_com_ComparativeGenomicsToolkit_cactus-gfa-tools.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cactus-gfa-tools_overview.md)