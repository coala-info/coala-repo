---
name: memopair
description: memopair identifies methylated motif pairs within genomic data using a reference genome and methylation pileup files. Use when user asks to identify methylated motif pairs, analyze motif-specific methylation density, or determine modification states at precise genomic positions.
homepage: https://github.com/SorenHeidelbach/memopair
metadata:
  docker_image: "quay.io/biocontainers/memopair:0.1.6--h4349ce8_0"
---

# memopair

## Overview
memopair is a specialized command-line utility designed to identify methylated motif pairs within genomic data. By processing a reference genome and a corresponding methylation pileup file, it allows researchers to target specific DNA motifs and determine their modification states at precise positions. This tool is particularly useful for studying epigenetic symmetry, co-occurrence of modifications, and motif-specific methylation density.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::memopair
```

## Core Usage
The basic syntax requires a reference FASTA, a pileup file, and at least one motif definition:

```bash
memopair <REFERENCE_FASTA> <PILEUP_FILE> [MOTIFS]...
```

### Defining Motifs
Motifs must be provided in a specific string format: `MOTIF_TYPE1_POS1_TYPE2_POS2`.
- **MOTIF**: The DNA sequence (e.g., `ACGT`).
- **TYPE**: The modification type (e.g., `m` for 5mC, `a` for 6mA, `4mC`).
- **POS**: The 0-indexed position of the modification within the motif.

**Examples:**
- `ACGT_a_0_m_3`: Analyzes the `ACGT` motif where position 0 is checked for 'a' modification and position 3 for 'm' modification.
- `CCWGG_4mC_0_5mC_3`: Analyzes the `CCWGG` motif checking for 4mC at position 0 and 5mC at position 3.

## Command Line Options
- `-o, --out <PATH>`: Specify the output file path. Defaults to `motif_methylation_state`.
- `--min-cov <INT>`: Set the minimum coverage threshold for a position to be included in the analysis. Default is `5`.
- `--verbosity <LEVEL>`: Control log output. Options: `verbose`, `normal`, `silent`.

## Best Practices
- **Coverage Tuning**: For high-confidence methylation calls, increase `--min-cov` to 10 or higher, especially when working with noisy nanopore data.
- **Reference Matching**: Ensure the headers in your `<REFERENCE>` FASTA exactly match the sequence identifiers used in the `<PILEUP>` file.
- **Batch Processing**: You can pass multiple motif strings in a single command to analyze different modification patterns simultaneously.
- **Memory Management**: For very large pileup files, ensure you have sufficient RAM, as the tool performs complex matching between the reference and the methylation data.

## Reference documentation
- [memopair Overview](./references/anaconda_org_channels_bioconda_packages_memopair_overview.md)
- [memopair GitHub Repository](./references/github_com_SorenHeidelbach_memopair.md)