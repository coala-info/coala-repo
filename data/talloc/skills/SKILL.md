---
name: talloc
description: talloc is a hierarchical memory allocator for C that simplifies resource management by tracking dependencies between memory chunks.
homepage: https://github.com/esneider/talloc
---

# talloc

## Overview

talloc is a hierarchical memory allocator for C that simplifies resource management by tracking dependencies between memory chunks. In a talloc-managed system, every allocation can have a "parent" context. When a parent chunk is freed, all of its children (and their descendants) are automatically freed as well. This transforms memory management from manual tracking of every individual pointer into a tree-based lifecycle management system, making it ideal for complex objects like nested configurations, ASTs, or multi-dimensional arrays.

## Core API Usage

### Basic Allocation
*   **`talloc(size_t size, void *parent)`**: Allocates a block of memory. If `parent` is NULL, it creates a new top-level context.
*   **`tzalloc(size_t size, void *parent)`**: The preferred allocation method. It performs the same action as `talloc` but initializes the memory to zero.
*   **`tfree(void *ptr)`**: Frees the specified pointer and the entire subtree of memory chunks that depend on it.

### Memory Manipulation
*   **`trealloc(void *ptr, size_t size)`**: Resizes a talloc chunk while preserving its place in the hierarchy.
*   **`talloc_steal(void *ptr, void *new_parent)`**: Moves a memory chunk from its current parent to a new one. This is a critical pattern for "promoting" memory from a temporary local context to a long-lived global context.
*   **`talloc_set_parent(void *ptr, void *new_parent)`**: Changes the parent of a chunk, affecting the entire subtree rooted at that chunk.

## Best Practices and Expert Tips

### 1. Avoid Mixing Allocators
Never mix the standard `malloc`/`free` family with `talloc`/`tfree`. A chunk allocated with `talloc` must be freed with `tfree`. Mixing them will lead to heap corruption or segmentation faults because talloc maintains a 3-pointer overhead per chunk to track the hierarchy.

### 2. Use Hierarchy for Error Handling
When performing a multi-step operation that requires several allocations, create a temporary "top-level" context for that operation:
1. Create a `tmp_ctx` using `talloc(0, NULL)`.
2. Make all intermediate allocations children of `tmp_ctx`.
3. If any step fails, simply call `tfree(tmp_ctx)` to clean up everything at once.
4. If the operation succeeds, "steal" the final result to the permanent parent and then free `tmp_ctx`.

### 3. Zero-Length Allocations
You can call `talloc(0, parent)` to create a "named" context or a logical grouping point that doesn't hold data itself but serves as a parent for other allocations.

### 4. Multi-dimensional Arrays
To create a matrix where the entire structure can be freed with one call:
1. Allocate the main struct/header.
2. Allocate the row-pointer array as a child of the main struct.
3. Allocate each row as a child of the row-pointer array.
4. A single `tfree` on the main struct cleans up the header, the pointers, and all rows.

## Build Integration

To use talloc in a project, include the header and link against the compiled object:

```c
#include "talloc.h"
```

When compiling, ensure the `src/talloc.c` is included in your build process or linked as a library. The provided `Makefile` in the repository can be used to build the source and run tests.

## Reference documentation
- [talloc README and API Overview](./references/github_com_esneider_talloc.md)