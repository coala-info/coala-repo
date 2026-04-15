---
name: rnaalishapes
description: RNAalishapes predicts secondary structures and structural shape abstractions for a set of aligned RNA sequences. Use when user asks to predict consensus structures, identify structural folds through shape abstraction, calculate shape probabilities, or perform suboptimal folding on RNA alignments.
homepage: https://bibiserv.cebitec.uni-bielefeld.de/rnaalishapes
metadata:
  docker_image: "quay.io/biocontainers/rnaalishapes:2.5.0--pl5321h9948957_2"
---

# rnaalishapes

## Overview
RNAalishapes is a specialized bioinformatics tool that predicts secondary structures for a set of aligned RNA sequences. Unlike tools that only provide a single "best" structure, RNAalishapes uses "shape abstraction" to group similar structures into classes, making it easier to identify the primary structural folds within a thermodynamic ensemble. It supports various modes including minimum free energy (MFE), suboptimal folding, and partition function-based probabilities.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::rnaalishapes
```

## Core Prediction Modes
Select the mode based on the required depth of analysis:
- `mfe`: Calculates the single most stable structure. (Note: If only MFE is needed, `RNAalifold` from the Vienna package is a faster alternative).
- `shapes`: Groups suboptimal structures into shape classes and reports the best representative for each.
- `probs`: Calculates probabilities for shape classes.
- `subopt`: Lists all suboptimal structures within a specific energy range.
- `sample`: Uses stochastic sampling to estimate shape frequencies.
- `mea`: Finds the structure with the Maximum Expected Accuracy.
- `eval`: Evaluates the free energy of a specific sequence/structure pair.

## Common CLI Patterns

### Basic MFE Prediction
Predict the consensus structure for an alignment file:
```bash
RNAalishapes --mode mfe < input.aln
```

### Shape Abstraction and Probabilities
To see the most probable structural shapes (level 5 abstraction) within a window:
```bash
RNAalishapes --mode probs --shape 5 --structureProbs 1 < input.aln
```

### Suboptimal Folding with Energy Constraints
Find structures within a 10% energy deviation of the MFE:
```bash
RNAalishapes --mode subopt --relative 10.0 < input.aln
```

### Sliding Window Analysis
For long alignments, use windowing to find local structures:
```bash
RNAalishapes --windowSi 50 --windowInc 10 < input.aln
```

## Expert Tips
- **Shape Levels**: The `--shape` parameter (1-5) controls abstraction. Level 1 is the most detailed (most shapes), while Level 5 is the most abstract (fewer, more distinct shapes).
- **Semantic Ambiguity**: In `subopt` mode, you may see identical dot-bracket strings with slightly different energies; this is due to the underlying "microstate" grammar accounting for different base dangling configurations.
- **Input Format**: The tool expects a multiple sequence alignment (MSA). Ensure your `.aln` or Clustal format files are properly aligned before processing.
- **Pseudoknots**: RNAalishapes does not predict pseudoknots. If the RNA species is known to have them, the results will only represent the nested secondary structure components.

## Reference documentation
- [RNAalishapes Manual and Modes](./references/bibiserv_cebitec_uni-bielefeld_de_rnaalishapes_3.md)
- [RNAalishapes Overview and Bioconda Info](./references/anaconda_org_channels_bioconda_packages_rnaalishapes_overview.md)