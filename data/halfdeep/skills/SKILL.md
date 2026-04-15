---
name: halfdeep
description: HalfDeep automates the detection of genomic regions with half-depth coverage signatures to identify assembly errors or haploid sequences in diploid genome assemblies. Use when user asks to align raw reads to an assembly, compute per-base depth, or identify statistically significant intervals that deviate from expected global coverage.
homepage: https://github.com/richard-burhans/HalfDeep
metadata:
  docker_image: "quay.io/biocontainers/halfdeep:0.1.0--hdfd78af_1"
---

# halfdeep

## Overview

HalfDeep is a specialized toolset for automated detection of "half-depth" genomic regions. In the context of diploid genome assembly, regions that should be represented twice but are only represented once (or vice versa) show characteristic coverage signatures. HalfDeep automates the pipeline of aligning raw reads to an assembly, computing per-base depth, and identifying statistically significant intervals that deviate from the expected global coverage. It is designed to work within a specific directory structure similar to the VGP (Vertebrate Genomes Project) assembly pipeline.

## Requirements and Setup

Before running HalfDeep, ensure the following dependencies are in your `$PATH`:
- `minimap2`
- `samtools`
- `genodsp` (version 0.0.8 or newer)
- The HalfDeep shell and Python scripts

## Core Workflow

### 1. Prepare the Assembly
Index your assembly using `minimap2`. Choose the appropriate preset for your read type (e.g., `map-pb` for PacBio subreads, `map-hifi` for HiFi).

```bash
minimap2 -x map-pb -d assembly.idx assembly.fasta.gz
```

### 2. Initialize Input Files
Create a "File of Filenames" (`input.fofn`) containing the paths to your raw sequencing files (FASTQ).

```bash
ls pacbio/*.fastq.gz > input.fofn
```

### 3. Generate Depth Data
Run the `bam_depth.sh` script (or its variants) for each file in your `input.fofn`. The second argument is the line number in the `.fofn` to process.

- **PacBio Subreads:** `bam_depth.sh <ref.fasta> <line_number>`
- **PacBio HiFi:** `bam_depth.hifi.sh <ref.fasta> <line_number>`
- **Illumina:** `bam_depth.illumina.sh <ref.fasta> <line_number>`
- **Assembly-to-Assembly (5% divergence):** `bam_depth.asm5.sh <ref.fasta> <line_number>`
- **Assembly-to-Assembly (20% divergence):** `bam_depth.asm20.sh <ref.fasta> <line_number>`

### 4. Call Half-Depth Intervals
Once all depth files are generated, run the main caller to produce the `halfdeep.dat` file.

```bash
halfdeep.sh assembly.fasta.gz
```

## Output Interpretation

The primary output is `halfdeep.dat`. This file contains a list of intervals (1-based, closed) called as "covered at half depth."

## Expert Tips and Best Practices

- **Directory Structure:** HalfDeep expects a specific layout. Run commands from a directory containing your `input.fofn` and an `assembly_curated/` folder. It will automatically create a `halfdeep/` directory to store intermediate BAMs and depth files.
- **Parallelization:** The `bam_depth.sh` scripts are designed to work with SLURM array tasks. If the `<number>` argument is omitted, the script defaults to `$SLURM_ARRAY_TASK_ID`.
- **Memory Management:** Intermediate `.bam` files can be very large. The HiFi variant (`bam_depth.hifi.sh`) includes commands to remove intermediate BAMs after the compressed depth data is generated to save space.
- **Visualization:** Use the provided `halfdeep.r` script in R to plot coverage across scaffolds. This is highly recommended for validating the "half-depth" calls visually against the global distribution.



## Subcommands

| Command | Description |
|---------|-------------|
| ./bam_depth | Assumes we have <ref> and input.fofn in the current dir |
| halfdeep | Assumes we have <ref>.lengths and <input.fofn> in the same dir |

## Reference documentation
- [HalfDeep GitHub Repository](./references/github_com_richard-burhans_HalfDeep.md)
- [HalfDeep README](./references/github_com_richard-burhans_HalfDeep_blob_master_README.md)
- [HiFi Depth Script](./references/github_com_richard-burhans_HalfDeep_blob_master_bam_depth.hifi.sh.md)