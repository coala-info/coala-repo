# rnasamba CWL Generation Report

## rnasamba_classify

### Tool Description
Classify sequences from a input FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnasamba:0.2.5--py36h91eb985_1
- **Homepage**: https://github.com/apcamargo/RNAsamba
- **Package**: https://anaconda.org/channels/bioconda/packages/rnasamba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rnasamba/overview
- **Total Downloads**: 43.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/apcamargo/RNAsamba
- **Stars**: N/A
### Original Help Text
```text
usage: rnasamba classify [-h] [--version] [-p PROTEIN_FASTA] [-v {0,1}]
                         output_file fasta_file weights [weights ...]

Classify sequences from a input FASTA file.

positional arguments:
  output_file           output TSV file containing the results of the
                        classification.
  fasta_file            input FASTA file containing transcript sequences.
  weights               input HDF5 file(s) containing weights of a trained
                        RNAsamba network (if more than a file is provided, an
                        ensembling of the models will be performed).

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -p PROTEIN_FASTA, --protein_fasta PROTEIN_FASTA
                        output FASTA file containing translated sequences for
                        the predicted coding ORFs. (default: None)
  -v {0,1}, --verbose {0,1}
                        print the progress of the classification. 0 = silent,
                        1 = current step. (default: 0)
```


## rnasamba_train

### Tool Description
Train a new classification model.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnasamba:0.2.5--py36h91eb985_1
- **Homepage**: https://github.com/apcamargo/RNAsamba
- **Package**: https://anaconda.org/channels/bioconda/packages/rnasamba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnasamba train [-h] [--version] [-s EARLY_STOPPING] [-b BATCH_SIZE]
                      [-e EPOCHS] [-v {0,1,2,3}]
                      output_file coding_file noncoding_file

Train a new classification model.

positional arguments:
  output_file           output HDF5 file containing weights of the newly
                        trained RNAsamba network.
  coding_file           input FASTA file containing sequences of protein-
                        coding transcripts.
  noncoding_file        input FASTA file containing sequences of noncoding
                        transcripts.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -s EARLY_STOPPING, --early_stopping EARLY_STOPPING
                        number of epochs after lowest validation loss before
                        stopping training (a fraction of 0.1 of the training
                        set is set apart for validation and the model with the
                        lowest validation loss will be saved). (default: 0)
  -b BATCH_SIZE, --batch_size BATCH_SIZE
                        number of samples per gradient update. (default: 128)
  -e EPOCHS, --epochs EPOCHS
                        number of epochs to train the model. (default: 40)
  -v {0,1,2,3}, --verbose {0,1,2,3}
                        print the progress of the training. 0 = silent, 1 =
                        current step, 2 = progress bar, 3 = one line per
                        epoch. (default: 0)
```

