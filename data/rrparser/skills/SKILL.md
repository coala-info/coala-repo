---
name: rrparser
description: "rrparser parses and filters synthetic biology reaction rules from local files or the RetroRules repository. Use when user asks to parse reaction rules, filter rules by diameter or directionality, or fetch data from RetroRules."
homepage: https://github.com/brsynth/RRParser
---


# rrparser

## Overview
`rrparser` is a specialized utility designed to handle reaction rules used in synthetic biology and metabolic pathway design. It provides a streamlined way to filter rule sets based on chemical diameter and directionality (forward, reverse, or both). A key feature is its native integration with the RetroRules repository, allowing users to download and process rules without manually providing an input file.

## CLI Usage Patterns

### Basic Rule Parsing
To parse a local file and save the results:
```bash
python -m rrparser rules-file input.csv --outfile results.csv
```

### Fetching from RetroRules
If you do not have a local file, use the `retrorules` keyword to fetch data directly from retrorules.org:
```bash
python -m rrparser rules-file retrorules --outfile my_rules.csv
```

### Filtering by Diameter and Type
Filter rules based on the atom-level diameter (sphere of influence around the reaction center) and the direction of the reaction:
```bash
python -m rrparser rules-file input.csv \
    --rule-type retro \
    --diameters 2,4,6 \
    --outfile filtered_rules.csv
```

## Tool-Specific Best Practices

- **Automatic Compression**: If the `--outfile` path ends with `.gz`, the tool will automatically gzip the output file to save space.
- **Diameter Constraints**: The tool only accepts specific integer values for diameters: `2, 4, 6, 8, 10, 12, 14, 16`.
- **Input Formats**: Ensure your input files are strictly `csv` or `tsv`. Use the `--input-format` flag if the file extension is non-standard.
- **Rule Types**:
    - `retro`: Returns rules for retrosynthesis (reverse direction).
    - `forward`: Returns rules for forward synthesis.
    - `all`: Returns both types.

## Python API Integration
For scripts requiring programmatic access, use the `parse_rules` function:

```python
from rrparser import parse_rules

outfile = parse_rules(
    rules_file='input.csv',
    outfile='output.csv',
    input_format='csv',
    rule_type='retro',
    diameters='2,4,6',
    output_format='csv'
)
```

## Reference documentation
- [RRParser Main Documentation](./references/github_com_brsynth_RRParser.md)