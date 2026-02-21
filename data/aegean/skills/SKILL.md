---
name: aegean
description: The provided text is an error log from a container runtime (Apptainer/Singularity) and does not contain the help documentation or usage instructions for the 'aegean' tool. As a result, no arguments could be extracted.
homepage: https://github.com/BrendelGroup/AEGeAn
---

# aegean

## Overview
The AEGeAn Toolkit is a specialized suite of C and Python tools designed for the rigorous analysis of genome annotations. It follows the RAMOSE philosophy (Reproducible, Accurate, Meaningful, Open, Scalable, Easy-to-use) to help researchers understand the spatial organization of genes and the quality of gene models. Use this skill to process GFF3 files, calculate genome statistics, and partition genomic data into manageable "locus" units for downstream analysis.

## Common CLI Patterns and Tools

### LocusPocus
The primary tool for defining "iLoci" (intergenic loci). It parses gene annotations and partitions the genome into regions containing a single gene or multiple overlapping genes, along with their associated intergenic regions.

*   **Basic Usage**: `locuspocus [options] annotation.gff3`
*   **Key Function**: Use this to resolve overlapping gene models and define clear boundaries for genomic features.

### fidibus
A workflow module used for summarizing genome content. It is particularly effective at calculating statistics regarding gene spacing and density.

*   **Usage**: Typically invoked as a python-based workflow to generate summary tables and spacing metrics.
*   **Expert Tip**: Use fidibus when you need a high-level overview of how genes are distributed across a newly assembled or annotated scaffold.

### GFF3 Processing and Validation
AEGeAn includes utilities for cleaning and standardizing GFF3 files, which is often a prerequisite for other bioinformatics tools.

*   **canon-gff3**: Use this utility to ensure GFF3 files follow a "canonical" format, resolving common ID conflicts and parent-child relationship errors.
*   **Validation**: When working with data from sources like BRAKER3, use AEGeAn's parsers to check for structural consistency before performing comparative genomics.

## Best Practices
1.  **Standardization First**: Always run your GFF3 files through `canon-gff3` before performing complex analysis to prevent errors related to non-standard attribute formatting or ID duplication.
2.  **Memory Management**: For large genomes, ensure you are using the latest version (0.16.0+) which includes optimizations for memory usage during the locus-parsing phase.
3.  **Integration**: AEGeAn tools are designed to be modular. Pipe the output of `locuspocus` (which is often GFF3) directly into other analysis scripts to maintain a seamless data processing stream.

## Reference documentation
- [AEGeAn GitHub Repository](./references/github_com_BrendelGroup_AEGeAn.md)
- [AEGeAn Wiki and FAQ](./references/github_com_BrendelGroup_AEGeAn_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_aegean_overview.md)