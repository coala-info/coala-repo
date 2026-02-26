# quasildr CWL Generation Report

## quasildr_run_graphdr.py

### Tool Description
Run GraphDR.

### Metadata
- **Docker Image**: quay.io/biocontainers/quasildr:0.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/jzthree/quasildr
- **Package**: https://anaconda.org/channels/bioconda/packages/quasildr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/quasildr/overview
- **Total Downloads**: 5.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jzthree/quasildr
- **Stars**: N/A
### Original Help Text
```text
Run GraphDR.

Usage:
    run_graphdr <input_file> [--max_dim=<max_dim>] [--anno_file=<anno_file>] [--anno_column=<anno_column>] 
  [--n_neighbors=<n_neighbors>] [--reg=<reg>] [--refine_iter=<refine_iter>] 
  [--refine_threshold=<refine_threshold>] [--method=<method>] [--metric=<metric>] 
  [--no_rotation] [--rescale]  [--plot] [--pca|--lda]  [--log] [--transpose] [--scale] [--output=<output>] [--suffix=<suffix>]

Options:
  -h --help                                 Show this screen.
  --version                                 Show version.
  --max_dim=<max_dim>                       Number of input dims to use [default: 20]
  --anno_file=<anno_file>                   Annotation of categories used for plotting or use with `--lda`.
  --anno_column=<anno_column>               Name of the column to use in annotation file [default: group_id].
  --n_neighbors=<n_neighbors>               Number of neighbors to construct KNN graph [default: 10].
  --reg=<reg>                               Regularization parameter  [default: 100]
  --refine_iter=<refine_iter>               Refine iteration [default: 0].
  --refine_threshold=<refine_threshold>     Refine threshold [default: 12].
  --method=<method>                         Method [default: auto].
  --metric=<metric>                         Metric [default: euclidean].
  --no_rotation                             Run GraphDR with --no_rotation option.
  --rescale                                 Postprocess output by rescaling to match input mean and variance.
  --plot                                    Generate a pdf plot of the first two dims of the representation.
  --pca                                     Preprocess input with PCA.
  --lda                                     Preprocess input with LDA (using `anno_column` in `anno_file` as labels)
  --log                                     Preprocess input with log(1+X) transform.
  --transpose                               Preprocess input by transposing the matrix.
  --scale                                   Preprocess input by scaling to unit variance.
  --output=<output>                         Output file prefix, use input_file if not specified [default: ]
  --suffix=<suffix>                         Suffix append to output file name [default: ]
```


## quasildr_run_structdr.py

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/quasildr:0.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/jzthree/quasildr
- **Package**: https://anaconda.org/channels/bioconda/packages/quasildr/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/run_structdr.py", line 10, in <module>
    import networkx as nx
ModuleNotFoundError: No module named 'networkx'
```

