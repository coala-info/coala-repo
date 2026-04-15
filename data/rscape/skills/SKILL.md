---
name: rscape
description: R-scape is a statistical tool that evaluates RNA alignments to determine if base pairs show significant covariation above what is expected from phylogenetic history. Use when user asks to verify conserved RNA structures, predict new structures using CaCoFold, or evaluate and improve existing structural models from Stockholm alignments.
homepage: http://eddylab.org/R-scape/
metadata:
  docker_image: "quay.io/biocontainers/rscape:2.0.4.a--h503566f_1"
---

# rscape

## Overview
R-scape (RNA Structural Covariation Above Phylogenetic Expectation) is a statistical tool designed to verify if the base pairs in an RNA alignment show more covariation than would be expected by chance given the phylogeny. It helps researchers determine if a conserved RNA structure actually exists or if observed variations are merely artifacts of evolution. It supports Stockholm format alignments and can handle complex structures, including pseudoknots.

## Core Workflows

### 1. Evaluating a Region for Conserved Structure
Use this mode to determine if any part of an alignment shows evidence of a conserved structure without relying on a pre-existing model.
- **Input**: Stockholm alignment (.stk).
- **Logic**: Analyzes all possible pairs equally in a single test.
- **Best for**: Initial discovery phases where no consensus structure is known.

### 2. Predicting New Structures (CaCoFold)
Use this mode to generate a new consensus structure based on statistically significant covarying pairs.
- **Algorithm**: Employs CaCoFold to build a structure compatible with all significant covariations.
- **Best for**: Generating high-confidence structural models from sequence data.

### 3. Evaluating/Improving a Given Structure
Use these modes when you already have a proposed consensus structure (annotated in the Stockholm file).
- **Evaluation**: Performs two independent tests—one on the proposed pairs and one on all other possible pairs—to see how well the data supports the specific model.
- **Improvement**: Takes the existing structure and refines it by incorporating additional significant covarying pairs found during analysis.

## Technical Requirements & Best Practices
- **Input Format**: Must be a Stockholm alignment file. Only the first alignment in the file is processed; subsequent alignments are ignored.
- **Statistical Thresholds**: The primary output is based on E-values. A lower E-value indicates higher statistical significance for a covarying pair.
- **Null Hypothesis**: R-scape is unique because its null hypothesis accounts for phylogenetic correlations, preventing "false positive" structural signals caused by shared ancestry.
- **Visualization**: The tool typically generates visualizations (via R2R) where significant covarying pairs are highlighted (often in green).

## Common CLI Patterns
While specific flags vary by version, the general execution follows these patterns:
- **Basic Analysis**: `R-scape alignment.stk`
- **Predicting Structure**: `R-scape --fold alignment.stk` (triggers CaCoFold)
- **Setting E-value**: `R-scape -E 0.05 alignment.stk` (sets the threshold for false positives)

## Reference documentation
- [R-scape Overview](./references/eddylab_org_R-scape.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_rscape_overview.md)