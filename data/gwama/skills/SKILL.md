---
name: gwama
description: The `gwama` tool is a specialized utility for meta-analyzing genome-wide association study results.
homepage: https://www.geenivaramu.ee/en/tools/gwama
---

# gwama

## Overview
The `gwama` tool is a specialized utility for meta-analyzing genome-wide association study results. It allows researchers to aggregate data across different cohorts to increase statistical power for detecting genetic associations. It handles various input formats, manages genomic strand alignment, and calculates pooled effect sizes, standard errors, and heterogeneity statistics (like I-squared).

## Command Line Usage
The basic execution pattern for `gwama` involves a configuration file (map file) and specific flags to define the analysis model.

### Basic Execution
```bash
gwama --map [map_file] --output [output_prefix]
```

### Key Parameters
- `--map`: Path to the file listing the study-specific result files.
- `--output`: Prefix for the generated results (defaults to `gwama_results`).
- `--random`: Perform random-effects meta-analysis (default is fixed-effects).
- `--genomic-control`: Apply genomic control to study-specific results before meta-analysis.
- `--quantitative`: Specify that the trait is quantitative (continuous).
- `--binary`: Specify that the trait is binary (case-control).

## Input File Requirements
To ensure successful execution, input files must be formatted correctly:

1.  **The Map File**: A simple text file where each line contains the path to a study's summary statistics file.
2.  **Summary Statistics**: Each study file should ideally contain:
    - Marker name (RSID)
    - Allele 1 and Allele 2
    - Frequency of Allele 1
    - Beta (effect size) or OR (odds ratio)
    - Standard Error (SE)
    - P-value

## Best Practices
- **Strand Alignment**: Ensure all studies are aligned to the same reference strand. `gwama` can handle strand flipping if the alleles are provided, but pre-alignment reduces errors.
- **Filtering**: Filter out low-quality variants (e.g., low MAF or low imputation quality) from individual study files before running the meta-analysis.
- **Heterogeneity**: Always check the `i_squared` and `q_statistic` in the output to identify variants with inconsistent effects across studies.

## Reference documentation
- [gwama - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_gwama_overview.md)