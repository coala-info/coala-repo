# pybdei CWL Generation Report

## pybdei_bdei_infer

### Tool Description
BDEI model parameter inference from phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/pybdei:0.13--py310hef477bb_1
- **Homepage**: https://github.com/evolbioinfo/bdei
- **Package**: https://anaconda.org/channels/bioconda/packages/pybdei/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pybdei/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-08-14
- **GitHub**: https://github.com/evolbioinfo/bdei
- **Stars**: N/A
### Original Help Text
```text
usage: bdei_infer [-h] --nwk NWK [-u U] [--mu MU] [--la LA] [--psi PSI] [-p P]
                  [--start START START START START]
                  [--upper_bounds UPPER_BOUNDS UPPER_BOUNDS UPPER_BOUNDS UPPER_BOUNDS]
                  [--pi_E PI_E] [--T T] [--u_policy {min,median,mean,max}]
                  [-c CI_REPETITIONS] [--log LOG] [--time_log TIME_LOG]
                  [-t THREADS] [--log_level LOG_LEVEL] [-v]

BDEI model parameter inference from phylogenetic trees.

options:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads for parallelization.
  --log_level LOG_LEVEL
                        level of logging information (the lower, the less
                        information will be printed to the output). Possible
                        levels are: 0 (errors only), 1 (errors+warnings), 2
                        (errors+warnings+info), 3
                        (errors+warnings+info+debug).
  -v, --version         show program's version number and exit

tree-related arguments:
  --nwk NWK             Input tree(s) in newick format (must be rooted).
  -u U, --u U           Number of unobserved trees. By default (-1) is
                        estimated.

parameter-related arguments:
  --mu MU               Value to fix BDEI becoming-infectious rate mu. If not
                        given, will be estimated.
  --la LA               Value to fix BDEI transmission rate lambda. If not
                        given, will be estimated.
  --psi PSI             Value to fix BDEI removal rate psi. If not given, will
                        be estimated.
  -p P, --p P           Value to fix BDEI sampling probability. If not given,
                        will be estimated.
  --start START START START START
                        Starting values for parameter optimisation, should be
                        4 values in the following order: mu, lambda, psi, p.
                        If not given, will be estimated.
  --upper_bounds UPPER_BOUNDS UPPER_BOUNDS UPPER_BOUNDS UPPER_BOUNDS
                        Upper bound on parameter values for parameter
                        optimisation, should be in the following order: mu,
                        lambda, psi, p. If not given, will be estimated.
  --pi_E PI_E           Frequency of E at time 0, should be between 0 and 1.
                        If not given, will be estimated from the model
                        parameters.
  --T T                 Total time between the tree roots and the end of the
                        sampling period. If a positive value is given, the
                        total time will be set to the maximum between this
                        value and the maximal time between the start and the
                        last sampled tip of all the trees. If a zero or
                        negative value is given, the time will be tree-
                        specific and estimated as the time between the root
                        and the last sampled tip for each tree. In the latter
                        case, one can additionally annotate each tree root
                        with a feature 'T' (e.g. '(a:2,b:3):1[&&NHX:T=5];' is
                        a tree with two tips, a and b, and the tree-specific
                        time annotated to 5): then the tree-specific time will
                        be set to the maximum between the annotated value and
                        the time between the root and the last sampled tip of
                        this tree.
  --u_policy {min,median,mean,max}
                        How to estimate the time for unobserved trees in case
                        of tree-specific observed tree times. By default, the
                        mean of tree-specific observed times is taken.

output-related arguments:
  -c CI_REPETITIONS, --CI_repetitions CI_REPETITIONS
                        Number of repetitions for CI calculation (the higher,
                        the more precise but also longer; a typical value is
                        100). If not specified, CIs will not be calculated.
  --log LOG             Path to the output file where to write the estimates.
                        If not given, the estimates will only be printed in
                        the stdout
  --time_log TIME_LOG   Path to the output file where to write the time. If
                        not given, the time will only be printed in the stdout
```

