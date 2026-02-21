---
name: mgcod
description: `mgcod` (Multiple Genetic CODes) is a specialized bioinformatics tool designed to recognize genetic codes and annotate protein-coding regions in prokaryotic DNA.
homepage: https://github.com/gatech-genemark/Mgcod
---

# mgcod

## Overview
`mgcod` (Multiple Genetic CODes) is a specialized bioinformatics tool designed to recognize genetic codes and annotate protein-coding regions in prokaryotic DNA. It is particularly effective for analyzing phage genomes, which often exhibit bimodal genetic codes or stop codon reassignments (e.g., TGA/opal, TAG/amber, or TAA/ochre). By utilizing MetaGeneMark (MGM) scoring models, the tool can identify regions where genetic code usage shifts along a contig and annotate the resulting gene isoforms.

## Core CLI Usage

### Basic Annotation
To perform a standard scan of a contig and annotate genes using the highest-scoring genetic code model:
```bash
mgcod -i input.fasta -o output_folder
```

### Detecting Genetic Code Switches (Isoforms Mode)
Use the `--isoforms` flag for viral sequences or phages where different parts of the genome may use different stop codons. This triggers a sliding window analysis:
```bash
mgcod -i phage_genome.fasta -o output_folder --isoforms
```

### Parameter Tuning for Phages
*   **Window Size (`-w`)**: Default is 5000 bp. Do not set this lower than 5000 bp, as the accuracy of stop codon set determination significantly declines on shorter sequences.
*   **Stride (`-st`)**: Step size for the sliding window. For small contigs (<100 kb), reducing the stride (e.g., to 2500 bp) can increase sensitivity for detecting short blocks of alternative coding.
*   **Merge Threshold (`-n`)**: Default is 3. This defines the number of consecutive windows required to identify a distinct genetic code block. Increase this to avoid over-segmenting the genome.
*   **Isoform Coordinate Tolerance (`-t`)**: Default is 30 bp. Predictions from different models are considered equivalent isoforms if their coordinates differ by less than this value.

## Parallel Processing
When analyzing multiple genomes that may have different genetic codes, it is best practice to analyze them separately rather than as a single multi-FASTA file. Use the provided multiprocess script:

1.  Create a text file (e.g., `fasta_paths.txt`) with one absolute file path per line.
2.  Execute the parallel wrapper:
```bash
python multiprocess_mgcod.py fasta_paths.txt
```

## Expert Tips and Best Practices

*   **Targeted Usage**: Only apply the `--isoforms` mode to sequences already confirmed or strongly suspected to be viral. In standard bacterial genomes, this mode can produce false-positive dual-coding gene predictions due to natural tandem stop codon usage.
*   **Interpreting Reassignments**: `mgcod` identifies the *occurrence* of a stop codon reassignment but does not determine the specific amino acid being encoded. To find the amino acid, perform a multiple sequence alignment of the predicted protein against conserved homologs.
*   **Switch Region Refinement**: The tool uses Protein-Encoding Strand (PES) information to refine boundaries. If a PES switch occurs between two windows with different genetic codes, the intergenic region between those genes is marked as the "switch region."
*   **Supported Models**: The tool currently supports:
    *   Standard genetic code (`mgm_11.mod`)
    *   Opal (TGA) reassignment (`mgm_4.mod`)
    *   Amber (TAG) reassignment (`mgm_15.mod`)
    *   Ochre (TAA) reassignment (`mgm_101.mod`)

## Reference documentation
- [Mgcod GitHub README](./references/github_com_gatech-genemark_Mgcod.md)
- [Bioconda mgcod Overview](./references/anaconda_org_channels_bioconda_packages_mgcod_overview.md)