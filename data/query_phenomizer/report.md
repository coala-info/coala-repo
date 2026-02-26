# query_phenomizer CWL Generation Report

## query_phenomizer

### Tool Description
Give hpo terms either on the form 'HP:0001623', or '0001623'

### Metadata
- **Docker Image**: quay.io/biocontainers/query_phenomizer:1.2.1--pyh7cba7a3_0
- **Homepage**: https://www.github.com/moonso/query_phenomizer
- **Package**: https://anaconda.org/channels/bioconda/packages/query_phenomizer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/query_phenomizer/overview
- **Total Downloads**: 12.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: query_phenomizer [OPTIONS] [HPO_TERM]...

  Give hpo terms either on the form 'HP:0001623', or '0001623'

Options:
  -u, --username TEXT    A username for phenomizer
  -p, --password TEXT    A password for phenomizer
  -c, --check-terms      Check if the term(s) exist
  -o, --output FILENAME  Specify the path to a file for storing the phenomizer
                         output.
  --p-value-limit FLOAT  Specify the highest p-value that you want included.
                         [default: 1.0]
  --to-json              If result should be printed to json format
  -v, --verbose
  --help                 Show this message and exit.
```

