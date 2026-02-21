---
name: edlib
description: Edlib is a lightweight C/C++ and Python library designed for rapid sequence alignment.
homepage: https://github.com/Martinsos/edlib/
---

# edlib

## Overview

Edlib is a lightweight C/C++ and Python library designed for rapid sequence alignment. It utilizes Myers's bit-vector algorithm to calculate edit distances significantly faster than traditional dynamic programming methods. It is the tool of choice when you need to find the optimal alignment path (CIGAR) or simply the edit distance between two strings while maintaining a small memory footprint.

## Core Alignment Modes

Edlib supports three distinct alignment modes, each suited for different biological or computational scenarios:

- **Global (NW)**: Standard Needleman-Wunsch alignment. Use this when you expect the two sequences to be of similar length and aligned from start to finish.
- **Prefix (SHW)**: Semi-global alignment where the query must align to a prefix of the target. Use this when looking for a sequence that starts at the beginning of a reference.
- **Infix (HW)**: Also known as "overlap" or "local" fit. The query can align anywhere within the target sequence without penalty for leading or trailing gaps in the target. Use this for finding a small sequence (like a primer or adapter) within a much larger sequence.

## Installation and Setup

The most efficient way to deploy edlib in a bioinformatics environment is via Bioconda:

```bash
conda install -c bioconda edlib
```

For Python-based workflows, it can be installed via pip:

```bash
pip install edlib
```

## Usage Patterns and Best Practices

### Task Selection for Performance
Edlib allows you to define the "task" level to optimize speed. If you do not need the full alignment path, choosing a simpler task will reduce execution time:
1. **Distance Only**: Returns only the edit distance score. Fastest mode.
2. **Locations**: Returns the edit distance and the start/end locations in the target.
3. **Path**: Returns distance, locations, and the alignment path (CIGAR). Most resource-intensive.

### Handling Large Sequences
Because Edlib uses bit-vector parallelization, it is exceptionally efficient for long sequences. However, when finding the alignment path for very large sequences, ensure you have sufficient memory for the traceback matrix, though Edlib is generally more memory-efficient than competitors.

### Custom Character Equality
Edlib allows for the extension of character equality. This is useful for:
- **Case-insensitive alignment**: Treating 'A' and 'a' as equal.
- **Degenerate Nucleotides**: Defining wildcards (e.g., 'N' matching any base).

### Integration in C++ Projects
To use Edlib in a native C++ application, you only need to include `edlib.h` and compile with `edlib.cpp`. A basic implementation follows this pattern:

```cpp
#include "edlib.h"

// Configuration for default global alignment
EdlibAlignConfig config = edlibDefaultAlignConfig();
config.mode = EDLIB_MODE_NW; // Global
config.task = EDLIB_TASK_DISTANCE; // Only get the score

EdlibAlignResult result = edlibAlign(query, queryLen, target, targetLen, config);

if (result.status == EDLIB_STATUS_OK) {
    int distance = result.editDistance;
}
edlibFreeAlignResult(result);
```

## Expert Tips

- **Infix for Mapping**: When mapping short reads to a long reference, always use `EDLIB_MODE_HW` (Infix). This prevents the tool from penalizing the "gaps" at the start and end of the reference where the read doesn't align.
- **CIGAR Strings**: If you require a standard SAM-compatible CIGAR string, use `EDLIB_TASK_PATH`. Note that Edlib's internal path representation may need to be converted to the standard `M`, `I`, `D` format depending on your downstream tools.
- **Alphabet Size**: Edlib is optimized for small alphabets (like DNA/RNA). Performance is best when the number of unique characters in the sequences is small.

## Reference documentation
- [Edlib GitHub Repository](./references/github_com_Martinsos_edlib.md)
- [Bioconda Edlib Package](./references/anaconda_org_channels_bioconda_packages_edlib_overview.md)