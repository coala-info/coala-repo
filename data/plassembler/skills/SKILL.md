---
name: plassembler
description: Plassembler is a bioinformatic tool designed to accurately reconstruct and recover plasmid sequences from bacterial sequencing data. Use when user asks to generate high-quality plasmid assemblies, estimate plasmid copy numbers, or verify plasmid sequences against the PLSDB database.
homepage: https://github.com/gbouras13/plassembler
---


# plassembler

## Overview
Plassembler is a specialized bioinformatic tool designed to accurately reconstruct plasmid sequences in bacterial isolates. While long-read assemblers often struggle with small circular DNA molecules—leading to duplication, fragmentation, or total loss—plassembler optimizes recovery by filtering out chromosomal reads and utilizing a database-driven approach (PLSDB). Use this skill when you need to generate high-quality plasmid assemblies, estimate plasmid copy numbers, or verify plasmid sequences against known databases.

## Installation and Setup
Before running assemblies, the PLSDB database must be initialized.

```bash
# Install via Conda
conda install -c bioconda plassembler

# Download and initialize the required database
plassembler download -d <database_directory>
```

## Common CLI Patterns

### Hybrid Assembly (Recommended)
The most accurate mode, using both Oxford Nanopore/PacBio long reads and Illumina paired-end short reads.
```bash
plassembler run -d <db_dir> -l <long_reads.fq> -1 <R1.fq> -2 <R2.fq> -c <est_chrom_size> -o <output_dir>
```

### Long-Read Only Assembly
Use this mode when short-read data is unavailable. It treats long reads as both the backbone and the polishing source.
```bash
plassembler long -d <db_dir> -l <long_reads.fq> -o <output_dir> -c <est_chrom_size>
```

### Using Existing Flye Assemblies
If you have already performed a Flye assembly, you can skip the initial assembly step to save time.
```bash
plassembler run -d <db_dir> -l <long_reads.fq> -1 <R1.fq> -2 <R2.fq> --flye_assembly <assembly.fasta> --flye_info <assembly_info.txt> -o <output_dir>
```

## Expert Tips and Best Practices
- **Chromosome Length**: Always provide an estimated chromosome length (`-c`). This helps the tool effectively filter out chromosomal contigs, which significantly improves the recovery rate of small plasmids.
- **Database Updates**: If you upgrade plassembler (e.g., to v1.5.0+), you must re-run the `download` command to ensure compatibility with the expanded PLSDB schema.
- **Copy Number Estimation**: Plassembler provides estimated copy numbers for both long and short read sets. If you only need to check existing plasmid contigs against the database without calculating copy numbers, use the `--no_copy_numbers` flag with the `assembled` command.
- **Large Scale Automation**: For high-throughput workflows involving many genomes, consider using **Hybracter**, which has plassembler integrated as a core component.
- **Manual Recovery**: For complex isolates where automated tools struggle, use **Trycycler** to recover the chromosome first, then use plassembler to target the remaining plasmid content.

## Reference documentation
- [Plassembler GitHub Repository](./references/github_com_gbouras13_plassembler.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_plassembler_overview.md)