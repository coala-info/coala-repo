# graphembed CWL Generation Report

## graphembed_embedding

### Tool Description
Graph/Network Embedding

### Metadata
- **Docker Image**: quay.io/biocontainers/graphembed:0.1.8--h2e3eeea_0
- **Homepage**: https://github.com/jean-pierreBoth/graphembed
- **Package**: https://anaconda.org/channels/bioconda/packages/graphembed/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/graphembed/overview
- **Total Downloads**: 3.5K
- **Last updated**: 2025-08-08
- **GitHub**: https://github.com/jean-pierreBoth/graphembed
- **Stars**: N/A
### Original Help Text
```text
************** initializing logger *****************

Graph/Network Embedding

Usage: graphembed --csv <csvfile> --symetric <symetry> embedding [OPTIONS] <COMMAND>

Commands:
  hope       Asymmetric Transitivity Preserving Graph Embedding
  sketching  Highly-Efficient Graph/Network Embeddings via Recursive Sketching
  help       Print this message or the help of the given subcommand(s)

Options:
  -o, --output <output>  -o fname for a dump in fname.bson
  -h, --help             Print help
```


## graphembed_validation

### Tool Description
Graph/Network Embedding with Accuracy Benchmark

### Metadata
- **Docker Image**: quay.io/biocontainers/graphembed:0.1.8--h2e3eeea_0
- **Homepage**: https://github.com/jean-pierreBoth/graphembed
- **Package**: https://anaconda.org/channels/bioconda/packages/graphembed/overview
- **Validation**: PASS

### Original Help Text
```text
************** initializing logger *****************

Graph/Network Embedding with Accuracy Benchmark

Usage: graphembed --csv <csvfile> --symetric <symetry> validation [OPTIONS] --nbpass <nbpass> --skip <skip> <COMMAND>

Commands:
  hope       Asymmetric Transitivity Preserving Graph Embedding
  sketching  Highly-Efficient Graph/Network Embeddings via Recursive Sketching
  help       Print this message or the help of the given subcommand(s)

Options:
      --nbpass <nbpass>  number  of passes of validation
      --skip <skip>      fraction of edges to skip in training set
      --centric          --centric To ask for a centric validation pass after standard one, require no value
  -h, --help             Print help
```


## Metadata
- **Skill**: generated
