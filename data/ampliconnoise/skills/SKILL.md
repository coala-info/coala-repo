---
name: ampliconnoise
description: "Ampliconnoise denoises high-throughput amplicon sequencing data from the 454 platform to remove sequencing artifacts. Use when user asks to split multiplexed SFF files, denoise flowgrams using PyroNoise, truncate sequences, or denoise sequences using SeqNoise."
homepage: https://github.com/fhcrc/ampliconnoise
---


# ampliconnoise

## Overview

The `ampliconnoise` skill facilitates the denoising of high-throughput amplicon sequencing data, specifically targeting the 454 platform. It provides a Python-based wrapper for the original AmpliconNoise C code, allowing for a streamlined workflow that transforms raw flowgram data (.sff) into error-corrected sequences. This process is critical for microbial community analysis to ensure that sequencing artifacts are not misinterpreted as biological diversity.

## Core Workflow and CLI Patterns

The standard pipeline involves splitting a multiplexed SFF file, denoising flowgrams, truncating sequences, and finally denoising the sequences themselves.

### 1. Splitting Multiplexed SFF Files
Use `anoise split` to separate a master SFF file into individual samples based on barcodes and primers.

**Command:**
`anoise split <barcode_map.csv> <input.sff>`

**Barcode Map Format:**
The mapping file must be a comma-delimited CSV with the following structure:
`output_path_prefix,barcode,primer`

*Example record:* `sample1/sample1,ATAG,TAAATGGCAGTCTAGCAGAARAAG`

### 2. Denoising Flowgrams (PyroNoise)
`PyroNoise` cleans the raw flowgram data. This step is computationally intensive and benefits from parallelization via MPI.

**Command:**
```bash
anoise pyronoise \
  --mpi-args "-np <procs>" \
  --temp-dir <path_to_tmp> \
  <sample>.sff
```

*   **--mpi-args**: Pass MPI parameters (e.g., `-np 12` for 12 processors).
*   **--temp-dir**: Specify a directory for intermediate files. If using multiple nodes, ensure this path is accessible to all nodes.

### 3. Sequence Truncation
After PyroNoise, sequences should be truncated to a consistent length (e.g., 400bp) before further processing.

**Command:**
`anoise truncate "{barcode}" 400 < <input_pnoise_cd>.fa > <output_trunc>.fa`

### 4. Denoising Sequences (SeqNoise)
The final step clusters sequences to remove remaining errors.

**Command:**
```bash
anoise seqnoise \
  --mpi-args "-np <procs>" \
  --stub <sample_name> \
  --temp-dir <path_to_tmp> \
  <input_trunc>.fa \
  <mapping_file>
```

*   **--stub**: The prefix used for output files.
*   **mapping_file**: The `.mapping` file generated during the PyroNoise step.

## Expert Tips and Best Practices

*   **MPI Configuration**: Always use the `--mpi-args` flag for `pyronoise` and `seqnoise` to significantly reduce processing time.
*   **Temporary Storage**: For large datasets, the temporary directory can grow significantly. Use a high-performance scratch disk and ensure the `--temp-dir` is explicitly set if the default `/tmp` has space limitations.
*   **Degenerate Primers**: When defining the barcode map for the `split` command, specify degenerate primers using standard IUPAC codes; the tool handles these appropriately.
*   **Input Requirements**: Ensure BioPython is installed, as it is a primary dependency for the Python front end.

## Reference documentation
- [AmpliconNoise GitHub Repository](./references/github_com_fhcrc_ampliconnoise.md)