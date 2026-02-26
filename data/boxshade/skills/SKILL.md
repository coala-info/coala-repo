---
name: boxshade
description: Boxshade transforms multiple sequence alignments into formatted figures with identity and similarity shading. Use when user asks to highlight conserved regions in an alignment, apply identity or similarity shading logic, configure consensus thresholds, or export alignments to formats like RTF and PostScript.
homepage: https://github.com/mdbaron42/pyBoxshade
---


# boxshade

## Overview
Boxshade (specifically the pyBoxshade implementation) is a specialized tool designed to transform raw multiple sequence alignments into visually informative figures. Unlike alignment programs that generate sequences, Boxshade focuses entirely on the aesthetic and functional shading of existing alignments. It allows researchers to highlight conserved regions using identity or similarity logic, apply custom threshold fractions for consensus calling, and export the results into formats suitable for word processors or vector graphics editors. Use this skill to understand the shading logic, configure consensus parameters, and choose the appropriate output format for sequence analysis.

## Shading Logic and Consensus Strategies
Boxshade does not use standard mutational matrices by default; instead, it relies on user-defined thresholds and similarity rules.

*   **Threshold Fraction**: Define a value between 0.0 and 1.0. A residue is considered "consensus" only if it appears in a fraction of sequences greater than or equal to this threshold.
*   **Identity vs. Similarity**:
    *   **Identity**: Shading is applied only to residues that match the consensus exactly.
    *   **Similarity**: If an identity consensus is found, the tool checks if other residues at that position are "similar" based on the "Sims" definitions.
*   **Consensus by Groups**: If no single residue meets the threshold, the tool looks for "Groups" (defined in the "Grps" logic) where the sum of residues in that group meets the threshold.
*   **Master Sequence**: You can designate a specific sequence as the "Master." Shading will then be determined solely by identity or similarity to that specific sequence rather than a calculated consensus.

## Input and Output Management
*   **Supported Inputs**: Boxshade utilizes BioPython, supporting Clustal (.aln), FASTA, Phylip (interleaved/sequential), MSF, Nexus, and Stockholm formats.
*   **Output Selection**:
    *   **PostScript (PS)**: Best for high-resolution printing and conversion to PDF or TIFF via vector tools (GIMP, Preview).
    *   **RTF**: Ideal for direct import into Microsoft Word or OpenOffice while preserving formatting.
    *   **PNG**: Best for quick web previews or screen displays. For higher quality, generate a large image with a large font and scale it down.
    *   **ASCII**: Generates a text-based representation showing only conserved or varying residues.

## Expert Tips for Visualization
*   **Consensus Symbols**: The consensus line uses a three-symbol string configuration:
    1.  First symbol: No relationship/not conserved.
    2.  Second symbol: Position meets the similarity/identity threshold.
    3.  Third symbol: Position is globally conserved (identical in all sequences).
*   **Handling Gaps**: In version 1.2+, you can choose whether to count gaps when determining the number of active sequences at a position. Disabling gap counting is useful for alignments with highly variable lengths where a consensus is still desired in sparse regions.
*   **Similarity vs. Groups**: 
    *   Use **Sims** for directional similarity (e.g., T is similar to S, but S is not necessarily similar to T).
    *   Use **Groups** for mutual similarity (all members of the group are treated as equivalent for consensus calculation).

## Reference documentation
- [pyBoxshade README](./references/github_com_mdbaron42_pyBoxshade.md)
- [pyBoxshade Version 1.2 Tags](./references/github_com_mdbaron42_pyBoxshade_tags.md)