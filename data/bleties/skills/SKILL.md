---
name: bleties
description: BleTIES is a bioinformatics toolkit designed to identify and analyze Internal Eliminated Sequences and genome rearrangement events in ciliates using long-read sequencing data. Use when user asks to identify IES junctions, perform de novo IES assembly, quantify IES retention levels, map telomere addition sites, or simulate genome rearrangements.
homepage: https://github.com/Swart-lab/bleties
---


# bleties

## Overview
BleTIES (Basic Long-read Enabled Toolkit for Interspersed DNA Elimination Studies) is a specialized bioinformatics suite for studying genome rearrangement in ciliates. It leverages the high error tolerance and length of single-molecule long reads to identify sequences that are present in the Micronucleus (MIC) but removed during the development of the Macronucleus (MAC). The toolkit provides a complete workflow from de novo IES discovery and assembly to population-level retention quantification and telomere addition site mapping.

## Core Submodules and Workflows

BleTIES uses a subcommand-based CLI. Access specific help for any module using `bleties <subcommand> --help`.

### 1. IES Discovery and Assembly (MILRAA)
Use **MILRAA** (Method for IES Locating by Read-Assembly Alignment) to identify putative IESs and their junctions.
*   **Input**: Sorted/indexed BAM of long reads mapped to a MAC reference.
*   **Requirement**: The BAM file must contain valid CIGAR strings and `NM` (edit distance) tags.
*   **Function**: It clusters reads with insertions relative to the MAC, performs local assembly of those insertions, and reports IES coordinates and sequences.

### 2. Retention Analysis (MILRET & MILCOR)
Quantify how many reads support the retention of an IES versus its excision.
*   **MILRET**: Calculates IES retention scores across the population at specific junctions. Use this for general quantification of IES presence.
*   **MILCOR**: Calculates per-read retention scores. Use this to bin individual reads as being of MIC or MAC origin based on their IES content.

### 3. Chromosome Breakage (MILTEL)
Use **MILTEL** to identify potential chromosome breakage sites where telomeres are added.
*   **Logic**: It looks for soft-clipped reads at the ends of alignments that contain telomeric repeats, indicating where a MIC chromosome was processed into a MAC scaffold.

### 4. Sequence Manipulation (Insert)
Use the **insert** utility to modify reference genomes.
*   **MAC to MIC**: Insert known IES sequences into a MAC reference to create a "MAC+IES" hybrid (pseudo-MIC).
*   **MIC to MAC**: Perform the reverse operation to simulate excision.

## CLI Usage Patterns

### Basic Execution
```bash
# General help
bleties --help

# Submodule help
bleties milraa --help
```

### Visualization
BleTIES includes standalone scripts for plotting results, typically found in the `bin/` directory:
*   `milraa_plot.py`: Visualizes IES junctions and assembly support.
*   `milcor_plot.py`: Plots per-read retention scores and read binning results.

## Expert Tips and Best Practices

*   **Mapping Accuracy**: BleTIES assumes the input mapping is accurate. Use high-quality mappers like `minimap2` (with `-ax map-pb` or `-ax map-ont`) or `pbmm2` for PacBio data.
*   **CIGAR/NM Tags**: Ensure your mapper is configured to output the `NM` tag. If missing, BleTIES may fail to correctly evaluate the mismatch rate within putative IES regions.
*   **Read Types**: While compatible with uncorrected PacBio subreads and Nanopore reads, the highest accuracy for IES reconstruction is achieved using PacBio CCS (HiFi) reads.
*   **Scrambled IESs**: Note that the current version of MILRAA is designed for non-scrambled IESs. Complex rearrangements (scrambled/inverted) may require manual curation or specialized tools.
*   **Curation**: Use the **MISER** module (experimental) to screen for potentially erroneous IES calls and curate the list of putative junctions before running downstream retention analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| bleties milcor | MILCOR - Method of IES Long-read CORrelation |
| bleties miltel | MILTEL - Method of Long-read Telomere detection |
| bleties_insert | Insert - Insert/Remove IESs to/from MAC reference sequence |
| milraa | MILRAA - Method of Identification by Long Read Alignment Anomalies |

## Reference documentation
- [BleTIES Main Documentation](./references/github_com_Swart-lab_bleties_blob_master_docs_index.md)
- [MILRAA Module Details](./references/swart-lab_github_io_bleties_milraa.html.md)
- [MILRET/MILCOR Retention Analysis](./references/swart-lab_github_io_bleties_milret.html.md)
- [Installation and Environment](./references/github_com_Swart-lab_bleties_blob_master_README.md)