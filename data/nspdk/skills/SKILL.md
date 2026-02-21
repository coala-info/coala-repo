---
name: nspdk
description: NSPDK (Neighborhood Subgraph Pairwise Distance Kernel) is a specialized tool for extracting structural features from molecular graphs.
homepage: https://github.com/aigulkhkmv/nspdk-features
---

# nspdk

## Overview

NSPDK (Neighborhood Subgraph Pairwise Distance Kernel) is a specialized tool for extracting structural features from molecular graphs. It decomposes molecules into subgraphs based on neighborhood relationships and represents them as high-dimensional feature vectors. This skill provides the procedural knowledge to configure feature complexity and bit-space size when processing SMILES strings into numerical descriptors.

## CLI Usage and Parameters

The tool is primarily executed via a Docker container (`nspdk_run`). The core logic requires an input file containing SMILES strings and specific parameters to define the feature extraction behavior.

### Command Syntax
```bash
docker run --rm -v /path/to/data:/usr/src/code/ nspdk_run -i <input_file> -c <complexity> -b <bits> -o <output_file>
```

### Parameter Definitions
- `-i`: **Input File**. Accepts `.smi` or `.txt` files. The structure must be one SMILES string per line.
- `-c`: **Complexity**. An integer defining the complexity of the features extracted (e.g., `-c 3`). Higher values capture more distant structural relationships.
- `-b`: **Bit Size**. Defines the feature space size where $|feature space| = 2^{nbits}$. For example, `-b 8` results in a feature space of 256.
- `-o`: **Output File**. The destination for the generated text file containing the NSPDK descriptors.

## Best Practices

- **Volume Mapping**: Always map your local working directory to `/usr/src/code/` inside the Docker container. The tool expects to find input files and write output files relative to this internal path.
- **Feature Space Optimization**: When working with large or highly diverse chemical libraries, increase the bit size (`-b`) to minimize bit collisions in the feature space.
- **Input Formatting**: Ensure the input file is clean. The expected format is a simple list of SMILES strings followed by a newline.
- **Complexity Scaling**: Start with a complexity (`-c`) of 3 for general-purpose machine learning tasks. Increase this only if the model fails to capture necessary structural nuances, as higher complexity significantly increases computational overhead.

## Reference documentation
- [NSPDK Features README](./references/github_com_aigulkhkmv_nspdk-features_blob_master_README.md)