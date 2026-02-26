---
name: metabinkit
description: Metabinkit is a toolkit for taxonomic assignment that processes alignment data to determine the origin of DNA sequences using identity thresholds and Lowest Common Ancestor calculations. Use when user asks to perform taxonomic binning, classify metagenomic sequences, or assign taxonomy to alignment files.
homepage: https://github.com/envmetagen/metabinkit
---


# metabinkit

## Overview

Metabinkit is a specialized toolkit for taxonomic assignment that processes alignment data to determine the most likely origin of DNA sequences. While many tools provide raw alignments, metabinkit refines these results by applying hierarchical percentage identity thresholds (Species, Genus, Family, etc.) and calculating the Lowest Common Ancestor (LCA) for all alignments that pass the filters. This ensures a conservative and accurate taxonomic classification for metagenomic datasets.

## Core CLI Usage

The primary program in the toolkit is `metabin`. It processes tab-separated alignment files to produce taxonomic bins.

### Basic Command
```bash
metabin -i input_alignments.tsv -o output_prefix
```

### Input File Requirements
The input must be a tab-separated (TSV) file containing at least these three columns:
- `qseqid`: The ID of the query sequence.
- `pident`: The percentage identity of the alignment.
- `taxids`: The NCBI taxid of the database subject sequence.

*Note: If the input lacks taxonomic rank columns (K, P, C, O, F, G, S), the tool will attempt to retrieve this information from its internal database.*

### Default Identity Thresholds
Metabinkit applies the following default thresholds for binning:
- **Species**: 99% identity
- **Genus**: 97% identity
- **Family**: 95% identity
- **Higher than Family**: 90% identity

## Expert Tips and Best Practices

### Interpreting Output Codes
When a sequence cannot be assigned at a specific level, metabinkit uses specific codes in the output to explain why:
- `mbk:nb-thr`: The percentage identity (`pident`) was below the required threshold for that level.
- `mbk:nb-lca`: A Lowest Common Ancestor could not be determined.
- `mbk:bl-S/G/F`: The taxid was blacklisted at the Species, Genus, or Family level.

### Performance and Automation
- **Quiet Mode**: Use the `-q` flag to suppress non-essential progress messages, which is useful for clean logs in automated pipelines.
- **Database Setup**: Ensure the taxonomy database is properly initialized. If using a manual installation, run `source metabinkit_env.sh` to set up the necessary environment variables for the database path.
- **Custom Filtering**: Use the `--FilterCol` argument if you need to filter alignments based on additional metadata columns present in your input TSV.

### Installation Patterns
- **Conda (Recommended)**: `conda install -c bioconda metabinkit`
- **Docker**: Use the `envmetagen/metabinkit` image to ensure all R dependencies and TaxonKit components are correctly configured without manual intervention.

## Reference documentation
- [Metabinkit Main Documentation](./references/github_com_envmetagen_metabinkit.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_metabinkit_overview.md)