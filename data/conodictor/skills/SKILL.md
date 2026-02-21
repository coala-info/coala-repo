---
name: conodictor
description: ConoDictor is a specialized bioinformatics tool designed for the rapid discovery of bioactive peptides within cone snail venom.
homepage: https://github.com/koualab/conodictor
---

# conodictor

## Overview

ConoDictor is a specialized bioinformatics tool designed for the rapid discovery of bioactive peptides within cone snail venom. It streamlines the identification of conopeptide precursor-like sequences from transcriptomic data, transforming raw sequence information into classified superfamilies. By utilizing both Hidden Markov Models (HMM) and Position-Specific Scoring Matrices (PSSM), it provides a robust consensus-based classification that is essential for venom research and drug discovery.

## CLI Usage and Patterns

### Basic Execution
The tool automatically recognizes the sequence alphabet (DNA or Amino Acid) and can handle compressed files directly.

```bash
# Basic run on a compressed fasta file
conodictor sequences.fasta.gz
```

### Optimized Workflows
For large-scale transcriptomic datasets, use the following flags to manage performance and output:

*   **Output Management**: Use `--out` to specify a results directory.
*   **Parallelization**: Use `--cpus` to leverage multi-core processing.
*   **Length Filtering**: Use `--mlen` to set a minimum length for predicted precursors (default is often sufficient, but can be tuned for specific fragments).

```bash
# High-performance run with custom output and length filtering
conodictor --out ./results_dir --cpus 8 --mlen 50 input_transcriptome.fasta
```

### Containerized Execution
If the local environment lacks dependencies like Pftools, use Docker to ensure a consistent environment:

```bash
docker run --rm=True -v $PWD:/data -u $(id -u):$(id -g) \
  ebedthan/conodictor:latest \
  conodictor --out /data/output /data/input.fasta.gz
```

## Interpreting Results

The primary output is `summary.csv`, which contains four critical columns:
1.  **sequence**: The identifier of the input sequence.
2.  **hmm_pred**: The superfamily predicted by the Hidden Markov Model.
3.  **pssm_pred**: The superfamily predicted by the Generalized Profile (PSSM).
4.  **definitive_pred**: The final classification. 

**Expert Tip**: Pay close attention to "CONFLICT" labels in the `definitive_pred` column. This occurs when HMM and PSSM models disagree (e.g., "CONFLICT B and D"). These sequences should be manually inspected or validated through secondary structural analysis.

## Best Practices

*   **Input Quality**: While ConoDictor can process raw reads, using assembled contigs generally yields more complete precursor sequences and more reliable superfamily assignments.
*   **Version Note**: As of version 2.4, the tool uses the `pyhmmer` library, removing the external dependency on HMMER 3 for easier installation via pip.
*   **Resource Allocation**: When running on HPC clusters, use the Singularity container to bypass root privilege requirements.

## Reference documentation
- [Main Repository and Usage](./references/github_com_koualab_conodictor.md)
- [Project Introduction](./references/github_com_koualab_conodictor_wiki.md)