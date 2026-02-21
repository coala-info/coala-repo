---
name: rseqc
description: rseqc is a specialized suite of tools designed to perform deep quality control on RNA-seq data.
homepage: https://rseqc.sourceforge.net
---

# rseqc

## Overview
rseqc is a specialized suite of tools designed to perform deep quality control on RNA-seq data. It allows researchers to move beyond simple mapping statistics to understand the biological and technical nuances of their sequencing libraries. By analyzing BAM files against reference gene models (BED files), rseqc identifies issues such as RNA degradation, DNA contamination, and incorrect library preparation protocols.

## Core Workflows and CLI Patterns

### 1. Library Statistics and Strand Specificity
Before analysis, verify the basic mapping stats and whether the library is stranded.

*   **Basic Stats**: Summarize mapping results (total reads, QC failure, duplicate reads, etc.).
    ```bash
    bam_stat.py -i input.bam
    ```
*   **Infer Experiment**: Determine if the library is "sense", "antisense", or "unstranded" by comparing to a reference gene model.
    ```bash
    infer_experiment.py -i input.bam -r reference.bed
    ```

### 2. Transcript Coverage and Bias
Assess if sequencing covers the entire transcript or is biased toward the 5' or 3' ends, which often indicates RNA degradation.

*   **Gene Body Coverage**: Calculate the RNA-seq signals over the gene body.
    ```bash
    # For a single file
    geneBody_coverage.py -i input.bam -r reference.bed -o output_prefix
    
    # For multiple files (generates a comparison plot)
    geneBody_coverage.py -i bam_directory/ -r reference.bed -o output_prefix
    ```

### 3. Mapping Distribution
Determine where reads are mapping (exons, introns, or intergenic regions). High intronic mapping may suggest DNA contamination.

*   **Read Distribution**:
    ```bash
    read_distribution.py -i input.bam -r reference.bed
    ```

### 4. Paired-End Specific Metrics
For paired-end data, evaluate the distance between read pairs.

*   **Inner Distance**: Calculate the "inner distance" (or insert size) between paired-end reads.
    ```bash
    inner_distance.py -i input.bam -r reference.bed -o output_prefix
    ```

### 5. Splicing and Junction Analysis
Evaluate the quality of splice junction detection.

*   **Junction Annotation**: Compare detected junctions with the reference gene model.
    ```bash
    junction_annotation.py -i input.bam -r reference.bed -o output_prefix
    ```
*   **Junction Saturation**: Check if the current sequencing depth is sufficient to detect all splice junctions.
    ```bash
    junction_saturation.py -i input.bam -r reference.bed -o output_prefix
    ```

## Expert Tips
*   **Reference Files**: Most rseqc tools require a gene model in BED format. Ensure your BED file matches the chromosome naming convention (e.g., "chr1" vs "1") used in your BAM file.
*   **Memory Management**: `geneBody_coverage.py` can be memory-intensive with large BAM files. If it fails, consider using a subset of genes (e.g., 1000-2000 housekeeping genes) rather than the entire genome.
*   **Output Interpretation**: 
    *   **Inner Distance**: A negative inner distance indicates that the two reads in a pair overlap.
    *   **Read Distribution**: In a high-quality poly-A enriched library, >80% of reads should map to CDS exons.

## Reference documentation
- [rseqc Index](./references/rseqc_sourceforge_net_index.md)
- [Gene Body Workflow](./references/rseqc_sourceforge_net__images_geneBody_workflow.png.md)
- [Inner Distance Concept](./references/rseqc_sourceforge_net__images_inner_distance_concept.png.md)
- [Junction Interaction](./references/rseqc_sourceforge_net__images_junction_interact.png.md)