---
name: intarna
description: IntaRNA predicts the interaction between two RNA molecules by calculating the energy balance between intermolecular base pairing and the cost of site accessibility. Use when user asks to predict sRNA-target interactions, calculate RNA hybridization energy with accessibility constraints, or identify seed-based binding sites between RNA sequences.
homepage: https://github.com/BackofenLab/IntaRNA
---


# intarna

## Overview

IntaRNA is a specialized bioinformatics tool designed to predict the interaction between two RNA molecules, such as a small regulatory RNA (sRNA) and its target mRNA. It distinguishes itself from basic hybridization tools by calculating the energy balance between the gain of intermolecular base pairing and the energy "cost" required to make the interaction sites accessible (unpaired). This approach, combined with user-definable seed requirements, provides high accuracy for identifying functional regulatory sites in bacterial genomes.

## CLI Usage and Personalities

IntaRNA provides several "personalities"—specialized binaries or execution modes optimized for specific tasks.

### Common Binaries
- `IntaRNA`: The standard, fast heuristic prediction tool.
- `IntaRNAsTar`: Optimized specifically for sRNA-target prediction.
- `IntaRNAexact`: Performs exact predictions similar to `RNAup`.
- `IntaRNAhelix`: Composes interactions from stable intermolecular helices.
- `IntaRNAduplex`: Focuses on hybrid-only optimization, similar to `RNAduplex`.
- `IntaRNAseed`: Identifies and reports only the seed interactions.
- `IntaRNAens`: Computes partition functions and ensemble-based predictions.

### Basic Command Pattern
```bash
# Basic interaction prediction between a query and a target
IntaRNA --query <query_sequence.fa> --target <target_sequence.fa>

# Direct sequence input via command line
IntaRNA -q "GGCUUAU..." -t "AAUUCGG..."
```

## Expert Tips and Best Practices

### 1. Managing Accessibility
Accessibility is the probability that a region remains unpaired and available for interaction.
- **SHAPE Data**: Use `--shapeQuery` and `--shapeTarget` to incorporate experimental probing data, which significantly improves prediction accuracy by grounding accessibility in real-world measurements.
- **Window-based Prediction**: For long target sequences (e.g., whole mRNAs), use window-based accessibility computation to limit memory consumption.

### 2. Seed Constraints
Seeds are short, highly complementary regions that initiate the interaction.
- **Define Seed**: Use `--seedBP` to set the number of base pairs required in the seed (default is often 7).
- **Explicit Seeds**: If you have experimental evidence of a specific binding site, provide it via `--seedQueryPos` and `--seedTargetPos` to force the prediction to center on that region.

### 3. Output Optimization
- **CSV Output**: For large-scale genomic screens, use `--outMode C` to generate comma-separated values, which are easier to parse with Python or R scripts.
- **Suboptimal Interactions**: Use `--outNumber <N>` to report more than just the Minimum Free Energy (MFE) interaction. This is useful for RNAs that might have multiple binding modes.
- **Visualization**: Use the auxiliary R or Python scripts provided in the `perl/`, `python/`, and `R/` directories of the source distribution to visualize energy profiles and interaction spots.

### 4. Performance Tuning
- **Multi-threading**: Use `--threads <N>` to parallelize the computation across multiple CPU cores.
- **Parameter Files**: For complex runs with many constraints, load arguments from a file using `--parameterFile <file.txt>` to keep the command line clean and reproducible.

## Reference documentation
- [GitHub - BackofenLab/IntaRNA](./references/github_com_BackofenLab_IntaRNA.md)
- [intarna - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_intarna_overview.md)