---
name: rseqc
description: RSeQC is a bioinformatics suite used to evaluate the quality and technical biases of RNA-seq data by analyzing mapped reads against genomic features. Use when user asks to infer library strand specificity, assess gene body coverage, calculate transcript integrity numbers, or analyze the distribution of reads across genomic regions.
homepage: https://rseqc.sourceforge.net
metadata:
  docker_image: "quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1"
---

# rseqc

## Overview
RSeQC is a specialized bioinformatics suite used to assess the quality of RNA-seq experiments. While standard QC tools (like FastQC) focus on raw reads, RSeQC analyzes mapped data to identify biological and technical biases. It helps researchers determine if a library is stranded, check for RNA degradation via gene body coverage, and quantify the distribution of reads across genomic features like exons, introns, and intergenic regions.

## Core CLI Usage Patterns

Most RSeQC scripts follow a standard syntax requiring an input BAM file and a reference gene model in BED format.

### 1. Verifying Library Metadata
Before downstream analysis (like differential expression), use these tools to verify library construction.

*   **Infer Strand Specificity**: Determines if the library is stranded (e.g., ISR, ISF) or unstranded.
    ```bash
    infer_experiment.py -i input.bam -r reference.bed
    ```
*   **Mapping Statistics**: Provides a summary of total reads, mapped/unmapped counts, and QC failures.
    ```bash
    bam_stat.py -i input.bam
    ```

### 2. Assessing RNA Integrity and Bias
*   **Gene Body Coverage**: Checks if reads are uniformly distributed across the transcript or biased towards the 3' or 5' end (indicating degradation).
    ```bash
    geneBody_coverage.py -i input.bam -r reference.bed -o output_prefix
    ```
    *Tip: For large BAM files, use `-i` with a list of BAMs or run on a subset of housekeeping genes to save time.*
*   **TIN (Transcript Integrity Number)**: Calculates a score for every transcript, similar to RIN but based on sequencing data.
    ```bash
    tin.py -i input.bam -r reference.bed
    ```

### 3. Genomic Feature Distribution
*   **Read Distribution**: Calculates how many reads map to CDS exons, 5'UTRs, 3'UTRs, introns, and intergenic regions.
    ```bash
    read_distribution.py -i input.bam -r reference.bed
    ```
*   **Junction Annotation**: Categorizes splice junctions as "known" (in reference), "novel", or "partially novel".
    ```bash
    junction_annotation.py -i input.bam -r reference.bed -o output_prefix
    ```

### 4. Sequencing Depth and Saturation
*   **Junction Saturation**: Determines if the current sequencing depth is sufficient to detect all splice junctions.
    ```bash
    junction_saturation.py -i input.bam -r reference.bed -o output_prefix
    ```
*   **RPKM Saturation**: Checks if the RPKM values (expression levels) have reached a plateau at the current depth.
    ```bash
    RPKM_saturation.py -i input.bam -r reference.bed -o output_prefix
    ```

## Expert Tips and Best Practices
*   **BED File Selection**: Ensure your BED file (e.g., RefSeq, Ensembl) matches the exact genome version used for alignment. Mismatched coordinates will result in zero or nonsensical overlaps.
*   **Housekeeping Genes**: When running `geneBody_coverage.py`, using a BED file containing only 100-200 high-expression housekeeping genes provides a reliable estimate of bias much faster than using the whole transcriptome.
*   **Paired-End Data**: For paired-end BAMs, use `inner_distance.py` to calculate the distance between read pairs, which is critical for verifying the fragment size distribution expected from your library prep.
*   **Output Interpretation**: RSeQC generates R scripts alongside text outputs. Run these R scripts to automatically generate PDF/PNG visualizations of the QC metrics.



## Subcommands

| Command | Description |
|---------|-------------|
| bam_stat.py | Summarizing mapping statistics of a BAM file. |
| geneBody_coverage.py | Calculate the RNA-seq signals coverage over gene body. This tool is used to check if read coverage is uniform and if there is any 5'/3' bias. |

## Reference documentation
- [RSeQC Main Index](./references/rseqc_sourceforge_net_index.md)
- [RSeQC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rseqc_overview.md)
- [Gene Body Coverage Workflow](./references/rseqc_sourceforge_net__images_geneBody_workflow.png.md)
- [Inner Distance Concept](./references/rseqc_sourceforge_net__images_inner_distance_concept.png.md)