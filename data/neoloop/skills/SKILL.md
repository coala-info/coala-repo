---
name: neoloop
description: NeoLoopFinder is a computational framework for detecting 3D genomic disruptions and novel chromatin interactions induced by structural variations in rearranged genomes. Use when user asks to calculate CNV profiles from Hi-C data, assemble complex structural variations, or call neo-loops and neo-TADs across breakpoints.
homepage: https://github.com/XiaoTaoWang/NeoLoopFinder
---


# neoloop

## Overview

NeoLoopFinder is a specialized computational framework for detecting 3D genomic disruptions in rearranged genomes. It allows researchers to identify "neo-loops"—novel chromatin interactions induced by structural variations such as translocations, inversions, and large deletions—which often lead to enhancer-hijacking and oncogene activation. The tool provides a modular pipeline to calculate and correct for CNV effects in Hi-C data, assemble complex SVs, and call loops or TADs across breakpoints.

## Core Workflow and CLI Patterns

### 1. CNV Inference and Segmentation
Before calling loops, you must account for the effects of copy number variations on Hi-C signal intensity.

*   **Calculate CNV Profile**: Use a specific resolution from an `.mcool` file.
    ```bash
    calculate-cnv -H sample.mcool::/resolutions/25000 -g hg38 -e MboI --output sample_25k.CNV-profile.bedGraph
    ```
    *   **Genomes (-g)**: Supports `hg38`, `hg19`, `mm10`, `mm9`.
    *   **Enzymes (-e)**: Supports `HindIII`, `MboI`, `DpnII`, `BglII`, `Arima`, or `uniform`.

*   **Segment CNV**: Identify discrete copy number regions.
    ```bash
    segment-cnv --cnv-file sample_25k.CNV-profile.bedGraph --binsize 25000 --ploidy 2 --output sample_25k.CNV-seg.bedGraph
    ```

### 2. SV Assembly and Reconstruction
NeoLoopFinder reconstructs the local Hi-C environment by "stitching" together the genomic regions flanking SV breakpoints.

*   **Assemble Complex SVs**: Input a list of simple SVs and the Hi-C matrix.
    ```bash
    assemble-complexSVs -S sv_list.txt -H sample.cool --output ./sv_assemblies/
    ```

### 3. Neo-Loop and Neo-TAD Calling
Once the local maps are reconstructed, use these scripts to identify the actual interactions.

*   **Call Neo-Loops**:
    ```bash
    neoloop-caller -S ./sv_assemblies/ -H sample.cool --output neo_loops.bedpe
    ```

*   **Call Neo-TADs**:
    ```bash
    neotad-caller -S ./sv_assemblies/ -H sample.cool --output neo_tads.bed
    ```

## Expert Tips and Best Practices

*   **Chromosome Naming**: Ensure your `.cool` files use the "chr" prefix (e.g., `chr1` instead of `1`). If missing, use the utility script `add_prefix_to_cool.py` before running `calculate-cnv`.
*   **Matrix Balancing**: Always run `cooler balance` on your `.cool` files before performing CNV correction (`correct-cnv`) to ensure the underlying contact matrix is normalized.
*   **Resolution Selection**: While 25kb or 50kb is often sufficient for CNV inference, neo-loop calling typically requires higher resolutions (5kb or 10kb) to accurately capture enhancer-promoter interactions.
*   **Uniform Enzymes**: If using sequence-independent or uniform-cutting enzymes, specify `-e uniform` during the CNV calculation step.
*   **Searching by Gene**: Use `searchSVbyGene` to quickly identify which SV assemblies involve a specific oncogene of interest.

## Reference documentation
- [NeoLoopFinder Main Documentation](./references/github_com_XiaoTaoWang_NeoLoopFinder.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_neoloop_overview.md)