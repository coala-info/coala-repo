# deepaccess CWL Generation Report

## deepaccess_train

### Tool Description
Train a deep learning model for variant calling.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepaccess:0.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/gifford-lab/deepaccess-package
- **Package**: https://anaconda.org/channels/bioconda/packages/deepaccess/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepaccess/overview
- **Total Downloads**: 11.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gifford-lab/deepaccess-package
- **Stars**: N/A
### Original Help Text
```text
usage: deepaccess [-h] -l LABELS [LABELS ...] -out OUT [-ref REFFASTA]
                  [-g GENOME] [-beds BEDFILES [BEDFILES ...]] [-fa FASTA]
                  [-fasta_labels FASTA_LABELS] [-f FRAC_RANDOM]
                  [-nepochs NEPOCHS] [-ho HOLDOUT] [-seed SEED] [-verbose]

optional arguments:
  -h, --help            show this help message and exit
  -l LABELS [LABELS ...], --labels LABELS [LABELS ...]
  -out OUT, --out OUT
  -ref REFFASTA, --refFasta REFFASTA
  -g GENOME, --genome GENOME
                        genome chrom.sizes file
  -beds BEDFILES [BEDFILES ...], --bedfiles BEDFILES [BEDFILES ...]
  -fa FASTA, --fasta FASTA
  -fasta_labels FASTA_LABELS, --fasta_labels FASTA_LABELS
  -f FRAC_RANDOM, --frac_random FRAC_RANDOM
  -nepochs NEPOCHS, --nepochs NEPOCHS
  -ho HOLDOUT, --holdout HOLDOUT
                        chromosome to holdout
  -seed SEED, --seed SEED
  -verbose, --verbose   Print training progress
```


## deepaccess_interpret

### Tool Description
Interpret deep learning models for DNA sequence analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepaccess:0.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/gifford-lab/deepaccess-package
- **Package**: https://anaconda.org/channels/bioconda/packages/deepaccess/overview
- **Validation**: PASS

### Original Help Text
```text
usage: deepaccess [-h] -trainDir TRAINDIR [-fastas FASTAS [FASTAS ...]]
                  [-l LABELS [LABELS ...]] [-c COMPARISONS [COMPARISONS ...]]
                  [-evalMotifs EVALMOTIFS] [-evalPatterns EVALPATTERNS]
                  [-p POSITION] [-saliency] [-subtract] [-bg BACKGROUND]
                  [-vis]

optional arguments:
  -h, --help            show this help message and exit
  -trainDir TRAINDIR, --trainDir TRAINDIR
  -fastas FASTAS [FASTAS ...], --fastas FASTAS [FASTAS ...]
  -l LABELS [LABELS ...], --labels LABELS [LABELS ...]
  -c COMPARISONS [COMPARISONS ...], --comparisons COMPARISONS [COMPARISONS ...]
  -evalMotifs EVALMOTIFS, --evalMotifs EVALMOTIFS
  -evalPatterns EVALPATTERNS, --evalPatterns EVALPATTERNS
  -p POSITION, --position POSITION
  -saliency, --saliency
  -subtract, --subtract
  -bg BACKGROUND, --background BACKGROUND
  -vis, --makeVis
```


## Metadata
- **Skill**: generated
