---
name: cat
description: The Contig Annotation Tool (CAT) assigns taxonomic classifications to metagenomic contigs and bins using a consensus-based voting algorithm. Use when user asks to classify metagenomic sequences, assign taxonomy to bins or MAGs, or generate taxonomic profiles for contigs.
homepage: https://github.com/dutilh/CAT
---


# cat

## Overview
The Contig Annotation Tool (CAT) and Bin Annotation Tool (BAT) provide a framework for assigning taxonomy to metagenomic data. Unlike simple BLAST searches, these tools use a consensus-based voting algorithm: they predict genes (ORFs), align them against a protein database, and then determine the most likely taxonomic origin for the entire sequence or bin. This approach is particularly effective for classifying unknown or highly divergent microorganisms.

## Core Workflows

### 1. Database Preparation
Before running classification, you must have a formatted database.
- **Download preconstructed:** It is highly recommended to download pre-indexed files from the official repository links to save significant compute time.
- **Automated download:**
  `CAT_pack download --db nr -o ./db_dir`
- **Prepare for use:**
  `CAT_pack prepare --protein_fasta <fasta> --nodes <nodes.dmp> --names <names.dmp>`

### 2. Taxonomic Classification
- **Contigs (CAT):**
  `CAT_pack contigs -c contigs.fasta -d path/to/database -t path/to/taxonomy`
- **Bins/MAGs (BAT):**
  `CAT_pack bins -b bin_directory/ -d path/to/database -t path/to/taxonomy -s .fa`
- **Profiling (RAT):**
  `CAT_pack rat -c contigs.fasta -o output_prefix [options]`

### 3. Interpreting Results
The primary output is a tab-separated file containing TaxIDs. To make it human-readable, you must add the lineage names:
`CAT_pack add_names -i classification.txt -o classification.with_names.txt -t path/to/taxonomy`

## Expert Tips & Best Practices
- **Resource Management:** DIAMOND is the primary resource consumer. Use `--nproc` to specify CPU cores and manage RAM usage during the alignment phase by adjusting DIAMOND-specific parameters.
- **Sensitivity:** If working with highly novel sequences, consider passing sensitivity settings to the underlying aligner using the `--diamond_args` flag (e.g., `--diamond_args "--sensitive"`).
- **Intermediate Files:** CAT/BAT can be restarted from intermediate steps (such as gene calling or alignment) if the initial run fails or if you want to test different voting parameters without re-running the expensive alignment phase.
- **Asterisk Notation:** In the output, an asterisk (*) indicates a "suggestive" assignment. This occurs when the tool finds a hit but the voting threshold is not strictly met, signaling that the classification should be treated with caution.
- **Path Configuration:** Ensure `Prodigal` and `DIAMOND` are in your system `$PATH`. For RAT, `BWA` and `SAMtools` are also required.

## Reference documentation
- [CAT/BAT/RAT GitHub Repository](./references/github_com_MGXlab_CAT_pack.md)
- [Bioconda CAT Overview](./references/anaconda_org_channels_bioconda_packages_cat_overview.md)