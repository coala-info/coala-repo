---
name: r-fastmatch
description: "Package providing a fast match() replacement for cases 	that require repeated look-ups. It is slightly faster that R's 	built-in match() function on first match against a table, but 	extremely fast on any subsequent lookup as it keeps the hash 	table in memory.</p>"
homepage: https://cloud.r-project.org/web/packages/fastmatch/index.html
---

# r-fastmatch

name: r-fastmatch
description: High-performance replacement for R's built-in match() and %in% functions. Use this skill when performing repeated lookups against the same target table, working with large datasets where match() performance is a bottleneck, or when you need to pre-hash tables for optimized search operations.

## Overview

The `fastmatch` package provides a fast `match()` replacement (`fmatch`) designed for cases requiring repeated look-ups. While it is slightly faster than R's built-in `match()` on the first call, it is significantly faster on subsequent lookups because it stores the hash table in memory, attaching it to the target table object.

## Installation

```R
install.packages("fastmatch")
library(fastmatch)
```

## Main Functions

### fmatch()
The primary replacement for `match()`.
- **Usage**: `fmatch(x, table, nomatch = NA_integer_, incomparables = NULL)`
- **Behavior**: The first time `fmatch` is called on a specific `table` object, it creates a hash table and caches it as an attribute of that object. Subsequent calls using the same `table` object will reuse this hash, resulting in $O(n)$ complexity.

### %fin%
A fast replacement for the `%in%` operator.
- **Usage**: `x %fin% table`
- **Benefit**: Uses `fmatch` internally, making it much faster than `%in%` for repeated checks against the same set of values.

### fmatch.hash()
Manually creates a hash table for a given object.
- **Usage**: `fmatch.hash(table)`
- **Purpose**: Useful if you want to pre-calculate the hash table before the first lookup to ensure the first `fmatch` call is also fast.

## Workflows and Tips

### Repeated Lookups
The performance gain is most visible when the `table` argument remains the same across multiple calls.
```R
# Standard R match
idx1 <- match(query1, reference_data)
idx2 <- match(query2, reference_data) # Re-hashes reference_data

# fastmatch fmatch
library(fastmatch)
idx1 <- fmatch(query1, reference_data) # Hashes reference_data
idx2 <- fmatch(query2, reference_data) # Reuses existing hash
```

### Memory Considerations
Because `fastmatch` stores the hash table as an attribute of the `table` object, it increases the memory footprint of that object. If you are finished with lookups and need to free memory, you can remove the hash using `attr(table, ".match.hash") <- NULL`.

### Handling Incomparables
Note that `fmatch` currently only supports `incomparables = NULL`. If you require specific handling for incomparable values, you may need to stick with base `match()`.

## Reference documentation

- [fastmatch - Fast match() function replacement](./references/home_page.md)
- [fastmatch: Fast 'match()' Function](./references/index.html.md)