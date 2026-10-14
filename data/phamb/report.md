# phamb CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| phamb_run_RF | Failed | image problem: /usr/local/bin/run_RF.py looks for dbs/RF_model.python39.sav next to itself, but the model is only in site-packages/phamb/dbs, so every run stops with FileNotFoundError |

## phamb_run_RF

### Tool Description
Command-line utility that predicts viral bins from VAMB clusters with the PHAMB random forest model.

### Metadata
- **Docker Image**: quay.io/biocontainers/phamb:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/RasmussenLab/phamb
- **Package**: https://anaconda.org/channels/bioconda/packages/phamb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: run_RF.py [-h] [-m] [-s SEPARATOR]
                 fastafile clusterspath annotationdir directoryout

Command-line benchmark utility.

positional arguments:
  fastafile      Path to concatenated assembly VAMB
  clusterspath   Path to clusters.tsv
  annotationdir  Path to directory with contig annotations
  directoryout   Path to directory out

options:
  -h, --help     show this help message and exit
  -m             Minimum size of bins - default [5000]
  -s SEPARATOR   Binsplit separator
```

## Metadata
- **Skill**: generated

