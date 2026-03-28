---
name: neoloop
description: NeoLoopFinder is a computational framework designed to reconstruct local genomic architecture and identify chromatin disruptions such as neo-loops and neo-TADs caused by structural variations. Use when user asks to infer copy number variations from Hi-C data, correct Hi-C matrices for CNV effects, assemble complex structural variations, or call neo-loops and neo-TADs.
homepage: https://github.com/XiaoTaoWang/NeoLoopFinder
---


# neoloop

## Overview

NeoLoopFinder is a computational framework designed to detect chromatin disruptions caused by structural variations like translocations, large deletions, and inversions. Unlike standard Hi-C tools that assume a reference genome, NeoLoopFinder reconstructs the local genomic architecture surrounding SV breakpoints. Use this skill to execute the full pipeline: from inferring and correcting CNV effects in Hi-C maps to assembling complex SVs and calling neo-loops that may drive oncogene expression through enhancer-hijacking.

## Core Workflow and CLI Patterns

### 1. Copy Number Variation (CNV) Inference
Before calling loops, you must account for the bias introduced by copy number changes in cancer genomes.

*   **Calculate CNV Profile**: Use a specific resolution from an `.mcool` file.
    ```bash
    calculate-cnv -H sample.mcool::resolutions/25000 -g hg38 -e MboI --output sample_25k.CNV.bedGraph
    ```
    *   **Genomes**: Supports `hg38`, `hg19`, `mm10`, `mm9`.
    *   **Enzymes**: Supports `HindIII`, `MboI`, `DpnII`, `BglII`, `Arima`, or `uniform` (for sequence-independent cutting).

*   **Segment and Plot**:
    ```bash
    segment-cnv -i sample_25k.CNV.bedGraph --output sample_25k.CNV.segments.bed
    plot-cnv -i sample_25k.CNV.bedGraph -s sample_25k.CNV.segments.bed -g hg38 --output cnv_plot.png
    ```

### 2. Hi-C Matrix Correction
Remove CNV and allele effects to ensure interaction signals are driven by 3D structure rather than DNA abundance.
```bash
correct-cnv -H sample.mcool::resolutions/5000 -s sample_25k.CNV.segments.bed --output sample_5k.corrected.cool
```

### 3. SV Assembly and Neo-Loop Calling
Reconstruct the rearranged genome and identify new loops crossing breakpoints.

*   **Assemble Complex SVs**: Combine simple SV calls with Hi-C data to resolve complex rearrangements.
    ```bash
    assemble-complexSVs -i sv_list.txt -H sample.cool --output sv_assemblies.txt
    ```
*   **Call Neo-Loops**: Identify interactions across the reconstructed breakpoints.
    ```bash
    neoloop-caller -i sv_assemblies.txt -H sample.cool --output neo_loops.bedpe
    ```
*   **Call Neo-TADs**: Identify new Topologically Associating Domains formed by SVs.
    ```bash
    neotad-caller -i sv_assemblies.txt -H sample.cool --output neo_tads.txt
    ```

### 4. Gene-Centric Analysis
Search for SVs affecting specific oncogenes or regions of interest.
```bash
searchSVbyGene -i sv_assemblies.txt -g MYC
```

## Expert Tips and Best Practices

*   **Chromosome Prefixes**: Ensure your `.cool` files use the `chr` prefix (e.g., `chr1` not `1`). If missing, use the provided `add_prefix_to_cool.py` script before running `calculate-cnv`.
*   **Matrix Balancing**: Always run `cooler balance` on your `.cool` files before performing CNV correction (`correct-cnv`).
*   **Resolution Selection**: 25kb is generally recommended for CNV inference, while 5kb or 10kb is preferred for neo-loop calling to achieve high-resolution breakpoint reconstruction.
*   **Enzyme Parameter**: If your Hi-C library was generated with a sequence-independent or uniform-cutting enzyme, specify `-e uniform` in `calculate-cnv` to avoid restriction-site density bias.
*   **Input SVs**: The `assemble-complexSVs` tool expects a list of simple SVs. High-quality SV calls from WGS (e.g., Manta, Delly) improve the accuracy of the Hi-C reconstruction.



## Subcommands

| Command | Description |
|---------|-------------|
| assemble-complexSVs | Assemble complex SVs given an individual SV list. |
| calculate-cnv | Calculate the copy number variation profile from Hi-C map using a generalized additive model with the Poisson link function |
| neoloop-caller | Identify novel loop interactions across SV points. |
| neoloop_add_prefix_to_cool.py | Adds a prefix to the chromosome names in a .cool file. |
| neotad-caller | Identify neo-TADs. |
| searchSVbyGene | Search matched SV regions by gene. |
| segment-cnv | Perform HMM segmentation on a pre-calculated copy number variation profile. |

## Reference documentation
- [NeoLoopFinder GitHub README](./references/github_com_XiaoTaoWang_NeoLoopFinder_blob_master_README.rst.md)
- [NeoLoopFinder Overview](./references/anaconda_org_channels_bioconda_packages_neoloop_overview.md)