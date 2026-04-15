---
name: triqler
description: Triqler performs statistically rigorous label-free quantification in shotgun proteomics. Use when user asks to perform label-free quantification, evaluate differential expression, handle missing values, calculate posterior probabilities for fold changes, or analyze DDA/DIA proteomics data.
homepage: https://github.com/statisticalbiotechnology/triqler
metadata:
  docker_image: "quay.io/biocontainers/triqler:0.9.1--pyhdfd78af_0"
---

# triqler

## Overview

Triqler (Transparent Identification-Quantification-linked Error Rates) is a probabilistic graphical model designed for shotgun proteomics. Unlike traditional methods that use point estimates, Triqler employs probability distributions to account for uncertainty at every stage of the quantification pipeline—from MS1 features to protein-level fold changes. 

You should use this tool when you need a statistically rigorous approach to label-free quantification (LFQ), especially when dealing with missing values or when you require posterior probabilities for fold changes rather than simple p-values. It supports both Data-Dependent Acquisition (DDA) and Data-Independent Acquisition (DIA) workflows.

## Installation

Triqler can be installed via pip or conda:

```bash
pip install triqler
# OR
conda install bioconda::triqler
```

## Core CLI Usage

The basic syntax for running Triqler is:

```bash
python -m triqler [options] IN_FILE
```

### Common Command Patterns

**Standard DDA Analysis:**
Evaluate differential expression with a log2 fold change threshold of 0.8.
```bash
python -m triqler --fold_change_eval 0.8 --out_file results.tsv input_psms.tsv
```

**DIA Analysis:**
Use the specialized missing value prior for DIA data.
```bash
python -m triqler --missing_value_prior DIA input_psms.tsv
```

**High-Performance Execution:**
Utilize multiple CPU cores to speed up the probabilistic modeling.
```bash
python -m triqler --num_threads 12 input_psms.tsv
```

## Input Data Requirements

Triqler requires a specific tab-separated format. You must convert your search engine output (MaxQuant, DIA-NN, etc.) before running the main model.

### Simple Input Format (TSV)
The file must contain these columns:
1. `run`: Filename or run identifier.
2. `condition`: Treatment group identifier.
3. `charge`: Precursor charge state.
4. `searchScore`: Confidence score (higher must be better).
5. `intensity`: Raw XIC area (do **not** log-transform).
6. `peptide`: Peptide sequence.
7. `proteins`: Space-separated list of protein identifiers.

### Critical Data Rules
- **Decoys:** You must include decoy PSMs in the input file for the error model to function.
- **Intensity 0:** Triqler treats 0 as a missing value. Do not use 0 for observed low-intensity noise.
- **Score Orientation:** If your search engine uses a "lower is better" score (like p-value or PEP), you must transform it (e.g., `-log10(PEP)`) before inputting to Triqler.

## Expert Tips and Best Practices

- **Fold Change Threshold:** The `--fold_change_eval` parameter (default 1.0) defines the "interesting" fold change. Triqler calculates the probability that the true fold change is greater than this threshold. Adjust this based on your experimental design.
- **Missing Value Priors:** Use `--missing_value_prior default` for most DDA experiments. Use `DIA` only when you have a high frequency of missing values that are not necessarily due to low abundance (censoring).
- **Protein Grouping:** If a peptide maps to multiple proteins, list them all in the `proteins` column. Triqler handles the parsimony/apportioning probabilistically.
- **Output Interpretation:** The primary output `proteins.tsv` contains a column `posterior_error_prob`. This is the probability that the protein does **not** meet the fold change threshold specified.
- **Visualizing Results:** Use the `--write_protein_posteriors` flag to export raw data that can be used to plot the full probability distribution of a protein's fold change, which is more informative than a single point estimate.

## Reference documentation

- [Triqler GitHub Repository](./references/github_com_statisticalbiotechnology_triqler.md)
- [Triqler Wiki and Converters](./references/github_com_statisticalbiotechnology_triqler_wiki.md)
- [Bioconda Triqler Package](./references/anaconda_org_channels_bioconda_packages_triqler_overview.md)