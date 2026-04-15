---
name: ostir
description: The ostir tool estimates ribosome binding efficiency and translation initiation rates for bacterial start codons using thermodynamic models. Use when user asks to predict translation initiation rates, analyze FASTA files for ribosome binding efficiency, or calculate thermodynamic values for translation potential.
homepage: https://github.com/barricklab/rbs-calculator
metadata:
  docker_image: "quay.io/biocontainers/ostir:1.1.2--pyhdfd78af_0"
---

# ostir

## Overview
The `ostir` (Open Source Transcription Initiation Rates) tool is a Python-based utility designed to estimate how efficiently ribosomes bind to and initiate translation from specific start codons in bacteria. It builds upon the thermodynamic models of the RBS Calculator, utilizing the ViennaRNA package for free energy calculations. This skill provides the necessary command-line patterns and Python module usage to analyze individual sequences or large-scale genomic data for translation potential.

## Command Line Usage
The primary interface for `ostir` is its CLI, which supports both direct sequence input and file-based processing.

### Basic Execution
- **Single Sequence**: Predict TIR for a specific mRNA string.
  ```bash
  ostir -i ATGC...SEQUENCE...
  ```
- **FASTA Input**: Process multiple sequences and save results to a CSV.
  ```bash
  ostir -i input.fasta -o results.csv
  ```

### Advanced Options
- **Multi-threading**: Accelerate analysis for large datasets or long sequences.
  ```bash
  ostir -i input.fasta -o results.csv --threads 8
  ```
- **Help**: Access the full list of parameters and flags.
  ```bash
  ostir -h
  ```

## Python Module Integration
For programmatic workflows, `ostir` can be imported directly into Python scripts.

```python
from ostir import run_ostir

# Define the mRNA sequence
seq = "ACUUCUAAUUUAUUCUAUUUAUUCGCGGAUAUGCAUAGGAGUGCUUCGAUGUCAU"

# Run prediction
results = run_ostir(seq, name="my_sequence", threads=4)

# Results contain predicted initiation rates and deltaG values
print(results)
```

## Best Practices
- **Input Format**: While `ostir` handles DNA sequences (T), it internally processes them as RNA (U). Ensure your input includes sufficient upstream context (the 5' UTR) to allow for accurate Shine-Dalgarno sequence identification.
- **Dependencies**: Ensure `ViennaRNA` is installed in the environment, as `ostir` relies on it for underlying secondary structure energy calculations.
- **Performance**: When processing whole genomes or large libraries, always utilize the `--threads` flag to distribute the computational load of the thermodynamic folding algorithms.

## Reference documentation
- [OSTIR GitHub Repository](./references/github_com_barricklab_ostir.md)
- [OSTIR Wiki](./references/github_com_barricklab_ostir_wiki.md)