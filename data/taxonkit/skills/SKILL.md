---
name: taxonkit
description: TaxonKit is a high-performance command-line toolkit designed for processing NCBI taxonomy data.
homepage: https://github.com/shenwei356/taxonkit
---

# taxonkit

## Overview
TaxonKit is a high-performance command-line toolkit designed for processing NCBI taxonomy data. It is particularly useful for bioinformatics workflows that require mapping TaxIDs to full lineages, filtering datasets by taxonomic rank, or standardizing inconsistent taxonomy strings. It operates on local dump files from NCBI, ensuring speed and privacy without requiring constant API calls.

## Setup and Data Management
TaxonKit requires the NCBI `taxdump` files to function.
1.  **Download Data**: Obtain `taxdump.tar.gz` from NCBI FTP.
2.  **Storage**: By default, TaxonKit looks in `$HOME/.taxonkit`. You can override this using the `TAXONKIT_DB` environment variable or the `--data-dir` flag.
3.  **Required Files**: Ensure `names.dmp`, `nodes.dmp`, `delnodes.dmp`, and `merged.dmp` are present in the data directory.

## Common CLI Patterns

### Lineage Retrieval
Retrieve the full taxonomic lineage for a list of TaxIDs.
```bash
# Input can be a file or stdin
echo "9606" | taxonkit lineage
```
*   **Tip**: Use `--show-name` and `--show-rank` to include human-readable names and ranks alongside TaxIDs in the output.

### Standardizing Ranks (Reformatting)
Convert raw lineages into a fixed 7-level format (Superkingdom, Phylum, Class, Order, Family, Genus, Species).
```bash
# Reformat lineage from column 2 of a file
taxonkit lineage input.txt | taxonkit reformat -i 2
```
*   **Missing Ranks**: Use `-f` to define a custom format string and `-r` to specify a placeholder for missing ranks (e.g., `Unclassified`).

### Name to TaxID Conversion
Convert scientific names to NCBI TaxIDs.
```bash
echo "Homo sapiens" | taxonkit name2taxid
```

### Lowest Common Ancestor (LCA)
Find the LCA for a set of TaxIDs.
```bash
echo "9606 9598" | taxonkit lca
```

### Filtering by Rank
Filter a list of TaxIDs to keep only those within a specific rank range (e.g., at or below Genus).
```bash
taxonkit filter --lower-lineage-rank genus input_taxids.txt
```

## Expert Tips
*   **Pipe Integration**: TaxonKit is designed for shell pipes. It reads from `stdin` by default if no file is provided.
*   **Performance**: Use the `-j` or `--threads` flag to utilize multiple CPU cores for large datasets.
*   **Custom Taxonomies**: TaxonKit supports creating NCBI-style taxdump files for custom taxonomies (like GTDB or ICTV) using the `create-taxdump` subcommand.
*   **Handling Merged TaxIDs**: TaxonKit automatically handles merged TaxIDs using `merged.dmp`, ensuring that deprecated IDs are mapped to their current versions.

## Reference documentation
- [TaxonKit GitHub Repository](./references/github_com_shenwei356_taxonkit.md)
- [Bioconda TaxonKit Overview](./references/anaconda_org_channels_bioconda_packages_taxonkit_overview.md)