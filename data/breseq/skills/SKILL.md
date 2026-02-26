---
name: breseq
description: breseq finds mutations and variants in short-read DNA re-sequencing data relative to a reference sequence. Use when user asks to analyze bacterial genomes for mutations, identify variants, and understand genomic differences.
homepage: https://github.com/barricklab/breseq
---


# breseq

yaml
name: breseq
description: A computational pipeline for finding mutations relative to a reference sequence in short-read DNA re-sequencing data. Use when analyzing bacterial genomes for mutations, identifying variants, and understanding genomic differences.
```
## Overview
breseq is a command-line tool designed for the analysis of short-read DNA re-sequencing data, specifically for identifying mutations and variants within microbial genomes. It excels at comparing sequencing data against a reference genome to pinpoint genetic differences. This tool is particularly useful for researchers working with haploid microbial genomes.

## Usage Instructions

breseq is a powerful tool for variant calling in microbial re-sequencing data. Here are some best practices and common usage patterns:

### Core Command Structure

The fundamental command structure for `breseq` is:

```bash
breseq <input_reads_fastq_or_bam> --ref <reference_genome_fasta> [options]
```

### Essential Options

*   `--ref <reference_genome.fasta>`: **Required.** Specifies the path to the reference genome in FASTA format. This is crucial for variant calling.
*   `--outdir <output_directory>`: Specifies the directory where all output files will be saved. If not provided, output goes to the current directory.
*   `--paired-end`: Use this flag if your input reads are paired-end.
*   `--bam`: Use this flag if your input reads are in BAM format instead of FASTQ.
*   `--threads <number>`: Sets the number of CPU threads to use for the analysis. This can significantly speed up processing.
*   `--verbose`: Enables verbose output, which can be helpful for debugging.

### Common Analysis Scenarios

#### Basic Mutation Calling

For a standard analysis of paired-end FASTQ files against a reference:

```bash
breseq reads.fastq --ref genome.fasta --outdir breseq_output --paired-end --threads 8
```

#### Analyzing BAM Files

If you already have aligned reads in a BAM file:

```bash
breseq aligned_reads.bam --ref genome.fasta --outdir breseq_output --bam --threads 8
```

#### Advanced Options and Considerations

*   **Contig Analysis**: For genomes with multiple contigs, ensure your reference FASTA file is correctly formatted.
*   **Output Interpretation**: `breseq` generates several output files, including an HTML report (`.report.html`) which is the primary visualization of mutations, and tabular files (`.tsv`) for detailed variant information. Familiarize yourself with the output formats for effective interpretation.
*   **Memory Usage**: For large datasets or genomes, `breseq` can be memory-intensive. Monitor system resources and consider increasing available RAM if needed.
*   **Error Handling**: If `breseq` fails, check the verbose output and the log files within the output directory for specific error messages. Common issues include incorrect reference file formatting or insufficient disk space.

### Expert Tips

*   **Reference Genome Quality**: The accuracy of your mutation calls is highly dependent on the quality and completeness of your reference genome. Ensure it is properly assembled and annotated.
*   **Input Read Quality**: High-quality sequencing reads are essential. Perform quality control on your FASTQ files (e.g., using FastQC) before running `breseq`.
*   **Reproducibility**: Always record the exact `breseq` command and version used for your analysis to ensure reproducibility.
*   **Customization**: Explore the `breseq` documentation for more advanced options related to specific types of mutations, filtering, and output customization.

## Reference documentation
- [breseq Usage Documentation](./references/github_com_barricklab_breseq.md)
- [breseq Installation and Overview](./references/anaconda_org_channels_bioconda_packages_breseq_overview.md)