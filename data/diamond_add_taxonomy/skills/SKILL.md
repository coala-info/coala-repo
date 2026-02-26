---
name: diamond_add_taxonomy
description: This tool appends taxonomic lineage information to DIAMOND alignment files by looking up TaxIDs in the NCBI taxonomy database. Use when user asks to annotate DIAMOND output with taxonomic ranks, add lineage information to protein hits, or enrich alignment data with biological context.
homepage: https://github.com/pvanheus/diamond_add_taxonomy
---


# diamond_add_taxonomy

## Overview
The `diamond_add_taxonomy` tool is a utility designed to enrich DIAMOND alignment data with biological context. While DIAMOND can output TaxIDs, interpreting those IDs requires a lookup against the NCBI taxonomy database. This tool automates that lookup, appending seven standard taxonomic columns (superkingdom, phylum, class, order, family, genus, and species) to each hit in the alignment file. It is essential for metagenomic workflows where taxonomic classification of protein hits is required.

## Command Line Usage

### Basic Annotation
To annotate a standard DIAMOND output file that already contains the `staxids` field:
```bash
diamond_add_taxonomy --output_file annotated_results.tsv diamond_output.tsv
```

### Handling Custom DIAMOND Formats
If you used a custom `--outfmt 6` string in DIAMOND, you must provide that exact format string to the tool so it can locate the `staxids` column:
```bash
diamond_add_taxonomy --diamond_output_format "qseqid sseqid pident length staxids evalue" --output_file annotated.tsv input.tsv
```

### Optimizing Performance with Local Databases
By default, the tool may attempt to download the NCBI taxonomy database via `ete3`. To avoid network latency and repeated downloads, provide paths to local taxonomy files:
```bash
diamond_add_taxonomy --taxdump_filename /path/to/taxdump.tar.gz --taxdb_filename /path/to/taxonomy.sqlite diamond_output.tsv
```

## Best Practices and Expert Tips

*   **DIAMOND Pre-requisite**: Ensure your DIAMOND run was executed with `staxids` included in the `--outfmt 6` specification. Without the TaxID column, this tool cannot perform the lookup.
*   **Database Initialization**: The first time you run the tool without a local database, it will download several hundred megabytes of data. For high-throughput environments, pre-build the sqlite3 database using `ete3 NCBITaxa` and point to it using `--taxdb_filename`.
*   **Output Structure**: The tool appends the 7 taxonomic columns to the *right-hand side* of your existing TSV data. This preserves your original DIAMOND metrics while adding the lineage info.
*   **Standard Ranks**: Note that the tool specifically extracts the "standard" ranks. If a specific hit belongs to a non-standard rank (e.g., sub-family), the tool will resolve the lineage to the nearest standard parent rank defined in the NCBI schema.
*   **Memory Considerations**: While the tool is generally efficient, the underlying `ete3` sqlite3 database can be several gigabytes. Ensure the filesystem containing the `--taxdb_filename` has sufficient space.

## Reference documentation
- [diamond_add_taxonomy Overview](./references/anaconda_org_channels_bioconda_packages_diamond_add_taxonomy_overview.md)
- [diamond_add_taxonomy GitHub Documentation](./references/github_com_pvanheus_diamond_add_taxonomy.md)