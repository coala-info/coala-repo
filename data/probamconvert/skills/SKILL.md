---
name: probamconvert
description: The `probamconvert` tool is a specialized utility designed to bridge the gap between proteomics and genomics.
homepage: https://github.com/Biobix/proBAMconvert
---

# probamconvert

## Overview
The `probamconvert` tool is a specialized utility designed to bridge the gap between proteomics and genomics. It transforms standard peptide identification outputs—specifically mzIdentML (.mzid), pepXML (.xml), and mzTAB (.mztab)—into the proBAM format (a BAM file extension for proteomics) or proBED format. This allows researchers to treat peptide data like genomic features, enabling visualization in tools like IGV or UCSC Genome Browser and integration with other NGS data types.

## Installation and Setup
The tool is primarily distributed via Bioconda. Ensure your environment has the necessary dependencies, including `pysam`.

```bash
conda install -c bioconda probamconvert
```

## Common CLI Patterns
While the tool provides a graphical interface, the command-line version is preferred for automated pipelines and server environments.

### Basic Conversion
The standard execution requires defining the input file, the input format, and the reference genome/annotation source (often via Ensembl or BioMart).

```bash
# General syntax pattern
probamconvert -i <input_file> -f <format> -o <output_prefix> [options]
```

### Working with mzIdentML
When processing mzIdentML files, you can control whether to include all Peptide-Spectrum Matches (PSMs) or only those that passed the identification threshold.

*   **Validated PSMs only**: Use the validation filter to ensure only high-confidence identifications are exported to the proBAM file.
*   **Modification Extraction**: The tool automatically handles modification extraction, but ensure your .mzid file contains standard Unimod or PSI-MS CV terms for best results.

### Genomic Annotation Integration
`probamconvert` relies on Ensembl/BioMart to map peptides to genomic coordinates.
*   **Ensembl Versioning**: The tool supports specific Ensembl releases (e.g., v88). Ensure your reference matches the version used during your initial database search.
*   **Connection Stability**: If BioMart connections fail on default ports, the tool is designed to attempt alternative ports to maintain stability during the annotation fetch.

## Expert Tips and Best Practices
*   **Column Ordering**: Recent versions of the tool have standardized the proBAM column order. If using downstream tools that expect a specific schema, ensure you are using version 1.0.2 or later.
*   **Three-Frame Translation**: If you are working with proteogenomic searches against 3-frame translations, ensure the tool is updated to avoid known coordinate mapping bugs present in legacy versions.
*   **SAM/BAM Processing**: The tool handles SAM processing and BAM writing as separate steps to optimize memory usage. For very large datasets, ensure you have sufficient temporary disk space for the intermediate SAM file before it is converted to a sorted BAM.
*   **UniProt Mapping**: If your input uses UniProt accessions that have been deprecated, the tool includes a feature to attempt updating entry names via BioMart to find the current genomic mapping.

## Reference documentation
- [probamconvert - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_probamconvert_overview.md)
- [GitHub - Biobix/proBAMconvert](./references/github_com_Biobix_proBAMconvert.md)
- [proBAMconvert Commits History](./references/github_com_Biobix_proBAMconvert_commits_master.md)