---
name: seqfold
description: seqfold predicts the secondary structure and minimum free energy of DNA or RNA sequences using the Zuker dynamic programming algorithm. Use when user asks to predict nucleic acid folding, calculate minimum free energy, generate dot-bracket notation, or analyze substructure energy contributions.
homepage: https://github.com/Lattice-Automation/seqfold
metadata:
  docker_image: "quay.io/biocontainers/seqfold:0.9.0--pyhdfd78af_0"
---

# seqfold

## Overview
seqfold is a lightweight, open-source implementation of the Zuker dynamic programming algorithm used to predict the secondary structure of nucleic acids. It utilizes modern energy functions—SantaLucia (2004) for DNA and Turner (2009) for RNA—to determine the most stable folding state. It is particularly useful for researchers designing PCR primers, oligos for MAGE, or tuning RBS expression rates who require a fast, MIT-licensed alternative to more restrictive tools like mfold or UNAFold.

## CLI Usage Patterns

### Basic MFE Prediction
To get the minimum free energy (kcal/mol) for a sequence at the default temperature (37°C):
```bash
seqfold GGGAGGTCGTTACATCTGGGTAACACCGGTACTGATCCGGTGACCTCCC
```

### Generating Secondary Structure (Dot-Bracket)
To visualize the folding pattern using dot-bracket notation:
```bash
seqfold -d GGGAGGTCGTTACATCTGGGTAACACCGGTACTGATCCGGTGACCTCCC
```

### Detailed Substructure Analysis
To see the energy contribution (ddg) of every stack, loop, and hairpin within the MFE structure:
```bash
seqfold -r GGGAGGTCGTTACATCTGGGTAACACCGGTACTGATCCGGTGACCTCCC
```

### Adjusting Temperature
Thermodynamic stability is temperature-dependent. Use the `-t` flag to specify Celsius:
```bash
seqfold -t 32 GGGAGGTCGTTACATCTGGGTAACACCGGTACTGATCCGGTGACCTCCC
```

## Python API Quickstart

For integration into bioinformatics pipelines, use the Python interface:

```python
from seqfold import fold, dg, dot_bracket

seq = "GGGAGGTCGTTACATCTGGGTAACACCGGTACTGATCCGGTGACCTCCC"

# Get MFE only
mfe = dg(seq, temp=37.0)

# Get list of structure objects
structs = fold(seq)

# Get dot-bracket string
db = dot_bracket(seq, structs)
```

## Expert Tips
- **Performance**: For sequences longer than 200bp, use `pypy3` instead of standard CPython. It can be up to 6x faster (e.g., 2.5s vs 15s for a 200bp sequence).
- **Sequence Inference**: You do not need to specify if a sequence is DNA or RNA; `seqfold` automatically infers the type based on the input characters (e.g., presence of T vs U).
- **Case Sensitivity**: The tool is case-insensitive; `atgc` and `ATGC` are treated identically.
- **Limitations**: Unlike UNAFold, `seqfold` does not currently support heterodimers (folding of two different strands) or custom folding constraints.

## Reference documentation
- [seqfold GitHub Repository](./references/github_com_Lattice-Automation_seqfold.md)
- [Bioconda seqfold Overview](./references/anaconda_org_channels_bioconda_packages_seqfold_overview.md)