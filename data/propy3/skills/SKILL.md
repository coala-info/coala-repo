---
name: propy3
description: propy3 is a Python library designed to extract a wide array of theoretical descriptors from protein sequences.
homepage: https://github.com/MartinThoma/propy3
---

# propy3

## Overview

propy3 is a Python library designed to extract a wide array of theoretical descriptors from protein sequences. It serves as a Python 3-compatible drop-in replacement for the original propy package. By converting protein sequences into structured numerical data, it enables the application of machine learning and statistical analysis to biological problems such as predicting protein-protein interactions, drug-target binding, and subcellular localization.

## Installation and Setup

Install the package using pip or conda. Note that while the package name is `propy3`, the library is imported as `propy`.

```bash
# Via pip
pip install propy3

# Via BioConda
conda install -c bioconda propy3
```

## Core Usage Patterns

### Initializing the Descriptor Object
The primary workflow involves creating a `GetProDes` object from a protein sequence string.

```python
from propy import PyPro

sequence = "MQVWPIEGIKKFETLSYLPPLTVEDLLKQI..."
des_object = PyPro.GetProDes(sequence)
```

### Calculating Common Descriptors
Access specific descriptor sets using the object's methods:

*   **Amino Acid Composition (AAC):** `des_object.GetAAComp()` (20 features)
*   **Dipeptide Composition (DPC):** `des_object.GetDPComp()` (400 features)
*   **Composition, Transition, Distribution (CTD):** `des_object.GetCTD()` (147 features)
*   **Pseudo Amino Acid Composition (PAAC):** `des_object.GetPAAC(lamda=10, weight=0.05)`
*   **Amphiphilic PAAC (APAAC):** `des_object.GetAPAAC(lamda=10, weight=0.05)`

### Fetching Sequences from UniProt
Use the built-in utility to retrieve sequences directly via UniProt IDs.

```python
from propy.GetProteinFromUniprot import GetProteinSequence

protein_seq = GetProteinSequence("P48039")
```

## Descriptor Reference Table

| Code | Descriptor Type | Default Feature Count |
| :--- | :--- | :--- |
| **AAC** | Amino acid composition | 20 |
| **DPC** | Dipeptide composition | 400 |
| **TPC** | Tri-peptide composition | 8000 |
| **CTD** | Composition, Transition, Distribution | 147 |
| **MBauto** | Normalized Moreau-Broto autocorrelation | 240 (default) |
| **Moranauto** | Moran autocorrelation | 240 (default) |
| **Gearyauto** | Geary autocorrelation | 240 (default) |
| **SOCN** | Sequence order coupling numbers | 60 (default) |
| **QSO** | Quasi-sequence order descriptors | 100 (default) |
| **PAAC** | Pseudo amino acid composition | 50 (default) |
| **APAAC** | Amphiphilic pseudo amino acid composition | 50 (default) |

## Expert Tips and Best Practices

*   **Import Naming:** Always remember to `import propy`, not `import propy3`.
*   **Parameter Tuning:** For `PAAC` and `APAAC`, the `lamda` parameter must be smaller than the length of the protein sequence. If processing short peptides, ensure `lamda` is adjusted downward.
*   **Feature Engineering:** When building machine learning models, start with `GetAAComp` and `GetCTD` for a robust baseline (167 features total) before moving to high-dimensional descriptors like `TPC` (8000 features).
*   **AAindex Integration:** The package can automatically download properties from the AAindex database, allowing for the calculation of thousands of customized biochemical features.

## Reference documentation
- [propy3 GitHub Repository](./references/github_com_MartinThoma_propy3.md)
- [propy3 BioConda Overview](./references/anaconda_org_channels_bioconda_packages_propy3_overview.md)