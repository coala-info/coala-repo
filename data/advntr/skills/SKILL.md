---
name: advntr
description: adVNTR is a bioinformatics tool designed to genotype Variable Number Tandem Repeats and identify mutations within repetitive genomic regions using Hidden Markov Models. Use when user asks to genotype predefined VNTRs, identify frameshifts in protein-coding regions, or add custom VNTR models to the database.
homepage: https://github.com/mehrdadbakhtiari/adVNTR
metadata:
  docker_image: "quay.io/biocontainers/advntr:1.5.0--py310ha6711e0_1"
---

# advntr

## Overview
adVNTR is a specialized bioinformatics tool designed to genotype Variable Number Tandem Repeats (VNTRs). Unlike standard variant callers that struggle with repetitive regions, adVNTR uses Hidden Markov Models (HMMs) to find diploid repeating counts and identify mutations within these complex loci. It is particularly effective for studying disease-linked VNTRs (e.g., CSTB, PER3, MUC1) and supports both short-read and long-read sequencing technologies.

## Core Workflows

### 1. Genotyping Predefined VNTRs
To genotype a specific locus already present in the adVNTR database, use the `genotype` command with a VNTR ID.

```bash
# Basic genotyping for Illumina data
advntr genotype --vntr_id <ID> --alignment_file <input.bam> --working_directory <dir>

# Genotyping for PacBio data
advntr genotype --vntr_id <ID> --alignment_file <input.bam> --pacbio --working_directory <dir>

# Output results to a specific format (text, bed, or vcf)
advntr genotype --vntr_id <ID> --alignment_file <input.bam> --outfmt bed --outfile results.bed
```

### 2. Identifying Frameshifts
If the goal is to detect protein-coding changes rather than just copy number, use the `--frameshift` flag.

```bash
advntr genotype --vntr_id <ID> --alignment_file <input.bam> --frameshift
```

### 3. Adding Custom VNTR Models
If a locus is not in the recommended set, you must train a model using a reference genome.

```bash
advntr addmodel -r <ref.fa> -c <chrom> -p <motif_pattern> -s <start_pos> -e <end_pos>
```
*   `-p`: The repeating unit pattern (e.g., `CGCGGGGCGGGG`).
*   `-s`/`-e`: The genomic coordinates of the repeat region.

### 4. Managing the Database
*   **View Models**: Check existing VNTR structures in the database.
    ```bash
    advntr viewmodel
    ```
*   **Delete Model**: Remove a custom or existing model.
    ```bash
    advntr delmodel --vntr_id <ID>
    ```

## Expert Tips and Best Practices

*   **Data Requirements**: Always ensure you have downloaded the pre-trained models (`vntr_data_recommended_loci.zip`) for your specific reference assembly (hg19 or GRCh38). Place these in the project directory or specify the path using `-m`.
*   **Working Directory**: Always specify a `--working_directory`. adVNTR generates temporary files during the HMM alignment process; using a fast local SSD can improve performance.
*   **Haploid Organisms**: If working with non-human or haploid data, use the `--haploid` flag to prevent the tool from forcing a diploid genotype call.
*   **Model Updates**: Use the `--update` flag during genotyping to iteratively refine the HMM model based on the real sequencing data in your sample, which can improve accuracy for divergent alleles.
*   **Memory/Threads**: For large-scale genotyping (multiple IDs), use the `-t` flag to specify the number of threads (default is 4).



## Subcommands

| Command | Description |
|---------|-------------|
| advntr addmodel | Add a new VNTR model to the database |
| advntr genotype | Genotype VNTRs from sequencing data |

## Reference documentation
- [adVNTR Tutorial](./references/advntr_readthedocs_io_en_latest_tutorial.html.md)
- [Quick Start Guide](./references/advntr_readthedocs_io_en_latest_quickstart.html.md)
- [Installation and Data Requirements](./references/advntr_readthedocs_io_en_latest_installation.html.md)
- [Disease-linked VNTRs Wiki](./references/github_com_mehrdadbakhtiari_adVNTR_wiki_Disease-linked-VNTRs.md)