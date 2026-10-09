# lyner CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| lyner_astype | PASS |  |
| lyner_autoencode | Failed | image problem: lyner calls tensorflow set_random_seed, which does not exist in tensorflow 2.0.0 of the image |
| lyner_center | PASS |  |
| lyner_changes | Failed | tool bug: needs lyner estimate first, which crashes with NameError (pandas is not imported in lyner/commands/stats.py) |
| lyner_cluster | PASS |  |
| lyner_cluster-agglomerative | PASS |  |
| lyner_cluster-from | PASS |  |
| lyner_cluster-hierarchical | PASS |  |
| lyner_compose | PASS |  |
| lyner_correlate | PASS |  |
| lyner_decompose | PASS |  |
| lyner_dendro | PASS | default components verified; --num-components 2-3 crashes with an IndexError (tool bug) |
| lyner_design | Failed | tool bug: lyner design gives samples the wrong labels (data stay in input column order) when the design file is not ordered by sorted class name |
| lyner_dist-graph | PASS |  |
| lyner_estimate | Failed | tool bug: lyner estimate crashes with NameError (pandas is not imported in lyner/commands/stats.py) |
| lyner_filter | PASS |  |
| lyner_frequent-sets | PASS |  |
| lyner_mmr | PASS |  |
| lyner_normalise | PASS | quantile, scale and unit methods verified; the deseq and identity methods crash (tool bug: DataFrame has no normalize) |
| lyner_pairwise-distances | PASS |  |
| lyner_plot | PASS | heatmap html written; the tool strips trailing letters h, t, m, l and dots from the output name before adding .html |
| lyner_read | PASS |  |
| lyner_read-annotation | PASS |  |
| lyner_reindex | PASS |  |
| lyner_seed | Failed | tool bug: lyner seed always crashes (seed() got multiple values for argument 'seed'); its tensorflow set_random_seed import also fails with tensorflow 2.0.0 |
| lyner_select | PASS |  |
| lyner_show | PASS |  |
| lyner_sort | PASS |  |
| lyner_sort-index | PASS |  |
| lyner_store | PASS |  |
| lyner_summarise | PASS |  |
| lyner_supplement | PASS |  |
| lyner_targets | PASS |  |
| lyner_threshold | PASS |  |
| lyner_transform | PASS |  |
| lyner_transpose | PASS |  |
| lyner_uncluster | Failed | tool bug: lyner uncluster crashes (TypeError) on the integer cluster labels made by cluster-hierarchical |

## lyner_astype

### Tool Description
Convert data to given type.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tedil/lyner
- **Stars**: N/A
### Original Help Text
```text
Usage: lyner astype [OPTIONS] TYPE

  Convert data to given type.

Options:
  --help  Show this message and exit.
```

## lyner_autoencode

### Tool Description
Build and train an autoencoder.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner autoencode [OPTIONS]

  Build and train an autoencoder.

Options:
  -l, --layer-config DICT
  -f, --from-file FILE
  -s, --store-model PATH
  --loss [kld|mae|mape|mse|msle|binary_crossentropy|categorical_crossentropy|categorical_hinge|cosine|cosine_proximity|hinge|logcosh|poisson|sparse_categorical_crossentropy|squared_hinge]
  -o, --optimiser [adadelta|adagrad|adam|adamax|nadam|rmsprop|sgd]
  -e, --epochs INTEGER
  -b, --batch-size INTEGER
  -s, --shuffle BOOLEAN
  -v, --validation-split FLOAT RANGE
  -w, --adjust-weights FLOAT
  -m, --mode [discard|nodes|weights]
  --help                          Show this message and exit.
```

## lyner_center

### Tool Description
Center features around their respective median or mean.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner center [OPTIONS]

  Center features around their respective median or mean.

Options:
  -m, --method [mean|median]
  --help                      Show this message and exit.
```

## lyner_changes

### Tool Description
Calculate differences between sample groups.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner changes [OPTIONS]

  Calculate differences between sample groups.

Options:
  -m, --mode [likelihood|cdf]
  --help                       Show this message and exit.
```

## lyner_cluster

### Tool Description
Clustering via k_mean / dbscan / mean_shift.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner cluster [OPTIONS]

  Clustering via k_mean / dbscan / mean_shift.

Options:
  -m, --method [dbscan|k_means|mean_shift]
  -n, --num-clusters INTEGER      The exact number of clusters to build.
  -c, --mode-config DICT
  --help                          Show this message and exit.
```

## lyner_cluster-agglomerative

### Tool Description
Agglomerative clustering.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner cluster-agglomerative [OPTIONS]

  Agglomerative clustering.

Options:
  -b, --by LIST                Any comma separated combination of: 'trend',
                               'mean', 'median', 'mad', 'var', 'ontology'.
                               Order is relevant.
  -l, --min-nclusters INTEGER  The minimum number of clusters to build. NOTE:
                               This option is mutually exclusive with:
                               [nclusters].
  -u, --max-nclusters INTEGER  The maximum number of clusters to build. NOTE:
                               This option is mutually exclusive with:
                               [nclusters].
  -n, --nclusters INTEGER      The exact number of clusters to build. NOTE:
                               This option is mutually exclusive with:
                               [max_nclusters, min_nclusters].
  --help                       Show this message and exit.
```

## lyner_cluster-from

### Tool Description
Use cluster indices from file.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner cluster-from [OPTIONS] FILE

  Use cluster indices from file.

Options:
  --help  Show this message and exit.
```

## lyner_cluster-hierarchical

### Tool Description
Hierarchical clustering

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner cluster-hierarchical [OPTIONS]

  Hierarchical clustering

Options:
  -m, --method [single|complete|average|weighted|centroid|median|ward]
  -d, --distance-metric [braycurtis|canberra|chebyshev|cityblock|correlation|cosine|dice|euclidean|hamming|jaccard|kulsinski|mahalanobis|matching|minkowski|rogerstanimoto|russellrao|seuclidean|sokalmichener|sokalsneath|sqeuclidean|yule]
  -c, --criterion [inconsistent|distance|maxclust|monocrit|maxclust_monocrit]
  -t, --threshold FLOAT
  --help                          Show this message and exit.
```

## lyner_compose

### Tool Description
'Inverse' of `decompose`. Assumes `decompose` has been executed already.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner compose [OPTIONS]

  'Inverse' of `decompose`. Assumes `decompose` has been executed already.

Options:
  --help  Show this message and exit.
```

## lyner_correlate

### Tool Description
Correlate features using either of pearson, kendall or spearman correlation.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner correlate [OPTIONS]

  Correlate features using either of pearson, kendall or spearman
  correlation.

Options:
  -m, --method [pearson|kendall|spearman]
  --help                          Show this message and exit.
```

## lyner_decompose

### Tool Description
Decomposition/dimensionality reduction (PCA, ICA, …)

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner decompose [OPTIONS]

  Decomposition/dimensionality reduction (PCA, ICA, …)

Options:
  -m, --mode [PCA|KPCA|NMF|BMF|TSNE|ICA]
  -d, --decode
  -n, --num-components INTEGER
  -c, --mode-config DICT
  --help                          Show this message and exit.
```

## lyner_dendro

### Tool Description
Build a dendrogram based on the results of chosen decomposition methods.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner dendro [OPTIONS]

  Build a dendrogram based on the results of chosen decomposition methods.

Options:
  -a, --axis INTEGER RANGE
  -m, --methods LIST
  --mode [consensus|each]
  -c, --num-components LIST
  -r, --num-runs INTEGER
  --help                     Show this message and exit.
```

## lyner_design

### Tool Description
Description of the experiment. Expects 2-column tsv (Sample, Class).

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner design [OPTIONS] DESIGN

  Description of the experiment. Expects 2-column tsv (Sample, Class).

Options:
  --help  Show this message and exit.
```

## lyner_dist-graph

### Tool Description
Build a threshold graph, presumes pairwise_distances.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner dist-graph [OPTIONS]

  Build a threshold graph, presumes pairwise_distances.

Options:
  -t, --threshold FLOAT
  -l, --layout [fruchterman_reingold|kamada_kawai]
  -c, --cliques
  --help                          Show this message and exit.
```

## lyner_estimate

### Tool Description
Fit the given distribution to each target(-cluster) and each (design-)group.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner estimate [OPTIONS]

  Fit the given distribution to each target(-cluster) and each
  (design-)group.

Options:
  -d, --distribution TEXT  May be any of ['negbinom', 'gamma', 'laisson', 't',
                           'norm', 'cauchy', 'lognorm'] as well as any
                           distribution in `scipy.stats.rv_continuous`.
  --help                   Show this message and exit.
```

## lyner_filter

### Tool Description
Filter data according to selected option.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner filter [OPTIONS]

  Filter data according to selected option.

Options:
  -s, --sum INTEGER               Drops rows with sum smaller than or equal to
                                  given value.
  -z, --zeros INTEGER             Drop rows with up to the given amount of
                                  zeros.
  -i, --identical                 Drop rows consisting of only one single
                                  value.
  -n, --negative                  Drop rows with negative entries.
  -e, --drop-na                   Drop rows with NA/nan/empty entries.
  -d, --drop-duplicates           Drop duplicate rows.
  -p, --prefix LIST
  --suffix LIST
  -v, --variance-relative FLOAT   Keep the top n% most variant rows, drop the
                                  rest.
  -k, --variance-absolute INTEGER
                                  Keep the top k most variant rows, drop the
                                  rest.
  --help                          Show this message and exit.
```

## lyner_frequent-sets

### Tool Description
Calculate frequent sets using the apriori algorithm. Assumes one-hot encoded matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner frequent-sets [OPTIONS]

  Calculate frequent sets using the apriori algorithm. Assumes one-hot
  encoded matrix.

Options:
  -l, --min-support FLOAT
  --help                   Show this message and exit.
```

## lyner_mmr

### Tool Description
Calculate columnwise differences (of order `order`)

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner mmr [OPTIONS]

  Calculate columnwise differences (of order `order`)

Options:
  -o, --order INTEGER
  --help               Show this message and exit.
```

## lyner_normalise

### Tool Description
Normalize data using one of the following methods: quantile, deseq, identity, scale, unit, tanh.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner normalise [OPTIONS] [[quantile|deseq|identity|scale|unit|tanh]]

  Normalize data using one of the following methods: quantile, deseq,
  identity, scale, unit, tanh.

Options:
  -a, --axis INTEGER RANGE
  --help                    Show this message and exit.
```

## lyner_pairwise-distances

### Tool Description
Calculate pairwise distances between rows of the data matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner pairwise-distances [OPTIONS]

  Calculate pairwise distances between rows of the data matrix.

Options:
  -m, --metric [braycurtis|canberra|chebyshev|cityblock|correlation|cosine|dice|euclidean|hamming|jaccard|jensenshannon|kulsinski|mahalanobis|matching|minkowski|rogerstanimoto|russellrao|seuclidean|sokalmichener|sokalsneath|sqeuclidean|yule]
  --help                          Show this message and exit.
```

## lyner_plot

### Tool Description
Visualize current selection in different ways, depending on context.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner plot [OPTIONS]

  Visualize current selection in different ways, depending on context.

Options:
  -o, --outfile FILE
  -d, --directory DIRECTORY
  --with-annotation
  --annotation-split FLOAT RANGE
  --colorscale [Greys|YlGnBu|Greens|YlOrRed|Bluered|RdBu|Reds|Blues|Picnic|Rainbow|Portland|Jet|Hot|Blackbody|Earth|Electric|Viridis|Cividis]
  -m, --mode LIST
  -c, --mode-config DICT
  -a, --auto-open
  --help                          Show this message and exit.
```

## lyner_read

### Tool Description
Read abundance/count matrix from `MATRIX` (tsv format).

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner read [OPTIONS] MATRIX

  Read abundance/count matrix from `MATRIX` (tsv format).

Options:
  --help  Show this message and exit.
```

## lyner_read-annotation

### Tool Description
Reads annotation from given file and stores it in `annotation`.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner read-annotation [OPTIONS] FILE

  Reads annotation from given file and stores it in `annotation`.

Options:
  --help  Show this message and exit.
```

## lyner_reindex

### Tool Description
Sort and reindex.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner reindex [OPTIONS]

  Sort and reindex.

Options:
  --help  Show this message and exit.
```

## lyner_seed

### Tool Description
Sets both numpy and tensorflow seed.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner seed [OPTIONS] SEED

  Sets both numpy and tensorflow seed.

Options:
  --help  Show this message and exit.
```

## lyner_select

### Tool Description
Select a datum based on its name (e.g. 'matrix' or 'estimate'), making it the target of commands such as `show`, `save` and `plot`.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner select [OPTIONS] WHAT

  Select a datum based on its name (e.g. 'matrix' or 'estimate'), making it
  the target of commands such as `show`, `save` and `plot`.

Options:
  --help  Show this message and exit.
```

## lyner_show

### Tool Description
Prints current selection to stdout, in tsv format.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner show [OPTIONS]

  Prints current selection to stdout, in tsv format.

Options:
  --help  Show this message and exit.
```

## lyner_sort

### Tool Description
Sort values by columns.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner sort [OPTIONS]

  Sort values by columns.

Options:
  --help  Show this message and exit.
```

## lyner_sort-index

### Tool Description
Sort index.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner sort-index [OPTIONS]

  Sort index.

Options:
  --help  Show this message and exit.
```

## lyner_store

### Tool Description
Save current selection in given file; in tsv format.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner store [OPTIONS] [OUT]

  Save current selection in given file; in tsv format.

Options:
  -m, --mode [csv|pickle|auto]
  --help                        Show this message and exit.
```

## lyner_summarise

### Tool Description
Calculate either of median/mean/min/max for each group.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner summarise [OPTIONS] [[median|mean|min|max]]

  Calculate either of median/mean/min/max for each group.

Options:
  --help  Show this message and exit.
```

## lyner_supplement

### Tool Description
Supply additional data which may be used for plot colors, for example.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner supplement [OPTIONS] SUPPLEMENTARY_DATA

  Supply additional data which may be used for plot colors, for example.

Options:
  --help  Show this message and exit.
```

## lyner_targets

### Tool Description
Include only/exclude all genes in the given file. One feature per line.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner targets [OPTIONS]

  Include only/exclude all genes in the given file. One feature per line.

Options:
  -t, --targets LIST
  -f, --from-file FILENAME
  -m, --mode [exclude|intersect]
  --help                          Show this message and exit.
```

## lyner_threshold

### Tool Description
Set |data| < value to 0, data >= value to 1, -data >= value to -1.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner threshold [OPTIONS] VALUE

  Set |data| < value to 0, data >= value to 1, -data >= value to -1.

Options:
  --help  Show this message and exit.
```

## lyner_transform

### Tool Description
Apply a transformation to the current selection.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner transform [OPTIONS] [[log2|log10|log|exp|log1p|expm1|transpose]]

  Apply a transformation to the current selection.

Options:
  --help  Show this message and exit.
```

## lyner_transpose

### Tool Description
Transpose current selection if it is a matrix

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner transpose [OPTIONS]

  Transpose current selection if it is a matrix

Options:
  --help  Show this message and exit.
```

## lyner_uncluster

### Tool Description
Remove grouping of samples/features into clusters.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner uncluster [OPTIONS]

  Remove grouping of samples/features into clusters.

Options:
  --help  Show this message and exit.
```

## Metadata
- **Skill**: generated
