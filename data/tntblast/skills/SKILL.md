---
name: tntblast
description: tntblast simulates biochemical assays against nucleic acid databases using free energy and melting temperature calculations. Use when user asks to 'predict PCR amplification results', 'validate TaqMan assays', 'identify hybridization sites for probes', 'search for PCR assays', 'search for TaqMan PCR assays', 'search for simple hybridization probes', or 'search for padlock probes'.
homepage: https://github.com/jgans/thermonucleotideBLAST
---


# tntblast

## Overview
tntblast (ThermonucleotideBLAST) is a specialized bioinformatics tool designed to simulate biochemical assays against large nucleic acid databases. Unlike standard BLAST, which uses heuristic sequence similarity, tntblast employs physically relevant measures—specifically free energy ($\Delta G$) and melting temperature ($T_m$) calculated via the nearest-neighbor method. It is primarily used to predict PCR amplification results, validate TaqMan assays, and identify hybridization sites for probes in genomic data.

## Query File Configuration
tntblast requires queries to be formatted as tab-delimited text files. The number of columns determines the assay type:

*   **PCR Assays**: 3 columns
    *   `Assay_Name` | `Forward_Primer` | `Reverse_Primer`
*   **TaqMan PCR Assays**: 4 columns
    *   `Assay_Name` | `Forward_Primer` | `Reverse_Primer` | `Probe_Sequence`
*   **Simple Hybridization Probes**: 2 columns
    *   `Assay_Name` | `Probe_Sequence`
*   **Padlock Probes**: 3 columns
    *   `Assay_Name` | `5'_Probe_Sequence` | `3'_Probe_Sequence`

**Note**: Assay names must not contain spaces.

## Best Practices and Performance
*   **Database Selection**: For high-performance searching of large datasets (e.g., GenBank), use BLAST-formatted databases (version 5). While FASTA, GBK, and EMBL (including gzipped versions) are supported, they are significantly slower due to I/O patterns.
*   **Parallel Execution**: 
    *   On multi-core workstations, leverage **OpenMP** for multithreaded execution.
    *   On clusters, use **MPI** to distribute the computational load across nodes.
*   **Degenerate Bases**: tntblast handles degenerate bases by enumerating all possible nucleotide combinations. It automatically adjusts $T_m$ calculations to account for the reduced effective concentration of each specific oligo variant.
*   **Inosine Support**: Inosine (I) is treated as a valid base for both queries and targets.
*   **Seed Matches**: When searching against targets with degenerate nucleotides, tntblast requires at least one short perfect "seed" match of standard bases (A, T, G, C, I) to initiate the thermodynamic alignment.

## Common CLI Patterns
While specific flags depend on the version, the general workflow involves:
1.  Preparing the tab-delimited query file.
2.  Specifying the target database (FASTA, GBK, or BLAST db).
3.  Setting the annealing temperature or $T_m$ thresholds to filter results.
4.  Defining experiment-specific constraints such as maximum amplicon length or required 3' exact matches for primers.

## Reference documentation
- [tntblast Overview](./references/anaconda_org_channels_bioconda_packages_tntblast_overview.md)
- [tntblast GitHub Documentation](./references/github_com_jgans_thermonucleotideBLAST.md)