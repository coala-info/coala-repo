---
name: tmscoring
description: The `tmscoring` package compares protein structures to determine their structural similarity. Use when user asks to 'compare protein structures', 'calculate TM-score', 'calculate RMSD', 'align protein structures', 'get local residue-specific scores', or 'generate aligned PDB files'.
homepage: https://github.com/Dapid/tmscoring
---


# tmscoring

## Overview

The `tmscoring` package provides a robust Python-based alternative to the original Fortran TM-score program. It is designed to compare the structures of the same protein or similar protein chains to determine structural similarity. Unlike the original program, `tmscoring` uses the MINUIT Migrad algorithm for optimization, which often results in more precise scores. This skill enables the calculation of global similarity metrics (TM-score, RMSD) and local residue-specific scores, as well as the generation of aligned PDB files.

## Installation

The package can be installed via conda or pip:

```bash
# Via Bioconda
conda install bioconda::tmscoring

# Via Pip (requires iminuit < 2.0.0 for older versions)
pip install tmscoring
```

## Core Usage Patterns

### Basic Structural Comparison
To quickly get the TM-score or RMSD between two structures without manual object management:

```python
import tmscoring

# Get global TM-score
tm_score = tmscoring.get_tm('model.pdb', 'native.pdb')

# Get global RMSD
rmsd_val = tmscoring.get_rmsd('model.pdb', 'native.pdb')
```

### Advanced Alignment and Transformation
For more control, use the `TMscoring` class. This allows you to extract the transformation matrix and save the aligned coordinates.

```python
import tmscoring

# Initialize with two PDB files
alignment = tmscoring.TMscoring('structure1.pdb', 'structure2.pdb')

# Run the optimization engine (Migrad)
alignment.optimise()

# Retrieve metrics using the optimized parameters
current_params = alignment.get_current_values()
tm = alignment.tmscore(**current_params)
rmsd = alignment.rmsd(**current_params)

# Get the 3x3 rotation matrix and translation vector
matrix = alignment.get_matrix(**current_params)

# Save the aligned structure to a new file
alignment.write(outputfile='aligned_output.pdb', appended=True)
```

### Local Similarity Scores
To analyze which specific regions of a protein are well-aligned, use `tmscore_samples`:

```python
# Returns an array of scores for each residue
local_scores = alignment.tmscore_samples(**alignment.get_current_values())
```

## Expert Tips

- **Sequence Alignment**: By default, `tmscoring` matches residues by index. If the PDB files have different numbering or gaps, the tool can perform a global sequence alignment using the Smith-Waterman algorithm (Match: 2, Mismatch: -1, Gap Open: -0.5, Gap Extend: -0.1).
- **Optimization Scores**: While `TMscoring` is the standard, the library also provides `Sscoring` and `RMSDscoring` classes. These function identically but change the default objective function used during the optimization phase.
- **Handling iminuit Versions**: If you encounter `RuntimeError` or parameter errors, ensure you are using a compatible version of `iminuit`. Older versions of `tmscoring` specifically require `iminuit < 2.0.0`.
- **Data Extraction**: Because this is a native Python library, you can access the underlying atom coordinates and residue information directly from the `alignment` object without parsing standard output text files.

## Reference documentation
- [tmscoring GitHub README](./references/github_com_Dapid_tmscoring.md)
- [tmscoring Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tmscoring_overview.md)