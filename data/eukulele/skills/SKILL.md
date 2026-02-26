---
name: eukulele
description: EUKulele is a bioinformatics pipeline for the taxonomic classification of eukaryotes in environmental metagenomic and metatranscriptomic data. Use when user asks to classify eukaryotic sequences, manage reference databases like EukProt or MMETSP, or assess taxonomic annotation completeness using BUSCO.
homepage: https://github.com/AlexanderLabWHOI/EUKulele
---


# eukulele

## Overview
EUKulele is a specialized bioinformatics pipeline designed to simplify the taxonomic classification of eukaryotes in environmental "omics" data. It bridges the gap between raw sequence data (MAGs or metatranscriptomes) and taxonomic insights by providing automated database management and alignment workflows. It is particularly effective for researchers who need to integrate multiple reference sets like EukProt or MMETSP without manual formatting.

## Core CLI Usage
The primary entry point for the tool is the `EUKulele` command. At a minimum, you must specify the data type and the location of your samples.

### Basic Command Structure
```bash
EUKulele --mets_or_mags <type> --sample_dir <path_to_samples>
```
*   `--mets_or_mags`: Specify whether the input data consists of metatranscriptomes (`mets`) or metagenome-assembled genomes (`mags`).
*   `--sample_dir`: The directory containing your FASTA/FASTQ files.

### Database Management
EUKulele can automatically download and format reference databases if they are not already present in your reference directory.
*   **Supported Databases**: PhyloDB, EukProt, MMETSP, and GTDB.
*   **Automatic Setup**: If a reference directory is not specified or is empty, the tool will prompt or default to downloading these standard sets.

## Workflow Best Practices
*   **Input Organization**: Place all sample files in a single directory. EUKulele iterates through the files in the provided `--sample_dir`.
*   **Nucleotide MAGs**: While EUKulele is optimized for protein-level alignments, it supports nucleotide MAGs using `blastx`. Note that this is computationally intensive and generally less recommended than providing protein sequences.
*   **Extension Handling**: If your files use non-standard extensions, use the `--n_ext` flag to ensure the tool recognizes your sequence files correctly.
*   **Completeness Assessment**: To evaluate the quality of your taxonomic assignments, utilize the BUSCO features. EUKulele can assess the completeness of contig subsets at each taxonomic level to provide confidence scores for the annotations.

## Troubleshooting and Expert Tips
*   **BUSCO Dependencies**: Ensure that BUSCO and its dependencies (like HMMER and MetaEuk) are correctly installed in your environment, as these are critical for the completeness assessment features.
*   **Memory Management**: When running against large databases like PhyloDB, ensure your system has sufficient RAM for the alignment step (Diamond or BLAST).
*   **Eukaryote Dumping**: Recent versions include the ability to dump eukaryotic-specific FASTA sequences after classification, which is useful for downstream phylogenomic analysis.

## Reference documentation
- [EUKulele GitHub README](./references/github_com_AlexanderLabWHOI_EUKulele.md)
- [EUKulele Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_eukulele_overview.md)
- [EUKulele Known Issues and Flags](./references/github_com_AlexanderLabWHOI_EUKulele_issues.md)