---
name: scar
description: "Removes ambient signal noise from droplet-based single-cell omics data. Use when user asks to denoise ambient signals from single-cell RNA-seq, CITE-seq, scATAC-seq, or scCRISPRseq data."
homepage: https://github.com/Novartis/scAR
---


# scar

scar/SKILL.md
```yaml
name: scar
description: |
  Removes ambient signal noise from droplet-based single-cell omics data.
  Use when dealing with single-cell RNA-seq, CITE-seq, scATAC-seq, or scCRISPRseq data
  and requiring denoising of ambient signals to improve downstream analysis.
```
## Overview
scAR (single-cell Ambient Remover) is a deep learning model designed to denoise ambient signals present in droplet-based single-cell omics data. It is applicable to various single-cell modalities including mRNA (scRNAseq), protein (CITE-seq), ATAC (scATACseq), and sgRNA (scCRISPRseq). Use scAR when you need to clean your single-cell data by removing background noise that can interfere with accurate cell type identification, gene expression quantification, or other downstream analyses.

## Usage Instructions

scAR is typically used via its command-line interface (CLI). The primary function is to process input data (e.g., count matrices) and output denoised data.

### Installation

Install scAR using conda from the bioconda channel:
```bash
conda install bioconda::scar
```

### Core Functionality

The main command for running scAR is `scar`. While specific command-line arguments can vary based on the version and desired output, a common pattern involves specifying input data and output paths.

**General Command Structure:**

```bash
scar --input <input_file_path> --output <output_file_path> [options]
```

**Key Considerations and Tips:**

*   **Input Data Format**: scAR typically expects count matrices. Ensure your input data is in a compatible format (e.g., `.h5ad`, `.mtx` with associated gene/cell metadata). Refer to the official documentation for precise format requirements.
*   **Output Data**: The output will be the denoised count matrix. The format will depend on the options used, but often it's compatible with standard single-cell analysis workflows.
*   **Model Selection**: scAR utilizes deep learning models. Depending on the data type (e.g., RNA, protein), specific pre-trained models or configurations might be available or recommended. Consult the documentation for details on model selection.
*   **Parameters**: Explore parameters related to:
    *   **`--model`**: Specify the model to use (e.g., `rna`, `cite`, `atac`).
    *   **`--n_epochs`**: Number of training epochs (if training is part of the workflow).
    *   **`--batch_size`**: Batch size for training.
    *   **`--learning_rate`**: Learning rate for the optimizer.
    *   **`--use_gpu`**: Flag to enable GPU acceleration.
*   **Reproducibility**: For reproducible results, consider setting random seeds for PyTorch and NumPy if you are involved in training or fine-tuning. The repository mentions `torch.manual_seed` and `numpy.random.seed` in its issues, suggesting these are relevant for reproducibility.
*   **Troubleshooting**: If you encounter errors, check the GitHub issues for similar problems. Common issues might relate to data shapes, dependencies, or GPU availability.

**Example (Conceptual - actual arguments may vary):**

To denoise an RNA count matrix:

```bash
scar --input counts.h5ad --output denoised_counts.h5ad --model rna --use_gpu
```

For detailed command-line arguments and advanced usage, always refer to the official scAR documentation and the tool's help output (`scar --help`).

## Reference documentation
- [scAR Overview (Anaconda.org)](./references/anaconda_org_channels_bioconda_packages_scar_overview.md)
- [scAR GitHub Repository](./references/github_com_Novartis_scar.md)
- [scAR Documentation (ReadTheDocs)](./references/github_com_Novartis_scAR_tree_main_docs.md)