# psap CWL Generation Report

## psap_annotate

### Tool Description
Annotate peptide fasta files with LLPS labels and store as a data frame

### Metadata
- **Docker Image**: quay.io/biocontainers/psap:1.0.7--pyhdfd78af_0
- **Homepage**: https://github.com/vanheeringen-lab/psap
- **Package**: https://anaconda.org/channels/bioconda/packages/psap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/psap/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vanheeringen-lab/psap
- **Stars**: N/A
### Original Help Text
```text
usage: psap annotate [-h] -f FASTA [-l LABELS] [-o OUT]

options:
  -h, --help            show this help message and exit
  -f FASTA, --fasta FASTA
                        Path to peptide fasta file
  -l LABELS, --labels LABELS
                        .txt file with llps uniprot ids (positive training
                        labels)
  -o OUT, --out OUT     Output directory to store annotated data frame in .csv
                        format
```


## psap_train

### Tool Description
Train a RandomForest classifier for PSAP (Phase Separation Associated Proteins)

### Metadata
- **Docker Image**: quay.io/biocontainers/psap:1.0.7--pyhdfd78af_0
- **Homepage**: https://github.com/vanheeringen-lab/psap
- **Package**: https://anaconda.org/channels/bioconda/packages/psap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: psap train [-h] -f FASTA [-o OUT] [-l LABELS]

options:
  -h, --help            show this help message and exit
  -f FASTA, --fasta FASTA
                        Path to peptide fasta file
  -o OUT, --out OUT     Output directory to store trained RandomForest
                        classifier in json format
  -l LABELS, --labels LABELS
                        .txt file with llps uniprot ids (positive training
                        labels)
```


## psap_predict

### Tool Description
Predict protein phase separation potential using the PSAP classifier.

### Metadata
- **Docker Image**: quay.io/biocontainers/psap:1.0.7--pyhdfd78af_0
- **Homepage**: https://github.com/vanheeringen-lab/psap
- **Package**: https://anaconda.org/channels/bioconda/packages/psap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: psap predict [-h] -f FASTA [-m MODEL] [-o OUT] [-l LABELS]

options:
  -h, --help            show this help message and exit
  -f FASTA, --fasta FASTA
                        Path to peptide fasta file
  -m MODEL, --model MODEL
                        Path to RandomForest model in json format
  -o OUT, --out OUT     Output directory for psap prediction results
  -l LABELS, --labels LABELS
                        .txt file with llps uniprot ids (positive training
                        labels)
```


## Metadata
- **Skill**: generated
