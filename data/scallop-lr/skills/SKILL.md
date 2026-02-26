---
name: scallop-lr
description: "Scallop-LR assembles long-read RNA-seq data into transcripts using a reference genome. Use when user asks to assemble long-read RNA-seq data to transcripts."
homepage: https://github.com/Kingsford-Group/lrassemblyanalysis
---


# scallop-lr

yaml
name: scallop-lr
description: |
  Scallop-LR is a reference-based transcriptome assembler for long-read RNA-seq data.
  Use this skill when you need to assemble RNA sequencing reads into transcripts,
  specifically when working with long-read data (e.g., PacBio Iso-Seq) and a reference genome is available.
  This skill is suitable for analyzing datasets that have been pre-processed into a BioSample-based format.
---
## Overview

Scallop-LR is a specialized tool designed for assembling RNA sequencing data into transcript sequences, particularly when dealing with long-read technologies like PacBio Iso-Seq. It leverages a reference genome to guide the assembly process, making it effective for identifying and reconstructing full-length isoforms. This skill is best utilized when you have pre-processed long-read RNA-seq data and a corresponding reference genome and annotation available.

## Usage Instructions

Scallop-LR is a command-line tool. The primary command is `scallop-lr`.

### Core Functionality and Parameters

The general usage pattern involves providing input reads, a reference genome, and an annotation file.

**Basic Command Structure:**

```bash
scallop-lr -r <reads.bam> -g <genome.fa> -a <annotation.gtf> -o <output_dir> [options]
```

**Key Parameters:**

*   `-r, --reads`: Path to the input BAM file containing long reads. These reads should be aligned to the reference genome.
*   `-g, --genome`: Path to the reference genome FASTA file.
*   `-a, --annotation`: Path to the reference annotation GTF file. This is crucial for guiding the assembly process.
*   `-o, --output-dir`: Directory where the assembled transcripts and other output files will be saved.
*   `-p, --prefix`: Prefix for output files.
*   `-t, --threads`: Number of threads to use for computation.
*   `--min-fl-len`: Minimum full-length read length to consider for assembly.
*   `--min-fl-cov`: Minimum coverage for a full-length read to be considered.
*   `--max-intron-len`: Maximum intron length to consider.
*   `--min-isoform-expr`: Minimum expression level for an isoform to be reported.

### Expert Tips and Best Practices

1.  **Input Data Preparation:** Ensure your input reads (`.bam` file) are aligned to the reference genome using a compatible aligner (e.g., Minimap2, GMAP). The BAM file should be sorted and indexed.
2.  **Reference and Annotation Quality:** The accuracy of the assembly heavily relies on the quality and completeness of the reference genome and its corresponding annotation (GTF file). Use up-to-date and well-curated references.
3.  **Parameter Tuning:**
    *   For datasets with very long reads, consider adjusting `--min-fl-len` and `--max-intron-len` based on known biological characteristics of your organism.
    *   The `--min-isoform-expr` parameter can help filter out low-abundance transcripts, which can be useful for reducing noise.
4.  **Output Interpretation:** Scallop-LR typically outputs assembled transcripts in GTF format. These can be further analyzed using tools like Gffcompare for quality assessment and comparison against known annotations.
5.  **Version Compatibility:** Be mindful of the Scallop-LR version. Older versions (e.g., v0.9.1) might use the binary name `scallop`, while newer versions (e.g., v0.9.2 and later) use `scallop-lr`. Ensure the correct binary is in your PATH.

### Example Workflow Snippet

This example assumes you have your aligned reads in `aligned_reads.bam`, your reference genome in `genome.fa`, and your annotation in `annotation.gtf`.

```bash
scallop-lr \
  -r aligned_reads.bam \
  -g genome.fa \
  -a annotation.gtf \
  -o scallop_output \
  -p my_experiment \
  -t 8 \
  --min-fl-len 100 \
  --max-intron-len 50000
```

This command will run Scallop-LR using 8 threads, specifying minimum full-length read length and maximum intron length, and save the output in the `scallop_output` directory with a prefix `my_experiment`.

## Reference documentation

- [Overview: Long-Read Transcript Assembly Analysis](./references/github_com_Kingsford-Group_lrassemblyanalysis.md)