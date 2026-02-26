---
name: genome_profiler
description: genome_profiler is a bioinformatics pipeline for the comprehensive annotation of prokaryotic genomes and the identification of genetic features. Use when user asks to annotate prokaryotic genetic material, identify resistance genes and virulence factors, or detect mobile genetic elements and plasmids.
homepage: https://github.com/Syrinx55/GenomeProfiler
---


# genome_profiler

## Overview
genome_profiler is a specialized bioinformatics pipeline designed for the comprehensive annotation of prokaryotic genetic material. It streamlines the identification of critical metadata features such as resistance genes and virulence factors, providing precise nucleotide coordinates for downstream analysis. It is particularly useful for researchers needing a standardized, automated workflow for plasmid and genome characterization, including the detection of mobile genetic elements and related plasmids.

## Setup and Configuration
Before running the pipeline, you must configure the environment and download necessary databases.

1. **Environment Variables**: Create a `.env` file in your working directory to store credentials. This is required for accessing NCBI Entrez and IslandViewer APIs.
   ```bash
   GENPROF_ENTREZ_EMAIL=your_email@example.com
   GENPROF_ISLANDVIEWER_AUTH_TOKEN=your_api_token
   ```
   *Note: The IslandViewer token must be renewed every 30 days via the IslandViewer website.*

2. **Resource Initialization**: Download the required databases and resources (e.g., antibiotic resistance and virulence databases) to the local directory.
   ```bash
   genome_profiler --setup
   ```
   This command populates the `./data_GenomeProfiler` directory.

## Command Line Usage
The tool provides both a graphical interface and a standard CLI.

### Basic Commands
- **Help Menu**: View all available arguments and tool descriptions.
  ```bash
  genome_profiler --help
  ```
- **Graphical Mode**: Launch the interactive GUI for configuration and execution.
  ```bash
  genome_profiler --gui
  ```

### Execution Patterns
By default, the pipeline saves all results to `./output_GenomeProfiler`. Ensure your input files (prokaryotic genomes or plasmid sequences) are accessible in your current environment.

## Best Practices
- **API Registration**: While any valid email works for Entrez, using a registered NCBI account email allows for higher concurrency and more stable processing of accessions.
- **Directory Management**: Run the tool from a dedicated project directory, as it creates `./data_GenomeProfiler` and `./output_GenomeProfiler` folders relative to the execution path.
- **Architecture Support**: Ensure you are running on `linux-64` or `osx-64` architectures, as these are the currently supported platforms for the bioconda package.

## Reference documentation
- [GenomeProfiler GitHub Repository](./references/github_com_Syrinx55_GenomeProfiler.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_genome_profiler_overview.md)