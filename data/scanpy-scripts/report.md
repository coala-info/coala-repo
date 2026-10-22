# scanpy-scripts CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| scanpy-scripts_scanpy-cli_cluster_leiden | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_diffexp | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_embed_umap | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_filter | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_hvg | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_neighbor | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_norm | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_pca | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_plot_embed | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_read | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_scale | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |

## scanpy-scripts_scanpy-cli_read

### Tool Description
Read 10x data and save in specified format.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli read [OPTIONS] <output_obj>

  Read 10x data and save in specified format.

  <output_obj>:  output file in format specfied by --output-format

Options:
  -i, --input-10x-h5 FILE         Input 10x data in Cell-Ranger hdf5 format.
  -x, --input-10x-mtx DIRECTORY   Path of input folder containing 10x data in
                                  mtx format.

  -F, --output-format [anndata|loom|zarr]
                                  Output object format.  [default: anndata]
  -z, --zarr-chunk-size INTEGER   Chunk size for writing output in zarr
                                  format.  [default: 1000]

  -b, --loom-write-obsm-varm      Write obsm and varm to the Loom file?
                                  [default: False]

  -X, --export-mtx PATH           When specified, using it as prefix for
                                  exporting mtx files. If not empty and not
                                  ending with "/" or "_", a "_" will be
                                  appended.

  -G, --mtx-compression [zip|gzip|bz2|zstd]
                                  Compression type for MTX output.
  --show-obj [stdout|stderr]      Print output object summary info to
                                  specified stream.

  -g, --genome TEXT               Name of the genome group in hdf5 file,
                                  required by "--input-10x-h5".  [default:
                                  hg19]

  -v, --var-names [gene_symbols|gene_ids]
                                  Attribute to be used as the index of the
                                  variable table, required by "--
                                  input-10x-mtx".  [default: gene_symbols]

  --extra-obs FILE                Extra cell metadata table, must be tab-
                                  separated with a header row and an index
                                  column, and with matched dimension.

  --extra-var FILE                Extra gene metadata table, must be tab-
                                  separated with a header row and an index
                                  column, and with matched dimension.

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_filter

### Tool Description
Filter data based on specified conditions.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli filter [OPTIONS] <input_obj> <output_obj>

  Filter data based on specified conditions.

  <input_obj>:   input file in format specfied by --input-format
  <output_obj>:  output file in format specfied by --output-format

Options:
  -f, --input-format [anndata|loom]
                                  Input object format.  [default: anndata]
  -F, --output-format [anndata|loom|zarr]
                                  Output object format.  [default: anndata]
  -z, --zarr-chunk-size INTEGER   Chunk size for writing output in zarr
                                  format.  [default: 1000]

  -b, --loom-write-obsm-varm      Write obsm and varm to the Loom file?
                                  [default: False]

  -X, --export-mtx PATH           When specified, using it as prefix for
                                  exporting mtx files. If not empty and not
                                  ending with "/" or "_", a "_" will be
                                  appended.

  -G, --mtx-compression [zip|gzip|bz2|zstd]
                                  Compression type for MTX output.
  --show-obj [stdout|stderr]      Print output object summary info to
                                  specified stream.

  -r, --save-raw                  Save adata to adata.raw before processing.
                                  [default: False]

  -g, --gene-name TEXT            Name of the variable that contains gene
                                  names, used for flagging mitochondria genes
                                  when column "mito" is absent from `.var`.
                                  [default: index]

  -l, --list-attr                 When set, list attributes that can be
                                  filtered on.

  -p, --param <TEXT FLOAT FLOAT>...
                                  Numerical parameters used to filter the
                                  data, in the format of "-p name min max".
                                  Multiple -p entries allowed.

  -c, --category <TEXT TEXT[,TEXT...]>...
                                  Categorical attributes used to filter the
                                  data, in the format of "-c <name> <values>",
                                  where entries with attribute <name> with
                                  value in <values> are kept. If <values> is
                                  preceded by "!", entries with value in
                                  <values> are removed. Multiple -c entries
                                  allowed.

  -s, --subset <TEXT FILENAME>...
                                  Similar to --category in the format of "-s
                                  <name> <file>", but the <file> to be a one-
                                  column table that provides the values.
                                  Multiple -s entries allowed.

  --force-recalc                  When set, re-calculate
                                  `pct_counts_<qc_variable>` and
                                  `pct_counts_in_top_<n>_genes` even if they
                                  exist.

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_norm

### Tool Description
Normalise data per cell.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli norm [OPTIONS] <input_obj> <output_obj>

  Normalise data per cell.

  <input_obj>:   input file in format specfied by --input-format
  <output_obj>:  output file in format specfied by --output-format

Options:
  -f, --input-format [anndata|loom]
                                  Input object format.  [default: anndata]
  -F, --output-format [anndata|loom|zarr]
                                  Output object format.  [default: anndata]
  -z, --zarr-chunk-size INTEGER   Chunk size for writing output in zarr
                                  format.  [default: 1000]

  -b, --loom-write-obsm-varm      Write obsm and varm to the Loom file?
                                  [default: False]

  -X, --export-mtx PATH           When specified, using it as prefix for
                                  exporting mtx files. If not empty and not
                                  ending with "/" or "_", a "_" will be
                                  appended.

  -G, --mtx-compression [zip|gzip|bz2|zstd]
                                  Compression type for MTX output.
  --show-obj [stdout|stderr]      Print output object summary info to
                                  specified stream.

  -r, --save-raw                  Save adata to adata.raw before processing.
                                  [default: False]

  -y, --save-layer TEXT           Save adata.X to the specified layer before
                                  processing.

  --key-added TEXT[,TEXT...]      Key under which to add the computed results
  --no-log-transform              When set, do not apply (natural) log
                                  transform following normalisation.
                                  [default: True]

  -t, --normalize-to FLOAT        Normalize per cell nUMI to this number.
                                  [default: 10000]

  -e, --exclude-highly-expressed  Exclude (very) highly expressed genes for
                                  the computation of the normalization factor
                                  (size factor) for each cell. A gene is
                                  considered highly expressed, if it has more
                                  than max_fraction of the total counts in at
                                  least one cell. The not-excluded genes will
                                  sum up to the number specified by
                                  --normalize-to.  [default: False]

  -m, --max-fraction FLOAT        If exclude_highly_expressed=True, consider
                                  cells as highly expressed that have more
                                  counts than max_fraction of the original
                                  total counts in at least one cell.
                                  [default: 0.05]

  -l, --layers TEXT[,TEXT...]     List of layers to normalize. Set to 'all' to
                                  normalize all layers.

  -n, --layer-norm [after|X]      Specifies how to normalize layers: 1) If
                                  None, after normalization, for each layer in
                                  layers each cell has a total count equal to
                                  the median of the counts_per_cell before
                                  normalization of the layer. 2) If 'after',
                                  for each layer in layers each cell has a
                                  total count equal to target_sum. 3) If 'X',
                                  for each layer in layers each cell has a
                                  total count equal to the median of total
                                  counts for observations (cells) of adata.X
                                  before normalization.'

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_hvg

### Tool Description
Find highly variable genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli hvg [OPTIONS] <input_obj> <output_obj>

  Find highly variable genes.

  <input_obj>:   input file in format specfied by --input-format
  <output_obj>:  output file in format specfied by --output-format

Options:
  -f, --input-format [anndata|loom]
                                  Input object format.  [default: anndata]
  -F, --output-format [anndata|loom|zarr]
                                  Output object format.  [default: anndata]
  -z, --zarr-chunk-size INTEGER   Chunk size for writing output in zarr
                                  format.  [default: 1000]

  -b, --loom-write-obsm-varm      Write obsm and varm to the Loom file?
                                  [default: False]

  -X, --export-mtx PATH           When specified, using it as prefix for
                                  exporting mtx files. If not empty and not
                                  ending with "/" or "_", a "_" will be
                                  appended.

  -G, --mtx-compression [zip|gzip|bz2|zstd]
                                  Compression type for MTX output.
  --show-obj [stdout|stderr]      Print output object summary info to
                                  specified stream.

  -m, --mean-limits <FLOAT FLOAT>...
                                  Cutoffs for the mean of expressionin the
                                  format of "-m min max".  [default: 0.0125,
                                  3]

  -d, --disp-limits <FLOAT FLOAT>...
                                  Cutoffs for the dispersion of expressionin
                                  the format of "-d min max".  [default: 0.5,
                                  inf]

  --span FLOAT                    The fraction of the data (cells) used when
                                  estimating the variance in the loess model
                                  fit if flavor='seurat_v3'.  [default: 0.3]

  -b, --n-bins INTEGER            Number of bins for binning the mean gene
                                  expression.  [default: 20]

  -t, --n-top-genes INTEGER       Number of highly-variable genes to keep.
  -v, --flavor [seurat|cell_ranger|seurat_v3]
                                  Choose the flavor for computing normalized
                                  dispersion.  [default: seurat]

  -s, --subset                    When set, inplace subset to highly-variable
                                  genes, otherwise only flag highly-variable
                                  genes.

  --batch-key TEXT                If specified, highly-variable genes are
                                  selected within each batch separately and
                                  merged. This simple process avoids the
                                  selection of batch-specific genes and acts
                                  as a lightweight batch correction method.
                                  For all flavors, genes are first sorted by
                                  how many batches they are a HVG. For
                                  dispersion-based flavors ties are broken by
                                  normalized dispersion. If flavor =
                                  'seurat_v3', ties are broken by the median
                                  (across batches) rank based on within-batch
                                  normalized variance.

  --always-hv-genes-file PATH     If specified, the gene identifers in this
                                  file will be set as highly variable in the
                                  var dataframe after HVGs are computed.

  --never-hv-genes-file PATH      If specified, the gene identifers in this
                                  file will be removed from highly variable in
                                  the var dataframe (set to false) after HVGs
                                  are computed.

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_scale

### Tool Description
Scale data per gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli scale [OPTIONS] <input_obj> <output_obj>

  Scale data per gene.

  <input_obj>:   input file in format specfied by --input-format
  <output_obj>:  output file in format specfied by --output-format

Options:
  -f, --input-format [anndata|loom]
                                  Input object format.  [default: anndata]
  -F, --output-format [anndata|loom|zarr]
                                  Output object format.  [default: anndata]
  -z, --zarr-chunk-size INTEGER   Chunk size for writing output in zarr
                                  format.  [default: 1000]

  -b, --loom-write-obsm-varm      Write obsm and varm to the Loom file?
                                  [default: False]

  -X, --export-mtx PATH           When specified, using it as prefix for
                                  exporting mtx files. If not empty and not
                                  ending with "/" or "_", a "_" will be
                                  appended.

  -G, --mtx-compression [zip|gzip|bz2|zstd]
                                  Compression type for MTX output.
  --show-obj [stdout|stderr]      Print output object summary info to
                                  specified stream.

  -r, --save-raw                  Save adata to adata.raw before processing.
                                  [default: False]

  -y, --save-layer TEXT           Save adata.X to the specified layer before
                                  processing.

  --no-zero-center                When set, omit zero-centering variables to
                                  allow efficient handling of sparse input.

  -m, --max-value FLOAT           When specified, clip to this value after
                                  scaling, otherwise do not clip

  -l, --layer TEXT[,TEXT...]      If provided, which element of layers to
                                  scale.

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_pca

### Tool Description
Dimensionality reduction by PCA.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli pca [OPTIONS] <input_obj> <output_obj>

  Dimensionality reduction by PCA.

  <input_obj>:   input file in format specfied by --input-format
  <output_obj>:  output file in format specfied by --output-format

Options:
  -f, --input-format [anndata|loom]
                                  Input object format.  [default: anndata]
  -F, --output-format [anndata|loom|zarr]
                                  Output object format.  [default: anndata]
  -z, --zarr-chunk-size INTEGER   Chunk size for writing output in zarr
                                  format.  [default: 1000]

  -b, --loom-write-obsm-varm      Write obsm and varm to the Loom file?
                                  [default: False]

  -X, --export-mtx PATH           When specified, using it as prefix for
                                  exporting mtx files. If not empty and not
                                  ending with "/" or "_", a "_" will be
                                  appended.

  -G, --mtx-compression [zip|gzip|bz2|zstd]
                                  Compression type for MTX output.
  --show-obj [stdout|stderr]      Print output object summary info to
                                  specified stream.

  --no-zero-center                When set, omit zero-centering variables to
                                  allow efficient handling of sparse input.

  -S, --random-state INTEGER      Seed for random number generator.  [default:
                                  0]

  -E, --export-embedding FILE     Export embeddings in a tab-separated text
                                  table.

  --n-comps INTEGER               Number of components to compute
  -V, --svd-solver [auto|arpack|randomized]
                                  SVD solver to use.  [default: auto]
  -a, --use-all                   When set, use all genes for PCA, otherwise
                                  use highly-variable genes by default.

  -K, --chunked                   When set, perform an incremental PCA on
                                  segments of --chunk-size, which
                                  automatically zero centers and ignore
                                  settings of --random-state and --svd-solver.

  -Z, --chunk-size INTEGER        Number of observations to include in each
                                  chunk, required by --chunked.

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_neighbor

### Tool Description
Compute a neighbourhood graph of observations.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli neighbor [OPTIONS] <input_obj> <output_obj>

  Compute a neighbourhood graph of observations.

  <input_obj>:   input file in format specfied by --input-format
  <output_obj>:  output file in format specfied by --output-format

Options:
  -f, --input-format [anndata|loom]
                                  Input object format.  [default: anndata]
  -F, --output-format [anndata|loom|zarr]
                                  Output object format.  [default: anndata]
  -z, --zarr-chunk-size INTEGER   Chunk size for writing output in zarr
                                  format.  [default: 1000]

  -b, --loom-write-obsm-varm      Write obsm and varm to the Loom file?
                                  [default: False]

  -X, --export-mtx PATH           When specified, using it as prefix for
                                  exporting mtx files. If not empty and not
                                  ending with "/" or "_", a "_" will be
                                  appended.

  -G, --mtx-compression [zip|gzip|bz2|zstd]
                                  Compression type for MTX output.
  --show-obj [stdout|stderr]      Print output object summary info to
                                  specified stream.

  -n, --n-pcs INTEGER             Use this many PCs. Use `.X` if --n-pcs is 0
                                  when --use-rep is None.

  -u, --use-rep TEXT              Use the indicated representation. If None,
                                  the representation is chosen automatically:
                                  for `.n_vars` < 50, `.X` is used, otherwise
                                  `X_pca` is used. If `X_pca` is not present,
                                  it's computed with default parameters.

  --key-added TEXT[,TEXT...]      Key under which to add the computed results
  -S, --random-state INTEGER      Seed for random number generator.  [default:
                                  0]

  -k, --n-neighbors INTEGER[,INTEGER...]
                                  The size of local neighborhood (in terms of
                                  number of neighboring data points) used for
                                  manifold approximation. Larger values result
                                  in more global views of the manifold, while
                                  smaller values result in more local data
                                  being preserved. In general values should be
                                  in the range 2 to 100.  If --knn is set,
                                  number of nearest neighbors to be searched,
                                  othwise a Gaussian kernel width is set to
                                  the distance of the --n-neighbors neighbor.
                                  [default: 15]

  --no-knn                        When NOT set, use a hard threshold to
                                  restrict the number of neighbors to
                                  --n-neighbors. Otherwise, use a Gaussian
                                  kernel to assign low weights to neighbors
                                  more distant than the --n-neighbors nearest
                                  neighbor  [default: True]

  -m, --method [umap|gauss|rapids]
                                  Use umap or gauss with adaptive width for
                                  computing connectivities. Use rapids for the
                                  RAPIDS implementation of UMAP (experimental,
                                  GPU only).  [default: umap]

  -t, --metric [cityblock|cosine|euclidean|l1|l2|manhattan|braycurtis|canberra|chebyshev|correlation|dice|hamming|jaccard|kulsinski|mahalanobis|minkowski|rogerstanimoto|russellrao|seuclidean|sokalmichener|sokalsneath|sqeuclidean|yule]
                                  A known metric’s name.  [default: euclidean]
  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_diffexp

### Tool Description
Find markers for each clusters.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli diffexp [OPTIONS] <input_obj> <output_obj>

  Find markers for each clusters.

  <input_obj>:   input file in format specfied by --input-format
  <output_obj>:  output file in format specfied by --output-format

Options:
  -f, --input-format [anndata|loom]
                                  Input object format.  [default: anndata]
  -F, --output-format [anndata|loom|zarr]
                                  Output object format.  [default: anndata]
  -z, --zarr-chunk-size INTEGER   Chunk size for writing output in zarr
                                  format.  [default: 1000]

  -b, --loom-write-obsm-varm      Write obsm and varm to the Loom file?
                                  [default: False]

  -X, --export-mtx PATH           When specified, using it as prefix for
                                  exporting mtx files. If not empty and not
                                  ending with "/" or "_", a "_" will be
                                  appended.

  -G, --mtx-compression [zip|gzip|bz2|zstd]
                                  Compression type for MTX output.
  --show-obj [stdout|stderr]      Print output object summary info to
                                  specified stream.

  --use-raw / --no-raw            Use expression values in `.raw` if present.
  --key-added TEXT[,TEXT...]      Key under which to add the computed results
  -l, --layer TEXT                Key from adata.layers whose value will be
                                  used to perform tests on.

  -g, --groupby TEXT              The key of the observations grouping to
                                  consider.  [required]

  --groups TEXT[,TEXT...]         Subset of groups to which comparison shall
                                  be restricted.  [default: all]

  --reference TEXT                If "rest", compare each group to the union
                                  of the rest of the groups. If a group
                                  identifier, compare with respect to this
                                  group.  [default: rest]

  -n, --n-genes INTEGER           The number of genes that appear in the
                                  retured tables. By default return all
                                  available genes depending on the value of
                                  --use-raw.

  --method [logreg|t-test|wilcoxon|t-test_overestim_var]
                                  Method of performing differential expression
                                  analysis.  [default: t-test_overestim_var]

  --corr-method [benjamini-hochberg|bonferroni]
                                  P-value correction method. Used only for
                                  "t-test", "t-test_overestim_var" and
                                  "wilcoxon".  [default: benjamini-hochberg]

  --rankby-abs                    Rank genes by the absolute value of the
                                  score, not by the score. The returned scores
                                  are never the absolute values.  [default:
                                  False]

  --pts                           Compute the fraction of cells expressing the
                                  genes.  [default: False]

  --tie-correct                   Use tie correction for 'wilcoxon' scores.
                                  Used only for 'wilcoxon'.  [default: False]

  --filter-params TEXT:VAL[,TEXT:VAL...]
                                  Parameters for filtering DE results, valid
                                  parameters are: "min_in_group_fraction"
                                  (float), "max_out_group_fraction" (float),
                                  "min_fold_change" (float).

  --logreg-param TEXT:VAL[,TEXT:VAL...]
                                  Parameters passed to
                                  `sklearn.linear_model.LogisticRegression`.

  --save FILE                     Tab-separated table to store results of
                                  differential expression analysis.

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_embed_umap

### Tool Description
Embed the neighborhood graph using UMAP.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli embed umap [OPTIONS] <input_obj> <output_obj>

  Embed the neighborhood graph using UMAP.

  <input_obj>:   input file in format specfied by --input-format
  <output_obj>:  output file in format specfied by --output-format

Options:
  -f, --input-format [anndata|loom]
                                  Input object format.  [default: anndata]
  -F, --output-format [anndata|loom|zarr]
                                  Output object format.  [default: anndata]
  -z, --zarr-chunk-size INTEGER   Chunk size for writing output in zarr
                                  format.  [default: 1000]

  -b, --loom-write-obsm-varm      Write obsm and varm to the Loom file?
                                  [default: False]

  -X, --export-mtx PATH           When specified, using it as prefix for
                                  exporting mtx files. If not empty and not
                                  ending with "/" or "_", a "_" will be
                                  appended.

  -G, --mtx-compression [zip|gzip|bz2|zstd]
                                  Compression type for MTX output.
  --show-obj [stdout|stderr]      Print output object summary info to
                                  specified stream.

  --neighbors-key TEXT            If not specified, look in .uns[‘neighbors’]
                                  for neighbors settings and
                                  .obsp[‘connectivities’], .obsp[‘distances’]
                                  for connectivities and distances
                                  respectively (default storage places for
                                  pp.neighbors). If specified, look in
                                  .uns[neighbors_key] for neighbors settings
                                  and .obsp[.uns[neighbors_key][‘connectivitie
                                  s_key’]],
                                  .obsp[.uns[neighbors_key][‘distances_key’]]
                                  for connectivities and distances
                                  respectively.

  -S, --random-state INTEGER      Seed for random number generator.  [default:
                                  0]

  --key-added TEXT[,TEXT...]      Key under which to add the computed results
  -E, --export-embedding FILE     Export embeddings in a tab-separated text
                                  table.

  --init-pos TEXT                 How to initialize the low dimensional
                                  embedding. Can be "spectral", "paga" or
                                  "random", or any key of `.obsm`.  [default:
                                  spectral]

  --min-dist FLOAT                The effective minimum distance between
                                  embedded points. Smaller values will result
                                  in a more clustered embedding, while larger
                                  values will results in a more even dispersal
                                  of points.  [default: 0.5]

  --spread FLOAT                  The effective scale of embedded points,
                                  which determines the scale at which embedded
                                  points will be spread out.  [default: 1.0]

  --n-components INTEGER          The number of dimensions of the embedding.
                                  [default: 2]

  --maxiter INTEGER               The number of iterations of the
                                  optimization.

  --alpha FLOAT                   The initial learning rate for the embedding
                                  optimization.  [default: 1.0]

  --gamma FLOAT                   Weighting applied to negative samples in low
                                  dimensional embedding optimization.
                                  [default: 1.0]

  --negative-sample-rate INTEGER  The number of negative edge samples to use
                                  per positive edge sample in optimizing the
                                  low dimensional embedding.  [default: 5]

  --method [umap|rapids]          Use the original ‘umap’ implementation, or
                                  ‘rapids’ (experimental, GPU only).
                                  [default: umap]

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_cluster_leiden

### Tool Description
Find clusters by Leiden algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli cluster leiden [OPTIONS] <input_obj> <output_obj>

  Find clusters by Leiden algorithm.

  <input_obj>:   input file in format specfied by --input-format
  <output_obj>:  output file in format specfied by --output-format

Options:
  -f, --input-format [anndata|loom]
                                  Input object format.  [default: anndata]
  -F, --output-format [anndata|loom|zarr]
                                  Output object format.  [default: anndata]
  -z, --zarr-chunk-size INTEGER   Chunk size for writing output in zarr
                                  format.  [default: 1000]

  -b, --loom-write-obsm-varm      Write obsm and varm to the Loom file?
                                  [default: False]

  -X, --export-mtx PATH           When specified, using it as prefix for
                                  exporting mtx files. If not empty and not
                                  ending with "/" or "_", a "_" will be
                                  appended.

  -G, --mtx-compression [zip|gzip|bz2|zstd]
                                  Compression type for MTX output.
  --show-obj [stdout|stderr]      Print output object summary info to
                                  specified stream.

  --export-cluster FILE           Export embeddings in a tab-separated text
                                  table.

  --neighbors-key TEXT            If not specified, look in .uns[‘neighbors’]
                                  for neighbors settings and
                                  .obsp[‘connectivities’], .obsp[‘distances’]
                                  for connectivities and distances
                                  respectively (default storage places for
                                  pp.neighbors). If specified, look in
                                  .uns[neighbors_key] for neighbors settings
                                  and .obsp[.uns[neighbors_key][‘connectivitie
                                  s_key’]],
                                  .obsp[.uns[neighbors_key][‘distances_key’]]
                                  for connectivities and distances
                                  respectively.

  --obsp TEXT                     Use .obsp[obsp] as adjacency. You can’t
                                  specify both obsp and neighbors_key at the
                                  same time.

  --directed / --undirected       Interpret the adjacency matrix as directed
                                  graph.  [default: True]

  --use-weights                   Use weights from KNN graph.  [default:
                                  False]

  --restrict-to <TEXT TEXT[,TEXT...]>...
                                  Restrict the clustering to the categories
                                  within the key for sample annotation, in the
                                  form of "obs_key list_of_categories".
                                  [default: None, None]

  -S, --random-state INTEGER      Seed for random number generator.  [default:
                                  0]

  --key-added TEXT[,TEXT...]      Key under which to add the computed results
  -r, --resolution FLOAT[,FLOAT...]
                                  A parameter value controlling the coarseness
                                  of the clustering. Higher values lead to
                                  more clusters. Set to "None" if overriding
                                  --partition_type to one that doesn't accept
                                  `resolution_parameter`.  [default: 1]

  --n-iterations INTEGER          How many iterations of the Leiden clustering
                                  algorithm to perform. -1 has the algorithm
                                  run until it reaches its optimal clustering.
                                  [default: -1]

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_plot_embed

### Tool Description
Plot cell embeddings.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli plot embed [OPTIONS] <input_obj> <output_fig>

  Plot cell embeddings.

  <input_obj>:   input file in format specfied by --input-format
  <output_fig>:  output figure in pdf or png format

Options:
  -f, --input-format [anndata|loom]
                                  Input object format.  [default: anndata]
  --fig-size INTEGER,INTEGER      Figure size.  [default: 7,7]
  --fig-dpi INTEGER               Figure DPI.  [default: 80]
  --fig-fontsize INTEGER          Figure font size.  [default: 15]
  --frameon / --frameoff          Draw a frame around the plot  [default:
                                  True]

  --title TEXT[,TEXT...]          Provide title for the plot or panels.
  --layer TEXT[,TEXT...]          Name of the AnnData object layer that wants
                                  to be plotted. By default adata.raw.X is
                                  plotted. If use_raw=False is set, then
                                  adata.X is plotted. If layer is set to a
                                  valid layer name, then the layer is plotted.
                                  layer takes precedence over use_raw.

  --basis TEXT                    Name of the embedding to plot, must be a key
                                  of `.obsm` without the prefix "X_".
                                  [default: umap]

  --color TEXT[,TEXT...]          Keys for annotations of observations/cells
                                  or variables/genes.

  --legend-loc [right margin|on data]
                                  Location of legend, either "on data", "right
                                  margin" or valid keywords for
                                  `matplotlib.legend`.  [default: right
                                  margin]

  --legend-fontsize INTEGER       Legend font size.  [default: 15]
  --size FLOAT                    Point size. Automatically computed if not
                                  specified.

  --gene-symbols TEXT[,TEXT...]   Column name in .var DataFrame that stores
                                  gene symbols. By default this is assumed to
                                  be the index column of the .var DataFrame.
                                  Setting this option allows alternative names
                                  to be used.

  --edges                         Show edges.  [default: False]
  --edges-width FLOAT             Width of edges.  [default: 0.1]
  --edges-color TEXT              Color of edges. See draw_networkx_edges().
  --neighbors-key TEXT            If not specified, look in .uns[‘neighbors’]
                                  for neighbors settings and
                                  .obsp[‘connectivities’], .obsp[‘distances’]
                                  for connectivities and distances
                                  respectively (default storage places for
                                  pp.neighbors). If specified, look in
                                  .uns[neighbors_key] for neighbors settings
                                  and .obsp[.uns[neighbors_key][‘connectivitie
                                  s_key’]],
                                  .obsp[.uns[neighbors_key][‘distances_key’]]
                                  for connectivities and distances
                                  respectively.

  --no-sort-order                 Disable default behaviour: for continuous
                                  annotations used as color parameter, plot
                                  data points with higher values on top of
                                  others.  [default: True]

  --use-raw / --no-raw            Use `.raw` attribute for coloring with gene
                                  expression. If `None`, uses `.raw` if
                                  present.

  --groups TEXT                   Key for categorical in `.obs`. You can pass
                                  your predefined groups by choosing any
                                  categorical annotation of observations.

  --components TEXT               For instance, ['1,2', '2,3']. To plot all
                                  available components use 'all'.

  --projection [2d|3d]            Projection of plot.  [default: 2d]
  --help                          Show this message and exit.
```

