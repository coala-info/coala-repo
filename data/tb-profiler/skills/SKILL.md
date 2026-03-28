---
name: tb-profiler
description: tb-profiler profiles Mycobacterium tuberculosis from whole genome sequencing data to determine lineages and predict drug resistance. Use when user asks to profile TB samples, predict phenotypic resistance, determine lineages, or update the resistance database.
homepage: https://github.com/jodyphelan/TBProfiler
---


# tb-profiler

## Overview

tb-profiler is a specialized bioinformatics pipeline designed to automate the profiling of Mycobacterium tuberculosis from Whole Genome Sequencing (WGS) data. It streamlines the process of aligning raw reads to the H37Rv reference genome, calling variants, and comparing those variants against a curated drug-resistance database. The tool is essential for researchers and clinicians needing to determine TB lineages and predict phenotypic resistance to first- and second-line drugs from genomic data.

## Core Workflows

### Database Initialization
Before running any analysis, ensure the resistance database is up to date. The tool and the database are developed independently.
```bash
tb-profiler update_tbdb
```

### Standard Profiling (Illumina Paired-End)
The most common use case involves paired FASTQ files. Use the `-p` flag to set a prefix for all output files (BAM, VCF, and results).
```bash
tb-profiler profile -1 reads_1.fastq.gz -2 reads_2.fastq.gz -p sample_name --txt
```

### Processing Nanopore (minION) Data
tb-profiler supports long-read data. Note that hetero-resistance prediction is generally not applicable for minION data.
```bash
tb-profiler profile --read1 nanopore_reads.fastq.gz --platform nanopore -p sample_name
```

## CLI Best Practices and Tips

### Performance Optimization
Use the `-t` or `--threads` option to speed up the alignment and variant calling stages, especially when processing large batches.
```bash
tb-profiler profile -1 R1.fq.gz -2 R2.fq.gz -p sample_id -t 8
```

### Output Management
*   **Default Output**: Results are stored in `results/sample_name.results.json`.
*   **Human-Readable Formats**: Always include `--txt` or `--csv` if you need to manually inspect results or share them with non-computational collaborators.
*   **Intermediate Files**: The pipeline produces `.bam` and `.vcf` files in their respective directories. These are useful for manual inspection in tools like IGV.

### Reproducibility
When reporting results, always document both the version of the `tb-profiler` software and the version of the database used, as resistance nomenclature and associations evolve.

### Alignment Options
While the tool defaults to sensible aligners, you can specify different mappers (bowtie2, bwa, or minimap2) depending on your specific requirements or read characteristics.



## Subcommands

| Command | Description |
|---------|-------------|
| load_library | Load a library into the tb-profiler database. |
| reformat | Sample prefix |
| tb-profiler batch | Run tb-profiler on multiple samples defined in a CSV file. |
| tb-profiler create_db | Create a database for tb-profiler |
| tb-profiler lineage | Lineage profiling for Mycobacterium tuberculosis |
| tb-profiler list_db | List available databases |
| tb-profiler profile | Profile TB samples |
| tb-profiler spoligotype | Spoligotyping analysis for TBProfiler |
| tb-profiler_collate | Collate results from TBProfiler runs. |
| update_tbdb | Update the TB-Profiler database |

## Reference documentation
- [Main README and Usage Guide](./references/github_com_jodyphelan_TBProfiler_blob_master_README.md)
- [Installation and Conda Overview](./references/anaconda_org_channels_bioconda_packages_tb-profiler_overview.md)