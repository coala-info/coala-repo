---
name: wade
description: WADE is a bioinformatics tool that uses BLAST+ to extract gene sequences and identify molecular markers from assembled genomes, particularly for antimicrobial resistance and virulence factors. Use when user asks to interrogate assembled genomes, extract gene sequences, identify molecular markers, identify antimicrobial resistance genes, identify virulence factors, profile mutations, serotype pneumococcus, serotype Group B Streptococcus, or predict MIC values for pneumococci.
homepage: https://github.com/phac-nml/wade
metadata:
  docker_image: "quay.io/biocontainers/wade:1.2.0--r44hdfd78af_0"
---

# wade

## Overview
WADE (WGS Analysis and Detection of Molecular Markers) is a specialized bioinformatics framework designed to streamline the interrogation of assembled genomes. By leveraging BLAST+, it automates the extraction of specific gene sequences and identifies molecular determinants across large genomic datasets. The tool is particularly effective for clinical and public health microbiology, offering curated databases for AMR (CARD, ResFinder, ARG-ANNOT) and virulence factors (VFDB). It provides both simple presence/absence results and detailed mutation profiling, outputting data in formats compatible with LabWare and sequence alignment tools.

## Installation and Environment Setup
WADE can be installed via Bioconda or directly from GitHub within an R environment.

**Bioconda Installation:**
```bash
conda install bioconda::wade
```

**R Installation:**
```R
install.packages("devtools")
devtools::install_github("phac-nml/wade")
```

**External Dependencies:**
- **BLAST+**: Must be installed and available in the system PATH.
- **R Packages**: Requires `tidyverse`, `Biostrings`, `shiny`, `DT`, and `readxl`.

## Configuration and Directory Structure
WADE relies on a specific directory structure and a configuration file to locate genomic data.

1. **Required Directories**: Create a base directory (e.g., `WADE/`) with `Output/` and `temp/` subdirectories.
2. **DirectoryLocations.csv**: This file maps organism IDs to their respective data paths.
   - `OrgID`: The target organism.
   - `LocalDir`: The base WADE directory.
   - `SystemDir`: Path to curated `wade-data` files.
   - `ContigsDir`: Path to the folder containing `.fasta` contig files.
   - `VCFDir`: Path to VCF files (required for GONO and PNEUMO analyses).

## Usage Patterns

### Running the Shiny Interface
The primary way to interact with WADE is through its RShiny UI, which facilitates organism selection and analysis parameters.
```R
library(wade)
# Set working directory to your WADE folder containing DirectoryLocations.csv
setwd("C:/WADE/")
# Run the application
source("WADE.R") 
```

### Batch Processing
To process multiple samples simultaneously, use a `list.csv` file located in the WADE root directory.
- **Structure**: The file must contain `SampleNo` and `Variable` columns.
- **Trigger**: In the UI, enter "list" in the sample number field to initiate batch mode.

### Standalone Tools
For specific workflows, WADE includes standalone scripts in the `standalones/` directory:
- **MasterBlastR**: General gene extraction from contigs.
- **SerotypeR**: Pneumococcus and Group B Streptococcus serotyping.
- **WamR-Pneumo**: MIC value prediction for pneumococci based on resistance determinants.

## Expert Tips and Troubleshooting
- **Database Indexing**: If running a new analysis or after updating allele lookup files, always click the **MakeBlastdb** button to re-index the BLAST databases.
- **Windows Memory Errors**: If `makeblastdb` fails on Windows, set the following environment variable to increase the map size:
  - Variable: `BLASTDB_LMDB_MAP_SIZE`
  - Value: `1000000`
- **Input Formatting**: Ensure all contig files use the `.fasta` extension and follow a consistent naming convention (e.g., `SampleID_contig.fasta`) to ensure the tool correctly associates files with the sample list.

## Reference documentation
- [WADE Overview](./references/anaconda_org_channels_bioconda_packages_wade_overview.md)
- [WADE GitHub Documentation](./references/github_com_phac-nml_wade.md)