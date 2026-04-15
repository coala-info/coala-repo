---
name: theiacov-gc
description: This tool performs genomic characterization and epidemiological analysis for viral pathogens, primarily SARS-CoV-2. Use when user asks to perform command-line based genomic characterization, epidemiological analysis, or prepare submission data for viral pathogens.
homepage: https://github.com/theiagen/public_health_viral_genomics
metadata:
  docker_image: "quay.io/biocontainers/theiacov-gc:2.3.2--hdfd78af_0"
---

# theiacov-gc

yaml
name: theiacov-gc
description: |
  TheiaCov genomic characterization workflow for SARS-CoV-2. Use when you need to perform command-line based genomic characterization, epidemiological analysis, or prepare submission data for viral pathogens, particularly SARS-CoV-2. This skill is suitable for users who have genomic sequencing data and require automated analysis for variant calling, phylogenetic analysis, and generating reports.
```
## Overview
The `theiacov-gc` tool is a command-line interface for the TheiaCov workflow, designed for the genomic characterization of viral pathogens, with a primary focus on SARS-CoV-2. It automates complex bioinformatics pipelines for tasks such as variant calling, epidemiological analysis, and preparing data for submission to public databases. This skill is intended for users who need to process raw genomic sequencing data and obtain detailed insights into viral strains.

## Usage Instructions

The `theiacov-gc` tool is typically installed via Conda. Once installed, it can be invoked from the command line. The primary function is to process input genomic data and generate various analytical outputs.

### Basic Command Structure

The general structure for running `theiacov-gc` involves specifying input files and desired analysis modules. While specific command-line arguments can vary based on the exact version and desired output, a common pattern involves providing input FASTA or FASTQ files and selecting specific analysis steps.

### Key Considerations and Expert Tips

*   **Input Data**: Ensure your input genomic data is in a compatible format (e.g., FASTA, FASTQ). The tool is designed to handle sequencing data from various platforms.
*   **Configuration**: For advanced usage or specific experimental designs, consult the project's documentation for configuration options. This might include specifying reference genomes, primer sets, or custom analysis parameters.
*   **Output Interpretation**: The tool generates a suite of outputs, including variant calls, phylogenetic trees, and reports. Familiarize yourself with the expected output formats to effectively interpret the results.
*   **Version Management**: As with any bioinformatics tool, it's crucial to be aware of the version of `theiacov-gc` you are using, as updates can introduce new features or change default behaviors. The Anaconda.org page for `theiacov-gc` provides version history and download statistics.
*   **Troubleshooting**: If you encounter issues, refer to the GitHub repository for the `public_health_viral_genomics` project. The issues and pull requests sections can provide insights into common problems and their solutions.

## Reference documentation
- [Anaconda.org - theiacov-gc Overview](./references/anaconda_org_channels_bioconda_packages_theiacov-gc_overview.md)
- [Theiagen Public Health Viral Genomics GitHub Repository](./references/github_com_theiagen_public_health_viral_genomics.md)