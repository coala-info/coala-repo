# lyner CWL Generation Report

## lyner_astype

### Tool Description
Convert data to a specified type.

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
Try "lyner astype --help" for help.

Error: no such option: --h  Did you mean --help?
```

## lyner_center

### Tool Description
Center the matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 66, in center
    data = getattr(pipe, pipe.selection, pipe.matrix)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: selection
```

## lyner_cluster

### Tool Description
Cluster cells based on their expression profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/cluster.py", line 36, in cluster
    centroids, labels, *_ = clustering(pipe.matrix.values, **mode_config)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```

## lyner_cluster-agglomerative

### Tool Description
Agglomerative clustering of cells

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/cluster.py", line 60, in cluster_agglomerative
    matrix = pipe.matrix
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```

## lyner_cluster-from

### Tool Description
Cluster sequences from a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner cluster-from [OPTIONS] FILE
Try "lyner cluster-from --help" for help.

Error: no such option: --h  Did you mean --help?
```

## lyner_cluster-hierarchical

### Tool Description
Hierarchical clustering of samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/cluster.py", line 110, in cluster_hierarchical
    l = linkage(pipe.matrix.values, method=method, metric=distance_metric)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```

## lyner_compose

### Tool Description
Compose a pipeline from a list of transformations.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 354, in compose
    assert hasattr(pipe, 'decomposition')
AssertionError
```

## lyner_correlate

### Tool Description
Calculate pairwise Pearson correlation coefficients between columns of a matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 79, in correlate
    pipe.matrix = pipe.matrix.corr(method=method)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```

## lyner_decompose

### Tool Description
Decompose a matrix into its constituent parts.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 91, in decompose
    matrix = pipe.matrix.copy()
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```

## lyner_dendro

### Tool Description
Plot a dendrogram from a distance matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/plot.py", line 44, in dendro
    matrix = pipe.matrix
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
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
Generates a distance graph from a distance matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/cluster.py", line 197, in dist_graph
    assert pipe.matrix.index.values.shape == pipe.matrix.columns.values.shape, "call pdist first"
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```

## lyner_estimate

### Tool Description
Estimate gene expression levels from RNA-Seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/stats.py", line 27, in estimate
    matrix = pipe.matrix
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
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
Find frequent itemsets in a binary matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/cluster.py", line 166, in frequent_sets
    df = pipe.matrix.astype(np.bool)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```

## lyner_pairwise-distances

### Tool Description
Compute pairwise distances between samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/cluster.py", line 183, in pairwise_distances
    d = squareform(pdist(pipe.matrix.values, metric=metric))
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```

## lyner_read

### Tool Description
Read abundance/count matrix from MATRIX (tsv format).

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
Reindex the matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 324, in reindex
    pipe.matrix = pipe.matrix.reindex(index=natsorted(pipe.matrix.index))
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```

## lyner_seed

### Tool Description
Try "lyner seed --help" for help.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner seed [OPTIONS] SEED
Try "lyner seed --help" for help.

Error: no such option: -h
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
Show the content of a lyner pipe.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/io.py", line 40, in show
    data = getattr(pipe, pipe.selection, pipe.matrix)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: selection
```

## lyner_sort

### Tool Description
Sorts the matrix by columns.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 308, in sort
    pipe.matrix.sort_values(by=pipe.matrix.columns.values.tolist(), axis=0, inplace=True)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```

## lyner_sort-index

### Tool Description
Sorts and indexes a matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 316, in sort_index
    pipe.matrix.sort_index(kind='mergesort', inplace=True)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```

## lyner_summarise

### Tool Description
Summarise a lyner matrix

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 371, in summarise
    m: pd.DataFrame = pipe.matrix
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
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
Specify targets for lyner

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/io.py", line 97, in targets
    raise ValueError("No targets specified.")
ValueError: No targets specified.
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

## lyner_transpose

### Tool Description
Transpose a matrix or a selection of columns from a matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 345, in transpose
    data = getattr(pipe, pipe.selection, pipe.matrix)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: selection
```

## lyner_uncluster

### Tool Description
Uncluster sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/cluster.py", line 238, in uncluster
    if pipe.is_clustered:
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: is_clustered
```

## Metadata
- **Skill**: generated
