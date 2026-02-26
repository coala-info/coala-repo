# sourcepredict CWL Generation Report

## sourcepredict

### Tool Description
Coprolite source classification

### Metadata
- **Docker Image**: quay.io/biocontainers/sourcepredict:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/maxibor/sourcepredict
- **Package**: https://anaconda.org/channels/bioconda/packages/sourcepredict/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sourcepredict/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/maxibor/sourcepredict
- **Stars**: N/A
### Original Help Text
```text
usage: SourcePredict v0.5.1 [-h] [-a ALPHA] [-s SOURCES] [-l LABELS]
                            [-n NORMALIZATION] [-dt DISTANCE] [-r TAX_RANK]
                            [-me METHOD] [-kne NEIGHBORS] [-kw WEIGHTS]
                            [-e EMBED] [-di DIM] [-o OUTPUT] [-se SEED]
                            [-k KFOLD] [-t THREADS]
                            sink_table

==========================================================
SourcePredict v0.5.1
Coprolite source classification
Author: Maxime Borry
Contact: <borry[at]shh.mpg.de>
Homepage & Documentation: github.com/maxibor/sourcepredict
==========================================================
        

positional arguments:
  sink_table        path to sink TAXID count table in csv format

options:
  -h, --help        show this help message and exit
  -a ALPHA          Proportion of sink sample in unknown. Default = 0.1
  -s SOURCES        Path to source csv file. Default =
                    data/modern_gut_microbiomes_sources.csv
  -l LABELS         Path to labels csv file. Default =
                    data/modern_gut_microbiomes_labels.csv
  -n NORMALIZATION  Normalization method (RLE | Subsample | GMPR | None).
                    Default = GMPR
  -dt DISTANCE      Distance method. (unweighted_unifrac | weighted_unifrac)
                    Default = weighted_unifrac
  -r TAX_RANK       Taxonomic rank to use for Unifrac distances. Default =
                    species
  -me METHOD        Embedding Method. TSNE, MDS, or UMAP. Default = TSNE
  -kne NEIGHBORS    Numbers of neigbors if KNN ML classication (integer or
                    'all'). Default = 0 (chosen by CV)
  -kw WEIGHTS       Sample weight function for KNN prediction (distance |
                    uniform). Default = distance.
  -e EMBED          Output embedding csv file. Default = None
  -di DIM           Number of dimensions to retain for dimension reduction.
                    Default = 2
  -o OUTPUT         Output file basename. Default =
                    <sample_basename>.sourcepredict.csv
  -se SEED          Seed for random generator. Default = 42
  -k KFOLD          Number of fold for K-fold cross validation in parameter
                    optimization. Default = 5
  -t THREADS        Number of threads for parallel processing. Default = 2
```

