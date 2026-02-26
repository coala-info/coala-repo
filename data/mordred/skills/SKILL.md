---
name: mordred
description: Mordred is a molecular descriptor calculator that transforms chemical structures into numerical feature sets for machine learning and chemical analysis. Use when user asks to calculate 2D or 3D molecular descriptors, convert SMILES or SDF files into feature matrices, or perform high-throughput screening of chemical properties.
homepage: https://github.com/mordred-descriptor/mordred
---


# mordred

## Overview
Mordred is a comprehensive molecular descriptor calculator that serves as a modern alternative to older tools like Dragon. It can calculate 1,613 2D descriptors and 213 3D descriptors. Use this skill to transform chemical structure files into numerical feature sets for machine learning, perform high-throughput screening, or analyze specific chemical properties like acidity, aromaticity, and topological indices.

## Installation
Ensure the environment has `rdkit` and `mordred` installed:
- Conda: `conda install -c rdkit -c mordred-descriptor mordred`
- Pip: `pip install 'mordred[full]'`

## Command Line Interface (CLI) Patterns

### Basic Calculation
Calculate all 2D descriptors for a SMILES file and output to CSV:
```bash
python -m mordred input.smi -o output.csv
```

### 3D Descriptors
To calculate 3D descriptors, you must provide a file format containing coordinates (SDF or MOL) and use the `-3` flag:
```bash
python -m mordred input.sdf -3 -o output_3d.csv
```

### Performance and Memory Optimization
- **Parallel Processing**: Use `-p` to specify the number of processes (defaults to all logical processors).
- **Streaming**: Use `-s` for very large input files to process molecules one by one, significantly reducing memory usage.
- **Quiet Mode**: Use `-q` to hide the progress bar in automated pipelines.

### Selecting Specific Descriptors
Instead of calculating all 1,800+ descriptors, specify only the ones needed to save time:
```bash
python -m mordred input.smi -d ABCIndex -d AcidBase -o subset.csv
```

## Python Library Usage

### Basic Integration
```python
from rdkit import Chem
from mordred import Calculator, descriptors

# Initialize calculator with 2D descriptors
calc = Calculator(descriptors, ignore_3D=True)

# Calculate for a single molecule
mol = Chem.MolFromSmiles('c1ccccc1')
result = calc(mol)

# Calculate for multiple molecules as a Pandas DataFrame
mols = [Chem.MolFromSmiles(s) for s in ['CC', 'CCC', 'CCCC']]
df = calc.pandas(mols)
```

## Expert Tips and Best Practices
- **Input Validation**: Mordred relies on RDKit. If a molecule cannot be parsed by RDKit (returns `None`), Mordred will skip it or throw an error depending on the interface used.
- **Missing Values**: Some descriptors may fail for specific molecules (e.g., 3D descriptors on a flat molecule). Mordred returns a `Missing` value object rather than NaN in the raw results to explain why it failed.
- **SMILES vs SDF**: Always prefer SDF for 3D descriptors. While SMILES can be used for 2D descriptors, they do not contain the spatial coordinates required for geometrical or gravitational indices.
- **Descriptor Names**: Use `python -m mordred --help` to see the full list of available descriptor modules (e.g., `BertzCT`, `Chi`, `EState`, `Lipinski`).

## Reference documentation
- [mordred-descriptor/mordred](./references/github_com_mordred-descriptor_mordred.md)