---
name: chemfp
description: Chemfp is a high-performance toolkit for generating, searching, and managing cheminformatics fingerprints. Use when user asks to generate fingerprints from chemical structures, perform similarity searches, convert between FPS and FPB formats, or perform clustering and diversity selection.
homepage: https://chemfp.com
---

# chemfp

## Overview

chemfp is a specialized suite for handling cheminformatics fingerprints with a focus on speed and memory efficiency. It supports multiple chemistry toolkits (RDKit, Open Babel, OEChem, CDK) and provides both a command-line interface and a Python API. It is particularly effective for processing large-scale datasets (millions of molecules) using the binary FPB format, which allows for memory-mapped I/O and extremely fast similarity calculations.

## Common CLI Workflows

### Fingerprint Generation
Generate fingerprints from structure files (SMILES, SDF) using a specific toolkit.
```bash
# Using RDKit to generate Morgan fingerprints (radius 2)
chemfp rdkit2fps molecules.smi -o fingerprints.fps

# Using Open Babel to generate FP2 fingerprints
chemfp ob2fps molecules.sdf -o fingerprints.fps
```

### Similarity Searching
Perform k-nearest neighbor or threshold-based searches.
```bash
# Find the 10 most similar targets for each query with a minimum score of 0.7
simsearch -k 10 --threshold 0.7 targets.fpb queries.fps -o results.txt

# Output results in CSV format for easier downstream analysis
simsearch --threshold 0.8 targets.fpb queries.smi --out csv -o results.csv
```

### Format Conversion and Management
Convert between the text-based FPS format and the high-performance binary FPB format.
```bash
# Convert FPS to FPB (highly recommended for large datasets)
fpcat fingerprints.fps -o fingerprints.fpb

# View metadata and header information of a fingerprint file
fpcat --header fingerprints.fpb
```

## Working with Sparse Count Fingerprints

Chemfp 5.0+ supports sparse count fingerprints (FPC format), which can be converted to binary fingerprints for searching.

### Generation and Conversion
```bash
# Generate Morgan count fingerprints using RDKit
chemfp rdkit2fpc molecules.smi -o counts.fpc

# Convert counts to binary using the "superimpose" method
chemfp fpc2fps counts.fpc -o binary.fpb

# Convert counts to binary using "folding" (ignores counts, same as standard Morgan)
chemfp fpc2fps -m fold counts.fpc -o folded.fpb
```

## Diversity and Clustering

### Butina Clustering
Group molecules into clusters based on a similarity threshold.
```bash
# Cluster molecules with a Tanimoto threshold of 0.8
chemfp butina --threshold 0.8 fingerprints.fpb -o clusters.txt
```

### Diversity Selection (MaxMin)
Select a diverse subset of molecules from a larger library.
```bash
# Select 100 diverse molecules
chemfp maxmin -n 100 fingerprints.fpb -o diverse_picks.fps
```

## Expert Tips and Performance

- **Use FPB for Speed**: Always convert `.fps` files to `.fpb` for large-scale searches. FPB files are memory-mapped, meaning they load instantly and allow the OS to manage memory efficiently.
- **Parallel Processing**: Use the `--procs` (or `-j`) flag in `simsearch` to utilize multiple CPU cores for faster searching.
- **In-Memory Search**: For the fastest possible performance in Python, load fingerprints into an "Arena":
  ```python
  import chemfp
  arena = chemfp.load_fingerprints("data.fpb")
  results = arena.threshold_tanimoto_search_fp(query_fp, threshold=0.7)
  ```
- **Toolkit Selection**: If a toolkit is not specified, chemfp will attempt to use available ones. Explicitly use `rdkit2fps`, `ob2fps`, etc., to ensure consistency.



## Subcommands

| Command | Description |
|---------|-------------|
| chemfp_fps2fpb | Convert a fingerprint file in FPS format to the FPB format. FPB files are a binary format for fingerprints that allow for fast loading and memory-mapped access. |
| rdkit2fps | Generate FPS fingerprints from a structure file using RDKit |
| simsearch | Search a set of target fingerprints for those similar to the query fingerprints. |

## Reference documentation

- [Command-line examples for binary fingerprints](./references/chemfp_com_docs_tools.html.md)
- [Command-line examples for sparse count fingerprints](./references/chemfp_com_docs_count_tools.html.md)
- [The chemfp command-line tools](./references/chemfp_com_docs_tool_help.html.md)
- [Getting started with the API](./references/chemfp_com_docs_getting_started_api.html.md)
- [FPB Format Overview](./references/chemfp_com_fpb_format.md)