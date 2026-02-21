---
name: savage
description: SAVAGE (Strain Aware VirAl GEnome assembly) is a specialized bioinformatics tool designed to resolve the genetic diversity within viral populations.
homepage: https://github.com/HaploConduct/HaploConduct/tree/master/savage
---

# savage

## Overview
SAVAGE (Strain Aware VirAl GEnome assembly) is a specialized bioinformatics tool designed to resolve the genetic diversity within viral populations. Unlike standard assemblers that produce a single consensus sequence, SAVAGE distinguishes between closely related strains (haplotypes) within a single host. It utilizes an iterative overlap graph approach and clique enumeration to reconstruct individual sequences, making it essential for studying viral evolution, drug resistance, and quasispecies dynamics.

## Installation
The most reliable way to deploy SAVAGE and its dependencies (including `rust-overlaps`, `bwa`, and `samtools`) is through the Bioconda channel.

```bash
conda install -c bioconda haploconduct
```

## Usage Guidelines
SAVAGE is executed as a subcommand of the `haploconduct` toolkit.

### Input Requirements
- **Sequencing Type**: Illumina paired-end reads.
- **Coverage Depth**: High coverage is critical. A minimum of 10,000x total coverage is typically required to accurately differentiate between low-frequency haplotypes.

### Assembly Modes
1. **De Novo Mode**:
   - Constructs overlap graphs using FM-index data structures.
   - Relies on `rust-overlaps` for suffix-prefix overlap computations.
   - Use this mode when no high-quality reference genome is available or to avoid reference bias.
2. **Reference-Guided Mode**:
   - Uses an ad-hoc consensus sequence to guide the assembly.
   - Requires `bwa mem` and `samtools` to be present in the PATH for read alignment.

### Primary Command
To initiate the SAVAGE workflow:
```bash
haploconduct savage
```

## Best Practices and Expert Tips
- **Resource Allocation**: The assembly process, specifically the maximal clique enumeration performed by the integrated `quick-cliques` package, is computationally demanding. Ensure your environment supports OpenMP for multi-threaded execution.
- **Python Environment**: The current implementation of the HaploConduct workflow relies on Python 2.7. It is highly recommended to run the tool within a isolated Conda environment to prevent library version conflicts.
- **Iterative Refinement**: SAVAGE follows an iterative scheme where reads and contigs are joined based on statistically well-calibrated groups. If the assembly is fragmented, verify that the input read quality is high and that the coverage depth meets the 10,000x threshold.
- **Data Pre-processing**: Ensure adapters are trimmed and low-quality bases are removed before running SAVAGE, as the overlap graph sensitivity is highly dependent on read accuracy.

## Reference documentation
- [HaploConduct GitHub Repository](./references/github_com_HaploConduct_HaploConduct.md)
- [SAVAGE Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_savage_overview.md)