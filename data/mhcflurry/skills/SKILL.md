---
name: mhcflurry
description: MHCflurry predicts the binding affinity and presentation scores of peptides to MHC Class I molecules. Use when user asks to predict peptide-MHC interactions, scan protein sequences for epitopes, or simulate antigen processing.
homepage: https://github.com/hammerlab/mhcflurry
---


# mhcflurry

## Overview
MHCflurry is a specialized toolset for predicting the interaction between peptides and Major Histocompatibility Complex (MHC) Class I molecules. Unlike basic affinity predictors, MHCflurry incorporates multiple models to simulate the biological pipeline of antigen presentation, including proteasomal cleavage (antigen processing) and a composite presentation score. It is designed for researchers performing epitope discovery, vaccine design, or immunopeptidomics analysis.

## Installation and Data Setup
Before running predictions, you must download the trained models and datasets.

```bash
# Install via pip
pip install mhcflurry

# Download required models (mandatory for first-time use)
mhcflurry-downloads fetch
```

If you encounter connection issues during the fetch command, use `mhcflurry-downloads url <model_name>` to get the direct link, download it via `wget`, and then use the `--already-downloaded-dir` flag to install.

## Common CLI Patterns

### Predicting Binding Affinity for Specific Peptides
Use `mhcflurry-predict` when you have a defined list of peptides and target alleles.

```bash
mhcflurry-predict \
  --alleles HLA-A0201 HLA-A0301 \
  --peptides SIINFEKL SIINFEKD SIINFEKQ \
  --out predictions.csv
```

### Scanning Protein Sequences for Epitopes
Use `mhcflurry-predict-scan` to find high-affinity binders within a full protein sequence. This automatically fragments the sequence into overlapping peptides (k-mers).

```bash
mhcflurry-predict-scan \
  --sequences MFVFLVLLPLVSSQCVNLTTRTQLPPAYTNSFTRGVYYPDKVFRSSVLHS \
  --alleles HLA-A*02:01 \
  --out scan_results.csv
```

## Expert Tips and Best Practices

- **Presentation Scores vs. Binding Affinity**: While binding affinity (IC50) is the traditional metric, the "presentation score" provided by MHCflurry 2.0 is often more accurate for identifying naturally presented ligands as it accounts for processing constraints.
- **Allele Nomenclature**: MHCflurry is flexible with HLA nomenclature, but using the standard format (e.g., `HLA-A*02:01` or `HLA-A0201`) is recommended for consistency.
- **Batch Processing**: For large-scale genomic or proteomic screens, pipe sequences into `mhcflurry-predict-scan` or provide a text file with one sequence per line to maximize throughput.
- **Model Selection**: By default, MHCflurry uses the latest released models. If you need to replicate results from older studies, use the `mhcflurry-downloads` tool to inspect and fetch specific model versions.

## Reference documentation
- [MHCflurry Overview and Installation](./references/anaconda_org_channels_bioconda_packages_mhcflurry_overview.md)
- [MHCflurry GitHub Repository and Usage Examples](./references/github_com_openvax_mhcflurry.md)