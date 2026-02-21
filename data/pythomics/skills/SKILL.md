---
name: pythomics
description: Pythomics is a specialized Python library designed to unify computational approaches across different "-omic" disciplines.
homepage: https://github.com/pandeylab/pythomics
---

# pythomics

## Overview
Pythomics is a specialized Python library designed to unify computational approaches across different "-omic" disciplines. It is particularly effective for researchers who need to bridge the gap between genomics and proteomics, such as creating customized protein databases that reflect specific genomic variations or performing standardized quantitative proteomics workflows.

## Common CLI Workflows
The `pythomics` package provides several specialized scripts for handling multi-omic data. When using these tools, follow these functional patterns:

### Proteomics and Digestion
- **Protein Inference**: Use the `proteinInference` script to derive protein-level identifications from peptide-level data.
- **iBAQ Quantification**: Use the `iBAQ` script to calculate Intensity-Based Absolute Quantification values, which are essential for estimating the relative abundance of proteins within a sample.
- **In Silico Digestion**:
    - Use `fastadigest` to simulate the enzymatic cleavage of protein sequences from a FASTA file.
    - Use `fastadigeststats` to evaluate the theoretical proteome coverage and peptide distribution of a specific digestion strategy.

### Genomic and Transcriptomic Integration
- **Variant-Aware Databases**: Use `incorporateVCF` to integrate variants from a VCF file into a reference FASTA file. This is a critical step for proteogenomics workflows where you need to identify mutated peptide sequences.
- **Annotation Integration**: Use `incorporateGFF` to generate FASTA sequences based on GFF/GTF genomic annotations.
- **Combined Workflows**: You can chain these tools to create a FASTA file from a GFF annotation that also incorporates specific variants from a VCF file, ensuring the downstream proteomics search database matches the specific genomic background of the sample.
- **Transcriptomics**: Use `fetch_cufflinks_transcripts` when working with Cufflinks output to extract specific transcript sequences for further analysis.

## Best Practices
- **Custom Proteases**: When performing digestions, `pythomics` allows for custom protease definitions. Use this when working with non-standard enzymes like Asp-N or Chymotrypsin.
- **Database Preparation**: Always run `fastadigeststats` after creating a custom FASTA (via VCF/GFF integration) to ensure the resulting database has the expected peptide properties for your mass spectrometry setup.
- **Environment**: Ensure the package is installed via bioconda (`conda install bioconda::pythomics`) to have all CLI scripts correctly mapped to your path.

## Reference documentation
- [GitHub Repository - pythomics](./references/github_com_Chris7_pythomics.md)
- [pythomics Wiki - Home](./references/github_com_Chris7_pythomics_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pythomics_overview.md)