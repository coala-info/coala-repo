---
name: comparem2
description: "CompareM2 is a microbial genomes-to-report pipeline for comprehensive characterization of microbial genomes. Use when user asks to analyze microbial genome assemblies to generate reports with interpretable information and publication-ready graphics."
homepage: https://github.com/cmkobel/comparem2
---


# comparem2

comparem2/SKILL.md
---
name: comparem2
description: |
  A microbial genomes-to-report pipeline for comprehensive characterization of microbial genomes.
  Use when Claude needs to analyze microbial genome assemblies (isolates and metagenomes/MAGs)
  to generate reports with interpretable information and publication-ready graphics.
  This includes tasks like quality control, phylogenetics, pan/core genome analysis,
  antimicrobial resistance and virulence profiling, species detection, pathway annotation,
  and metabolic modeling.
---
## Overview

CompareM2 is a powerful pipeline designed for the in-depth analysis and reporting of microbial genomes. It automates a wide range of bioinformatics tasks, from initial quality control to complex analyses like phylogenetics and metabolic modeling. The pipeline is particularly useful for researchers working with both isolate genomes and metagenome-assembled genomes (MAGs), and it excels at generating comprehensive, publication-ready reports with integrated visualizations.

## Usage Instructions

CompareM2 is typically run as a Snakemake workflow. While direct CLI usage of individual tools within the pipeline is possible, the primary interaction is through the Snakemake interface to manage the workflow.

### Installation

Install CompareM2 using Conda:

```bash
conda install bioconda::comparem2
```

### Running the Pipeline

The core of CompareM2 is its Snakemake workflow. You will need to provide your input genomes and configure the workflow.

1.  **Prepare Input Genomes**: Ensure your microbial genome assemblies are in a suitable format (e.g., FASTA files). Organize them in a directory.
2.  **Configuration**: The workflow can be configured via a `config.yaml` file. This file allows you to specify input directories, output directories, and parameters for various underlying tools. Refer to the official documentation for detailed configuration options.
3.  **Execute Snakemake**: Once installed and configured, you can run the pipeline using Snakemake.

    *   **Local Execution**:
        ```bash
        snakemake --cores <number_of_cores> --use-conda
        ```
        (Ensure you have Snakemake installed and configured to use Conda environments.)

    *   **HPC Cluster Execution**: CompareM2 supports execution on HPC clusters using job schedulers like SLURM or PBS. You will need to adapt the Snakemake command to submit jobs to your cluster. Consult the CompareM2 documentation for specific cluster configuration examples.

### Key Features and Analyses

CompareM2 integrates a suite of tools for:

*   **Quality Control**: Assessing the quality of genome assemblies.
*   **Phylogenetics**: Determining evolutionary relationships.
*   **Pan/Core Genome Analysis**: Identifying shared and unique genes across a set of genomes.
*   **Antimicrobial Resistance (AMR) and Virulence Profiling**: Detecting genes associated with AMR and virulence.
*   **Species Detection**: Identifying the species represented by the genomes.
*   **Pathway Annotation**: Assigning functional roles to genes.
*   **Metabolic Modeling**: Inferring metabolic capabilities.

### Output

The primary output is a dynamic, compact `.html` report that can be viewed in any web browser. This report integrates central results, interpretable information, and publication-ready graphics. The report is generated even if some jobs in the pipeline fail.

### Expert Tips

*   **Resource Requirements**: Running CompareM2, especially on large datasets or complex analyses, can be resource-intensive. A local workstation with >= 64GiB RAM is recommended for significant local runs. For HPC, ensure adequate resources are allocated.
*   **Configuration is Key**: Familiarize yourself with the `config.yaml` file. It's your primary tool for tailoring the pipeline to your specific needs and optimizing performance.
*   **Documentation**: The comprehensive documentation at `CompareM2.readthedocs.io` is invaluable for understanding specific parameters, troubleshooting, and advanced usage.
*   **Containerization**: Apptainer/Singularity/Docker images and conda environment definitions are available, which are highly recommended for ensuring reproducibility and managing dependencies, especially in HPC environments.

## Reference documentation

- [CompareM2 GitHub Repository](./references/github_com_cmkobel_CompareM2.md)
- [CompareM2 Overview on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_comparem2_overview.md)
- [CompareM2 Documentation (readthedocs.io)](https://comparem2.readthedocs.io/)
---