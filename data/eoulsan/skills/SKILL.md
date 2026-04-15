---
name: eoulsan
description: Eoulsan is a modular and scalable workflow engine designed for performing reproducible high-throughput sequencing data analysis across various computing infrastructures. Use when user asks to execute NGS workflows, perform RNA-Seq differential analysis, or manage large-scale genomic data processing on clusters and Hadoop environments.
homepage: http://www.tools.genomique.biologie.ens.fr/eoulsan/
metadata:
  docker_image: "quay.io/biocontainers/eoulsan:2.5--hdfd78af_0"
---

# eoulsan

## Overview
Eoulsan is a modular and scalable workflow engine designed for bioinformaticians to perform reproducible NGS analysis. It operates on a separation of concerns: experimental metadata is defined in a plain text design file, while the analytical steps and parameters are defined in XML-based workflow and configuration files. It is compatible with various infrastructures, from local workstations to large clusters (SLURM, HT-Condor) and Hadoop environments.

## Environment and Installation
- **Requirements**: Ensure a GNU/Linux distribution with **Java 11** or higher installed.
- **Conda Installation**: The preferred method for installation is via Bioconda:
  ```bash
  conda install bioconda::eoulsan
  ```
- **Manual Installation**: Download the latest archive and untar it; no complex compilation is required for the core application.

## Core Components
To run an analysis, you must prepare three primary inputs:
1.  **Design File (.txt)**: Defines the experimental design (samples, replicates, and metadata).
2.  **Workflow File (.xml)**: Describes the sequence of analysis steps (modules) and their specific parameters.
3.  **Configuration File (.xml)**: Contains global settings, including paths to data repositories and cluster/Hadoop settings.

## Native Usage and Best Practices
- **Module Extensibility**: Eoulsan reuses the syntax of XML Galaxy tool description files. You can integrate simple Galaxy tools into an Eoulsan workflow without modification.
- **Reproducibility**: Always use Docker or Singularity containers for module dependencies to ensure the analysis is portable and reproducible.
- **Infrastructure Scaling**:
    - For local execution, ensure the configuration file is set to use local CPU resources.
    - For clusters, configure the job scheduler (HT-Condor, SLURM, TORQUE, or TGCC) within the configuration XML to distribute computations.
- **RNA-Seq Specifics**: The built-in RNA-Seq pipeline supports normalization and differential analysis using DESeq 1 and DESeq 2. Note that complex experimental designs require DESeq 2.
- **Long-Read Support**: Version 2.6.1+ bundles Minimap 2.24, making it suitable for Nanopore RNA-Seq workflows out of the box.
- **Illumina Support**: Supports Illumina samplesheet v2 (NextSeq 1000/2000).

## Expert Tips
- **Resuming Analyses**: Because Eoulsan tracks state via the design and workflow files, you can resume large-scale analyses from the point of failure after troubleshooting.
- **Memory Management**: Since Eoulsan is Java-based, ensure your `JAVA_OPTS` are configured to provide sufficient heap space for large NGS datasets.
- **Data Repositories**: Use the configuration file to define centralized data repositories to avoid redundant data copying across cluster nodes.

## Reference documentation
- [eoulsan - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_eoulsan_overview.md)
- [Eoulsan – Welcome to Eoulsan](./references/www_outils_genomique_biologie_ens_fr_eoulsan.md)