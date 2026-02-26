# plasflow CWL Generation Report

## plasflow_PlasFlow.py

### Tool Description
predicting plasmid sequences in metagenomic data using genome signatures. PlasFlow is based on the TensorFlow artificial neural network classifier

### Metadata
- **Docker Image**: quay.io/biocontainers/plasflow:1.1.0--py35_0
- **Homepage**: https://github.com/smaegol/PlasFlow
- **Package**: https://anaconda.org/channels/bioconda/packages/plasflow/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plasflow/overview
- **Total Downloads**: 8.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/smaegol/PlasFlow
- **Stars**: N/A
### Original Help Text
```text
usage: PlasFlow.py [-h] --input INPUTFILE --output OUTPUTFILE
                   [--threshold THRESHOLD] [--labels LABELS] [--models MODELS]

PlasFlow - predicting plasmid sequences in metagenomic data using genome
signatures. PlasFlow is based on the TensorFlow artificial neural network
classifier

optional arguments:
  -h, --help            show this help message and exit
  --input INPUTFILE     Input fasta file with sequences to classify (required)
  --output OUTPUTFILE   Output file with classification results (required)
  --threshold THRESHOLD
                        Threshold for probability filtering (default=0.7)
  --labels LABELS       Custom labels file
  --models MODELS       Custom models localization
```

