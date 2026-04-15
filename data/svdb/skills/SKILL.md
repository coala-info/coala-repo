---
name: svdb
description: SVDB is a utility for building structural variant databases, querying frequency information, and merging calls from multiple structural variant callers. Use when user asks to build a structural variant database from VCF files, annotate variants with frequency data, or merge overlapping calls from different algorithms.
homepage: https://github.com/J35P312/SVDB
metadata:
  docker_image: "quay.io/biocontainers/svdb:2.8.4--py311h7c5c6c8_0"
---

# svdb

## Overview
SVDB is a specialized utility for handling structural variant (SV) data in VCF format. It allows researchers to build local databases from their own cohorts, query public frequency databases to filter out common variants, and merge overlapping calls from different SV callers. It is particularly effective for reducing false positives by comparing new calls against a background of known variants or by requiring consensus between multiple algorithms.

## Core Modules and CLI Patterns

### Building a Database
Use the `--build` module to aggregate multiple VCF files into a single SQLite database. This is the standard way to create a "normal" or "cohort" background.

```bash
# Build a database from specific VCF files
svdb --build --vcf sample1.vcf sample2.vcf sample3.vcf --prefix my_cohort_db

# Build a database from all VCFs in a directory
svdb --build --folder /path/to/vcf_folder/ --prefix cohort_background
```

### Querying and Annotation
The `--query` module annotates a query VCF with frequency information from one or more databases. You can query SQLite databases (`--sqdb`) or multi-sample VCFs (`--db`).

```bash
# Annotate a patient VCF using a single database
svdb --query --query_vcf patient.vcf --sqdb cohort_background.db > annotated.vcf

# Query multiple databases simultaneously (requires specific tag mapping)
svdb --query --query_vcf patient.vcf \
     --db 1000G.vcf,gnomad.vcf \
     --in_occ AC,AN \
     --in_frq AF,AF \
     --out_occ 1K_AC,GN_AC \
     --out_frq 1K_AF,GN_AF \
     --prefix annotated_multi
```

### Merging SV Callers
Use the `--merge` module to combine outputs from different callers (e.g., Manta and TIDDIT) for the same sample. SVDB prioritizes calls based on the order of the input files.

```bash
# Merge calls from three different callers
svdb --merge --vcf manta.vcf tiddit.vcf delly.vcf > merged_calls.vcf
```

### Exporting Databases
To convert a SQLite database back into a VCF format for visualization or downstream analysis:

```bash
# Export with default 80% overlap clustering
svdb --export --db my_database.db --prefix exported_db

# Export using DBSCAN clustering for more complex variant clusters
svdb --export --db my_database.db --DBSCAN --epsilon 500 --min_pts 2
```

## Expert Tips and Best Practices

*   **Memory Optimization**: When querying large databases, use the `--memory` flag. This loads the database into RAM, significantly increasing speed at the cost of higher memory consumption.
*   **Overlap Sensitivity**: The default overlap requirement is 0.6 (60%) for querying and 0.8 (80%) for exporting. 
    *   Decrease `--overlap` (e.g., 0.5) if you want to be more aggressive in filtering variants.
    *   Increase `--overlap` (e.g., 0.9) if you only want to match variants that are nearly identical in coordinates.
*   **BND Handling**: For Breakends (BND), use `--bnd_distance` to define the search window. The default is 10,000bp for querying, but for high-precision callers, reducing this to 500-1000bp often yields better results.
*   **Type Matching**: By default, SVDB only matches variants of the same type (e.g., DEL to DEL). Use the `--no_var` flag during query if you want to count any overlapping variant as a hit regardless of the SV type.
*   **Tag Mapping**: When querying public VCFs, always check the INFO header of the database file to identify the correct allele count (OCC) and frequency (FRQ) tags (e.g., `AF`, `AC`, `AN`, `GNOMAD_AF`).

## Reference documentation
- [SVDB GitHub Repository](./references/github_com_J35P312_SVDB.md)
- [SVDB Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_svdb_overview.md)