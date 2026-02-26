---
name: ganon
description: Ganon is a high-performance genomic sequence classifier that uses k-mer based indexing and Bloom filters for fast taxonomic assignment of metagenomic reads. Use when user asks to build taxonomic databases, classify sequencing reads, generate abundance reports with genome size correction, or create contingency tables for multiple samples.
homepage: https://github.com/pirovc/ganon
---


# ganon

## Overview

Ganon (v2+) is a high-performance genomic sequence classifier designed to handle massive reference sets. It utilizes k-mer based indexing and Bloom filters to provide fast and memory-efficient taxonomic assignments. The tool manages the entire metagenomics pipeline, including automated reference genome retrieval, database construction, read classification using EM or LCA algorithms, and advanced reporting with genome size correction.

## Common CLI Patterns

### Installation
Install ganon via bioconda to ensure all dependencies (like SeqAn3) are correctly managed:
```bash
conda install -c bioconda -c conda-forge ganon
```

### Database Construction
Ganon can automatically download and build databases for specific organism groups.

**Build an Archaea database from RefSeq:**
```bash
ganon build --db-prefix archaea_db \
    --source refseq \
    --organism-group archaea \
    --complete-genomes \
    --threads 24
```

**Build a custom database from local FASTA files:**
```bash
ganon build --db-prefix custom_db \
    --input-files references/*.fasta \
    --taxonomy ncbi \
    --threads 12
```

### Sequence Classification
Classify sequencing reads against one or more pre-built databases.

**Classify paired-end reads:**
```bash
ganon classify --db-prefix archaea_db \
    --paired-reads reads.1.fq.gz reads.2.fq.gz \
    --output-prefix classification_results \
    --threads 24
```

**Hierarchical classification (multiple databases):**
Ganon can run multiple databases in a single command, which is useful for tiered searches (e.g., screening against human contamination before microbial classification).
```bash
ganon classify --db-prefix human_db microbial_db \
    --single-reads sample.fq.gz \
    --output-prefix multi_level_results
```

### Reporting and Profiling
Transform raw classification results into human-readable taxonomic profiles.

**Generate a taxonomic report with genome size correction:**
```bash
ganon report --input-prefix classification_results \
    --db-prefix archaea_db \
    --output-report sample_report.tre \
    --report-type abundance \
    --genome-size-correction
```

**Create a contingency table for multiple samples:**
```bash
ganon table --input-files sample1.rep sample2.rep \
    --output-file study_comparison.tsv \
    --output-format tsv
```

## Expert Tips and Best Practices

- **Memory Management**: Ganon uses Bloom filters. If you encounter memory constraints during `build`, consider adjusting the `--filter-type` or increasing the number of filters.
- **Taxonomy Support**: Ganon natively supports both NCBI and GTDB taxonomies. Ensure you specify the correct `--taxonomy` flag during the `build` and `report` stages to match your reference source.
- **Algorithm Selection**: Use the EM (Expectation-Maximization) algorithm for more accurate abundance estimation at lower taxonomic ranks, or LCA (Lowest Common Ancestor) for more conservative assignments.
- **Incremental Updates**: Ganon supports updating existing databases with new genomic sequences without rebuilding from scratch, saving significant computational time.
- **Thread Scaling**: Most ganon commands scale well with threads. For large-scale classification, ensure `--threads` matches your available CPU cores to maximize throughput.

## Reference documentation
- [ganon - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ganon_overview.md)
- [pirovc/ganon: ganon2 classifies genomic sequences against large sets of references efficiently](./references/github_com_pirovc_ganon.md)