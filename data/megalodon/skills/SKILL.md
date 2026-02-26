---
name: megalodon
description: Megalodon extracts high-accuracy modified base calls, sequence variants, and basecalls from raw nanopore signal data by anchoring neural network outputs to a reference. Use when user asks to identify DNA or RNA methylation, call sequence variants from raw signal, or generate basecalls and mappings simultaneously.
homepage: https://github.com/nanoporetech/megalodon
---


# megalodon

## Overview
Megalodon is a research-oriented command-line tool designed to extract high-accuracy modified base and sequence variant calls from raw nanopore signal data. It works by anchoring the output of basecalling neural networks to a reference genome or transcriptome. While it provides a comprehensive "all-in-one" processing pipeline—producing basecalls, mappings, and methylation scores simultaneously—it is important to note that Oxford Nanopore now recommends newer tools like Dorado, Remora, and modkit for production-scale modified base calling.

## Installation and Setup
Megalodon requires a Python environment (>= 3.6) and the Guppy basecaller (>= 4.0).

```bash
# Recommended installation via pip
pip install megalodon

# If using conda, the guppy client library must still be installed via pip
conda install -c bioconda megalodon
pip install ont_pyguppy_client_lib
```

## Core Usage Patterns

### Standard Methylation Pipeline
To output basecalls, mappings, and aggregated CpG methylation (5mC and 5hmC) using a Remora model:

```bash
megalodon raw_fast5s/ \
  --guppy-config dna_r9.4.1_450bps_fast.cfg \
  --remora-modified-bases dna_r9.4.1_e8 fast 0.0.0 5hmc_5mc CG 0 \
  --outputs basecalls mappings mod_mappings mods \
  --reference reference.fa \
  --devices 0 \
  --processes 20
```

### Specific Motif Filtering
To restrict modified base calls to specific motifs (e.g., CpG sites), use the `--mod-motif` argument:

```bash
# Filter for CpG methylation
megalodon raw_fast5s/ \
  --reference reference.fa \
  --outputs mods \
  --mod-motif Z CG 0 \
  --devices 0
```

### Using Rerio Models
For specific models not included in the standard Guppy distribution, download from Rerio and point Megalodon to the model directory:

```bash
megalodon raw_fast5s/ \
  --guppy-params "-d ./rerio/basecall_models/" \
  --guppy-config res_dna_r941_min_modbases_5mC_CpG_v001.cfg \
  --reference reference.fa \
  --outputs basecalls mappings mods
```

## Expert Tips and Best Practices

- **GPU Acceleration**: Nanopore basecalling is compute-intensive. Always specify GPU devices using `--devices` (e.g., `--devices 0 1`) for viable performance.
- **Guppy Server Path**: By default, Megalodon looks for the Guppy executable in `./ont-guppy/bin/`. If installed elsewhere, explicitly set the path using `--guppy-server-path /path/to/guppy_basecall_server`.
- **Output Management**: Use the `--outputs` flag to limit files to only what is necessary. Common options include:
    - `basecalls`: FASTQ/FASTA files.
    - `mappings`: BAM/SAM files.
    - `mods`: Aggregated methylation (bedmethyl).
    - `mod_mappings`: Per-read methylation tags in BAM (Mm/Ml tags).
- **Variant Calling**: To perform sequence variant calling, you must provide a VCF of candidate variants using `--variant-filename` and include `variants` in the `--outputs` list.
- **Transitioning to Modern Tools**: If starting a new production project, consider using **Dorado** for basecalling and methylation, and **modkit** for downstream analysis, as Megalodon is now in a maintenance/unsupported state.

## Reference documentation
- [Megalodon GitHub Repository](./references/github_com_nanoporetech_megalodon.md)
- [Megalodon Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_megalodon_overview.md)