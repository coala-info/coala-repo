---
name: btyper3
description: BTyper3 performs high-resolution taxonomic classification and genomic nomenclature assignment for the Bacillus cereus group using assembled genomes. Use when user asks to classify Bacillus cereus group isolates, perform type strain comparisons using ANI, or assign genomic species and genomospecies definitions.
homepage: https://github.com/lmc297/BTyper3
---


# btyper3

## Overview

BTyper3 is a specialized command-line tool designed for the high-resolution taxonomic classification of the *Bacillus cereus* group. Unlike traditional methods that rely on phenotypic traits, BTyper3 utilizes a standardized genomic nomenclature to provide consistent species and genomospecies assignments. It processes assembled genomes (complete or draft) to reconcile genomic definitions with clinical and industrial phenotypes, making it a critical tool for researchers working with *B. cereus* group isolates.

## Usage Instructions

### Basic Classification
To perform the default taxonomic analysis on an assembled genome:
```bash
btyper3 -i /path/to/genome.fasta -o /path/to/output_directory
```

### Type Strain Comparison (v3.2.0+)
To compare your query genome against the type strain genomes of all published *B. cereus* group species and report the highest ANI (Average Nucleotide Identity) value:
```bash
btyper3 -i /path/to/genome.fasta -o /path/to/output_directory --ani_typestrains
```

### Advanced Options
*   **Pseudo-gene flow unit assignment**: Use the `--geneflow` flag to include gene flow analysis in the output.
*   **Custom FastANI path**: If FastANI is not in your system PATH, specify it manually:
    ```bash
    btyper3 -i input.fasta -o output --fastani_path /path/to/fastANI
    ```

## Best Practices and Expert Tips

*   **Input Requirements**: BTyper3 requires assembled genomes in (multi-)FASTA format. It is not designed for raw sequencing reads; perform assembly (e.g., using Shovill or SPAdes) before running this tool.
*   **Standardized vs. Historical Taxonomy**: Be aware that BTyper3 uses a standardized nomenclature. For example, species like *B. sanguinis* and *B. paramobilis* are classified as *B. mosaicus* within this framework. Use the `--ani_typestrains` option if you specifically need to see how an isolate relates to historically named type strains.
*   **Interpretation Caution**: While BTyper3 provides high-resolution classification, it does not definitively prove pathogenicity. Always interpret results regarding "anthrax-like" or "emetic-like" potential with clinical or experimental context.
*   **Dependency Management**: The tool relies on BLAST+ and FastANI. If using the Conda installation, these are typically handled automatically. If using Pip, ensure `makeblastdb` and `tblastn` are accessible in your environment.
*   **Version Awareness**: Ensure you are using v3.4.0 or later to include the most recently added species such as *B. rhizoplanae* and *B. pretiosus*.

## Reference documentation
- [BTyper3 GitHub Repository](./references/github_com_lmc297_BTyper3.md)
- [BTyper3 Wiki Home](./references/github_com_lmc297_BTyper3_wiki.md)
- [Bioconda btyper3 Overview](./references/anaconda_org_channels_bioconda_packages_btyper3_overview.md)