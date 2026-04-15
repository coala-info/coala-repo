---
name: pneumo-typer
description: Pneumo-Typer is a bioinformatics pipeline for identifying serotypes, sequence types, and visualizing capsule gene clusters in Streptococcus pneumoniae genomes. Use when user asks to determine pneumococcal serotypes, perform MLST or cgMLST analysis, and generate visualizations of capsule polysaccharide gene clusters.
homepage: https://www.microbialgenomic.cn/Pneumo-Typer.html
metadata:
  docker_image: "quay.io/biocontainers/pneumo-typer:2.0.1--hdfd78af_0"
---

# pneumo-typer

## Overview
Pneumo-Typer is a specialized bioinformatics pipeline designed for the comprehensive characterization of *Streptococcus pneumoniae*. It automates the identification of serotypes and sequence types while providing high-quality visualizations of the capsule polysaccharide (cps) gene clusters. This skill should be used when you need to process multiple pneumococcal genomes to determine their antigenic properties and genetic lineages simultaneously.

## Core Workflows

### 1. Database Preparation
Before running analysis, ensure the MLST and cgMLST databases are current. This is critical for accurate sequence typing.

- **Update MLST only:** `update_mlstdb_cgmlstdb -m T -c F`
- **Update both MLST and cgMLST (Parallel):** `update_mlstdb_cgmlstdb -m T -c T -t 4`

### 2. Standard Analysis
The primary command processes a directory of genomes. It accepts GenBank (.gbk), FASTA (.fasta/.fa), or a mix of both.

```bash
pneumo-typer -d <input_directory> -t <threads> -m T
```

### 3. Advanced Analysis (cgMLST)
To include core-genome MLST (cgST) analysis, which provides higher resolution than standard MLST but requires more computation time (~3 mins per genome):

```bash
pneumo-typer -d <input_directory> -t <threads> -m T -c T
```

## Key Arguments & Best Practices

| Argument | Function | Recommendation |
| :--- | :--- | :--- |
| `-d` | Input directory | Ensure all genome files are in one folder. |
| `-t` | Threads | Use higher counts (e.g., 10+) for large datasets to speed up BLAST/BLAT. |
| `-m` | MLST | Set to `T` (True) for standard sequence typing. |
| `-c` | cgMLST | Set to `T` only if high-resolution phylogenetic context is needed. |
| `-Ts T` | Test System | Use this flag to verify dependencies (Prodigal, BLAST+, BLAT) are correctly mapped. |

## Interpreting Results
The tool generates several output files in the working directory:
- **Serotype.out**: The refined serotype prediction. Note that "CapT" labels represent raw capsule gene matches, while the final output column represents the refined, true serotype.
- **ST_out.txt / cgST_out.txt**: Sequence type results.
- **Visualizations (.svg)**: 
    - `heatmap_gene.svg`: Distribution at the individual gene level.
    - `heatmap_class.svg`: Distribution at the functional class level.
    - `cps_cluster.svg`: Linear map of the genetic organization of the capsule cluster.

## Expert Tips
- **Input Quality**: If using FASTA files without annotations, the tool automatically runs Prodigal for gene prediction. For the most consistent results, providing GenBank files with existing curated annotations is preferred.
- **Dependency Check**: If the tool fails, run `pneumo-typer -Ts T`. It provides a detailed checklist of Perl modules (GD, BioPerl) and binary dependencies.
- **Visualization**: The SVG outputs are publication-ready but can be edited in vector graphics software (like Inkscape or Illustrator) if labels overlap in dense datasets.

## Reference documentation
- [Pneumo-Typer User Guide](./references/www_microbialgenomic_cn_Pneumo-Typer.html.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pneumo-typer_overview.md)