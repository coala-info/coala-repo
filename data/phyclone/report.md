# phyclone CWL Generation Report

## phyclone_consensus

### Tool Description
Build consensus results.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyclone:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/Roth-Lab/PhyClone
- **Package**: https://anaconda.org/channels/bioconda/packages/phyclone/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phyclone/overview
- **Total Downloads**: 674
- **Last updated**: 2026-01-23
- **GitHub**: https://github.com/Roth-Lab/PhyClone
- **Stars**: N/A
### Original Help Text
```text
Usage: phyclone consensus [OPTIONS]

  Build consensus results.

Options:
  -i, --in-file FILE              Path to trace file from MCMC analysis.
                                  Format is HDF5.  [required]
  -o, --out-table-file FILE       [required]
  -t, --out-tree-file FILE        Path to where tree will be written in
                                  minimal newick format.  [required]
  -s, --out-sample-prev-table FILE
                                  Path to where sample prevalence table will
                                  be written in .tsv format.
  --consensus-threshold FLOAT RANGE
                                  Consensus threshold to keep an SNV.
                                  [default: 0.5; 0.0<=x<=1.0]
  -w, --weight-type [counts|joint-likelihood]
                                  Which measure to use as the consensus tree
                                  weights. Counts is the same as an unweighted
                                  consensus.  [default: joint-likelihood]
  --help                          Show this message and exit.
```


## phyclone_map

### Tool Description
Build MAP results.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyclone:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/Roth-Lab/PhyClone
- **Package**: https://anaconda.org/channels/bioconda/packages/phyclone/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phyclone map [OPTIONS]

  Build MAP results.

Options:
  -i, --in-file FILE              Path to trace file from MCMC analysis.
                                  Format is HDF5.  [required]
  -o, --out-table-file FILE       [required]
  -t, --out-tree-file FILE        Path to where tree will be written in
                                  minimal newick format.  [required]
  -s, --out-sample-prev-table FILE
                                  Path to where sample prevalence table will
                                  be written in .tsv format.
  --map-type [joint-likelihood|frequency]
                                  Which measure to use as for MAP computation.
                                  [default: joint-likelihood]
  --help                          Show this message and exit.
```


## phyclone_run

### Tool Description
Run a new PhyClone analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyclone:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/Roth-Lab/PhyClone
- **Package**: https://anaconda.org/channels/bioconda/packages/phyclone/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phyclone run [OPTIONS]

  Run a new PhyClone analysis.

Options:
  -i, --in-file FILE              Path to TSV format file with copy number and
                                  allele count information for all samples.
                                  See the examples directory in the GitHub
                                  repository for format.  [required]
  -o, --out-file FILE             Path to where trace file will be written in
                                  HDF5 format.  [required]
  -b, --burnin INTEGER RANGE      Number of burn-in iterations using
                                  unconditional SMC sampler.  [default: 1000;
                                  x>=1]
  -n, --num-iters INTEGER RANGE   Number of iterations of the MCMC sampler to
                                  perform.  [default: 10000; x>=1]
  --thin INTEGER RANGE            Thinning parameter for storing entries in
                                  trace.  [default: 1; x>=1]
  --num-chains INTEGER RANGE      Number of parallel chains for sampling.
                                  Recommended to use at least 4.  [default: 1;
                                  x>=1]
  -c, --cluster-file FILE         Path to file with pre-computed cluster
                                  assignments of mutations.
  -d, --density [binomial|beta-binomial]
                                  Allele count density in the PyClone model.
                                  Use beta-binomial for most cases.  [default:
                                  beta-binomial]
  -l, --outlier-prob FLOAT RANGE  Prior probability that data points are
                                  outliers and don't fit tree.  [default: 0;
                                  0.0<=x<=1.0]
  -p, --proposal [bootstrap|fully-adapted|semi-adapted]
                                  Proposal distribution to use for PG
                                  sampling. Fully adapted is the most
                                  computationally expensive but also likely to
                                  lead to the best performance per iteration.
                                  For large datasets it may be necessary to
                                  use one of the other proposals.  [default:
                                  semi-adapted]
  -t, --max-time FLOAT            Maximum running time in seconds.  [default:
                                  inf]
  --concentration-update / --no-concentration-update
                                  Whether the concentration parameter should
                                  be updated during sampling.  [default:
                                  concentration-update]
  --concentration-value FLOAT     The (initial) concentration of the Dirichlet
                                  process. Higher values will encourage more
                                  clusters,  lower values have the opposite
                                  effect.  [default: 1.0]
  --grid-size INTEGER RANGE       Grid size for discrete approximation. This
                                  will numerically marginalise the cancer cell
                                  fraction.  Higher values lead to more
                                  accurate approximations at the expense of
                                  run time.  [default: 101; x>=11]
  --num-particles INTEGER RANGE   Number of particles to use during PG
                                  sampling.  [default: 100; x>=1]
  --num-samples-data-point INTEGER RANGE
                                  Number of Gibbs updates to reassign data
                                  points per SMC iteration.  [default: 1;
                                  x>=0]
  --num-samples-prune-regraph INTEGER RANGE
                                  Number of prune-regraph updates per SMC
                                  iteration.  [default: 1; x>=0]
  -s, --subtree-update-prob FLOAT RANGE
                                  Probability of updating a subtree (instead
                                  of whole tree) using PG sampler.  [default:
                                  0.0; 0.0<=x<=1.0]
  --precision FLOAT               The (initial) precision parameter of the
                                  Beta-Binomial density.  The higher the value
                                  the more similar the Beta-Binomial is to a
                                  Binomial.  [default: 400]
  --print-freq INTEGER RANGE      How frequently to print information about
                                  fitting.  [default: 100; x>=1]
  --resample-threshold FLOAT RANGE
                                  ESS threshold to trigger resampling.
                                  [default: 0.5; 0.0<=x<=1.0]
  --seed INTEGER                  Set random seed so results can be
                                  reproduced. By default, a random seed is
                                  chosen.
  --assign-loss-prob / --no-assign-loss-prob
                                  Whether to assign loss probability prior
                                  from the cluster data. Note: This option is
                                  incompatible with --user-provided-loss-prob
                                  [default: no-assign-loss-prob]
  --user-provided-loss-prob / --no-user-provided-loss-prob
                                  Whether to use user-provided cluster loss
                                  probability prior from the cluster file.
                                  Requires that the 'outlier_prob' column be
                                  present and populated in the cluster file.
                                  Note: This option is incompatible with
                                  --assign-loss-prob  [default: no-user-
                                  provided-loss-prob]
  --high-loss-prob FLOAT RANGE    Higher loss probability setting.  Used when
                                  allowing PhyClone to assign loss prior
                                  probability from cluster data.  [default:
                                  0.4; 0.0002<=x<=1.0]
  --help                          Show this message and exit.
```


## phyclone_topology-report

### Tool Description
Build topology report.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyclone:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/Roth-Lab/PhyClone
- **Package**: https://anaconda.org/channels/bioconda/packages/phyclone/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phyclone topology-report [OPTIONS]

  Build topology report.

Options:
  -i, --in-file FILE             Path to trace file from MCMC analysis. Format
                                 is HDF5.  [required]
  -o, --out-file FILE            Path/filename to where topology report will
                                 be written in .tsv format  [required]
  -t, --topologies-archive FILE  To produce the results tables and newick
                                 trees for each uniquely sampled topology in
                                 the report, provide a path to where the
                                 archive file will be written in tar.gz
                                 compressed format.
  --top-trees INTEGER RANGE      Number of uniquely sampled topologies to
                                 archive. Default is to produce an archive of
                                 all unique  topologies.  [x>=1]
  --help                         Show this message and exit.
```


## Metadata
- **Skill**: generated
