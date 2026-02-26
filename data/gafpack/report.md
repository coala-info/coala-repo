# gafpack CWL Generation Report

## gafpack

### Tool Description
Project a GAF alignment file into coverage over GFA graph nodes

### Metadata
- **Docker Image**: quay.io/biocontainers/gafpack:0.1.3--h4349ce8_0
- **Homepage**: https://github.com/pangenome/gafpack
- **Package**: https://anaconda.org/channels/bioconda/packages/gafpack/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gafpack/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2025-06-24
- **GitHub**: https://github.com/pangenome/gafpack
- **Stars**: N/A
### Original Help Text
```text
Project a GAF alignment file into coverage over GFA graph nodes

Usage: gafpack [OPTIONS] --gfa <GFA> --gaf <GAF>

Options:
      --gfa <GFA>        Input GFA pangenome graph file (supports .gz/.bgz compression)
  -g, --gaf <GAF>        Input GAF alignment file
  -l, --len-scale        Scale coverage values by node length
  -c, --coverage-column  Emit graph coverage vector in a single column
  -w, --weight-queries   Weight coverage by query group occurrences
  -h, --help             Print help
  -V, --version          Print version
```

