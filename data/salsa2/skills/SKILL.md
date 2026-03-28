---
name: salsa2
description: "SALSA2 integrates Hi-C data with genome assemblies to produce chromosome-scale scaffolds. Use when user asks to scaffold assemblies using Hi-C data, correct misassemblies, or utilize assembly graphs to resolve contig orientations."
homepage: https://github.com/marbl/SALSA
---


# salsa2

## Overview

SALSA2 (Scaffolding Assemblies with Long-range Sequence Alignment) is a tool designed to integrate Hi-C data with genome assemblies to produce chromosome-scale scaffolds. It is particularly effective for long-read assemblies (e.g., PacBio or Oxford Nanopore) where it can utilize assembly graphs to resolve ambiguities. Use this skill to guide the preparation of Hi-C alignments, execute the scaffolding pipeline, and interpret the resulting iterative output.

## Prerequisites and Data Preparation

Before running the SALSA2 pipeline, input files must be formatted specifically:

1.  **Contig Lengths**: Generate a `.fai` file from your assembly.
    ```bash
    samtools faidx contigs.fasta
    ```
2.  **BED Alignments**: Hi-C reads must be mapped to the assembly (using BWA or Bowtie2). The resulting BAM must be converted to BED and **sorted by read name** (column 4), not by coordinate.
    ```bash
    bamToBed -i alignment.bam > alignment.bed
    sort -k 4 alignment.bed > tmp && mv tmp alignment.bed
    ```
3.  **Restriction Enzyme**: Identify the cutting site sequence (e.g., `GATC` for MboI). For enzyme-free protocols like Omni-C, use `DNASE`.

## Core Command Patterns

### Basic Scaffolding
Use this for a standard run when you have contigs and a name-sorted BED file.
```bash
python run_pipeline.py -a contigs.fasta -l contigs.fasta.fai -b alignment.bed -e GATC -o output_dir
```

### Scaffolding with Misassembly Correction
Enable the `-m yes` flag to allow SALSA2 to identify and break misassembled contigs based on Hi-C coverage inconsistencies.
```bash
python run_pipeline.py -a contigs.fasta -l contigs.fasta.fai -b alignment.bed -e GATC -o output_dir -m yes
```

### Utilizing Assembly Graphs
If your assembler provided a GFA file, include it to reduce scaffolding errors by constraining contig orientations.
```bash
python run_pipeline.py -a contigs.fasta -l contigs.fasta.fai -b alignment.bed -e GATC -g assembly_graph.gfa -o output_dir
```

## Expert Tips and Parameters

*   **Iterative Refinement**: Use `-i` to set the number of iterations (default is 3). Increasing iterations can sometimes improve results for highly fragmented assemblies.
*   **Contig Filtering**: Use `-c` to set the minimum contig length to be considered for scaffolding (default is 1000bp). For higher quality assemblies, increasing this to 5000 or 10000 can reduce noise.
*   **Multiple Enzymes**: If a cocktail of enzymes was used, provide them as a comma-separated list: `-e GATC,AAGCTT`.
*   **Output Interpretation**: The final results are stored in `scaffolds_FINAL.fasta` and `scaffolds_FINAL.agp`. Intermediate iterations are preserved in the output directory for troubleshooting.
*   **Visualization**: SALSA2 supports converting scaffolds to `.hic` format for contact map visualization in Juicebox.



## Subcommands

| Command | Description |
|---------|-------------|
| python | Python interpreter |
| sort | Sort lines of text |

## Reference documentation
- [SALSA README](./references/github_com_marbl_SALSA_blob_master_README.md)
- [SALSA Pipeline Script](./references/github_com_marbl_SALSA_blob_master_run_pipeline.py.md)
- [Restriction Site Processing](./references/github_com_marbl_SALSA_blob_master_RE_sites.py.md)