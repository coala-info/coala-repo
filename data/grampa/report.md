# grampa CWL Generation Report

## grampa

### Tool Description
GRAMPA: Gene-tree Reconciliation Algorithm with MUL-trees for Polyploid Analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/grampa:1.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/gwct/grampa
- **Package**: https://anaconda.org/channels/bioconda/packages/grampa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/grampa/overview
- **Total Downloads**: 6.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gwct/grampa
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/grampa --help

usage: grampa [-h] [-s SPEC_TREE] [-g GENE_INPUT] [-h1 H1_SPEC] [-h2 H2_SPEC]
              [-c GROUP_CAP] [-o OUTPUT_DIR] [-f OUTPUT_PREFIX] [-p PROCESSES]
              [-v VERBOSITY] [--multree] [--labeltree] [--buildmultrees]
              [--numtrees] [--checknums] [--no-st] [--st-only] [--maps]
              [--info] [--overwrite] [--appendlog] [--tests [{bioconda}]]

GRAMPA: Gene-tree Reconciliation Algorithm with MUL-trees for Polyploid
Analysis.

options:
  -h, --help            show this help message and exit
  -s SPEC_TREE          A file or string containing a ROOTED, bifurcating,
                        newick formatted species tree in newick format on
                        which to search for polyploid events.
  -g GENE_INPUT         A file containing one or more ROOTED, bifurcating (no
                        polytomies), newick formatted gene trees to reconcile.
                        The labels in the gene tree MUST end with '_[species
                        name]' and contain no other underscores. Also accepts
                        a single tree string.
  -h1 H1_SPEC           A space separated list of species labels or internal
                        nodes that define the polyploid clade. Example: 'x,y,z
                        y,z' or '2 4'
  -h2 H2_SPEC           A space separated list of species labels or internal
                        node labels that make up the clade that you wish to
                        place the second polyploid clade sister to. Example:
                        'c'
  -c GROUP_CAP          The maxmimum number of groups to consider for any gene
                        tree. Default: 8. Max value: 18.
  -o OUTPUT_DIR         Output directory name. Default: grampa-[current
                        date]-[current time]
  -f OUTPUT_PREFIX      A prefix to add to the beginning of all output files
                        created. Default: grampa
  -p PROCESSES          The number of processes GRAMPA should use. Default: 1.
  -v VERBOSITY          An option to control the amount of output printed to
                        the screen. 0: print nothing. 1: print only some info
                        at the start. 2: print all log info to screen. 3
                        (default): print all log info to the screen as well as
                        progress updates for certain steps.
  --multree             Set this option if your input species tree is a MUL-
                        tree
  --labeltree           If this flag is set, the program will read your
                        species tree and simply print it out with the internal
                        nodes labeled.
  --buildmultrees       Use this along with -s and possibly -h1 and -h2 to
                        simply build MUL-trees from those options.
  --numtrees            Use this along with -s and possibly -h1 and -h2 to
                        simply count the number of MUL-trees from those
                        options.
  --checknums           Use this flag in conjunction with all other options to
                        check the number of nodes, groups, and combinations
                        for each gene tree and MUL-tree. In general, gene
                        trees with more than 15 groups to map take a very long
                        time to reconcile.
  --no-st               Set this to only perform reconciliations to the input
                        MUL-trees and NOT the singly-labeled tree.
  --st-only             Set this to only perform reconciliations to the
                        singly-labeled tree.
  --maps                Output the maps for each reconciliation in the
                        detailed output file.
  --info                Print some meta information about the program and
                        exit. No other options required.
  --overwrite           Set this to overwrite existing files.
  --appendlog           Set this to keep the old log file even if --overwrite
                        is specified. New log information will instead be
                        appended to the previous log file.
  --tests [{bioconda}]  Use 'grampa.py --tests' the first time you run grampa
                        to run through all the options with pre-set input
                        files.
```

