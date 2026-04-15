---
name: locarna
description: LocARNA performs simultaneous alignment and folding of RNA sequences to identify common secondary structures. Use when user asks to perform multiple or pairwise RNA structural alignment, align sequences with low sequence identity, or use sparsified alignment for long RNA sequences.
homepage: https://s-will.github.io/LocARNA
metadata:
  docker_image: "quay.io/biocontainers/locarna:2.0.1--pl5321h4ac6f70_0"
---

# locarna

## Overview

LocARNA (Local Alignment of RNA) provides a suite of tools for the structural analysis of RNA by performing simultaneous alignment and folding. Unlike standard sequence aligners, LocARNA implements a computationally efficient version of the Sankoff algorithm to identify common secondary structures while aligning sequences. This makes it the preferred tool for RNAs in the "twilight zone" of sequence identity. The skill covers the primary command-line interfaces for multiple alignment (`mlocarna`), pairwise alignment (`locarna`), and high-performance sparsified alignment (`sparse`).

## General Usage Patterns

### Multiple Sequence Alignment
Use `mlocarna` as the high-level interface for aligning three or more RNA sequences.
*   Perform a basic progressive alignment:
    `mlocarna sequences.fa`
*   Run in probabilistic mode for improved accuracy via consistency transformation:
    `mlocarna --probabilistic sequences.fa`
*   Specify a target directory for output files:
    `mlocarna --tgtdir output_folder sequences.fa`

### Pairwise Alignment
Use `locarna` for detailed comparison of two RNA sequences or alignments.
*   Align two sequences in FASTA format:
    `locarna seq1.fa seq2.fa`
*   Perform sequence-local alignment (finding best matching subsequences):
    `locarna --sequ-local=true seq1.fa seq2.fa`
*   Perform structure-local alignment (aligning best matching substructures):
    `locarna --struct-local=true seq1.fa seq2.fa`

### High-Performance Alignment
Use `sparse` for faster pairwise alignment with stronger sparsification, especially useful for longer sequences.
*   Execute sparsified alignment:
    `sparse seq1.fa seq2.fa`
*   Enable Maximum Expected Accuracy (MEA) alignment:
    `sparse --mea-alignment seq1.fa seq2.fa`

## Expert Tips and Best Practices

### Balancing Sequence and Structure
*   Adjust the `--struct-weight` (default 200) to control the influence of secondary structure relative to sequence similarity. Increase this value if the sequences are highly divergent but structurally conserved.
*   Use the `--tau` factor (0-100) to control sequence-dependent scoring within arc matches. Setting `tau=0` ignores sequence similarity in base pairs, focusing purely on structural compatibility.

### Optimization and Speed
*   Filter low-probability base pairs using `-p` or `--min-prob` (default 0.001). Increasing this threshold (e.g., to 0.01) significantly speeds up computation by ignoring unlikely structural features.
*   Limit the search space for arc matches using `-D` or `--max-diff-am`. This restricts the difference in length between matched arcs, which is effective for aligning RNAs of similar size.

### Handling Constraints
*   Provide folding constraints (e.g., forcing specific base pairs) or alignment anchors (forcing specific columns to align) within the input FASTA, Clustal, or Stockholm files.
*   Use `--relaxed-anchors` if anchor names in the input files should be treated as suggestions rather than strict requirements.

### Output Management
*   Generate consensus structures in specific formats using `--stockholm` or `--clustal`.
*   Visualize results by checking the `results/` subdirectory in the output folder, which typically contains the alignment (`result.aln`) and consensus structure information.

## Reference documentation
- [LocARNA: Alignment of RNAs](./references/s-will_github_io_LocARNA.md)
- [mlocarna manual page](./references/s-will_github_io_LocARNA_md_src_Utils_mlocarna.html.md)
- [locarna manual page](./references/s-will_github_io_LocARNA_md__build_Doc_man_locarna.html.md)
- [sparse manual page](./references/s-will_github_io_LocARNA_md__build_Doc_man_sparse.html.md)
- [exparna_p manual page](./references/s-will_github_io_LocARNA_md__build_Doc_man_exparna_p.html.md)