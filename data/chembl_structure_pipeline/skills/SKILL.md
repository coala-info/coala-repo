---
name: chembl_structure_pipeline
description: This tool curates and standardizes chemical structures according to the protocols used by the ChEMBL database. Use when user asks to standardize functional groups, strip salts or solvents to extract parent molecules, and identify structural quality issues or valency errors.
homepage: https://github.com/chembl/ChEMBL_Structure_Pipeline
---


# chembl_structure_pipeline

## Overview
The ChEMBL Structure Pipeline is a specialized toolset for the curation and standardization of chemical structures. It implements the exact protocols used by the ChEMBL database to ensure that molecules are represented consistently across large datasets. You should use this skill when you need to process "raw" chemical data into a "clean" format suitable for database storage, virtual screening, or SAR analysis. It excels at neutralizing charges, standardizing functional groups, removing salts or solvents, and identifying structural anomalies that could break downstream modeling.

## Usage Patterns

The pipeline is primarily used as a Python library. All core functions expect and return Molblock strings (V2000 format).

### 1. Standardizing a Molecule
Standardization unifies the representation of functional groups (e.g., nitro groups, azides) and ensures the molecule follows ChEMBL's business rules.

```python
from chembl_structure_pipeline import standardizer

# Input: A raw molblock string
std_molblock = standardizer.standardize_molblock(raw_molblock)
```

### 2. Salt Stripping (Extracting the Parent)
To compare the core active moieties of different salt forms or remove solvents, use the parent extraction tool. This returns a tuple containing the parent molblock and a boolean indicating if the structure was modified.

```python
from chembl_structure_pipeline import standardizer

# Returns (parent_molblock, was_modified)
parent_molblock, changed = standardizer.get_parent_molblock(molblock)
```

### 3. Structure Checking and Quality Assessment
The checker identifies potential issues such as unusual valency, overlapping atoms, or problematic stereochemistry. It returns a list of issues, each associated with a penalty score from 0 (minor) to 9 (critical).

```python
from chembl_structure_pipeline import checker

# Returns a list of tuples: (penalty_score, issue_description)
issues = checker.check_molblock(molblock)

# Example output processing
for score, msg in issues:
    if score > 5:
        print(f"Critical Issue: {msg}")
```

## Best Practices and Expert Tips

- **Input Format**: The pipeline is strictly designed for Molblock strings. If your source data is in SMILES format, use RDKit to convert `SMILES -> RDKit Mol -> Molblock` before passing it to the pipeline.
- **Workflow Sequence**: For the most robust curation, follow this order:
    1. **Check**: Identify if the raw structure is fundamentally broken.
    2. **Standardize**: Unify functional group representations.
    3. **Get Parent**: Strip salts to isolate the active moiety.
    4. **Check (Final)**: Ensure the standardization/stripping didn't introduce new valency issues.
- **Penalty Score Thresholds**: 
    - **Scores 0-3**: Generally safe to ignore or auto-fix.
    - **Scores 4-6**: Potential issues; consider flagging for review.
    - **Scores 7-9**: Critical errors (e.g., hypervalent atoms); these structures should usually be excluded from modeling.
- **Handling Stereochemistry**: Be aware that the standardizer may remove certain stereo-groups or convert specific bond types to ensure database compatibility. Always verify stereochemical integrity if it is critical to your specific application.

## Reference documentation
- [ChEMBL Structure Pipeline README](./references/github_com_chembl_ChEMBL_Structure_Pipeline.md)
- [ChEMBL Structure Pipeline Wiki](./references/github_com_chembl_ChEMBL_Structure_Pipeline_wiki.md)