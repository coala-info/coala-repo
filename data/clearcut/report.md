# clearcut CWL Generation Report

## clearcut

### Tool Description
Compute tree by supplying distance matrix via stdin

### Metadata
- **Docker Image**: biocontainers/clearcut:v1.0.9-3-deb_cv1
- **Homepage**: https://github.com/DavidJBianco/Clearcut
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clearcut/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-11-14
- **GitHub**: https://github.com/DavidJBianco/Clearcut
- **Stars**: N/A
### Original Help Text
```text
Usage: clearcut --in=<infilename> --out=<outfilename> [options]...
GENERAL OPTIONS:
  -h, --help         Display this information.
  -V, --version      Print the version of this program.
  -v, --verbose      More output. (Default: OFF)
  -q, --quiet        Silent operation. (Default: ON)
  -s, --seed=<seed>  Explicitly set the PRNG seed to a specific value.
  -r, --norandom     Attempt joins deterministically.  (Default: OFF)
  -S, --shuffle      Randomly shuffle the distance matrix.  (Default: OFF)
  -N, --neighbor     Use traditional Neighbor-Joining algorithm. (Default: OFF)

INPUT OPTIONS:
  -I, --stdin        Read input from STDIN.
  -d, --distance     Input file is a distance matrix. (Default: ON)
  -a, --alignment    Input file is a set of aligned sequences. (Default: OFF)
  -D, --DNA          Input alignment are DNA sequences.
  -P, --protein      Input alignment are protein sequences.

CORRECTION MODEL FOR COMPUTING DISTANCE MATRIX (Default: NO Correction):
  -j, --jukes        Use Jukes-Cantor correction for computing distance matrix.
  -k, --kimura       Use Kimura correction for distance matrix.

OUTPUT OPTIONS:
  -O, --stdout           Output tree to STDOUT.
  -m, --matrixout=<file> Output distance matrix to specified file.
  -n, --ntrees=<n>       Output n trees.  (Default: 1)
  -e, --expblen          Exponential notation for branch lengths. (Default: OFF)
  -E, --expdist          Exponential notation in distance output. (Default: OFF)

EXAMPLES:
  Compute tree by supplying distance matrix via stdin:
  clearcut --distance < distances.txt > treefile.tre

  Compute tree by supplying an alignment of DNA sequences from a file:
  clearcut --alignment --DNA --in=alignment.txt --out=treefile.tre
```

