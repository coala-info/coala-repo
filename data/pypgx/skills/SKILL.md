---
name: pypgx
description: PyPGx is a bioinformatics platform for pharmacogenomics analysis that translates genomic data into star-allele nomenclature and predicts clinical phenotypes. Use when user asks to call star alleles, detect structural variations in pharmacogenes, or predict metabolic phenotypes from genomic data.
homepage: https://github.com/sbslee/pypgx
---


# pypgx

## Overview

PyPGx is a specialized bioinformatics platform designed to provide a unified environment for pharmacogenomics analysis. It translates genomic data into standardized star-allele nomenclature (e.g., *4/*5) and predicts clinical phenotypes (e.g., Poor Metabolizer). The tool is particularly powerful for its ability to detect complex structural variations—such as gene deletions, duplications, and hybrids—using a machine learning-based approach (SVM). It supports 88 pharmacogenes and is compatible with both GRCh37 (hg19) and GRCh38 (hg38) reference builds.

## Essential Setup and Resource Management

The most critical aspect of using pypgx is the requirement of a separate resource bundle containing reference haplotype panels and structural variant classifiers.

### 1. Installation
Conda is the recommended installation method because it automatically handles the OpenJDK dependency required for the Beagle phasing software.

```bash
conda install -c bioconda pypgx
```

### 2. Mandatory Resource Bundle
The core pypgx package is small (<1 MB) because the large genomic reference files are hosted in a separate repository. You must clone the bundle version that matches your pypgx version.

```bash
# Replace x.x.x with your pypgx version (e.g., 0.26.0)
cd ~
git clone --branch x.x.x --depth 1 https://github.com/sbslee/pypgx-bundle
```

### 3. Configuring the Bundle Path
By default, pypgx looks for the bundle in your home directory. If you store it elsewhere, you must set the `PYPGX_BUNDLE` environment variable.

```bash
export PYPGX_BUNDLE=/path/to/pypgx-bundle
```

## Expert Tips and Best Practices

### Structural Variation (SV) Detection
*   **SVM Classifiers**: pypgx uses a support vector machine (SVM) multiclass classifier for each gene. This is necessary because sequence homology (e.g., between CYP2D6 and CYP2D7) often causes read misalignment.
*   **Gene Specificity**: SV detection is not universal; it is trained for specific genes. Check the "Genes" documentation to verify if SV detection is supported for your target gene.

### Data Compatibility
*   **NGS Data**: Best for SV detection and star-allele calling.
*   **SNP Arrays**: Supported for genotype prediction but may have limited SV detection capabilities compared to sequencing.
*   **Long-read Sequencing**: Supported for phased haplotype resolution.

### Haplotype Phasing
*   pypgx uses **Beagle** for phasing SNVs and indels.
*   The software (beagle.jar) is bundled within the pypgx installation, so no separate download is required, but a Java Runtime Environment (JRE) must be present in your path.

## Reference documentation
- [pypgx GitHub Repository](./references/github_com_sbslee_pypgx.md)
- [pypgx Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pypgx_overview.md)