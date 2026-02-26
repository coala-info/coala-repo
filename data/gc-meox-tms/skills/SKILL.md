---
name: gc-meox-tms
description: This tool simulates chemical derivatization by performing methoximation and trimethylsilylation on molecular structures for GC-MS preparation. Use when user asks to simulate chemical derivatization, generate MeOX or TMS derivatives from SMILES, or remove derivatization groups to reconstruct original structures.
homepage: https://github.com/RECETOX/gc-meox-tms
---


# gc-meox-tms

## Overview

The `gc-meox-tms` tool provides a computational approach to simulate chemical derivatization, a common requirement for preparing samples for Gas Chromatography-Mass Spectrometry (GC-MS). It specifically targets two reactions: the substitution of carbonyl groups (ketones and aldehydes) with methoxime groups, and the substitution of acidic hydrogens (in hydroxyl, thiol, carboxyl, and amine groups) with trimethylsilyl groups. 

Because these chemical substitutions are probabilistic in a laboratory setting, the tool uses a non-deterministic approach. Users should perform multiple iterations to ensure all potential derivative structures for a given precursor are identified.

## CLI Usage Patterns

The tool is executed as a Python module. It requires input files containing SMILES strings (one per line).

### Basic Derivatization
To generate derivatives and save them to a flat text file:
```bash
python -m gc_meox_tms -f derivatives.txt input_smiles.txt
```

### Grouped Output
To generate a tab-separated file where all derivatives of a specific precursor are kept on the same line:
```bash
python -m gc_meox_tms -t derivatives.tsv input_smiles.txt
```

### Performance and Sampling
For complex molecules or large batches, use multiple cores and increase the number of repeats to capture the full range of probabilistic substitutions:
```bash
# Note: Use --help to verify exact flag names for cores and repeats in your environment
python -m gc_meox_tms --help
```

## Python API Integration

For programmatic workflows, use the following functions from the `gc_meox_tms` package:

*   `is_derivatized(smiles=str)`: Returns a boolean indicating if the molecule contains MeOX or TMS groups.
*   `remove_derivatization_groups(smiles=str)`: Returns an RDKit molecule object with derivatization groups removed, reconstructing the original structure.
*   `add_derivatization_groups(mol=obj)`: Performs the in-silico substitution.

### Example Workflow
```python
from gc_meox_tms import add_derivatization_groups, is_derivatized, remove_derivatization_groups
from rdkit.Chem import MolFromSmiles, MolToSmiles

smiles = "CCO" # Ethanol

# Check if already derivatized
print(is_derivatized(smiles=smiles))

# Add groups (Non-deterministic: run multiple times for all variants)
mol = MolFromSmiles(smiles)
derivatized_mol = add_derivatization_groups(mol=mol)
print(MolToSmiles(derivatized_mol))
```

## Expert Tips & Limitations

1.  **Exhaustive Sampling**: Since `add_derivatization_groups` is non-deterministic, you must run the function or CLI tool multiple times to ensure you have discovered all possible conversion degrees and conformations.
2.  **Cyclic Molecules**: A known limitation is that methoximation on cycles (which should theoretically break the cycle) is not yet implemented.
3.  **Input Cleaning**: Ensure input `.txt` files contain only valid SMILES strings. The tool expects one SMILES per line without additional metadata unless processing via the TSV output path.
4.  **RDKit Dependency**: The tool relies on RDKit molecule objects; ensure RDKit is properly configured in your environment when using the Python API.

## Reference documentation
- [gc-meox-tms Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gc-meox-tms_overview.md)
- [gc-meox-tms GitHub Repository](./references/github_com_RECETOX_gc-meox-tms.md)