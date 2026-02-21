---
name: rdp_classifier
description: The RDP Classifier is a specialized bioinformatics tool designed for high-throughput taxonomic classification.
homepage: http://rdp.cme.msu.edu/
---

# rdp_classifier

## Overview
The RDP Classifier is a specialized bioinformatics tool designed for high-throughput taxonomic classification. It utilizes a Naive Bayesian algorithm to provide fast and accurate assignments for bacterial and archaeal 16S rRNA sequences, as well as fungal Internal Transcribed Spacer (ITS) sequences. This skill provides the necessary command-line patterns to execute classifications, retrain the classifier with custom datasets, and interpret confidence scores.

## Usage Patterns

### Basic Classification
The most common use case is classifying a set of FASTA sequences against the default RDP training set.

```bash
rdp_classifier -Xmx2g -jar /path/to/rdp_classifier.jar classify \
    --outputFile output_assignments.txt \
    --confidence 0.8 \
    input_sequences.fasta
```
*   **-Xmx2g**: Allocates memory (adjust based on dataset size).
*   **--confidence**: Sets the cutoff for taxonomic assignment (0.8 is the standard recommendation for sequences >250bp).

### Batch Processing and Formats
The classifier supports different output formats depending on downstream analysis needs.

```bash
# Output in "allrank" format for a detailed view of every level
rdp_classifier classify -f allrank -o classification_details.txt input.fasta
```

### Training with Custom Databases
If the default RDP taxonomy is insufficient, you can train the classifier on custom reference sets (e.g., SILVA, Greengenes, or specialized local databases).

1.  **Prepare Training Files**: You need a reference FASTA and a taxonomy file.
2.  **Execute Training**:
```bash
rdp_classifier train \
    --train_propfile training.properties \
    --tax_file taxonomy.txt \
    --seq_file reference_sequences.fasta \
    --outdir ./custom_classifier_data
```

## Best Practices
*   **Confidence Scores**: Always filter results by the bootstrap confidence estimate. For short reads (<250bp), consider lowering the threshold to 0.5, but treat results with caution.
*   **Memory Management**: For large metagenomic datasets, ensure the Java heap size (`-Xmx`) is set to at least 4GB to 8GB to avoid `OutOfMemoryError`.
*   **Orientation**: The classifier assumes sequences are in the correct 5' to 3' orientation. If results are poor, check if sequences need to be reverse-complemented.
*   **Version Consistency**: When comparing multiple datasets, ensure the same training set version is used across all runs to maintain taxonomic consistency.

## Reference documentation
- [rdp_classifier Overview](./references/anaconda_org_channels_bioconda_packages_rdp_classifier_overview.md)