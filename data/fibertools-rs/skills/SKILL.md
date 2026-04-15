---
name: fibertools-rs
description: fibertools-rs processes Fiber-seq data to predict epigenetic features like m6A sites and nucleosome positions. Use when user asks to predict m6A sites, identify nucleosome positions, extract Fiber-seq features into text formats, or center reads for visualization.
homepage: https://github.com/mrvollger/fibertools-rs
metadata:
  docker_image: "quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0"
---

# fibertools-rs

## Overview
This skill enables the processing and analysis of Fiber-seq data using the `fibertools-rs` (command: `ft`) toolkit. It is designed for researchers needing to transform raw HiFi kinetics into epigenetic annotations (m6A and nucleosomes) and extract these features into accessible formats for downstream analysis.

## Core CLI Patterns

### 1. Epigenetic Feature Prediction
The primary workflow involves predicting m6A sites and subsequently identifying nucleosome positions.

*   **Predict m6A**: Converts HiFi kinetics into m6A tags (MM/ML).
    ```bash
    ft predict-m6a input.bam output.m6a.bam
    ```
    *Note: This command automatically runs nucleosome calling in the background by default.*

*   **Add Nucleosomes**: Use this if you already have m6A-tagged BAMs or need to re-run nucleosome calling with custom parameters.
    ```bash
    ft add-nucleosomes m6a_tagged.bam output.nucleosomes.bam
    ```

### 2. Data Extraction
Convert complex BAM tags into human-readable text formats for analysis in R, Python, or shell.

*   **Extract Fiber-seq Data**:
    ```bash
    ft extract input.bam --all features.txt
    ```
    This extracts m6A positions, nucleosome positions, and accessible regions.

### 3. Visualization and Centering
Prepare data for aggregate plots (e.g., heatmaps or enrichment plots) around specific genomic features.

*   **Center Reads**: Re-coordinates reads relative to a specific reference position.
    ```bash
    ft center --bed sites.bed input.bam > centered.bam
    ```

*   **Footprinting**: Analyze motifs and surrounding accessibility.
    ```bash
    ft footprint --motif TATABOX input.bam
    ```

## Expert Tips
*   **Performance**: The Bioconda version of `fibertools-rs` is CPU-only. For large-scale m6A prediction, use the GPU-accelerated version (requires manual installation of libtorch) to significantly reduce processing time.
*   **Tagging**: `fibertools-rs` adheres to the SAMtags specification for base modifications (MM and ML tags). Ensure your downstream tools (like IGV or specialized libraries) are compatible with these tags.
*   **Help Access**: Use `ft --help` for a list of all subcommands, or `ft <subcommand> --help` (e.g., `ft predict-m6a --help`) for specific parameter details.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_fiberseq_fibertools-rs.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_fibertools-rs_overview.md)