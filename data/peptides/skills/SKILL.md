---
name: peptides
description: The `peptides` package is a comprehensive Python library designed for the computational analysis of amino acid sequences.
homepage: https://peptides.readthedocs.io/
---

# peptides

## Overview

The `peptides` package is a comprehensive Python library designed for the computational analysis of amino acid sequences. It provides a unified interface to derive a wide array of descriptors—ranging from simple statistics like amino acid frequencies to complex QSAR indices and hydrophobicity profiles. It is particularly useful for researchers performing protein characterization, sequence vetting against reference databases like SwissProt, and generating feature vectors for machine learning models in proteomics.

## Usage Guidelines

### Core Object Initialization
The primary interface is the `Peptide` class. It validates the sequence upon instantiation.

```python
from peptides import Peptide

# Initialize with a standard amino acid sequence
p = Peptide("ACDEFGHIKLMNPQRSTVWY")

# The library supports 'J' for Leucine/Isoleucine in specific indices
p_with_j = Peptide("ACDEFGHJKLM")
```

### Physicochemical Properties
Calculate standard biochemical metrics using various scales where applicable.

*   **Isoelectric Point:** Use `p.isoelectric_point(table="EMBOSS")`. Supported scales include "Bjellqvist", "EMBOSS", "Murray", "Sillero", etc.
*   **Molecular Weight:** Use `p.molecular_weight(average="average")`.
*   **Net Charge:** Use `p.charge(ph=7.0, pka="EMBOSS")` to calculate the theoretical net charge at a specific pH.
*   **Instability Index:** Use `p.instability_index()` to predict if a protein will be stable in a test tube.

### QSAR Descriptors
Generate numerical vectors for quantitative structure-activity relationship (QSAR) modeling.

*   **Z-Scales:** `p.z_scales()` (5 descriptors representing hydrophobicity, bulk, and electronic properties).
*   **BLOSUM Indices:** `p.blosum_indices()` (derived from the BLOSUM62 matrix).
*   **FASGAI Vectors:** `p.fasgai_vectors()` (Factor Analysis Scales of Global Amino acid Indices).
*   **Other Scales:** Supports Atchley factors, Kidera factors, Cruciani properties, and VHSE-scales.

### Sequence Statistics and Vetting
Perform basic sequence analysis and outlier detection.

*   **Statistics:** Use `p.counts()`, `p.frequencies()`, `p.entropy()`, and `p.longest_run()` for rapid sequence characterization.
*   **Outlier Detection:** Use `p.detect_outlier()` to compare the sequence against the SwissProt database distribution. This returns an `OutlierResult` indicating if the sequence is statistically anomalous.

### Sequence Profiles
Generate per-residue profiles for structural or membrane analysis.

*   **Hydrophobicity:** `p.hydrophobicity_profile(method="KyteDoolittle")`.
*   **Membrane Position:** `p.membrane_position_profile()` based on Eisenberg (1984).
*   **Hydrophobic Moment:** `p.hydrophobic_moment_profile(window=11, angle=100)` for identifying amphiphilic structures.

## Expert Tips

*   **Performance:** The library uses `bytes.translate` for high-performance sequence encoding. For large-scale datasets, ensure you are using version 0.4.0+ which optimized instantiation.
*   **Vectorization:** Many methods support vectorized operations via NumPy if it is installed in the environment.
*   **Biosynthesis Cost:** Use `p.energy_cost()` and `p.nutrient_cost()` to estimate the metabolic burden of peptide production, which is useful in synthetic biology and metabolic engineering.

## Reference documentation

- [peptides.py — peptides 0.5.0 documentation](./references/peptides_readthedocs_io_en_stable.md)
- [API Reference — peptides 0.5.0 documentation](./references/peptides_readthedocs_io_en_stable_api_index.html.md)
- [Changelog — peptides 0.5.0 documentation](./references/peptides_readthedocs_io_en_stable_guide_changes.html.md)