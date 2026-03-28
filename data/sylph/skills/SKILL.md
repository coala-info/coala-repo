---
name: sylph
description: Sylph performs rapid metagenomic profiling and containment ANI estimation using abundance-corrected k-mer sketching. Use when user asks to sketch sequencing data, profile metagenomic samples for taxonomic abundance, or perform ANI queries against reference databases.
homepage: https://github.com/bluenote-1577/sylph
---

# sylph

## Overview

Sylph is a high-performance bioinformatics tool designed for the rapid analysis of metagenomic samples. It utilizes an abundance-corrected minhash approach to overcome the biases typically associated with low-coverage k-mer containment methods. Use this skill to transform raw sequencing reads into taxonomic profiles or to perform containment ANI queries against large reference databases (like GTDB) with minimal memory overhead.

## Core Workflows

### 1. Sketching Data
Before querying or profiling, raw sequences must be converted into sketches.
- **FASTQ files** (reads) become `.sylsp` (sample) files.
- **FASTA files** (genomes) become `.syldb` (database) files.

```bash
# Sketch reads and genomes into a database prefix
sylph sketch reads.fastq genomes.fasta -o my_database
```

### 2. Metagenomic Profiling
Use `profile` to determine the species present in a sample and their relative abundances. This is the preferred command for standard metagenomic classification.

```bash
# Profile a sample against a pre-built database
sylph profile gtdb-r220.syldb sample.fastq.gz -t 8 > profiling_results.tsv

# Multi-sample paired-end profiling
sylph profile db.syldb -1 R1.fq.gz -2 R2.fq.gz -t 16 > results.tsv
```

### 3. ANI Querying
Use `query` to find the similarity between a specific reference genome and your metagenomic sample. This provides "containment ANI," indicating how closely a queried genome matches the best-matching organism in the sample.

```bash
# Query a specific sample sketch against a database sketch
sylph query sample.sylsp database.syldb
```

### 4. Taxonomic Annotation
Sylph's native output is a TSV with genome identifiers. To add full taxonomic lineages, use the companion tool `sylph-tax`.

```bash
# Convert sylph output to a taxonomic profile (.sylphmpa)
sylph-tax taxprof results.tsv -t GTDB_r220
```

## Expert Tips and Best Practices

- **Handle Low Coverage**: Sylph is accurate down to 0.1x coverage. If you see a high `Adjusted_ANI` but low `Eff_cov`, the organism is likely present at low abundance.
- **Interpret ANI Metrics**: 
    - `Adjusted_ANI`: The primary similarity metric, corrected for sequencing depth and error.
    - `Naive_ANI`: The uncorrected estimate (similar to Mash/Sourmash); usually biased downward at low coverage.
- **Database Selection**: For general metagenomics, use the pre-built GTDB (Genomic Taxonomy Database) representatives to ensure species-level dereplication and reduce false positives.
- **Memory Management**: Profiling against the entire GTDB-R220 (~110k genomes) requires only ~15GB of RAM, making it suitable for standard workstations.
- **Sequencing Errors**: `Eff_cov` (Effective Coverage) may be lower than the raw depth because sequencing errors invalidate k-mers. This is expected behavior.



## Subcommands

| Command | Description |
|---------|-------------|
| sylph inspect | Inspect sketched .syldb and .sylsp files |
| sylph profile | Species-level taxonomic profiling with abundances and ANIs |
| sylph query | Coverage-adjusted ANI querying between databases and samples |
| sylph sketch | Sketch sequences into samples (reads) and databases (genomes). Each sample.fq -> sample.sylsp. All *.fa -> *.syldb |

## Reference documentation

- [Sylph Main Documentation](./references/github_com_bluenote-1577_sylph.md)
- [5-minute Sylph Tutorial](./references/github_com_bluenote-1577_sylph_wiki_5_E2_80_90minute-sylph-tutorial.md)
- [Taxonomic Integration with sylph-tax](./references/github_com_bluenote-1577_sylph_wiki_Incorporating-taxonomic-information-into-sylph-with-sylph_E2_80_90tax.md)
- [Sylph Cookbook](./references/github_com_bluenote-1577_sylph_wiki_sylph-cookbook.md)