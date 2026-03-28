---
name: cactus-gfa-tools
description: cactus-gfa-tools is a suite of C++ utilities designed to manipulate pangenome graph alignments and coordinate spaces within the Cactus pipeline. Use when user asks to convert GAF files to PAF, filter redundant alignments, split graphs based on reference designations, or map coordinates between stable sequence and graph-node space.
homepage: https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools
---


# cactus-gfa-tools

## Overview

The `cactus-gfa-tools` suite is a collection of high-performance C++ utilities designed to support the Cactus Pangenome Pipeline. These tools bridge the gap between graph-based alignments (GAF) and traditional pairwise alignments (PAF), allowing researchers to manipulate coordinates between stable sequence space and unstable graph-node space. They are particularly useful for filtering redundant alignments and splitting pangenome graphs based on reference designations.

## Tool-Specific Usage and Best Practices

### GAF to PAF Conversion

Converting minigraph GAF output to PAF requires specific handling of sequence lengths, as GAF files do not inherently contain target sequence lengths.

*   **Stable Coordinates (`gaf2paf`)**: Use this to convert GAF to PAF in stable sequence space (e.g., chromosome names).
    *   **Requirement**: You must provide a lengths table using `-l`.
    *   **Pattern**:
        ```bash
        # Generate lengths table from FASTA indices
        cat *.fai > lengths.tsv
        gaf2paf input.gaf -l lengths.tsv > output.paf
        ```
*   **Unstable Coordinates (`gaf2unstable`)**: Use this when the pipeline requires PAF in node-space (e.g., `s1234`) for better performance.
    *   **Workflow**:
        ```bash
        # 1. Generate unstable GAF and node-lengths table using the rGFA
        gaf2unstable input.gaf -g graph.gfa -o node-lengths.tsv > unstable.gaf
        # 2. Convert the resulting unstable GAF to PAF
        gaf2paf unstable.gaf -l node-lengths.tsv > unstable.paf
        ```

### Alignment Filtering (`gaffilter`)

Use `gaffilter` to resolve overlapping query intervals in GAF or PAF files. This is critical for cleaning up noisy alignments before graph construction.

*   **Heuristic Logic**: The tool keeps records based on primary status, MAPQ, and block length.
*   **Sensitivity**: The default MAPQ/length ratio is 2. Adjust this with `-r` (e.g., `-r 5` for stricter filtering).
*   **PAF Support**: To filter PAF files, you must use the `-p` flag. Note that this expects a `gl` (GAF block length) tag in the PAF.

### Graph Splitting and Assignment (`rgfa-split`)

`rgfa-split` uses rGFA tags to assign query contigs to reference contigs.

*   **Mechanism**: It performs a Breadth-First Search (BFS) from rank-0 nodes to assign every node to its nearest reference contig.
*   **Assignment**: Query contigs are assigned to the reference contig where they have the highest alignment coverage.
*   **Expert Tip**: Use the uniqueness and specificity filters to label low-confidence assignments as "ambiguous" to prevent false-positive mappings in complex regions.

### Coordinate Mapping and Anchoring

*   **`mzgaf2paf`**: Use this for legacy minigraph outputs generated with `-S --write-mz`. It converts minimizer-based GAFs into PAF records with CIGAR strings, which can serve as initial anchors for Cactus.
*   **`rgfa2paf`**: Quickly generate a PAF representing the rank-0 (reference) paths within an rGFA file.
*   **`faprefix.sh`**: A utility script to ensure consistency between FASTA headers and PAF records by adding prefixes (e.g., `mg_anchors`).



## Subcommands

| Command | Description |
|---------|-------------|
| gaf2paf | Convert minigraph GAF to PAF |
| gaf2unstable | Replace stable sequences in path steps, ex >chr1:500-1000, with the unstable graph node names, ex >s1:1-100>s2:100-600 |
| gaffilter | Filter GAF record if its query interval overlaps another query interval based on primary/secondary status, MAPQ ratio, or block length ratio. |
| mzgaf2paf | Convert minigraph --write-mz output(s) to PAF |
| paf2lastz | Convert PAF(s) with cg cigars to LASTZ cigars |
| rgfa-split | Partition rGFA nodes into reference contigs. Input must be uncompressed GFA (not stdin) |

## Reference documentation
- [cactus-gfa-tools README](./references/github_com_ComparativeGenomicsToolkit_cactus-gfa-tools_blob_main_README.md)
- [faprefix.sh source](./references/github_com_ComparativeGenomicsToolkit_cactus-gfa-tools_blob_main_faprefix.sh.md)
- [Makefile build targets](./references/github_com_ComparativeGenomicsToolkit_cactus-gfa-tools_blob_main_Makefile.md)