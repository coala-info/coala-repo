---
name: chemfp
description: "chemfp provides a high-performance framework for generating, searching, and managing cheminformatics fingerprints. Use when user asks to generate fingerprints, perform similarity searches, convert between FPS and FPB formats, or conduct clustering and diversity analysis."
homepage: https://chemfp.com
---


# chemfp

## Overview
The `chemfp` suite provides a high-performance framework for handling dense cheminformatics fingerprints. It is particularly effective for large-scale similarity searches and clustering tasks where speed and memory efficiency are critical. You should use this skill to automate molecular similarity workflows, generate fingerprints using various toolkits (RDKit, Open Babel, OEChem), and manage specialized binary formats like FPB for near-instantaneous data loading.

## Core CLI Patterns

### Fingerprint Generation
Generate fingerprints from structure files using toolkit-specific commands.
- **RDKit**: `rdkit2fps --morgan --radius 2 input.smi -o output.fps`
- **Open Babel**: `ob2fps --type FP2 input.sdf -o output.fps`
- **OEChem**: `oe2fps --type path input.smi -o output.fps`

### Similarity Searching
Perform high-speed Tanimoto searches.
- **Threshold search**: Find all targets with similarity >= 0.7.
  `simsearch --threshold 0.7 --queries queries.fps --target targets.fps -o results.txt`
- **K-Nearest Neighbors**: Find the top 10 most similar molecules.
  `simsearch --k 10 -q queries.fps -t targets.fps`
- **In-memory search**: Use the FPB format for massive speed gains on repeated searches.
  `simsearch -k 5 -q queries.fps targets.fpb`

### Format Conversion
Convert between exchange formats (FPS) and high-performance binary formats (FPB).
- **FPS to FPB**: `fps2fpb input.fps -o output.fpb`
- **FPB to FPS**: `fpb_text input.fpb > output.fps`
- **Sparse Count (FPC) to FPS**: `fpc2fps input.fpc -o output.fps`

### Clustering and Diversity
- **Butina Clustering**: Cluster a dataset based on a similarity threshold.
  `chemfp cluster --threshold 0.8 input.fps -o clusters.txt`
- **MaxMin Diversity**: Select a diverse subset of molecules.
  `chemfp maxmin --size 100 input.fps -o diverse_subset.fps`

## Expert Tips
- **Memory Mapping**: Always use `.fpb` files for large datasets (1M+ compounds). They use memory-mapping to allow multiple processes to share the same fingerprint data without redundant RAM usage.
- **Sorting**: For maximum search performance, ensure fingerprints are sorted by popcount (number of bits set). The `fps2fpb` tool does this automatically.
- **Toolkit Independence**: Use the `chemfp` "text toolkit" to extract fingerprints directly from SD file tags without needing a full chemistry toolkit installed.
- **Parallelization**: `simsearch` and `simarray` utilize OpenMP. Control the number of threads using the `OMP_NUM_THREADS` environment variable to optimize performance on multi-core systems.

## Reference documentation
- [chemfp features](./references/chemfp_com_features.md)
- [FPS format specification](./references/chemfp_com_fps_format.md)
- [FPB format specification](./references/chemfp_com_fpb_format.md)
- [FPC format specification](./references/chemfp_com_fpc_format.md)
- [chemfp performance](./references/chemfp_com_performance.md)