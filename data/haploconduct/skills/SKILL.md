---
name: haploconduct
description: HaploConduct is a bioinformatics suite for the de novo assembly of viral quasispecies and polyploid haplotypes. Use when user asks to reconstruct intra-host virus strains, assemble diploid or polyploid genomes, or estimate the number of strains in a sample.
homepage: https://github.com/HaploConduct/HaploConduct
metadata:
  docker_image: "quay.io/biocontainers/haploconduct:0.2.1--py27h78a066a_0"
---

# haploconduct

## Overview
HaploConduct is a specialized bioinformatics suite for de novo assembly of haplotypes. It provides two primary workflows: SAVAGE, which is optimized for reconstructing intra-host virus strains without a reference genome, and POLYTE, which is tailored for diploid and polyploid organisms at low coverage. This skill enables the execution of these complex assembly pipelines, estimation of strain counts, and management of haplotype-aware overlap graphs.

## Installation and Environment
HaploConduct is built for Linux-based systems and relies on Python 2.7. The most reliable way to ensure all C++ dependencies (Boost, OpenMP) and external tools (bwa, samtools, rust-overlaps) are available is via Bioconda.

```bash
# Create and activate the environment
conda create --name haploconduct-deps python=2.7 scipy bwa samtools rust-overlaps
source activate haploconduct-deps

# Install the package
conda install haploconduct
```

## Core Subprograms
The `haploconduct` wrapper provides access to three main execution modes:

- `savage`: For viral quasispecies assembly. Requires high coverage (typically >10,000x).
- `polyte`: For diploid/polyploid genomes of known ploidy. Optimized for 15-20x coverage per haplotype.
- `polyte-split`: A specialized mode for large genomic regions (>100 kb) that bins data into 10 kb segments before assembly.

## Common CLI Patterns

### Estimating Strain Count
Before running a full assembly, use the included script to estimate the number of strains in a sample based on contig alignments to a reference.

```bash
python estimate_strain_count.py --sam input.sam --ref reference.fasta --verbose
```

### Running SAVAGE
Execute the viral quasispecies assembly pipeline. Use the `-h` flag to see specific parameters for overlap thresholds and iteration counts.

```bash
haploconduct savage [options]
```

### Running POLYTE
For polyploid assembly where ploidy is known:

```bash
# Standard mode
haploconduct polyte [options]

# Split mode for large regions (>100kb)
haploconduct polyte-split [options]
```

## Expert Tips
- **Coverage Requirements**: Ensure your input data meets the minimum depth requirements. SAVAGE is extremely coverage-hungry due to the complexity of viral quasispecies, while POLYTE is specifically designed to perform well at lower "per-haplotype" coverage.
- **Reference-Guided vs. De Novo**: While SAVAGE can run de novo using FM-index structures, providing an ad-hoc consensus reference can significantly improve assembly quality in complex samples.
- **Memory Management**: For large datasets or high-ploidy reconstructions, prefer `polyte-split` to reduce the computational overhead by processing the genome in 10 kb bins.
- **Dependency Check**: If the tool fails to launch, verify the core binary by running `ViralQuasispecies --help` to ensure the C++ components are correctly compiled and linked to Boost libraries.



## Subcommands

| Command | Description |
|---------|-------------|
| polyte-split.py | POLYTE assembles individual haplotypes from NGS data. It expects as input single- and/or paired-end Illumina sequencing reads. |
| polyte.py | POLYTE assembles individual haplotypes from NGS data. It expects as input single- and/or paired-end Illumina sequencing reads. |
| savage.py | SAVAGE - Strain Aware VirAl GEnome assembly. SAVAGE assembles individual (viral) haplotypes from NGS data. It expects as input single- and/or paired-end Illumina sequencing reads. Please note that the paired-end reads are expected to be in forward-forward format, as output by PEAR. |

## Reference documentation
- [HaploConduct Main README](./references/github_com_HaploConduct_HaploConduct_blob_master_README.md)
- [HaploConduct Wrapper Script](./references/github_com_HaploConduct_HaploConduct_blob_master_haploconduct.py.md)
- [Strain Estimation Tool](./references/github_com_HaploConduct_HaploConduct_blob_master_estimate_strain_count.py.md)