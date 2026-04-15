---
name: mp3treesim
description: mp3treesim calculates similarity scores between complex tree structures using a triplet-based measure that supports multiple and repeating labels. Use when user asks to compare tree structures, calculate similarity between Graphviz files, or analyze trees with multi-labeled nodes.
homepage: https://algolab.github.io/mp3treesim/
metadata:
  docker_image: "quay.io/biocontainers/mp3treesim:1.0.6--py_0"
---

# mp3treesim

## Overview
The `mp3treesim` tool implements a triplet-based similarity measure designed for complex tree structures. Unlike standard metrics, it handles trees where a single node contains multiple labels and where labels can repeat across different nodes. It provides a similarity score (typically between 0 and 1) based on the shared relationships of triplets of labels.

## CLI Usage Patterns

The basic syntax requires two tree files in Graphviz (.gv) format:
```bash
mp3treesim <tree1.gv> <tree2.gv>
```

### Comparison Modes
Choose a mode based on how you want to handle label sets that differ between the two trees:
- **Intersection Mode (`-i`)**: Only considers labels present in both trees.
- **Union Mode (`-u`)**: Considers the union of all labels; labels missing in one tree are treated as if they were not present in that specific structure.
- **Geometric Mode (`-g`)**: Calculates the geometric mean of the similarity.

### Filtering and Optimization
- **Exclude Labels**: Use `--exclude` to ignore specific noise or root labels.
  - Same labels from both: `--exclude "A,B"`
  - Different labels per tree: `--exclude "A,B" "C,D"`
- **Labeled Only**: Use `--labeled-only` to ignore internal nodes that do not have a "label" attribute, treating the input as a partially-labeled tree.
- **Performance**: For large trees or batch comparisons, use the `-c` flag to specify CPU cores:
  ```bash
  mp3treesim -c 8 tree1.gv tree2.gv
  ```

## Python Module Integration
For programmatic workflows or clustering, use the module directly:

```python
import mp3treesim as mp3

# Load trees from Graphviz files
t1 = mp3.read_dotfile('tree1.gv')
t2 = mp3.read_dotfile('tree2.gv')

# Calculate similarity
score = mp3.similarity(t1, t2)
```

## Input Requirements
- **Format**: Files must be valid Graphviz/DOT files.
- **Labels**: Multiple labels within a single node must be comma-separated (e.g., `[label="A,B,C"]`).
- **Structure**: Nodes must have a `label` attribute unless using the `--labeled-only` flag to skip unlabeled nodes.

## Reference documentation
- [MP3-treesim Documentation](./references/algolab_github_io_mp3treesim.md)
- [Clustering Example Notebook](./references/algolab_github_io_mp3treesim_examples_clustering.ipynb.md)