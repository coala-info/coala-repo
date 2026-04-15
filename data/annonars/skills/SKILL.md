---
name: annonars
description: annonars is a high-performance genome annotation toolset that transforms large genomic TSV files into optimized RocksDB key-value stores for fast variant lookups. Use when user asks to import variant annotations from TSV files, create local mirrors of datasets like CADD or dbNSFP, or build queryable genomic databases using SPDI representation.
homepage: https://github.com/bihealth/annona-rs
metadata:
  docker_image: "quay.io/biocontainers/annonars:0.44.1--h13c227e_0"
---

# annonars

## Overview

`annonars` is a high-performance genome annotation toolset written in Rust. It is designed to handle massive genomic datasets by transforming flat TSV files into optimized RocksDB key-value stores. By using the SPDI (Sequence Position Deletion Insertion) representation for variants, it enables extremely fast lookups of variant-specific scores and metadata. This tool is particularly useful for bioinformaticians who need to create local, queryable mirrors of large public datasets like CADD or dbNSFP to avoid the latency of remote API calls or the overhead of parsing multi-gigabyte text files.

## CLI Usage and Patterns

### Importing Variant Annotations

The primary workflow involves the `tsv import` command. This command parses input TSVs, infers data types, and builds the RocksDB structure.

#### Basic Import Template
```bash
annonars tsv import \
    --path-in-tsv <input_file.tsv.gz> \
    --path-out-rocksdb <output_dir> \
    --genome-release <grch37|grch38> \
    --db-name <name> \
    --db-version <version> \
    --col-chrom <chrom_col> \
    --col-start <pos_col> \
    --col-ref <ref_col> \
    --col-alt <alt_col>
```

#### Importing CADD Data
CADD files often contain copyright headers that must be skipped.
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
    --skip-row-count 1 \
    --add-default-null-values
```

#### Importing dbNSFP Data
Since dbNSFP is split across multiple files (one per chromosome), use shell expansion to include all files.
```bash
annonars tsv import \
    $(for f in dbNSFP4.4a_variant.*.gz; do echo --path-in-tsv $f; done) \
    --path-out-rocksdb dbnsfp-rocksdb \
    --genome-release grch38 \
    --db-name dbnsfp \
    --db-version 4.4a \
    --col-chrom "#chr" \
    --col-start pos\(1-based\) \
    --col-ref ref \
    --col-alt alt
```

## Expert Tips and Best Practices

### Schema Inference
*   **Row Count**: By default, `annonars` uses the first 100,000 rows to infer column types. If your data has sparse columns that only appear later in the file, increase this with `--inference-row-count`.
*   **Manual Seeds**: If inference fails or results in "Unknown" types, you can provide a JSON schema file as a seed to guide the importer.

### Performance and Storage
*   **Compaction**: At the end of an import, `annonars` automatically compacts the database. This is a heavy I/O operation but is critical for reducing disk space and enabling fast read-only access later.
*   **WAL Cleanup**: After a successful import, check the output directory for `.log` files (Write-Ahead Logs). If they are zero-sized, they can be safely deleted to keep the database directory clean.
*   **Genome Releases**: Always build separate RocksDB instances for different genome releases (e.g., one for GRCh37 and one for GRCh38).

### Feature Gates
*   When building from source, ensure the `cli` feature is enabled. The easiest way is to use:
    `cargo run --all-features -- [commands]`



## Subcommands

| Command | Description |
|---------|-------------|
| annonars clinvar-genes | clinvar-genes sub commands |
| annonars clinvar-minimal | clinvar-minimal sub commands |
| annonars clinvar-sv | clinvar-sv sub commands |
| annonars cons | "cons" sub commands |
| annonars db-utils | "db-utils" sub commands |
| annonars dbsnp | dbsnp sub commands |
| annonars freqs | "freqs" sub commands |
| annonars functional | "functional" sub commands |
| annonars gene | "genes" sub commands |
| annonars gnomad-mtdna | gnomad-mtdna sub commands |
| annonars gnomad-nuclear | gnomad-nuclear sub commands |
| annonars gnomad-sv | gnomad-sv sub commands for annonars |
| annonars helixmtdb | "helixmtdb" sub commands |
| annonars regions | "regions" sub commands |
| annonars server | "server" sub command |
| annonars tsv | annonars tsv subcommands for importing and querying TSV data |

## Reference documentation
- [Annonars README](./references/github_com_varfish-org_annonars_blob_main_README.md)