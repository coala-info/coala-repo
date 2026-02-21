---
name: nanometa-live
description: Nanometa-live is a specialized bioinformatics suite designed to process nanopore sequence reads as they are generated.
homepage: https://github.com/FOI-Bioinformatics/nanometa_live
---

# nanometa-live

## Overview
Nanometa-live is a specialized bioinformatics suite designed to process nanopore sequence reads as they are generated. It provides a bridge between raw sequencing output and actionable taxonomic insights through a multi-step pipeline that includes project initialization, data preparation, and a real-time graphical dashboard. This skill guides the execution of the backend analysis and the management of the local project environment.

## Project Initialization and Setup
Before running live analysis, a project environment must be structured.

- **Initialize a new project**: Use `nanometa-new` to define the working directory and data sources.
  ```bash
  nanometa-new --path ./my_project \
               --species_of_interest species_list.txt \
               --nanopore_output_directory /path/to/fastq_pass \
               --kraken_db /path/to/kraken_database \
               --kraken_taxonomy gtdb
  ```
- **Prepare resources**: Run `nanometa-prepare` to download necessary metadata and finalize the offline-capable environment.
  ```bash
  nanometa-prepare --path ./my_project
  ```

## Live Analysis and Visualization
Once the project is prepared, the live monitoring can begin.

- **Start the backend and GUI**: Execute `nanometa-live` pointing to your project directory.
  ```bash
  nanometa-live -p ./my_project
  ```
- **Accessing the Interface**: The command will output a local URL (typically on port 8050 or 8080). Open this in a web browser to view Sankey plots and sunburst charts.
- **Termination**: Use the "Shut down program" button in the GUI or press `Ctrl+C` in the terminal multiple times to stop the analysis.

## Simulation and Testing
To verify the pipeline without an active sequencing run, use the simulation tool.

- **Simulate sequencing**: Move existing FASTQ files into the monitored directory at a controlled pace.
  ```bash
  nanometa-sim -i /path/to/source_data -o /path/to/project_fastq_input
  ```
- **Automated Demo**: For a complete walkthrough with sample data, use the demo command.
  ```bash
  nanometa-demo --path ./demo_output
  ```

## Best Practices
- **Species of Interest**: Provide a text file with one species name or Taxonomy ID per line to highlight specific pathogens in the GUI.
- **Offline Usage**: Ensure `nanometa-prepare` is run while connected to the internet; after this step, the entire workflow can be run in air-gapped environments.
- **Resource Management**: Metagenomic classification is memory-intensive. Ensure at least 8GB of RAM is available, though 16GB+ is recommended for large Kraken2 databases.
- **Data Monitoring**: Point the `--nanopore_output_directory` to the folder where MinKNOW or Guppy/Dorado writes `fastq_pass` files. Nanometa-live will automatically detect new files as they appear.

## Reference documentation
- [Nanometa Live GitHub Repository](./references/github_com_FOI-Bioinformatics_nanometa_live.md)
- [Nanometa Live Wiki](./references/github_com_FOI-Bioinformatics_nanometa_live_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_nanometa-live_overview.md)