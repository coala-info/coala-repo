# ampd-up CWL Generation Report

## ampd-up_AMPd-Up

### Tool Description
Generate antimicrobial peptide sequences with recurrent neural network. Users can either generate sequences by training new models or from the existing models.

### Metadata
- **Docker Image**: quay.io/biocontainers/ampd-up:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/bcgsc/AMPd-Up
- **Package**: https://anaconda.org/channels/bioconda/packages/ampd-up/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ampd-up/overview
- **Total Downloads**: 404
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bcgsc/AMPd-Up
- **Stars**: 3
### Original Help Text
```text
usage: AMPd-Up.py [-h] [-fm FROM_MODEL] [-tr AMP_TRAIN] -n NUM_SEQ
                  [-sm SAVE_MODEL] [-od OUT_DIR] [-of {fasta,tsv}]

AMPd-Up v1.0.0
--------------------------------------------------------------
Generate antimicrobial peptide sequences with recurrent neural 
network.
Uses can either generate sequences by training new models or 
from the exiting models.

optional arguments:
  -h, --help            show this help message and exit
  -fm FROM_MODEL, --from_model FROM_MODEL
                        Directory of the existing models; only specify this
                        argument if you want to sample from existing models
                        (optional)
  -tr AMP_TRAIN, --amp_train AMP_TRAIN
                        Directory of training data (fasta format); only
                        specify this argument if you want to train AMPd-Up
                        with your own data (optional)
  -n NUM_SEQ, --num_seq NUM_SEQ
                        Number of sequences to sample
  -sm SAVE_MODEL, --save_model SAVE_MODEL
                        Prefix of the models if you want to save them; only
                        specify this argument if you want to sample by
                        training new models (optional)
  -od OUT_DIR, --out_dir OUT_DIR
                        Output directory (optional)
  -of {fasta,tsv}, --out_format {fasta,tsv}
                        Output format, fasta or tsv (tsv by default, optional)
```

