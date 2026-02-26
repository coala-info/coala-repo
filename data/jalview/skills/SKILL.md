---
name: jalview
description: Jalview is a comprehensive bioinformatics workbench for the manipulation, analysis, and visualization of biological sequence alignments and structures. Use when user asks to align sequences, map genomic variants to protein structures, generate publication-quality alignment figures, or integrate sequence data with 3D structural information.
homepage: http://www.jalview.org/
---


# jalview

## Overview
Jalview is a comprehensive bioinformatics workbench designed for the manipulation and analysis of biological sequences. This skill enables the processing of alignments, the integration of sequence data with 3D structural information, and the generation of publication-quality figures. It is particularly effective for identifying conserved regions, mapping genomic variants (VCF) onto protein structures, and performing comparative analysis across different molecular scales.

## Command Line Usage
Jalview can be executed from the command line for automated processing, alignment generation, and image export.

### Common CLI Patterns
*   **Convert Formats:**
    `jalview -open alignment.fasta -format pfam -features annotations.gff -output processed_alignment.stk`
*   **Generate Figures:**
    `jalview -open alignment.fasta -colour Clustal -png alignment_view.png`
    `jalview -open alignment.fasta -eps alignment_view.eps`
*   **Headless Processing:**
    Use the `-headless` flag for environments without a display (e.g., HPC clusters or CI/CD pipelines).
    `jalview -headless -open data.fasta -props user_preferences.properties -output result.fasta`
*   **Structure Mapping:**
    `jalview -open alignment.fasta -pdb structure.pdb`

### Argument Reference
*   `-open [file]`: Opens a specific alignment or project file.
*   `-props [file]`: Loads a specific Jalview properties file for custom settings.
*   `-colour [scheme]`: Applies a color scheme (e.g., Zappo, Taylor, Hydrophobic, Clustal).
*   `-annotations [file]`: Imports an alignment annotations file.
*   `-features [file]`: Imports sequence features (GFF or Jalview format).
*   `-tree [file]`: Loads a Newick format phylogenetic tree.

## Expert Tips
*   **Linked Views:** When working with both DNA and Protein products, Jalview provides a "Split Frame" view. Ensure your input files have matching identifiers to allow Jalview to automatically link the genomic coordinates to the translated protein sequences.
*   **3D-Beacons Integration:** Use Jalview to automatically discover experimental and predicted structures (AlphaFold) by leveraging the built-in 3D-Beacons client.
*   **VCF Mapping:** You can load VCF files directly onto an alignment to visualize how genomic variants affect specific protein domains or residues.
*   **Memory Management:** For very large alignments, increase the Java heap size using standard JVM flags (e.g., `-Xmx8g`) if running via the executable JAR.

## Reference documentation
- [Jalview Overview](./references/anaconda_org_channels_bioconda_packages_jalview_overview.md)
- [Jalview Home Page](./references/www_jalview_org_index.md)