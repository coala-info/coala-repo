---
name: pyonsite
description: pyonsite localizes post-translational modifications on peptide sequences using statistical validation and probability-based scoring algorithms. Use when user asks to localize phosphorylation sites, calculate site-specific probabilities, or perform false localization rate estimation for PTMs.
homepage: https://www.github.com/bigbio/onsite
---


# pyonsite

## Overview
The `pyonsite` skill enables the precise localization of post-translational modifications (primarily phosphorylation) on peptide sequences. By integrating three industry-standard algorithms—AScore, PhosphoRS, and LucXor—it allows for statistical validation and probability-based scoring of site assignments. This skill is essential when you need to move beyond simple peptide identification to determine exactly which residue (e.g., S, T, or Y) carries a modification, using `.mzML` spectra and `.idXML` identification files.

## Installation and Setup
The package is available via Bioconda and PyPI. Note the naming distinction: the package is installed as `pyonsite` but executed/imported as `onsite`.

```bash
# Installation via Conda (Recommended)
conda install bioconda::pyonsite

# Installation via pip
pip install pyonsite
```

## Unified CLI Usage
The `onsite` command provides a single entry point for all three localization algorithms. All algorithms require an input spectrum file (`-in`) and an identification file (`-id`).

### AScore
Best for fast, probability-based scoring using binomial statistics and site-determining ions.
```bash
onsite ascore -in spectra.mzML -id identifications.idXML -out results.idXML --threads 4
```

### PhosphoRS
Best for detailed isomer analysis and site-specific probabilities.
```bash
onsite phosphors -in spectra.mzML -id identifications.idXML -out results.idXML --add-decoys
```

### LucXor (LuciPHOr2)
Best for advanced statistical validation, including False Localization Rate (FLR) estimation and decoy-based modeling.
```bash
onsite lucxor -in spectra.mzML -id identifications.idXML -out results.idXML --fragment-method HCD --threads 8
```

## Expert Tips and Best Practices
- **Algorithm Selection**: Use `AScore` for speed and standard phosphorylation; use `LucXor` when rigorous FLR estimation is required for publication-quality validation.
- **Mass Tolerance**: Ensure `--fragment-mass-tolerance` matches your instrument settings (e.g., `0.05 Da` for high-res, `0.5 Da` for low-res). Use `--fragment-mass-unit` to specify `Da` or `ppm`.
- **Multi-threading**: Always utilize the `--threads` parameter for large datasets, as PTM localization is computationally intensive due to permutation testing.
- **Decoy Analysis**: Enable `--add-decoys` to validate the reliability of the localization scores.
- **LucXor Modeling**: LucXor requires a minimum number of high-scoring PSMs to build its model (default 50). If your dataset is small, you may need to adjust `--min-num-psms-model`.
- **Integration**: The tool outputs `.idXML` files, which are natively compatible with the OpenMS ecosystem for downstream quantification or visualization.

## Reference documentation
- [onsite: posttranslation modification site localization](./references/github_com_bigbio_onsite.md)