---
name: sigprofilerextractor
description: SigProfilerExtractor identifies and quantifies mutational signatures by extracting them de novo using non-negative matrix factorization and decomposing them into known COSMIC signatures. Use when user asks to extract mutational signatures from VCF or matrix files, perform de novo signature discovery, or decompose signatures into established biological processes.
homepage: https://github.com/AlexandrovLab/SigProfilerExtractor
---


# sigprofilerextractor

## Overview
SigProfilerExtractor is a bioinformatics framework designed to identify and quantify mutational signatures. It uses Non-negative Matrix Factorization (NMF) to extract signatures *de novo* and then decomposes them into known COSMIC signatures. This tool is essential for researchers looking to understand the underlying biological or environmental processes (like UV exposure, smoking, or DNA repair deficiencies) that have shaped the genome of a specific sample or cohort.

## Core Workflow

### 1. Installation and Genome Setup
Before running extraction, ensure the required reference genomes are installed via the Python interface:

```python
from SigProfilerMatrixGenerator import install as genInstall
# Supported: 'GRCh37', 'GRCh38', 'mm9', 'mm10'
genInstall.install('GRCh37')
```

### 2. Data Import
Use the `importdata` function to locate example datasets or prepare your path:

```python
from SigProfilerExtractor import sigpro as sig
path_to_example = sig.importdata("matrix")
```

### 3. Signature Extraction (Main Function)
The `sigProfilerExtractor` function is the primary entry point. It handles matrix generation (via SigProfilerMatrixGenerator) and the NMF process.

```python
from SigProfilerExtractor import sigpro as sig

sig.sigProfilerExtractor(
    input_type="vcf", 
    out_put="output_folder", 
    input_data="path/to/vcf/files",
    reference_genome="GRCh37",
    minimum_signatures=1,
    maximum_signatures=10,
    nmf_replicates=100,
    cpu=-1 # Use all available CPUs
)
```

### 4. Key Parameters and Best Practices
*   **input_type**: 
    *   `"vcf"`: For raw variant calls.
    *   `"matrix"`: For pre-calculated mutational tables (tab-separated).
    *   `"seg:TYPE"`: For copy number analysis (e.g., `"seg:BATTENBERG"`, `"seg:FACETS"`).
*   **nmf_replicates**: For publication-quality results, use at least `100` replicates. For quick testing, reduce to `5-10`.
*   **context_type**: Defaults to `"96,DINUC,ID"`. You can specify individual contexts (e.g., `"96"`) to save computation time if only SBS signatures are needed.
*   **exome**: Set to `True` if analyzing Whole Exome Sequencing (WES) data to apply the correct normalization.
*   **matrix_normalization**: The default `"gmm"` (Gaussian Mixture Model) is generally preferred for handling varying mutation burdens across samples.

## Advanced Operations

### Solution Estimation
If you have already run an extraction and want to re-evaluate the optimal number of signatures without re-running NMF:
```python
sig.estimate_solution(base_csv_stats="path/to/All_Solutions_Stats.txt", 
                      output="path/to/evaluation_output")
```

### Signature Decomposition
To decompose your *de novo* extracted signatures into known COSMIC signatures:
```python
sig.decompose(signatures="path/to/de_novo_signatures.txt", 
              activities="path/to/de_novo_activities.txt", 
              output="decomposition_results")
```

## Reference documentation
- [SigProfilerExtractor GitHub Repository](./references/github_com_SigProfilerSuite_SigProfilerExtractor.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_sigprofilerextractor_overview.md)