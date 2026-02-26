---
name: plasann
description: PlasAnn is a specialized pipeline for the comprehensive annotation and visualization of plasmid sequences. Use when user asks to annotate plasmid features, generate circular plasmid maps, or process FASTA and GenBank files for mobile genetic elements.
homepage: https://github.com/ajlopatkin/PlasAnn
---


# plasann

## Overview

PlasAnn is a specialized pipeline for the comprehensive annotation and visualization of plasmid sequences. Unlike general-purpose prokaryotic annotation tools, PlasAnn focuses on features critical to plasmid biology, such as mobile genetic elements and replication machinery. It integrates several bioinformatics tools—including BLAST+, Prodigal, and Infernal—to provide a one-stop solution for transforming raw sequence data into annotated GenBank files, tabular summaries, and publication-ready circular maps.

## Usage Guidelines

### Initial Setup and Verification
Before running annotations, ensure the environment is correctly configured. PlasAnn relies on external binaries that must be in your PATH.

*   **Check Dependencies**: Run `PlasAnn --check-deps` to verify that BLAST+, Prodigal, and Infernal are installed and accessible.
*   **Database Initialization**: Databases are downloaded automatically during the first run. Ensure you have an active internet connection for the initial execution.

### Common CLI Patterns

**Basic FASTA Annotation**
For a single sequence file:
`PlasAnn -i plasmid.fasta -o output_dir -t fasta`

**Batch Processing**
To process an entire directory of mixed FASTA and GenBank files:
`PlasAnn -i ./input_folder/ -o ./results/ -t auto`

**Handling GenBank Files**
When starting with an existing GenBank file, you have two primary strategies:
*   **Preserve existing data**: `PlasAnn -i input.gb -o results -t genbank --retain` (Default behavior; keeps existing CDS annotations).
*   **Re-annotate from scratch**: `PlasAnn -i input.gb -o results -t genbank --overwrite` (Ignores existing CDS and uses Prodigal for new predictions).

**High-Sensitivity Annotation**
For more comprehensive protein identification using UniProt:
`PlasAnn -i sequence.fasta -o results -t fasta --uniprot-blast --min-identity 60`

### Output Interpretation
PlasAnn generates three primary outputs per input file:
1.  **Annotated GenBank (.gb)**: The full sequence with all detected features.
2.  **Annotation Table (.csv)**: A structured list of genes, locations, and functions.
3.  **Plasmid Map (.png)**: A circular visualization of the plasmid features.

## Expert Tips

*   **Sequence Length Constraints**: CDS prediction may be unreliable for very short sequences (under 100bp). If working with small fragments, focus on the BLAST-based feature detection rather than gene calling.
*   **Apple Silicon (M1/M2) Users**: If installing via Conda fails to link binaries correctly, use Homebrew to install `blast`, `brewsci/bio/prodigal`, and `infernal` manually.
*   **Performance**: The `--uniprot-blast` flag significantly increases processing time. Use it only when standard annotations are insufficient or for final characterization of novel plasmids.
*   **Identity Thresholds**: The default `--min-identity` for UniProt BLAST is 50%. Increase this to 70-80% if you require high-confidence ortholog assignments.

## Reference documentation
- [PlasAnn Overview](./references/anaconda_org_channels_bioconda_packages_plasann_overview.md)
- [PlasAnn GitHub Repository](./references/github_com_ajlopatkin_PlasAnn.md)