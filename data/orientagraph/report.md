# orientagraph CWL Generation Report

## orientagraph

### Tool Description
OrientAGraph is built from TreeMix v1.13 Revision 231 by J.K. Pickrell and J.K. Pritchard and has several new features, including the option to run Maximum Likelihood Network Orientation (MLNO) as part of the admixture graph search heuristic.

### Metadata
- **Docker Image**: quay.io/biocontainers/orientagraph:1.1--h3b735ea_0
- **Homepage**: https://github.com/sriramlab/OrientAGraph
- **Package**: https://anaconda.org/channels/bioconda/packages/orientagraph/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/orientagraph/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sriramlab/OrientAGraph
- **Stars**: N/A
### Original Help Text
```text
OrientAGraph 1.0

OrientAGraph is built from TreeMix v1.13 Revision 231
by J.K. Pickrell and J.K. Pritchard and has several new
features, including the option to run Maximum Likelihood
Network Orientation (MLNO) as part of the admixture graph
search heuristic.

Contact: Erin Molloy (ekmolloy@cs.ucla.edu)

COMMAND:  orientagraph --help

TreeMix Options:
-h display this help
-i [file name] input file
-o [stem] output stem (will be [stem].treeout.gz, [stem].cov.gz, [stem].modelcov.gz)
-k [int] number of SNPs per block for estimation of covariance matrix (1)
-global Do a round of global rearrangements after adding all populations
-tf [file name] Read the tree topology from a file, rather than estimating it
-m [int] number of migration edges to add (0)
-root [string] comma-delimited list of populations to set on one side of the root (for migration)
-g [vertices file name] [edges file name] read the graph from a previous TreeMix run
-se Calculate standard errors of migration weights (computationally expensive)
-micro microsatellite data
-bootstrap Perform a single bootstrap replicate
-cor_mig [file] list of known migration events to include (also use -climb)
-noss Turn off sample size correction
-seed [int] Set the seed for random number generation
-n_warn [int] Display first N warnings

Options for OrientAGraph:
-mlno Run maximum likelihood network orientation (MLNO) as part of search
-allmigs Evaluate all legal ways to add migration edge to base tree as part of search
-popaddorder [file of population names] Order to add populations when building starting tree
-freq2stat Estimate covariances or f2-statistics from allele frequencies and then exit;
    the resulting files can be given as input using the -givenmat option
-givenmat [se matrix file] Allows user to input matrix (e.g. [stem].cov.gz) with the -i flag,
    the file after this option should contain the standard error (e.g. [stem].covse.gz);
    if no file is provided after this option, then 0.0001 is used as the standard error.
-refit Allows user to (re)fit model parameters on starting tree (-tf) or graph (-g)
-score [1, 2, 3, 4] Score input tree (-tf) or graph (-g)
    (1) without refitting, (2) with refitting,
    (3) evaluating each base tree and returning the best,
    (4) evaluating each network orientation and returning the best
```

