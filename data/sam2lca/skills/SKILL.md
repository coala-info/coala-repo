---
name: sam2lca
description: sam2lca identifies the lowest common ancestor for reads that align to multiple reference sequences to provide accurate taxonomic classification. Use when user asks to resolve taxonomic ambiguity in sequencing data, analyze alignments for taxonomic assignment, or add taxonomic tags to BAM files.
homepage: https://github.com/maxibor/sam2lca
---


# sam2lca

## Overview
sam2lca is a specialized bioinformatics tool designed to resolve taxonomic ambiguity in sequencing data. When a single read aligns to multiple reference sequences representing different organisms, sam2lca identifies the Lowest Common Ancestor (LCA) in the taxonomic tree to provide a conservative and accurate classification. It is particularly useful in metagenomics and environmental DNA (eDNA) workflows where reads often map to multiple related species.

## Core Workflows

### Database Management
Before analyzing alignments, the taxonomic database must be initialized or updated. sam2lca supports NCBI, GTDB, and custom taxonomies.

- **List available databases**: `sam2lca list-db`
- **Update or create a database**: `sam2lca update-db --db <database_name>`
  - Common database names include `ncbi`, `gtdb`, and `18s`.

### Analyzing Alignments
The primary command is `analyze`, which processes alignment files and produces taxonomic assignments.

- **Basic analysis**:
  `sam2lca analyze input.bam`
- **Filter by sequence identity**:
  Use the `--min-identity` flag to ignore low-quality alignments (e.g., 0.90 to 1.0).
  `sam2lca analyze input.bam --min-identity 0.95`
- **Filter by edit distance**:
  Use `--max-edit-dist` to limit the number of allowed mismatches.
  `sam2lca analyze input.bam --max-edit-dist 2`

### Advanced Output Options
sam2lca can modify the alignment files themselves to include taxonomic metadata.

- **Add taxonomic tags to BAM**:
  The tool can add `XN` (Taxon Name) and `XR` (Taxon Rank) flags to each alignment record.
- **Split BAM by Taxonomy**:
  Generate separate BAM files for different taxonomic groups at a specific rank (e.g., genus or family).
  `sam2lca analyze input.bam --split-by-rank genus`

## Expert Tips
- **Unclassified Reads**: By default, reads that cannot be assigned are given the TAXID `12908`.
- **Performance**: The tool utilizes multithreading on shared dictionaries. Ensure your environment has sufficient memory when working with large taxonomic databases like NCBI.
- **Custom Mappings**: You can provide custom accession-to-taxid mappings using JSON files via the `update-db` command.
- **Progress Tracking**: For large files, sam2lca calculates the total read count early to provide an accurate progress bar during processing.



## Subcommands

| Command | Description |
|---------|-------------|
| analyze | Run the sam2lca analysis |
| update-db | Download/prepare acc2tax and taxonomy databases |

## Reference documentation
- [sam2lca README](./references/github_com_maxibor_sam2lca_blob_master_README.md)
- [sam2lca Changelog](./references/github_com_maxibor_sam2lca_blob_master_CHANGELOG.md)