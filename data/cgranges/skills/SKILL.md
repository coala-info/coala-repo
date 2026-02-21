---
name: cgranges
description: cgranges is a specialized library designed for the rapid identification of overlapping genomic regions.
homepage: https://github.com/lh3/cgranges
---

# cgranges

## Overview
cgranges is a specialized library designed for the rapid identification of overlapping genomic regions. Unlike traditional interval trees, it uses an implicit tree structure encoded in a sorted array, which minimizes memory overhead and maximizes cache locality. It is ideal for processing large-scale genomic datasets where performance and memory footprint are critical.

## Installation
The easiest way to install cgranges is via Bioconda:
```bash
conda install bioconda::cgranges
```

## C API Usage
For C development, include `cgranges.h` and follow this lifecycle:

1. **Initialize**: Create the `cgranges_t` object.
2. **Add Intervals**: Populate the tree with genomic coordinates.
3. **Index**: Build the implicit tree structure.
4. **Query**: Perform overlap searches.
5. **Cleanup**: Free the result array and destroy the object.

```c
cgranges_t *cr = cr_init();
cr_add(cr, "chr1", 20, 30, 0); // chrom, start, end, label/id
cr_index(cr);

int64_t i, n, *b = 0, max_b = 0;
n = cr_overlap(cr, "chr1", 15, 22, &b, &max_b);
for (i = 0; i < n; ++i)
    printf("%d\t%d\t%d\n", cr_start(cr, b[i]), cr_end(cr, b[i]), cr_label(cr, b[i]));

free(b); // Important: cr_overlap allocates b
cr_destroy(cr);
```

## C++ API Usage
The C++ implementation uses a header-only template class `IITree`.

```cpp
#include "cpp/IITree.h"

IITree<int, int> tree;
tree.add(12, 34, 0); // start, end, data
tree.index();

std::vector<size_t> a;
tree.overlap(22, 25, a);
for (size_t i = 0; i < a.size(); ++i)
    printf("%d\t%d\t%d\n", tree.start(a[i]), tree.end(a[i]), tree.data(a[i]));
```

## CLI Tool: bedcov-cr
The repository includes a sample implementation of a BED coverage tool. It is significantly faster than standard bedtools for simple coverage depth calculations.

```bash
# Usage: bedcov-cr <target.bed> <query.bed>
./bedcov-cr annotation.bed reads.bed
```
The first file is indexed into RAM; the second file is queried against that index to compute depth and breadth of coverage.

## Expert Tips and Best Practices
- **Memory Management**: In the C API, `cr_overlap` allocates or reallocates the output array `b`. You must manually `free(b)` when finished to avoid memory leaks.
- **Sorted Results**: cgranges returns overlapping intervals sorted by start position. This is highly beneficial for calculating breadth of coverage without additional sorting steps.
- **Worst-Case Performance**: The "Implicit Augmented Interval Tree" algorithm is sensitive to intervals that span an entire chromosome (e.g., assembly gaps or whole-chromosome features). These can increase query time.
- **Labeling**: The `label` field in `cr_add` is a 4-byte integer. Use this to store indices or IDs that map back to more complex metadata stored in external arrays.
- **Containment Mode**: While primarily used for overlaps, the library supports containment logic. Ensure you are using the correct query parameters if you specifically need regions entirely contained within the query window.

## Reference documentation
- [cgranges GitHub Repository](./references/github_com_lh3_cgranges.md)
- [Bioconda cgranges Overview](./references/anaconda_org_channels_bioconda_packages_cgranges_overview.md)