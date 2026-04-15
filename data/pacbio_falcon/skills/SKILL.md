---
name: pacbio_falcon
description: FALCON is a suite of tools designed for the efficient assembly and haplotig resolution of long-read sequencing data. Use when user asks to assemble long reads, phase diploid genomes, or convert assembly graphs to GFA format.
homepage: https://github.com/PacificBiosciences/FALCON
metadata:
  docker_image: "quay.io/biocontainers/pacbio_falcon:052016--py27_1"
---

# pacbio_falcon

## Overview
FALCON (Fast Aligning Long reads for Consensus) is a suite of tools developed for the efficient assembly of long-read sequencing data. Unlike standard assemblers, FALCON is optimized to handle the high error rates of long reads through a hierarchical process: first generating highly accurate "consensus" reads and then assembling those into contigs. For diploid organisms, it utilizes the FALCON-Unzip extension to resolve haplotypes, producing primary contigs and associated haplotigs. This skill provides the procedural knowledge required to initialize the environment, execute the core assembly scripts, and perform downstream polishing and format conversion.

## Environment and Installation
FALCON requires a specific legacy environment. Ensure the following conditions are met before execution:

- **Python Version**: Must use Python 2.7. Python 3 is not supported.
- **Unicode ABI**: Ensure your Python 2.7 is compiled with UCS4 support. Verify with:
  `python2.7 -c 'import sysconfig; print(sysconfig.get_config_vars()["Py_UNICODE_SIZE"])'` (Value should be 4).
- **Library Paths**: Always export the library path to include the FALCON distribution:
  `export LD_LIBRARY_PATH=${FALCON_PREFIX}/lib:${LD_LIBRARY_PATH}`
- **External Dependencies**: Ensure `mummer` (nucmer/show-coords), `samtools`, and `minimap2` are available in your `$PATH`.

## Core Command Line Usage

### 1. Running the Assembly
The primary entry point for the assembly pipeline is `fc_run.py`. It requires a configuration file (typically in `.cfg` or `.ini` format) that defines the data locations and compute parameters.

```bash
# Execute the main assembly pipeline
fc_run fc_run.cfg
```

### 2. Phased Assembly (FALCON-Unzip)
After the initial assembly, use the Unzip workflow to phase the diploid genome.

```bash
# Run the unzipping process
fc_unzip.py fc_unzip.cfg

# Run the polishing step (Quiver/Arrow)
fc_quiver.py fc_unzip.cfg
```

### 3. Graph and Format Conversion
FALCON uses internal graph representations. To work with standard tools, convert these to GFA (Graphical Fragment Assembly) format.

```bash
# Convert assembly graph to GFA-1 or GFA-2
python -m falcon_kit.mains.gfa_graph [input_file]
```

### 4. Verification and Debugging
To ensure the toolset is correctly installed and accessible within your environment:

```bash
# Check for core modules
python2.7 -c 'import falcon_kit; print falcon_kit'
python2.7 -c 'import falcon_unzip; print falcon_unzip'

# Verify tool accessibility
pbalign --help
variantCaller -h
```

## Expert Tips and Best Practices
- **Resource Management**: FALCON is designed for distributed systems. Ensure your configuration file correctly specifies the `job_type` (e.g., `sge`, `lsf`, `pbs`, or `local`) to match your cluster environment.
- **Resuming Jobs**: If a run fails due to filesystem latency or cluster issues, `fc_run.py` is designed to be restartable. Simply re-run the command; it will detect existing "done" files in the unit-of-work directories and skip completed steps.
- **Lustre Filesystems**: If running on Lustre, be aware that the tool may perform stripe checks. If errors occur regarding `lfs`, ensure your environment has the appropriate Lustre client utilities.
- **Corrected Reads**: If you only need the pre-assembled (corrected) reads without running the full assembly, look in the `0-rawreads/` directory after the first stage of `fc_run.py` completes.

## Reference documentation
- [FALCON Main Repository](./references/github_com_PacificBiosciences_FALCON.md)
- [FALCON Wiki Home](./references/github_com_PacificBiosciences_FALCON_wiki.md)
- [Binary Installation and Dependencies](./references/github_com_PacificBiosciences_FALCON_unzip_wiki_Binaries.md)