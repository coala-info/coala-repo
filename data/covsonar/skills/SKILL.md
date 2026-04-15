---
name: covsonar
description: covsonar is a database-driven framework for the large-scale alignment, storage, and screening of SARS-CoV-2 genomic sequences. Use when user asks to import viral genomes into a searchable database, update metadata with Pangolin lineages, or match specific amino acid and nucleotide mutations.
homepage: https://github.com/rki-mf1/covsonar
metadata:
  docker_image: "quay.io/biocontainers/covsonar:2.0.0a1--pyhdfd78af_0"
---

# covsonar

## Overview
covsonar is a database-driven framework designed for the large-scale handling and screening of SARS-CoV-2 genomic sequences. It streamlines the process of aligning sequences to the Wuhan-Hu-1 reference (NC_045512.2), storing them in a searchable SQLite format, and querying them based on specific amino acid or nucleotide mutations. It is particularly useful for genomic surveillance, allowing users to track the emergence of variants and manage metadata across thousands of viral genomes.

## Core Workflows

### 1. Database Initialization and Data Import
Genomes are added from FASTA files. The tool performs pairwise alignment using EMBOSS Stretcher.

*   **Basic Import**: `python sonar.py add -f genomes.fasta --db mydb.sqlite`
*   **Performance Optimization**: Use `--cpus` to parallelize alignment and `--cache` to persist intermediate files, which is useful if an import is interrupted.
    *   `python sonar.py add -f genomes.fasta --db mydb.sqlite --cpus 8 --cache ./import_cache`
*   **Quiet Mode**: Use `--noprogress` or `--quiet` when running in automated pipelines to prevent verbose progress bar output.

### 2. Metadata Management
Metadata can be imported from Pangolin CSVs or custom TSV/CSV files.

*   **Pangolin Lineages**: `python sonar.py update --pangolin pangolin.csv --db mydb.sqlite`
*   **Custom Metadata**: Map CSV columns to database fields using the `--fields` argument.
    *   `python sonar.py update --csv data.csv --fields accession=ID lineage=Lineage zip=PostalCode date=CollectionDate --db mydb.sqlite`
*   **Supported Fields**: `accession`, `lineage`, `zip`, `date` (YYYY-MM-DD), `lab`, `source`, `collection`, `technology`, `platform`, `ct`, and `submission_date`.

### 3. Genomic Profile Matching
The `match` command is the primary tool for screening the database for specific variants.

*   **Nucleotide SNPs**: `python sonar.py match --profile A3451T --db mydb.sqlite`
*   **Amino Acid Mutations**: Specify the protein symbol followed by the mutation.
    *   `python sonar.py match --profile S:N501Y --db mydb.sqlite`
*   **Deletions**: Use the format `del:pos:length`.
    *   `python sonar.py match --profile del:21765:6 --db mydb.sqlite`
*   **Complex Queries**: Combine multiple mutations in a single profile.
    *   `python sonar.py match --profile "S:N501Y S:E484K" --db mydb.sqlite`

## Expert Tips and Best Practices

*   **Sublineage Expansion**: When querying by lineage, use `--with-sublineage` to automatically include all descendant lineages in the results.
*   **Bulk Arguments**: For large queries, provide arguments in a file using the `@` prefix.
    *   `python sonar.py match --lineage @lineages_of_interest.txt --db mydb.sqlite`
*   **Database Maintenance**: Periodically run `python sonar.py optimize --db mydb.sqlite` to shrink the database file size and improve query performance after large deletions or updates.
*   **Sequence Retrieval**: Use the `restore` command to export specific sequences back to FASTA format based on their database accessions.
*   **Version Compatibility**: If upgrading covsonar, run `python sonar.py db-upgrade --db mydb.sqlite` to ensure the database schema is compatible with the latest tool features.

## Reference documentation
- [covsonar GitHub Repository](./references/github_com_rki-mf1_covsonar.md)
- [covsonar Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_covsonar_overview.md)