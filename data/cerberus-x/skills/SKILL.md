---
name: cerberus-x
description: Cerberus-x (formerly MetaCerberus) is a versatile pipeline that transforms raw sequencing reads or assembled contigs into metabolic knowledge.
homepage: https://github.com/raw-lab/cerberus
---

# cerberus-x

## Overview

Cerberus-x (formerly MetaCerberus) is a versatile pipeline that transforms raw sequencing reads or assembled contigs into metabolic knowledge. It automates the complex process of functional profiling by integrating quality control (FastQC/fastp), gene prediction (Prodigal/FragGeneScanRs), and HMMER-based searching against a wide array of functional databases. It is particularly effective for environmental 'omics where diverse metabolic pathways across bacteria, archaea, viruses, and eukaryotes need to be characterized simultaneously.

## Installation and Initialization

Before running analysis, the environment must be prepared and databases must be synchronized.

```bash
# Create environment
mamba create -n cerberus -c conda-forge -c bioconda cerberus
conda activate cerberus

# Initial setup (required once)
cerberus.py --setup

# Download HMM databases (required once)
cerberus.py --download
```

## Common CLI Patterns

### 1. Processing Raw Reads (End-to-End)
For Illumina or PacBio data, Cerberus-x performs QC, trimming, and phiX removal before gene prediction.

```bash
cerberus.py --read1 sample_R1.fastq --read2 sample_R2.fastq --out output_dir
```

### 2. Processing Assembled Contigs
Use this when you have already performed assembly and want to predict genes and annotate functions.

```bash
cerberus.py --fasta assembly.fna --out output_dir
```

### 3. Processing Protein Sequences (.faa)
If you already have predicted ORFs, this is the fastest way to run functional annotation.

```bash
cerberus.py --faa proteins.faa --out output_dir
```

## Expert Tips and Best Practices

*   **Eukaryotic Samples:** If your metagenome is rich in eukaryotes, use the `--super` option. This utilizes FragGeneScanRs, which typically identifies more ORFs and KOs in eukaryotic-heavy samples compared to Prodigal.
*   **Viral Analysis:** When conducting viral or phage analysis, ensure you do **not** use `--skip_decon`. The default behavior removes the phiX174 genome (a common Illumina spike-in), which can otherwise cause false positives for ssDNA microviruses.
*   **Customizing Thresholds:** The default HMMER thresholds are a bitscore of 25 and an e-value of 1e-9. You can tighten these for higher confidence:
    ```bash
    cerberus.py --faa proteins.faa --bitscore 30 --evalue 1e-10 --out output_dir
    ```
*   **N-Repeat Handling:** Cerberus-x automatically removes N-repeats from contigs/genomes by default. Avoid using scaffolds with high N-counts as they lead to ambiguous annotations.
*   **Visualization:** The tool generates interactive HTML reports using Plotly. Ensure the `plotly.js` file (provided in the package) remains in the report folder to view the metabolic distributions.
*   **Resource Management:** For large datasets, Cerberus-x uses HydraMPP for modular pipeline execution. Ensure your environment has sufficient memory for HMMER searches against multiple large databases.

## Reference documentation

- [Cerberus-x Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cerberus-x_overview.md)
- [Cerberus-x GitHub Documentation](./references/github_com_raw-lab_cerberus.md)