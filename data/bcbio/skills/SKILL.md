---
name: bcbio
description: bcbio-nextgen is a toolkit that automates high-throughput sequencing data processing through validated pipelines for variant calling and transcriptomics. Use when user asks to install genomic tools, initialize analysis projects from templates, or execute distributed sequencing pipelines.
homepage: https://github.com/bcbio/bcbio-nextgen
metadata:
  docker_image: "biocontainers/bcbio:v1.1.2-3-deb-py3_cv1"
---

# bcbio

## Overview
bcbio-nextgen is a community-developed toolkit designed to automate the data processing component of high-throughput sequencing. It provides validated pipelines for variant calling (germline and somatic), RNA-seq, and small RNA analysis, with a heavy focus on scalability and reproducibility. This skill guides the user through the lifecycle of a bcbio project, including environment installation, template-based project initialization, and distributed execution.

## Installation and Setup
To install bcbio-nextgen along with its required third-party tools and genomic data, use the automated installer script.

1. **Download the installer**:
   `wget https://raw.githubusercontent.com/bcbio/bcbio-nextgen/master/scripts/bcbio_nextgen_install.py`

2. **Execute installation**:
   `python bcbio_nextgen_install.py /path/to/data --tooldir=/path/to/tools --genomes hg38 --aligners bwa`
   - The `--genomes` flag specifies which reference genomes to download.
   - The `--aligners` flag specifies which alignment tools to configure.

## Project Initialization
bcbio uses a template system to create the necessary processing descriptions. This allows you to define a high-level analysis type and apply it to multiple samples.

- **Generate a project configuration**:
  `bcbio_nextgen.py -w template [template_name] [metadata.csv] [input_files]`
  - `[template_name]`: Common built-in templates include `freebayes-variant`, `gatk-variant`, or `rna-seq`.
  - `[metadata.csv]`: A CSV file containing sample names and associated metadata.
  - `[input_files]`: FASTQ or BAM files for the analysis.
  - This command produces a `config` directory containing the generated configuration file required for the run.

## Execution and Parallelism
The `bcbio_nextgen.py` script handles the execution of the pipeline. It is recommended to run the analysis from a dedicated `work` directory to keep the environment organized.

- **Run analysis locally**:
  `cd project_directory/work`
  `bcbio_nextgen.py ../config/project_name.yaml -n [number_of_cores]`
  - The `-n` flag specifies the number of local cores to use for parallel processing.

- **Distributed execution**:
  bcbio can scale to compute clusters or cloud environments (AWS). It uses IPython parallel to manage distributed tasks across multiple nodes.

## Expert Tips and Best Practices
- **Transactional Processing**: bcbio steps are idempotent. If a run is interrupted, simply re-running the command will resume the analysis from the last completed step without re-processing successful stages.
- **Validation**: To ensure call correctness, bcbio supports automated validation against reference materials. Include a "variants" entry in your metadata CSV pointing to a truth set (e.g., Genome in a Bottle) to trigger automated comparison.
- **System Configuration**: The installer creates a `bcbio_system.yaml` file. Edit this file to define system-specific resources like memory limits and core availability for individual tools.
- **Project Status**: Be aware that as of August 2024, the bcbio-nextgen project has been discontinued. It remains functional for existing pipelines, but users should plan for long-term transitions to maintained alternatives.

## Reference documentation
- [bcbio-nextgen README](./references/github_com_bcbio_bcbio-nextgen.md)