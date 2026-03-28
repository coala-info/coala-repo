---
name: captus
description: Captus is a phylogenomics pipeline that processes raw high-throughput sequencing data into filtered alignments for phylogenetic inference. Use when user asks to clean reads, perform de novo assembly, extract target markers, or filter paralogs and align sequences.
homepage: https://github.com/edgardomortiz/Captus
---


# captus

## Overview
Captus is a comprehensive phylogenomics pipeline designed to transform raw HTS data into high-quality alignments ready for phylogenetic inference. It operates through four primary modules—clean, assemble, extract, and align—which are typically executed in sequence. The tool is particularly effective for hybridization capture, genome skimming, and RNA-Seq data, offering specialized presets and sophisticated paralog filtering methods to ensure orthology in the final datasets.

## Core Workflow and Commands

### 1. Read Cleaning (`captus clean`)
Performs adaptor and quality trimming using BBTools and generates quality reports.
*   **Standard Usage**: `captus clean -i /path/to/raw_reads/ -o 01_clean_reads`
*   **RNA-Seq**: Add `--rna` to enable poly-A trimming.
*   **Expert Tip**: Use `--compression` to specify output format (default is `.gz`).

### 2. De Novo Assembly (`captus assemble`)
Assembles cleaned reads using MEGAHIT and estimates contig depth with Salmon.
*   **Standard Usage**: `captus assemble -r 01_clean_reads -o 02_assemblies --preset CAPSKIM`
*   **Presets**:
    *   `CAPSKIM`: Optimized for hyb-cap and genome skimming (Default).
    *   `WGS`: For high-coverage (>30x) whole genome shotgun data.
    *   `RNA`: Optimized for transcriptome data.
*   **Contamination Filtering**: Use `--max_contig_gc 60.0` to remove bacterial contigs from eukaryotic samples.
*   **Depth Filtering**: Default minimum depth is 1.5x. Adjust with `--min_contig_depth`.

### 3. Marker Extraction (`captus extract`)
Searches assemblies for target loci using reference sequences.
*   **Standard Usage**: `captus extract -a 02_assemblies -p /path/to/references.faa -o 03_extractions`
*   **Reference Types**: Supports amino acids (via Scipio) or nucleotides (via BLAT).
*   **Discovery**: Use `--cluster_leftovers` to find novel homologous regions not present in your reference set.

### 4. Alignment and Paralog Filtering (`captus align`)
Collects markers, aligns them, filters paralogs, and trims the results.
*   **Standard Usage**: `captus align -e 03_extractions -o 04_alignments`
*   **Paralog Filtering**:
    *   `naive`: Keeps only the best hit per sample.
    *   `informed`: (Recommended) Uses reference similarity and frequency across samples to identify the most likely ortholog.
*   **Codon Alignment**: By default, if both AA and NT formats are requested, Captus performs codon-aware alignment. Disable with `--disable_codon_align`.
*   **Trimming**: Uses TAPER (error masking) and ClipKIT (site trimming). Adjust aggressiveness with `--taper_cutoff` and `--clipkit_method`.

## Expert Tips and Best Practices
*   **Parallelization**: Captus is highly parallel. Use `--threads` for cores per task and `--concurrent` for the number of samples to process simultaneously.
*   **Memory Management**: Use `--ram` to limit the total memory (in GB) available to the process, which is critical during the `assemble` step.
*   **Restarting**: If a run fails or parameters need adjustment, use `--redo_from` in the `align` module to skip successful early stages (e.g., `--redo_from trimming`).
*   **Outgroups**: In the `align` step, use `--outgroup sample1,sample2` to ensure these samples are placed first in the FASTA files, facilitating automatic rooting in downstream tree-building software.



## Subcommands

| Command | Description |
|---------|-------------|
| captus align | Captus-assembly: Align; collect, align, and curate aligned markers |
| captus assemble | Assemble; perform de novo assembly using MEGAHIT |
| captus extract | Captus-assembly: Extract; recover markers from FASTA assemblies |
| clean | Clean; remove adaptors and quality-filter reads with BBTools |

## Reference documentation
- [Captus Assembly Overview](./references/edgardomortiz_github_io_captus.docs_assembly.md)
- [Assemble Options](./references/edgardomortiz_github_io_captus.docs_assembly_assemble_options.md)
- [Align Options](./references/edgardomortiz_github_io_captus.docs_assembly_align_options.md)
- [Extract Options](./references/edgardomortiz_github_io_captus.docs_assembly_extract_options.md)
- [Parallelization Basics](./references/edgardomortiz_github_io_captus.docs_basics_parallelization.md)