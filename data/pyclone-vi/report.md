# pyclone-vi CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pyclone-vi_fit | PASS |  |
| pyclone-vi_write-results-file | PASS |  |

## pyclone-vi_fit

### Tool Description
Fit PyClone-VI model to data.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyclone-vi:0.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/Roth-Lab/pyclone-vi
- **Package**: https://anaconda.org/channels/bioconda/packages/pyclone-vi/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyclone-vi fit [OPTIONS]

  Fit PyClone-VI model to data.

Options:
  -i, --in-file FILE              Path to TSV format file with copy number and
                                  allele count information for all samples.
                                  See the examples directory in the GitHub
                                  repository for format.  [required]
  -o, --out-file FILE             Path to where results will be written in
                                  HDF5 format.  [required]
  -c, --num-clusters INTEGER RANGE
                                  Number of clusters to use in variational
                                  approximation distribution. Note that not
                                  all clusters may not be assigned data
                                  points, so the final number of clusters
                                  could be lower.  [default: 10; x>=2]
  -d, --density [beta-binomial|binomial]
                                  Allele count density in the PyClone model.
                                  Use beta-binomial for high coverage
                                  sequencing.  [default: binomial]
  -g, --num-grid-points INTEGER RANGE
                                  Number of points used to approximate CCF
                                  values.  [default: 100; x>=10]
  -r, --num-restarts INTEGER RANGE
                                  Number of random restarts of variational
                                  inference.  [default: 1; x>=1]
  -t, --num-threads INTEGER RANGE
                                  Number of threads to use.  [default: 1;
                                  x>=1]
  --convergence-threshold FLOAT   Maximum relative ELBO difference between
                                  iterations to decide on convergence.
                                  [default: 1e-06]
  --max-iters INTEGER RANGE       Maximum number of ELBO optimization
                                  iterations.  [default: 10000; x>=1]
  --mix-weight-prior FLOAT        Parameter value of symmetric Dirichlet prior
                                  distribution on mixture weights.  Higher
                                  values will produce more clusters. Default
                                  is 1.0 which is the uniform prior.
                                  [default: 1.0]
  --precision FLOAT               Precision for Beta-Binomial density. Has no
                                  effect when using Binomial.  [default: 200]
  --print-freq INTEGER RANGE      How often to print information about
                                  optimization. Default is every 100
                                  iterations.  [default: 100; x>=1]
  --seed INTEGER                  Set random seed so results can be
                                  reproduced. By default, a random seed is
                                  chosen.
  --help                          Show this message and exit.
```

## pyclone-vi_write-results-file

### Tool Description
Write the results of a fitted model to file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyclone-vi:0.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/Roth-Lab/pyclone-vi
- **Package**: https://anaconda.org/channels/bioconda/packages/pyclone-vi/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyclone-vi write-results-file [OPTIONS]

  Write the results of a fitted model to file.

Options:
  -i, --in-file FILE   Path to HDF5 format file produced by the `fit` command.
                       [required]
  -o, --out-file FILE  Path to where results will be written in tsv format.
                       [required]
  -c, --compress       If the output file should be compressed using gzip.
  --help               Show this message and exit.
```

