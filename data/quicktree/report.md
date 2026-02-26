# quicktree CWL Generation Report

## quicktree

### Tool Description
Constructs a phylogenetic tree from a distance matrix or an alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/quicktree:2.5--h7b50bb2_9
- **Homepage**: https://github.com/khowe/quicktree
- **Package**: https://anaconda.org/channels/bioconda/packages/quicktree/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/quicktree/overview
- **Total Downloads**: 27.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/khowe/quicktree
- **Stars**: N/A
### Original Help Text
```text
A Fatal Error occurred: Fatal error: Incorrect number of arguments.
Usage: quicktree [-options] <inputfile>
Options:
-in <m|a>        : input file is a distance matrix in phylip format (m)
                   or an alignment in stockholm format* (a, default)
-out <m|t>       : output is a distance matrix in phylip format (m) or
                   a tree in New Hampshire format

Advanced options :
-upgma           : Use the UPGMA method to construct the tree
                     (ignored for distance matrix outputs)
-kimura          : Use the kimura translation for pairwise distances
                     (ignored for distance matrix inputs)
-boot <n>        : Calcuate bootstrap values with n iterations
                     (ignored for distance matrix outputs)
-v               : print version and exit

*Use sreformat, part of the HMMer package to convert your alignment to Stockholm format
```

