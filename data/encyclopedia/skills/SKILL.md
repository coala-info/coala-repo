---
name: encyclopedia
description: EncyclopeDIA is a specialized search engine for identifying and quantifying peptides in DIA proteomics data. Use when user asks to search DIA data against spectrum libraries, perform library-free analysis using FASTA files, or generate chromatogram libraries.
homepage: https://bitbucket.org/searleb/encyclopedia/wiki/Home
metadata:
  docker_image: "quay.io/biocontainers/encyclopedia:2.12.30--hdfd78af_0"
---

# encyclopedia

## Overview
EncyclopeDIA is a specialized search engine designed for the analysis of DIA proteomics data. It bridges the gap between traditional spectrum library searching and library-free analysis. Use this tool to identify and quantify peptides by matching experimental chromatograms against pre-existing libraries or by generating new chromatogram libraries directly from protein sequence databases (FASTA) when a physical library is unavailable.

## Command Line Usage
EncyclopeDIA is typically executed as a Java archive. The basic syntax for running the tool via the command line is:

```bash
java -Xmx[Memory] -jar encyclopedia.jar [options]
```

### Core Analysis Workflows
- **Library Search**: To search DIA data against an existing spectrum library (.elib or .blib).
- **Walnut (Library-free)**: To search DIA data directly against a FASTA file to generate a chromatogram library.
- **Library Generation**: To convert DDA search results into a format compatible with DIA analysis.

### Common Parameters
- `-i <file>`: Input DIA data file (typically in .mzML format).
- `-lib <file>`: The spectrum or chromatogram library file to search against.
- `-f <file>`: The FASTA protein database (required for Walnut/PECAN workflows).
- `-a`: Perform alignment between multiple DIA runs.
- `-o <directory>`: Specify the output directory for results.

## Best Practices
- **Memory Allocation**: DIA analysis is memory-intensive. Always specify the maximum heap size (e.g., `-Xmx32G`) based on the size of your dataset and library.
- **File Formats**: Ensure input files are converted to centroided .mzML format using tools like ProteoWizard's msconvert before processing.
- **Library Selection**: Use DDA-based spectrum libraries for highest confidence, but resort to Walnut (FASTA-based) when working with non-model organisms or specific protein variants not present in public repositories.
- **FDR Filtering**: Always review the False Discovery Rate (FDR) thresholds applied to the final peptide and protein detections to ensure statistical rigor.

## Reference documentation
- [EncyclopeDIA Overview](./references/anaconda_org_channels_bioconda_packages_encyclopedia_overview.md)
- [EncyclopeDIA Wiki Home](./references/bitbucket_org_searleb_encyclopedia_wiki_Home.md)