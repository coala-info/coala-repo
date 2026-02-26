---
name: gdpc
description: GDPC is a Python framework for programmatically reading from and writing to Minecraft worlds to enable generative design and automated construction. Use when user asks to generate settlements, place blocks programmatically, implement automated construction scripts, or perform geometric operations within Minecraft.
homepage: https://github.com/avdstaaij/gdpc
---


# gdpc

## Overview

GDPC is a Python framework specifically built for the Generative Design in Minecraft (GDMC) competition. It allows developers to write algorithms that can read from and write to a Minecraft world live while playing. This skill should be used to implement automated construction, settlement generation, and environmental adaptation scripts. It focuses on the core library components: the Editor for world interaction, the Block class for state management, and the geometry module for structural patterns.

## Core Usage Patterns

### Initializing the Editor
The `Editor` class is the primary interface. For any non-trivial generation, always enable buffering to minimize the overhead of HTTP requests.

```python
from gdpc import Editor, Block, geometry

# Initialize with buffering for performance
editor = Editor(buffering=True)
```

### Block Manipulation
Blocks are placed using 3D coordinate tuples `(x, y, z)`.

- **Retrieving Blocks**: `editor.getBlock((x, y, z))` returns the block at the specified location.
- **Placing Blocks**: `editor.placeBlock((x, y, z), Block("block_id"))`.
- **Block States**: The `Block` constructor accepts a string ID (e.g., `"stone"`, `"oak_planks"`).

### Geometric Operations
The `geometry` module provides high-level functions to place multiple blocks efficiently.

- **Cuboids**: Use `geometry.placeCuboid(editor, start_coords, end_coords, Block("id"))` to fill a rectangular area.
- **Performance Tip**: When using geometry functions with a buffered editor, the library handles the batching of block updates automatically.

## Best Practices

1. **Coordinate Handling**: Minecraft uses a (X, Y, Z) system where Y is the vertical axis. Ensure your algorithms account for the world's height limits (typically 0 to 319 in modern versions, or -64 to 319).
2. **Buffering Strategy**: While `buffering=True` is faster, remember that blocks are not actually placed in the world until the buffer is flushed or the script finishes. If your algorithm needs to "see" a block it just placed (via `getBlock`), ensure the buffer logic is synchronized.
3. **Terrain Adaptation**: Use the framework to query heightmaps before building. This is essential for the "Settlement Generation" challenge where buildings must adapt to the existing terrain.
4. **Namespace Management**: Always import `Editor`, `Block`, and `geometry` directly from `gdpc` for the cleanest implementation of procedural logic.

## Reference documentation

- [GDPC Repository Overview](./references/github_com_avdstaaij_gdpc.md)
- [Examples Directory](./references/github_com_avdstaaij_gdpc_tree_master_examples.md)