---
name: consensusfixer
description: ConsensusFixer computes consensus sequences from deep next-generation sequencing alignments while handling ambiguous bases and in-frame insertions. Use when user asks to generate a consensus sequence from a BAM file, call IUPAC ambiguity codes, or preserve reading frames during consensus generation.
homepage: https://github.com/cbg-ethz/ConsensusFixer
---


# consensusfixer

## Overview
ConsensusFixer is a specialized tool for computing consensus sequences from ultra-deep next-generation sequencing (NGS) alignments. Unlike standard consensus callers, it is designed to handle complex genomic features such as ambiguous nucleotide calls (wobbles), in-frame insertions, and deletions. It is particularly effective for analyzing viral populations or microbial samples where minority variants and structural consistency are critical. The tool processes BAM alignments and can integrate results directly into a provided reference sequence.

## Command Line Usage

### Basic Execution
Run the tool using the Java archive. At minimum, an input BAM file is required.
```bash
java -jar ConsensusFixer.jar -i alignment.bam
```

### Common Workflow Patterns
*   **Reference-Based Consensus**: Integrate the consensus into a known reference to maintain coordinate consistency.
    ```bash
    java -jar ConsensusFixer.jar -i alignment.bam -r reference.fasta -o ./output_dir
    ```
*   **Calling Ambiguous Bases (Wobbles)**: Use the `-plurality` flag to set the sensitivity for IUPAC ambiguity codes.
    ```bash
    # Call a wobble if a secondary base has >1% frequency
    java -jar ConsensusFixer.jar -i alignment.bam -plurality 0.01
    ```
*   **Preserving Reading Frames**: Ensure that only insertions that do not cause frameshifts are included.
    ```bash
    java -jar ConsensusFixer.jar -i alignment.bam -f
    ```
*   **Majority Vote Mode**: Perform a strict majority vote while respecting the gap threshold.
    ```bash
    java -jar ConsensusFixer.jar -i alignment.bam -m -pluralityN 0.5
    ```

### Parameter Reference
*   `-i`: Input alignment file (BAM format).
*   `-r`: Reference file (FASTA format).
*   `-o`: Output directory path.
*   `-mcc [INT]`: Minimal coverage required to call a consensus base.
*   `-mic [INT]`: Minimal coverage required to include an insertion.
*   `-plurality [DOUBLE]`: Threshold for integrating a base into a wobble (default: 0.05).
*   `-pluralityN [DOUBLE]`: Threshold for calling a gap as 'N' (default: 0.5).
*   `-f`: Only allow in-frame insertions (multiples of 3).
*   `-dash`: Use '-' characters instead of reference bases for gaps.
*   `--stats`: Generate position-wise statistics and a list of deletions.

## Expert Tips and Best Practices

### Memory Management for Large Datasets
ConsensusFixer can be memory-intensive with very deep alignments. Use specific JVM flags to optimize performance:
*   **Standard Optimization**: `java -XX:NewRatio=9 -jar ConsensusFixer.jar ...`
*   **High Memory Allocation**: For very large datasets, increase the heap space: `java -Xmx10G -XX:NewRatio=9 -jar ConsensusFixer.jar ...`
*   **Multi-core Systems**: Enable parallel garbage collection: `java -XX:+UseParallelGC -XX:NewRatio=9 -jar ConsensusFixer.jar ...`

### Handling Insertions
*   **Major Insertion Only**: Use `-mi` to only incorporate the single most frequent insertion at a position that passes the `-mic` threshold.
*   **Progressive Mode**: Use `-pi` and `-pis [INT]` (window size) for progressive insertion handling in complex regions.

### Quality Control
*   Always use the `--stats` flag during initial runs to review the `deletions.txt` and position-wise statistics. This helps verify if the `-mcc` and `-plurality` thresholds are appropriate for your sequencing depth and expected error rate.
*   If the output contains unexpected "N" characters, check the `-pluralityN` setting; this determines the ratio of gaps to bases required to mask a position.

## Reference documentation
- [ConsensusFixer GitHub Repository](./references/github_com_cbg-ethz_ConsensusFixer.md)
- [Bioconda ConsensusFixer Overview](./references/anaconda_org_channels_bioconda_packages_consensusfixer_overview.md)