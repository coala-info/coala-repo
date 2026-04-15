---
name: mrbayes_volpiano
description: This tool performs Bayesian inference of phylogenetic trees for Gregorian chants using Volpiano melody strings. Use when user asks to estimate melodic evolution, study chant transmission, or perform phylogenetic analysis on musical notation in NEXUS format.
homepage: https://github.com/gaballench/mrbayes_volpiano
metadata:
  docker_image: "quay.io/biocontainers/mrbayes:3.2.7--hd0d793b_7"
---

# mrbayes_volpiano

## Overview
The `mrbayes_volpiano` skill provides guidance for using a specialized version of MrBayes (v3.2.7a) tailored for musicological research. While standard MrBayes is used for biological sequences, this "Volpiano edition" allows for the estimation of phylogenetic trees of Gregorian chants. It treats Volpiano melody strings as character data, enabling the study of melodic evolution and transmission through Bayesian inference.

## Installation and Execution
Install the tool via bioconda:
```bash
conda install bioconda::mrbayes_volpiano
```

To run the program, use the standard MrBayes command:
```bash
mb
```

## Common CLI Patterns
- **Interactive Mode**: Simply type `mb` to enter the command-line interface.
- **Batch Mode**: Execute a NEXUS file containing a MrBayes block directly from the terminal:
  ```bash
  mb input_file.nexus
  ```

## Data Preparation and Best Practices
- **Data Format**: Input data must be in NEXUS format.
- **Character Coding**: In this fork, the `standard` character type is repurposed for Volpiano. In your NEXUS file, ensure your data block specifies `datatype=standard`.
- **Volpiano Symbols**: Define the specific Volpiano characters used in your dataset within the `symbols` attribute of the `format` command to ensure the model correctly interprets the musical notation.
- **Model Selection**: Since plainchant evolution differs from biological evolution, start with simpler symmetric models before moving to complex substitution matrices unless specific transition probabilities for musical intervals are known.

## Expert Tips
- **Greeting Text**: Upon startup, the program displays a specific note confirming it is the Volpiano edition. Always verify this text to ensure you are not using the standard biological version of MrBayes, which may not handle Volpiano character sets correctly.
- **Citations**: When publishing results, cite both the original MrBayes paper (Ronquist et al., 2012) and the Volpiano application paper (Hajič jr. et al., 2023).
- **Output Analysis**: Use the standard `sump` (summarize parameters) and `sumt` (summarize trees) commands to analyze the posterior distribution of your chant phylogenies.

## Reference documentation
- [mrbayes_volpiano - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mrbayes_volpiano_overview.md)
- [gaballench/mrbayes_volpiano: Bayesian Inference of Phylogeny (Volpiano edition)](./references/github_com_gaballench_mrbayes_volpiano.md)