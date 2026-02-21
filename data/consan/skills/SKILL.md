---
name: consan
description: Consan is a specialized bioinformatics tool for aligning two RNA sequences by considering both primary sequence and secondary structure.
homepage: http://eddylab.org/software/consan/
---

# consan

## Overview
Consan is a specialized bioinformatics tool for aligning two RNA sequences by considering both primary sequence and secondary structure. It implements a pairwise stochastic context-free grammar (SCFG) that can operate in a "full" mode (Sankoff-style) or a "constrained" mode using alignment pins to improve efficiency. It is particularly useful for high-accuracy structural alignments of non-coding RNAs like tRNA or 5S rRNA.

## Core Workflows

### 1. Training a Model (`strain_ml`)
To generate a custom parameter file (`.mod`) from a set of known structural alignments:
```bash
strain_ml -s my_model.mod training_set.stk
```
*   **Input**: A Stockholm format file (`.stk`) containing structural alignments.
*   **Output**: A binary model file used by the alignment programs.

### 2. Pairwise Structural Alignment (`sfold`)
To align two sequences based on a structural model:
```bash
sfold -m model.mod sequence1.fa sequence2.fa
```
*   **Note**: This is the primary tool for aligning two unaligned FASTA sequences.

### 3. Alignment Comparison and Evaluation (`scompare`)
To align two sequences and compare the result to a known reference alignment:
```bash
scompare -m model.mod reference_alignment.stk
```
*   **Full SCFG**: Use the `-f` flag for unconstrained (full) alignment. Warning: This is extremely resource-intensive ($N^6$ time, $N^4$ memory).
*   **Suppression**: Use `-S` to suppress summary information in the output.

## Expert Tips and Constraints

### Resource Management
Consan is computationally expensive. For sequences longer than 100-150 nucleotides, the full Sankoff algorithm (`-f`) may exceed available system memory.
*   **Constraints**: By default, Consan uses "alignment pins" (posteriors > 0.95) to restrict the search space.
*   **Adjusting Constraints**: Use `-Z <float>` to change the posterior cutoff and `-W <int>` to change the protection window size.

### File Formats
*   **Stockholm 1.0**: Consan requires structural information in Stockholm format, typically using `> <` or `( )` for base pairing in the `#=GC SS_cons` line.
*   **WUSS Notation**: For certain downstream evaluation tools like `compstruct`, you may need to reformat Stockholm files to WUSS notation using `sreformat`:
    ```bash
    sreformat --wuss stockholm input.stk > output.wuss.stk
    ```

### Simultaneous Execution
Avoid running multiple instances of Consan simultaneously on the same machine if they share the same temporary directory. The interface with `dpswalign` uses a fixed naming mechanism for temporary files in `src/tmp/`, which can lead to race conditions and file corruption.

## Reference documentation
- [Consan README](./references/eddylab_org_software_consan_README.md)
- [Paper Guide (Usage Examples)](./references/eddylab_org_software_consan_paperguide.txt.md)
- [Installation and Configuration](./references/eddylab_org_software_consan_INSTALL.md)