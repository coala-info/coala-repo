---
name: rnahybrid
description: RNAhybrid is a specialized bioinformatics tool designed to find the energetically most favorable binding sites between two RNA molecules.
homepage: https://bibiserv.cebitec.uni-bielefeld.de/rnahybrid
---

# rnahybrid

## Overview
RNAhybrid is a specialized bioinformatics tool designed to find the energetically most favorable binding sites between two RNA molecules. Unlike tools that fold a single sequence, RNAhybrid treats the target as an unstructured sequence, making it exceptionally fast and effective for microRNA target prediction. It is particularly useful for high-throughput screening of potential binding sites across 3' UTRs or other long transcript sequences.

## Command Line Usage

The basic syntax for RNAhybrid is:
`RNAhybrid [options] <target_file> <query_file>`

### Common Patterns
- **Basic Hybridization**:
  `RNAhybrid target.fasta miRNA.fasta`
- **Multiple Targets/Queries**:
  The tool accepts multi-FASTA files for both inputs, allowing for batch processing of many miRNAs against many targets.
- **Limiting Results**:
  Use `-n <int>` to specify the maximum number of hits to report per target/query pair.
- **Energy Threshold**:
  Use `-e <float>` to filter results by a maximum energy cutoff (e.g., `-e -20` to see only strong bindings).

### Expert Tips & Best Practices
- **Seed Match Constraints**: For microRNA studies, use the `-m <int>` and `-f <int>` options to enforce seed match requirements (e.g., requiring a match at positions 2-7).
- **P-Value Calculation**: To obtain statistical significance for hits, use the `-d` option to specify the parameters for the extreme value distribution. This requires pre-calculated xi and theta values for the specific sequence lengths and compositions.
- **Output Formatting**: 
  - Use `-s` for a compact, "short" output format suitable for parsing with scripts.
  - Use `-c` for a "clustered" output format.
- **Helix Constraints**: If you know certain regions must be unpaired or paired, use the `-u` and `-p` flags to set constraints on the number of internal loops or bulges allowed.

## Reference documentation
- [RNAhybrid Overview](./references/anaconda_org_channels_bioconda_packages_rnahybrid_overview.md)