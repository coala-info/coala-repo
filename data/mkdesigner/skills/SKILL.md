---
name: mkdesigner
description: MKDesigner is a bioinformatics pipeline that automates the identification of genomic polymorphisms and the design of specific PCR primers for genotyping. Use when user asks to call SNPs or InDels, design primers for markers, or generate physical maps for fine mapping projects.
homepage: https://github.com/KChigira/mkdesigner/
---


# mkdesigner

## Overview

MKDesigner is a specialized bioinformatics pipeline that automates the transition from raw genomic data to lab-ready PCR primers. It streamlines the identification of polymorphic markers—specifically Single Nucleotide Polymorphisms (SNPs) and Insertion-Deletions (InDels)—between different plant or animal lines. By integrating variant calling, primer design, and physical mapping, it eliminates the manual labor of designing primers one-by-one for fine mapping or genotyping projects.

## Core Workflow

The tool operates in three sequential stages. Each stage generates an output directory used by the subsequent command.

### 1. Haplotype Calling (`mkvcf`)
Generates a VCF file from aligned BAM files.
- **Requirement**: At least two BAM files are needed to identify polymorphisms between lines.
- **Key Pattern**:
  ```bash
  mkvcf -r ref.fasta -b lineA.bam -b lineB.bam -n lineA -n lineB -O project_prefix --cpu 4
  ```
- **Tip**: Ensure variety names (`-n`) match the order of BAM files (`-b`).

### 2. Primer Design (`mkprimer`)
Identifies markers and designs primers using Primer3, then checks specificity with BLAST.
- **Key Pattern**:
  ```bash
  mkprimer -r ref.fasta -V project_mkvcf/output.vcf -n1 lineA -n2 lineB -O project_prefix --type SNP
  ```
- **Optimization Parameters**:
  - `--type`: Choose `SNP` or `INDEL`.
  - `--target`: Focus on a specific region (e.g., `chr01:1000000-2000000`) to save time.
  - `--min_prodlen` / `--max_prodlen`: Set based on your intended gel electrophoresis resolution (default range is typically 150-280bp).
  - `--limit`: Use to cap the number of attempts if the genome is highly polymorphic.

### 3. Marker Selection and Mapping (`mkselect`)
Filters the designed primers to a manageable number and generates a physical map.
- **Key Pattern**:
  ```bash
  mkselect -i project_mkprimer/for_draw.fai -V project_mkprimer/output_added.vcf -n 20 -O project_prefix
  ```
- **Output**: Produces a `.tsv` file with final primer sequences and a `.png` visualization of marker distribution across chromosomes.

## Expert Tips

- **Environment**: Always run within a dedicated conda environment to manage dependencies like GATK4, Picard, and Primer3.
- **Depth Filtering**: Use `--mindep` and `--maxdep` in `mkprimer` to exclude low-confidence variants or repetitive regions that might cause PCR failure.
- **Phased Data**: Version 0.5.3+ supports phased genotypes (e.g., `0|0`, `1|1`), which is critical for accurate marker design in heterozygous or polyploid species.
- **Specificity**: If `mkprimer` is slow, it is likely performing BLAST searches for primer specificity. Use `--blast_timeout` to skip markers in highly repetitive regions.



## Subcommands

| Command | Description |
|---------|-------------|
| mkprimer | MKDesigner version 0.5.3 |
| mkselect | Selects markers based on various criteria. |
| mkvcf | MKDesigner version 0.5.3 |

## Reference documentation

- [MKDesigner User Guide](./references/github_com_KChigira_mkdesigner_blob_main_README.md)
- [MKDesigner Repository Overview](./references/github_com_KChigira_mkdesigner.md)