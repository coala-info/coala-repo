---
name: ntm-profiler
description: The ntm-profiler tool is a specialized bioinformatic pipeline designed to characterize Non-Tuberculous Mycobacteria from genomic data.
homepage: https://github.com/jodyphelan/NTM-Profiler
---

# ntm-profiler

## Overview

The ntm-profiler tool is a specialized bioinformatic pipeline designed to characterize Non-Tuberculous Mycobacteria from genomic data. It performs two primary functions: species identification using a k-mer based approach (falling back to mash/GTDB if needed) and drug resistance prediction by mapping reads against species-specific databases. It is particularly useful for clinical microbiology and genomic surveillance workflows involving NTM species like *M. abscessus* and *M. leprae*.

## Core Workflows

### 1. Database Initialization
Before running any analysis, ensure the species and resistance databases are downloaded and up to date.
```bash
ntm-profiler update_db
```

### 2. Profiling Samples
The `profile` command is the primary entry point. It automatically detects the species and, if a corresponding resistance database exists, identifies resistance-associated variants.

**From Raw Reads (Fastq):**
```bash
ntm-profiler profile -1 reads_R1.fastq.gz -2 reads_R2.fastq.gz -p sample_name --threads 4
```

**From Assemblies (Fasta):**
```bash
ntm-profiler profile -f assembly.fasta -p sample_name
```

**From Alignments (BAM/CRAM):**
*Note: The alignment must use the same reference genome and chromosome names as the ntm-profiler database.*
```bash
ntm-profiler profile -a alignment.bam -p sample_name
```

**From Variant Calls (VCF):**
```bash
ntm-profiler profile --vcf variants.vcf -p sample_name
```

### 3. Summarizing Multiple Results
To aggregate results from multiple individual runs into a single summary table, use the `collate` command within the directory containing the result files.
```bash
ntm-profiler collate --prefix study_summary
```

## Expert Tips and Best Practices

- **Platform Specification**: If using Nanopore data, explicitly set the platform to ensure the underlying mapping parameters are optimized.
  ```bash
  ntm-profiler profile -1 reads.fq.gz -p sample_name --platform nanopore
  ```
- **Output Formats**: By default, the tool produces JSON output. Use the `--txt` flag to generate a human-readable text report alongside the JSON.
- **Species-Specific Resistance**: Resistance prediction is currently most robust for *M. leprae* and the *M. abscessus* complex (subsp. *abscessus*, *bolletii*, and *massiliense*). For other species, the tool may only provide species identification.
- **Thread Management**: Use the `--threads` option to speed up the alignment phase, especially when processing large Fastq files.
- **Custom Databases**: If working with novel species or specific local variants, you can create custom databases using `create_species_db` and `create_resistance_db`. Always use the `--load` flag to make these databases immediately available to the `profile` command.

## Reference documentation
- [ntm-profiler Overview](./references/anaconda_org_channels_bioconda_packages_ntm-profiler_overview.md)
- [NTM-Profiler GitHub Documentation](./references/github_com_jody_phelan_NTM-Profiler.md)