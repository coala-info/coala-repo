---
name: modle
description: MoDLE models the stochastic formation of DNA loops to simulate Hi-C-like contact matrices based on the loop extrusion model. Use when user asks to simulate DNA loop extrusion, generate contact matrices in Cooler format, or run MoDLE simulations using Docker or Singularity containers.
homepage: https://github.com/paulsengroup/MoDLE
---


# modle

## Overview

MoDLE (Molecular DNA Loop Extrusion) is a high-performance tool designed to model the stochastic formation of DNA loops. It is particularly useful for researchers looking to simulate Hi-C-like contact matrices based on the loop extrusion model without the computational overhead of traditional molecular dynamics. Use this skill to execute simulations, prepare necessary genomic coordinate files, and troubleshoot environment-specific issues when running MoDLE in containers.

## Simulation Workflow

The primary function of MoDLE is the `simulate` (or `sim`) subcommand. A standard simulation requires chromosome dimensions and the locations of extrusion barriers (typically CTCF binding sites).

### Basic Command Pattern
```bash
modle simulate \
  --chrom-sizes <path_to_chrom_sizes> \
  --extrusion-barrier-file <path_to_barriers_bed> \
  --output-prefix <prefix_for_outputs>
```

### Key Input Requirements
- **Chromosome Sizes**: A tab-separated file containing chromosome names and their respective lengths in base pairs.
- **Extrusion Barriers**: A BED-formatted file (often compressed as `.bed.xz`) specifying the positions and orientations of barriers that stop or stall Loop Extruding Factors (LEFs).

### Output Files
MoDLE generates several files upon completion:
- `.cool`: The resulting molecular contact matrix in Cooler format.
- `_lef_1d_occupancy.bw`: A BigWig file showing the 1D density of LEFs along the genome.
- `_config.toml`: A record of the parameters used for the simulation.
- `.log`: Execution details and performance metrics.

## Containerized Execution

MoDLE is frequently run via Docker or Singularity to manage dependencies. The most common failure point is file accessibility.

### Docker Best Practices
When using Docker, you must explicitly mount the host directory containing your data to a path inside the container using the `-v` flag.

```bash
docker run -v "$(pwd):/data" ghcr.io/paulsengroup/modle:1.1.0 simulate \
  --chrom-sizes /data/genome.chrom.sizes \
  --extrusion-barrier-file /data/barriers.bed \
  --output-prefix /data/sim_results
```

### Singularity/Apptainer Best Practices
Singularity typically mounts the user's home directory or current working directory by default, but explicit binding is safer for external drives or specific clusters.

```bash
singularity run -B /path/to/data:/mnt \
  docker://ghcr.io/paulsengroup/modle:1.1.0 simulate \
  --chrom-sizes /mnt/genome.chrom.sizes \
  --extrusion-barrier-file /mnt/barriers.bed \
  --output-prefix /mnt/output
```

## Expert Tips

- **Performance**: MoDLE is optimized for multi-threading. Ensure your environment provides sufficient CPU resources for genome-wide simulations.
- **Troubleshooting**: If the tool reports "File does not exist" while running in Docker, verify that the path provided to the CLI matches the *internal* container path defined in the `-v` mount, not the host path.
- **Configuration**: Use the `--config` flag to pass a pre-defined configuration file if you need to override default biophysical parameters (e.g., LEF processivity or density).

## Reference documentation
- [MoDLE GitHub Repository](./references/github_com_paulsengroup_MoDLE.md)