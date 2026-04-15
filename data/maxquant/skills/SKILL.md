---
name: maxquant
description: MaxQuant is a proteomics platform that identifies and quantifies protein groups from high-resolution mass spectrometry data. Use when user asks to process raw MS data, perform label-free or isobaric quantification, or execute searches using mqpar.xml configuration files.
homepage: http://www.coxdocs.org/doku.php?id=maxquant:start
metadata:
  docker_image: "quay.io/biocontainers/maxquant:2.0.3.0--py310hdfd78af_1"
---

# maxquant

## Overview
MaxQuant is the industry-standard platform for high-resolution MS-based proteomics. It specializes in the "bottom-up" proteomics workflow, converting raw mass spectrometry data into identified and quantified protein groups. It is particularly effective for Label-Free Quantification (LFQ), SILAC, and TMT/iTRAQ experiments. This skill provides guidance on executing MaxQuant via the command line and managing its configuration requirements.

## Command Line Usage
While MaxQuant is often associated with a GUI, it is frequently executed in headless mode on Linux servers or HPC clusters using the `MaxQuantCmd.exe` (via Mono or .NET core) or the `maxquant` wrapper provided by Bioconda.

### Basic Execution
To run a search with an existing configuration file:
```bash
maxquant mqpar.xml
```

### Configuration Management
The `mqpar.xml` file is the central configuration hub. It defines:
- Paths to raw data files (.raw, .mzXML, etc.)
- Search databases (.fasta)
- Experimental design (fractions, replicates)
- Parameter settings (mass tolerance, modifications, quantification methods)

### Resource Allocation
MaxQuant is highly parallelizable. Ensure the `numThreads` parameter in the `mqpar.xml` matches the available CPU cores on your system to optimize performance.

## Expert Tips
- **Dry Runs**: Before committing to a multi-day run, verify that all file paths in the `mqpar.xml` are absolute and accessible by the user running the process.
- **Memory Management**: MaxQuant is memory-intensive. A general rule of thumb is to allocate 2-4 GB of RAM per thread, depending on the complexity of the search and the size of the FASTA database.
- **FASTA Databases**: Always include common contaminants (e.g., keratins, trypsin) in your search database to avoid false identifications. MaxQuant can automatically generate "decoy" entries for False Discovery Rate (FDR) estimation.
- **Output Analysis**: The primary results are stored in the `combined/txt/` directory. Key files include `proteinGroups.txt` (quantification) and `evidence.txt` (peptide-level details).

## Reference documentation
- [MaxQuant Overview](./references/anaconda_org_channels_bioconda_packages_maxquant_overview.md)