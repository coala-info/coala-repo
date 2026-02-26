---
name: lepwrap
description: LepWrap is a Snakemake-based pipeline that streamlines linkage mapping and genomic scaffold anchoring using Lep-Map3 and LepAnchor. Use when user asks to build linkage maps, anchor scaffolds into chromosomes, or orient genomic data.
homepage: https://github.com/pdimens/LepWrap/
---


# lepwrap

## Overview
LepWrap is a bioinformatic pipeline that streamlines the complex multi-step processes of Lep-Map3 and LepAnchor. It is designed for researchers working with genomic data to build robust linkage maps and subsequently use those maps to anchor and orient genomic scaffolds into chromosomes. It functions as a Snakemake-based wrapper, managing the flow of data between linkage mapping and assembly anchoring modules.

## Native Command Line Usage
The primary interface for the tool is the `LepWrap` executable.

### Installation
Install the tool via Bioconda to ensure all dependencies (Lep-Map3, LepAnchor, Snakemake, and R) are correctly configured:
`conda install -c bioconda lepwrap`

### Basic Execution
To run the pipeline using the default configuration file (`config.yml`) in the current directory:
`LepWrap <number_of_cores>`

### Custom Execution
To specify a specific configuration file (e.g., for different parameters or datasets):
`LepWrap <number_of_cores> <custom_config_file.yml>`

### Initialization
If no configuration file exists in the working directory, running the `LepWrap` command will automatically generate a default template. You must populate this template with your specific file paths and parameters before the pipeline can execute successfully.

## Best Practices and Expert Tips
- **Environment Management**: Always execute within a dedicated Conda environment. This prevents version conflicts between the Java-based Lep-Map3 components and the R-based annotation scripts.
- **Resource Allocation**: The `<number_of_cores>` argument should match your available hardware threads. LepWrap passes this directly to Snakemake to parallelize linkage mapping modules, which is particularly beneficial during the computationally intensive LOD score calculations.
- **Workflow Flexibility**: The pipeline is designed to be modular. If you only require linkage mapping, you can configure the tool to stop after the Lep-Map3 modules.
- **Script Customization**: The underlying logic is contained in human-readable Bash and R scripts. If your study requires non-standard parameters (e.g., specific LOD thresholds or unique family structures), you can fork the repository and adapt the scripts in the `scripts/` and `rules/` directories.
- **Citation Requirements**: When using this tool, ensure you cite both the LepWrap repository and the original Pasi Rastas publications for Lep-Map3 and LepAnchor.

## Reference documentation
- [LepWrap README](./references/github_com_pdimens_LepWrap.md)
- [LepWrap Wiki](./references/github_com_pdimens_LepWrap_wiki.md)