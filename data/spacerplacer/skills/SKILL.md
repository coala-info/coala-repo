---
name: spacerplacer
description: SpacerPlacer is a specialized bioinformatics tool designed to model the evolutionary history of CRISPR spacer arrays.
homepage: https://github.com/fbaumdicker/SpacerPlacer
---

# spacerplacer

## Overview
SpacerPlacer is a specialized bioinformatics tool designed to model the evolutionary history of CRISPR spacer arrays. Unlike general sequence alignment tools, it respects the inherent chronological order of spacers—where new spacers are typically added at the leader end—to improve the accuracy of ancestral reconstructions. It provides quantitative estimates for spacer deletion rates and identifies complex genomic events such as block deletions and rearrangements. The tool is particularly effective for determining the transcription orientation of CRISPR arrays by comparing the likelihood of different insertion models.

## Installation and Environment
The tool is primarily supported on Linux. Due to a dependency on the `ete3` library, it requires a Python version earlier than 3.13.

**Bioconda (Recommended):**
```bash
conda install -c bioconda spacerplacer
```

**GitHub Source:**
If running from source, ensure `mafft` is installed in your environment.
```bash
git clone https://github.com/fbaumdicker/SpacerPlacer.git
cd SpacerPlacer
conda env create -f environment/environment.yml
```

## Command Line Usage

### Basic Execution
The tool requires a positional input directory and an output directory.
```bash
spacerplacer <input_path> <output_path> [options]
```

### Predicting Array Orientation
To determine the leader end and transcription direction, use the orientation prediction flag. This runs reconstructions in both forward and reverse orientations to find the most likely model.
```bash
spacerplacer <input_path> <output_path> --determine_orientation --orientation_threshold 2.0
```

### Using Configuration Files
For complex workflows or repetitive analyses, you can pass all options via a configuration file using the `@` prefix.
```bash
spacerplacer @path/to/config_file
```

### Tree Reconstruction
If a phylogenetic tree is not provided in the input data, SpacerPlacer can attempt to reconstruct one based on the spacer content itself.

## Input Requirements
The input directory must contain the CRISPR spacer data. Recent updates have renamed the input option `ccf` to `ccdb`. The tool supports:
- Spacer fasta files with clustering information.
- Pre-defined phylogenetic trees for guided reconstruction.
- Input data formatted for the CRISPRCasFinder (CCF) pipeline.

## Key Outputs
Results are organized in the specified output directory:
- **0_results.csv**: The primary summary file containing parameter estimates, likelihoods, and reconstruction details.
- **0_forward / 0_reverse**: Directories containing orientation-specific reconstruction data if orientation prediction was enabled.

## Best Practices
- **Orientation Check**: Always use `--determine_orientation` if the leader end of the CRISPR array is not experimentally confirmed, as incorrect orientation significantly biases deletion rate estimates.
- **Dependency Management**: Use the Bioconda installation to ensure `mafft` and other binary dependencies are correctly linked.
- **Version Control**: If using the GitHub version, be aware that the `main` branch may contain features not yet present in the Bioconda release.

## Reference documentation
- [SpacerPlacer GitHub Repository](./references/github_com_fbaumdicker_SpacerPlacer.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_spacerplacer_overview.md)