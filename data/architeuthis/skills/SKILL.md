---
name: architeuthis
description: Architeuthis is a bioinformatics utility designed to process, merge, and annotate taxonomic classification data from the Kraken suite. Use when user asks to merge sample outputs, annotate TaxIDs with lineage paths, analyze k-mer mapping reliability, or filter Kraken files based on classification consistency.
homepage: https://github.com/cdiener/architeuthis
metadata:
  docker_image: "quay.io/biocontainers/architeuthis:0.5.0--he881be0_0"
---

# architeuthis

## Overview

Architeuthis (the "giant squid") is a specialized utility designed to streamline bioinformatics pipelines involving the Kraken suite. It eliminates the need for custom scripts to handle common tasks such as combining sample outputs or expanding TaxIDs into full taxonomic paths. Its primary strengths lie in its speed and its ability to perform deep-dives into k-mer classifications to identify cross-domain matches or poorly resolved taxa.

## Core Workflows

### 1. Merging Sample Outputs
Efficiently combine multiple classification files into a single dataset. Architeuthis automatically detects the file type and adds a `sample_id` column based on the filename.

- **Bracken/CSV files**: `architeuthis merge -o merged_output.csv *.b2`
- **Kraken files**: `architeuthis merge -o merged.k2 sample1.k2 sample2.k2`

### 2. Lineage Annotation
Transform TaxIDs into human-readable taxonomic paths. This is most efficient when performed *after* merging multiple samples.

- **Basic annotation**: `architeuthis lineage input.b2 -o annotated.csv`
- **Custom format**: Use `--format` with taxonkit syntax (e.g., `"{genus};{species}"`).
- **Database source**: Use `--db /path/to/kraken_db` to ensure the taxonomy matches your classification run.

### 3. Mapping Analysis
Investigate the reliability of classifications by looking at individual k-mer assignments.

- **K-mer summary**: `architeuthis mapping kmers sample.k2 --out mappings.csv`
  - Useful for seeing if a "Bacterial" read actually contains "Human" k-mers.
- **Taxonomic summary**: `architeuthis mapping summary sample.k2 --out summary.csv`
  - Collapses mappings by rank to identify discordant classifications (where `in_lineage` is 0).

### 4. Quality Filtering
Filter Kraken output files (`.k2`) to retain only high-confidence reads based on k-mer distribution.

- **Filter command**:
  ```bash
  architeuthis mapping filter \
      --min-consistency 0.9 \
      --max-multiplicity 2 \
      --max-entropy 0.1 \
      --out filtered.k2 \
      input.k2
  ```
- **Metrics**:
  - **Consistency**: Fraction of k-mers matching the final read classification.
  - **Multiplicity**: Number of unique taxa matched at the same rank.
  - **Entropy**: Shannon index of k-mer assignments (abundance-weighted multiplicity).

## Expert Tips

- **Taxonomy Dumps**: If not using a Kraken DB, specify a local NCBI taxonomy directory using `--data-dir /path/to/taxdump/`.
- **Modified Domains**: Architeuthis uses a modified domain rank that merges "domain", "acellular root", and "superkingdom" to better support Viruses and various NCBI taxonomy versions.
- **Performance**: For large-scale studies, always `merge` first, then `lineage` to take advantage of internal taxonomy hashing.



## Subcommands

| Command | Description |
|---------|-------------|
| architeuthis completion | Generate the autocompletion script for the specified shell |
| architeuthis mapping | A tool for processing Kraken output, including filtering, k-mer summarization, and scoring. |
| architeuthis merge | Merge results using architeuthis |

## Reference documentation

- [Lineage annotation](./references/cdiener_github_io_architeuthis_lineage.md)
- [Mapping Analysis](./references/cdiener_github_io_architeuthis_mapping.md)
- [Filtering](./references/cdiener_github_io_architeuthis_filter.md)
- [Merging](./references/cdiener_github_io_architeuthis_merge.md)