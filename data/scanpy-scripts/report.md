# scanpy-scripts CWL Generation Report

## scanpy-scripts_scanpy-cli

### Tool Description
Command line interface to [scanpy](https://github.com/theislab/scanpy)

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Total Downloads**: 232.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Stars**: N/A
### Original Help Text
```text
Usage: scanpy-cli [OPTIONS] COMMAND [ARGS]...

  Command line interface to [scanpy](https://github.com/theislab/scanpy)

Options:
  --debug              Print debug information
  --verbosity INTEGER  Set scanpy verbosity
  --version            Show the version and exit.
  --help               Show this message and exit.

Commands:
  read       Read 10x data and save in specified format.
  filter     Filter data based on specified conditions.
  norm       Normalise data per cell.
  hvg        Find highly variable genes.
  scale      Scale data per gene.
  regress    Regress-out observation variables.
  pca        Dimensionality reduction by PCA.
  neighbor   Compute a neighbourhood graph of observations.
  embed      Embed cells into two-dimensional space.
  cluster    Cluster cells into sub-populations.
  diffexp    Find markers for each clusters.
  paga       Trajectory inference by abstract graph analysis.
  dpt        Calculate diffusion pseudotime relative to the root cells.
  integrate  Integrate cells from different experimental batches.
  multiplet  Execute methods for multiplet removal.
  plot       Visualise data.
```

