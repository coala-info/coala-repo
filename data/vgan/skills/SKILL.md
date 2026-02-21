---
name: vgan
description: vgan is a specialized suite of pangenomic tools built upon the `vg` (Variation Graph) framework.
homepage: https://github.com/grenaud/vgan
---

# vgan

## Overview

vgan is a specialized suite of pangenomic tools built upon the `vg` (Variation Graph) framework. It is designed to handle complex genomic tasks that benefit from graph-based references, which are more robust than traditional linear references for ancient or degraded DNA. The toolkit is primarily utilized in paleogenomics and environmental DNA (eDNA) research to provide high-resolution taxonomic identification and abundance estimation.

## Installation and Environment Setup

vgan is supported on Linux systems. The most efficient way to manage dependencies is via Bioconda:

```bash
conda install bioconda::vgan
```

### Manual Setup and Directory Structure

If using the static binary, vgan requires a specific directory structure in your home directory to locate its resource files (HaploCart files, euka data, and damage profiles). Run the following commands to initialize the environment:

```bash
# Create binary directory
mkdir -p $HOME/bin
cp vgan $HOME/bin/
chmod +x $HOME/bin/vgan

# Create mandatory resource structure
mkdir -p $HOME/share/vgan/euka_dir/
mkdir -p $HOME/share/vgan/hcfiles/
mkdir -p $HOME/share/vgan/soibean_dir/
mkdir -p $HOME/share/vgan/damageProfiles/
mkdir -p $HOME/share/vgan/plottingScripts/
```

## Core Subcommands

vgan operates through three primary modules. Each is optimized for a specific pangenomic workflow:

### 1. Haplocart
Used for modern human mitochondrial DNA (mtDNA) haplogroup classification. It leverages variation graphs to improve the accuracy of haplogroup assignment, especially in cases with missing data or low coverage.

### 2. euka
Designed for bilaterian abundance estimation in ancient environmental DNA (aeDNA). Use this module when you need to detect and quantify animal taxa from complex environmental samples.

### 3. soibean
Used for species identification and multiple source estimation. It is specifically tailored for filtered bilaterian data from ancient environmental samples, helping to distinguish between multiple contributing sources in a single sample.

## Best Practices and Expert Tips

- **Graph-Based Mapping**: Since vgan is built on `vg`, ensure your input data is compatible with variation graph workflows. The tool is particularly effective at reducing reference bias in ancient DNA studies.
- **Resource Management**: The `$HOME/share/vgan/` directories must be populated with the necessary reference graphs and damage profiles specific to your study. vgan expects these files to be in these exact locations to function correctly.
- **Ancient DNA Damage**: When using `euka` or `soibean`, ensure you have appropriate damage profiles in the `damageProfiles/` directory. Ancient DNA often exhibits specific deamination patterns (C-to-T transitions) that these tools use to authenticate the "ancient" nature of the DNA.
- **Binary Pathing**: If you installed vgan manually, ensure `$HOME/bin` is in your `PATH` to call the tool from any working directory.

## Reference documentation
- [vgan GitHub Repository](./references/github_com_grenaud_vgan.md)
- [vgan Wiki Home](./references/github_com_grenaud_vgan_wiki.md)
- [Bioconda vgan Overview](./references/anaconda_org_channels_bioconda_packages_vgan_overview.md)