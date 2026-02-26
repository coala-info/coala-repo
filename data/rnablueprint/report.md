# rnablueprint CWL Generation Report

## rnablueprint_RNAblueprint

### Tool Description
Reads RNA secondary structures in dot-bracket notation as well as sequence constraints in IUPAC code and fairly samples RNA sequences compatible to both inputs

### Metadata
- **Docker Image**: quay.io/biocontainers/rnablueprint:1.3.3--py311pl5321h6accb3f_0
- **Homepage**: https://github.com/ViennaRNA/RNAblueprint
- **Package**: https://anaconda.org/channels/bioconda/packages/rnablueprint/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rnablueprint/overview
- **Total Downloads**: 36.7K
- **Last updated**: 2025-10-01
- **GitHub**: https://github.com/ViennaRNA/RNAblueprint
- **Stars**: N/A
### Original Help Text
```text
This program reads RNA secondary structures in dot-bracket notation as well as
sequence constraints in IUPAC code and fairly samples RNA sequences compatible
to both inputs:

Generic Options:
  -h [ --help ]                print help message
  -v [ --verbose ]             be verbose
  -d [ --debug ]               be verbose for debugging

Program options:
  -i [ --in ] arg              input file which contains the structures, 
                               sequence constraints and the start sequence 
                               [string]
                               structures: secondary structures in dot-bracket 
                                           notation. one structure per input 
                                           line
                               sequence constraints: Permanent sequence 
                                                     constraints in IUPAC 
                                                     notation [ACGTUWSMKRYBDHVN
                                                     ] (optional)
                               start sequence:  A initial RNA sequence to start
                                               the sampling from [ACGU] 
                                               (optional)
  -o [ --out ] arg             output file for writing the sequences (default: 
                               stdout) [string]
  -g [ --graphml ] arg         write a GraphML file representing the dependency
                               graph to the given filename (optional) [string]
  -m [ --mode ] arg (=sample)  mode for sequence generation [string]:
                               sample: stochastic sampling of all positions 
                                       (default)
                               sample-clocal: Only sample one connected 
                                              component at a time starting from
                                              an initial sequence
                               sample-plocal: Sample only single paths starting
                                              from an initial sequence
                               clocal-neighbors: Only find neighboring 
                                                 sequences to the initial start
                                                 sequence by sampling one 
                                                 connected component only
                               plocal-neighbors: Only find neighboring 
                                                 sequences to the initial start
                                                 sequence by sampling one path 
                                                 only
                               
  -s [ --seed ] arg            random number generator seed [unsigned long]
  -n [ --num ] arg (=10)       number of designs (default: 10) [unsigned int]
```

