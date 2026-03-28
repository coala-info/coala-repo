# probabilistic2020 CWL Generation Report

## probabilistic2020_oncogene

### Tool Description
Find statsitically significant oncogene-like genes. Evaluates clustering of missense mutations and high in silico pathogenicity scores for missense mutations.

### Metadata
- **Docker Image**: quay.io/biocontainers/probabilistic2020:1.2.3--py37h9c5868f_4
- **Homepage**: https://github.com/KarchinLab/probabilistic2020
- **Package**: https://anaconda.org/channels/bioconda/packages/probabilistic2020/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/probabilistic2020/overview
- **Total Downloads**: 7.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/KarchinLab/probabilistic2020
- **Stars**: N/A
### Original Help Text
```text
usage: probabilistic2020 oncogene [-h] -i INPUT -m MUTATIONS -b BED
                                  [-p PROCESSES] [-n NUM_ITERATIONS]
                                  [-sc STOP_CRITERIA] [-c CONTEXT]
                                  [-s SCORE_DIR] [-r RECURRENT] [-f FRACTION]
                                  [--unique] [-u] [-g GENOME] [-seed SEED] -o
                                  OUTPUT

Find statsitically significant oncogene-like genes. Evaluates clustering of
missense mutations and high in silico pathogenicity scores for missense
mutations.

optional arguments:
  -h, --help            show this help message and exit

Major options:
  -i INPUT, --input INPUT
                        gene FASTA file from extract_gene_seq.py script
  -m MUTATIONS, --mutations MUTATIONS
                        DNA mutations file (MAF file). Columns can be in any
                        order, but should contain the correct column header
                        names.
  -b BED, --bed BED     BED file annotation of genes
  -p PROCESSES, --processes PROCESSES
                        Number of processes to use for parallelization. 0
                        indicates using a single process without using a
                        multiprocessing pool (more means Faster, default: 0).
  -n NUM_ITERATIONS, --num-iterations NUM_ITERATIONS
                        Number of iterations for null model. p-value precision
                        increases with more iterations, however this will also
                        increase the run time (Default: 100,000).
  -c CONTEXT, --context CONTEXT
                        Number of DNA bases to use as context. 0 indicates no
                        context. 1 indicates only use the mutated base. 1.5
                        indicates using the base context used in CHASM (http:/
                        /wiki.chasmsoftware.org/index.php/CHASM_Overview). 2
                        indicates using the mutated base and the upstream
                        base. 3 indicates using the mutated base and both the
                        upstream and downstream bases. (Default: 1.5)
  -s SCORE_DIR, --score-dir SCORE_DIR
                        Directory containing VEST score information in pickle
                        files (Default: None).
  -o OUTPUT, --output OUTPUT
                        Output text file of probabilistic 20/20 results

Advanced options:
  -sc STOP_CRITERIA, --stop-criteria STOP_CRITERIA
                        Number of iterations more significant then the
                        observed statistic to stop further computations. This
                        decreases compute time spent in resolving p-values for
                        non-significant genes. (Default: 1000).
  -r RECURRENT, --recurrent RECURRENT
                        Minimum number of mutations at a position for it to be
                        considered a recurrently mutated position (Default:
                        3).
  -f FRACTION, --fraction FRACTION
                        Fraction of total mutations in a gene. This define the
                        minimumm number of mutations for a position to be
                        defined as recurrently mutated (Defaul: .02).
  --unique              Only keep unique mutations for each tumor sample.
                        Mutations reported from heterogeneous sources may
                        contain duplicates, e.g. a tumor sample was sequenced
                        twice.
  -u, --use-unmapped    Use mutations that are not mapped to the the single
                        reference transcript for a gene specified in the bed
                        file indicated by the -b option.
  -g GENOME, --genome GENOME
                        Path to the genome fasta file. Required if --use-
                        unmapped flag is used. (Default: None)
  -seed SEED, --seed SEED
                        Specify the seed for the pseudo random number
                        generator. By default, the seed is randomly chosen.
                        The seed will be used for the monte carlo simulations
                        (Default: 101).
```


## probabilistic2020_tsg

### Tool Description
Find statistically significant Tumor Suppressor-like genes. Evaluates for a higher proportion of inactivating mutations than expected.

### Metadata
- **Docker Image**: quay.io/biocontainers/probabilistic2020:1.2.3--py37h9c5868f_4
- **Homepage**: https://github.com/KarchinLab/probabilistic2020
- **Package**: https://anaconda.org/channels/bioconda/packages/probabilistic2020/overview
- **Validation**: PASS

### Original Help Text
```text
usage: probabilistic2020 tsg [-h] -i INPUT -m MUTATIONS -b BED [-p PROCESSES]
                             [-n NUM_ITERATIONS] [-sc STOP_CRITERIA]
                             [-c CONTEXT] [-d DELETERIOUS] [--unique] [-u]
                             [-g GENOME] [-seed SEED] -o OUTPUT

Find statistically significant Tumor Suppressor-like genes. Evaluates for a
higher proportion of inactivating mutations than expected.

optional arguments:
  -h, --help            show this help message and exit

Major options:
  -i INPUT, --input INPUT
                        gene FASTA file from extract_gene_seq.py script
  -m MUTATIONS, --mutations MUTATIONS
                        DNA mutations file (MAF file). Columns can be in any
                        order, but should contain the correct column header
                        names.
  -b BED, --bed BED     BED file annotation of genes
  -p PROCESSES, --processes PROCESSES
                        Number of processes to use for parallelization. 0
                        indicates using a single process without using a
                        multiprocessing pool (more means Faster, default: 0).
  -n NUM_ITERATIONS, --num-iterations NUM_ITERATIONS
                        Number of iterations for null model. p-value precision
                        increases with more iterations, however this will also
                        increase the run time (Default: 100,000).
  -c CONTEXT, --context CONTEXT
                        Number of DNA bases to use as context. 0 indicates no
                        context. 1 indicates only use the mutated base. 1.5
                        indicates using the base context used in CHASM (http:/
                        /wiki.chasmsoftware.org/index.php/CHASM_Overview). 2
                        indicates using the mutated base and the upstream
                        base. 3 indicates using the mutated base and both the
                        upstream and downstream bases. (Default: 1.5)
  -o OUTPUT, --output OUTPUT
                        Output text file of probabilistic 20/20 results

Advanced options:
  -sc STOP_CRITERIA, --stop-criteria STOP_CRITERIA
                        Number of iterations more significant then the
                        observed statistic to stop further computations. This
                        decreases compute time spent in resolving p-values for
                        non-significant genes. (Default: 1000).
  -d DELETERIOUS, --deleterious DELETERIOUS
                        Perform tsg randomization-based test if gene has at
                        least a user specified number of deleterious mutations
                        (default: 1)
  --unique              Only keep unique mutations for each tumor sample.
                        Mutations reported from heterogeneous sources may
                        contain duplicates, e.g. a tumor sample was sequenced
                        twice.
  -u, --use-unmapped    Use mutations that are not mapped to the the single
                        reference transcript for a gene specified in the bed
                        file indicated by the -b option.
  -g GENOME, --genome GENOME
                        Path to the genome fasta file. Required if --use-
                        unmapped flag is used. (Default: None)
  -seed SEED, --seed SEED
                        Specify the seed for the pseudo random number
                        generator. By default, the seed is randomly chosen.
                        The seed will be used for the monte carlo simulations
                        (Default: 101).
```


## probabilistic2020_hotmaps1d

### Tool Description
Find codons with significant clustering of missense mutations in sequence. Evaluates for a higher ammount of clustering of missense mutations.

### Metadata
- **Docker Image**: quay.io/biocontainers/probabilistic2020:1.2.3--py37h9c5868f_4
- **Homepage**: https://github.com/KarchinLab/probabilistic2020
- **Package**: https://anaconda.org/channels/bioconda/packages/probabilistic2020/overview
- **Validation**: PASS

### Original Help Text
```text
usage: probabilistic2020 hotmaps1d [-h] -i INPUT -m MUTATIONS -b BED
                                   [-p PROCESSES] [-n NUM_ITERATIONS]
                                   [-sc STOP_CRITERIA] [-c CONTEXT]
                                   [-w WINDOW] [-r] [-nd NULL_DISTR_DIR]
                                   [--unique] [-u] [-g GENOME] [-seed SEED] -o
                                   OUTPUT

Find codons with significant clustering of missense mutations in sequence.
Evaluates for a higher ammount of clustering of missense mutations.

optional arguments:
  -h, --help            show this help message and exit

Major options:
  -i INPUT, --input INPUT
                        gene FASTA file from extract_gene_seq.py script
  -m MUTATIONS, --mutations MUTATIONS
                        DNA mutations file (MAF file). Columns can be in any
                        order, but should contain the correct column header
                        names.
  -b BED, --bed BED     BED file annotation of genes
  -p PROCESSES, --processes PROCESSES
                        Number of processes to use for parallelization. 0
                        indicates using a single process without using a
                        multiprocessing pool (more means Faster, default: 0).
  -n NUM_ITERATIONS, --num-iterations NUM_ITERATIONS
                        Number of iterations for null model. p-value precision
                        increases with more iterations, however this will also
                        increase the run time (Default: 100,000).
  -c CONTEXT, --context CONTEXT
                        Number of DNA bases to use as context. 0 indicates no
                        context. 1 indicates only use the mutated base. 1.5
                        indicates using the base context used in CHASM (http:/
                        /wiki.chasmsoftware.org/index.php/CHASM_Overview). 2
                        indicates using the mutated base and the upstream
                        base. 3 indicates using the mutated base and both the
                        upstream and downstream bases. (Default: 1.5)
  -o OUTPUT, --output OUTPUT
                        Output text file of probabilistic 20/20 results

Advanced options:
  -sc STOP_CRITERIA, --stop-criteria STOP_CRITERIA
                        Number of iterations more significant then the
                        observed statistic to stop further computations. This
                        decreases compute time spent in resolving p-values for
                        non-significant genes. (Default: 1000).
  -w WINDOW, --window WINDOW
                        Sequence window size for HotMAPS 1D algorithm by
                        number of codons (Default: 3)
  -r, --report-index    Flag for reporting index (row number, starts at zero)
                        in associated mutation file
  -nd NULL_DISTR_DIR, --null-distr-dir NULL_DISTR_DIR
                        Path to directory to save empirical null distribution
  --unique              Only keep unique mutations for each tumor sample.
                        Mutations reported from heterogeneous sources may
                        contain duplicates, e.g. a tumor sample was sequenced
                        twice.
  -u, --use-unmapped    Use mutations that are not mapped to the the single
                        reference transcript for a gene specified in the bed
                        file indicated by the -b option.
  -g GENOME, --genome GENOME
                        Path to the genome fasta file. Required if --use-
                        unmapped flag is used. (Default: None)
  -seed SEED, --seed SEED
                        Specify the seed for the pseudo random number
                        generator. By default, the seed is randomly chosen.
                        The seed will be used for the monte carlo simulations
                        (Default: 101).
```


## Metadata
- **Skill**: not generated
