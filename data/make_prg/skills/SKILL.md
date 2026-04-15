---
name: make_prg
description: make_prg constructs and maintains Population Reference Graphs from multiple sequence alignments to represent genetic diversity. Use when user asks to create a PRG from MSAs or update an existing PRG database with new sequences.
homepage: https://github.com/rmcolq/make_prg
metadata:
  docker_image: "quay.io/biocontainers/make_prg:0.5.0--pyhdfd78af_0"
---

# make_prg

## Overview

make_prg is a bioinformatics utility designed to construct and maintain Population Reference Graphs (PRGs). It processes Multiple Sequence Alignments to create a graph-based representation of genetic diversity, which is a prerequisite for tools like Pandora and Gramtools. The tool supports both initial graph construction from scratch and efficient incremental updates, allowing researchers to incorporate new genomic data without recomputing the entire pangenome structure.

## Core Workflows

### Creating a PRG from MSAs
Use the `from_msa` subcommand to generate a PRG from one or more alignment files.

```bash
# Process a single MSA file
make_prg from_msa -i input.aln -o output_prefix

# Process a directory of MSA files with a specific suffix
make_prg from_msa -i ./msa_dir/ -s .fasta -o output_prefix
```

**Key Parameters:**
- `-i, --input`: Path to a single MSA file or a directory containing multiple alignments.
- `-o, --output-prefix`: Prefix for generated files (e.g., `.prg.bin`, `.prg.fa`, `.prg.gfa`).
- `-f, --alignment-format`: Specify the format of the input MSAs (e.g., fasta, clustal).
- `-t, --threads`: Enable multithreading for faster processing.
- `-g, --output-graphs`: Explicitly request GFA output.

### Updating an Existing PRG
Use the `update` subcommand to add new sequences to an existing PRG structure. This avoids the computational cost of rebuilding the MSA and PRG from scratch.

```bash
make_prg update [options]
```

## Expert Tips and Best Practices

- **Output Management**: When processing a directory, `make_prg` bundles outputs. `.prg.bin` and `.prg.gfa` files will be collected into `.zip` archives, while `.prg.fa` will be generated as a multi-fasta file.
- **Debugging**: Use the `-vv` flag to enable trace-level logging. This is particularly useful for tracking the recursive clustering and collapse algorithm behavior.
- **Resource Optimization**: Always utilize the `-t` parameter in HPC environments to leverage multithreading, as PRG construction from large MSAs is computationally intensive.
- **Handling Ambiguity**: Version 0.5.0+ properly handles 'N' characters in both MSAs and de novo sequences. Ensure you are using the latest version if your data contains ambiguous bases.
- **Binary Requirements**: If using the precompiled portable binary, ensure the system has `GLIBC >= 2.29` (standard on Ubuntu 19.04+, Debian 11+, and CentOS 9+).



## Subcommands

| Command | Description |
|---------|-------------|
| make_prg from_msa | Creates a PRG from a Multiple Sequence Alignment. |
| make_prg update | Updates a PRG database with new sequences. |

## Reference documentation
- [make_prg README](./references/github_com_iqbal-lab-org_make_prg_blob_master_README.md)
- [make_prg Changelog](./references/github_com_iqbal-lab-org_make_prg_blob_master_CHANGELOG.md)