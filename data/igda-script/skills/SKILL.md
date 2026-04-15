---
name: igda-script
description: igda-script provides a suite of utilities for genomic data post-processing, including long-read alignment, VCF manipulation, and assembly refinement. Use when user asks to align genomes, add genotype quality to VCF files, fill gaps in assembled sequences, or convert haploid assemblies to diploid formats.
homepage: https://github.com/zhixingfeng/shell
metadata:
  docker_image: "quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0"
---

# igda-script

## Overview

The `igda-script` skill provides a suite of specialized utilities designed to support the Integrated Genome Detection and Assembly (IGDA) workflow. It focuses on the post-processing of genomic data, including the alignment of long reads, the manipulation of VCF files to include quality metrics, and the refinement of assembly contigs. Key capabilities include filling gaps in assembled sequences using read pileups and converting haploid assembly representations into diploid formats.

## Core Workflows and CLI Patterns

### Genome Alignment
Use these scripts to wrap `minimap2` for genomic assembly alignment (typically using the `asm20` preset).

*   **Single File Alignment**:
    `align_genome <input.fasta> <reference.fasta> <output.sam>`
*   **Directory Batch Alignment**:
    `align_genome_dir <input_dir> <reference.fasta> <output_dir>`
    *Note: This script specifically looks for `.fasta` files in the input directory.*

### VCF Manipulation
*   **Add Genotype Quality (GQ)**:
    `add_gq_to_vcf <input.vcf> <output.vcf>`
    This script appends a `##FORMAT=<ID=GQ...>` header and assigns a default GQ value of 100 to all records.

### Assembly Refinement (IGDA Toolset)
The `igda` binary and its associated wrappers manage `.ann` (annotation/contig) files.

*   **Convert ANN to SAM**:
    `igda_ann2sam <input.ann> <reference.fasta> <output.sam>`
*   **Find Non-Chimeric Contigs**:
    `igda find_nccontigs -j <overlap_threshold> <input.ann> <output.ann>`
    *Common threshold: 0.5 or 0.8.*
*   **Transitive Reduction (tred)**:
    `igda tred -r -l 0 -p 0 -j <threshold> <input.ann>`
*   **Assemble Contigs**:
    `igda assemble <input.ann> <output.tred.dot>`

### Advanced Assembly Processing (R-based)
These scripts require `rGDA` and `intervals` libraries.

*   **Gap Filling**:
    `ann_fill_gap <ann_file> <recode_file> <m5_file> <ref_file> <left_n> <right_n> <min_prop> <outdir>`
    *   `left_n`/`right_n`: Number of loci to check to the left/right of a gap.
    *   `min_prop`: Minimum proportion of reads supporting the fill.
*   **Diploid Reconstruction**:
    `ann_to_diploid <ann_file> <var_file> <outdir>`
    Used to expand haploid contigs into diploid representations by identifying and flipping SNVs within contig ranges.

### Data Conversion
*   **BAM to FASTA/FASTQ**:
    `bamtofasta <input.bam> <output.fasta>`
    `bamtofastq <input.bam> <output.fastq>`
    *Use `_dir` versions (e.g., `bamtofasta_dir`) for batch processing entire directories.*

## Expert Tips
*   **Memory Management**: When running `align_genome_dir`, ensure the environment has sufficient cores as the script may attempt to process files sequentially but `minimap2` itself is resource-intensive.
*   **File Extensions**: Many scripts in this suite are hardcoded to look for specific extensions (e.g., `.fasta` or `.bam`). Ensure your input files match these expectations or the scripts will return empty results.
*   **R Dependencies**: The `ann_fill_gap` and `ann_to_diploid` scripts depend on the `rGDA` package. Ensure this is installed in the R environment before execution.



## Subcommands

| Command | Description |
|---------|-------------|
| add_gq_to_vcf | Add GQ (Genotype Quality) to VCF file |
| est_depth | only work for single chromosome data |
| fastq2fasta | Converts FASTQ format to FASTA format. |
| igda-script_est_depth_dir | only work for single chromosome data |
| igda-script_getbambyregion | Extract BAM alignments within a specified genomic region. |
| igda-script_getbambyregion_dir | Get BAM files by region within a directory |
| igda-script_split_range | Splits a range into segments. |
| igda_pipe_detect | Detects structural variants using IGDA pipeline. |
| igda_pipe_detect_ont | Detects ONT reads using IGDA pipeline |
| igda_pipe_detect_pb | Detects potential structural variations in sequencing data. |
| igda_pipe_phase | Phase contigs using PacBio or Oxford Nanopore sequencing data. |
| igda_pipe_phase | Phases diploid genomes using PacBio or Oxford Nanopore sequencing data. |
| igda_pipe_phase_ont | Phase ONT reads using IGDA |
| igda_pipe_phase_pb | Performs phasing of pangenome graphs. |
| igda_pipe_phase_pb | Phase diploid genomes using long reads |

## Reference documentation
- [add_gq_to_vcf source](./references/github_com_zhixingfeng_shell_blob_master_add_gq_to_vcf.md)
- [align_genome source](./references/github_com_zhixingfeng_shell_blob_master_align_genome.md)
- [ann_fill_gap logic](./references/github_com_zhixingfeng_shell_blob_master_ann_fill_gap.md)
- [ann_to_diploid logic](./references/github_com_zhixingfeng_shell_blob_master_ann_to_diploid.md)