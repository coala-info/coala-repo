# linearfold CWL Generation Report

## linearfold

### Tool Description
Predict RNA secondary structure using the LinearFold algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/linearfold:1.0.1.dev20220829--h9948957_2
- **Homepage**: https://github.com/LinearFold/LinearFold
- **Package**: https://anaconda.org/channels/bioconda/packages/linearfold/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/linearfold/overview
- **Total Downloads**: 11.8K
- **Last updated**: 2025-10-02
- **GitHub**: https://github.com/LinearFold/LinearFold
- **Stars**: N/A
### Original Help Text
```text
USAGE: echo SEQUENCE | /usr/local/bin/linearfold [flags]
       or
       echo FASTA_FILE | /usr/local/bin/linearfold [flags]

flags:
  -V,--[no]Vienna: use vienna parameters
    (default: 'false')
  -b,--beamsize: set beam size
    (default: '100')	    (an integer)
  --[no]constraints: print out energy of a given structure
    (default: 'false')
  -d,--dangles: the way to treat `dangling end' energies for bases adjacent to
    helices in free ends and multi-loops (only supporting `0' or `2',
    default=`2')
    (default: '2')	    (an integer)
  --delta: compute Zuker suboptimal structures with scores or energies(-V,
    kcal/mol) in a centain range of the optimum
    (default: '5.0')	    (a number)
  --[no]eval: print out energy of a given structure
    (default: 'false')
  --[no]fasta: input is in fasta format
    (default: 'false')
  --shape: specify a file name that contains SHAPE reactivity data (DEFAULT: not
    use SHAPE data)
    (default: '')
  --[no]sharpturn: enable sharp turn in prediction
    (default: 'false')
  -v,--[no]verbose: print out energy of each loop in the structure
    (default: 'false')
  --[no]zuker: output Zuker suboptimal structures
    (default: 'false')
```

