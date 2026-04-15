---
name: ipyrad
description: ipyrad is an interactive toolkit for assembling and analyzing restriction-site associated genomic data through a modular seven-step pipeline. Use when user asks to assemble RAD-seq data, demultiplex raw reads, perform de novo or reference-based clustering, or export genomic datasets for population genetic and phylogenetic studies.
homepage: http://github.com/dereneaton/ipyrad
metadata:
  docker_image: "quay.io/biocontainers/ipyrad:0.9.108--pyhdfd78af_0"
---

# ipyrad

## Overview
ipyrad is an interactive toolkit designed for the assembly and analysis of restriction-site associated genomic data sets. It transforms raw sequencing reads into analyzed datasets (such as SNPs or loci) through a modular 7-step pipeline. It is particularly effective for population genetic and phylogenetic studies, supporting both de novo assembly and reference-based mapping. This skill assists in navigating the CLI-based workflow, from initial parameter configuration to final data export.

## Core CLI Workflow

The ipyrad workflow is centered around a "params" file that stores project settings.

### 1. Project Initialization
Create a new parameters file for your project.
```bash
ipyrad -n [project_name]
```
This generates a file named `params-[project_name].txt`. You must edit this file to specify the path to your raw data, the restriction enzyme used, and other assembly parameters.

### 2. Executing Assembly Steps
ipyrad runs in seven discrete steps. You can run them individually, in groups, or all at once using the `-s` flag.

```bash
# Run step 1 (Demultiplexing)
ipyrad -p params-[project_name].txt -s 1

# Run steps 2 and 3 (Filtering and Clustering/Mapping)
ipyrad -p params-[project_name].txt -s 23

# Run all steps (1 through 7)
ipyrad -p params-[project_name].txt -s 1234567
```

**The 7-Step Pipeline:**
1. **Demultiplexing**: Sorts raw reads by barcode into individual sample files.
2. **Filter Reads**: Removes adapter sequences and low-quality reads.
3. **Clustering/Mapping**: Clusters reads within samples (de novo) or maps to a reference.
4. **Joint Estimation**: Estimates heterozygosity and error rates.
5. **Consensus Calling**: Determines the consensus sequence for each locus.
6. **Clustering Across Samples**: Aligns orthologous loci across the entire dataset.
7. **Filtering and Formats**: Applies final filters (e.g., min samples per locus) and exports data.

### 3. Parallelization
To speed up processing, use the `-c` flag to specify the number of CPU cores.
```bash
ipyrad -p params-[project_name].txt -s 123 -c 12
```

## Advanced CLI Patterns

### Branching Assemblies
To test different filtering parameters (e.g., different levels of missing data in Step 7) without re-running the entire pipeline, use the branching feature.
```bash
ipyrad -p params-[project_name].txt -b [new_branch_name]
```
This creates a new params file inheriting settings from the original, allowing you to modify Step 7 parameters and run `-s 7` independently.

### Downstream Analysis Modules
ipyrad includes specialized modules for analysis that can be invoked via the CLI or within a Python environment.
- **PCA**: Generate Principal Component Analysis plots.
- **VCF Conversion**: Use `vcf2hdf5` to convert VCF outputs for faster processing in downstream tools.
- **BPP**: Prepare and run Bayesian Phylogenetics and Phylogeography analyses.

## Expert Tips
- **Preview Mode**: Before running a full assembly, check your parameter file and data paths using the `-p` flag without steps to ensure everything is configured correctly.
- **HPC Usage**: When running on a cluster, ensure `ipyparallel` is installed and configured to handle distributed computing across nodes.
- **Reference Mapping**: If a reference genome is available, set the `assembly_method` to `reference` in the params file and provide the path to the fasta reference in Step 3.

## Reference documentation
- [ipyrad GitHub Repository](./references/github_com_dereneaton_ipyrad.md)
- [ipyrad Wiki and Userland Docs](./references/github_com_dereneaton_ipyrad_wiki.md)
- [Bioconda ipyrad Package Overview](./references/anaconda_org_channels_bioconda_packages_ipyrad_overview.md)