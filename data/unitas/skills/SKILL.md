---
name: unitas
description: unitas annotates small RNA sequencing data to identify known and novel small non-coding RNAs. Use when user asks to annotate small RNA sequences, identify novel small non-coding RNAs, configure annotation for specific species or custom references, or interpret small RNA classification results.
homepage: http://www.smallrnagroup.uni-mainz.de/software.html
---


# unitas

## Overview
unitas is a specialized tool for the comprehensive annotation of small RNA sequencing data. It streamlines the identification of known and novel small non-coding RNAs by performing sequential mapping against multiple databases. This skill helps in configuring the tool for different species, managing input requirements, and interpreting the automated classification of small RNA sequences.

## Usage Guidelines

### Basic Command Structure
The tool is typically invoked via Perl (as it is a Perl-based application) or directly if the bioconda installation is in the path:
```bash
unitas -input [sequence_file] -species [species_name] [options]
```

### Key Parameters
- `-input`: Supports FASTQ or FASTA formats. Ensure adapters have been trimmed before running unitas.
- `-species`: Use the scientific name (e.g., `homo_sapiens`, `drosophila_melanogaster`). This triggers the automatic download of required reference sequences if they are not present.
- `-out`: Specify the output directory name.

### Common Workflow Patterns
- **Standard Annotation**: For a basic run using default parameters for a specific organism:
  `unitas -input sample.fastq -species homo_sapiens`
- **Custom Reference Files**: If working with a species not in the internal database or using custom sequences:
  `unitas -input sample.fastq -ref [path_to_custom_ref]`
- **Adjusting Sensitivity**: Use `-mismatch` (default is 0 or 1 depending on version) to control the stringency of the mapping process.

### Best Practices
- **Memory Management**: Small RNA datasets can be large; ensure sufficient RAM is available for the mapping steps, especially when using large reference genomes.
- **Species Naming**: Always check the exact spelling of the species name as expected by the tool to ensure the automated reference fetching works correctly.
- **Output Interpretation**: unitas generates several files, including a summary table and categorized FASTA files. Focus on the `.summary` file for a high-level overview of the small RNA composition.

## Reference documentation
- [unitas Overview](./references/anaconda_org_channels_bioconda_packages_unitas_overview.md)