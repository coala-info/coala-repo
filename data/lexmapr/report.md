# lexmapr CWL Generation Report

## lexmapr

### Tool Description
Map lexical terms to ontology IRIs and classify samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/lexmapr:0.7.1--py36h09cc20e_1
- **Homepage**: https://github.com/LexMapr/lexmapr
- **Package**: https://anaconda.org/channels/bioconda/packages/lexmapr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lexmapr/overview
- **Total Downloads**: 53.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LexMapr/lexmapr
- **Stars**: N/A
### Original Help Text
```text
usage: lexmapr [-h] [-o [OUTPUT]] [-f] [-c CONFIG] [-b] [--no-cache] [-v]
               [-p {ifsac}]
               input_file

positional arguments:
  input_file            Input csv or tsv file

optional arguments:
  -h, --help            show this help message and exit
  -o [OUTPUT], --output [OUTPUT]
                        Output file
  -f, --full            Full output format
  -c CONFIG, --config CONFIG
                        Path to JSON file containing the IRI of ontologies to fetch terms from
  -b, --bucket          Classify samples into pre-defined buckets
  --no-cache            Ignore or replace online cached resources, if there are any.
  -v, --version         show program's version number and exit
  -p {ifsac}, --profile {ifsac}
                        Pre-defined sets of command-line arguments for specialized purposes:
                        
                        * ifsac: 
                          * maps samples to food and environmental resources
                          * classifies samples into ifsac labels
                          * outputs content to ``ifsac_output.tsv``
```

