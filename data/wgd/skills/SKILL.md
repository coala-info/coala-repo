---
name: wgd
description: The `wgd` (v2) suite is a specialized bioinformatics toolkit designed to unearth traces of ancient polyploidy from genomic and transcriptomic data.
homepage: https://github.com/heche-psb/wgd
---

# wgd

## Overview
The `wgd` (v2) suite is a specialized bioinformatics toolkit designed to unearth traces of ancient polyploidy from genomic and transcriptomic data. It transforms raw sequence alignments into evolutionary insights by modeling the distribution of synonymous substitutions ($K_S$) and identifying collinear gene blocks (synteny). Use this skill to navigate the multi-step process of identifying WGD-derived gene duplicates, distinguishing them from small-scale duplications, and placing these events within a calibrated phylogenetic timeframe.

## Core CLI Modules
The `wgd` toolset is organized into functional sub-commands. Most workflows follow a sequence from raw data processing to statistical modeling and visualization.

### 1. Sequence Alignment (`wgd dmd`)
Performs the initial all-against-all protein alignment required for duplication analysis.
- **Usage**: Typically the first step in the pipeline.
- **Best Practice**: Use this to generate the similarity files needed for $K_S$ calculation.

### 2. $K_S$ Distribution (`wgd ksd`)
Calculates the synonymous substitution rates for gene pairs.
- **Paralogous $K_S$**: Used to identify WGD events within a single species.
- **Orthologous $K_S$**: Used to compare divergence between species and place WGD events relative to speciation.
- **Tip**: For transcriptome assemblies, note that $K_S$ distributions may reflect continuous small-scale duplications; genome assemblies are preferred for clear WGD signal delineation.

### 3. Synteny Analysis (`wgd syn`)
Identifies anchor points and collinear blocks to provide structural evidence for WGD.
- **Requirement**: Requires a genome assembly (not applicable to fragmented transcriptomes).
- **Utility**: Helps distinguish WGD-retained duplicates from tandem or transposed duplications.

### 4. Peak Identification (`wgd peak`)
Uses mixture modeling to identify significant "age peaks" in the $K_S$ distribution.
- **Logic**: A burst of gene duplication (WGD) leaves a distinct peak against the background of quasi-exponential decay of small-scale duplications.
- **Handling IDs**: If your dataset uses pure numerical gene IDs, ensure you are using `wgd` v2.0.38 or later to avoid parsing errors.

### 5. Visualization (`wgd viz`)
Generates plots for $K_S$ distributions and synteny dot plots.
- **Common Task**: Visualizing the $K_S$ age distribution to manually inspect the fit of the mixture model.

## Standard Workflow for WGD Inference
1. **Initial Search**: Run `wgd dmd` followed by `wgd ksd` to generate the raw $K_S$ distribution.
2. **Synteny Validation**: If a genome assembly is available, run `wgd syn` to find anchor pairs.
3. **Peak Analysis**: Run `wgd peak` on the $K_S$ data to statistically confirm the presence of a WGD event.
4. **Phylogenetic Dating**: 
   - Formulate a starting tree with fossil calibrations.
   - Construct orthogroups using collinear duplicates and reciprocal best hits (RBHs).
   - Perform absolute dating to estimate the geological timing of the event.

## Expert Tips
- **Rate Correction**: When comparing $K_S$ peaks across different lineages, always perform rate correction using orthologous distributions, as evolutionary rates can vary significantly between species.
- **Data Quality**: For absolute dating, the quality of the starting tree and the accuracy of fossil calibration bounds are the most critical factors for reliable results.
- **Version Check**: If encountering issues with `wgd viz` or multi-species errors, verify the installation via Bioconda to ensure the environment is using the latest stable release (v2.0.38+).

## Reference documentation
- [GitHub Repository Overview](./references/github_com_heche-psb_wgd.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_wgd_overview.md)