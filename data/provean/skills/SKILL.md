---
name: provean
description: PROVEAN predicts the functional impact of amino acid substitutions, insertions, and deletions on protein biological function. Use when user asks to predict the effect of protein variants, filter non-synonymous mutations, or analyze the impact of indels on protein function.
homepage: https://www.jcvi.org/research/provean
---


# provean

## Overview

PROVEAN (Protein Variation Effect Analyzer) is a bioinformatics tool used to predict whether an individual amino acid change or an indel (insertion/deletion) affects the biological function of a protein. It is particularly useful for filtering non-synonymous variants in genomic studies. Unlike many tools that only handle single amino acid substitutions, PROVEAN supports multiple substitutions, insertions, and deletions.

## Usage Guidelines

### Installation
The tool is primarily distributed via Bioconda for Linux and macOS:
```bash
conda install -c bioconda provean
```

### Core Logic and Thresholds
PROVEAN calculates a "delta alignment score" by comparing the alignment of a reference sequence and a variant sequence against a set of homologous sequences (typically from the NCBI NR database).

*   **Default Threshold**: **-2.5**
    *   **Score ≤ -2.5**: Predicted "Deleterious" (impacts function).
    *   **Score > -2.5**: Predicted "Neutral" (no significant impact).
*   **Adjusting Stringency**:
    *   **High Specificity (Lower False Positives)**: Use a lower threshold (e.g., **-4.1**).
    *   **High Sensitivity (Lower False Negatives)**: Use a higher threshold (e.g., **-1.3**).

### Supported Variant Types
*   **Single Amino Acid Substitutions**: e.g., `M1L`
*   **Multiple Substitutions**: Multiple changes within the same protein.
*   **Insertions**: Single or multiple amino acids added.
*   **Deletions**: Single or multiple amino acids removed.

### Performance Expectations
*   **Human Variants**: ~79% accuracy for substitutions; ~93% for deletions.
*   **Non-Human Variants**: ~78% accuracy across mammals, plants, and bacteria.
*   **Comparison**: Performance is comparable to SIFT and PolyPhen-2, but PROVEAN's ability to handle indels makes it more versatile for complex mutation sets.

### Best Practices
1.  **Supporting Sequences**: PROVEAN relies on a "supporting sequence set" generated via BLAST. By default, it uses the top 30 clusters of sequences with at least 75% global identity.
2.  **Sequence Length**: For a sequence to be included in the supporting set, it must be at least 30% of the length of the query sequence.
3.  **Tool Combination**: For critical variants, combine PROVEAN results with SIFT or PolyPhen-2. If all three tools agree, the prediction confidence is significantly higher.

## Reference documentation
- [PROVEAN Overview and Performance](./references/www_jcvi_org_research_provean.md)
- [Bioconda Package Information](./references/anaconda_org_channels_bioconda_packages_provean_overview.md)