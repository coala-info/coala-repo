---
name: detonate
description: DETONATE (DE novo TranscriptOme rNa-seq Assembly with or without the Truth Evaluation) is a computational framework for assessing the quality of transcriptome assemblies.
homepage: https://github.com/deweylab/detonate
---

# detonate

## Overview
DETONATE (DE novo TranscriptOme rNa-seq Assembly with or without the Truth Evaluation) is a computational framework for assessing the quality of transcriptome assemblies. It is particularly useful in de novo scenarios where a gold-standard reference genome may be unavailable. The tool provides two distinct evaluation paths:
1. **RSEM-EVAL**: A reference-free approach that uses a probabilistic model to score how well the RNA-Seq reads support the assembly. It balances assembly compactness with read alignment likelihood.
2. **REF-EVAL**: A reference-based toolkit that calculates traditional metrics (precision, recall, F1) and k-mer based scores (KC score) by comparing the assembly against known reference sequences.

## CLI Usage and Best Practices

### RSEM-EVAL (Reference-Free)
RSEM-EVAL is the primary tool for selecting the "best" assembly when no reference exists.

*   **Basic Scoring**: Use `rsem-eval-calculate-score` to generate a statistically principled evaluation score. Higher scores indicate better assemblies.
*   **Contig Filtering**: Beyond global scores, RSEM-EVAL provides per-contig scores. Use these to identify and remove "noise" contigs that have poor read support.
*   **Memory Management**: For large datasets, ensure you are using version 1.10+ which supports single-precision storage in hash tables to reduce memory footprint.

### REF-EVAL (Reference-Based)
Use REF-EVAL when you have a high-quality set of reference transcripts to compare against.

*   **Multi-Level Evaluation**: REF-EVAL provides scores at the contig, nucleotide, and pair levels. Always look at the F1 score for a balanced view of precision and recall.
*   **K-mer Compression (KC) Score**: Use the KC score to evaluate how well the assembly represents the k-mer distribution of the reference without requiring direct alignments.
*   **True Assembly Estimation**: Use the `ref-eval-estimate-true-assembly` utility to create a theoretical "best" assembly from your reads relative to a reference, providing a ceiling for your assembler's performance.

### Common Workflow Patterns
*   **Assembler Comparison**: Run RSEM-EVAL on outputs from different assemblers (e.g., Trinity, SOAPdenovo-Trans, Velveth) using the exact same set of input reads to determine which tool produced the most likely transcriptome.
*   **Parameter Optimization**: Systematically vary k-mer sizes or coverage thresholds in your assembler and use the RSEM-EVAL score as the objective function to find the optimal settings.
*   **Paired-End Data**: Ensure you specify paired-end parameters if your library is not single-end, as insert size distribution is a key component of the probabilistic model.

## Expert Tips
*   **Score Interpretation**: RSEM-EVAL scores are relative. A single score in isolation is less meaningful than comparing scores across different assembly versions of the same data.
*   **Handling Scaffolds**: When working with scaffolds rather than contigs, use the updated k-mer scoring logic (available since version 1.8) to ensure gaps (N's) are handled correctly.
*   **Build Issues**: If the standard `make` fails, try `NEED_CMAKE=yes make` to force the use of the system-wide CMake.

## Reference documentation
- [DETONATE Overview](./references/github_com_deweylab_detonate.md)
- [DETONATE Examples](./references/github_com_deweylab_detonate_tree_master_examples.md)