---
name: riboraptor
description: Riboraptor is a Python package for analyzing ribosome profiling data. Use when user asks to process and analyze ribosome profiling data, download SRA datasets, or manage dependencies for ribo-seq analysis.
homepage: https://github.com/saketkc/riboraptor
metadata:
  docker_image: "quay.io/biocontainers/riboraptor:0.2.2--py36_0"
---

# riboraptor

A Python package for analyzing ribosome profiling data. Use this skill when you need to process and analyze ribosome profiling (ribo-seq) data, including tasks related to SRA dataset processing, dependency management, and running analysis workflows.
---
## Overview

Riboraptor is a bioinformatics tool designed for the analysis of ribosome profiling data. It provides a pipeline for processing and analyzing ribo-seq experiments. While much of its functionality has been ported to a newer tool called `ribotricer`, Riboraptor can still be used for specific analyses, particularly those involving Snakemake-based workflows or as a standalone toolkit. It requires a specific conda environment setup and can handle SRA dataset downloads and processing.

## Usage Instructions

Riboraptor can be used in several ways, primarily as a Snakemake-based workflow or as a standalone toolkit.

### Installation and Environment Setup

1.  **Conda Environment Setup:** It is crucial to set up a dedicated conda environment for Riboraptor to manage its dependencies.
    *   Add necessary channels:
        ```bash
        conda config --add channels r
        conda config --add channels defaults
        conda config --add channels conda-forge
        conda config --add channels bioconda
        ```
    *   Create and activate the environment:
        ```bash
        conda create --name riboraptor python=3 gcc matplotlib numpy pandas pybedtools pyBigWig pyfaidx pysam scipy seaborn statsmodels six click click-help-colors htseq biopython bx-python h5py joblib trackhub pytest snakemake sra-tools star fastqc trim-galore ucsc-bedgraphtobigwig ucsc-bedsort ucsc-bigwigmerge bamtools pysradb
        source activate riboraptor
        ```
2.  **SRA Data Dependencies:** For processing and downloading SRA datasets, install `aspera-connect` and `SRAdb`.
    *   Download and install Aspera Connect for `.fasp` downloads.
    *   Install `SRAdb` from GitHub:
        ```bash
        git clone https://github.com/seandavi/SRAdb
        cd SRAdb
        # Ensure your riboraptor conda environment is activated
        R
        library(devtools)
        devtools::install(".")
        quit()
        ```
3.  **Metadata Files:** Download necessary metadata files for SRA record processing:
    ```bash
    mkdir riboraptor-data && cd riboraptor-data
    wget -c http://starbuck1.s3.amazonaws.com/sradb/GEOmetadb.sqlite.gz && gunzip GEOmetadb.sqlite.gz
    wget -c https://starbuck1.s3.amazonaws.com/sradb/SRAmetadb.sqlite.gz && gunzip SRAmetadb.sqlite.gz
    ```
4.  **Install Riboraptor:**
    ```bash
    # Ensure your riboraptor conda environment is activated
    git clone https://github.com/saketkc/riboraptor.git
    cd riboraptor
    python setup.py install --single-version-externally-managed --record=record.txt
    ```

### Usage Modes

*   **Mode 1: Snakemake-based Workflow:**
    Riboraptor can be integrated into Snakemake workflows. Refer to the example workflows provided in the repository for detailed usage.

*   **Mode 2: Standalone Toolkit:**
    Riboraptor can be used as a command-line tool for specific analysis tasks. For a comprehensive command manual, consult the documentation.

### Common CLI Patterns and Expert Tips

*   **Data Input:** Riboraptor typically expects input files in formats like FASTQ, BAM, or SRA. Ensure your input files are correctly formatted and accessible.
*   **Configuration:** For Snakemake workflows, configuration files (e.g., `config.yaml`) are used to define parameters, sample information, and paths.
*   **Output:** Analysis results are usually generated in various formats, including text files, plots, and potentially BED or BigWig files, depending on the specific analysis step.
*   **SRA Downloads:** Use the `pysradb` tool (installed as a dependency) to download SRA datasets efficiently. For example: `pysradb download -p <project_accession>`.
*   **Note on `ribotricer`:** Be aware that `ribotricer` is the successor to Riboraptor and may offer more up-to-date features and support. If starting a new project, consider evaluating `ribotricer` first.



## Subcommands

| Command | Description |
|---------|-------------|
| riboraptor bam-to-bedgraph | Convert bam to bedgraph |
| riboraptor bedgraph-to-bigwig | Convert bedgraph to bigwig |
| riboraptor export-bed-fasta | Export gene level fasta from specified bed regions |
| riboraptor export-gene-coverages | Export gene level coverage for all genes for given region |
| riboraptor export-metagene-coverage | Export metagene coverage for given region |
| riboraptor periodicity | Calculate periodicity of Ribo-seq data. |
| riboraptor plot-metagene | Plot metagene read counts. |
| riboraptor plot-read-length | Plot read length distribution |
| riboraptor read-length-dist | Calculate read length distribution |
| riboraptor uniq-bam | Create a new bam with unique mapping reads only |
| riboraptor uniq-mapping-count | Count number of unique mapping reads |

## Reference documentation

- [Riboraptor Documentation](https://riboraptor.readthedocs.io/en/latest/)
- [GitHub Repository](https://github.com/saketkc/riboraptor)