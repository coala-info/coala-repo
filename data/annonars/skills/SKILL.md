---
name: annonars
description: annonars is a high-performance genome annotation tool built with Rust and RocksDB.
homepage: https://github.com/bihealth/annona-rs
---

# annonars

## Overview
annonars is a high-performance genome annotation tool built with Rust and RocksDB. It is designed to handle massive variant datasets by converting flat TSV files into indexed, queryable databases. This skill provides the necessary commands to build these databases from common sources like CADD or dbNSFP and perform efficient lookups using SPDI-style coordinates.

## Core Workflows

### Importing TSV Data
To import variant annotations into a RocksDB database, use the `tsv import` command. This process requires specifying the genome release and mapping the relevant columns.

**Example: Importing CADD data**
```bash
annonars tsv import \
  --path-in-tsv InDels_inclAnno.tsv.gz \
  --path-in-tsv whole_genome_SNVs_inclAnno.tsv.gz \
  --path-out-rocksdb cadd-rocksdb \
  --genome-release grch37 \
  --db-name cadd \
  --db-version 1.6 \
  --col-chrom Chrom \
  --col-start Pos \
  --col-ref Ref \
  --col-alt Alt \
  --skip-row-count=1 \
  --inference-row-count 100000 \
  --add-default-null-values
```

**Example: Importing dbNSFP data**
```bash
annonars tsv import \
  $(for f in dbNSFP4.4a_variant.*.gz; do echo --path-in-tsv $f; done) \
  --path-out-rocksdb dbnsfp-rocksdb \
  --genome-release grch37 \
  --db-name dbnsfp \
  --db-version 4.4a \
  --col-chrom hg19_chr \
  --col-start "hg19_pos(1-based)" \
  --col-ref ref \
  --col-alt alt \
  --inference-row-count 100000 \
  --null-values=.
```

### Querying Databases
Queries use SPDI-style coordinates (1-based, inclusive). You can query by specific variant, position, or range.

*   **Variant Query:** `tsv query --path-rocksdb path/to/db --range GRCh37:1:1000:A:T`
*   **Position Query:** `tsv query --path-rocksdb path/to/db --pos GRCh37:1:1000`
*   **Region Query:** `tsv query --path-rocksdb path/to/db --range GRCh37:1:1000:1001`

## Expert Tips & Best Practices

*   **Parallel Import:** If `.tbi` (tabix) files exist for your input TSVs, annonars will automatically perform a parallel window-based import. Without indices, it will still process files in parallel but read them sequentially.
*   **Performance Tuning:** Control the number of threads used for database building by setting the `RAYON_NUM_THREADS` environment variable.
*   **Schema Inference:** Use a high `--inference-row-count` (e.g., 100,000) to ensure data types are correctly detected. If "Unknown" types appear in the resulting JSON schema, provide a manual JSON schema seed.
*   **Database Maintenance:** After import, annonars compacts the database. Once finished, check the output directory for `.log` files (Write-Ahead Logs); if they are zero-sized, they can be safely deleted to save space.
*   **Coordinate Systems:** Always verify if your input TSV is 0-based or 1-based. annonars expects 1-based inclusive coordinates for its internal SPDI representation.

## Reference documentation
- [GitHub Repository and README](./references/github_com_varfish-org_annonars.md)