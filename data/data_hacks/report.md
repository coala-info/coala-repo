# data_hacks CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| data_hacks_bar_chart.py | PASS |  |

## Metadata
- **Skill**: generated

## data_hacks_bar_chart.py

### Tool Description
Draw an ASCII bar chart of how often each value occurs in the input (read from stdin).

### Metadata
- **Docker Image**: quay.io/biocontainers/data_hacks:0.3.1--py27_0
- **Homepage**: https://github.com/bitly/data_hacks
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: cat data | bar_chart.py [options]

Options:
  -h, --help           show this help message and exit
  -a, --agg            Two column input format, space seperated with
                       value<space>key
  -A, --agg-key-value  Two column input format, space seperated with
                       key<space>value
  -k, --sort-keys      sort by the key [default]
  -v, --sort-values    sort by the frequence
  -r, --reverse-sort   reverse the sort
  -n, --numeric-sort   sort keys by numeric sequencing
  -p, --percentage     List percentage for each bar
```

