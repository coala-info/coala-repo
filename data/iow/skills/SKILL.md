---
name: iow
description: The iow library provides a memory-efficient balanced parentheses succinct data structure for representing and manipulating large tree structures. Use when user asks to perform phylogenetic fragment placement, integrate sequences into a tree using jplace files, or convert placement data into Newick format.
homepage: https://github.com/biocore/improved-octo-waddle
---


# iow

## Overview

The `iow` (Improved Octo Waddle) library provides a Python implementation of the balanced parentheses (BP) succinct data structure for representing trees. This approach allows for highly memory-efficient storage and manipulation of large tree structures. The tool is primarily used in bioinformatics for phylogenetic fragment placement, allowing users to integrate new sequences into an existing tree using the `jplace` format. It supports two primary resolution methods: breaking edges to maintain a fully resolved tree or creating multifurcations at the placement site.

## Installation and Setup

To avoid build errors related to dependencies, ensure `numpy` and `cython` are present in your environment before installing `iow`.

**Conda (Recommended):**
```bash
conda install -c bioconda iow
```

**Pip:**
```bash
pip install numpy cython
pip install iow
```

*Note: If you are building from source, you must initialize submodules:*
```bash
git clone https://github.com/biocore/improved-octo-waddle
cd improved-octo-waddle
git submodule update --init --recursive
```

## CLI Usage Patterns

The primary command-line interface is accessed via the `bp` command, specifically for tree placements.

### Fragment Placement

Use the `bp placement` command to insert fragments from a `.jplace` file into a tree and output the result in Newick format.

```bash
bp placement \
  --placements input.jplace \
  --output result.tre \
  --method fully-resolved
```

### Placement Methods

| Method | Description |
| :--- | :--- |
| `fully-resolved` | Breaks the target edge $N$ times for $N$ fragments, maintaining a bifurcating structure. |
| `multifurcating` | Creates a new node representing the average distal length of the fragments and adds a multifurcation. |

**Important:** The `multifurcating` method requires the GPL-licensed extension. If this method is required, you must install `iow-gpl` instead of the standard `iow` package.

## Expert Tips

- **Memory Efficiency:** Use `iow` when dealing with massive trees that exceed the memory limits of standard object-oriented tree libraries (like `scikit-bio` or `DendroPy`), as the balanced parentheses representation is significantly more compact.
- **Jplace Compatibility:** Ensure your `.jplace` files are properly formatted; the tool expects standard JSON-based placement data.
- **Environment Management:** Because `iow` relies on specific versions of Cython for its C-extensions, it is best used within a dedicated Conda environment to prevent library conflicts.

## Reference documentation

- [iow Overview - Bioconda](./references/anaconda_org_channels_bioconda_packages_iow_overview.md)
- [Improved Octo Waddle GitHub Repository](./references/github_com_biocore_improved-octo-waddle.md)