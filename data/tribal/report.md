# tribal CWL Generation Report

## tribal_preprocess

### Tool Description
Preprocesses sequencing data for tribal analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/tribal:0.1.1--py310hdbdd923_1
- **Homepage**: https://github.com/elkebir-group/TRIBAL
- **Package**: https://anaconda.org/channels/bioconda/packages/tribal/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tribal/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/elkebir-group/TRIBAL
- **Stars**: N/A
### Original Help Text
```text
usage: tribal preprocess [-h] -d DATA -r ROOTS -e ENCODING
                         [--min-size MIN_SIZE] [--dataframe DATAFRAME] -o OUT
                         [-j CORES] [--heavy] [-v]

options:
  -h, --help            show this help message and exit
  -d DATA, --data DATA  filename of csv file with the sequencing data
  -r ROOTS, --roots ROOTS
                        filename of csv file with the root sequences
  -e ENCODING, --encoding ENCODING
                        filename isotype encodings
  --min-size MIN_SIZE   minimum clonotype size (default 4)
  --dataframe DATAFRAME
                        path to where the filtered dataframe with additional
                        sequences and isotype encodings should be saved.
  -o OUT, --out OUT     path to where pickled clonotype dictionary input
                        should be saved
  -j CORES, --cores CORES
                        number of cores to use (default 1)
  --heavy               only use the heavy chain and ignore the light chain
  -v, --verbose         print additional messages
```


## tribal_fit

### Tool Description
Fit B cell lineage trees

### Metadata
- **Docker Image**: quay.io/biocontainers/tribal:0.1.1--py310hdbdd923_1
- **Homepage**: https://github.com/elkebir-group/TRIBAL
- **Package**: https://anaconda.org/channels/bioconda/packages/tribal/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tribal fit [-h] -c CLONOTYPES --n_isotypes N_ISOTYPES
                  [--stay-prob STAY_PROB] [-t TRANSMAT] [--niter NITER]
                  [--thresh THRESH] [-j CORES] [--max-cand MAX_CAND] [-s SEED]
                  [--restarts RESTARTS] [--mode {score,refinement}]
                  [--score SCORE] [--transmat-infer TRANSMAT_INFER]
                  [--verbose] [--pickle PICKLE]
                  [--write-results WRITE_RESULTS]

options:
  -h, --help            show this help message and exit
  -c CLONOTYPES, --clonotypes CLONOTYPES
                        path to pickled clonotypes dictionary of parsimony
                        forests, alignments, and isotypes
  --n_isotypes N_ISOTYPES
                        the number of isotypes states to use
  --stay-prob STAY_PROB
                        the lower and upper bound of not class switching,
                        example: 0.55,0.95
  -t TRANSMAT, --transmat TRANSMAT
                        optional filename of isotype transition probabilities
  --niter NITER         max number of iterations during fitting
  --thresh THRESH       theshold for convergence in during fitting
  -j CORES, --cores CORES
                        number of cores to use
  --max-cand MAX_CAND   max candidate tree size per clonotype
  -s SEED, --seed SEED  random number seed
  --restarts RESTARTS   number of restarts
  --mode {score,refinement}
                        mode for fitting B cell lineage trees, one of
                        'refinment' or 'score'
  --score SCORE         filename where the objective values file should be
                        saved
  --transmat-infer TRANSMAT_INFER
                        filename where the inferred transition matrix should
                        be saved
  --verbose             print additional messages.
  --pickle PICKLE       path where the output dictionary of LineageTree lists
                        should be pickled
  --write-results WRITE_RESULTS
                        path where all optimal solution results are saved
```

