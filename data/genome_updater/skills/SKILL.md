---
name: genome_updater
description: Genome_updater automates the retrieval and management of genomic data from NCBI using snapshots to efficiently update local collections. Use when user asks to download genomic sequences, update local genome databases, filter assemblies by taxonomy or metadata, or create representative datasets with reduced redundancy.
homepage: https://github.com/pirovc/genome_updater
---


# genome_updater

## Overview
The `genome_updater` skill provides a streamlined workflow for interacting with the NCBI Genomes repository. It automates the retrieval of assembly summaries and the subsequent download of genomic sequences, annotations, and reports. Unlike simple download tools, it manages "snapshots," allowing you to update a local collection by only downloading new or changed files while using hard links for unchanged data to save disk space. It supports complex filtering by taxonomy (including GTDB integration), assembly level, and custom metadata fields.

## Core CLI Patterns

### Basic Download
To initialize a new local repository, specify the database, organism group, and desired file formats.
```bash
./genome_updater.sh -d "refseq" -g "bacteria" -l "complete genome" -f "genomic.fna.gz" -o "my_bacteria_db" -t 8
```

### Updating an Existing Snapshot
To update a repository, point to the same output directory. The tool reads `history.tsv` to resume or update the collection.
```bash
./genome_updater.sh -o "my_bacteria_db" -t 8
```

### Taxonomy-Specific Filtering
Use `-T` for specific TaxIDs or names. Use the `^` prefix to exclude specific taxa.
- **Specific TaxID**: `-T "562"` (E. coli)
- **Inclusion and Exclusion**: `-T "f__Enterobacteriaceae,^s__Escherichia coli"` (Requires `-M gtdb`)

### Redundancy Reduction
Limit the number of assemblies per taxonomic group to create representative datasets.
- **Per Leaf Node**: `-A 1` (One assembly per taxonomic leaf)
- **Per Genus**: `-A "genus:2"` (Two assemblies per genus)

### Advanced Metadata Filtering
Use `-F` to pass custom `awk` logic against the `assembly_summary.txt` columns.
- **Filter by BioProject**: `-F '$2 == "PRJNA12377"'`
- **Filter by Genome Size/Attribute**: `-F '$14 == "Full"'`

## Expert Tips & Best Practices

- **Dry Runs**: Always use the `-k` flag before a large download to see how many files will be retrieved and ensure your filters are correct.
- **Integrity Checks**: Use `-m` to perform MD5 checksum verification on all downloaded files.
- **Parallelization**: Adjust `-t` based on your network bandwidth and CPU; 8-12 threads is usually the sweet spot for NCBI's FTP limits.
- **Folder Structure**: By default, files are stored in a flat structure. Use `-N` to enforce the hierarchical NCBI FTP structure (`GCF/000/...`) if your downstream tools expect it.
- **GTDB Integration**: Use `-M gtdb` to filter assemblies based on the Genome Taxonomy Database standards rather than NCBI's default taxonomy.
- **Date Filtering**: Use `-D` (start date) and `-E` (end date) in `YYYYMMDD` format to capture genomes released within a specific window.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_pirovc_genome_updater.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_genome_updater_overview.md)