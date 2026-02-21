---
name: pbh5tools
description: The `pbh5tools` package is a specialized "swiss-army knife" for handling legacy PacBio HDF5 data.
homepage: https://github.com/zkennedy/pbh5tools
---

# pbh5tools

## Overview

The `pbh5tools` package is a specialized "swiss-army knife" for handling legacy PacBio HDF5 data. It provides a suite of command-line utilities designed to interface with `bas.h5` and `cmp.h5` files, allowing users to extract specific metrics, generate data summaries, and filter sequencing reads. It is particularly useful for bioinformaticians working with older PacBio datasets or maintaining pipelines that rely on the HDF5-based data schema.

## Core CLI Tools

The package primarily operates through two main scripts: `bash5tools.py` and `cmph5tools.py`.

### bash5tools.py
Used for interrogating `.bas.h5` files (raw or filtered basecalls).

*   **Summarize Data**: Use the `summarize` subcommand to get a high-level overview of the file contents, including read counts and basic quality metrics.
*   **Statistics**: Use the `stats` subcommand to generate detailed metrics. If no arguments are passed to `stats`, it typically provides a default set of core metrics.
*   **Subsampling**: Supports extracting a fixed number of random reads using the `SubSample` functionality (e.g., specifying `n` reads).
*   **Read Type Filtering**: Allows filtering based on the `readType` to ensure the input file matches the expected data category (e.g., subreads vs. CCS).

### cmph5tools.py
Used for interrogating `.cmp.h5` files (aligned/mapped reads).

*   **Alignment Inspection**: Extract information regarding how reads were mapped to reference sequences.
*   **Data Extraction**: Convert HDF5 records into tabular formats using internal functions like `rec2tbl`.

## Common Usage Patterns

### File Interrogation
To quickly check the sanity and contents of a PacBio HDF5 file:
```bash
bash5tools.py summarize input.bas.h5
```

### Generating Metrics
To produce a report of sequencing statistics:
```bash
bash5tools.py stats input.bas.h5
```

### Random Subsampling
To extract a specific number of random reads for testing or downsampling:
```bash
bash5tools.py select --n 1000 input.bas.h5
```

## Expert Tips

*   **API Dependencies**: `pbh5tools` relies heavily on `pbcore`. Ensure `pbcore` is correctly installed in the environment, as many `pbh5tools` commands are wrappers around `BasH5Reader` and `CmpH5Reader` classes.
*   **Reference Matching**: When working with `cmp.h5` files, ensure the reference sequences used for the original alignment are available if the tool needs to validate coordinate systems.
*   **Output Formats**: While the tool supports tabular output (`rec2tbl`), legacy versions may have limited or unimplemented CSV support. Prefer tab-delimited output for downstream processing.
*   **Error Handling**: If a script dumps an exception regarding `readType`, verify that the input file actually contains the type of reads (e.g., Polymerase, Subread) you are requesting.

## Reference documentation
- [Main Repository Overview](./references/github_com_zkennedy_pbh5tools.md)
- [Commit History and Feature Evolution](./references/github_com_zkennedy_pbh5tools_commits_master.md)