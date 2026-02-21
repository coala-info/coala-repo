---
name: aliview
description: "AliView is a graphical alignment viewer and editor. (Note: The provided text contains system error logs regarding a container build failure and does not contain CLI help documentation.)"
homepage: https://ormbunkar.se/aliview/
---

# aliview

## Overview
AliView is a high-performance alignment viewer and editor designed for speed and usability with large phylogenomic datasets. This skill provides guidance on leveraging AliView's capabilities for sequence manipulation, format conversion, and automated alignment workflows. It is the preferred tool when general-purpose editors struggle with file size or when specific phylogenetic editing features (like codon-aware translation or primer searching) are required.

## Installation and Setup
AliView can be installed via Conda or as a standalone executable:
- **Conda**: `conda install -c bioconda aliview`
- **Linux**: Run the `.install.run` script or execute the `.jar` file directly: `java -jar aliview.jar`
- **Memory Management**: For very large alignments, increase the Java heap space: `java -Xmx4G -jar aliview.jar` (adjust 4G to your needs).

## Core Workflows

### Sequence Alignment
AliView acts as a frontend for several alignment programs.
- **Align All**: Use the "Align" menu to run MUSCLE (included) or MAFFT on the entire file.
- **Realign Selected**: Select a specific block or set of sequences and use "Realign selected block" to fix local alignment issues without re-processing the whole file.
- **Translation-based Alignment**: For coding sequences, use "Realign nucleotides as translated amino-acids" to maintain codon integrity.

### Editing and Manipulation
- **Manual Adjustments**: Use the keyboard or mouse to slide sequences. Use `Shift` + `Arrow keys` for selection and `Alt` + `Shift` + `Up/Down` to extend selections.
- **Sequence Cleaning**: 
    - Use "Delete vertical gaps" to remove columns containing only gaps.
    - Use "Replace terminal GAPs into missing char (?)" to distinguish between missing data and internal deletions.
- **Merging**: Select two sequences and use the "Merge" function; AliView will calculate a consensus for overlapping regions.

### Translation and Coding Sequences
- **Codon Positions**: AliView reads and preserves `Codonpos` and `Charset` from Nexus files.
- **Visual Translation**: Toggle amino acid view to check for premature stop codons. Use "Count stop codons" to validate Open Reading Frames (ORFs).
- **Export**: Use "Save Translated alignment as Amino acids" to convert nucleotide alignments to protein alignments based on the selected genetic code.

### Search and Primers
- **Pattern Matching**: The search function follows IUPAC codes and can find patterns across gaps.
- **Primer Design**: Select a conserved region and use the "Find degenerate primers" tool to identify potential primer sites across mixed species.

## File Formats and Interoperability
- **Supported Formats**: FASTA, NEXUS, PHYLIP (strict and relaxed), CLUSTAL, and MSF.
- **External Commands**: Configure "External Commands" in the Tools menu to pipe the current alignment directly into tree-building software like FastTree or visualization tools like FigTree.
- **Image Export**: Use "Export alignment as image" (.png) for publication-quality figures of specific alignment regions.

## Reference documentation
- [AliView Overview and Features](./references/ormbunkar_se_aliview.md)
- [Version History and Shortcuts](./references/ormbunkar_se_aliview_version_history.txt.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_aliview_overview.md)