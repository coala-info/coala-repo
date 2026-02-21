---
name: phold
description: phold is a specialized bioinformatics tool designed to improve the functional annotation of bacteriophages by leveraging protein structural information rather than just primary sequences.
homepage: https://github.com/gbouras13/phold
---

# phold

## Overview

phold is a specialized bioinformatics tool designed to improve the functional annotation of bacteriophages by leveraging protein structural information rather than just primary sequences. It uses the ProstT5 protein language model to convert amino acid sequences into 3Di tokens, which are then searched against a massive database of phage protein structures using Foldseek. This approach is significantly more sensitive than traditional HMM or BLAST-based methods, making it the preferred choice for analyzing metagenomic datasets or novel phage isolates.

## Installation and Database Setup

Before running annotations, the structural databases must be initialized.

*   **Standard Install**: `phold install -t <threads>`
*   **GPU-Enabled Install**: If using an NVIDIA GPU, use `phold install -t 8 --foldseek_gpu` to ensure the GPU-compatible version of the Foldseek database is prepared.
*   **Storage Requirement**: Ensure at least 8GB of free space is available for the uncompressed databases and models.

## Common CLI Patterns

### Full Annotation Pipeline
The `run` command executes both prediction (3Di translation) and comparison (structural search).

```bash
phold run -i input_genome.gbk -o output_directory -t 8
```

*   **For CPU-only environments**: Add the `--cpu` flag.
*   **For NVIDIA GPUs**: Add the `--foldseek_gpu` flag to accelerate the search phase.

### Optimized Large-Scale Processing
For large metagenomic datasets, use the `autotune` feature or the two-step workflow to manage resources efficiently.

1.  **Autotune**: Automatically detect the optimal batch size for your hardware.
    ```bash
    phold run -i input.gbk -o output_dir --autotune
    ```
2.  **Split Workflow**: Run prediction on a GPU node and comparison on a standard compute node.
    *   Step 1 (GPU): `phold predict -i input.gbk -o predictions_dir`
    *   Step 2 (CPU): `phold compare -i predictions_dir -o final_output`

### Updating Pharokka Annotations
phold is designed to be complementary to Pharokka. If you have already run Pharokka, provide the GenBank output as input to phold to refine "hypothetical protein" assignments with structural hits.

## Expert Tips and Best Practices

*   **Input Format**: While phold can take FASTA files, using a GenBank file (from Pharokka or NCBI) is highly recommended as it preserves existing gene calls and metadata.
*   **Hardware Acceleration**: The `predict` step (ProstT5) is computationally expensive on CPUs. Always prefer an NVIDIA GPU or Apple Silicon (M1/M2/M3/M4) when available.
*   **Batch Size**: If you encounter Out-Of-Memory (OOM) errors on your GPU, manually reduce the `--batch_size` or use the `--autotune` flag.
*   **Synteny Integration**: For maximum annotation depth, consider a "Pharokka -> phold -> Phynteny" workflow. phold provides the structural evidence, while Phynteny uses gene order to fill remaining gaps.
*   **Visualization**: Use `phold plot` to generate genomic maps. For interactive exploration, the output GenBank file can be uploaded to the phold-plot-wasm-app.

## Reference documentation

- [phold GitHub Repository](./references/github_com_gbouras13_phold.md)
- [phold Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_phold_overview.md)