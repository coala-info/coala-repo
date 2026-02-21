---
name: transtermhp
description: TransTermHP is a specialized computational tool for the rapid discovery of rho-independent transcription terminators in bacterial sequences.
homepage: http://transterm.cbcb.umd.edu/index.php
---

# transtermhp

## Overview
TransTermHP is a specialized computational tool for the rapid discovery of rho-independent transcription terminators in bacterial sequences. It utilizes a dynamic programming algorithm to identify potential hairpin structures followed by poly-U tails, assigning each a confidence value (0-100) that estimates the probability of it being a true biological terminator. It is designed to handle genomic complexities such as overlapping genes and gaps in terminator hairpins.

## Usage Guidelines

### Input Requirements
TransTermHP requires two primary inputs:
1.  **Genomic Sequence**: The DNA sequence in FASTA format.
2.  **Gene Annotations**: Annotations are used to identify intergenic regions where terminators are likely located. Supported formats include:
    *   **NCBI .ptt files**: Standard protein table files.
    *   **Simple List**: A basic coordinate list of genes.

### Key Functional Parameters
When configuring or filtering TransTermHP results, focus on these structural and statistical metrics:
*   **Confidence Score**: A value between 0 and 100. Higher values indicate a higher probability of a true terminator.
*   **Hairpin Score**: A measure of the secondary structure stability. Lower (more negative) scores indicate more stable hairpins.
*   **Tail Score**: A measure of the U-richness of the 3' tail. This should typically be non-positive; lower scores indicate a better match to the rho-independent model.
*   **Stem Length**: The length of the double-stranded portion of the hairpin.
*   **Region Context**: Terminators are often categorized by the orientation of surrounding genes:
    *   **Tail-to-tail**: Between convergent genes.
    *   **Head-to-tail**: Between genes in a tandem orientation.
    *   **Head-to-head**: Between divergent genes (less common for terminators).

### Best Practices
*   **Filtering**: For high-confidence sets, filter results to show only those with a confidence score $\ge 60$ or $80$.
*   **Downstream Search**: Focus searches within 1kb downstream of gene ends, as this is the most biologically relevant area for transcription termination.
*   **Overlapping Genes**: Ensure the tool is aware of gene boundaries, as TransTermHP is specifically optimized to handle terminators that might overlap with the coding sequences of adjacent genes.

## Reference documentation
- [TransTermHP Overview](./references/transterm_cbcb_umd_edu_index.php.md)
- [Search and Parameter Logic](./references/transterm_cbcb_umd_edu_query.php.md)
- [Bioconda Package Information](./references/anaconda_org_channels_bioconda_packages_transtermhp_overview.md)