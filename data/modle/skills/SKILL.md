---
name: modle
description: MoDLE is a high-performance stochastic simulator that models the formation of DNA loops and molecular contacts to generate genome-wide contact maps. Use when user asks to simulate loop extrusion, generate in silico chromatin contact maps, or predict the effects of genomic rearrangements on 3D genome architecture.
homepage: https://github.com/paulsengroup/MoDLE
metadata:
  docker_image: "quay.io/biocontainers/modle:1.1.0--h63853f4_0"
---

# modle

## Overview

MoDLE (Molecular DNA Loop Extrusion) is a high-performance stochastic simulator that models the formation of DNA loops and molecular contacts. It is designed to generate realistic genome-wide contact maps in minutes, significantly faster than traditional molecular dynamics approaches. By providing chromosome sizes and extrusion barrier positions (typically CTCF sites), users can simulate how ring-shaped proteins like cohesin shape the 3D genome. The tool is essential for "in silico" genetics, allowing researchers to predict the effects of genomic rearrangements or protein perturbations on chromatin architecture.

## Command Line Usage

The primary interface for MoDLE is the `simulate` (or `sim`) subcommand.

### Basic Simulation
To run a standard simulation, you must provide the chromosome lengths and the positions of extrusion barriers.

```bash
modle simulate \
  --chrom-sizes hg38.chrom.sizes \
  --extrusion-barrier-file ctcf_sites.bed \
  --output-prefix simulation_results
```

### Key Arguments
- `--chrom-sizes`: Path to a text file containing chromosome names and lengths.
- `--extrusion-barrier-file`: A BED file containing barrier positions. For realistic results, these should include the orientation of the binding site (e.g., CTCF motifs) in the 6th column.
- `--output-prefix`: Base name for output files.
- `--config`: (Optional) Path to a TOML configuration file to override default simulation parameters.

### Running via Container (Docker/Singularity)
Because MoDLE is optimized for Linux, use containers for Windows or macOS environments. Ensure host directories are mounted to make data accessible.

```bash
# Docker example with volume mounting
docker run -v "$(pwd):/data" ghcr.io/paulsengroup/modle:1.1.0 simulate \
  --chrom-sizes /data/my.chrom.sizes \
  --extrusion-barrier-file /data/barriers.bed \
  --output-prefix /data/output
```

## Expert Tips and Best Practices

### Input Preparation
- **Barrier Orientation**: Loop extrusion is directional. Ensure your barrier BED file correctly identifies the strand (+/-) of CTCF sites. Convergent CTCF sites are the primary drivers of loop "dots" in contact maps.
- **Chrom Sizes**: Ensure the chromosome names in your `--chrom-sizes` file exactly match those in your `--extrusion-barrier-file`.

### Simulation Tuning
- **Stopping Criteria**: MoDLE halts based on a target number of epochs or a target number of contacts. If your output map is too sparse (noisy), increase the simulation depth.
- **Modeling Perturbations**:
    - **CTCF Depletion**: Adjust the barrier binding probability (stationary distribution of the Markov chain) to simulate weaker or fewer CTCF barriers.
    - **WAPL Depletion**: Decrease the LEF release rate to simulate longer-lived loops and "vermicelli" chromosomes.

### Performance
- **Multithreading**: MoDLE scales near-linearly with CPU cores. On high-performance clusters, allocate multiple cores to significantly reduce wall-clock time.
- **Memory**: Memory usage scales with the size of the genomic region and the number of contacts being recorded. For genome-wide human simulations, ensure at least 8-16GB of RAM is available.

### Output Interpretation
MoDLE produces several files:
- `.cool`: The main contact matrix in Cooler format, compatible with `cooler`, `cooltools`, and `HiGlass`.
- `.bw`: BigWig file showing 1D LEF occupancy (how often a LEF was present at a specific locus).
- `.log`: Detailed execution logs and statistics.
- `_config.toml`: A record of all parameters used for the simulation, ensuring reproducibility.



## Subcommands

| Command | Description |
|---------|-------------|
| modle simulate | Simulate loop extrusion and write resulting molecular contacts in a .cool file. |
| modle simulate | Simulate loop extrusion and write resulting molecular contacts in a .cool file. |

## Reference documentation
- [MoDLE GitHub Repository](./references/github_com_paulsengroup_MoDLE.md)
- [MoDLE: high-performance stochastic modeling of DNA loop extrusion interactions](./references/link_springer_com_article_10.1186_s13059-022-02815-7.md)