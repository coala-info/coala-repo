---
name: curare
description: Curare is a modular Python framework that automates RNA-Seq data processing from raw sequencing reads to differential expression results. Use when user asks to process RNA-Seq data, generate pipeline configuration templates, perform differential expression analysis, or create comprehensive HTML reports for sequencing statistics.
homepage: https://github.com/pblumenkamp/Curare
metadata:
  docker_image: "quay.io/biocontainers/curare:0.6.0--pyhdfd78af_0"
---

# curare

## Overview
Curare is a Python-based framework designed to streamline RNA-Seq data processing by wrapping popular bioinformatics tools into a modular workflow. It automates the transition from raw sequencing reads to differential expression results, handling environment management via Conda to ensure reproducibility. The pipeline is structured into four distinct phases—Preprocessing, Premapping, Mapping, and Analysis—and culminates in a comprehensive HTML report that aggregates statistics and visualizations from all utilized modules.

## Core CLI Commands

### Project Initialization
The most efficient way to start a new analysis is using the built-in wizard to generate the necessary configuration templates.
- **Generate templates**: `curare_wizard --samples <path/to/samples.tsv> --pipeline <path/to/pipeline.yml>`
- **Purpose**: This creates a tab-separated sample file and a configuration file with the required headers and placeholders for your specific modules.

### Pipeline Execution
Once the configuration files are populated, execute the pipeline using the main entry point.
- **Standard run**: `curare --samples <samples.tsv> --pipeline <pipeline.yml> --cores <number_of_cores>`
- **Mandatory arguments**: Recent versions require the `--cores` parameter to be explicitly defined for Snakemake resource allocation.
- **Bypass Conda**: If all bioinformatic tools (like Star, Bowtie2, or DESeq2) are already installed in your local environment, use the `--no-conda` flag to skip environment creation.

### Help and Documentation
- **General help**: `curare --help`
- **Module dependencies**: To view the specific Conda dependencies for a module without running the pipeline, check the `lib/conda_env.yaml` file within the specific module category in the Curare installation directory.

## Best Practices and Expert Tips

### Sample Metadata Management
- **Naming Conventions**: Use only alphanumeric characters and underscores (`_`) for sample names. Avoid spaces or special characters to prevent breaks in the file system or downstream scripts.
- **Pathing**: File paths for sequencing data (forward/reverse reads) in the `samples.tsv` can be absolute or relative to the location of the TSV file itself.
- **Wizard First**: Always use the wizard to generate the `samples.tsv`. Different modules (e.g., DESeq2 vs. edgeR) may require different additional columns like `condition`, and the wizard automatically includes all required fields based on your module selection.

### Resource Optimization
- **Parallelism**: Curare can run multiple analysis modules (like DESeq2 and edgeR) in parallel if sufficient cores are provided via the `--cores` argument.
- **Memory Management**: For large-scale mapping (especially with STAR or BWA-MEM2), ensure the execution environment has sufficient RAM, as these tools load large genome indices into memory.

### Result Interpretation
- **HTML Report**: The primary output is a `report.html`. Use the navigation bar at the top of the generated page to jump between specific module reports (e.g., FastQC results, Mapping statistics, or Volcano plots from DGE analysis).
- **Runtime Statistics**: The start page of the report includes Curare-specific statistics and the total runtime, which is useful for benchmarking and resource planning for future runs.

## Reference documentation
- [Curare Overview](./references/anaconda_org_channels_bioconda_packages_curare_overview.md)
- [Curare GitHub Repository](./references/github_com_pblumenkamp_Curare.md)