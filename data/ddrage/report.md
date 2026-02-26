# ddrage CWL Generation Report

## ddrage

### Tool Description
RAGE -- the ddRAD generator -- simulates ddRADseq

### Metadata
- **Docker Image**: quay.io/biocontainers/ddrage:1.8.1--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/genomeinformatics/rage
- **Package**: https://anaconda.org/channels/bioconda/packages/ddrage/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ddrage/overview
- **Total Downloads**: 58.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: ddrage [-h] [--name NAME] [-o OUTPUT_PATH_PREFIX] [-n NR_INDIVIDUALS]
              [-l LOCI] [-r READ_LENGTH] [-c COV] [--hrl-number HRL_NUMBER]
              [--no-singletons] [--diversity DIVERSITY]
              [--gc-content GC_CONTENT] [-q QUALITY_MODEL] [--single-end]
              [--overlap OVERLAP] [--multiple-p7-barcodes]
              [--coverage-model COVERAGE_MODEL] [--BBD-alpha BBD_ALPHA]
              [--BBD-beta BBD_BETA] [--max-pcr-copies MAX_PCR_COPY_NR]
              [--hrl-max-cov HRL_MAX_COV] [-d DBR] [--p5-overhang P5_OVERHANG]
              [--p7-overhang P7_OVERHANG] [--p5-rec-site P5_REC_SITE]
              [--p7-rec-site P7_REC_SITE] [-b BARCODE_SET]
              [--event-probabilities PROB_COMMON PROB_DROPOUT PROB_MUTATION]
              [--mutation-type-probabilities PROB_SNP PROB_INSERTION PROB_DELETION PROB_P5_NA_ALTERNATIVE PROB_P7_NA_ALTERNATIVE PROB_P5_NA_DROPOUT PROB_P7_NA_DROPOUT]
              [--prob-heterozygous PROB_HETEROZYGOCITY]
              [--prob-incomplete-digestion PROB_INCOMPLETE_DIGESTION]
              [--rate-incomplete-digestion RATE_INCOMPLETE_DIGESTION]
              [--prob-pcr-copy PROB_PCR_COPY]
              [--hrl-pcr-copies HRL_PCR_COPIES]
              [--singleton-pcr-copies SINGLETON_PCR_COPIES]
              [-e PROB_SEQ_ERROR] [-v] [-z] [--get-barcodes] [--DEBUG]
              [--version]

RAGE -- the ddRAD generator -- simulates ddRADseq

options:
  -h, --help            show this help message and exit
  -v, --verbose         Increase verbosity of output. -v: Show progress of
                        simulation. -vv: Print used parameters after
                        simulation. -vvv: Show details for each simulated
                        locus.
  -z, --zip             Write output as gzipped fastq.
  --get-barcodes        Write copies of the default barcode files into the
                        current folder.
  --DEBUG               Set debug-friendly values for the data set, i.e. all
                        mutation events and mutation types are equally
                        probable.
  --version             Print the version number.

Naming Parameters:
  --name NAME           Name for the data set that will be used in the file
                        name. If none is given, the name 'RAGEdataset' will be
                        used.
  -o OUTPUT_PATH_PREFIX, --output OUTPUT_PATH_PREFIX
                        Prefix of the output path. At this point a folder will
                        be created that contains all output files created by
                        ddRAGE.

Dataset Parameters:
  -n NR_INDIVIDUALS, --nr-individuals NR_INDIVIDUALS
                        Number of individuals in the result. Default: 3
  -l LOCI, --loci LOCI  Number of loci for which reads will be created or path
                        to a FASTA file with predefined fragments. Default: 3
  -r READ_LENGTH, --read-length READ_LENGTH
                        Total sequence length of the reads (including
                        overhang, barcodes, etc.). The officially supported
                        and well tested range is 50-500bp but longer or
                        shorter reads are also possible. Default: 100
  -c COV, --coverage COV
                        Expected coverage that will be created by normal
                        duplication and mutations. The exact coverage value is
                        determined using a probabilistic process. Default: 30
  --hrl-number HRL_NUMBER
                        Number of Highly Repetitive Loci (HRLs) that will be
                        added, given as fraction of total locus size. Example:
                        ``-l 100 --hrl-number 0.1`` for 10 HRLs. Default: 0.05
  --no-singletons       Disable generation of singleton reads.
  --diversity DIVERSITY
                        Parameter for the number of genotypes created per
                        locus. This will be used as parameter for a Poisson
                        distribution. Default: 1.0, increase for more alleles/
                        genotypes per locus.
  --gc-content GC_CONTENT
                        GC content of the generated sequences. Default: 0.5
  -q QUALITY_MODEL, --quality-model QUALITY_MODEL
                        Path to a quality model file (.qmodel.npz). A qmodel
                        file contains a probability vector for each read
                        position. For details, please refer to the
                        documentation.
  --single-end, --se    Write a single-end dataset. Only writes a p5 FASTQ
                        file. Default: False
  --overlap OVERLAP, --ol OVERLAP
                        Overlap factor (between 0 and 1.0) of randomly
                        generated reads. Default 0
  --multiple-p7-barcodes, --combine-p7-bcs
                        Combine individuals with multiple p7 barcodes in one
                        output file. Default: False

Coverage Model Parameters:
  --coverage-model COVERAGE_MODEL
                        Model to choose coverage values. Can be either
                        'poisson' or 'betabinomial'. The Betabinomial model is
                        the default as it can be easily adapted to different
                        coverage profiles using the --BBD-alpha and --BBD-beta
                        parameters.
  --BBD-alpha BBD_ALPHA
                        Alpha parameter of the Beta-binomial distribution.
                        Higher values increase the left tailing of the
                        coverage distribution, if the BBD model is used.
                        Default: 6
  --BBD-beta BBD_BETA   Beta parameter of the Beta-binomial distribution.
                        Higher values increase the right tailing of the
                        coverage distribution, if the BBD model is used.
                        Default: 2
  --max-pcr-copies MAX_PCR_COPY_NR
                        Maximum number of PCR copies that can be created for
                        each finalized (potentially mutated and multiplied)
                        read. Default: 3
  --hrl-max-cov HRL_MAX_COV, --hrl-max-coverage HRL_MAX_COV
                        Maximum coverage for Highly Repetitive Loci (HRLs)
                        (per individual). The minimum coverage is determined
                        as mean + 2 standard deviations of the main coverage
                        generating function. Default: 1000

Read Sequences:
  -d DBR, --dbr DBR     Sequence of the degenerate base region (DBR) in IUPAC
                        ambiguity code. Default: 'NNNNNNMMGGACG'. To not
                        include a DBR sequence use --dbr ''
  --p5-overhang P5_OVERHANG
                        Sequence of the p5 overhang. Default: 'TGCAT'
  --p7-overhang P7_OVERHANG
                        Sequence of the p7 overhang. Default: 'TAC'
  --p5-rec-site P5_REC_SITE
                        Sequence of the p5 recognition site. Default: 'ATGCAT'
  --p7-rec-site P7_REC_SITE
                        Sequence of the p7 recognition site. Default: 'GTCA'
  -b BARCODE_SET, --barcodes BARCODE_SET
                        Path to barcodes file or predefined barcode set like
                        'barcodes', 'small', 'full' or 'full'. Default:
                        'barcodes', a generic population. Take a look at the
                        rage/barcode_handler/barcodes folder for more
                        information.

Simulation Probabilities:
  --event-probabilities PROB_COMMON PROB_DROPOUT PROB_MUTATION
                        Probability profile for the distribution of event
                        types (common, dropout, mutation; in this order).
                        Example: ``python ddrage.py --event-probabilities 0.9
                        0.05 0.05`` -> common 90%, dropout 5%, mutation 5%
                        (Default). Each entry can be given as a float or a
                        string of python code (see example above) which is
                        helpful for small probability values.
  --mutation-type-probabilities PROB_SNP PROB_INSERTION PROB_DELETION PROB_P5_NA_ALTERNATIVE PROB_P7_NA_ALTERNATIVE PROB_P5_NA_DROPOUT PROB_P7_NA_DROPOUT
                        Probability profile for the distribution of mutation
                        types (snp, insertion, deletion, p5 na alternative, p7
                        na alternative, p5 na dropout, p7 na dropout; in this
                        order). Example: ``python ddrage.py --mutation-type-
                        probabilities 0.8999 0.05 0.05 '0.0001*0.001'
                        '0.0001*0.05' '0.0001*0.899' '0.0001*0.05'`` -> snp
                        89.99%, insertion 5%, deletion 5%, p5 na alternative
                        0.00001% , p7 na alternative 0.0005%, p5 na dropout
                        0.00899%, p7 na dropout 0.0005% (Default). Each entry
                        can be given as a float or a string of python code
                        (see example above) which is helpful for small
                        probability values.
  --prob-heterozygous PROB_HETEROZYGOCITY
                        Probability of mutations being heterozygous. Default:
                        0.5
  --prob-incomplete-digestion PROB_INCOMPLETE_DIGESTION
                        Probability of incomplete digestion for an individual
                        at a locus. Default: 0.1
  --rate-incomplete-digestion RATE_INCOMPLETE_DIGESTION
                        Expected fraction of reads that are being lost in the
                        event of Incomplete Digestion. Default: 0.2
  --prob-pcr-copy PROB_PCR_COPY
                        Probability that a (potentially mutated and
                        multiplied) read will receive PCR copies. This
                        influences the simulated PCR copy rate. Default: 0.2
  --hrl-pcr-copies HRL_PCR_COPIES
                        Probability of PCR copies for HRL reads in relation to
                        normal reads. Default: 0.9, i.e. the probability for a
                        PCR copy of a HRL read is prob_pcr_copy * hrl_pcr
                        copies = 0.2 * 0.9 = 0.18
  --singleton-pcr-copies SINGLETON_PCR_COPIES
                        Probability of PCR copies for singleton reads in
                        relation to normal reads. Default: 1/3, i.e. the
                        probability for a PCR copy of a singleton read is
                        prob_pcr_copy * singleton_pcr_copies = 0.2 * (1/3) =
                        0.0666...
  -e PROB_SEQ_ERROR, --prob-seq-error PROB_SEQ_ERROR
                        Probability of sequencing substitution errors.
                        Default: 0.01
```


## Metadata
- **Skill**: generated
