---
name: editdistance
description: This tool calculates the Levenshtein distance between two sequences of hashable objects using a fast, bit-parallel implementation. Use when user asks to compute the edit distance between strings, compare lists of tokens, or perform sequence similarity analysis.
homepage: https://github.com/roy-ht/editdistance
---


# editdistance

## Overview
The `editdistance` skill provides a fast, C++ and Cython-based implementation of the Levenshtein distance algorithm. It is designed for speed, utilizing a bit-parallel approximate string matching algorithm. A key advantage of this tool over similar libraries is its ability to compare any two iterables containing hashable objects—such as lists of strings or custom objects—rather than being restricted solely to string comparisons.

## Usage and Best Practices

### Installation
Install the library via pip:
```bash
pip install editdistance
```

### Basic String Comparison
The primary function is `eval()`, which returns the minimum number of edits (insertions, deletions, or substitutions) required to change one sequence into the other.

```python
import editdistance

# Returns the edit distance (integer)
distance = editdistance.eval('banana', 'bahama') 
# Result: 2
```

### Comparing Non-String Iterables
You can use `editdistance` to compare lists, tuples, or any iterable of hashable items. This is useful for word-level comparisons or sequence analysis.

```python
# Comparing lists of strings (words)
list_a = ['spam', 'egg']
list_b = ['spam', 'ham']
distance = editdistance.eval(list_a, list_b)
# Result: 1
```

### Performance Considerations
- **Algorithm**: The library implements the algorithm proposed by Heikki Hyyrö (2001), which is optimized for speed through bit-parallelism.
- **Benchmarking**: It is significantly faster than pure Python implementations (like `pylev`) and competitive with other C-based libraries (like `python-Levenshtein`).
- **Object Hashing**: When comparing custom objects within an iterable, ensure the objects have a proper `__hash__` method defined. The tool determines equality based on the hash of the objects.

### Expert Tips
- **Memory Efficiency**: Because it is implemented in C++, it handles large sequences more efficiently than native Python loops.
- **Type Flexibility**: Use this library specifically when your data is already tokenized (e.g., a list of words) to avoid the overhead of joining tokens into a single string just for comparison.

## Reference documentation
- [editdistance README](./references/github_com_roy-ht_editdistance.md)