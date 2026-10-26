# unitig-counter CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| unitig-counter | PASS |  |
| unitig-counter_cdbg-ops_dist | PASS |  |
| unitig-counter_cdbg-ops_extend | PASS |  |

## unitig-counter

### Tool Description
Count unitigs in sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/unitig-counter:1.1.0--h5ca1c30_2
- **Homepage**: https://github.com/johnlees/unitig-counter
- **Package**: https://anaconda.org/channels/bioconda/packages/unitig-counter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/unitig-counter/overview
- **Total Downloads**: 13.6K
- **Last updated**: 2025-08-28
- **GitHub**: https://github.com/johnlees/unitig-counter
- **Stars**: N/A
### Original Help Text
```text
ERROR: Unknown parameter '--help'
ERROR: Option '-strains' is mandatory

[unitig-counter options]
       -gzip     (0 arg) :    Compress unitig output using gzip.
       -strains  (1 arg) :    A text file describing the strains containing 2 columns: 1) ID of the strain; 2) Path to a multi-fasta file containing the sequences of the strain. This file needs a header.
       -k        (1 arg) :    K-mer size.  [default '31']
       -output   (1 arg) :    Path to the folder where the final and temporary files will be stored.  [default 'output']
       -nb-cores (1 arg) :    number of cores  [default '0']
       -verbose  (1 arg) :    verbosity level  [default '1']
       -version  (0 arg) :    version
       -help     (0 arg) :    help
```

## unitig-counter_cdbg-ops_dist

### Tool Description
Calculate distance between two nodes of the compacted de Bruijn graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/unitig-counter:1.1.0--h5ca1c30_2
- **Homepage**: https://github.com/johnlees/unitig-counter
- **Package**: https://anaconda.org/channels/bioconda/packages/unitig-counter/overview
- **Validation**: PASS

### Original Help Text
```text
cdbg-ops dist: Calculate distance between two nodes
cdbg-ops extend: Extend sequence around a node by finding paths through it

Graph options:
  --graph arg            Prefix of graph files
  --nodes arg            Name of .node file
  --edges arg            Name of .edges.dbg file

Distance options:
  --source arg           Sequence of source node
  --source-list arg      File containing sequences of source nodes
  --target arg           Sequence of target node
  --all                  Generate distances to all other unitigs

Extending options:
  --unitigs arg          File containing unitigs to extend
  --length arg (=100)    Maximum extension length
  --repeats              Allow loops in extensions

Other options:
  --mode arg             Mode of operation
  --version              prints version and exits
  -h [ --help ]          full help message
```

## unitig-counter_cdbg-ops_extend

### Tool Description
Extend sequence around a node by finding paths through it.

### Metadata
- **Docker Image**: quay.io/biocontainers/unitig-counter:1.1.0--h5ca1c30_2
- **Homepage**: https://github.com/johnlees/unitig-counter
- **Package**: https://anaconda.org/channels/bioconda/packages/unitig-counter/overview
- **Validation**: PASS

### Original Help Text
```text
cdbg-ops dist: Calculate distance between two nodes
cdbg-ops extend: Extend sequence around a node by finding paths through it

Graph options:
  --graph arg            Prefix of graph files
  --nodes arg            Name of .node file
  --edges arg            Name of .edges.dbg file

Distance options:
  --source arg           Sequence of source node
  --source-list arg      File containing sequences of source nodes
  --target arg           Sequence of target node
  --all                  Generate distances to all other unitigs

Extending options:
  --unitigs arg          File containing unitigs to extend
  --length arg (=100)    Maximum extension length
  --repeats              Allow loops in extensions

Other options:
  --mode arg             Mode of operation
  --version              prints version and exits
  -h [ --help ]          full help message
```

