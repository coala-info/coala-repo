---
name: sipros
description: Sipros is a bioinformatics toolkit for identifying and quantifying proteins in stable-isotope mass spectrometry-based metaproteomics. Use when user asks to convert RAW files to FT2 format, perform unlabeled protein searches, or quantify isotopic enrichment through stable isotope probing.
homepage: https://github.com/thepanlab/Sipros4
---


# sipros

## Overview

Sipros is a specialized bioinformatics toolkit designed for stable-isotope mass spectrometry-based metaproteomics. It excels at identifying and quantifying isotopically labeled proteins (SIP-metaproteomics) and performing standard unlabeled searches. The toolkit manages the entire pipeline from vendor-specific RAW file conversion to protein-level False Discovery Rate (FDR) refinement. While Sipros 4 provides legacy support for specific workflows, Sipros 5 is the recommended version for improved sensitivity, automatic SIP-labeling FDR control, and Data-Independent Acquisition (DIA) support.

## Installation and Environment Setup

Sipros is primarily distributed via Bioconda. Because the toolkit relies on a mix of C++, Python 2.7, Mono (.NET), and R, it is best managed through specific Conda environments.

```bash
# Install Sipros 5 (Recommended)
conda install bioconda::sipros

# Legacy Sipros 4 Environment
conda create -n sipros4 bioconda::sipros=4.02
conda activate sipros4

# Helper Environments
conda create -n py2 scikit-learn python=2.7
conda create -n mono -c conda-forge mono
conda create -n r -c conda-forge -c bioconda r-base r-stringr r-tidyr bioconductor-biostrings
```

## Core CLI Workflows

### 1. RAW File Conversion
Convert vendor RAW files to the FT2 format required by Sipros. This requires the Mono environment.

```bash
conda activate mono
mono Raxport.exe -i [input_dir] -o [output_dir] -j [threads]
```

### 2. Unlabeled Search Workflow (Ensemble)
Used for standard metaproteomics searches against a FASTA database.

1.  **Search**: Run `SiprosEnsembleOMP` using a configuration file.
    ```bash
    export OMP_NUM_THREADS=10
    SiprosEnsembleOMP -f demo.FT2 -c SiprosEnsembleConfig.cfg -o output_dir
    ```
2.  **Post-Processing**: Tabulate, filter, and assemble results.
    ```bash
    # Tabulate (Python 2)
    python sipros_psm_tabulating.py -i output_dir -c config.cfg -o output_dir
    # Filter
    python sipros_ensemble_filtering.py -i demo.tab -c config.cfg -o output_dir
    # Assemble
    python sipros_peptides_assembling.py -c config.cfg -w output_dir
    ```
3.  **FDR Refinement**: Use R to control protein-group FDR.
    ```bash
    Rscript refineProteinFDR.R -pro demo.pro.txt -psm demo.psm.txt -fdr 0.005 -o demo
    ```

### 3. Labeled Search Workflow (SIP)
Used for Stable Isotope Probing to quantify isotopic enrichment.

1.  **Generate Configs**: Create specific configuration files for labeled searches.
    ```bash
    configGenerator -i SiprosV4Config.cfg -o configs -e C
    ```
2.  **Search**: Run `SiprosV4OMP` against a reduced FASTA (often generated from an initial unlabeled search).
    ```bash
    SiprosV4OMP -f demo.FT2 -c C13_10000Pct.cfg -o output_dir
    ```
3.  **Quantification**: Cluster SIP abundance and quantify per FT2 file.
    ```bash
    python ClusterSip.py -c SiprosV4Config.cfg -w output_dir
    Rscript getLabelPCTinEachFT.R -pro refined.pro.txt -psm demo.psm.txt -thr 5 -o output_prefix
    ```

## Expert Tips and Best Practices

*   **Version Selection**: Always prefer Sipros 5 for new projects. It offers approximately 3x more labeled identifications than Sipros 4 and handles FDR control automatically.
*   **Performance**: Use the `OMP_NUM_THREADS` environment variable to control parallelization for the C++ binaries (`SiprosEnsembleOMP`, `SiprosV4OMP`).
*   **Memory Management**: Metaproteomics databases can be massive. For SIP searches, use `makeDBforLabelSearch.R` to create a reduced FASTA containing only proteins identified in the unlabeled search to save time and memory.
*   **Configuration**: Use `copyConfigTemplate` to get a baseline configuration file rather than writing one from scratch.
*   **File Naming**: Ensure FT2 files and configuration files are correctly matched; the scripts often rely on consistent naming conventions within the working directory (`-w` flag).

## Reference documentation
- [Sipros Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sipros_overview.md)
- [Sipros4 GitHub Repository](./references/github_com_thepanlab_Sipros4.md)
- [Sipros4 Wiki](./references/github_com_thepanlab_Sipros4_wiki.md)