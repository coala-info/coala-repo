---
name: sidr
description: SIDR uses machine learning to identify and filter target sequences from assembly data based on taxonomic classifications. Use when user asks to clean sequence data before assembly, filter contigs by target phylum, or generate lists of sequence IDs to keep or remove.
homepage: https://github.com/damurdock/SIDR
---


# sidr

## Overview
SIDR (Sequence Identification with Decision Trees) is a bioinformatics tool used to clean and filter sequence data before assembly. It bridges the gap between raw classification data (like BLAST results) and final sequence sets by using machine learning to automate the identification of target sequences. You should use this skill when you have preliminary taxonomic assignments and want to generate a refined list of contig IDs to keep or remove based on a target phylum.

## Installation
The tool is available via Bioconda or pip:
```bash
conda install bioconda::sidr
# OR
pip install sidr
```

## Command Line Usage

### Default Mode
Use this mode when you have raw bioinformatics files (BAM, FASTA, BLAST) and need SIDR to calculate features like GC content and per-base coverage automatically.

```bash
sidr default -d [taxdump path] \
             -b [bamfile] \
             -f [assembly FASTA] \
             -r [BLAST results] \
             -k tokeep.contigids \
             -x toremove.contigids \
             -t [target phylum]
```

**Required Arguments:**
- `-d`: Path to the NCBI taxdump directory.
- `-b`: BAM file containing mapping information.
- `-f`: The assembly FASTA file.
- `-r`: BLAST results (or similar classifier output).
- `-k`: Output file for contig IDs to keep.
- `-x`: Output file for contig IDs to remove.
- `-t`: The specific target phylum to isolate.

### Runfile Mode
Use this mode if you have already pre-calculated variables for your contigs and have them in a tab-delimited format.

```bash
sidr runfile -i [runfile] \
             -k tokeep.contigids \
             -x toremove.contigids \
             -t [target phylum]
```

## Best Practices and Tips
- **Target Phylum Accuracy**: Ensure the string provided to `-t` matches the taxonomic nomenclature used in your `taxdump` and BLAST results exactly.
- **BLAST Formatting**: For best results, ensure your BLAST output includes the necessary fields for taxonomic identification (typically standard outfmt 6 or 7 with taxids).
- **Alpha Software Caution**: As SIDR is currently in alpha, always validate the `tokeep.contigids` and `toremove.contigids` files against a subset of known sequences before proceeding to large-scale assembly.
- **Data Preparation**: Ensure your BAM file is indexed and corresponds exactly to the contigs in your FASTA file to avoid mapping errors during feature calculation.

## Reference documentation
- [SIDR GitHub Repository](./references/github_com_damurdock_SIDR.md)
- [Bioconda SIDR Package Overview](./references/anaconda_org_channels_bioconda_packages_sidr_overview.md)