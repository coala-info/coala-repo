---
name: openstructure
description: OpenStructure (OST) is a modular, open-source framework designed for computational structural biology.
homepage: https://openstructure.org
---

# openstructure

## Overview

OpenStructure (OST) is a modular, open-source framework designed for computational structural biology. It provides a powerful environment for method developers and bioinformaticians to manipulate molecular structures, density maps, and sequences. Use this skill to perform high-accuracy model quality assessments (like lDDT), clean problematic PDB files, perform structural superpositions, and automate complex structural analysis via its Python API or command-line "actions."

## Core CLI Usage

The primary entry point for OpenStructure is the `ost` binary. It can be used to run custom scripts or execute built-in "actions."

### Running Scripts
To execute a Python script within the OpenStructure environment (which pre-configures the necessary search paths and environment variables):
```bash
ost your_script.py
```

### Built-in Actions
OpenStructure includes several specialized command-line tools for common tasks:

*   **lDDT**: Calculate the Local Distance Difference Test score to compare a model against a reference structure without needing superposition.
    ```bash
    ost lDDT <model_file> <reference_file>
    ```
*   **Molck**: The Molecular Checker tool for cleaning and validating PDB files (e.g., handling non-standard residues or missing atoms).
    ```bash
    ost molck <input_file>
    ```
*   **Structure Comparison**: Compare two macromolecular structures or structures with ligands.
    ```bash
    ost compare-structures --model <model.pdb> --reference <ref.pdb>
    ```

## Python API Best Practices

When writing scripts for `ost`, use the following patterns for efficiency and reliability.

### Loading Structures
Standard PDB files often contain errors. Use the `fault_tolerant` flag to skip erroneous records.
```python
from ost import io

# Load a PDB file, skipping errors
ent = io.LoadPDB('structure.pdb', fault_tolerant=True)

# Load an mmCIF file (preferred for large structures)
ent = io.LoadMMCIF('structure.cif')
```

### Selection and Queries
OpenStructure uses a dedicated query language to create `EntityViews` (subsets of structures).
```python
# Select all Carbon-alpha atoms in chain A
ca_atoms = ent.Select('chain=A and aname=CA')

# Select residues within a specific range
binding_site = ent.Select('rnum=10:25')

# Select by property (e.g., B-factor)
high_bfactor = ent.Select('eleme=C and bfactor > 50')
```

### Scoring and Comparison
For programmatic model evaluation:
```python
from ost.mol.alg import lDDT

# Compute lDDT score
# model and reference should be EntityViews or Entities
score = lDDT(model_view, reference_view, inclusion_radius=15.0)
```

## Expert Tips

*   **Environment Variables**: If using OpenStructure modules from a standard Python interpreter instead of the `ost` binary, ensure `PYTHONPATH` includes the OST `site-packages` directory (e.g., `export PYTHONPATH="/path/to/ost/lib64/python3.10/site-packages/:$PYTHONPATH"`).
*   **Compound Library**: For proper connectivity and bond handling, ensure the compound library is loaded. This is critical when working with ligands or non-standard residues.
*   **Density Maps**: Use the `img` module for 3D density map processing. You can convert molecular structures into density maps for cross-correlation analysis.
*   **Fault Tolerance**: Always use `fault_tolerant=True` when batch processing PDB files from the PDB archive to prevent script crashes on legacy formatting issues.

## Reference documentation

- [OpenStructure Documentation](./references/openstructure_org_docs_2.11.md)
- [Frequently Asked Questions](./references/openstructure_org_faq.md)
- [Features Overview](./references/openstructure_org_features.md)
- [Installation Guide](./references/openstructure_org_install.md)