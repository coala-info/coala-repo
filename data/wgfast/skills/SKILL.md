---
name: wgfast
description: WG-FAST genotypes unknown samples against a reference set for phylogenetic analysis. Use when user asks to genotype samples against a reference, place samples phylogenetically, or analyze pathogen populations.
homepage: https://github.com/jasonsahl/wgfast
metadata:
  docker_image: "quay.io/biocontainers/wgfast:1.0.4--py_0"
---

# wgfast

---
## Overview
WG-FAST is a bioinformatics pipeline designed for whole-genome SNP typing using focused arrays. It's particularly useful for placing unknown samples within the phylogenetic context of known pathogen populations. This tool can process various types of sequencing data, including metagenomics, metatranscriptomics, and single isolate sequencing.

## Usage Instructions

### Installation

The recommended installation method is via Conda:

```bash
conda create -n wgfast python=3.6
conda activate wgfast
# Previous required versions: gatk4=4.2.6.1, picard=2.27.4
conda install -c bioconda gatk4 picard raxml samtools bbmap dendropy minimap2 biopython
```

Alternatively, you can download the GitHub repository and install it locally:

```bash
git clone https://github.com/jasonsahl/wgfast.git
cd wgfast
python setup.py build
python setup.py install
```

After local installation, you may need to edit the `wgfast.py` script to set the `WGFAST_PATH` environment variable to your installation directory.

### Core Functionality

WG-FAST's primary function is to genotype unknown samples against a reference set. The exact command-line usage will depend on the specific analysis you wish to perform, but it generally involves providing input sample data and reference information.

### Expert Tips and Common Patterns

*   **Environment Activation**: Always ensure your `wgfast` Conda environment is activated before running the tool to avoid dependency issues.
*   **Reference Data**: The accuracy of WG-FAST heavily relies on the quality and comprehensiveness of your reference dataset. Ensure your reference genomes are well-curated and representative of the pathogen population you are studying.
*   **Input Data Formats**: WG-FAST is designed to handle various input types. Refer to the `wgfast_manual.md` for detailed specifications on expected input file formats for metagenomic, metatranscriptomic, or isolate data.
*   **Troubleshooting Installation**: If you encounter issues during installation or execution, verify that all required dependencies (GATK4, Picard, RAxML, Samtools, BBMap, DendroPy, Minimap2, Biopython) are correctly installed and accessible in your environment. The `tests/test_all_functions.py` script can be used to verify a successful installation.

## Reference documentation
- [WG-FAST Manual Overview](./references/github_com_jasonsahl_wgfast.md)