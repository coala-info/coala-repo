---
name: bcbio-nextgen
description: bcbio-nextgen is a community-driven toolkit designed to provide "best-practice" pipelines for complex sequencing analysis.
homepage: https://github.com/bcbio/bcbio-nextgen
---

# bcbio-nextgen

## Overview

bcbio-nextgen is a community-driven toolkit designed to provide "best-practice" pipelines for complex sequencing analysis. It abstracts the complexity of individual bioinformatics tools (like BWA, GATK, and FreeBayes) into a unified workflow. This skill should be used when you need to process large-scale genomic data with a focus on reproducibility, scalability, and validation. It handles the heavy lifting of distributed execution and transactional processing, allowing researchers to focus on biological interpretation rather than pipeline engineering.

## Installation and Setup

To install the full suite including tool dependencies and reference data:

1. Download the installer:
   `wget https://raw.githubusercontent.com/bcbio/bcbio-nextgen/master/scripts/bcbio_nextgen_install.py`

2. Run the installation (example for hg38 and BWA):
   `python bcbio_nextgen_install.py /usr/local/share/bcbio --tooldir=/usr/local --genomes hg38 --aligners bwa`

For a lightweight installation of the python code only via Conda:
`conda install bioconda::bcbio-nextgen`

## Common CLI Patterns

### Automated Project Setup
Use the `-w template` command to automatically generate a processing description from your raw data and metadata. This command takes a template name, a metadata CSV, and your sequence files (FASTQ or BAM).

`bcbio_nextgen.py -w template freebayes-variant project_metadata.csv sample1_1.fq sample1_2.fq`

### Running Analysis
Execute the pipeline by pointing to your configuration file. Use the `-n` flag to specify the number of local cores for parallel processing.

`bcbio_nextgen.py ../config/project_config.yaml -n 8`

### Distributed Execution
For large-scale runs on compute clusters, bcbio-nextgen uses IPython parallel. Ensure your environment is configured for your scheduler (SGE, SLURM, Torque) and run using the appropriate cluster configuration.

## Expert Tips and Best Practices

- **Idempotent Restarts**: bcbio-nextgen is designed with transactional steps. If a run is interrupted, simply re-running the same command will resume the analysis from the last successful step without re-processing completed data.
- **Validation**: Always utilize the automated validation features. You can compare variant calls against gold-standard reference materials (like Genome in a Bottle) by including the validation files in your setup.
- **Resource Management**: When running on a single multicore machine, ensure the `-n` parameter does not exceed available physical cores to avoid memory contention, especially during alignment and variant calling phases.
- **Project Discontinuation**: Note that as of August 2024, the project has been marked for discontinuation. While the tool remains functional for existing pipelines, consider this for long-term project planning.

## Reference documentation
- [bcbio-nextgen GitHub Repository](./references/github_com_bcbio_bcbio-nextgen.md)
- [bcbio-nextgen Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bcbio-nextgen_overview.md)