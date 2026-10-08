# graphembed CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| graphembed_embedding_hope_precision | PASS |  |
| graphembed_embedding_hope_rank | PASS |  |
| graphembed_embedding_sketching | PASS |  |
| graphembed_validation_hope_precision | PASS |  |
| graphembed_validation_hope_rank | PASS |  |
| graphembed_validation_sketching | PASS |  |

## graphembed_embedding_sketching

### Tool Description
Graph/Network embedding by recursive sketching (NodeSketch).

### Metadata
- **Docker Image**: quay.io/biocontainers/graphembed:0.1.8--h2e3eeea_0
- **Homepage**: https://github.com/jean-pierreBoth/graphembed
- **Package**: https://anaconda.org/channels/bioconda/packages/graphembed/overview
- **Validation**: PASS

### Original Help Text
```text


Highly-Efficient Graph/Network Embeddings via Recursive Sketching

Usage: graphembed embedding sketching --dim <dimension> --decay <decay> --nbiter <nbiter>

Options:
  -d, --dim <dimension>  the embedding dimension
      --decay <decay>    decay coefficient
      --nbiter <nbiter>  number of loops around a node 
  -h, --help             Print help
```

## graphembed_embedding_hope_precision

### Tool Description
Asymmetric transitivity preserving graph embedding (HOPE) with a precision target.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphembed:0.1.8--h2e3eeea_0
- **Homepage**: https://github.com/jean-pierreBoth/graphembed
- **Package**: https://anaconda.org/channels/bioconda/packages/graphembed/overview
- **Validation**: PASS

### Original Help Text
```text


Usage: graphembed embedding hope precision --epsil <epsil> --maxrank <maxrank> --blockiter <blockiter>

Options:
      --epsil <epsil>          precision between 0. and 1.
      --maxrank <maxrank>      maximum rank expected
      --blockiter <blockiter>  integer between 2 and 5
  -h, --help                   Print help
```

## graphembed_embedding_hope_rank

### Tool Description
Asymmetric transitivity preserving graph embedding (HOPE) with a target rank.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphembed:0.1.8--h2e3eeea_0
- **Homepage**: https://github.com/jean-pierreBoth/graphembed
- **Package**: https://anaconda.org/channels/bioconda/packages/graphembed/overview
- **Validation**: PASS

### Original Help Text
```text


Usage: graphembed embedding hope rank --targetrank <targetrank> --nbiter <nbiter>

Options:
      --targetrank <targetrank>  rank expected
      --nbiter <nbiter>          integer between 2 and 5
  -h, --help                     Print help
```

## graphembed_validation_sketching

### Tool Description
Graph/Network embedding by recursive sketching with link-prediction accuracy benchmark.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphembed:0.1.8--h2e3eeea_0
- **Homepage**: https://github.com/jean-pierreBoth/graphembed
- **Package**: https://anaconda.org/channels/bioconda/packages/graphembed/overview
- **Validation**: PASS

### Original Help Text
```text


Highly-Efficient Graph/Network Embeddings via Recursive Sketching

Usage: graphembed validation --nbpass <nbpass> --skip <skip> sketching --dim <dimension> --decay <decay> --nbiter <nbiter>

Options:
  -d, --dim <dimension>  the embedding dimension
      --decay <decay>    decay coefficient
      --nbiter <nbiter>  number of loops around a node 
  -h, --help             Print help
```

## graphembed_validation_hope_precision

### Tool Description
HOPE graph embedding (precision target) with link-prediction accuracy benchmark.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphembed:0.1.8--h2e3eeea_0
- **Homepage**: https://github.com/jean-pierreBoth/graphembed
- **Package**: https://anaconda.org/channels/bioconda/packages/graphembed/overview
- **Validation**: PASS

### Original Help Text
```text


Usage: graphembed validation hope precision --epsil <epsil> --maxrank <maxrank> --blockiter <blockiter>

Options:
      --epsil <epsil>          precision between 0. and 1.
      --maxrank <maxrank>      maximum rank expected
      --blockiter <blockiter>  integer between 2 and 5
  -h, --help                   Print help
```

## graphembed_validation_hope_rank

### Tool Description
HOPE graph embedding (target rank) with link-prediction accuracy benchmark.

### Metadata
- **Docker Image**: quay.io/biocontainers/graphembed:0.1.8--h2e3eeea_0
- **Homepage**: https://github.com/jean-pierreBoth/graphembed
- **Package**: https://anaconda.org/channels/bioconda/packages/graphembed/overview
- **Validation**: PASS

### Original Help Text
```text


Usage: graphembed validation hope rank --targetrank <targetrank> --nbiter <nbiter>

Options:
      --targetrank <targetrank>  rank expected
      --nbiter <nbiter>          integer between 2 and 5
  -h, --help                     Print help
```

## Metadata
- **Skill**: generated
