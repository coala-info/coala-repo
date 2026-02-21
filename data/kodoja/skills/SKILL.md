---
name: kodoja
description: Kodoja is a bioinformatics pipeline specifically designed to detect viruses in plant transcriptomic data.
homepage: https://github.com/abaizan/kodoja/
---

# kodoja

## Overview

Kodoja is a bioinformatics pipeline specifically designed to detect viruses in plant transcriptomic data. It leverages a dual-tool approach, combining the speed of k-mer-based classification (Kraken) with the sensitivity of protein-level searches using the Burrows-Wheeler transform (Kaiju). This workflow is ideal for researchers who need to process raw sequencing data (fasta or fastq) to identify viral pathogens while optionally filtering out host plant sequences.

## Installation

The most reliable way to install Kodoja and its dependencies (FastQC, Trimmomatic, Kraken, Kaiju) is via Bioconda:

```bash
conda install -c bioconda kodoja
```

## Core Workflow

### 1. Building Databases (kodoja_build.py)
Before searching, you must create or download databases. Use `kodoja_build.py` to download viral and host genomes from NCBI.

*   **Basic Build:** `kodoja_build.py --output_dir <db_path> --all_viruses`
*   **Include Host Genome:** Use the NCBI TaxID to include a specific host (e.g., 4577 for *Zea mays*) to improve classification accuracy.
    ```bash
    kodoja_build.py --output_dir plant_db --host 4577 --threads 8
    ```

### 2. Classifying Sequences (kodoja_search.py)
This is the primary diagnostic tool. It runs Trimmomatic for quality control before passing reads to Kraken and Kaiju.

*   **Standard Search:**
    ```bash
    kodoja_search.py --read1 R1.fastq --read2 R2.fastq --output_dir results_dir \
                     --kraken_db <path_to_kraken> --kaiju_db <path_to_kaiju>
    ```
*   **Key Parameters:**
    *   `--host_subset`: Provide the TaxID of the host to exclude those reads from the final viral summary table.
    *   `--trim_minlen`: Adjust the minimum read length (default 50) based on your sequencing quality.

### 3. Retrieving Sequences (kodoja_retrieve.py)
After classification, use this script to extract the actual sequences identified as viral for downstream analysis (e.g., assembly or BLAST).

*   **Stringent Retrieval:** Pulls sequences identified as the same virus by both Kraken and Kaiju.
    ```bash
    kodoja_retrieve.py --file_dir results_dir --read1 R1.fastq --taxID <virus_id> --stringent
    ```

## Expert Tips and Best Practices

*   **Output Directory Safety:** Never place your original raw data files inside the directory specified by `--output_dir`. Kodoja manages this directory and may overwrite or conflict with existing files.
*   **Kaiju Sensitivity:** Always ensure the `-x` parameter is enabled (it is recommended by the authors) to filter low-complexity regions, which significantly reduces false-positive viral matches caused by repetitive sequencing noise.
*   **Memory Management:** Kraken and Kaiju databases can be large. Ensure your environment has sufficient RAM (typically 32GB+ depending on database size) before initiating `kodoja_search.py`.
*   **Pre-built Databases:** If you do not wish to build your own, use the official kodojaDB (v1.0) available via Zenodo (DOI: 10.5281/zenodo.1406071).

## Reference documentation
- [Kodoja GitHub Repository](./references/github_com_abaizan_kodoja.md)
- [Kodoja Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kodoja_overview.md)