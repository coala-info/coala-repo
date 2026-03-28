---
name: genview
description: GEnView automates the extraction of genomic flanking sequences and generates phylogeny-aware interactive visualizations to compare gene synteny across multiple organisms. Use when user asks to build genomic databases from NCBI or local files, investigate the genomic context of target proteins, or generate comparative visualizations of gene neighborhoods.
homepage: https://github.com/EbmeyerSt/GEnView.git
---

# genview

## Overview

GEnView is a specialized tool for investigating the genomic context of target proteins across multiple organisms. It automates the process of fetching genomic data from NCBI (or using local files), identifying target genes, extracting their flanking sequences (typically 20kbp), and performing multi-sequence alignments. The final output is a phylogeny-aware interactive visualization that allows researchers to compare gene content and synteny visually. Use this skill to guide the creation of genomic databases and the generation of comparative visualizations.

## Core Workflow

### 1. Database Creation (`genview-makedb`)
The first step is to build a SQLite database containing the target genes and their environments.

**Basic command structure:**
```bash
genview-makedb -d <output_dir> -db <ref_proteins.fasta> --taxa '<species_name>' --assemblies --plasmids
```

**Key Parameters:**
- `-db`: A FASTA file containing **amino acid sequences** of the proteins you are looking for.
- `--taxa`: Specify one or more taxa (e.g., `'Escherichia coli' 'Salmonella'`). Use `'all'` with caution as it can trigger massive downloads.
- `--accessions`: Use a CSV file with one NCBI accession per row instead of taxa names.
- `--local`: Path to a directory of local FASTA files if not using NCBI.
- `--flanking_length`: Distance to extract upstream/downstream (default is 20000 bp).
- `--uniprot_db`: Path to a Diamond-indexed UniProt database for annotating flanking ORFs. If omitted, the tool will attempt to download it.

### 2. Visualization (`genview-visualize`)
Once the database is created, generate the interactive HTML comparison.

**Basic command structure:**
```bash
genview-visualize -db <path_to_db> -gene '<gene_name>' -id <identity_cutoff>
```

**Key Parameters:**
- `-gene`: The name/prefix of the gene to extract (e.g., `per-` to find PER-1, PER-2, etc.).
- `--compress`: Highly recommended for large datasets; it removes sequences that are >95% identical to simplify the visualization.
- `--custom_colors`: Path to a tab-separated file to color-code specific gene classes (e.g., `transporter [tab] mfs,pump [tab] rgb(255,0,0)`).

## Expert Tips and Best Practices

- **Reference FASTA Headers**: Keep headers in your reference protein FASTA file extremely simple. Avoid special characters and the pipe (`|`) symbol. GEnView uses these names to group genes during visualization.
- **Local File Headers**: When using `--local`, ensure headers are clean. GEnView splits headers at the first space; the first string must be unique.
- **Identity Cutoffs**: Use `-id` and `-scov` (subject coverage) in `genview-makedb` to filter out weak hits early. A common starting point is 80% for both.
- **Updating Databases**: Use the `--update` flag with `genview-makedb` to add new genomes to an existing directory without rebuilding the entire database.
- **Memory Management**: For large-scale searches, specify the number of CPU cores using `-p`.
- **Interactive Exploration**: The output `interactive_visualization.html` allows you to click on genes to see nucleotide sequences or click the lines between genes to see the full flanking sequence.



## Subcommands

| Command | Description |
|---------|-------------|
| genview-makedb | Creates sqlite3 database with genetic environment from genomes containing the provided reference gene(s). |
| genview-visualize | Extract, visualize and annotate genes and genetic environments from genview database |

## Reference documentation
- [GEnView GitHub Wiki](./references/github_com_EbmeyerSt_GEnView_wiki.md)
- [GEnView Repository Overview](./references/github_com_EbmeyerSt_GEnView.md)