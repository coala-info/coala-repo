---
name: verifyidintensity
description: The `verifyidintensity` tool detects DNA contamination in genomic samples by analyzing signal intensity patterns. Use when user asks to detect DNA contamination, estimate contamination levels, identify contaminated samples, or check for sample mix-ups.
homepage: https://genome.sph.umich.edu/wiki/VerifyIDintensity
metadata:
  docker_image: "quay.io/biocontainers/verifyidintensity:0.0.1--h077b44d_6"
---

# verifyidintensity

## Overview
The `verifyidintensity` tool is a specialized utility for quality control in genomic studies using Illumina arrays. It analyzes signal intensity patterns to determine if a sample contains DNA from more than one individual. By calculating the likelihood of contamination based on observed intensities versus expected values for a single individual, it provides a quantitative estimate of contamination levels, which is essential for ensuring the integrity of downstream genetic analyses.

## Usage Guidelines

### Core Command Pattern
The tool typically requires intensity data (Log R Ratio and B Evans Fraction) and population allele frequencies.
```bash
verifyIDintensity --vcf [input.vcf] --intensity [intensity_file] --output [prefix]
```

### Key Parameters and Best Practices
- **Input Preparation**: Ensure your input VCF contains the necessary genotype calls and that the intensity files (often derived from GenomeStudio or similar software) are correctly formatted with LRR and BAF values.
- **Population Reference**: For accurate estimation, use allele frequencies that match the ancestry of the samples being tested.
- **Interpreting Results**:
    - **Contamination Score**: A value near 0 indicates a pure sample.
    - **High Scores**: Significant deviations (e.g., >0.02 or 2%) suggest potential contamination or sample mix-ups that may require excluding the sample from further study.
- **Resource Management**: When processing large batches of Illumina Infinium arrays, run `verifyidintensity` as a pre-processing step before association testing to filter out low-quality data.

### Common Workflow
1. **Export Data**: Export intensity data from Illumina's GenomeStudio.
2. **Run Detection**: Execute `verifyidintensity` to generate contamination estimates.
3. **Filter Samples**: Use the output `.self-check` or summary files to identify samples exceeding the project's contamination threshold.

## Reference documentation
- [verifyidintensity Overview](./references/anaconda_org_channels_bioconda_packages_verifyidintensity_overview.md)