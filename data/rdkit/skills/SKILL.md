---
name: rdkit
description: RDKit is a powerful cheminformatics toolkit used to handle the complexities of chemical structures and reactions.
homepage: https://github.com/rdkit/rdkit
---

# rdkit

## Overview
RDKit is a powerful cheminformatics toolkit used to handle the complexities of chemical structures and reactions. It transforms raw chemical data into computationally accessible objects, allowing for the calculation of physical properties, the generation of molecular fingerprints, and the execution of substructure or similarity searches. This skill provides the essential patterns for molecular I/O, standardization, and feature extraction using RDKit's Python interface.

## Core Usage Patterns

### Installation and Environment
The recommended way to install RDKit is via conda to ensure all C++ dependencies and Python wrappers are correctly linked.
```bash
conda install -c conda-forge rdkit
```

### Molecular Input/Output
RDKit supports various formats. The most common are SMILES for strings and SDF for 3D/multi-molecule files.

*   **From SMILES**: `mol = Chem.MolFromSmiles('c1ccccc1')`
*   **From SDF**: Use `SDMolSupplier` for iterating through large files.
    ```python
    suppl = Chem.SDMolSupplier('data.sdf')
    for mol in suppl:
        if mol is None: continue
        # process molecule
    ```
*   **To SMILES**: `Chem.MolToSmiles(mol)`

### Molecular Standardization
Before performing analysis or machine learning, molecules should be standardized to ensure consistency (e.g., removing salts, neutralizing charges).
*   **Uncharging**: Use `rdMolStandardize.Uncharger()` to neutralize molecules.
*   **Tautomer Enumeration**: Use `rdMolStandardize.TautomerEnumerator()` to find the canonical tautomer for consistent indexing.
*   **Adding Hydrogens**: Use `Chem.AddHs(mol)` for 3D coordinate generation; use `Chem.RemoveHs(mol)` for simple substructure matching.

### Substructure Searching and SMARTS
Use SMARTS strings to define patterns for matching.
```python
pattern = Chem.MolFromSmarts('[NX3][CX3](=[OX1])[#6]') # Amide bond
matches = mol.GetSubstructMatches(pattern)
```

### Descriptor and Fingerprint Generation
Fingerprints are essential for similarity searching and ML models.
*   **Morgan Fingerprints (Circular)**:
    ```python
    from rdkit.Chem import AllChem
    fp = AllChem.GetMorganFingerprintAsBitVect(mol, radius=2, nBits=2048)
    ```
*   **Molecular Descriptors**: Use `rdkit.Chem.Descriptors` to calculate LogP, Molecular Weight, etc.

### 3D Conformer Generation
Generating 3D coordinates from 2D/SMILES:
```python
mol_3d = Chem.AddHs(mol)
AllChem.EmbedMolecule(mol_3d, AllChem.ETKDG())
AllChem.MMFFOptimizeMolecule(mol_3d)
```

## Expert Tips
*   **Sanitization**: Always ensure molecules are sanitized (`Chem.SanitizeMol`) before calculation, as this perceives aromaticity and validates valence.
*   **Handling Errors**: `MolFromSmiles` returns `None` if the SMILES is invalid. Always check for `None` before calling methods on the molecule object.
*   **Memory Efficiency**: When processing millions of molecules, use `ForwardSDMolSupplier` to read from a stream without loading the entire file into memory.
*   **Stereochemistry**: Use `Chem.AssignStereochemistry` to explicitly perceive and label chiral centers and double bond stereochemistry.

## Reference documentation
- [RDKit README](./references/github_com_rdkit_rdkit.md)
- [RDKit Wiki](./references/github_com_rdkit_rdkit_wiki.md)
- [RDKit Discussions](./references/github_com_rdkit_rdkit_discussions.md)