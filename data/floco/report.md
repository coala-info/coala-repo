# floco CWL Generation Report

## floco

### Tool Description
Calculate copy numbers from graph and alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/floco:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/hugocarmaga/floco
- **Package**: https://anaconda.org/channels/bioconda/packages/floco/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/floco/overview
- **Total Downloads**: 57
- **Last updated**: 2026-02-20
- **GitHub**: https://github.com/hugocarmaga/floco
- **Stars**: N/A
### Original Help Text
```text
usage: floco -g GRAPH [-a ALIGNMENT] -o OUTPUT [-p BG_PLOIDY [BG_PLOIDY ...]]
             [-S EXPEN_PEN] [-s CHEAP_PEN] [-e EPSILON] [-b BIN_SIZE]
             [-c COMPLEXITY] [-d PICKLE] [-t THREADS] [--debug] [-h] [-V]

options:
  -g, --graph GRAPH     The GFA file with the graph.
  -a, --alignment ALIGNMENT
                        The GAF file with sequence-to-graph alignments.
  -o, --output OUTPUT   The name for the output csv file with the copy
                        numbers.
  -p, --bg-ploidy BG_PLOIDY [BG_PLOIDY ...]
                        Expected most common CN value in the graph (background
                        ploidy of the dataset). (default:[1, 2])
  -S, --expen-pen EXPEN_PEN
                        Probability for using the super edges when there are
                        other edges available. (default:-10000)
  -s, --cheap-pen CHEAP_PEN
                        Probability for using the super edges when there is no
                        other edge available. (default:-25)
  -e, --epsilon EPSILON
                        Epsilon value for adjusting CN0 counts to
                        probabilities (default:0.02)
  -b, --bin-size BIN_SIZE
                        Set the bin size to use for the NB parameters
                        estimation. (default:100)
  -c, --complexity COMPLEXITY
                        Model complexity (1-3): larger = slower and more
                        accurate. (default: 2)
  -d, --pickle PICKLE   Pickle dump with the data. Dump file can be produced
                        with '--debug'.
  -t, --threads THREADS
                        Number of computing threads to use by the ILP solver.
  --debug               Produce additional files.
  -h, --help            Show this help message and exit.
  -V, --version         Show program's version number and exit.
```

