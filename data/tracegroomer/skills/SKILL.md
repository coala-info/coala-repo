---
name: tracegroomer
description: TraceGroomer is a specialized preprocessing tool designed to transform raw or corrected tracer metabolomics data into a standardized format required by the DIMet differential analysis suite.
homepage: https://github.com/cbib/TraceGroomer
---

# tracegroomer

## Overview
TraceGroomer is a specialized preprocessing tool designed to transform raw or corrected tracer metabolomics data into a standardized format required by the DIMet differential analysis suite. It automates the generation of multiple quantification types—including total metabolite abundances, isotopologues, isotopologue proportions, and mean enrichment (fractional contributions)—from a single input source. By handling the tedious aspects of data reshaping and normalization, it ensures that metabolomics datasets are mathematically consistent and ready for statistical comparison.

## CLI Usage and Patterns

### Basic Execution
The tool is typically invoked as a Python module or via its registered command:
```bash
tracegroomer --help
# OR
python -m tracegroomer --help
```

### Core Workflow
1.  **Input Preparation**: Ensure your data has already been corrected for naturally occurring isotopologues (e.g., using IsoCor). TraceGroomer does not perform natural abundance correction itself.
2.  **Formatting**: Provide your input files (e.g., IsoCor outputs). TraceGroomer will automatically detect or require you to specify the input format.
3.  **Normalization**: Choose your normalization strategy. The tool supports:
    *   Normalization by amount of material.
    *   Normalization by internal standard.
    *   Combined modalities.
4.  **Output Generation**: The tool produces independent files for each quantification type. Use the `-ox` flag to specify the output file extension (`csv`, `tsv`, or `txt`).

### Key Functional Capabilities
*   **Automatic Derivation**: If you only provide absolute isotopologue values, TraceGroomer automatically calculates proportions and mean enrichment.
*   **Robustness**: The tool can execute even if only metabolite abundance data is provided, though its primary strength is handling isotope-labeled data.
*   **Speed**: Designed to process supported input formats in seconds.

## Best Practices and Expert Tips
*   **Data Integrity**: Always verify that your input data is "corrected" (natural abundance correction) before grooming. Using uncorrected data will lead to inaccurate fractional contribution calculations in DIMet.
*   **Output Customization**: Use the `-ox` argument to match the requirements of your next pipeline step. While DIMet typically uses `.csv`, some local workflows may prefer `.tsv`.
*   **Normalization Choice**: If your samples vary significantly in biomass, prioritize normalization by material amount to avoid artifacts in total abundance comparisons.
*   **Check Versioning**: Ensure you are using TraceGroomer 0.1.4 or later for improved robustness when handling datasets that may only contain metabolite abundances without full isotopologue breakdowns.

## Reference documentation
- [TraceGroomer GitHub Repository](./references/github_com_cbib_TraceGroomer.md)
- [TraceGroomer Wiki Overview](./references/github_com_cbib_TraceGroomer_wiki.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_tracegroomer_overview.md)