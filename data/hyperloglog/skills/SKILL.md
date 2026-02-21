---
name: hyperloglog
description: The `hyperloglog` skill provides a Python-based implementation for counting unique elements in a dataset without the memory overhead of storing every individual item.
homepage: https://github.com/svpcom/hyperloglog
---

# hyperloglog

## Overview
The `hyperloglog` skill provides a Python-based implementation for counting unique elements in a dataset without the memory overhead of storing every individual item. By using the HyperLogLog (HLL) algorithm, you can estimate cardinality with a configurable error rate. This implementation also includes "Sliding HyperLogLog" for tracking unique items within a moving time window and incorporates HLL++ bias correction for improved accuracy.

## Implementation Guide

### Basic Cardinality Counting
To use the standard HyperLogLog counter, initialize it with a target error rate. A lower error rate provides higher precision but consumes more memory.

```python
import hyperloglog

# Initialize with a 1% (0.01) expected error rate
hll = hyperloglog.HyperLogLog(0.01)

# Add elements (strings, numbers, etc.)
hll.add("user_123")
hll.add("user_456")
hll.add("user_123") # Duplicate items do not increase the count

# Get the estimated cardinality
print(len(hll)) # Output: 2
```

### Sliding Window Counting
For time-sensitive data where you only care about unique items within a specific window (e.g., unique users in the last hour), use the `SlidingHyperLogLog` variant.

### Performance and Memory Optimization
*   **Error Rate Selection**: The memory usage is proportional to `(1/error_rate)^2`. 
    *   1% error (0.01) is a standard balance for most applications.
    *   5% error (0.05) is sufficient for high-level dashboards and significantly reduces memory footprint.
*   **NumPy Integration**: Recent versions of this library utilize NumPy for internal array management. Ensure NumPy is installed to benefit from optimized performance, especially when handling large numbers of counters.
*   **Data Types**: The library handles various input types. For maximum performance when processing massive streams, ensure data is consistently encoded (e.g., UTF-8 strings) before calling `.add()`.

## Expert Tips
*   **Bias Correction**: This implementation includes bias correction from the HLL++ paper, which makes it significantly more accurate for small sets (low cardinality) compared to the original HLL algorithm.
*   **Persistence**: The objects support pickling. You can save the state of a counter to disk and reload it later to continue counting without losing the current estimation.
*   **Thread Safety**: When using this in a multi-threaded environment (like a web server tracking unique hits), wrap the `.add()` calls in a lock if the same HLL object is being updated by multiple threads simultaneously.

## Reference documentation
- [github_com_svpcom_hyperloglog.md](./references/github_com_svpcom_hyperloglog.md)
- [anaconda_org_channels_bioconda_packages_hyperloglog_overview.md](./references/anaconda_org_channels_bioconda_packages_hyperloglog_overview.md)