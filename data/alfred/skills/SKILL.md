---
name: alfred
description: Alfred is a comprehensive bioinformatics toolset for analyzing, quality-controlling, and quantifying BAM and CRAM alignment files. Use when user asks to perform alignment quality control, count DNA or RNA features, annotate genomic peaks with motifs, generate browser tracks, or conduct haplotype-resolved analysis.
homepage: https://github.com/tobiasrausch/alfred
---


# alfred

## Overview
Alfred is a comprehensive bioinformatics toolset for analyzing BAM/CRAM alignment files. It provides a unified interface for generating quality control metrics, quantifying read counts across genomic windows or gene annotations, and performing functional annotations on peaks and motifs. Beyond standard QC, Alfred supports advanced workflows such as haplotype-specific BAM splitting, allele-specific expression analysis, and consensus sequence generation for long-read data.

## Core CLI Workflows

### Alignment Quality Control (QC)
The `qc` subcommand is the primary entry point for assessing library quality.
*   **Standard QC**: Always provide the reference genome to calculate full metrics.
    ```bash
    alfred qc -r reference.fa -o qc.tsv.gz input.bam
    ```
*   **Web-Ready Output**: Generate a JSON file to upload to the [Alfred Web App](https://www.gear-genomics.com/alfred) for interactive visualization.
    ```bash
    alfred qc -r reference.fa -j qc.json.gz -o qc.tsv.gz input.bam
    ```
*   **Targeted/Exome Sequencing**: Use a BED file to calculate on-target rates and coverage over specific regions.
    ```bash
    alfred qc -r reference.fa -b targets.bed.gz -o qc.tsv.gz input.bam
    ```

### Feature Counting
Alfred supports various quantification modes for DNA and RNA.
*   **DNA-Seq Coverage**: Calculate coverage in windows or specific intervals.
    ```bash
    alfred count_dna -o coverage.gz input.bam
    ```
*   **RNA-Seq Quantification**: Count reads by gene or transcript using a GTF file.
    ```bash
    alfred count_rna -g annotation.gtf.gz input.bam
    ```
*   **Splice Junctions**: Identify and count exon-exon junction support.
    ```bash
    alfred count_jct -g annotation.gtf.gz input.bam
    ```

### Feature and Motif Annotation
Use `annotate` to link genomic coordinates (like peaks) to biological features.
*   **Peak Annotation**: Find neighboring genes within a specific distance (e.g., 10kb).
    ```bash
    alfred annotate -d 10000 -g annotation.gtf.gz peaks.bed
    ```
*   **Motif Discovery**: Annotate peaks with motif hits using Position Weight Matrices (PWMs).
    ```bash
    alfred annotate -r reference.fa -m motifs.jaspar.gz peaks.bed
    ```

### Browser Track Generation
Create size-optimized bedGraph files for genome browsers like UCSC or IGV.
*   **Resolution Control**: Use `-r` to set the resolution (e.g., 0.2). Lower values create smaller files; higher values provide finer detail.
    ```bash
    alfred tracks -r 0.2 -o sample.bedGraph.gz input.bam
    ```

### Haplotype-Resolved Analysis
For phased data, Alfred can split alignments or analyze allele-specific expression.
*   **BAM Splitting**: Separate a BAM into two haplotype-specific files using phased SNPs (BCF).
    ```bash
    alfred split -r ref.fa -s SampleID -v phased.bcf -p hap1.bam -q hap2.bam input.bam
    ```
*   **Allele-Specific Expression (ASE)**: Generate ASE tables from phased or unphased SNPs.
    ```bash
    alfred ase -r ref.fa -s SampleID -v snps.bcf -a ase.tsv input.bam
    ```

## Expert Tips and Best Practices
*   **Memory Efficiency**: Alfred is optimized for speed. When processing large cohorts, use the `-j` (JSON) output for multi-sample comparison in the web interface rather than merging TSVs manually.
*   **ATAC-Seq QC**: For ATAC-Seq, check the TSS enrichment and fragment size distribution. A "good" library typically has a TSS enrichment > 5 and a clear nucleosome banding pattern in the insert size plot.
*   **Normalization**: The `tracks` command normalizes to 30 million reads by default, making peak heights directly comparable across different samples.
*   **Long-Read Consensus**: Use the `consensus` subcommand after `split` to generate high-quality haplotype-specific consensus sequences from error-prone long reads (ONT/PacBio).



## Subcommands

| Command | Description |
|---------|-------------|
| alfred annotate | Annotate peaks with GTF/GFF3, BED, or motif information. |
| alfred ase | Allele-specific expression analysis using alfred |
| alfred bam2match | Extract matches from a BAM file against a reference genome |
| alfred barcode | Generate Hamming-distanced barcodes for sequencing experiments. |
| alfred bcsplit | Split FASTQ files based on barcodes and UMIs |
| alfred consensus | Generate consensus sequences from BAM or FASTA files |
| alfred count_dna | Count DNA coverage and fragments from aligned BAM files |
| alfred count_jct | Count exon-exon junction reads from aligned BAM files using GTF/GFF3 or BED annotations. |
| alfred count_rna | RNA-seq counting tool for GTF/GFF3 or BED files |
| alfred pwalign | Pairwise sequence alignment of two FASTA files |
| alfred pwedit | Pairwise sequence alignment and editing tool |
| alfred qc | Quality control for aligned sequencing reads |
| alfred replication | Alfred replication analysis tool for analyzing replication timing using BAM files and a reference genome. |
| alfred spaced_motif | Identify and join spaced motifs from motif hits |
| alfred split | Split unphased BAM files into haplotype-specific BAM files using phased variants. |
| alfred telmotif | Identify telomeric motifs in sequencing data |
| alfred tracks | Generate track files from aligned BAM files |

## Reference documentation
- [Alfred CLI Usage Guide](./references/www_gear-genomics_com_docs_alfred_cli.md)
- [Alfred GitHub Repository Overview](./references/github_com_tobiasrausch_alfred.md)
- [Alfred README and Installation](./references/github_com_tobiasrausch_alfred_blob_main_README.md)