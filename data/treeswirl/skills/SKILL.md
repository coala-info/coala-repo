---
name: treeswirl
description: TreeSwirl models how different populations contribute to the genetic makeup of a target group at specific genomic loci. Use when user asks to model population contributions, detect gene flow, characterize hybrid genomes, estimate mixture proportions, or smooth local ancestry estimates.
homepage: https://bitbucket.org/wegmannlab/treeswirl
metadata:
  docker_image: "quay.io/biocontainers/treeswirl:2.0.0--h778a338_0"
---

# treeswirl

## Overview
TreeSwirl is a specialized population genetics tool designed to model how different populations contribute to the genetic makeup of a target group at specific genomic loci. Unlike global admixture tools, it leverages linked allele frequencies to provide a high-resolution view of population mixtures across the genome. It is particularly effective for detecting subtle gene flow and characterizing the mosaic nature of hybrid genomes.

## Core Workflow and CLI Patterns

### Input Preparation
TreeSwirl typically requires allele frequency data from multiple reference (source) populations and the target (mixed) population.
- Ensure input files are formatted as tab-delimited frequency tables or specific formats required by the Wegmann Lab suite.
- Data should be indexed by genomic coordinates (Chromosome and Position) to allow for locus-specific inference.

### Running the Inference
The primary execution involves estimating mixture proportions ($\alpha$) for each locus.
- **Basic Estimation**: Run the core inference engine by specifying the target population and the set of potential source populations.
- **Window-based Analysis**: Use sliding windows to smooth local ancestry estimates and reduce noise from individual SNPs.
- **Likelihood Optimization**: The tool uses maximum likelihood frameworks; ensure you provide sufficient iterations for convergence in complex multi-source models.

### Common Parameters
- `--target`: Path to the allele frequency file for the population being analyzed.
- `--sources`: A list or directory of frequency files for the ancestral/reference populations.
- `--window-size`: The genomic distance (in bp or SNPs) used for local inference.
- `--output`: Prefix for the resulting mixture proportion and likelihood files.

## Best Practices
- **Reference Selection**: Choose reference populations that are as close to the true ancestral sources as possible to avoid biased mixture estimates.
- **Linkage Considerations**: While TreeSwirl handles linked frequencies, extremely high linkage disequilibrium (LD) can inflate confidence; consider thinning SNPs if the computational burden is high.
- **Validation**: Compare results with global admixture estimates (e.g., ADMIXTURE or STRUCTURE) to ensure the average of local estimates aligns with the global genomic proportion.

## Reference documentation
- [TreeSwirl Overview](./references/anaconda_org_channels_bioconda_packages_treeswirl_overview.md)
- [TreeSwirl Bitbucket Repository and Wiki](./references/bitbucket_org_wegmannlab_treeswirl.md)