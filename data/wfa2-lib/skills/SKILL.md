---
name: wfa2-lib
description: WFA2-lib is a high-performance library for sequence alignment using the Wavefront Alignment algorithm. Use when user asks to align sequences, perform gap-affine alignment, align long or noisy sequences with low memory, accelerate alignment, or use different distance metrics.
homepage: https://github.com/smarco/WFA2-lib
metadata:
  docker_image: "quay.io/biocontainers/wfa2-lib:2.3.5--h9948957_3"
---

# wfa2-lib

## Overview
WFA2-lib is a high-performance library designed for the Wavefront Alignment algorithm, which provides an exact alternative to traditional dynamic programming (DP) methods like Smith-Waterman or Needleman-Wunsch. Instead of filling a quadratic DP table, it computes the "wavefront" of optimal alignment scores, resulting in a time complexity of $O(ns + s^2)$ where $s$ is the alignment score. This makes it exceptionally fast for sequences with high similarity. The library supports various distance metrics (gap-affine, dual-gap, edit, indel) and provides an "ultralow" memory mode (BiWFA) that reduces memory requirements from $O(s^2)$ to $O(s)$.

## Installation
The library can be installed via Bioconda or built from source:

```bash
# Via Conda
conda install bioconda::wfa2-lib

# From Source
git clone https://github.com/smarco/WFA2-lib
cd WFA2-lib
make clean all
```

## Core CLI Tool: align_benchmark
The library includes a powerful benchmarking tool located in the `tools/` directory (after building) used to execute and test alignments.

### Common Patterns
*   **Basic Gap-Affine Alignment:**
    ```bash
    ./align_benchmark -i input.sequences -p 4,6,2
    ```
    *(Note: Penalties are typically ordered as Mismatch, Gap-Opening, Gap-Extension)*

*   **Using Ultralow Memory (BiWFA):**
    Essential for long or noisy sequences where $O(s^2)$ memory would be prohibitive.
    ```bash
    ./align_benchmark -i input.sequences --memory-mode ultralow
    ```

*   **Applying Heuristics:**
    To accelerate alignment at the cost of potential sub-optimality (though often negligible in practice):
    ```bash
    ./align_benchmark -i input.sequences --heuristic adaptive-pruning
    ```

## C API Integration Best Practices
When integrating `wfa2-lib` into C/C++ projects, follow this standard workflow:

1.  **Initialize Attributes:** Use `wavefront_aligner_attr_default` as a starting point.
2.  **Configure Penalties:** Ensure mismatch, gap-opening, and gap-extension are positive integers.
3.  **Select Scope:** Decide if you need only the score or the full CIGAR string.
4.  **Memory Management:** Always call `wavefront_aligner_delete()` to free resources.

### Minimal C Example
```c
#include "wavefront/wavefront_align.h"

// 1. Setup attributes
wavefront_aligner_attr_t attributes = wavefront_aligner_attr_default;
attributes.distance_metric = gap_affine;
attributes.affine_penalties.mismatch = 4;
attributes.affine_penalties.gap_opening = 6;
attributes.affine_penalties.gap_extension = 2;

// 2. Initialize Aligner
wavefront_aligner_t* const wf_aligner = wavefront_aligner_new(&attributes);

// 3. Align
wavefront_align(wf_aligner, pattern, strlen(pattern), text, strlen(text));

// 4. Access Result
printf("Score: %d\n", wf_aligner->cigar->score);

// 5. Cleanup
wavefront_aligner_delete(wf_aligner);
```

## Expert Tips
*   **Vectorization:** WFA2-lib is designed to be automatically vectorized by modern compilers. When building from source, ensure you use optimization flags (e.g., `-O3`, `-march=native`).
*   **Distance Metrics:**
    *   `indel`: Only insertions and deletions.
    *   `edit`: Unit cost for mismatches and indels.
    *   `gap-linear`: Constant cost per gap base.
    *   `gap-affine`: Standard affine penalty (opening + extension).
*   **Alignment Span:** The library supports Global (end-to-end), Semi-global, and Extension alignment modes. Adjust `attributes.alignment_span` accordingly.
*   **Heuristic Pruning:** If performance is the priority, use `adaptive-pruning`. It discards wavefront elements that are unlikely to lead to the optimal path, significantly reducing the search space.

## Reference documentation
- [WFA2-lib GitHub README](./references/github_com_smarco_WFA2-lib.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_wfa2-lib_overview.md)