---
name: finestructure
description: This tool identifies high-resolution population structure and genetic clustering using haplotype data. Use when user asks to detect subtle ancestry differences, generate a co-ancestry matrix, or perform MCMC-based genetic clustering.
homepage: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html
metadata:
  docker_image: "quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0"
---

# finestructure

## Overview
This skill enables the identification of population structure through high-resolution genetic clustering. It utilizes the fineSTRUCTURE algorithm to process haplotype data (typically phased) to detect subtle differences in population history and ancestry. It is most effective for large-scale genomic datasets where traditional methods like PCA or ADMIXTURE may lack the resolution to distinguish closely related groups.

## Installation and Setup
The tool is available via Bioconda and includes an installation script for environment configuration.

```bash
# Installation via Conda
conda install bioconda::finestructure

# Manual installation script (if using the binary download)
./fs_install.sh
```

## Core Workflow
The fineSTRUCTURE pipeline typically follows a four-step process:

1.  **Painting**: Use the internal ChromoPainter to calculate the co-ancestry matrix.
2.  **Clustering**: Run the MCMC algorithm to identify population clusters.
3.  **Tree Building**: Perform tree exploration to determine the relationship between clusters.
4.  **Visualisation**: Use the R tools for processing the output files.

### Common CLI Patterns
The `fs` command is the primary entry point for the version 4+ suite.

**1. Generating the Co-ancestry Matrix**
```bash
fs cp -g <input.genotypes> -r <input.recombination_map> -t <idfile.ids> -o <output_prefix>
```

**2. Running the MCMC Clustering**
```bash
# Run MCMC with 100,000 iterations (burn-in) and 100,000 samples
fs fs <output_prefix>.chunkcounts.out -m -burnin 100000 -sample 100000 -o <analysis_results>.xml
```

**3. Building the Tree**
```bash
# Build the tree based on the MCMC results
fs fs <analysis_results>.xml <output_prefix>.chunkcounts.out -t -o <tree_results>.xml
```

## Expert Tips
- **Phasing**: fineSTRUCTURE requires phased data for maximum power. Ensure your VCFs are phased (e.g., using Beagle or SHAPEIT) before converting to the fineSTRUCTURE format.
- **Perl Dependencies**: If using the auxiliary scripts and encountering `Can't locate Switch.pm`, install the module via CPAN: `sudo cpan -f Switch`.
- **Large Datasets**: For very large datasets, consider using the "linked model" which accounts for linkage disequilibrium, though it is computationally more intensive than the "unlinked model".
- **Licensing**: Note that fs4/ChromoPainter is free for academic use only. Commercial applications require specific licensing.

## Reference documentation
- [fineSTRUCTURE Software Overview](./references/people_maths_bris_ac_uk__madjl_finestructure_finestructure.html.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_finestructure_overview.md)