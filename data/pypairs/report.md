# pypairs CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pypairs_cyclone | Failed | image problem: python module click is missing, so cyclone stops at import (options rewritten from the tool source) |
| pypairs_sandbag | Failed | image problem: python module click is missing, so sandbag stops at import (new CWL written from the tool source) |

## pypairs_cyclone

### Tool Description
Cyclone is a tool for inferring cell cycle phase from single-cell RNA sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypairs:3.2.3--py_0
- **Homepage**: https://github.com/rfechtner/pypairs
- **Package**: https://anaconda.org/channels/bioconda/packages/pypairs/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/cyclone", line 7, in <module>
    from pypairs.cli.cyclone.__main__ import main
  File "/usr/local/lib/python3.8/site-packages/pypairs/cli/cyclone/__main__.py", line 1, in <module>
    import click
ModuleNotFoundError: No module named 'click'
```

## pypairs_sandbag

### Tool Description
Sandbag identifies marker gene pairs for each cell cycle class from a training data matrix and an annotation file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypairs:3.2.3--py_0
- **Homepage**: https://github.com/rfechtner/pypairs
- **Package**: https://anaconda.org/channels/bioconda/packages/pypairs/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/sandbag", line 7, in <module>
    from pypairs.cli.sandbag.__main__ import main
  File "/usr/local/lib/python3.8/site-packages/pypairs/cli/sandbag/__main__.py", line 1, in <module>
    import click, json, csv
ModuleNotFoundError: No module named 'click'
```
