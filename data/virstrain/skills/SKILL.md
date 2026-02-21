---
name: virstrain
description: VirStrain is a high-resolution viral strain identification tool that operates on both raw sequencing reads and assembled genomic contigs.
homepage: https://github.com/liaoherui/VirStrain
---

# virstrain

## Overview
VirStrain is a high-resolution viral strain identification tool that operates on both raw sequencing reads and assembled genomic contigs. It utilizes a specialized k-mer and SNP-based approach to provide identification beyond the species level, making it essential for clinical diagnostics, epidemiology, and viral evolution studies. The tool supports custom database construction from Multiple Sequence Alignments (MSA) and includes specific modes for viruses with high mutation rates.

## Installation and Environment
The recommended way to use VirStrain is via Bioconda or Pip, which provides simplified command aliases.
- **Conda**: `conda install -c bioconda virstrain`
- **Pip**: `pip install virstrain==1.17`
- **Dependencies**: Requires Python 3.6 or 3.7 (3.9 is currently unsupported), Perl, and Bowtie2 (for version 1.17+).

## Common CLI Patterns

### Identifying Strains from Short Reads
Use the `virstrain` command for raw sequencing data.
- **Single-End (SE) Reads**:
  `virstrain -i input_1.fq -d path/to/database -o output_directory`
- **Paired-End (PE) Reads**:
  `virstrain -i input_1.fq -p input_2.fq -d path/to/database -o output_directory`
- **High Mutation Mode**:
  For viruses like HIV with high variability, always include the `-m` flag:
  `virstrain -i input_1.fq -d VirStrain_DB/HIV -o output_dir -m`

### Identifying Strains from Assembled Contigs
Use the `virstrain_contig` command for FASTA files.
`virstrain_contig -i assembled_contigs.fasta -d VirStrain_contig_DB -o output_dir`

### Building Custom Databases
You can build a database using your own reference genomes provided as a Multiple Sequence Alignment (MSA).
`virstrain_build -i input_msa.fasta -d custom_db_directory`

## Expert Tips and Best Practices
- **Input Format**: VirStrain (v1.12+) supports gzipped FASTQ files (`.fq.gz` or `.fastq.gz`) directly.
- **Result Sorting**: Use the `-s` parameter to sort the most probable strains by matches to specific sites, which helps in interpreting results with multiple hits.
- **Database Merging**: If you have multiple read-level databases (e.g., SCOV2 and H1N1) and want to use them for contig identification, use `virstrain_merge`:
  `virstrain_merge -i VirStrain_DB/SCOV2,VirStrain_DB/H1N1 -o merged_contig_db`
- **MSA Constraints**: When building custom databases, ensure the headers in your MSA file do not contain commas (`,`) or pipes (`|`), as these characters interfere with the tool's parsing logic.
- **Version Check**: Use `virstrain -v` (GitHub version) to verify your installation version, especially when troubleshooting bug fixes related to gzipped file handling.

## Reference documentation
- [VirStrain Overview](./references/anaconda_org_channels_bioconda_packages_virstrain_overview.md)
- [VirStrain GitHub Repository](./references/github_com_liaoherui_VirStrain.md)