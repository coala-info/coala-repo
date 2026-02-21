---
name: chromosomer
description: Chromosomer is a bioinformatics utility designed to produce draft chromosome-level assemblies by leveraging a closely related reference genome.
homepage: https://github.com/gtamazian/chromosomer
---

# chromosomer

## Overview
Chromosomer is a bioinformatics utility designed to produce draft chromosome-level assemblies by leveraging a closely related reference genome. It provides a structured workflow to order and orient genomic fragments (contigs or scaffolds) based on their alignments to a reference. This tool is particularly effective for improving the contiguity of draft genomes when a high-quality reference of a related species is available.

## Core Workflow

A standard assembly with `chromosomer` follows a three-step process:

1.  **Prepare Fragment Lengths**: Before mapping, you must calculate the lengths of your input sequences.
    ```bash
    chromosomer fastalength fragments.fasta > fragment_lengths.txt
    ```

2.  **Generate Fragment Map**: Create a map file that defines the order and orientation of fragments based on their alignments (e.g., BLAST tabular output) to the reference.
    ```bash
    chromosomer fragmentmap alignment_file gap_size fragment_lengths.txt output_map
    ```
    *   `alignment_file`: Typically a tabular alignment file (like BLAST `-outfmt 6`).
    *   `gap_size`: The number of 'N' characters to insert between fragments.

3.  **Assemble Sequences**: Construct the final FASTA file using the fragment map and the original fragment sequences.
    ```bash
    chromosomer assemble output_map fragments.fasta assembled_chromosomes.fasta
    ```

## Utility Commands

### Annotation Transfer
If you have existing annotations (GFF/GTF) for your fragments, you can migrate them to the new coordinate system of the assembled chromosomes:
```bash
chromosomer transfer map original_annotations.gff output_annotations.gff
```

### Map Analysis and Conversion
To validate or visualize the assembly plan before generating the FASTA:
*   **Summary Statistics**: Get a report on how many fragments were localized and the total length of the assembly.
    ```bash
    chromosomer fragmentmapstat output_map
    ```
*   **BED Conversion**: Convert the fragment map to BED format for viewing in genome browsers (like IGV or UCSC) to verify fragment placement against the reference.
    ```bash
    chromosomer fragmentmapbed output_map > output_map.bed
    ```

## Expert Tips and Best Practices

*   **Alignment Quality**: The quality of the `fragmentmap` depends entirely on the input alignments. Filter your BLAST/alignment files for high-confidence hits (e.g., minimum identity or alignment length) before running `fragmentmap` to avoid spurious placements.
*   **Gap Sizes**: Use a standard gap size (e.g., 100 or 1000) that is consistent with your downstream annotation pipelines. Some tools have specific requirements for minimum gap lengths to recognize scaffold boundaries.
*   **Soft-Masking**: If your input fragments contain soft-masked repeats, `chromosomer` can preserve this masking in the final assembly.
*   **Unlocalized Fragments**: Check the `fragmentmapstat` output to identify fragments that failed to map. These "unplaced" fragments are often saved separately or excluded; ensure you account for them if you need a complete genome representation.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_gtamazian_chromosomer.md)
- [Anaconda/Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_chromosomer_overview.md)