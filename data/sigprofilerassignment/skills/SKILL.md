---
name: sigprofilerassignment
description: SigProfilerAssignment maps established mutational signatures to genomic data to determine signature activity and calculate specific mutation counts. Use when user asks to assign mutational signatures to samples, perform signature refitting, or calculate the contribution of mutational processes from VCF, MAF, or matrix files.
homepage: https://github.com/AlexandrovLab/SigProfilerAssignment.git
metadata:
  docker_image: "quay.io/biocontainers/sigprofilerassignment:1.1.3--pyhdfd78af_0"
---

# sigprofilerassignment

## Overview
SigProfilerAssignment is a computational tool designed to map established mutational signatures to genomic data. It performs numerical optimization to determine which signatures are active in a sample and calculates the specific mutation count attributed to each. This skill enables the processing of various input formats—including raw mutation calls (VCF/MAF), segmentation files for copy number analysis, and pre-computed mutational matrices—to provide biological insights into mutational processes.

## Core Workflow

### 1. Environment Setup
Before running assignments, ensure the required reference genome is installed via the `SigProfilerMatrixGenerator` dependency:

```python
from SigProfilerMatrixGenerator import install as genInstall
genInstall.install('GRCh37') # Supports GRCh37, GRCh38, mm9, mm10, rn6
```

### 2. Signature Assignment (Refitting)
The primary interface is the `cosmic_fit` function within the `Analyzer` module.

```python
from SigProfilerAssignment import Analyzer as Analyze

Analyze.cosmic_fit(
    samples="path/to/input", 
    output="path/to/output_folder",
    input_type="matrix",          # Options: "matrix", "vcf", "seg:TYPE"
    context_type="96",            # Options: "96", "288", "1536", "DINUC", "ID"
    cosmic_version=3.5,           # Supports 1, 2, 3, 3.1, 3.2, 3.3, 3.4, 3.5
    genome_build="GRCh37",
    exome=False,                  # Set True for exome-specific signatures
    make_plots=True,
    sample_reconstruction_plots='pdf' # Requires poppler for 'png' or 'both'
)
```

## Expert Tips and Best Practices

### Input Handling
- **VCF/MAF Inputs**: When using `input_type="vcf"`, the tool automatically invokes `SigProfilerMatrixGenerator`. Ensure the `samples` parameter points to the directory containing the files, not a single file.
- **Segmentation Files**: For copy number signatures, use the format `seg:CALLER` (e.g., `seg:BATTENBERG`, `seg:FACETS`, or `seg:ASCAT`).
- **Custom Databases**: To use non-COSMIC signatures, provide a path to a tab-delimited file in the `signature_database` parameter. The file must have mutation types as rows and signature IDs as columns.

### Optimization and Accuracy
- **Signature Subgroups**: Use `exclude_signature_subgroups` to filter out irrelevant signatures (e.g., chemotherapy signatures in treatment-naive samples) to reduce noise and improve refitting accuracy.
- **Probability Mapping**: Set `export_probabilities_per_mutation=True` when using VCF inputs to obtain the probability of each individual mutation belonging to a specific signature.
- **Performance**: By default, the tool uses all available CPU cores (`cpu=-1`). In shared HPC environments, explicitly define the core count to avoid resource contention.

### Visualization
- **Reconstruction Plots**: These plots compare the original mutational profile against the profile reconstructed from assigned signatures. This is the best way to evaluate the "goodness of fit."
- **Dependencies**: If you require PNG outputs for reports, ensure `poppler` is installed in your environment (`conda install -c conda-forge poppler`).

## Reference documentation
- [SigProfilerAssignment GitHub Repository](./references/github_com_SigProfilerSuite_SigProfilerAssignment.md)