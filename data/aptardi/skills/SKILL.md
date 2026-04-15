---
name: aptardi
description: aptardi uses machine learning to improve the annotation of 3' transcript boundaries by predicting polyA sites from DNA sequences and RNA-Seq data. Use when user asks to refine 3' terminal exons, identify new transcript isoforms, or improve transcriptome annotations.
homepage: https://github.com/luskry/aptardi
metadata:
  docker_image: "quay.io/biocontainers/aptardi:1.4--pyh5e36f6f_0"
---

# aptardi

## Overview
aptardi is a machine learning-based tool that improves the annotation of 3' transcript boundaries. While standard transcriptome assembly from RNA-Seq often struggles with precise 3' end detection, aptardi leverages both the underlying DNA sequence and aligned RNA-Seq reads to predict polyA sites. It evaluates 3' terminal exons of input transcripts and outputs a refined GTF/GFF file containing newly identified isoforms.

## Installation and Environment
Install aptardi via Conda. Note that `samtools` and `bedtools` are required dependencies but should ideally be managed to avoid version conflicts within the same environment.

```bash
conda create -n aptardi_env -c conda-forge -c bioconda aptardi
conda activate aptardi_env
```

## Canonical Usage (Mode 1: Pre-built Model)
The most common workflow uses the pre-built machine learning model provided in the aptardi repository (`src/aptardi/ml_scale`).

### Required Inputs
*   **Output Directory (`--o`)**: Absolute path for results.
*   **Genome FASTA (`--f`)**: Reference genome where headers match the BAM/GTF chromosomes.
*   **Input GTF (`--r`)**: Transcriptome file (e.g., from StringTie).
*   **BAM File (`--b`)**: Sorted RNA-Seq alignments.
*   **Model File (`--n`)**: Path to `model.hdf5`.
*   **Scale File (`--t`)**: Path to `scale.pk`.

### Execution Command
```bash
aptardi --o /absolute/path/to/output \
        --f reference.fasta \
        --r input.gtf \
        --b sorted_alignments.bam \
        --n model.hdf5 \
        --t scale.pk \
        --g output_refined.gtf
```

## Advanced Configuration
*   **Probability Threshold (`--p`)**: Default is `0.5`. Increase this value (e.g., `0.8`) to reduce false positives or decrease it to increase sensitivity.
*   **Transcript Length (`--i`)**: Sets the maximum number of bins analyzed per transcript. Default is `300`. With a default bin size of 100bp, this covers 30,000 bases.
*   **Strand Orientation (`--a`)**: For paired-end data, specify `fr` (firststrand/Illumina, default) or `rf` (secondstrand).

## Expert Tips and Best Practices
*   **Input GTF Source**: While designed to work with StringTie output, aptardi can process other GTF/GFF formats. Ensure the chromosome naming is consistent across the FASTA, BAM, and GTF files.
*   **Mandatory Filtering**: aptardi adds new transcripts to the existing transcriptome rather than replacing them. This often results in redundant isoforms. It is highly recommended to filter the output:
    1.  Quantitate the aptardi-generated transcriptome (e.g., using RSEM).
    2.  Remove transcripts that do not meet a minimum expression threshold (e.g., at least 1 count in 2/3 of samples).
*   **Bin Size**: Do not change the bin size (`--w`) when using the pre-built model, as the model was specifically trained on 100bp bins.
*   **Debugging**: Use the `--d` flag to save intermediate files if the tool fails to produce the expected GTF output.

## Reference documentation
- [aptardi GitHub Repository](./references/github_com_luskry_aptardi.md)
- [aptardi Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_aptardi_overview.md)