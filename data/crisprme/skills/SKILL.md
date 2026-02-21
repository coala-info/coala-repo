---
name: crisprme
description: CRISPRme is a specialized bioinformatics suite for the thorough evaluation of off-target effects in CRISPR-Cas systems.
homepage: https://github.com/samuelecancellieri/CRISPRme
---

# crisprme

## Overview
CRISPRme is a specialized bioinformatics suite for the thorough evaluation of off-target effects in CRISPR-Cas systems. It distinguishes itself from standard search tools by incorporating genetic variation data (such as gnomAD) and orthogonal genomic annotations to prioritize potential off-target sites that might be unique to specific individuals or populations. The tool automates the pipeline from data acquisition to the generation of interactive web-based reports, making it an essential resource for clinical-grade CRISPR design and safety assessment.

## Installation and Environment
The tool is best managed via Mamba or Conda to ensure all C++ optimized dependencies are correctly resolved.

- **Create Environment**: `mamba create -n crisprme python=3.9 crisprme -y`
- **Activate**: `mamba activate crisprme`
- **Verify**: `crisprme.py --version`

## Core CLI Functions
The `crisprme.py` script serves as the primary entry point. Key sub-commands include:

- **complete_search**: Executes the full off-target discovery pipeline, including variant-aware searching.
- **complete_test**: Runs a validation suite to ensure the installation and local environment are performing correctly.
- **targets_integration**: Merges raw off-target search results with genomic annotations (e.g., genes, enhancers, or chromatin state) to prioritize sites.
- **gnomad_converter**: Processes gnomAD VCF files into the specific format required for variant-aware searching.
- **generate_personal_card**: Creates a summary of off-target risks tailored to a specific individual's genotype.
- **web_interface**: Launches the interactive dashboard for visualizing results and tables.

## Expert Tips and Best Practices
- **Memory Management**: CRISPRme is resource-intensive. Ensure a minimum of 32 GB RAM for standard tasks. For whole-genome searches involving large variant datasets, 64 GB or more is strongly recommended to avoid out-of-memory (OOM) errors.
- **Variant Integration**: When performing personal genome analysis, always use the `gnomad_converter` first to ensure your VCF data is compatible with the search engine's haplotype logic.
- **Output Analysis**: Focus on the `integrated_results` directory. This contains the most high-utility data, as it combines the raw search hits with biological context (annotations), which is more informative than raw mismatch counts alone.
- **Bulge Handling**: Unlike simpler tools, CRISPRme allows for DNA and RNA bulges. When designing spacers for highly repetitive regions, adjust the bulge parameters to capture potential "hidden" off-targets that standard tools might miss.

## Reference documentation
- [CRISPRme GitHub README](./references/github_com_samuelecancellieri_CRISPRme.md)
- [CRISPRme Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_crisprme_overview.md)