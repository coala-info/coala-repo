---
name: virchip
description: The `virchip` tool implements a multi-layer perceptron model to predict TF binding sites without requiring new ChIP-seq experiments.
homepage: https://virchip.hoffmanlab.org
---

# virchip

## Overview
The `virchip` tool implements a multi-layer perceptron model to predict TF binding sites without requiring new ChIP-seq experiments. It is particularly useful for studying TFs in rare cell types or tissues where experimental ChIP-seq is impractical. By integrating existing ChIP-seq data with cell-type-specific accessibility and expression data, it identifies both direct and indirect binding events.

## Input Requirements
To use `virchip` effectively, ensure your input data meets the following specifications:

- **Chromatin Accessibility**: Must be in `narrowPeak` format (from ATAC-seq or DNase-seq).
- **Transcriptome Data**: A matrix where:
    - Rows are human gene symbols.
    - Columns are cell types (at least one column for the cell type of interest).
    - Values are normalized (TPM, FPKM, or RPKM). **Do not use raw read counts.**
- **Hardware Considerations**: 
    - Generating input tables: ~6 CPU hours per TF.
    - Memory: Minimum 8GB RAM.
    - Model application: ~20 minutes per TF.

## CLI Usage and Workflow
The tool is primarily distributed via Bioconda. Install using:
`conda install bioconda::virchip`

### Prediction Logic
- **TF Support**: The model is trained for 36 specific TFs (including CTCF, RAD21, SMC3, NRF1, and various FOS/JUN family members).
- **Thresholding**: 
    - For TFs with H1-hESC validation data, use the posterior probability cutoff that maximizes the Matthews correlation coefficient (MCC).
    - For TFs without H1-hESC data, use the default optimal cutoff of **0.4**.

### Performance Benchmarks
When interpreting results, note that performance varies by TF. High-confidence predictions (MCC > 0.6) are typically observed for:
- CTCF (MCC: 0.686)
- NRF1 (MCC: 0.680)
- RAD21 (MCC: 0.626)
- SMC3 (MCC: 0.734)

## Expert Tips
- **Indirect Binding**: Unlike PWM-based methods, `virchip` can predict binding for TFs without known sequence preferences by learning from the association between gene expression and genomic regions.
- **Roadmap Integration**: If working with standard human tissues, check the Virtual ChIP-seq track hub first, as predictions for 33 Roadmap tissues are already pre-computed.
- **Gene Symbols**: Ensure your RNA-seq matrix uses official HGNC gene symbols to match the internal model features.

## Reference documentation
- [Virtual ChIP-seq Overview](./references/virchip_hoffmanlab_org_index.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_virchip_overview.md)