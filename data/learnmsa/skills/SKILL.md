---
name: learnmsa
description: The `learnmsa` tool (specifically learnMSA2) is a high-performance protein sequence aligner designed to handle datasets ranging from hundreds to millions of sequences.
homepage: https://github.com/Gaius-Augustus/learnMSA
---

# learnmsa

## Overview
The `learnmsa` tool (specifically learnMSA2) is a high-performance protein sequence aligner designed to handle datasets ranging from hundreds to millions of sequences. It leverages Hidden Markov Models (HMMs) and can optionally incorporate protein language models to achieve state-of-the-art accuracy. Unlike traditional aligners that rely on guide trees, `learnmsa` scales linearly with the number of sequences and is optimized for GPU acceleration, making it suitable for ultra-large-scale genomic and proteomic studies.

## Installation Quickstart
The most stable environment is provided via Singularity/Docker to ensure all GPU and language model dependencies are met.

```bash
# Recommended: Singularity
singularity build learnmsa.sif docker://felbecker/learnmsa
singularity run --nv learnmsa.sif learnMSA -i input.fasta -o output.aln --use_language_model
```

For local Python environments, ensure `tensorflow[and-cuda]` and `mmseqs2` are installed for full functionality.

## Common CLI Patterns

### High-Accuracy Alignment (Recommended)
Use the protein language model support for maximum accuracy on diverse protein families.
```bash
learnMSA -i sequences.fasta -o alignment.fasta --use_language_model
```

### High-Speed Alignment
For proteins with very high sequence similarity or when computational resources are limited, run without the language model.
```bash
learnMSA -i sequences.fasta -o alignment.fasta
```

### Visualization and Analysis
Generate a PDF with a sequence logo of the consensus motif alongside the alignment.
```bash
learnMSA -i sequences.fasta -o alignment.fasta --logo
```

### Advanced Processing
*   **Scoring**: Generate alignment scores without requiring an output file.
    ```bash
    learnMSA -i sequences.fasta --scores
    ```
*   **Format Conversion**: Convert between different input formats.
    ```bash
    learnMSA -i sequences.fasta -o output.aln --convert -f fasta
    ```
*   **Memory Management**: Adjust batch sizes for large-scale language model inference.
    ```bash
    learnMSA -i sequences.fasta -o output.aln --use_language_model --tokens_per_batch 4000
    ```

## Expert Tips and Best Practices
*   **Sequence Volume**: `learnmsa` is designed for large families. It typically requires at least 1000 sequences to achieve high accuracy, though it may work with as few as 100.
*   **Sequence Length**: The tool is optimized for proteins under 1000 residues. Performance may degrade significantly for very long proteins.
*   **GPU Troubleshooting**: If you encounter "TensorFlow libdevice not found" errors during JIT compilation, locate your `nvvm` directory and set the XLA flags:
    ```bash
    export XLA_FLAGS=--xla_gpu_cuda_data_dir=/path/to/cuda/nvvm
    ```
*   **Sequence Weights**: In versions >= 2.0.10, sequence weights are enabled by default. Use `--no_sequence_weights` only if specifically required for your workflow, though it is generally not recommended.
*   **Training Control**: Use `--skip_training` if you are loading a pre-trained model or only need to perform an alignment based on existing parameters.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_Gaius-Augustus_learnMSA.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_learnmsa_overview.md)
- [Recent Feature Commits](./references/github_com_Gaius-Augustus_learnMSA_commits_main.md)