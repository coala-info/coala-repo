---
name: homoeditdistance
description: This tool calculates the edit distance between strings by treating contiguous blocks of identical characters as single units for insertion or deletion operations. Use when user asks to calculate the homo-edit distance between sequences, perform string comparisons that ignore homopolymer length variations, or trace the specific block-based transformations needed to turn one string into another.
homepage: https://github.com/AlBi-HHU/homo-edit-distance
metadata:
  docker_image: "quay.io/biocontainers/homoeditdistance:0.0.1--py_0"
---

# homoeditdistance

## Overview

The `homoeditdistance` skill provides a specialized method for string comparison that differs from standard Levenshtein distance. Instead of single-character edits, it operates on "blocks" of identical characters. A single operation consists of either inserting or deleting a contiguous string of the same character (e.g., deleting "AAA" is one operation). This tool is essential when analyzing sequences where the length of repeated character runs is variable or prone to specific types of biological sequencing errors.

## Command Line Usage (hed)

The package installs a command-line utility named `hed`.

### Basic Distance Calculation
To find the distance between two strings:
```bash
hed -s "TCAGACT" -t "TAGGCTT"
```

### Detailed Analysis
To see the specific transformation steps and all optimal subsequences, use the `-a` (all) and `-b` (backtrace) flags:
```bash
hed -s "TCAGACT" -t "TAGGCTT" -a -b
```

### CLI Arguments
- `-s, --string1`: The source string. Use quotation marks for empty strings or strings containing special characters.
- `-t, --string2`: The target string.
- `-a, --all`: Displays all optimal subsequences found by the algorithm.
- `-b, --backtrace`: Prints the specific sequence of operations (e.g., "Deleting substring C from s") to reach the target.

## Python API Integration

You can integrate the algorithm directly into Python scripts for batch processing.

```python
from homoeditdistance import homoEditDistance

s1 = "TCAGACT"
s2 = "TAGGCTT"

# The third argument is typically 0 for standard usage
result = homoEditDistance(s1, s2, 0)

print(f"Distance: {result['hed']}")
```

## Best Practices and Tips

- **Input Sanitization**: When using the CLI, always wrap strings in double quotes to prevent shell expansion or errors with empty strings.
- **Interpreting Results**: The "homo-edit distance" is often smaller than the standard edit distance because it treats character blocks as single units. If your analysis requires penalizing the length of the insertion, this tool may not be the appropriate choice as it treats all block lengths equally (cost = 1).
- **Bioinformatics Context**: This tool is particularly effective for analyzing sequences from technologies prone to homopolymer errors (like Ion Torrent or 454 sequencing), where the identity of the base is certain but the count of the base is not.

## Reference documentation
- [homoeditdistance Overview](./references/anaconda_org_channels_bioconda_packages_homoeditdistance_overview.md)
- [homo-edit-distance GitHub Repository](./references/github_com_AlBi-HHU_homo-edit-distance.md)