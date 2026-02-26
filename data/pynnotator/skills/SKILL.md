---
name: pynnotator
description: pynnotator is a comprehensive framework that automates the annotation of VCF files by integrating multiple genomic databases and functional prediction tools. Use when user asks to annotate variants for Mendelian disorders, add population frequencies and clinical associations to VCF files, or convert raw genomic data into annotated CSV and VCF formats.
homepage: http://github.com/raonyguimaraes/pynnotator
---


# pynnotator

## Overview
pynnotator is a comprehensive wrapper and framework designed to streamline the annotation of Variant Call Format (VCF) files. It is specifically tailored for researchers and clinicians working with Mendelian disorders, as it integrates multiple state-of-the-art tools and databases into a single execution flow. By automating the interaction between tools like Ensembl VEP, SnpEff, and vcfanno, it allows for the rapid transformation of raw VCF data into annotated files (VCF and CSV) containing functional predictions, population frequencies, and clinical associations.

## Installation and Setup
Before running annotations, the environment must be initialized with the necessary genomic data.

- **Initial Data Download**: This command downloads approximately 35GB of reference data (requires ~65GB during the process).
  ```bash
  pynnotator install
  ```
- **Verification**: Ensure the installation and tool paths are correct by running the built-in test suite.
  ```bash
  pynnotator test
  ```

## Common CLI Patterns

### Basic Annotation
The primary use case is annotating a single VCF or compressed VCF.gz file.
```bash
pynnotator -i input_sample.vcf
```

### Specifying Genome Builds
pynnotator supports both GRCh37 (hg19) and GRCh38 (hg38). It is critical to match the build of your input VCF to the reference database.
```bash
# For hg19/GRCh37
pynnotator -i sample.vcf -b hg19

# For hg38/GRCh38
pynnotator -i sample.vcf -b hg38
```

### Building from Source
If you need to rebuild the entire dataset from scratch (e.g., to update to the latest database versions), use the build command. Note that this typically takes ~8 hours and requires significant memory.
```bash
pynnotator build
```

## Expert Tips and Best Practices

- **Resource Management**: You can tune memory usage and CPU core allocation by modifying the `settings.py` file within the pynnotator installation directory. This is highly recommended for large-scale whole-genome sequencing (WGS) data.
- **Input Preparation**: While pynnotator performs a sanity check and sorts VCFs automatically using `sort -k1,1d -k2,2n`, ensuring your VCF is valid and properly formatted beforehand reduces the risk of tool-specific errors (especially with VEP).
- **Integrated Databases**: pynnotator provides a "one-stop" annotation by pulling from:
    - **Functional Predictions**: SIFT, PolyPhen-2, LRT, MutationTaster (via dbNSFP).
    - **Population Frequencies**: 1000 Genomes, ESP6500, gnomAD.
    - **Clinical Context**: ClinVar, Decipher, Ensembl phenotype associated variants.
- **Output Formats**: The tool generates both an annotated VCF and a CSV file. The CSV file is particularly useful for downstream filtering in spreadsheet software or custom Python scripts for candidate gene prioritization.

## Reference documentation
- [pynnotator GitHub Repository](./references/github_com_raonyguimaraes_pynnotator.md)
- [Bioconda pynnotator Package](./references/anaconda_org_channels_bioconda_packages_pynnotator_overview.md)