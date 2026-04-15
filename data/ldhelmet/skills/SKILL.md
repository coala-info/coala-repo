---
name: ldhelmet
description: LDhelmet infers fine-scale crossover recombination rates from population genetic data. Use when user asks to estimate recombination rates from population genetic data, particularly for fine-scale analysis.
homepage: http://sourceforge.net/projects/ldhelmet/
metadata:
  docker_image: "quay.io/biocontainers/ldhelmet:1.10--h0704011_8"
---

# ldhelmet

ldhelmet/
├── SKILL.md
└── references/
    ├── anaconda_org_channels_bioconda_packages_ldhelmet_overview.md
    └── sourceforge_net_projects_ldhelmet.md
```

SKILL.md:
```yaml
name: ldhelmet
description: Software program for statistical inference of fine-scale crossover recombination rates from population genetic data. Use when needing to estimate recombination rates from population genetic data, particularly for fine-scale analysis.
```
## Overview
LDhelmet is a software program designed for the statistical inference of fine-scale crossover recombination rates from population genetic data. It is particularly useful for detailed analysis of recombination hotspots and variation across genomic regions.

## Usage Instructions

LDhelmet operates via command-line interface. The primary goal is to estimate recombination rates.

### Core Functionality

The main task involves providing genotype data and then running the inference process.

### Common CLI Patterns and Expert Tips

*   **Input Data**: LDhelmet typically requires genotype data in a specific format (e.g., VCF or a custom format). Ensure your input data is correctly formatted and pre-processed.
*   **Parameter Tuning**: Experiment with different parameters for the inference algorithm. Key parameters often include the number of iterations, block size, and prior settings. Consult the tool's documentation for a full list and their impact.
*   **Output Interpretation**: The output will typically be recombination rate estimates along the genome. Understanding how to interpret these rates in the context of your population genetics study is crucial.
*   **Resource Requirements**: Fine-scale recombination rate inference can be computationally intensive. Ensure you have adequate computational resources (CPU, RAM) for your analysis, especially for large datasets.

### Example Workflow (Conceptual)

While specific commands depend on your data and desired output, a typical workflow might involve:

1.  **Data Preparation**: Convert your genotype data into a format LDhelmet can read.
2.  **Inference Execution**: Run the `ldhelmet` command with your prepared data and appropriate parameters.
3.  **Post-processing**: Analyze the output files to visualize and interpret recombination rates.

For detailed command-line arguments and options, refer to the official LDhelmet documentation or its associated resources.



## Subcommands

| Command | Description |
|---------|-------------|
| ldhelmet find_confs | Finds configurations for LDHelmet. |
| ldhelmet max_lk | Maximum likelihood estimation of recombination rate |
| ldhelmet pade | Compute Pade coefficients for LDHelmet |
| ldhelmet post_to_text | Converts LDHelmet output files to text format. |
| ldhelmet rjmcmc | Run rjmcmc |
| ldhelmet table_gen | Generate tables for LDHelmet |
| ldhelmet_convert_table | Converts LDhat style tables to a format suitable for LDhelmet. |

## Reference documentation
- [LDhelmet Overview (Anaconda.org)](./references/anaconda_org_channels_bioconda_packages_ldhelmet_overview.md)
- [LDhelmet (SourceForge)](./references/sourceforge_net_projects_ldhelmet.md)