---
name: assemblycomparator2
description: The `assemblycomparator2` tool (also known as CompareM2) is a scalable genomes-to-report pipeline designed for microbial genomics.
homepage: https://github.com/cmkobel/assemblycomparator2
---

# assemblycomparator2

## Overview
The `assemblycomparator2` tool (also known as CompareM2) is a scalable genomes-to-report pipeline designed for microbial genomics. It automates the process of characterizing prokaryotic genomes by integrating multiple state-of-the-art bioinformatic tools into a single Snakemake-based workflow. Use this skill when you need to move from raw genomic assemblies to a publication-ready HTML report that includes quality metrics, species detection, and functional annotations.

## Core Usage Patterns

### Basic Execution
The tool is typically invoked via the command line to process a directory of genome assemblies.
```bash
comparem2 --input_dir ./assemblies --output_dir ./results
```

### Key Capabilities
- **Quality Control**: Automated assessment of assembly completeness and contamination.
- **Comparative Genomics**: Calculation of Average Amino Acid Identity (AAI) and pan/core genome analysis.
- **Functional Profiling**: Detection of anti-microbial resistance (AMR) genes, virulence factors, and metabolic pathways.
- **Species Identification**: Taxonomic classification of input assemblies.

### Resource Management
Because the pipeline integrates heavy-duty tools, it is recommended to run it on systems with at least 64GiB of RAM. When running on an HPC cluster, use the Snakemake-backed execution flags to manage job submission via SLURM or PBS.

## Expert Tips
- **Dynamic Reports**: The pipeline generates a portable `.html` report even if some individual jobs fail. Always check the `dynamic_report` directory in your output for the final summary.
- **Input Formats**: Ensure your assemblies are in FASTA format. The tool is designed to handle both isolate genomes and MAGs.
- **Workflow Customization**: Since the tool is built on Snakemake, you can modify parameters for underlying tools by adjusting the configuration files within the installation directory.

## Reference documentation
- [CompareM2 GitHub Repository](./references/github_com_cmkobel_CompareM2.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_assemblycomparator2_overview.md)