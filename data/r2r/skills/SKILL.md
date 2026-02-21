---
name: r2r
description: The `r2r` tool is a specialized command-line utility designed to transform RNA secondary structure data into high-quality visual depictions.
homepage: http://breaker.research.yale.edu/R2R/
---

# r2r

## Overview
The `r2r` tool is a specialized command-line utility designed to transform RNA secondary structure data into high-quality visual depictions. While it can handle single RNA molecules, its primary strength lies in its ability to process multiple sequence alignments to produce "consensus" diagrams that highlight conserved structural features across different species or sequences. It is the standard choice for researchers needing aesthetic control over RNA structural layouts for scientific publications.

## Core Workflow and CLI Patterns
To use `r2r` effectively, follow this general sequence of operations:

1.  **Input Preparation**: Ensure you have a Stockholm format file (.sto) containing the RNA sequence alignment and the secondary structure annotation (typically in `#=GC SS_cons` lines).
2.  **Initial Processing**: Generate a meta-file that defines how the structure should be drawn.
    ```bash
    r2r --GSC-filename input.sto output.meta
    ```
3.  **Refining the Layout**: Edit the generated `.meta` file to adjust aesthetics, such as shading, labeling, or font sizes.
4.  **Final Rendering**: Convert the meta-file into a visual format (usually PostScript).
    ```bash
    r2r output.meta output.ps
    ```

## Expert Tips for Aesthetic Diagrams
*   **Consensus Shading**: Use the `--GSC-filename` flag during the initial pass to ensure that the software correctly calculates conservation statistics, which are essential for the "aesthetic consensus" look where highly conserved residues are highlighted.
*   **Manual Overrides**: If the automated layout results in overlapping stems or labels, you can insert specific drawing commands into the `.meta` file to "nudge" elements or rotate specific helices.
*   **Format Conversion**: Since `r2r` outputs PostScript (.ps) by default, use tools like `ps2pdf` or Ghostscript to convert the final diagram into PDF or PNG for modern document integration.
*   **Single Molecule Mode**: For a single sequence, you can still use `r2r` by providing a Stockholm file with only one sequence entry, allowing you to leverage `r2r`'s superior layout engine compared to basic "circle" or "mountain" plot generators.

## Reference documentation
- [Weinberg-R2R Project Summary](./references/sourceforge_net_projects_weinberg-r2r.md)
- [R2R Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_r2r_overview.md)