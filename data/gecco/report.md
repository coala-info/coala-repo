# gecco CWL Generation Report

## gecco_annotate

### Tool Description
Annotate genomic sequences with genes and protein domains.

### Metadata
- **Docker Image**: quay.io/biocontainers/gecco:0.10.2--pyhdfd78af_0
- **Homepage**: https://gecco.embl.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/gecco/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gecco/overview
- **Total Downloads**: 41.7K
- **Last updated**: 2026-01-27
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: gecco annotate [-h] [-V] [-j JOBS] [-v] [-q] [--no-color] [--no-markup]
                      -g GENOME [-f FORMAT] [-M] [--cds-feature CDS_FEATURE]
                      [--locus-tag LOCUS_TAG] [--hmm HMMS] [-e E_FILTER]
                      [-p P_FILTER] [--bit-cutoffs {noise,gathering,trusted}]
                      [-o OUTPUT_DIR] [--force-tsv]

Options:
  -h, --help            Show this help message and exit.
  -V, --version         Show the program version number and exit.
  -j, --jobs JOBS       The number of jobs to use for multithreading. Use 0 to
                        use all available CPUs.
  -v, --verbose         Increase the console output
  -q, --quiet           Reduce or disable the console output
  --no-color            Disable the console color (default: True)
  --no-markup           Disable the console markup (default: True)

Input Sequences:
  -g, --genome GENOME   A genomic file containing one or more sequences to use
                        as input. Must be in one of the sequence formats
                        supported by Biopython (default: None)
  -f, --format FORMAT   The format of the input file, as a Biopython format
                        string. FASTA, EMBL and GenBank files are recognized
                        automatically if this is not given. (default: None)

Gene Calling:
  -M, --mask            Enable unknown region masking to prevent genes from
                        stretching across ambiguous nucleotides. (default:
                        False)
  --cds-feature CDS_FEATURE
                        Extract genes from annotated records using a feature
                        rather than running de-novo gene-calling. (default:
                        None)
  --locus-tag LOCUS_TAG
                        The name of the feature qualifier to use for naming
                        extracted genes when using the ``--cds-feature`` flag.
                        (default: locus_tag)

Domain Annotation:
  --hmm HMMS            The path to one or more alternative HMM file to use
                        (in HMMER format). (default: None)
  -e, --e-filter E_FILTER
                        The e-value cutoff for protein domains to be included.
                        This is not stable across versions, so consider using
                        a p-value filter instead. (default: None)
  -p, --p-filter P_FILTER
                        The p-value cutoff for protein domains to be included.
                        (default: 1e-09)
  --bit-cutoffs {noise,gathering,trusted}
                        Use HMM-specific bitscore cutoffs to filter domain
                        annotations. (default: None)

Output:
  -o, --output-dir OUTPUT_DIR
                        The directory in which to write the output files.
                        (default: .)
  --force-tsv           Always write TSV output files even when they are empty
                        (e.g. because no genes or no clusters were found).
                        (default: False)
```


## gecco_run

### Tool Description
Run gecco gene calling and cluster detection

### Metadata
- **Docker Image**: quay.io/biocontainers/gecco:0.10.2--pyhdfd78af_0
- **Homepage**: https://gecco.embl.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/gecco/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gecco run [-h] [-V] [-j JOBS] [-v] [-q] [--no-color] [--no-markup]
                 -g GENOME [-f FORMAT] [-M] [--cds-feature CDS_FEATURE]
                 [--locus-tag LOCUS_TAG] [--hmm HMMS] [-e E_FILTER]
                 [-p P_FILTER] [--bit-cutoffs {noise,gathering,trusted}]
                 [--model MODEL] [--no-pad] [-c CDS] [-m THRESHOLD]
                 [-E EDGE_DISTANCE] [-o OUTPUT_DIR] [--force-tsv]
                 [--merge-gbk] [--antismash-sideload]

Options:
  -h, --help            Show this help message and exit.
  -V, --version         Show the program version number and exit.
  -j, --jobs JOBS       The number of jobs to use for multithreading. Use 0 to
                        use all available CPUs.
  -v, --verbose         Increase the console output
  -q, --quiet           Reduce or disable the console output
  --no-color            Disable the console color (default: True)
  --no-markup           Disable the console markup (default: True)

Input Sequences:
  -g, --genome GENOME   A genomic file containing one or more sequences to use
                        as input. Must be in one of the sequence formats
                        supported by Biopython (default: None)
  -f, --format FORMAT   The format of the input file, as a Biopython format
                        string. FASTA, EMBL and GenBank files are recognized
                        automatically if this is not given. (default: None)

Gene Calling:
  -M, --mask            Enable unknown region masking to prevent genes from
                        stretching across ambiguous nucleotides. (default:
                        False)
  --cds-feature CDS_FEATURE
                        Extract genes from annotated records using a feature
                        rather than running de-novo gene-calling. (default:
                        None)
  --locus-tag LOCUS_TAG
                        The name of the feature qualifier to use for naming
                        extracted genes when using the ``--cds-feature`` flag.
                        (default: locus_tag)

Domain Annotation:
  --hmm HMMS            The path to one or more alternative HMM file to use
                        (in HMMER format). (default: None)
  -e, --e-filter E_FILTER
                        The e-value cutoff for protein domains to be included.
                        This is not stable across versions, so consider using
                        a p-value filter instead. (default: None)
  -p, --p-filter P_FILTER
                        The p-value cutoff for protein domains to be included.
                        (default: 1e-09)
  --bit-cutoffs {noise,gathering,trusted}
                        Use HMM-specific bitscore cutoffs to filter domain
                        annotations. (default: None)

Cluster Detection:
  --model MODEL         The path to an alternative CRF model to use (obtained
                        with `gecco train`). (default: None)
  --no-pad              Disable padding of gene sequences (used to predict
                        gene clusters in contigs smaller than the CRF window
                        length). (default: True)
  -c, --cds CDS         The minimum number of coding sequences a valid cluster
                        must contain to be retained. (default: 3)
  -m, --threshold THRESHOLD
                        The probability threshold for cluster detection.
                        (default: 0.8)
  -E, --edge-distance EDGE_DISTANCE
                        The minimum number of annotated genes that must
                        separate a cluster from the edge. Edge clusters will
                        still be included if they are longer. A lower number
                        will increase the number of false positives on small
                        contigs. (default: 0)

Output:
  -o, --output-dir OUTPUT_DIR
                        The directory in which to write the output files.
                        (default: .)
  --force-tsv           Always write TSV output files even when they are empty
                        (e.g. because no genes or no clusters were found).
                        (default: False)
  --merge-gbk           Output a single GenBank file containing every detected
                        cluster instead of writing one file per cluster.
                        (default: False)
  --antismash-sideload  Write an AntiSMASH v6 sideload JSON file next to the
                        output files. (default: False)
```


## gecco_predict

### Tool Description
Predicts gene clusters and domain annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/gecco:0.10.2--pyhdfd78af_0
- **Homepage**: https://gecco.embl.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/gecco/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gecco predict [-h] [-V] [-j JOBS] [-v] [-q] [--no-color] [--no-markup]
                     --genome GENOME [--format FORMAT] -f FEATURES -g GENES
                     [-e E_FILTER] [-p P_FILTER] [--model MODEL] [--no-pad]
                     [-c CDS] [-m THRESHOLD] [-E EDGE_DISTANCE]
                     [-o OUTPUT_DIR] [--force-tsv] [--merge-gbk]
                     [--antismash-sideload]

Options:
  -h, --help            Show this help message and exit.
  -V, --version         Show the program version number and exit.
  -j, --jobs JOBS       The number of jobs to use for multithreading. Use 0 to
                        use all available CPUs.
  -v, --verbose         Increase the console output
  -q, --quiet           Reduce or disable the console output
  --no-color            Disable the console color (default: True)
  --no-markup           Disable the console markup (default: True)

Input Sequences:
  --genome GENOME       A genomic file containing one or more sequences to use
                        as input. Must be in one of the sequence formats
                        supported by Biopython (default: None)
  --format FORMAT       The format of the input file, as a Biopython format
                        string. FASTA, EMBL and GenBank files are recognized
                        automatically if this is not given. (default: None)

Input Tables:
  -f, --features FEATURES
                        The path to a domain annotation table, used to train
                        the CRF model. (default: None)
  -g, --genes GENES     The path to a gene table, containing the coordinates
                        of the genes inside the training sequence. (default:
                        None)

Domain Annotation:
  -e, --e-filter E_FILTER
                        The e-value cutoff for protein domains to be included.
                        This is not stable across versions, so consider using
                        a p-value filter instead. (default: None)
  -p, --p-filter P_FILTER
                        The p-value cutoff for protein domains to be included.
                        (default: 1e-09)

Cluster Detection:
  --model MODEL         The path to an alternative CRF model to use (obtained
                        with `gecco train`). (default: None)
  --no-pad              Disable padding of gene sequences (used to predict
                        gene clusters in contigs smaller than the CRF window
                        length). (default: True)
  -c, --cds CDS         The minimum number of coding sequences a valid cluster
                        must contain to be retained. (default: 3)
  -m, --threshold THRESHOLD
                        The probability threshold for cluster detection.
                        (default: 0.8)
  -E, --edge-distance EDGE_DISTANCE
                        The minimum number of annotated genes that must
                        separate a cluster from the edge. Edge clusters will
                        still be included if they are longer. A lower number
                        will increase the number of false positives on small
                        contigs. (default: 0)

Output:
  -o, --output-dir OUTPUT_DIR
                        The directory in which to write the output files.
                        (default: .)
  --force-tsv           Always write TSV output files even when they are empty
                        (e.g. because no genes or no clusters were found).
                        (default: False)
  --merge-gbk           Output a single GenBank file containing every detected
                        cluster instead of writing one file per cluster.
                        (default: False)
  --antismash-sideload  Write an AntiSMASH v6 sideload JSON file next to the
                        output files. (default: False)
```


## gecco_train

### Tool Description
Train a CRF model for domain annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/gecco:0.10.2--pyhdfd78af_0
- **Homepage**: https://gecco.embl.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/gecco/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gecco train [-h] [-V] [-j JOBS] [-v] [-q] [--no-color] [--no-markup]
                   -f FEATURES -g GENES -c CLUSTERS [-e E_FILTER]
                   [-p P_FILTER] [--no-shuffle] [--seed SEED] [-W WINDOW_SIZE]
                   [--window-step WINDOW_STEP] [--c1 C1] [--c2 C2]
                   [--feature-type {protein,domain}] [--select SELECT]
                   [--correction CORRECTION] [-o OUTPUT_DIR]

Options:
  -h, --help            Show this help message and exit.
  -V, --version         Show the program version number and exit.
  -j, --jobs JOBS       The number of jobs to use for multithreading. Use 0 to
                        use all available CPUs.
  -v, --verbose         Increase the console output
  -q, --quiet           Reduce or disable the console output
  --no-color            Disable the console color (default: True)
  --no-markup           Disable the console markup (default: True)

Input Tables:
  -f, --features FEATURES
                        The path to a domain annotation table, used to train
                        the CRF model. (default: None)
  -g, --genes GENES     The path to a gene table, containing the coordinates
                        of the genes inside the training sequence. (default:
                        None)
  -c, --clusters CLUSTERS
                        The path to a cluster annotation table, used to
                        extract the domain composition for the type
                        classifier. (default: None)

Domain Annotation:
  -e, --e-filter E_FILTER
                        The e-value cutoff for protein domains to be included.
                        This is not stable across versions, so consider using
                        a p-value filter instead. (default: None)
  -p, --p-filter P_FILTER
                        The p-value cutoff for protein domains to be included.
                        (default: 1e-09)

Training Data:
  --no-shuffle          Disable shuffling the data before fitting the model.
                        (default: True)
  --seed SEED           The seed to initialize the random number generator
                        used for shuffling operations. (default: 42)

Training Parameters:
  -W, --window-size WINDOW_SIZE
                        The length of the sliding window for CRF predictions.
                        (default: 5)
  --window-step WINDOW_STEP
                        The step of the sliding window for CRF predictions.
                        (default: 1)
  --c1 C1               The strength of the L1 regularization. (default: 0.15)
  --c2 C2               The strength of the L2 regularization. (default: 0.15)
  --feature-type {protein,domain}
                        The level at which the features should be extracted
                        and given to the CRF. (default: protein)
  --select SELECT       The fraction of most significant features to select
                        from the training data prior to training the CRF.
                        (default: None)
  --correction CORRECTION
                        The multiple test correction method to use when
                        computing significance with multiple testing.
                        (default: None)

Output:
  -o, --output-dir OUTPUT_DIR
                        The directory in which to write the output files.
                        (default: .)
```


## gecco_cv

### Tool Description
Cross-validation for gecco

### Metadata
- **Docker Image**: quay.io/biocontainers/gecco:0.10.2--pyhdfd78af_0
- **Homepage**: https://gecco.embl.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/gecco/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gecco cv [-h] [-V] [-j JOBS] [-v] [-q] [--no-color] [--no-markup]
                -f FEATURES -g GENES -c CLUSTERS [-e E_FILTER] [-p P_FILTER]
                [--no-shuffle] [--seed SEED] [-W WINDOW_SIZE]
                [--window-step WINDOW_STEP] [--c1 C1] [--c2 C2]
                [--feature-type {protein,domain}] [--select SELECT]
                [--correction CORRECTION] [--loto] [--splits SPLITS]
                [-o OUTPUT]

Options:
  -h, --help            Show this help message and exit.
  -V, --version         Show the program version number and exit.
  -j, --jobs JOBS       The number of jobs to use for multithreading. Use 0 to
                        use all available CPUs.
  -v, --verbose         Increase the console output
  -q, --quiet           Reduce or disable the console output
  --no-color            Disable the console color (default: True)
  --no-markup           Disable the console markup (default: True)

Input Tables:
  -f, --features FEATURES
                        The path to a domain annotation table, used to train
                        the CRF model. (default: None)
  -g, --genes GENES     The path to a gene table, containing the coordinates
                        of the genes inside the training sequence. (default:
                        None)
  -c, --clusters CLUSTERS
                        The path to a cluster annotation table, used to
                        extract the domain composition for the type
                        classifier. (default: None)

Domain Annotation:
  -e, --e-filter E_FILTER
                        The e-value cutoff for protein domains to be included.
                        This is not stable across versions, so consider using
                        a p-value filter instead. (default: None)
  -p, --p-filter P_FILTER
                        The p-value cutoff for protein domains to be included.
                        (default: 1e-09)

Training Data:
  --no-shuffle          Disable shuffling the data before fitting the model.
                        (default: True)
  --seed SEED           The seed to initialize the random number generator
                        used for shuffling operations. (default: 42)

Training Parameters:
  -W, --window-size WINDOW_SIZE
                        The length of the sliding window for CRF predictions.
                        (default: 5)
  --window-step WINDOW_STEP
                        The step of the sliding window for CRF predictions.
                        (default: 1)
  --c1 C1               The strength of the L1 regularization. (default: 0.15)
  --c2 C2               The strength of the L2 regularization. (default: 0.15)
  --feature-type {protein,domain}
                        The level at which the features should be extracted
                        and given to the CRF. (default: protein)
  --select SELECT       The fraction of most significant features to select
                        from the training data prior to training the CRF.
                        (default: None)
  --correction CORRECTION
                        The multiple test correction method to use when
                        computing significance with multiple testing.
                        (default: None)

Cross-Validation:
  --loto                Use Leave-One-Type-Out (LOTO) cross-validation instead
                        of K-folds cross-validation. (default: False)
  --splits SPLITS       Number of folds for cross-validation (if running
                        K-folds). (default: 10)

Output:
  -o, --output OUTPUT   The name of the output file where the cross-validation
                        table will be written. (default: cv.tsv)
```


## gecco_convert

### Tool Description
Convert the GenBank records to a different format.

### Metadata
- **Docker Image**: quay.io/biocontainers/gecco:0.10.2--pyhdfd78af_0
- **Homepage**: https://gecco.embl.de/
- **Package**: https://anaconda.org/channels/bioconda/packages/gecco/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gecco convert [-h] [-V] [-j JOBS] [-v] [-q] [--no-color] [--no-markup]
                     INPUT ...

Positional Arguments:
  INPUT
    gbk            Convert the GenBank records to a different format.
    clusters       Convert the clusters table to a different format.

Options:
  -h, --help       Show this help message and exit.
  -V, --version    Show the program version number and exit.
  -j, --jobs JOBS  The number of jobs to use for multithreading. Use 0 to use
                   all available CPUs.
  -v, --verbose    Increase the console output
  -q, --quiet      Reduce or disable the console output
  --no-color       Disable the console color (default: True)
  --no-markup      Disable the console markup (default: True)
```

