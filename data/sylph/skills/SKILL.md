---
name: sylph
description: Sylph performs high-throughput metagenomic profiling and containment ANI estimation using an abundance-corrected MinHash approach. Use when user asks to profile metagenomic reads against a database, estimate species-level abundance in low-coverage samples, or sketch custom genomes for database preparation.
homepage: https://github.com/bluenote-1577/sylph
---


# sylph

## Overview
Sylph is a bioinformatics tool designed for high-throughput metagenomic analysis. It utilizes an abundance-corrected MinHash approach to provide precise species-level profiling and containment ANI estimates. Unlike traditional k-mer counters, sylph remains accurate even for low-abundance organisms (down to 0.1x coverage) by accounting for the statistical properties of k-mer containment in low-depth sequencing. It is optimized for speed and memory efficiency, capable of profiling samples against over 100,000 genomes in seconds using approximately 15GB of RAM.

## Installation
The recommended way to install sylph is via Bioconda:
```bash
conda install -c bioconda sylph
```

## Common CLI Patterns

### Metagenomic Profiling
To profile metagenomic reads against a pre-built database (e.g., GTDB):

**Paired-end reads:**
```bash
sylph profile database.syldb -1 sample_R1.fastq.gz -2 sample_R2.fastq.gz -t 8 > profiling_output.tsv
```

**Single-end or long reads (Oxford Nanopore/PacBio):**
```bash
sylph profile database.syldb sample.fastq.gz -t 8 > profiling_output.tsv
```

**Multiple samples (Batch processing):**
Sylph can process multiple files at once. It treats each input file (or pair) as a separate sample in the output TSV.
```bash
sylph profile database.syldb *.fastq.gz -t 16 > combined_results.tsv
```

### Database Preparation
If you have custom genomes (e.g., MAGs or specific reference sets) and want to create a searchable database:

1. **Sketch the genomes:**
```bash
sylph sketch genomes/*.fa -o custom_db
```
2. **Profile against the custom database:**
```bash
sylph profile custom_db.syldb reads.fastq.gz
```

## Expert Tips and Best Practices

### Handling Low Coverage
Sylph's primary advantage is its "abundance-corrected" containment estimation. If you are working with ancient DNA or highly complex environmental samples where coverage is extremely low, ensure you are using the latest version (v0.9.0+) as it includes improved help messages and parameter guidance for damaged DNA.

### Memory Management
While sylph is memory-efficient, the `inspect` option in older versions was memory-intensive. If you need to examine database contents, use version 0.8.0 or later, which optimized this feature.

### Taxonomic Integration
The raw output of `sylph profile` provides ANI and containment data. To get standard taxonomic lineages (Domain to Species), use the companion tool `sylph-tax`. This is necessary for generating MetaPhlAn-like output formats.

### Choosing the Right Database
- **GTDB-R220:** The standard for bacterial and archaeal profiling.
- **Custom MAGs:** Useful for site-specific studies where you want to see if your specific bins are present in other samples.

## Output Interpretation
The output is a TSV file. Key columns to monitor:
- **Containment_ANI:** The estimated ANI between the reference genome and the best-match organism in your sample.
- **Sequence_Abundance:** The relative proportion of the sequencing depth attributed to that specific genome.
- **True_Abundance:** The estimated taxonomic abundance, corrected for genome size and k-mer redundancy.

## Reference documentation
- [Sylph Main Repository](./references/github_com_bluenote-1577_sylph.md)
- [Sylph Wiki and Tutorials](./references/github_com_bluenote-1577_sylph_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_sylph_overview.md)