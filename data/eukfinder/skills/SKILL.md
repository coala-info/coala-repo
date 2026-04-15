---
name: eukfinder
description: Eukfinder is a modular bioinformatics pipeline designed to identify and extract eukaryotic genomic sequences from complex metagenomic datasets. Use when user asks to preprocess short reads, classify and assemble eukaryotic sequences from metagenomes, or identify eukaryotic contigs in long-read datasets.
homepage: https://github.com/RogerLab/Eukfinder
metadata:
  docker_image: "quay.io/biocontainers/eukfinder:1.2.4--py36h503566f_0"
---

# eukfinder

## Overview
Eukfinder is a modular bioinformatics pipeline designed to solve the challenge of "finding the needle in the haystack"—extracting eukaryotic genomic signals from complex metagenomic datasets dominated by prokaryotes. It operates in two primary modes: a multi-step assembly-and-reclassification workflow for short reads, and a direct classification workflow for long reads or existing contigs. By utilizing a combination of Centrifuge and PLAST against specialized databases, it filters out non-target sequences and provides a refined set of potential eukaryotic contigs ready for genome binning.

## Core Workflows

### 1. Illumina Short-Read Processing
Short-read analysis requires a two-stage approach: preprocessing and classification/assembly.

**Step A: Read Preprocessing (`read_prep`)**
Removes adapters, low-quality bases, and host contamination (e.g., human or environmental host).
```bash
Eukfinder read_prep --r1 R1.fastq --r2 R2.fastq \
    -n 16 --hcrop 10 -l 15 -t 15 --wsize 40 --qscore 25 --mlen 40 \
    -i adapters.fa --hg host_genome.fasta \
    -o sample_output --mhlen 50 --cdb /path/to/centrifuge_db_prefix
```
*   **Note**: Use `read_prep_env` instead of `read_prep` for environmental samples where no specific host genome needs to be filtered.

**Step B: Sequence Classification and Assembly (`short_seqs`)**
Classifies reads, assembles "Eukaryotic" and "Unknown" reads using metaSPAdes, and reclassifies the resulting contigs.
```bash
Eukfinder short_seqs --r1 sample_output_p.1.fastq --r2 sample_output_p.2.fastq --un sample_output_un.fastq \
    -o final_euk -n 16 -z 4 -t True \
    -e 1e-5 --pid 60 --cov 60 --mhlen 50 \
    --pclass sample_output_centrifuge_P --uclass sample_output_centrifuge_UP \
    --cdb /path/to/centrifuge_db_prefix -p /path/to/plast_db -m /path/to/plast_map
```

### 2. Long-Read or Contig Processing (`long_seqs`)
For Nanopore, PacBio, or pre-assembled contigs, use the simplified single-pass classification.
```bash
Eukfinder long_seqs -i assembly.fasta -o euk_contigs -n 16 \
    -p /path/to/plast_db -m /path/to/plast_map --cdb /path/to/centrifuge_db_prefix \
    -e 1e-5 --pid 60 --cov 60 --mhlen 100
```

## Expert Tips and Best Practices

*   **Output Path Restriction**: The `-o` (output prefix) parameter must be a simple filename prefix. Do **not** include directory paths in the prefix (e.g., use `my_sample`, not `/path/to/my_sample`). Run the command from within the desired output directory.
*   **Centrifuge Database Reference**: When specifying `--cdb`, provide the common filename prefix only (the part before `.1.cf`, `.2.cf`, etc.).
*   **Memory Management**: The `-z` (number of chunks) parameter in `short_seqs` is critical for memory control during PLAST searches. Increase this value (e.g., 4-8) for very large datasets (>100M reads) to prevent OOM (Out of Memory) errors.
*   **Sensitivity vs. Specificity**:
    *   **`--mhlen`**: Controls the minimum sequence length for Centrifuge matches. Use `50` for standard runs. Lowering to `30-40` increases sensitivity for short fragments but raises false positives.
    *   **`--pid` and `--cov`**: For divergent or novel environmental eukaryotes, consider lowering `--pid` (percent identity) to `50` to capture more distant homologs.
*   **Taxonomy Updates**: Set `-t True` only for the first run on a system to initialize the taxonomy database; set to `False` for subsequent runs to save time.



## Subcommands

| Command | Description |
|---------|-------------|
| eukfinder download_db | Download EukFinder databases |
| eukfinder long_seqs | Finds long sequences in a given file and searches them against a database. |
| eukfinder read_prep | Description |
| eukfinder read_prep_env | Prepare environment for eukfinder |
| eukfinder short_seqs | optional arguments:   -h, --help            show this help message and exit |

## Reference documentation
- [Eukfinder with Illumina short reads](./references/github_com_RogerLab_Eukfinder_wiki_Eukfinder_with_Illumina_short_reads.md)
- [Eukfinder with Long read or contig data](./references/github_com_RogerLab_Eukfinder_wiki_Eukfinder_with_Long_read_or_contig_data.md)
- [Eukfinder FAQ](./references/github_com_RogerLab_Eukfinder_wiki_FAQ.md)