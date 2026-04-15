---
name: esmre
description: The esmre module accelerates the execution of large sets of regular expressions by using an index of compulsory substrings to pre-filter potential matches. Use when user asks to index multiple regular expressions, perform high-performance string matching, or rapidly query a collection of patterns against an input string.
homepage: https://github.com/wharris/esmre
metadata:
  docker_image: "quay.io/biocontainers/esmre:0.3.1--py27_0"
---

# esmre

## Overview
The `esmre` module is a Python extension designed to accelerate the execution of large sets of regular expressions. It works by building an index of "compulsory substrings" extracted from your regex collection. When a query is performed, the tool uses this index to rapidly exclude any expressions that cannot possibly match the input, only running the full regex engine on the remaining candidates. This approach leverages the efficiency of the Aho-Corasick algorithm (via the underlying `esm` module) to provide a significant performance boost over linear iteration with the standard `re` module.

## Usage Patterns

### Basic Regex Indexing
To use `esmre`, initialize an index, register your patterns with associated metadata, and then query strings against the index.

```python
import esmre

# Initialize the index
index = esmre.Index()

# Enter patterns: index.enter(regex_string, return_value)
index.enter(r"Major-General\W*$", "savoy_opera")
index.enter(r"\bway\W+haye?\b", "sea_shanty")

# Query the index
# Returns a list of the return_values for all matching patterns
results = index.query("I am the very model of a modern Major-General.")
# Output: ['savoy_opera']
```

### Direct String Matching (Aho-Corasick)
If you only need to match literal strings rather than complex regular expressions, you can use the underlying `esm` module directly for even greater efficiency. Note that the `esm` module requires a `.fix()` call before querying.

```python
import esm

index = esm.Index()
index.enter("hers")
index.enter("his")
index.enter("she")

# Required for the base esm module to build the Aho-Corasick automaton
index.fix()

# Returns a list of tuples: ((start_index, end_index), matched_string)
results = index.query("Those are his sheep!")
# Output: [((10, 13), 'his'), ((14, 17), 'she'), ((15, 17), 'he')]
```

## Best Practices and Expert Tips

- **Compulsory Substrings**: `esmre` is most effective when your regular expressions contain literal string components. If a regex is entirely composed of wildcards or character classes (e.g., `.*`), the indexing mechanism cannot effectively pre-filter it.
- **Metadata Association**: Use the second argument of `index.enter()` to store IDs, callback functions, or category names. This allows you to immediately know which rule triggered without re-parsing the result.
- **Thread Safety**: While the underlying C implementation is fast, ensure you handle index creation and modification according to your application's concurrency model. Typically, you should build the index once and use it for multiple queries.
- **Memory Considerations**: Large indices with thousands of complex patterns can consume significant memory. Monitor your process if you are dynamically loading massive rule sets.
- **Python 3 Support**: Ensure you are using a recent version (1.0.1+) for stable Python 3 support and compatibility with modern build tools like Cython 3.

## Reference documentation
- [esmre - Efficient String Matching Regular Expressions](./references/github_com_wharris_esmre.md)