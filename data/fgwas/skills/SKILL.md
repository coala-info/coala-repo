---
name: fgwas
description: fgwas (Functional Genomics and Genome-Wide Association Studies) is a specialized command-line tool designed to bridge the gap between statistical associations and biological function.
homepage: https://github.com/joepickrell/fgwas
---

# fgwas

## Overview
fgwas (Functional Genomics and Genome-Wide Association Studies) is a specialized command-line tool designed to bridge the gap between statistical associations and biological function. It uses a Bayesian framework to model the relationship between GWAS results and functional genomic data. By calculating enrichment parameters for various annotations, the tool allows researchers to determine which types of genomic regions are most likely to harbor causal variants for a specific trait and subsequently re-rank SNPs based on these functional priors.

## Common CLI Patterns

### Basic Enrichment Analysis
To test for enrichment of a single annotation in your GWAS data:
```bash
fgwas -i input_data.fgwas_in.gz -w annotation_name -o output_prefix
```

### Multiple Annotations
To include multiple functional annotations in a joint model:
```bash
fgwas -i input_data.fgwas_in.gz -w annot1+annot2 -o joint_model_output
```

### Case-Control Studies
When working with case-control GWAS data, use the `-cc` flag to ensure the model correctly handles the underlying statistics:
```bash
fgwas -i input_data.fgwas_in.gz -cc -w annotation_name
```

### Using Bayes Factors
If you have pre-calculated Bayes Factors (BF) or log-Bayes Factors, you can input them directly:
```bash
fgwas -i input_data.fgwas_in.gz -bf -w annotation_name
```

## Expert Tips and Best Practices

### Data Requirements
*   **Signal Density**: The underlying model performs best when the GWAS has at least 20 independent loci with p-values less than 5e-8. With fewer hits, the model may struggle to converge or produce reliable enrichment estimates.
*   **Input Formatting**: Ensure your input file is gzipped. The tool expects specific columns including SNP ID, chromosome, position, and association statistics (Z-scores or BFs).

### Model Selection and Fine-mapping
*   **Cross-Validation**: Use the cross-validation features to prevent overfitting when testing many annotations.
*   **Penalty Parameters**: If the model fails to converge due to a small number of hits in a specific annotation, consider simplifying the model or checking for high correlation between annotations.

### Installation Troubleshooting
*   **Library Paths**: If compiling from source, the most common failure is the linker's inability to find the GNU Scientific Library (GSL) or Boost. Use `LDFLAGS` to point to non-standard library locations:
    ```bash
    ./configure LDFLAGS=-L/path/to/your/lib
    ```
*   **Conda Preference**: For most environments, installing via Bioconda (`conda install bioconda::fgwas`) is recommended to avoid dependency resolution issues.

## Reference documentation
- [fgwas - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_fgwas_overview.md)
- [GitHub - joepickrell/fgwas: Functional genomics and genome-wide association studies](./references/github_com_joepickrell_fgwas.md)