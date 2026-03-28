---
name: mhcflurry
description: MHCflurry predicts the binding affinity and presentation scores of peptides to MHC Class I molecules across thousands of alleles. Use when user asks to predict peptide-MHC binding, scan protein sequences for potential epitopes, or calculate antigen processing and presentation scores.
homepage: https://github.com/hammerlab/mhcflurry
---

# mhcflurry

## Overview

MHCflurry is a specialized toolset for predicting the binding affinity of peptides to MHC Class I molecules. It features pan-allele predictors supporting over 14,000 MHC alleles and includes experimental models for antigen processing (proteasomal cleavage) and a composite presentation score. It is a core tool for computational immunology, neoantigen screening, and vaccine development workflows.

## Setup and Model Management

Before running predictions, you must download the trained models. The `models_class1_presentation` set is recommended as it includes binding affinity, processing, and presentation predictors.

```bash
# Fetch the latest presentation models
mhcflurry-downloads fetch models_class1_presentation

# Check available and downloaded data
mhcflurry-downloads info
```

## Command-Line Usage Patterns

### Basic Peptide Prediction
Predict binding for specific peptides and alleles. Results include affinity (nM), percentile rank, processing score, and presentation score.

```bash
mhcflurry-predict \
    --alleles HLA-A0201 HLA-A0301 \
    --peptides SIINFEKL SIINFEKD \
    --out predictions.csv
```

### Scanning Protein Sequences
Scan FASTA or CSV protein sequences for potential epitopes. By default, it scans for 8-11mer peptides.

```bash
mhcflurry-predict-scan \
    input.fasta \
    --alleles HLA-A*02:01,HLA-B*07:02 \
    --threshold-affinity 500 \
    --results-filtered affinity
```

### Working with Genotypes
You can provide a comma-separated list of alleles to represent a sample's genotype. MHCflurry will report the tightest binding affinity across all alleles in that genotype for each peptide.

```bash
mhcflurry-predict --peptides SIINFEKL --alleles HLA-A*02:01,HLA-A*03:01,HLA-B*57:01
```

## Python Library Integration

For complex pipelines, use the Python API to load predictors and process dataframes directly.

```python
from mhcflurry import Class1PresentationPredictor

# Load the default downloaded predictor
predictor = Class1PresentationPredictor.load()

# Predict for a list of peptides and a genotype
results = predictor.predict(
    peptides=["SIINFEKL", "NLVPMVATV"],
    alleles=["HLA-A0201", "HLA-A0301"]
)
```

## Expert Tips and Best Practices

- **Affinity Thresholds**: A common threshold for potential immunogenicity is **< 500 nM**. For percentile ranks, **< 2%** is typically used to identify strong binders.
- **Flanking Sequences**: When using the presentation or processing predictors, provide N-terminal and C-terminal flanking sequences (the amino acids immediately adjacent to the peptide in the source protein) to significantly improve cleavage prediction accuracy.
- **Performance**: If you only need binding affinity and not processing/presentation scores, use the `--affinity-only` flag in the CLI to reduce computation time.
- **Allele Naming**: MHCflurry uses the `mhcnames` package for normalization. It accepts various formats (e.g., `HLA-A0201`, `A*02:01`, `A02:01`) and converts them to a standard format automatically.
- **Memory Management**: If encountering out-of-memory errors with pan-allele models, set the environment variable `MHCFLURRY_OPTIMIZATION_LEVEL=0`.



## Subcommands

| Command | Description |
|---------|-------------|
| mhcflurry-downloads | Download MHCflurry released datasets and trained models. |
| mhcflurry-predict | Run MHCflurry predictor on specified peptides. |
| mhcflurry-predict-scan | Scan protein sequences using the MHCflurry presentation predictor. |

## Reference documentation
- [Command-line reference](./references/openvax_github_io_mhcflurry_commandline_tools.html.md)
- [Command-line tutorial](./references/openvax_github_io_mhcflurry_commandline_tutorial.html.md)
- [Python library tutorial](./references/openvax_github_io_mhcflurry_python_tutorial.html.md)
- [Introduction and setup](./references/openvax_github_io_mhcflurry_intro.html.md)