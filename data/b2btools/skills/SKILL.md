---
name: b2btools
description: The b2btools suite is a collection of predictors developed by the Bio2Byte group to bridge the gap between protein sequence and biophysical behavior.
homepage: https://bio2byte.be/
---

# b2btools

## Overview
The b2btools suite is a collection of predictors developed by the Bio2Byte group to bridge the gap between protein sequence and biophysical behavior. It is particularly useful for researchers working with Intrinsically Disordered Proteins (IDPs) or those needing fast, sequence-based estimates of protein flexibility and aggregation propensity without requiring experimental NMR or X-ray data.

## Predictor Capabilities
The suite provides several specialized tools that can be invoked via the command line:

- **Dynamine**: Predicts backbone and side-chain dynamics (S2 order parameters) and secondary structure.
- **Disomine**: Predicts protein disorder using recurrent neural networks based on biophysical property predictions.
- **EfoldMine**: Identifies residues likely to be involved in early folding events.
- **AgMata**: Detects regions prone to beta-aggregation.
- **PSPer**: Predicts phase-separation likelihood, specifically for RNA-interacting (FUS-like) proteins.
- **ShiftCrypt**: Encodes NMR chemical shifts into a residue-level biophysical index.

## Command Line Usage
The tool is typically installed via conda and provides a unified interface for processing protein sequences.

### Basic Execution
To run the suite on a FASTA file containing protein sequences:
```bash
# Run all default predictors on a sequence file
b2btools predict --fasta input_sequences.fasta --output_dir ./results
```

### Specific Predictor Selection
If you only require specific biophysical properties, you can limit the execution to save time:
```bash
# Example: Only run Dynamine and Disomine
b2btools predict --fasta sequences.fasta --predictors dynamine disomine
```

### Output Interpretation
- **Dynamine S2 values**: Values > 0.8 generally indicate rigid regions; values < 0.6 indicate flexible/disordered regions.
- **Disomine probability**: Higher values indicate a higher likelihood of intrinsic disorder.
- **AgMata scores**: Peaks in the profile indicate specific "hot spots" for beta-aggregation.

## Expert Tips
- **Batch Processing**: For large-scale proteome analysis, use the `--fasta` input with multiple entries rather than calling the tool individually for each sequence to reduce overhead.
- **Environment Setup**: Ensure the `bioconda` channel is properly configured in your conda environment to resolve dependencies for the neural network components.
- **Sequence Length**: While the tools are fast, extremely long sequences (e.g., > 5000 residues) may require significant memory for the recurrent neural network models used in Disomine.

## Reference documentation
- [b2btools Overview](./references/anaconda_org_channels_bioconda_packages_b2btools_overview.md)