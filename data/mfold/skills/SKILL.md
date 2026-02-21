---
name: mfold
description: mfold is a specialized tool for predicting the secondary structure of single-stranded RNA or DNA.
homepage: http://www.unafold.org/mfold/software/download-mfold.php
---

# mfold

## Overview
mfold is a specialized tool for predicting the secondary structure of single-stranded RNA or DNA. It uses a "minimum free energy" (MFE) approach to find the most thermodynamically stable foldings. This skill provides the necessary command-line patterns to execute folding simulations, manage thermodynamic parameters, and interpret the resulting structural data.

## Core Usage Patterns

### Basic Folding
To fold a sequence with default parameters, use the `mfold` command. The input should be a file containing the sequence in FASTA or a simple text format.

```bash
mfold SEQ=my_sequence.fasta
```

### Specifying Molecule Type
By default, mfold assumes RNA. For DNA sequences, you must specify the type to ensure the correct thermodynamic parameters are applied.

```bash
mfold SEQ=my_dna.fasta NA=DNA
```

### Temperature and Constraints
Adjust the folding temperature (default is 37°C) or apply constraints to force or prevent specific base pairings.

- **Temperature**: `mfold SEQ=seq.txt T=30`
- **Constraints**: Use a constraint file (.aux) to specify known structural features.
  ```bash
  mfold SEQ=seq.txt AUX=constraints.aux
  ```

### Output Files
mfold generates several output files that are critical for downstream analysis:
- **.ct (Connectivity Table)**: Contains the primary sequence and the base-pairing information.
- **.pdf / .png / .jpg**: Visual representations of the predicted structures.
- **.plot**: Dot plot data showing the energy of all possible base pairs.
- **.det**: Detailed energy breakdown of the predicted structures.

## Expert Tips
- **Suboptimals**: mfold doesn't just find one structure; it finds a set of "suboptimal" structures within a certain energy range of the MFE. Use the `P` parameter (percent optimality) to control how many structures are generated (e.g., `P=5` for structures within 5% of the MFE).
- **Ionic Conditions**: For DNA hybridization, the salt concentration significantly impacts ΔG. While the standalone `mfold` script has defaults, ensure your environment variables or local `.col` files are correctly configured for specific Na+ or Mg++ concentrations if the version supports it.
- **Large Sequences**: mfold is computationally intensive for very long sequences (e.g., > 1000 nt). For genomic-scale folding, consider windowed folding or using the newer UNAFold suite which mfold is now a part of.

## Reference documentation
- [mfold Software Download and Overview](./references/www_unafold_org_mfold_software_download-mfold.php.md)
- [Bioconda mfold Package Summary](./references/anaconda_org_channels_bioconda_packages_mfold_overview.md)