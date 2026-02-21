---
name: damidseq_pipeline
description: The `damidseq_pipeline` is a comprehensive tool designed to handle the specialized requirements of DNA Adenine Methyltransferase Identification (DamID) sequencing.
homepage: https://github.com/owenjm/damidseq_pipeline
---

# damidseq_pipeline

## Overview
The `damidseq_pipeline` is a comprehensive tool designed to handle the specialized requirements of DNA Adenine Methyltransferase Identification (DamID) sequencing. It automates the transition from raw sequencing reads to binned, normalized signal tracks. The pipeline manages sequence alignment via Bowtie2, read extension to GATC fragments, count binning, and the generation of log2 ratios between a protein-of-interest and a Dam-only control.

## Initial Configuration
Before the first run, the pipeline requires the location of the genome indices and the GATC fragment file. These settings are cached for future use.

```bash
# Configure the pipeline with genome and GATC fragment paths
damidseq_pipeline --gatc_frag_file=/path/to/GATC.gff.gz --bowtie2_genome_dir=/path/to/bowtie2_index_base
```

*   **GATC Fragment Files**: If a pre-built GFF is not available, generate one using the included utility:
    `perl gatc.track.maker.pl --name=genome_version genome_sequence.fasta`
*   **Resetting Defaults**: To clear saved paths or configurations, use the `--reset_defaults` flag.

## Execution Patterns

### Standard Batch Processing
The pipeline is designed to process all files in a directory. By default, it looks for FASTQ files; if none are found, it defaults to BAM.

```bash
# Process all files in the current directory
damidseq_pipeline

# Process files in a specific directory (v1.6+)
damidseq_pipeline --datadir=/path/to/data
```

### Manual Control Selection
If the pipeline cannot automatically identify the "Dam-only" control (usually identified by the "Dam" prefix), specify it manually:

```bash
damidseq_pipeline --dam=Dam_control_sample.fastq
```

## File Naming and Grouping
The pipeline uses specific string patterns to group replicates and experiments.

*   **Naming Convention**: Start filenames with the protein name (e.g., `Myc_rep1.fastq`, `Myc_rep2.fastq`, `Dam_control.fastq`).
*   **Experiment Grouping**: Controlled by `--exp_prefix` (default `_`) and `--rep_prefix` (default `_n`).
*   **Custom Grouping**: If your files follow a different pattern (e.g., `Myc-Ex1-R1.fastq`), adjust the prefixes:
    `damidseq_pipeline --exp_prefix=-Ex --rep_prefix=-R`

## Normalization and Output
The pipeline produces log2 ratio files in **bedGraph** format.

*   **Normalization Methods**: Change the default normalization if required for specific datasets:
    `--norm_method=[rpm|total_reads|none]` (Default is usually appropriate for standard DamID).
*   **Read Extension**: Reads are typically extended to the next GATC fragment. To disable this and use full read extension, use `--extension_method=full`.
*   **CATaDa Support**: For Chromatin Accessibilty Transcripted-only DamID, use the `--catada` flag to generate appropriate outputs.

## Expert Tips
*   **ChIP-seq/CUT&RUN**: While designed for DamID, the pipeline can process ChIP-seq or CUT&RUN data by treating the "Input" or "IgG" as the "Dam" control.
*   **Memory Management**: For very large datasets or high-resolution genomes, ensure the environment has sufficient RAM for Bowtie2 and the Perl-based binning process.
*   **Alignment**: If using pre-aligned BAM files, ensure they were aligned to the same genome version used to generate the GATC fragment GFF file to avoid coordinate mismatches.

## Reference documentation
- [GitHub Repository README](./references/github_com_owenjm_damidseq_pipeline.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_damidseq_pipeline_overview.md)