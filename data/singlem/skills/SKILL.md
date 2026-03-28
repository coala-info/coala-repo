---
name: singlem
description: SingleM performs taxonomic profiling of shotgun metagenomic data by targeting conserved marker genes to estimate microbial abundance and detect novel organisms. Use when user asks to generate taxonomic profiles, estimate prokaryotic fractions, aggregate OTU tables, or assess how well genomes represent a metagenome.
homepage: https://github.com/wwood/singlem
---


# singlem

## Overview

SingleM is a specialized tool for taxonomic profiling of shotgun metagenomic data (both short and long-read). Unlike traditional methods that map to whole genomes, SingleM targets short, highly conserved 20-amino acid "windows" within single-copy marker genes. This approach allows for accurate abundance estimation and the detection of novel organisms that may not have close relatives in existing genomic databases. It also includes "Lyrebird" for dsDNA phage profiling and tools for assessing eukaryotic contamination and genome recovery bias.

## Core Workflows

### 1. Initial Setup and Data Preparation
Before running profiles, you must download the reference metapackage (the database of marker genes and taxonomies).

```bash
# Download the default microbial metapackage
singlem data --download

# For phage profiling, download the Lyrebird metapackage
lyrebird data --download
```

### 2. Standard Profiling (The Pipe Workflow)
The `pipe` command is the primary entry point for generating OTU tables and taxonomic profiles from raw sequences.

```bash
# Profile a single metagenome (short-read)
singlem pipe --sequences sample_R1.fastq.gz sample_R2.fastq.gz --otu-table sample.otu.tsv --taxonomic-profile sample.profile.tsv --threads 8

# Profile long-read data (Nanopore R10.4.1+ or PacBio HiFi recommended)
singlem pipe --sequences long_reads.fastq.gz --otu-table long.otu.tsv --threads 8
```

### 3. Summarizing and Combining Results
If you have processed multiple samples individually, use `summarise` to aggregate them into a single table or convert formats.

```bash
# Combine multiple OTU tables
singlem summarise --otu-tables sample1.otu.tsv sample2.otu.tsv --output-otu-table combined.otu.tsv

# Convert a taxonomic profile to a format suitable for Krona or STAMP
singlem summarise --taxonomic-profile sample.profile.tsv --output-format krona --output-file sample.krona.html
```

### 4. Assessing Metagenome Composition
Use these specialized tools to understand the "big picture" of your shotgun data.

```bash
# Estimate the fraction of DNA that is prokaryotic (Bacterial/Archaeal)
singlem prokaryotic_fraction --sequences sample.fastq.gz --threads 4

# Appraise how well a set of MAGs or an assembly represents the metagenome
singlem appraise --metagenome-otu-table sample.otu.tsv --genome-otu-tables mag1.otu.tsv mag2.otu.tsv
```

### 5. Updating Results (Renew)
When a new version of the GTDB taxonomy or SingleM metapackage is released, you can update your profiles without re-searching the raw reads if you saved the "archive" (JSON) OTU table.

```bash
# Re-run taxonomy assignment with a new database
singlem renew --archive-otu-table sample.otu.json --taxonomic-profile updated.profile.tsv
```

## Expert Tips and Best Practices

- **Input Handling**: For large batches (>100 samples), it is more efficient to run `pipe` on individual samples and then use `summarise` to combine them, rather than passing all files to a single `pipe` command.
- **Memory Management**: SingleM is generally memory-efficient, but using many threads increases memory usage during the DIAMOND search phase.
- **Novelty Detection**: If a read matches a marker gene window but has no close taxonomic hit, SingleM still counts it. This "novelty-inclusive" feature is what makes it superior to standard mappers for environmental samples.
- **Phage Profiling**: Always use the `lyrebird` command (which is installed alongside `singlem`) when working with the phage-specific metapackages.
- **Output Extras**: Use the `--output-extras` flag in `pipe` mode to get additional columns like read names and unaligned sequences, which are useful for lineage-targeted MAG recovery.



## Subcommands

| Command | Description |
|---------|-------------|
| get_tree | Extract path to Newick tree file in a SingleM package. |
| makedb | Create a searchable OTU sequence database from an OTU table |
| singlem | singlem: error: argument subparser_name: invalid choice: 'are' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement) |
| singlem | singlem: error: argument subparser_name: invalid choice: 'eukaryote' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement) |
| singlem | singlem: error: argument subparser_name: invalid choice: 'sequences' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement) |
| singlem | singlem: error: argument subparser_name: invalid choice: 'single' (choose from data, pipe, appraise, seqs, makedb, query, summarise, prokaryotic_fraction, microbial_fraction, renew, create, get_tree, regenerate, metapackage, chainsaw, condense, trim_package_hmms, supplement) |
| singlem appraise | How much of the metagenome do the genomes or assembly represent? |
| singlem chainsaw | Remove tree information and trim unaligned sequences from a SingleM package (expert mode) |
| singlem condense | Combine OTU tables across different markers into a single taxonomic profile. |
| singlem create | Create a SingleM package. |
| singlem data | Download reference metapackage data |
| singlem metapackage | Create or describe a metapackage (i.e. set of SingleM packages) |
| singlem microbial_fraction | Estimate the fraction of reads from a metagenome that are assigned to Bacteria and Archaea compared to e.g. eukaryote or phage. Also estimate average genome size. [deprecated; use prokaryotic_fraction] |
| singlem pipe | Generate a taxonomic profile or OTU table from raw sequences |
| singlem prokaryotic_fraction | Estimate the fraction of reads from a metagenome that are assigned to Bacteria and Archaea compared to e.g. eukaryote or phage. Also estimate average genome size. |
| singlem query | Find closely related sequences in a SingleM database. |
| singlem regenerate | Update a SingleM package with new sequences and taxonomy (expert mode). |
| singlem renew | Reannotate an OTU table with an updated taxonomy |
| singlem seqs | Find the best window position for a SingleM package |
| singlem supplement | Create a new metapackage from a vanilla one plus new genomes |
| singlem_summarise | Summarise single-cell RNA-seq data |
| singlem_trim_package_hmms | Trim the width of HMMs to increase speed (expert mode) |

## Reference documentation
- [SingleM Wiki](./references/github_com_wwood_singlem_wiki.md)
- [SingleM Pipe Tool](./references/wwood_github_io_singlem_tools_pipe.md)
- [Glossary of Terms](./references/wwood_github_io_singlem_Glossary.md)
- [Installation Guide](./references/wwood_github_io_singlem_Installation.md)
- [Prokaryotic Fraction Tool](./references/wwood_github_io_singlem_tools_prokaryotic_fraction.md)