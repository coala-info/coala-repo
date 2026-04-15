---
name: eternafold
description: EternaFold is an RNA secondary structure prediction tool that uses multitask learning to improve accuracy over traditional thermodynamic models. Use when user asks to predict RNA structures, incorporate SHAPE reactivity data into folding models, calculate base-pairing probabilities, or sample structures from the Boltzmann distribution.
homepage: https://github.com/eternagame/EternaFold
metadata:
  docker_image: "quay.io/biocontainers/eternafold:1.3.1--h9948957_2"
---

# eternafold

## Overview

EternaFold is a specialized RNA structure prediction tool that leverages multitask learning from Eterna project data. It improves upon traditional thermodynamic models by training on diverse experimental datasets, including structure probing and protein-affinity measurements. This skill provides guidance on performing Maximum Expected Accuracy (MEA) predictions, incorporating SHAPE reactivity data into folding models, and sampling the RNA structural ensemble.

## Core CLI Usage

The primary interface for EternaFold is the `contrafold` executable. When installed via Conda, this is typically available in the path; otherwise, it is located in the `src/` directory of the compiled repository.

### Single-Structure Prediction
To predict the MEA (Maximum Expected Accuracy) structure for a sequence:
```bash
contrafold predict input.seq --params parameters/EternaFoldParams.v1
```

### SHAPE-Directed Prediction
To incorporate SHAPE experimental data, use the `--evidence` flag. The input should be in `.bpseq` format where the SHAPE values are provided as evidence.
```bash
contrafold predict input.bpseq --evidence --numdatasources 1 --kappa 0.1 --params parameters/EternaFoldParams_PLUS_POTENTIALS.v1
```
*   **--kappa**: Adjusts the weight of the SHAPE evidence (default 0.1 is a common starting point).
*   **--params**: Ensure you use the `PLUS_POTENTIALS` version of the parameters when using SHAPE data.

### Ensemble and Probabilities
*   **Ensemble Free Energy**: Calculate the log partition coefficient.
    ```bash
    contrafold predict input.seq --params parameters/EternaFoldParams.v1 --partition
    ```
*   **Base-Pairing Probabilities**: Generate a list of pairing probabilities for all possible pairs above a specific threshold.
    ```bash
    contrafold predict input.seq --params parameters/EternaFoldParams.v1 --posteriors 0.001 output_bps.txt
    ```

### Stochastic Sampling
To sample structures from the Boltzmann distribution:
```bash
contrafold sample input.seq --params parameters/EternaFoldParams.v1 --nsamples 100
```

## Expert Tips and Best Practices

1.  **Parameter Selection**: Always explicitly point to the EternaFold parameter files (e.g., `EternaFoldParams.v1`). Without the `--params` flag, the tool may default to standard CONTRAfold parameters, losing the benefits of the EternaFold training.
2.  **Performance**: If running large batches or long sequences, ensure you are using the multithreaded version (compiled via `make multi`).
3.  **Input Formats**:
    *   `.seq`: Standard FASTA-like format (Header line starting with `>`, followed by sequence).
    *   `.bpseq`: Required for evidence-based folding. It typically contains three columns: index, nucleotide, and pairing partner (or 0 for unpaired), though EternaFold's evidence mode uses the third column for normalized reactivity data.
4.  **LinearFold Integration**: For very long sequences (e.g., viral genomes), EternaFold parameters can be used with `LinearFold` or `LinearPartition` using the provided patches in the repository to achieve linear-time scaling.

## Reference documentation
- [EternaFold GitHub Repository](./references/github_com_eternagame_EternaFold.md)
- [EternaFold Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_eternafold_overview.md)