---
name: ntm-profiler
description: "NTM-Profiler identifies Non-Tuberculous Mycobacteria species and detects drug resistance mutations from genomic data. Use when user asks to identify NTM species, detect drug resistance mutations, profile genomic sequences, or collate results from multiple samples."
homepage: https://github.com/jodyphelan/NTM-Profiler
---


# ntm-profiler

## Overview

NTM-Profiler is a specialized bioinformatics pipeline designed to characterize Non-Tuberculous Mycobacteria from genomic data. It utilizes a kmer-based approach for rapid species identification and an alignment-based workflow for detecting drug resistance mutations. The tool is particularly effective for identifying members of the *Mycobacteroides abscessus* complex and *Mycobacterium leprae*. It supports multiple input formats and provides utilities for collating results across large cohorts.

## Installation and Database Setup

Before running analysis, ensure the environment is ready and the latest species/resistance databases are downloaded.

```bash
# Install via conda/mamba
mamba install bioconda::ntm-profiler

# Download or update the required databases (Required before first run)
ntm-profiler update_db
```

## Common CLI Patterns

### Species and Resistance Profiling

The `profile` command is the primary entry point. It accepts various input types and requires a sample prefix (`-p`).

**1. Raw Sequencing Reads (Fastq)**
```bash
ntm-profiler profile -1 reads_1.fastq.gz -2 reads_2.fastq.gz -p sample_id --threads 8 --txt
```

**2. Aligned Data (BAM/CRAM)**
Note: Chromosome names in the alignment must match the NTM-Profiler reference.
```bash
ntm-profiler profile -a alignment.bam -p sample_id
```

**3. Assembled Genomes (Fasta)**
```bash
ntm-profiler profile -f assembly.fasta -p sample_id
```

**4. Variant Calls (VCF)**
```bash
ntm-profiler profile --vcf variants.vcf -p sample_id
```

### Summarizing Multiple Runs

To aggregate results from a directory containing multiple individual run outputs into a single table:

```bash
# Collate all results in the current directory
ntm-profiler collate --prefix study_summary

# Collate a specific subset of samples
ntm-profiler collate --samples sample_list.txt --prefix subset_summary
```

## Expert Tips and Best Practices

- **Performance**: Always specify `--threads` to utilize multi-core processing, especially during the alignment phase of resistance prediction.
- **Platform Specification**: If using Nanopore data, specify `--platform nanopore` (default is `illumina`).
- **Output Formats**: By default, the tool produces JSON. Use the `--txt` flag to generate a human-readable text report alongside the JSON.
- **Resistance Support**: Currently, full resistance prediction is available for *M. leprae* and the *M. abscessus* complex (subsp. *abscessus*, *bolletii*, and *massiliense*). For other species, the tool will primarily provide identification.
- **Database Synchronization**: If you are using BAM or VCF files generated outside of NTM-Profiler, ensure the reference genome used for the initial alignment matches the one in the NTM-Profiler database to avoid coordinate mismatches.

## Custom Database Management

You can extend the tool with custom species kmers or resistance mutations.

**Create Species Database:**
```bash
ntm-profiler create_species_db --kmers species_kmers.txt --prefix ntmdb --load
```

**Create Resistance Database:**
Requires a reference genome (`genome.fasta`), annotation (`genome.gff`), and a mutation CSV.
```bash
ntm-profiler create_resistance_db --csv mutations.csv --prefix species_name --load
```



## Subcommands

| Command | Description |
|---------|-------------|
| create_resistance_db | Create a resistance database for ntm-profiler. |
| ntm-profiler collate | Collate results from ntm-profiler runs. |
| ntm-profiler create_species_db | Create a species database for ntm-profiler. |
| ntm-profiler list_db | List available databases |
| ntm-profiler profile | Profile NTM samples |
| update_db | Update the ntm-profiler database. |

## Reference documentation
- [NTM-Profiler Main Documentation](./references/github_com_jodyphelan_NTM-Profiler_blob_main_README.md)
- [Environment and Dependencies](./references/github_com_jodyphelan_NTM-Profiler_blob_main_env.yml.md)