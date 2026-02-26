# unitig-caller CWL Generation Report

## unitig-caller

### Tool Description
Call unitigs in a population dataset

### Metadata
- **Docker Image**: quay.io/biocontainers/unitig-caller:1.3.1--py311heec5c76_1
- **Homepage**: https://github.com/johnlees/unitig-caller
- **Package**: https://anaconda.org/channels/bioconda/packages/unitig-caller/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/unitig-caller/overview
- **Total Downloads**: 39.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/johnlees/unitig-caller
- **Stars**: N/A
### Original Help Text
```text
usage: unitig-caller [-h] (--call | --query | --simple) [--refs REFS]
                     [--reads READS] [--graph GRAPH] [--colours COLOURS]
                     [--unitigs UNITIGS] [--pyseer] [--rtab] [--out OUT]
                     [--kmer KMER] [--write-graph] [--no-save-idx]
                     [--threads THREADS] [--version]

Call unitigs in a population dataset

options:
  -h, --help         show this help message and exit

Mode of operation:
  --call             Build a DBG and call colours of unitigs within
  --query            Query unitig colours in reference genomes/DBG
  --simple           Use FM-index to make calls

Unitig-caller input/output:
  --refs REFS        Ref file to used to build DBG or use with --simple
  --reads READS      Read file to used to build DBG
  --graph GRAPH      Existing graph in GFA format
  --colours COLOURS  Existing bifrost colours file in .bfg_colors format
  --unitigs UNITIGS  Text or fasta file of unitigs to query (--query or
                     --simple)
  --pyseer           Output pyseer format
  --rtab             Output rtab format
  --out OUT          Prefix for output [default = 'unitig_caller']

Bifrost options:
  --kmer KMER        K-mer size for graph building/querying [default = 31]
  --write-graph      Output DBG built with unitig-caller

Simple mode options:
  --no-save-idx      Do not save FM-indexes for reuse

Other:
  --threads THREADS  Number of threads to use [default = 1]
  --version          show program's version number and exit
```

