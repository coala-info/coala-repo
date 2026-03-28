---
name: taxonkit
description: TaxonKit is a high-performance command-line tool for processing and manipulating NCBI taxonomy data. Use when user asks to retrieve taxonomic lineages, convert scientific names to TaxIds, reformat lineage strings, find the lowest common ancestor, or filter TaxIds by rank.
homepage: https://github.com/shenwei356/taxonkit
---

# taxonkit

## Overview
TaxonKit is a high-performance command-line tool designed for processing NCBI taxonomy data. It is particularly useful for bioinformatics workflows that require mapping between TaxIds and scientific names, standardizing lineage formats (e.g., the 7-level superkingdom-to-species format), and navigating the taxonomic tree. It operates on the standard NCBI `taxdump` files and is optimized for speed and memory efficiency, making it suitable for large-scale metagenomic datasets.

## Setup and Data
TaxonKit requires the NCBI taxonomy database files.
1. Download the data: `wget ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz`
2. Extract to the default location: `tar -zxvf taxdump.tar.gz -C $HOME/.taxonkit`
3. Files needed: `names.dmp`, `nodes.dmp`, `delnodes.dmp`, and `merged.dmp`.

## Common CLI Patterns

### Querying Lineages
Retrieve the full taxonomic lineage for a list of TaxIds.
```bash
# From a file containing one TaxId per line
taxonkit lineage taxids.txt

# From STDIN
echo -e "9606\n2" | taxonkit lineage
```

### Reformating Lineage Strings
Standardize lineages into specific ranks (e.g., for Kraken2 or QIIME2 compatibility). Use `reformat2` for more flexibility with recent NCBI rank changes.
```bash
# Reformat to 7 canonical ranks: k,p,c,o,f,g,s
taxonkit lineage taxids.txt | taxonkit reformat -f "{k};{p};{c};{o};{f};{g};{s}"

# Handle missing ranks with a placeholder
taxonkit lineage taxids.txt | taxonkit reformat -f "{k};{p};{g};{s}" -F -p
```

### Name to TaxId Conversion
Convert scientific names to their corresponding NCBI TaxIds.
```bash
# Direct conversion
echo "Homo sapiens" | taxonkit name2taxid

# Fuzzy matching for approximate names
echo "Humo sapiens" | taxonkit name2taxid -f
```

### Filtering by Rank
Filter a list of TaxIds to keep only those within a specific taxonomic range.
```bash
# Keep only TaxIds at or below the Genus rank
taxonkit filter -L genus taxids.txt

# Keep only specific ranks
taxonkit filter -E species -E genus taxids.txt
```

### Lowest Common Ancestor (LCA)
Find the LCA for a set of TaxIds.
```bash
# Compute LCA for a space-separated list of IDs
echo "9606 9598" | taxonkit lca
```

## Expert Tips
- **Piping**: TaxonKit is designed for pipes. Most commands accept input from STDIN and append results as new columns to the input TSV data.
- **Rank Compatibility**: If working with Viruses or new NCBI ranks (like "clade" or "no rank"), prefer `reformat2` over `reformat`.
- **Performance**: For very large files, use the `--threads` flag to speed up processing.
- **Custom Taxonomies**: Use `create-taxdump` to convert custom taxonomies (like GTDB or ICTV) into NCBI-style dump files so they can be used with the rest of the TaxonKit suite.



## Subcommands

| Command | Description |
|---------|-------------|
| taxonkit cami-filter | Remove taxa of given TaxIds and their descendants in CAMI metagenomic profile |
| taxonkit create-taxdump | Create NCBI-style taxdump files for custom taxonomy, e.g., GTDB and ICTV |
| taxonkit filter | Filter TaxIds by taxonomic rank range |
| taxonkit genautocomplete | generate shell autocompletion script |
| taxonkit lca | Compute lowest common ancestor (LCA) for TaxIds |
| taxonkit lineage | Query taxonomic lineage of given TaxIds |
| taxonkit list | List taxonomic subtrees of given TaxIds |
| taxonkit name2taxid | Convert taxon names to TaxIds |
| taxonkit profile2cami | Convert metagenomic profile table to CAMI format |
| taxonkit reformat | Reformat lineage in canonical ranks |
| taxonkit reformat2 | Reformat lineage in chosen ranks, allowing more ranks than 'reformat' |
| taxonkit taxid-changelog | Create TaxId changelog from dump archives |
| taxonkit version | Prints the version of taxonkit |

## Reference documentation
- [TaxonKit GitHub README](./references/github_com_shenwei356_taxonkit_blob_master_README.md)
- [TaxonKit Changelog and Version Updates](./references/github_com_shenwei356_taxonkit_blob_master_CHANGELOG.md)