---
name: salmon
description: Salmon estimates transcript-level abundances from RNA-seq data using selective alignment or existing alignments. Use when user asks to index a transcriptome, quantify transcript expression from FASTQ or BAM files, or perform bias correction and bootstrapping for RNA-seq analysis.
homepage: https://github.com/COMBINE-lab/salmon
---


# salmon

## Overview
Salmon is a high-performance tool designed to estimate transcript-level abundances from RNA-seq data with high accuracy and speed. It achieves this through selective alignment and advanced inference algorithms. The tool is versatile, supporting both "mapping-based" mode (processing raw FASTQ files) and "alignment-based" mode (processing existing BAM files). It is a core component of modern transcriptomics pipelines, particularly when researchers need to account for multi-mapping reads and fragment-level biases.

## Core Workflows and CLI Patterns

### 1. Indexing the Transcriptome
Before quantification, you must create an index. Salmon supports three primary indexing strategies, with decoy-aware indexing being the recommended best practice to reduce false positives.

*   **cDNA-only Index (Basic):**
    ```bash
    salmon index -t transcripts.fa -i transcript_index
    ```
*   **Decoy-aware Index (Recommended):**
    To prevent reads from genomic regions that look like transcripts from being misassigned, include the whole genome as a "decoy."
    1. Concatenate transcriptome and genome: `cat transcripts.fa genome.fa > gentrome.fa`
    2. Create a `decoys.txt` file containing the names of the genome sequences.
    3. Run indexing:
    ```bash
    salmon index -t gentrome.fa -d decoys.txt -i decoy_index
    ```

### 2. Quantification (Mapping-based Mode)
This is the most common usage, where Salmon aligns raw reads directly to the index.

*   **Paired-end reads with automatic library type detection:**
    ```bash
    salmon quant -i transcript_index -l A -1 reads_1.fq.gz -2 reads_2.fq.gz --validateMappings -o quants_directory
    ```
*   **Single-end reads:**
    ```bash
    salmon quant -i transcript_index -l A -r reads.fq.gz --validateMappings -o quants_directory
    ```

### 3. Quantification (Alignment-based Mode)
Use this if you have already aligned reads to the transcriptome using another aligner (like STAR) and have a BAM file.

```bash
salmon quant -t transcripts.fa -l A -a alignments.bam -o quants_directory
```

## Expert Tips and Best Practices

*   **Library Type (`-l`):** While `-l A` (automatic) is convenient, explicitly defining the library type (e.g., `ISR` for stranded paired-end) can prevent errors if the automated check fails due to low mapping rates.
*   **Selective Alignment:** Always use `--validateMappings` in mapping-based mode. This enables a more sensitive and accurate alignment sensitive to the specific sequence of the fragments.
*   **Bias Correction:** For high-quality results, enable sequence-specific and GC-content bias correction:
    ```bash
    salmon quant ... --seqBias --gcBias
    ```
*   **Bootstrapping:** To estimate technical variance in quantification (useful for downstream differential expression tools like Sleuth), use the `--numBootstraps` flag:
    ```bash
    salmon quant ... --numBootstraps 100
    ```
*   **Single-Cell Analysis:** For single-cell RNA-seq (10x, Drop-seq, etc.), use the `alevin` subcommand. This requires a specific reference (splici) and a transcript-to-gene mapping file.

## Reference documentation
- [Salmon GitHub Repository](./references/github_com_COMBINE-lab_salmon.md)
- [Salmon Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_salmon_overview.md)