---
name: dialign2
description: DIALIGN 2.2.1 is a specialized multiple sequence alignment tool that differs from standard global or local alignment methods by constructing alignments from gap-free segment pairs (fragments).
homepage: http://dialign.gobics.de
---

# dialign2

## Overview
DIALIGN 2.2.1 is a specialized multiple sequence alignment tool that differs from standard global or local alignment methods by constructing alignments from gap-free segment pairs (fragments). This approach is particularly effective for sequences that share only local similarities or have large non-homologous regions. This skill provides guidance on configuring sequence types, setting sensitivity thresholds, and utilizing anchor points to guide the alignment process.

## Sequence Configuration
DIALIGN requires explicit definition of the input sequence type to apply the correct scoring matrix and alignment logic:
- **Protein**: Standard amino acid alignment.
- **Nucleotide (No Translation)**: Direct alignment of DNA/RNA sequences.
- **Nucleotide (With Translation)**: Aligns DNA/RNA sequences based on their translated protein sequences, which is often more sensitive for coding regions.

## Sensitivity Thresholds (T-value)
The threshold `T` determines the weight of the fragments included in the alignment.
- **Range**: T=0 to T=10.
- **Usage**: Lower values increase sensitivity (including more fragments), while higher values increase stringency (only including high-scoring fragments).
- **Default Recommendation**: T=0 is often used for fast alignments, while T=4 to T=10 are used for more rigorous comparisons.

## Anchored Alignment
You can force the alignment of specific regions by providing anchor points. This is useful when biological knowledge (e.g., known motifs or active sites) should override the default heuristic.

### Anchor File Format
If providing a list of constraints, use a space-separated or tab-separated format with the following columns:
1. **First sequence index**: (Integer, 1-based)
2. **Second sequence index**: (Integer, 1-based)
3. **Start position in first sequence**: (Integer, 1-based)
4. **Start position in second sequence**: (Integer, 1-based)
5. **Length of anchor**: (Integer, number of residues/bases)

*Note: In the web-based or manual input, anchors are prioritized by their order in the list unless explicit scores are provided.*

## Genomic Alignment (CHAOS Integration)
For large genomic sequences where standard DIALIGN may be computationally expensive, use the CHAOS/DIALIGN workflow. CHAOS identifies strong local similarities to serve as initial anchor points, significantly speeding up the subsequent DIALIGN procedure.

## Output Formats
DIALIGN typically generates several files:
- **DIALIGN format**: The native alignment output showing segment-based fragments.
- **FASTA format**: A standard multiple sequence alignment file.
- **Fragment list**: A detailed list of all gap-free segment pairs used in the final alignment.

## Reference documentation
- [Anchored multiple alignment with DIALIGN](./references/dialign_gobics_de_anchor_submission.php.md)
- [CHAOS + DIALIGN: job submission](./references/dialign_gobics_de_chaos-dialign-submission.md)
- [DIALIGN: home](./references/dialign_gobics_de_index.md)