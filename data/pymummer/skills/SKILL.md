---
name: pymummer
description: pymummer provides a Python wrapper for the MUMmer suite to automate sequence alignment and parse results into structured objects. Use when user asks to align genomic sequences, filter delta files, detect SNPs, or parse coordinate mapping outputs.
homepage: https://github.com/sanger-pathogens/pymummer
metadata:
  docker_image: "quay.io/biocontainers/pymummer:0.12.0--pyhdfd78af_0"
---

# pymummer

## Overview

The `pymummer` library provides a Pythonic wrapper around the MUMmer suite, specifically targeting `nucmer`, `delta-filter`, `show-coords`, and `show-snps`. It automates the execution of these command-line tools and provides structured parsers to transform their text-based outputs into iterable Python objects. This is particularly useful for bioinformatics pipelines that require sequence alignment filtering, SNP detection, or coordinate mapping without manual file handling or complex subprocess management.

## Core Usage Pattern

To perform an alignment and process the results, follow this standard workflow:

```python
from pymummer import nucmer, coords_file

# 1. Initialize the runner
# Arguments: reference, query, output_file
runner = nucmer.Runner(ref_fasta, query_fasta, "output.coords")

# 2. Execute the alignment
runner.run()

# 3. Parse the resulting coords file
file_reader = coords_file.reader("output.coords")

# 4. Iterate through alignment objects
for hit in file_reader:
    if not hit.is_self_hit():
        print(f"Ref: {hit.ref_start}-{hit.ref_end} | Query: {hit.qry_start}-{hit.qry_end}")
```

## The nucmer.Runner Class

The `Runner` class encapsulates several MUMmer steps into a single execution. Key parameters include:

- `min_id`: Sets the minimum identity percentage for the `delta-filter` step.
- `min_length`: Sets the minimum alignment length for the `delta-filter` step.
- `breaklen`: Extension threshold (nucmer default is 200).
- `maxmatch`: If `True`, uses all anchor matches regardless of their uniqueness.
- `show_snps`: If `True`, executes the `show-snps` command on the alignment.
- `coords_header` / `snps_header`: Boolean flags to include or omit headers in output files (default `True`).

## Handling Alignments

The `alignment` objects produced by the `coords_file.reader` allow for easy manipulation of hit data:

- **Filtering**: Use `hit.is_self_hit()` to quickly discard matches where a sequence is aligned against itself in a multi-fasta file.
- **Coordinate Transformation**: The library supports checking attributes of a hit and swapping reference/query orientations.
- **SNP Analysis**: When `show_snps=True` is used in the runner, the resulting data can be used to identify variants between the reference and query.

## Expert Tips

- **Environment Setup**: `pymummer` requires the MUMmer binaries to be in your system PATH. If using Conda, ensure the `mummer` package is installed in the active environment.
- **M-Series Macs**: If running on ARM64 macOS, you must use an Intel-emulated (x86_64) environment to maintain compatibility with MUMmer4 binaries from Bioconda.
- **Memory Management**: For very large genomic comparisons, ensure the `outfile` path points to a location with sufficient disk space, as MUMmer delta and coords files can grow significantly before filtering.



## Subcommands

| Command | Description |
|---------|-------------|
| delta-filter | Reads a delta alignment file from either nucmer or promer and filters the alignments based on the command-line switches, leaving only the desired alignments which are output to stdout in the same delta format as the input. |
| nucmer | nucmer generates nucleotide alignments between two mutli-FASTA input files. The out.delta output file lists the distance between insertions and deletions that produce maximal scoring alignments between each sequence. The show-* utilities know how to read this format. |
| show-coords | Output is to stdout, and consists of a list of coordinates, percent identity, and other useful information regarding the alignment data contained in the .delta file used as input. |
| show-snps | Output is to stdout, and consists of a list of SNPs (or amino acid substitutions for promer) with positions and other useful info. |

## Reference documentation
- [pymummer GitHub Repository](./references/github_com_sanger-pathogens_pymummer.md)