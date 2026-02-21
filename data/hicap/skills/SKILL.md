---
name: hicap
description: hicap is a specialized bioinformatics tool designed to automate the identification and characterization of the Haemophilus influenzae capsule (cap) locus.
homepage: https://github.com/scwatts/hicap
---

# hicap

## Overview

hicap is a specialized bioinformatics tool designed to automate the identification and characterization of the Haemophilus influenzae capsule (cap) locus. It categorizes isolates into one of the six capsular serotypes (a-f) by analyzing the three functionally distinct regions of the locus: Region I (transport), Region II (serotype-specific), and Region III (post-translational modification). The tool is particularly effective at resolving complex structural variations, such as duplications or deletions, which frequently complicate manual in silico typing.

## Usage Patterns

### Basic Serotyping
To run a standard analysis on a genome assembly, provide the input FASTA and a target output directory:

```bash
hicap --query_fp assembly.fasta --output_dir hicap_results/
```

### Generating Full-Length Annotations
By default, hicap outputs a GenBank file containing only the cap locus and its immediate surroundings. To include the entire input sequence in the annotated GenBank file:

```bash
hicap --query_fp assembly.fasta --output_dir results/ --full_sequence
```

### Tuning Search Sensitivity
If working with highly divergent or poor-quality assemblies, you can adjust the stringency of gene identification:

*   **Complete Genes**: Modify `--gene_coverage` (default: 0.80) and `--gene_identity` (default: 0.70).
*   **Fragmented/Broken Genes**: Modify `--broken_gene_length` (default: 60bp) and `--broken_gene_identity` (default: 0.80).

```bash
hicap -q assembly.fasta -o results/ --gene_identity 0.60 --gene_coverage 0.75
```

## Output Interpretation

hicap produces three primary files in the output directory:

1.  **Summary (TSV-style)**: Contains the predicted serotype and a detailed "attributes" column. This column is critical for identifying structural anomalies like missing genes or truncations.
2.  **Genbank (.gbk)**: Annotated sequence file.
    *   `region_one`, `region_two`, `region_three`: Locus regions.
    *   `IS1016`: Insertion sequences often associated with locus duplications.
3.  **Graphic (.svg)**: A visual map of the locus.
    *   **Green**: Region I
    *   **Red**: Region II (Serotype-specific)
    *   **Yellow**: Region III
    *   **Grey**: Non-cap ORFs
    *   **Blue Arrows**: IS1016 hits

## Expert Tips

*   **Assembly Quality**: hicap is designed for assemblies. Using raw reads will not work; ensure you have performed de novo assembly (e.g., using SPAdes or SKESA) before running hicap.
*   **Multi-Contig Loci**: If the cap locus is split across multiple contigs, the SVG graphic will display each contig as a separate track. Check the `locus_location` column in the summary file to see the exact coordinates across contigs.
*   **Dependency Check**: hicap relies on `prodigal` for gene calling and `blastn` for sequence alignment. Ensure these are available in your system PATH.
*   **Troubleshooting**: If a serotype is not predicted as expected, use the `--debug` flag to view the underlying BLAST hits and gene-calling logic.

## Reference documentation
- [hicap GitHub Repository](./references/github_com_scwatts_hicap.md)
- [hicap Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hicap_overview.md)