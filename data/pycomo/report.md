# pycomo CWL Generation Report

## pycomo

### Tool Description
Combine single species/strain models into a community model.

### Metadata
- **Docker Image**: quay.io/biocontainers/pycomo:0.2.9--pyhdfd78af_0
- **Homepage**: https://github.com/univieCUBE/PyCoMo
- **Package**: https://anaconda.org/channels/bioconda/packages/pycomo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pycomo/overview
- **Total Downloads**: 5.4K
- **Last updated**: 2025-11-24
- **GitHub**: https://github.com/univieCUBE/PyCoMo
- **Stars**: N/A
### Original Help Text
```text
2026-02-24 23:05:20,122 - PyCoMo - INFO - Logger initialized.
usage: PyCoMo [-h] [-v] -i INPUT [INPUT ...] [-c] [-n NAME]
              [-m MATCH_VIA_ANNOTATION] [--growth-rate GROWTH_RATE |
              --equal-abd | --abd-file ABD_FILE] [--medium MEDIUM]
              [--num-cores NUM_CORES] [-o OUTPUT_DIR] [--save-sbml]
              [--fba-flux] [--fva-flux [FVA_FLUX]] [--fba-interaction]
              [--fva-interaction] [--composition-agnostic]
              [--loopless LOOPLESS] [--precompute-loops PRECOMPUTE_LOOPS]
              [--fraction-of-optimum FRACTION_OF_OPTIMUM] [--max-growth-rate]
              [--log-file [LOG_FILE]] [--log-level LOG_LEVEL]

options:
  -h, --help            show this help message and exit
  -v, --version         display PyCoMo version
  -i, --input INPUT [INPUT ...]
                        single species/strain models to combine, either as a
                        directory or separate files
  -c, --is-community    Set this flag if the input model is already a
                        community model.

Community model parameters:
  -n, --name NAME       the name for the new community model
  -m, --match-via-annotation MATCH_VIA_ANNOTATION
                        the metabolite annotation type to use for matching
                        exchange metabolites of different community members
                        (e.g. metanetx.chemical)
  --growth-rate GROWTH_RATE
                        set a fixed growth-rate for the community
  --equal-abd           set abundances to be equal for all community members
  --abd-file ABD_FILE   a comma separated file containing the input model file
                        names and their abundance. No header should be used in
                        the file.
  --medium MEDIUM       the medium to be used in the community model, as a
                        comma separated file containing a column 'compounds'
                        and a column 'maxFlux'.
  --num-cores NUM_CORES
                        the number of cores to be used for FVA

Output parameters:
  -o, --output-dir OUTPUT_DIR
                        the output directory to store results (default is the
                        current working directory)
  --save-sbml           save the community metabolic model as sbml file
  --fba-flux            run FBA on the community model and store the flux
                        vector in a file
  --fva-flux [FVA_FLUX]
                        run FVA on the exchange metabolites of the community
                        model and store the flux vector in a file.
  --fba-interaction     run FBA on the community model and store the flux of
                        exchange metabolites and whether they are cross-fed in
                        a file
  --fva-interaction     run FVA on the community model and store the flux of
                        exchange metabolites and whether they are cross-fed in
                        a file. Set the threshold of the objective that needs
                        to be achieved.
  --composition-agnostic
                        run FVA with relaxed constraints, to calculate all
                        possible cross-feeding interactions across all
                        community growth-rates and abundance profiles.
  --loopless LOOPLESS   run FVA with loop correction (on by default)
  --precompute-loops PRECOMPUTE_LOOPS
                        precompute loop reactions for loopless FVA. Reduces
                        runtime for communities of <10 member, and can lead to
                        numerical issues with GLP solver on larger communities
                        (off by default)
  --fraction-of-optimum FRACTION_OF_OPTIMUM
                        set the fraction of optimum that needs to be achieved.
                        Values need to be between 0 and 1. Examples: 0 -> 0%
                        of optimum, 0.9 -> 90% of optimum, 1 -> 100% of
                        optimum.
  --max-growth-rate     calculate the maximum growth-rate of the community, as
                        well as the community composition reaching it. Results
                        are stored in a csv file.
  --log-file [LOG_FILE]
                        set a log file for PyCoMo, located in the output
                        directory (see -o / --output-dir. If used as flag, the
                        file is called 'pycomo.log'.
  --log-level LOG_LEVEL
                        set log level. Use one of the following values: error,
                        warning, info, debug
```

