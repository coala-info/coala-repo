# rnavirhost CWL Generation Report

## rnavirhost_classify_order

### Tool Description
Classifier query viruses at order level

### Metadata
- **Docker Image**: quay.io/biocontainers/rnavirhost:1.0.5--pyh7cba7a3_0
- **Homepage**: https://github.com/GreyGuoweiChen/VirHost.git
- **Package**: https://anaconda.org/channels/bioconda/packages/rnavirhost/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rnavirhost/overview
- **Total Downloads**: 327
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/GreyGuoweiChen/VirHost
- **Stars**: N/A
### Original Help Text
```text
Classifier query viruses at order level

usage: rnavirhost classify_order -i <input> -o <taxa.csv> [options]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        The name of query fasta file.
  -o OUTPUT, --output OUTPUT
                        The output taxonomic file.
```


## rnavirhost_predict

### Tool Description
Predict hosts of the query viruses

### Metadata
- **Docker Image**: quay.io/biocontainers/rnavirhost:1.0.5--pyh7cba7a3_0
- **Homepage**: https://github.com/GreyGuoweiChen/VirHost.git
- **Package**: https://anaconda.org/channels/bioconda/packages/rnavirhost/overview
- **Validation**: PASS

### Original Help Text
```text
Predict hosts of the query viruses

usage: rnavirhost predict -i <input> --taxa <taxa.csv> [options] -o <output> [options]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        The query fasta file.
  --taxa TAXA           The virus order taxa of query sequences. (.csv)
  -o OUTPUT, --output OUTPUT
                        The output directory，including the output and
                        intermediate file.
```

