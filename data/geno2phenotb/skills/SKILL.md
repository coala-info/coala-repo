---
name: geno2phenotb
description: geno2phenotb predicts drug resistance profiles for *Mycobacterium tuberculosis* from genomic sequencing data using machine learning models. Use when user asks to predict antibiotic resistance, analyze MTB genomic data, or identify resistance to first-line and second-line tuberculosis drugs.
homepage: https://github.com/msmdev/geno2phenoTB
---


# geno2phenotb

## Overview
The `geno2phenotb` skill enables the automated prediction of drug resistance profiles for *Mycobacterium tuberculosis* (MTB) directly from genomic data. It integrates the MTBseq processing pipeline with specialized machine learning models (including Gradient-Boosted Trees and Random Forests) to analyze 5 first-line and 7 second-line antibiotics. This tool is designed to replace or supplement time-consuming phenotypic drug susceptibility testing (DST) by providing results within minutes from raw sequencing reads.

## Installation and Environment Setup
To ensure compatibility and avoid dependency conflicts, always use a dedicated Conda environment.

**Warning**: Do not use version 1.0.0, as it is known to be broken on Bioconda. Always install version 1.0.1 or higher.

```bash
# Create and activate a clean environment
conda create -n g2p-tb
conda activate g2p-tb

# Install the tool from the bioconda channel
conda install -c bioconda geno2phenoTB
```

## Input Requirements and File Naming
The tool is highly sensitive to file naming conventions. It expects a directory containing FASTQ files (compressed or uncompressed) for a single bacterial sample.

### Strict Naming Convention
Files must follow this specific pattern to be recognized:
`[SampleID]_[LibID]_[*]_[Direction].f(ast)q.gz`

*   **SampleID**: The unique identifier for the bacterial sample.
*   **LibID**: The sequencing library identifier.
*   **Direction**: Must be either `R1` (forward/single-end) or `R2` (reverse).
*   **[*]**: Optional additional fields.

**Example**: `ERR551304_X_R1.fastq.gz`

## Command Line Usage
The primary interface requires the path to the directory containing your FASTQ files.

```bash
# Basic execution (replace [input_directory] with your data path)
geno2phenotb [input_directory]
```

## Supported Antibiotics
The tool provides resistance predictions for the following 12 drugs:
*   **First-generation**: Ethambutol, Isoniazid, Pyrazinamide, Rifampicin, Streptomycin.
*   **Second-generation**: Amikacin, Capreomycin, Cycloserine, Fluoroquinolones, Kanamycin, Para-aminosalicylic acid (PAS), Thioamides.

## Best Practices and Expert Tips
*   **Local Scaling**: Unlike web-based tools, `geno2phenotb` is designed for local workstations or HPC clusters. Use it to process thousands of samples in parallel by scripting the directory inputs.
*   **Interpretability**: The tool outputs model-intrinsic feature importance values or uses rule-based classifiers (RBC) to provide "OR-rules," helping clinicians and researchers understand why a specific resistance prediction was made.
*   **Data Processing**: Since the tool uses `MTBseq` under the hood, ensure your system has sufficient computational resources (CPU/RAM) for the initial alignment and variant calling steps, which are the most intensive parts of the workflow.
*   **Single vs. Paired End**: For single-end data, the file must still use the `R1` direction indicator in the filename.

## Reference documentation
- [Bioconda geno2phenotb Overview](./references/anaconda_org_channels_bioconda_packages_geno2phenotb_overview.md)
- [geno2phenoTB GitHub Repository](./references/github_com_msmdev_geno2phenoTB.md)