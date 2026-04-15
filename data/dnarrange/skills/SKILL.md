---
name: dnarrange
description: The dnarrange suite detects and reconstructs complex structural variations by analyzing non-colinear long-read alignments. Use when user asks to identify genomic rearrangements, filter variants using control data, visualize rearrangements with dotplots, generate consensus sequences for read groups, or link breakpoints to reconstruct derivative chromosomes.
homepage: https://github.com/mcfrith/dnarrange
metadata:
  docker_image: "quay.io/biocontainers/dnarrange:1.6.3--pyh7e72e81_0"
---

# dnarrange

## Overview
The `dnarrange` suite provides a specialized pipeline for detecting structural variations that are often difficult to resolve with short-read data. It works by analyzing multi-part alignments of long reads to identify non-colinear patterns, such as translocations, inversions, and large insertions. This skill guides you through the multi-step process of identifying rearranged read groups, filtering out common variants using control data, and reconstructing the architecture of complex rearranged chromosomes.

## Core Workflow

### 1. Finding Rearrangements
The primary command identifies reads that align to the genome in a rearranged fashion.

*   **Basic usage (Case only):**
    `dnarrange case.maf > groups.maf`
*   **With Control data (Recommended):**
    To filter out germline or common variants, provide control alignments after a colon.
    `dnarrange case.maf : control1.maf control2.maf > groups.maf`
*   **Handling Foreign DNA (e.g., Viral Insertion):**
    If looking for insertions of a specific sequence (like a virus) into a host, align reads to a combined index and use:
    `dnarrange --insert=VirusSeqName alignments.maf > groups.maf`

### 2. Sensitivity and Filtering
Adjust these parameters based on your coverage and the expected "cleanliness" of the data.

*   **Minimum Support:** By default, 2 reads are required. For single-read discovery, use `-s1`.
*   **Leniency:** Use `-c0` to find groups with at least 2 reads without requiring every consecutive fragment pair to be supported by 2 reads.
*   **Strict Control Filtering:** Use `-f0` to discard any case read sharing any two rearranged fragments with a control read.

### 3. Visualization
Use `last-multiplot` to generate dotplots for each identified group. This requires `last-dotplot` and the Python Imaging Library (PIL).

`last-multiplot groups.maf output_dir/`

*   **Tip:** Use the `-a` option to overlay gene or repeat annotations if available.
*   **Tip:** Use `-m` to limit the number of reads displayed per group (default is 10).

### 4. Consensus Generation
To improve accuracy, merge reads in a group into a consensus sequence. This requires `lamassemble`.

`dnarrange-merge reads.fq alignment_params.par groups.maf > merged.fa`

After merging, you should re-align the `merged.fa` to the genome using `lastal` with sensitive settings (e.g., `-m20` or `-m50`) to confirm the rearrangement.

### 5. Linking Groups
For large, complex rearrangements involving multiple breakpoints, use `dnarrange-link` to determine the order and orientation of the rearranged segments.

`dnarrange-link -g3,7,8,12 final.maf > linked.txt`

*   **Note:** If no groups are specified with `-g`, it attempts to link all groups.
*   **Output:** Reconstructed "derivative" chromosomes (e.g., `der1`, `der2`).

## Expert Tips
*   **Input Formats:** `dnarrange` natively handles `.maf` files and supports gzipped input (`.gz`).
*   **Memory Management:** Running `dnarrange` on large case datasets without control data can be memory-intensive. If memory is an issue, process controls in a separate step or ensure alignments are pre-filtered.
*   **Strand Orientation:** `dnarrange` automatically attempts to flip read strands so all reads in a group share the same orientation. A `-` suffix on a read name indicates it has been flipped.
*   **Validation:** Always compare the `last-multiplot` output of the merged consensus against the raw read plots to ensure the merging process didn't collapse tandem duplications incorrectly.

## Reference documentation
- [dnarrange GitHub Repository](./references/github_com_mcfrith_dnarrange.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_dnarrange_overview.md)