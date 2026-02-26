---
name: mtsv
description: MTSv is a suite of tools for metagenomic binning and analysis. Use when user asks to identify taxa present in DNA sequencing samples by analyzing signature reads, binning contigs into potential genomes, or profiling taxonomic abundance.
homepage: https://github.com/FofanovLab/MTSv
---


# mtsv

yaml
name: mtsv
description: A suite of tools for metagenomic binning and analysis. Use when you need to identify taxa present in DNA sequencing samples by analyzing signature reads, particularly for shotgun or short-read formats. This skill is useful for tasks such as binning, taxonomic profiling, and analyzing metagenomic datasets.
```
## Overview
MTSv is a powerful suite of tools designed for metagenomic binning and analysis. It excels at identifying the taxonomic composition of DNA sequencing samples by pinpointing unique reads associated with specific taxa. This is particularly effective for short-read data, such as shotgun sequencing. Use MTSv when you need to perform tasks like binning contigs into potential genomes, profiling the abundance of different taxa, or generally analyzing the microbial communities within a sample.

## Usage and Best Practices

MTSv is primarily a command-line tool. Installation is recommended via Conda.

### Installation

```bash
conda install mtsv -c bioconda -c conda-forge
```

### Core Workflow

The MTSv pipeline generally involves two main stages:

1.  **Sequence Database Setup (One-time or infrequent):** Downloading and preparing reference sequence databases.
2.  **Binning and Analysis (Per sample):** Processing new read sets through the binning and analysis pipeline.

### Key Commands and Concepts

While the full command-line interface can be extensive, understanding the core components is crucial. MTSv is written in Python and utilizes compiled Rust binaries for performance.

**General Usage Pattern:**

```bash
mtsv [command] [options] <input_files>
```

**Important Considerations:**

*   **Input Data:** MTSv typically expects short-read data, often in `.fastq` or `.fastq.gz` format.
*   **Databases:** The tool relies on reference databases for taxonomic assignment. Ensure these are correctly set up or downloaded. The `install.sh` script might be relevant for initial database setup.
*   **Environment:** It's recommended to run MTSv within a Python 3.6 Conda environment.

### Expert Tips

*   **Database Management:** For offline or air-gapped systems, refer to the issue tracker for discussions on creating offline mirrors of databases.
*   **Performance:** MTSv leverages Rust binaries for core functions, indicating a focus on performance. Consider the `--cpus` or similar parameters for multi-threading where applicable, especially for analysis steps.
*   **Custom Databases:** The tool supports building custom databases. Refer to the issue tracker for specific discussions on custom database creation from lists of files or using custom flat files.
*   **Troubleshooting:** If encountering issues, check the GitHub issue tracker for similar problems, especially regarding Conda installations or specific command executions.

## Reference documentation
- [MTSv Overview (Anaconda.org)](./references/anaconda_org_channels_bioconda_packages_mtsv_overview.md)
- [MTSv GitHub Repository](./references/github_com_FofanovLab_MTSv.md)
- [MTSv Issues](./references/github_com_FofanovLab_MTSv_issues.md)
- [MTSv Wiki](./references/github_com_FofanovLab_MTSv_wiki.md)