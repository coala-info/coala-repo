---
name: bioconductor-metascope
description: MetaScope performs strain-level metagenomic profiling and taxonomic identification of microbial sequencing data using a Bayesian read reassignment model. Use when user asks to perform taxonomic classification, create reference genome libraries, align reads to microbial targets, filter host contaminants, or identify microbial strains from metagenomic samples.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MetaScope.html
---

# bioconductor-metascope

name: bioconductor-metascope
description: Metagenomic profiling and strain-level identification of microbes using the MetaScope R package. Use this skill when you need to perform taxonomic classification, demultiplexing, reference genome library creation, and Bayesian read reassignment for metagenomic sequencing data.

## Overview

MetaScope is a Bioconductor package for accurate metagenomic profiling at strain-level resolution. It provides a complete workflow from raw reads to microbial composition reports, utilizing either `Rbowtie2` or `Rsubread` for alignment. Its core strength is a Bayesian reassignment model that resolves mapping ambiguities by using uniquely aligned reads to guide the placement of multi-mapped reads.

## Core Workflow

### 1. Setup and Taxonomy Database
Before running samples, you must initialize a taxonomy database. This is a one-time setup step.

```r
library(MetaScope)

# Download NCBI accession and taxonomy data
download_accessions(
  ind_dir = "path/to/indices",
  NCBI_accessions_database = TRUE,
  NCBI_accessions_name = "accessionTaxa.sql"
)
```

### 2. Reference Library Creation (MetaRef)
Identify "target" species (microbes) and "filter" species (host/contaminants).

```r
# Download specific genomes
download_refseq(
  taxon = "Staphylococcus aureus",
  reference = TRUE,
  representative = FALSE,
  out_dir = "target_dir",
  accession_path = "path/to/accessionTaxa.sql"
)

# Create Bowtie2 indices
mk_bowtie_index(
  ref_dir = "target_dir",
  lib_dir = "index_dir",
  lib_name = "target_index"
)
```

### 3. Alignment (MetaAlign & MetaFilter)
Align reads to targets, then remove reads that map to the host/filter library.

```r
# Align to targets
target_bam <- align_target_bowtie(
  read1 = "reads.fastq",
  lib_dir = "index_dir",
  libs = "target_index",
  align_dir = "output_dir",
  align_file = "sample_target"
)

# Filter out host reads
final_bam <- filter_host_bowtie(
  reads_bam = target_bam,
  lib_dir = "index_dir",
  libs = "host_index",
  make_bam = TRUE
)
```

### 4. Strain Identification (MetaID)
Reassign ambiguously mapped reads to the most probable source genome.

```r
# Run Bayesian reassignment
results <- metascope_id(
  final_bam,
  input_type = "bam",
  aligner = "bowtie2",
  accession_path = "path/to/accessionTaxa.sql"
)

# 'results' is a data frame containing:
# Genome, read_count, and Proportion
```

## Key Functions and Parameters

- `meta_demultiplex()`: Optional step to separate pooled samples based on barcodes.
- `download_refseq()`: Use `taxon` names (e.g., "bacteria", "viruses", or specific species). Set `caching = TRUE` to avoid redundant downloads.
- `align_target_bowtie()` vs `align_target()`: Use the former for Bowtie2 and the latter for Rsubread workflows.
- `metascope_id()`: The primary identification function. It assumes reference names in the BAM file are NCBI accessions.

## Tips for Success

- **Samtools**: While not strictly required, having `samtools` installed on the system path significantly speeds up BAM processing.
- **Disk Space**: If disk space is limited, set `make_bam = FALSE` in `filter_host_bowtie()` to produce a compressed CSV (`.csv.gz`) instead of a BAM file; `metascope_id()` can accept this CSV as input.
- **Memory**: Reference indexing and alignment are memory-intensive. Ensure the R session has sufficient RAM for the size of the reference genomes being used.

## Reference documentation

- [Introduction to MetaScope](./references/MetaScope_vignette.md)