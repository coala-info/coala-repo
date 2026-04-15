---
name: matam
description: MATAM is a reference-guided assembly tool designed to reconstruct full-length genomic markers, such as 16S rRNA, from metagenomic short-read sequences. Use when user asks to reconstruct phylogenetic markers from metagenomics data, index reference databases, perform taxonomic assignment, or generate abundance tables across multiple samples.
homepage: https://github.com/bonsai-team/matam
metadata:
  docker_image: "quay.io/biocontainers/matam:1.6.2--haf24da9_0"
---

# matam

## Overview

MATAM (Mapping-Assisted Targeted-Assembly for Metagenomics) is a specialized assembly tool designed to extract and reconstruct specific genomic markers from short-read metagenomic sequences. While general assemblers often struggle with closely related species in complex communities, MATAM uses a reference-guided approach to ensure high-quality, full-length marker reconstruction. It is optimized for 16S rRNA markers but can be adapted for other phylogenetic markers through custom database indexing.

## Resource Management

MATAM is parallelized and memory-intensive. Adjust these parameters based on your environment:

- **Memory**: 10GB RAM is recommended. Use `--max_memory` (in MB) to cap usage.
- **CPU**: Use `--cpu` to specify the number of threads.
- **Input Format**: Reads must be in FASTQ format with unique identifiers and Phred+33 encoding.

## Database Preparation

Before assembly, you must index a reference database.

### Using the Default SSU rRNA Database
MATAM provides a pre-clustered (95% identity) SILVA 128 database.
```bash
index_default_ssu_rrna_db.py -d /path/to/db_dir --max_memory 10000
```

### Using a Custom Database
For markers other than 16S rRNA, prepare a custom FASTA reference.
```bash
matam_db_preprocessing.py -i custom_ref.fasta -d /path/to/db_dir --cpu 8 --max_memory 10000 -v
```

## Assembly Workflows

### Standard De-novo Assembly
Reconstructs full-length sequences present in the sample.
```bash
matam_assembly.py -d /path/to/db_dir/prefix -i reads.fastq --cpu 8 --max_memory 10000 -v
```
*Note: The `prefix` for the default database is `SILVA_128_SSURef_NR95`.*

### Assembly with Taxonomic Assignment
Performs assembly followed by classification using the RDP classifier.
```bash
matam_assembly.py -d /path/to/db_dir/prefix -i reads.fastq --cpu 8 --perform_taxonomic_assignment -v
```
*Warning: The default RDP training model is "16srrna". This mode may not be suitable for non-16S markers.*

## Comparing Multiple Samples

If you have processed multiple samples with `--perform_taxonomic_assignment`, you can generate abundance tables.

1. Create a tabulated `samples.tsv` file:
   ```text
   sample1    /path/to/sample1/final_assembly.fa    /path/to/sample1/rdp.tab
   sample2    /path/to/sample2/final_assembly.fa    /path/to/sample2/rdp.tab
   ```

2. Run the comparison script:
   ```bash
   matam_compare_samples.py -s samples.tsv -t contingency_table.tsv -c comparison_table.tsv
   ```
   - `contingency_table.tsv`: Reports abundance per sequence.
   - `comparison_table.tsv`: Reports abundance by taxonomic path.

## Expert Tips

- **Low Memory Environments**: If running on a machine with limited RAM, set `--max_memory 4000` (4GB), but be aware this may degrade assembly performance or increase runtime.
- **Taxonomic Accuracy**: When using `--perform_taxonomic_assignment`, MATAM tags RDP nodes below the confidence threshold as "unclassified" to prevent false positives.
- **Output Files**: The primary output is `final_assembly.fa`. If taxonomic assignment was run, check `rdp.tab` for classification details.



## Subcommands

| Command | Description |
|---------|-------------|
| index_default_ssu_rrna_db.py | Index default SSU rRNA DB |
| matam_assembly.py | MATAM assembly |
| matam_compare_samples.py | This script let you compare two or more samples coming from MATAM -- v1.5.1 or superior |

## Reference documentation
- [MATAM GitHub Repository](./references/github_com_bonsai-team_matam.md)