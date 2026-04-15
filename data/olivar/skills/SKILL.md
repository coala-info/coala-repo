---
name: olivar
description: Olivar automates the design of tiled amplicon schemes for multiplex PCR by integrating genomic variation and specificity data to minimize primer risk. Use when user asks to build a reference index from sequence alignments, design tiled primer sets for pathogen sequencing, or validate primer specificity against background genomes.
homepage: https://gitlab.com/treangenlab/olivar
metadata:
  docker_image: "quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0"
---

# olivar

## Overview
Olivar is a specialized bioinformatics tool designed to automate the creation of tiled amplicon schemes for multiplex PCR. Unlike general primer design tools, Olivar integrates genomic variation data and non-specific sequence databases (via BLAST) to assign "risk scores" to target regions. This ensures that primers are placed in stable, conserved, and unique areas of the genome. It is an essential tool for researchers developing diagnostic assays or whole-genome sequencing protocols for pathogens where sequence evolution and specificity are critical.

## Core Workflow

### 1. Building the Reference Index
Before designing primers, you must generate an Olivar reference file (`.olvr`). This step calculates the risk landscape of your target.

**From a Multiple Sequence Alignment (MSA):**
Use this when you have a collection of variant sequences and want to find conserved regions.
```bash
olivar build -m targets.fasta -o output_dir --align -p 4
```

**From a Reference Sequence and Variation List:**
Use this for well-characterized genomes with known SNP data.
```bash
olivar build -f ref.fasta -v variations.csv -d path/to/blast_db -o output_dir
```
*   **Tip**: The variation CSV requires `START`, `STOP`, and `FREQ` columns (1-based coordinates).

### 2. Designing Tiled Amplicons
Once the `.olvr` file is ready, run the tiling command to generate the primer scheme.

```bash
olivar tiling path/to/target.olvr -o design_output --max-amp-len 400 --min-amp-len 250 --seed 42 -p 4
```

### 3. Validating Specificity
Check your design against a background genome (e.g., Human GRCh38) to ensure no off-target amplification.

```bash
olivar specificity --primer_pool design.csv --pool 1 -d path/to/human_blast_db -o validation_results
```

## Expert Tips and Best Practices

*   **Coordinate Systems**: Olivar uses 1-based closed intervals for most inputs and CSV outputs. However, the `.primer.bed` file follows the standard 0-based BED format for compatibility with ARTIC/PrimalScheme pipelines.
*   **Handling Variations**: If you provide a large list of variations, avoid setting `--check-var` to `True` in the `tiling` step. This flag strictly filters out any primer candidate with a variation within 5nt of the 3' end, which can lead to "no-design" gaps in highly variable regions.
*   **Reproducibility**: Always specify a `--seed` value. Olivar uses stochastic optimization for primer design regions (PDR) and primer-dimer minimization; a fixed seed ensures you get the same primer set every time.
*   **BLAST Databases**: When using a BLAST database for specificity, ensure the path provided to `-d` ends with the database prefix (e.g., `.../GRCh38_primary`), not just the directory.
*   **Multi-Target Design**: For multiple targets (e.g., different viral segments), build `.olvr` files for each, place them in one directory, and point `olivar tiling` to that directory.



## Subcommands

| Command | Description |
|---------|-------------|
| olivar | olivar: error: argument subparser_name: invalid choice: 'Olivar' (choose from build, tiling, save, specificity, sensitivity) |
| olivar | olivar: error: argument subparser_name: invalid choice: 'an' (choose from build, tiling, save, specificity, sensitivity) |
| olivar save | Saves an Olivar design to a file. |
| olivar tiling | Primer design for tiling experiments. |
| olivar_build | Build an Olivar reference file from a FASTA sequence and/or an MSA. |
| olivar_sensitivity | Check the sensitivity of existing primer pools against an MSA of target sequences, and visualize the MSA and primer alignments. |
| olivar_specificity | Calculate primer specificity using BLAST. |

## Reference documentation
- [GitHub Repository: treangenlab/Olivar](./references/github_com_treangenlab_Olivar.md)
- [Olivar README and Usage Guide](./references/github_com_treangenlab_Olivar_blob_main_README.md)
- [Example Python Implementation](./references/github_com_treangenlab_Olivar_blob_main_example.py.md)