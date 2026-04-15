---
name: perl-sort-mergesort
description: This tool merges multiple pre-sorted data streams into a single sorted sequence using a memory-efficient merge-sort algorithm. Use when user asks to merge pre-sorted files, consolidate large-scale genomic data, or perform stable sorting on multiple input iterators.
homepage: http://metacpan.org/pod/Sort::MergeSort
metadata:
  docker_image: "quay.io/biocontainers/perl-sort-mergesort:0.31--pl5321hdfd78af_2"
---

# perl-sort-mergesort

## Overview
The `perl-sort-mergesort` tool provides a robust mechanism for performing merge-sort operations on streams of data. Unlike standard sorting which requires loading all data into memory, this tool excels at taking multiple inputs that are already sorted and interleaving them into a single sorted sequence. This approach is highly memory-efficient and is the preferred method for consolidating large-scale genomic or tabular data that has been processed in parallel chunks.

## Usage Patterns

### Basic Command Line Execution
The tool is typically invoked via Perl as it is a module-based utility. Use the following pattern to merge sorted files:

```bash
perl -MSort::MergeSort -e '...implementation logic...'
```

### Core Functional Logic
When using the tool, you must define how the comparison between elements occurs. The `Sort::MergeSort` module provides several key functions:

- `mergesort($coderef, @iterators)`: The primary function. It takes a subroutine reference for comparison and a list of iterators (filehandles or arrays).
- **Comparison Subroutine**: This must return -1, 0, or 1 (similar to the Perl `cmp` or `<=>` operators) to determine the order of elements from the input streams.

### Expert Tips for Large Files
1. **Iterator Efficiency**: Instead of loading entire files into arrays, pass filehandle iterators to `mergesort`. This ensures that only the top element of each stream is in memory at any given time.
2. **Custom Keys**: If merging tabular data (like BED or VCF files), ensure your comparison subroutine targets the specific columns used for the initial sort (e.g., Chromosome then Position).
3. **Stability**: The mergesort algorithm is stable; if two elements are equal according to the comparison function, their relative order from the input streams is preserved.

## Common Pitfalls
- **Pre-sorting Requirement**: This tool does *not* sort unsorted data; it merges data that is already sorted. If input streams are not pre-sorted, the output will be interleaved but not globally sorted.
- **EOF Handling**: Ensure your iterators correctly return `undef` or a specific sentinel value when a stream is exhausted so the merger can proceed to the remaining streams.

## Reference documentation
- [Sort::MergeSort Documentation](./references/metacpan_org_pod_Sort__MergeSort.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-sort-mergesort_overview.md)