# gnuvid CWL Generation Report

## gnuvid_GNUVID_Predict.py

### Tool Description
GNUVID v2.4 uses the natural variation in public genomes of SARS-CoV-2 to rank gene sequences based on the number of observed exact matches (the GNU score) in all known genomes of SARS-CoV-2. It assigns a sequence type to each genome based on its profile of unique gene allele sequences. It can type (using whole genome multilocus sequence typing; wgMLST) your query genome in seconds. GNUVID_Predict is a speedy algorithm for assigning Clonal Complexes to new genomes, which uses machine learning Random Forest Classifier, implemented as of GNUVID v2.0.

### Metadata
- **Docker Image**: quay.io/biocontainers/gnuvid:2.4--hdfd78af_0
- **Homepage**: https://github.com/ahmedmagds/GNUVID
- **Package**: https://anaconda.org/channels/bioconda/packages/gnuvid/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gnuvid/overview
- **Total Downloads**: 14.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ahmedmagds/GNUVID
- **Stars**: N/A
### Original Help Text
```text
usage: GNUVID_Predict.py [-h] [-o OUTPUT_FOLDER] [-m MIN_LEN] [-n N_MAX]
                         [-b BLOCK_PRED] [-e] [-i] [-f] [-q] [-v]
                         query_fna

GNUVID v2.4 uses the natural variation in public genomes of SARS-CoV-2 to rank
gene sequences based on the number of observed exact matches (the GNU score)
in all known genomes of SARS-CoV-2. It assigns a sequence type to each genome
based on its profile of unique gene allele sequences. It can type (using whole
genome multilocus sequence typing; wgMLST) your query genome in seconds.
GNUVID_Predict is a speedy algorithm for assigning Clonal Complexes to new
genomes, which uses machine learning Random Forest Classifier, implemented as
of GNUVID v2.0.

positional arguments:
  query_fna             Query Whole Genome Nucleotide FASTA file to analyze
                        (.fna)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT_FOLDER, --output_folder OUTPUT_FOLDER
                        Output folder and prefix to be created for results
                        (default: timestamped GNUVID_results in the current
                        directory)
  -m MIN_LEN, --min_len MIN_LEN
                        minimum sequence length [Default: 15000]
  -n N_MAX, --n_max N_MAX
                        maximum proportion of ambiguity (Ns) allowed [Default:
                        0.5]
  -b BLOCK_PRED, --block_pred BLOCK_PRED
                        prediction block size, good for limited memory
                        [Default: 1000]
  -e, --exact_matching  turn off exact matching (no allele will be identified
                        for each ORF) and only use machine learning prediction
                        [default: False]
  -i, --individual      Individual Output file for each genome showing the
                        allele sequence and GNU score for each gene allele
  -f, --force           Force overwriting existing results folder assigned
                        with -o (default: off)
  -q, --quiet           No screen output [default OFF]
  -v, --version         print version and exit
```

