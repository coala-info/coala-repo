---
name: pypgatk
description: pypgatk is a Python framework for proteogenomics that generates customized protein sequence databases from genomic variants and non-canonical sources. Use when user asks to download reference data from Ensembl or COSMIC, translate genomic variants into protein databases, perform three-frame translations, generate decoy sequences for FDR estimation, or prepare input files for DeepLC and MSRescore.
homepage: http://github.com/bigbio/py-pgatk
---


# pypgatk

## Overview

The `pypgatk` (Python ProteoGenomics Analysis Toolkit) is a specialized framework designed to bridge the gap between genomics and proteomics. It provides a suite of tools to create customized protein sequence databases that include non-canonical peptides, mutations, and variants derived from genomic sources. This is essential for mass spectrometry workflows where standard reference databases (like UniProt) fail to capture the full diversity of the proteome, such as cancer-specific mutations or novel translation products.

## Core CLI Usage

The primary entry point for the toolkit is the `pypgatk` command.

### Data Acquisition
Use the downloader modules to fetch reference data from major repositories:
- **Ensembl**: `pypgatk ensembl-downloader --help`
- **COSMIC**: `pypgatk cosmic-downloader --help`
- **cBioPortal**: `pypgatk cbioportal-downloader --help`

### Database Generation
Transform genomic variants and sequences into protein databases (FASTA format):
- **VCF to Protein**: Generate peptides based on DNA variants.
  `pypgatk vcf-to-proteindb --vcf input.vcf --input_fasta reference.fasta --output_fasta output.fasta`
- **Three-frame Translation**: Perform 3-frame translation of nucleotide sequences.
  `pypgatk threeframe-translation --input_fasta transcripts.fasta --output_fasta translated.fasta`
- **cBioPortal/COSMIC to Protein**: Translate specific mutation records into searchable protein databases.
  `pypgatk cosmic-to-proteindb --input_mutation cosmic_mutations.tsv --output_fasta cosmic_proteins.fasta`

### Post-Processing and Validation
- **Decoy Generation**: Create decoy sequences for False Discovery Rate (FDR) estimation using methods like Reverse, Shuffled, or DecoyPYrat.
  `pypgatk generate-decoy --input_fasta proteins.fasta --output_fasta decoys.fasta --method reverse`
- **Ensembl Integrity**: Check Ensembl databases for stop codons or gaps before proceeding with analysis.
  `pypgatk ensembl-check --input_fasta proteins.fasta`
- **FDR Calculation**: Compute peptide class-specific FDR.
  `pypgatk peptide-class-fdr --input_psm results.tsv --output_fdr filtered_results.tsv`

### Integration with Other Tools
- **DeepLC**: Generate input files for DeepLC retention time prediction from idXML, mzTab, or consensusXML.
  `pypgatk generate-deeplc --input_file identification.idXML --output_file deeplc_input.csv`
- **MSRescore**: Generate configuration files for MSRescore from idXML files.
  `pypgatk msrescore-configuration --input_file identification.idXML`

## Expert Tips

1. **Pre-Translation Validation**: Always run `ensembl-check` on downloaded Ensembl data to identify potential issues with stop codons or sequence gaps that could lead to incorrect peptide identifications.
2. **Decoy Strategy**: When generating decoys for proteogenomics, ensure the decoy method matches the search engine requirements. The `reverse` method is generally preferred for standard proteomics, but `shuffled` may be more appropriate for specific non-canonical searches.
3. **Memory Management**: When processing large VCF files or whole-genome translations, ensure the environment has sufficient RAM, as these operations can be memory-intensive depending on the number of variants.
4. **Container Usage**: For reproducible environments, use the official BioContainers Docker image: `docker pull quay.io/biocontainers/pypgatk:<version>`.

## Reference documentation

- [pypgatk Overview](./references/anaconda_org_channels_bioconda_packages_pypgatk_overview.md)
- [pypgatk GitHub Repository](./references/github_com_bigbio_py-pgatk.md)