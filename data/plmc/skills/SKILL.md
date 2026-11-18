---
name: plmc
description: plmc infers evolutionary couplings from multiple sequence alignments by estimating the parameters of a Potts model, and its model scores amino-acid substitutions (EVmutation statistical energy) for mutation effect and variant effect prediction and protein fitness ranking. Use when user asks to calculate coupling scores, predict the effect of mutations from a homolog alignment, rank protein variants, infer protein or RNA models, or identify direct residue interactions in biological sequences.
homepage: https://github.com/debbiemarkslab/plmc
metadata:
  docker_image: "quay.io/biocontainers/plmc:20221105--hec16e2b_0"
---

# plmc

## Overview
The `plmc` tool implements a maximum a posteriori (MAP) estimation approach to infer the parameters of a Potts model (or Ising model for binary data) from biological sequence data. By analyzing covariation in a multiple sequence alignment, it identifies direct evolutionary couplings, which are often strong indicators of physical proximity in 3D structures. This skill provides the necessary command-line patterns to process alignments, tune regularization, and select appropriate alphabets for different biological systems.

## Core CLI Patterns

### Basic Coupling Inference
To calculate coupling scores from a protein alignment:
```bash
plmc -c output.couplings input_alignment.fasta
```

### Protein Model with Regularization
For protein families, it is standard practice to use specific L2 regularization values for fields ($h_i$) and couplings ($e_{ij}$):
```bash
plmc -o model.params -le 16.0 -lh 0.01 -m 100 -g -f FOCUS_SEQ_ID alignment.a2m
```
*   `-le 16.0`: Sets the L2 lambda for couplings (higher values prevent overfitting in small alignments).
*   `-lh 0.01`: Sets the L2 lambda for fields.
*   `-m 100`: Limits the maximum number of iterations for the L-BFGS optimizer.
*   `-g`: Ignores gaps (models only the coding portions).
*   `-f`: Focus mode; select a specific sequence ID to define the coordinate system and filter columns.

### Score substitutions (EVmutation)
The fitted model gives each sequence a statistical energy `E(x) = sum_i h_i(x_i) + sum_{i<j} J_ij(x_i, x_j)`.
The score of a variant is `dE = E(variant) - E(focus sequence)`; higher means more like the family,
and in deep mutational scans it ranks variants by fitness (Hopf et al. 2017, the EVmutation paper).

1. Fit with a focus sequence: `plmc -o model.params -le 16.0 -lh 0.01 -m 200 -t 0.2 -g -n max -f FOCUS_ID alignment.a2m`.
   `FOCUS_ID` is the focus sequence's header without `>`. With `-f`, only the focus sequence's
   uppercase, non-gapped columns are modelled; lowercase (insert) columns are left out.
   Run time grows with sequences x columns squared: about 30 minutes for 17,000 sequences and
   380 columns on 8 threads, so start it early and in the background.
2. Read the binary file (the BioContainers build writes float32; check that no bytes are left over):
```python
import numpy as np
def read_plmc(path, prec="float32"):
    with open(path, "rb") as f:
        L, q, n_valid, n_invalid, n_iter = np.fromfile(f, "int32", 5)
        np.fromfile(f, prec, 5)                               # theta, lambdas, N_eff
        alphabet = np.fromfile(f, "S1", q).astype("U1")
        np.fromfile(f, prec, n_valid + n_invalid)             # sequence weights
        target = np.fromfile(f, "S1", L).astype("U1")         # focus residues
        index = np.fromfile(f, "int32", L)                    # residue number of each column
        np.fromfile(f, prec, L * q)                           # f_i
        h = np.fromfile(f, prec, L * q).reshape(L, q)
        np.fromfile(f, prec, L * (L - 1) // 2 * q * q)        # f_ij
        J = np.zeros((L, L, q, q), prec)
        for i in range(L - 1):
            b = np.fromfile(f, prec, (L - 1 - i) * q * q).reshape(L - 1 - i, q, q)
            J[i, i + 1:], J[i + 1:, i] = b, b.transpose(0, 2, 1)
        assert not f.read(), "bytes left over: wrong precision or format"
    return alphabet, target, index, h, J
```
   Check that `target` equals the focus sequence at the residue numbers in `index`.
3. Single-substitution table: `S[i, a] = h_i(a) - h_i(wt_i) + sum_j (J_ij(a, wt_j) - J_ij(wt_i, wt_j))`,
   an L x q array. The sum of `S` over a variant's substitutions ranks variants with a few
   substitutions almost exactly as the full `dE` does (the pair terms between substitutions are
   small), and it is small enough to ship inside a model file. Positions outside the modelled
   columns get 0.
4. With measured variants, use `dE` as one feature next to the measured data rather than alone:
   ridge regression on one-hot substitution features plus `dE` (the "augmented" model of
   Hsu et al. 2022) beats either part when labels are few. Check any choice on held-out
   measured variants, and check `dE` against the measurements you have before relying on it.

### RNA Coupling Inference
When working with RNA, you must override the default protein alphabet:
```bash
plmc -c output.couplings -a .ACGU -le 20.0 -lh 0.01 -m 50 alignment.fasta
```
*   `-a .ACGU`: Defines the RNA alphabet (including the gap character).

## Expert Tips and Best Practices

### Focus Mode Requirements
With `-f`, plmc models only the columns where the focus sequence has an uppercase residue (the a2m convention); columns where it is lowercase or a gap are left out, and `index` in the parameter file gives the residue number of each modelled column. The focus header's `/start-end` suffix sets the numbering.

### Performance Optimization
*   **Multithreading**: Use `-n <number>` or `-n max` to specify the number of CPU cores for OpenMP acceleration.
*   **Fast Mode**: Use `--fast` to enable stochastic gradient descent and faster weight calculations, which is useful for extremely large alignments.
*   **Precision**: If memory is a bottleneck, use a version of `plmc` compiled with single precision (32-bit), which halves memory requirements compared to the default double precision.

### Sequence Weighting
`plmc` automatically weights sequences to account for phylogenetic bias (clustering of similar sequences).
*   `-t <value>`: Sets the theta parameter (neighborhood divergence). Default is typically 0.2 (80% identity).
*   `-s <value>`: Sets the scale for neighborhood weights.
*   `--save-weights <file>`: Use this to export the calculated weights for downstream analysis.

### Output Formats
1.  **Couplings File (`-c`)**: A 6-column text file. The 6th column contains the APC-corrected Frobenius norm scores, which are the standard metric for predicting contacts.
2.  **Parameter File (`-o`)**: A binary file containing the full model parameters ($h_i$ and $e_{ij}$). This is required for mutational effect prediction but can be very large ($10^6$ to $10^8$ parameters).

## Reference documentation
- [plmc GitHub Repository](./references/github_com_debbiemarkslab_plmc.md)
- [Bioconda plmc Package](./references/anaconda_org_channels_bioconda_packages_plmc_overview.md)