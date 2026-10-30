# scanpy-scripts CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| scanpy-scripts_scanpy-cli_cluster_leiden | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_cluster_louvain | PASS | real 10x PBMC counts (1000 cells x 1000 genes) after neighbours; Louvain labels in obs and in the exported table |
| scanpy-scripts_scanpy-cli_diffexp | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_dpt | PASS | real 10x PBMC counts (1000 cells x 1000 genes) diffusion map with root cluster 0; dpt_pseudotime written |
| scanpy-scripts_scanpy-cli_embed_diffmap | Failed | tool bug: the default run (no --n-comps) crashes; with --n-comps 15 it writes X_diffmap on real 10x PBMC counts (1000 cells x 1000 genes) after Leiden clustering |
| scanpy-scripts_scanpy-cli_embed_fdg | PASS | real 10x PBMC counts (1000 cells x 1000 genes) after the chain to neighbours; X_draw_graph_fa written |
| scanpy-scripts_scanpy-cli_embed_tsne | PASS | real 10x PBMC counts (1000 cells x 1000 genes) after norm, hvg, scale, pca; X_tsne written for 1000 cells |
| scanpy-scripts_scanpy-cli_embed_umap | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_filter | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_hvg | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_integrate_bbknn | PASS | real 10x PBMC counts (1000 cells x 1000 genes) PCA with batch column; batch-balanced neighbours graph written |
| scanpy-scripts_scanpy-cli_integrate_combat | PASS | real 10x PBMC counts (1000 cells x 1000 genes) normalised then ComBat on batch; combat layer written |
| scanpy-scripts_scanpy-cli_integrate_harmony | PASS | real 10x PBMC counts (1000 cells x 1000 genes) PCA with 3 text batch labels; X_pca_harmony written (an integer batch column crashes harmonypy) |
| scanpy-scripts_scanpy-cli_integrate_mnn | Failed | image problem: mnnpy dies with illegal instruction (exit 132) after the image warns that its mnnpy install seems faulty |
| scanpy-scripts_scanpy-cli_multiplet_scrublet | PASS | real 10x PBMC counts (1000 cells x 1000 genes) with 3 text batch labels; doublet_score and predicted_doublet written, plus the score table (an integer batch column cannot be written to h5ad) |
| scanpy-scripts_scanpy-cli_multiplet_scrublet_simulate_doublets | PASS | real 10x PBMC counts (1000 cells x 1000 genes) simulated 1000 doublets, output holds 2000 cells with doublet_parents |
| scanpy-scripts_scanpy-cli_neighbor | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_norm | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_paga | PASS | real 10x PBMC counts (1000 cells x 1000 genes) after Leiden clustering; uns paga graph written for the leiden groups |
| scanpy-scripts_scanpy-cli_pca | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_plot_dot | PASS | real 10x PBMC counts (1000 cells x 1000 genes) dot plot of the top 2 ranked genes per Leiden cluster; diagonal pattern as expected |
| scanpy-scripts_scanpy-cli_plot_embed | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_plot_heat | PASS | real 10x PBMC counts (1000 cells x 1000 genes) heat map of the top 2 ranked genes per Leiden cluster drawn as PNG |
| scanpy-scripts_scanpy-cli_plot_matrix | PASS | real 10x PBMC counts (1000 cells x 1000 genes) mean expression matrix plot per Leiden cluster drawn as PNG |
| scanpy-scripts_scanpy-cli_plot_paga | PASS | real 10x PBMC counts (1000 cells x 1000 genes) PAGA graph drawn from the paga output as PNG |
| scanpy-scripts_scanpy-cli_plot_scrublet | PASS | real 10x PBMC counts (1000 cells x 1000 genes) histogram of doublet scores drawn from the scrublet output |
| scanpy-scripts_scanpy-cli_plot_sviol | PASS | real 10x PBMC counts (1000 cells x 1000 genes) stacked violin of the top 2 ranked genes per Leiden cluster drawn as PNG |
| scanpy-scripts_scanpy-cli_read | PASS | 10x hgmm_1k example (1046 cells), chained read to plot |
| scanpy-scripts_scanpy-cli_regress | PASS | real 10x PBMC counts (1000 cells x 1000 genes) normalised, then regressed on the batch column; output scaled (mean 0) |
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

## scanpy-scripts_scanpy-cli_regress

### Tool Description
Regress-out observation variables.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli regress [OPTIONS] <input_obj> <output_obj>

  Regress-out observation variables.

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

  -J, --n-jobs INTEGER            Number of jobs for parallel computation.
  -k, --keys TEXT[,TEXT...]       Key(s) for observation annotation on which
                                  to regress.

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_embed_tsne

### Tool Description
Embed the cells using t-SNE.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli embed tsne [OPTIONS] <input_obj> <output_obj>

  Embed the cells using t-SNE.

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

  -S, --random-state INTEGER      Seed for random number generator.  [default:
                                  0]

  --key-added TEXT[,TEXT...]      Key under which to add the computed results
  -J, --n-jobs INTEGER            Number of jobs for parallel computation.
  -E, --export-embedding FILE     Export embeddings in a tab-separated text
                                  table.

  --perplexity FLOAT              The perplexity is related to the number of
                                  nearest neighbors that is used in other
                                  manifold learning algorithms. Larger
                                  datasets usually require a larger
                                  perplexity. Consider selecting a value
                                  between 5 and 50. The choice is not
                                  extremely critical since t-SNE is quite
                                  insensitive to this parameter.  [default:
                                  30]

  --early-exaggeration FLOAT      Controls how tight natural clusters in the
                                  original space are in the embedded space and
                                  how much space will be between them. For
                                  larger values, the space between natural
                                  clusters will be larger in the embedded
                                  space. Again, the choice of this parameter
                                  is not very critical. If the cost function
                                  increases during initial optimization, the
                                  early exaggeration factor or the learning
                                  rate might be too high.  [default: 12]

  --learning-rate FLOAT           Note that the R-package "Rtsne" uses a
                                  default of 200. The learning rate can be a
                                  critical parameter. It should be between 100
                                  and 1000. If the cost function increases
                                  during initial optimization, the early
                                  exaggeration factor or the learning rate
                                  might be too high. If the cost function gets
                                  stuck in a bad local minimum increasing the
                                  learning rate helps sometimes.  [default:
                                  1000]

  --no-fast-tsne                  When NOT set, use the MulticoreTSNE package
                                  by D. Ulyanov if installed.  [default: True]

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_embed_fdg

### Tool Description
Embed the neighborhood graph using force-directed graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli embed fdg [OPTIONS] <input_obj> <output_obj>

  Embed the neighborhood graph using force-directed graph.

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

  -S, --random-state INTEGER      Seed for random number generator.  [default:
                                  0]

  -E, --export-embedding FILE     Export embeddings in a tab-separated text
                                  table.

  --root INTEGER                  If choosing a tree layout, this is the index
                                  of the root node.  [default: 0]

  --init-pos TEXT                 Use precomputed coordinates for
                                  initialization. Can be any key of `.obsm` or
                                  "paga" if .uns["paga"] is present

  --layout [fa|fr|grid_fr|kk|lgl|drl|rt|rt_circular]
                                  Name of any valid igraph layout, including
                                  "fa" (ForceAtlas2), "fr" (Fruchterman
                                  Reingold), "grid_fr" (Grid Fruchterman
                                  Reingold, faster than "fr"), "kk" (Kamadi
                                  Kawai, slower than "fr"), "lgl" (Large Graph
                                  Layout, very fast), "drl" (Distributed
                                  Recursive Layout, pretty fast) and "rt"
                                  (Reingold Tilford tree layout).  [default:
                                  fa]

  --key-added-ext TEXT            By default, append 'layout'
  --init-pos TEXT                 How to initialize the low dimensional
                                  embedding. Can be "paga", or any valid key
                                  of `.obsm`.

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

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_embed_diffmap

### Tool Description
Embed the neighborhood graph using diffusion map.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli embed diffmap [OPTIONS] <input_obj> <output_obj>

  Embed the neighborhood graph using diffusion map.

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

  --key-added TEXT[,TEXT...]      Key under which to add the computed results
  -E, --export-embedding FILE     Export embeddings in a tab-separated text
                                  table.

  --n-comps INTEGER               Number of components to compute
  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_cluster_louvain

### Tool Description
Find clusters by Louvain algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli cluster louvain [OPTIONS] <input_obj> <output_obj>

  Find clusters by Louvain algorithm.

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
  --flavor [vtraag|igraph]        Choose between two packages for computing
                                  the clustering. "vtraag" is much powerful,
                                  and the default.  [default: vtraag]

  -r, --resolution FLOAT[,FLOAT...]
                                  For the default flavor "vtraag", you can
                                  provide a resolution. Higher resolution
                                  means finding more and smaller clusters.
                                  [default: 1]

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_paga

### Tool Description
Trajectory inference by abstract graph analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli paga [OPTIONS] <input_obj> <output_obj>

  Trajectory inference by abstract graph analysis.

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

  --key-added TEXT[,TEXT...]      Key under which to add the computed results
  --groups TEXT                   Key for categorical in `.obs`. You can pass
                                  your predefined groups by choosing any
                                  categorical annotation of observations.
                                  [required]

  --model [v1.2|v1.0]             The PAGA connectivity model.  [default:
                                  v1.2]

  --use-rna-velocity              Use RNA velocity to orient edges in the
                                  abstracted graph and estimate transitions.
                                  Requires that adata.uns contains a directed
                                  single-cell graph with key velocity_graph.
                                  This feature might be subject to change in
                                  the future.  [default: False]

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_dpt

### Tool Description
Calculate diffusion pseudotime relative to the root cells.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli dpt [OPTIONS] <input_obj> <output_obj>

  Calculate diffusion pseudotime relative to the root cells.

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

  --key-added TEXT[,TEXT...]      Key under which to add the computed results
  --root <TEXT TEXT>...           Specify a categorical annotaion of
                                  observations (`.obs`) and a value
                                  representing the root cells.  [default:
                                  None, None]

  --n-dcs INTEGER                 The number of diffusion components to use.
                                  [default: 10]

  --n-branchings INTEGER          Number of branchings to detect.  [default:
                                  0]

  --min-group-size FLOAT          During recursive splitting of branches for
                                  --n-branchings > 1, do not consider
                                  branches/groups that contain fewer than this
                                  fraction of the total number of data points.
                                  [default: 0.01]

  --disallow-kendall-tau-shift    By default: If a very small branch is
                                  detected upon splitting, shift away from
                                  maximum correlation in Kendall tau criterion
                                  of [Haghverdi16] to stabilize the splitting.
                                  Use flag to disable this.  [default: True]

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_integrate_harmony

### Tool Description
Use harmonypy [Korunsky19] to integrate different experiments.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli integrate harmony [OPTIONS] <input_obj> <output_obj>

  Use harmonypy [Korunsky19] to integrate different experiments.

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

  --batch-key TEXT                The name of the column in adata.obs that
                                  differentiates among experiments/batches.
                                  [required]

  --basis TEXT                    The name of the field in adata.obsm where
                                  the PCA table is stored. Defaults to
                                  'X_pca', which is the default for
                                  sc.tl.pca().  [default: X_pca]

  --adjusted-basis TEXT           The name of the field in adata.obsm where
                                  the adjusted PCA table will be stored after
                                  running this function.  [default:
                                  X_pca_harmony]

  --theta FLOAT                   Diversity clustering penalty parameter.
                                  theta=0 does not encourage any diversity.
                                  Larger values of theta result in more
                                  diverse clusters.  [default: 2]

  --lambda FLOAT                  Ridge regression penalty parameter. Lambda
                                  must be strictly positive.  Smaller values
                                  result in more aggressive correction.
                                  [default: 1]

  --sigma FLOAT                   Width of soft kmeans clusters. Sigma scales
                                  the distance from a cell to cluster
                                  centroids. Larger values of sigma result in
                                  cells assigned to more clusters. Smaller
                                  values of sigma make soft kmeans cluster
                                  approach hard clustering.  [default: 0.1]

  --n-clust INTEGER               Number of clusters in model. nclust=1
                                  equivalent to simple linear regression.

  --tau INTEGER                   Protection against overclustering small
                                  datasets with large ones. tau is the
                                  expected number of cells per cluster.
                                  [default: 0]

  --block-size FLOAT              What proportion of cells to update during
                                  clustering. Between 0 to 1, default 0.05.
                                  Larger values may be faster but less
                                  accurate.  [default: 0.05]

  --max-iter-cluster INTEGER      Maximum number of rounds to run clustering
                                  at each round of Harmony.  [default: 20]

  --max-iter-harmony INTEGER      Maximum number of rounds to run Harmony. One
                                  round of Harmony involves one clustering and
                                  one correction step.  [default: 10]

  --epsilon-cluster FLOAT         Convergence tolerance for clustering round
                                  of Harmony Set to -Inf to never stop early.
                                  [default: 1e-05]

  --epsilon-harmony FLOAT         Convergence tolerance for clustering round
                                  of Harmony Set to -Inf to never stop early.
                                  [default: 1e-05]

  -S, --random-state INTEGER      Seed for random number generator.  [default:
                                  0]

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_integrate_bbknn

### Tool Description
Batch balanced kNN [Polanski19].

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli integrate bbknn [OPTIONS] <input_obj> <output_obj>

  Batch balanced kNN [Polanski19].

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

  --key-added TEXT[,TEXT...]      Key under which to add the computed results
  --batch-key TEXT                The name of the column in adata.obs that
                                  differentiates among experiments/batches.
                                  [required]

  -u, --use-rep TEXT              The dimensionality reduction in .obsm to use
                                  for neighbour detection.  [default: X_pca]

  -n, --n-pcs INTEGER             Use this many PCs. Use `.X` if --n-pcs is 0
                                  when --use-rep is None.

  --no-approx                     Default behaviour is to use annoy’s
                                  approximate neighbour finding. This results
                                  in a quicker run time for large datasets
                                  while also potentially increasing the degree
                                  of batch correction. Use this flag to
                                  disable that behaviour.

  -t, --metric [cityblock|cosine|euclidean|l1|l2|manhattan|braycurtis|canberra|chebyshev|correlation|dice|hamming|jaccard|kulsinski|mahalanobis|minkowski|rogerstanimoto|russellrao|seuclidean|sokalmichener|sokalsneath|sqeuclidean|yule]
                                  A known metric’s name.  [default: euclidean]
  --neighbors-within-batch INTEGER
                                  How many top neighbours to report for each
                                  batch; total number of neighbours will be
                                  this number times the number of batches.
                                  [default: 3]

  --trim INTEGER                  Trim the neighbours of each cell to these
                                  many top connectivities. May help with
                                  population independence and improve the
                                  tidiness of clustering. The lower the value
                                  the more independent the individual
                                  populations, at the cost of more conserved
                                  batch effect. If None, sets the parameter
                                  value automatically to 10 times the total
                                  number of neighbours for each cell. Set to 0
                                  to skip.

  --annoy-n-trees INTEGER         Only used when approx=True. The number of
                                  trees to construct in the annoy forest. More
                                  trees give higher precision when querying,
                                  at the cost of increased run time and
                                  resource intensity.  [default: 10]

  --no-use-faiss                  Default behaviour If approx=False and the
                                  metric is “euclidean”, is to use the faiss
                                  package to compute nearest neighbours if
                                  installed. This improves performance at a
                                  minor cost to numerical precision as faiss
                                  operates on float32. Use this flag to
                                  disable that behaviour.

  --set-op-mix-ratio FLOAT        UMAP connectivity computation parameter,
                                  float between 0 and 1, controlling the blend
                                  between a connectivity matrix formed
                                  exclusively from mutual nearest neighbour
                                  pairs (0) and a union of all observed
                                  neighbour relationships with the mutual
                                  pairs emphasised (1).  [default: 1]

  --local-connectivity INTEGER    UMAP connectivity computation parameter, how
                                  many nearest neighbors of each cell are
                                  assumed to be fully connected (and given a
                                  connectivity value of 1)  [default: 1]

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_integrate_mnn

### Tool Description
Correct batch effects by matching mutual nearest neighbors [Haghverdi18] [Kang18].

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli integrate mnn [OPTIONS] <input_obj> <output_obj>

  Correct batch effects by matching mutual nearest neighbors [Haghverdi18]
  [Kang18].

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

  --batch-key TEXT                The name of the column in adata.obs that
                                  differentiates among experiments/batches.
                                  [required]

  -l, --layer TEXT                Layer to batch correct. By default corrects
                                  the contents of .X.

  --key-added TEXT                Key under which to add the computed results.
                                  By default a new layer will be created
                                  called 'mnn', 'mnn_{layer}' or
                                  'mnn_layer_{key_added}' where those
                                  parameters were specified. A value of 'X'
                                  causes batch-corrected values to overwrite
                                  the original content of .X.

  --var-subset <TEXT TEXT[,TEXT...]>...
                                  The subset of vars (list of str) to be used
                                  when performing MNN correction in the format
                                  of '--var-subset <name> <values>'.
                                  Typically, use the highly variable genes
                                  (HVGs) like '--var-subset highly_variable
                                  True'. When unset, uses all vars.

  -k, --n-neighbors INTEGER[,INTEGER...]
                                  Number of mutual nearest neighbors.
                                  [default: 20]

  --sigma FLOAT                   The bandwidth of the Gaussian smoothing
                                  kernel used to compute the correction
                                  vectors.  [default: 1.0]

  --no-cos_norm_in                Default behaviour is to perform cosine
                                  normalization on the input data prior to
                                  calculating distances between cells. Use
                                  this flag to disable that behaviour.

  --no-cos_norm_out               Default behaviour is to perform cosine
                                  normalization prior to computing corrected
                                  expression values. Use this flag to disable
                                  that behaviour.

  --svd-dim INTEGER               The number of dimensions to use for
                                  summarizing biological substructure within
                                  each batch. If not set, biological
                                  components will not be removed from the
                                  correction vectors.

  --no-var-adj                    Default behaviour is to adjust variance of
                                  the correction vectors. Use this flag to
                                  disable that behaviour. Note this step takes
                                  most computing time.

  --compute-angle                 When set, compute the angle between each
                                  cell’s correction vector and the biological
                                  subspace of the reference batch.

  --svd-mode [svd|rsvd|irlb]      'svd' computes SVD using a non-randomized
                                  SVD-via-ID algorithm, while 'rsvd' uses a
                                  randomized version. 'irlb' performs
                                  truncated SVD by implicitly restarted
                                  Lanczos bidiagonalization (forked from
                                  https://github.com/airysen/irlbpy).
                                  [default: rsvd]

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_integrate_combat

### Tool Description
ComBat function for batch effect correction

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli integrate combat [OPTIONS] <input_obj> <output_obj>

  ComBat function for batch effect correction

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

  --batch-key TEXT                The name of the column in adata.obs that
                                  differentiates among experiments/batches.
                                  [required]

  -l, --layer TEXT                Layer to batch correct. By default corrects
                                  the contents of .X.

  --key-added TEXT                Key under which to add the computed results.
                                  By default a new layer will be created
                                  called 'combat', 'combat_{layer}' or
                                  'combat_layer_{key_added}' where those
                                  parameters were specified. A value of 'X'
                                  causes batch-corrected values to overwrite
                                  the original content of .X.

  --covariates TEXT[,TEXT...]     Comma-separated list of additional
                                  covariates besides the batch variable such
                                  as adjustment variables or biological
                                  condition. This parameter refers to the
                                  design matrix X in Equation 2.1 in
                                  [Johnson07] and to the mod argument in the
                                  original combat function in the sva R
                                  package.  Note that not including covariates
                                  may introduce bias or lead to the removal of
                                  biological signal in unbalanced designs.

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_multiplet_scrublet

### Tool Description
Filter out likely multiplets from droplet data using Scrublet [Wolock2019].

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli multiplet scrublet [OPTIONS] <input_obj> <output_obj>

  Filter out likely multiplets from droplet data using Scrublet
  [Wolock2019].

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

  --batch-key TEXT                The name of the column in adata.obs that
                                  differentiates among experiments/batches.
                                  Doublets will be detected in each batch
                                  separately.

  --input-obj-sim FILE            (Advanced use case) Optional annData object
                                  generated by
                                  sc.external.pp.scrublet_simulate_doublets(),
                                  with same number of  vars as adata. This
                                  should have been built from input_obj after
                                  filtering genes and cells and selcting
                                  highly-variable genes.

  --threshold FLOAT               Doublet score threshold for calling a
                                  transcriptome a doublet. If not set, this is
                                  set automatically by looking for the minimum
                                  between the two modes of the
                                  doublet_scores_sim_ histogram. It is best
                                  practice to check the threshold visually
                                  using the doublet_scores_sim_ histogram
                                  and/or based on co-localization of predicted
                                  doublets in a 2-D embedding.

  --sim-doublet-ratio FLOAT       Number of doublets to simulate relative to
                                  the number of observed transcriptomes.
                                  [default: 2.0]

  --synthetic-doublet-umi-subsampling FLOAT
                                  Where input_obj_sim not suplied, rate for
                                  sampling UMIs when creating synthetic
                                  doublets. If 1.0, each doublet is created by
                                  simply adding the UMI counts from two
                                  randomly sampled observed transcriptomes.
                                  For values less than 1, the UMI counts are
                                  added and then randomly sampled at the
                                  specified rate.  [default: 1.0]

  --expected-doublet-rate FLOAT   Where input_obj_sim not suplied, the
                                  estimated doublet rate for the experiment.
                                  [default: 0.05]

  --stdev-doublet-rate FLOAT      Where input_obje_sim not suplied,
                                  uncertainty in the expected doublet rate.
                                  [default: 0.02]

  -t, --knn-dist-metric [cityblock|cosine|euclidean|l1|l2|manhattan|braycurtis|canberra|chebyshev|correlation|dice|hamming|jaccard|kulsinski|mahalanobis|minkowski|rogerstanimoto|russellrao|seuclidean|sokalmichener|sokalsneath|sqeuclidean|yule]
                                  A known metric’s name.  [default: euclidean]
  --no-normalize-variance         Default is to normalize the data such that
                                  each gene has a variance of 1.
                                  sklearn.decomposition.TruncatedSVD will be
                                  used for dimensionality reduction, if --no-
                                  mean-center is set. Use this flag to disable
                                  that behaviour.

  --log-transform                 Whether to use :func:~scanpy.pp.log1p to
                                  log-transform the data prior to PCA.
                                  [default: False]

  --no-mean-center                If True, center the data such that each gene
                                  has a mean of 0. sklearn.decomposition.PCA
                                  will be used for dimensionality reduction.

  --n-pcs INTEGER                 Number of principal components used to embed
                                  the transcriptomes prior to k-nearest-
                                  neighbor graph construction.  [default: 30]

  --no-approx                     Default behaviour is to use the approximate
                                  nearest neighbor method (annoy) for the KNN
                                  classifier. Use this flag to disable that
                                  behaviour.

  --get-doublet-neighbor-parents  If set, return (in .uns) the parent
                                  transcriptomes that generated the doublet
                                  neighbors of each observed transcriptome.
                                  This information can be used to infer the
                                  cell states that generated a given doublet
                                  state.  [default: False]

  -k, --n-neighbors INTEGER[,INTEGER...]
                                  Number of neighbors used to construct the
                                  KNN graph of observed transcriptomes and
                                  simulated doublets. If not set, this is
                                  automatically set to np.round(0.5 *
                                  np.sqrt(n_obs)).

  --filter                        By default, the output object is annotated
                                  but not filtered according to the scrublet
                                  status. Setting this flag will cause
                                  predicted multiplet elements to be removed.

  --no-verbose                    Default behaviour is to print progress
                                  updates. Use this flag to disable that.

  --export-table FILE             Export a table of double scores and calls to
                                  the specified file.

  -S, --random-state INTEGER      Seed for random number generator.  [default:
                                  0]

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_multiplet_scrublet_simulate_doublets

### Tool Description
Simulate doublets with random transcriptome pairs for Scrublet [Wolock2019].

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli multiplet scrublet_simulate_doublets [OPTIONS] <input_obj>
                                                       <output_obj>

  Simulate doublets with random transcriptome pairs for Scrublet
  [Wolock2019].

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

  --sim-doublet-ratio FLOAT       Number of doublets to simulate relative to
                                  the number of observed transcriptomes.
                                  [default: 2.0]

  --synthetic-doublet-umi-subsampling FLOAT
                                  Where input_obj_sim not suplied, rate for
                                  sampling UMIs when creating synthetic
                                  doublets. If 1.0, each doublet is created by
                                  simply adding the UMI counts from two
                                  randomly sampled observed transcriptomes.
                                  For values less than 1, the UMI counts are
                                  added and then randomly sampled at the
                                  specified rate.  [default: 1.0]

  -l, --layer TEXT                Layer of adata where raw values are stored,
                                  or ‘X’ if values are in .X.

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_plot_paga

### Tool Description
Plot PAGA trajectories.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli plot paga [OPTIONS] <input_obj> <output_fig>

  Plot PAGA trajectories.

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
  --use-raw / --no-raw            Use `.raw` attribute for coloring with gene
                                  expression. If `None`, uses `.raw` if
                                  present.

  --groups TEXT                   Key for categorical in `.obs`. You can pass
                                  your predefined groups by choosing any
                                  categorical annotation of observations.

  -S, --random-state INTEGER      Seed for random number generator.  [default:
                                  0]

  --use-key TEXT                  The key in `.uns` that contains trajectory
                                  information.  [default: paga]

  --layout [fa|fr|grid_fr|kk|lgl|drl|rt]
                                  Plotting layout that computes positions.
                                  [default: fr]

  --init-pos TEXT                 Plotting layout that computes positions.
  --threshold FLOAT               Do not draw edges for weights below this
                                  threshold. Set to 0 to include all edges.
                                  [default: 0.01]

  --root INTEGER                  If choosing a tree layout, this is the index
                                  of the root node.  [default: 0]

  --root INTEGER                  If choosing a tree layout, this is the index
                                  of the root node.  [default: 0]

  --transitions TEXT              Key for `.uns["paga"]` that specifies the
                                  matrix, e.g. `transition_confidence`, that
                                  stores the arrows.

  --single-component              Restrict to largest connected component
                                  [default: False]

  --solid-edges [connectivities|connectivities_tree]
                                  Key for `.uns["paga"]` that specifies the
                                  matrix that stores the edges to be drawn
                                  solid black.  [default: connectivities]

  --basis TEXT                    Name of the embedding to plot, must be a key
                                  of `.obsm` without the prefix "X_".

  --color TEXT[,TEXT...]          Key(s) for annotation of observations/cells
                                  or variables/genes. Comma-separated if more
                                  than one

  --legend-loc [right margin|on data]
                                  Location of legend, either "on data", "right
                                  margin" or valid keywords for
                                  `matplotlib.legend`.  [default: right
                                  margin]

  --size FLOAT                    Point size. Automatically computed if not
                                  specified.

  --node-size-scale FLOAT         Increase of decrease the size of the nodes.
                                  [default: 1.0]

  --fontsize INTEGER              Font size for node labels.
  --edge-width-scale FLOAT        Increase of decrease the width of the edges.
                                  [default: 1.0]

  --arrowsize INTEGER             For directed graphs, specify the length and
                                  width of the arrowhead.  [default: 30]

  --output-obj FILE               Optionally output an object to the specified
                                  path.

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

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_plot_sviol

### Tool Description
Plot stacked violin plots.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli plot sviol [OPTIONS] <input_obj> <output_fig>

  Plot stacked violin plots.

  <input_obj>:   input file in format specfied by --input-format
  <output_fig>:  output figure in pdf or png format

Options:
  -f, --input-format [anndata|loom]
                                  Input object format.  [default: anndata]
  --fig-size INTEGER,INTEGER      Figure size.  [default: 7,7]
  --fig-dpi INTEGER               Figure DPI.  [default: 80]
  --fig-fontsize INTEGER          Figure font size.  [default: 15]
  --use-raw / --no-raw            Use expression values in `.raw` if present.
  --var-names TEXT[,TEXT...]      var_names should be a valid subset of
                                  adata.var_names.

  --groups TEXT[,TEXT...]         The groups for which to show the gene
                                  ranking.

  -n, --n-genes INTEGER           Number of genes to show.  [default: 10]
  --layer TEXT[,TEXT...]          Name of the AnnData object layer that wants
                                  to be plotted. By default adata.raw.X is
                                  plotted. If use_raw=False is set, then
                                  adata.X is plotted. If layer is set to a
                                  valid layer name, then the layer is plotted.
                                  layer takes precedence over use_raw.

  --rgg                           When set, use the rank_genes_groups_ form of
                                  the function, where gene lists are
                                  automatically selected.  [default: False]

  --groupby TEXT[,TEXT...]        The key of the observation grouping to
                                  consider.

  --log                           Plot on logarithmic axis.  [default: False]
  --num-categories INTEGER        Only used if groupby observation is not
                                  categorical. This value determines the
                                  number of groups into which the groupby
                                  observation should be subdivided.  [default:
                                  7]

  --dendrogram                    If True, a dendrogram based on the
                                  hierarchical clustering between the groupby
                                  categories is added. The dendrogram
                                  information is computed using
                                  scanpy.tl.dendrogram(). If tl.dendrogram has
                                  not been called previously the function is
                                  called with default parameters.

  --standard-scale [var|obs]      Whether or not to standardize that dimension
                                  between 0 and 1, meaning for each variable
                                  or group, subtract the minimum and divide
                                  each by its maximum.

  --gene-symbols TEXT[,TEXT...]   Column name in .var DataFrame that stores
                                  gene symbols. By default this is assumed to
                                  be the index column of the .var DataFrame.
                                  Setting this option allows alternative names
                                  to be used.

  --no-stripplot                  When set, do not add a stripplot on top of
                                  the violin plot.  [default: True]

  --no-jitter                     Suppress jitter in the stripplot (only when
                                  stripplot is True)  [default: True]

  --size INTEGER                  Size of the jitter points.  [default: 1]
  --order TEXT[,TEXT...]          Order in which to show the categories.
  --scale [area|count|width]      The method used to scale the width of each
                                  violin. If ‘area’, each violin will have the
                                  same area. If ‘count’, the width of the
                                  violins will be scaled by the number of
                                  observations in that bin. If ‘width’, each
                                  violin will have the same width.  [default:
                                  width]

  --row-palette TEXT[,TEXT...]    The row palette determines the colors to use
                                  in each of the stacked violin plots. The
                                  value should be a valid seaborn palette name
                                  or a valic matplotlib colormap (see https://
                                  seaborn.pydata.org/generated/seaborn.color_p
                                  alette.html). Alternatively, a single color
                                  name or hex value can be passed. E.g. ‘red’
                                  or ‘#cc33ff’.  [default: muted]

  --swap-axes                     By default, the x axis contains var_names
                                  (e.g. genes) and the y axis the groupby
                                  categories. By setting swap_axes then x are
                                  the groupby categories and y the var_names.
                                  When swapping axes var_group_positions are
                                  no longer used.  [default: False]

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_plot_dot

### Tool Description
Plot a dot plot of expression values.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli plot dot [OPTIONS] <input_obj> <output_fig>

  Plot a dot plot of expression values.

  <input_obj>:   input file in format specfied by --input-format
  <output_fig>:  output figure in pdf or png format

Options:
  -f, --input-format [anndata|loom]
                                  Input object format.  [default: anndata]
  --fig-size INTEGER,INTEGER      Figure size.  [default: 7,7]
  --fig-dpi INTEGER               Figure DPI.  [default: 80]
  --fig-fontsize INTEGER          Figure font size.  [default: 15]
  --use-raw / --no-raw            Use expression values in `.raw` if present.
  --var-names TEXT[,TEXT...]      var_names should be a valid subset of
                                  adata.var_names.

  --groups TEXT[,TEXT...]         The groups for which to show the gene
                                  ranking.

  -n, --n-genes INTEGER           Number of genes to show.  [default: 10]
  --layer TEXT[,TEXT...]          Name of the AnnData object layer that wants
                                  to be plotted. By default adata.raw.X is
                                  plotted. If use_raw=False is set, then
                                  adata.X is plotted. If layer is set to a
                                  valid layer name, then the layer is plotted.
                                  layer takes precedence over use_raw.

  --rgg                           When set, use the rank_genes_groups_ form of
                                  the function, where gene lists are
                                  automatically selected.  [default: False]

  --groupby TEXT[,TEXT...]        The key of the observation grouping to
                                  consider.

  --log                           Plot on logarithmic axis.  [default: False]
  --num-categories INTEGER        Only used if groupby observation is not
                                  categorical. This value determines the
                                  number of groups into which the groupby
                                  observation should be subdivided.  [default:
                                  7]

  --dendrogram                    If True, a dendrogram based on the
                                  hierarchical clustering between the groupby
                                  categories is added. The dendrogram
                                  information is computed using
                                  scanpy.tl.dendrogram(). If tl.dendrogram has
                                  not been called previously the function is
                                  called with default parameters.

  --standard-scale [var|obs]      Whether or not to standardize that dimension
                                  between 0 and 1, meaning for each variable
                                  or group, subtract the minimum and divide
                                  each by its maximum.

  --gene-symbols TEXT[,TEXT...]   Column name in .var DataFrame that stores
                                  gene symbols. By default this is assumed to
                                  be the index column of the .var DataFrame.
                                  Setting this option allows alternative names
                                  to be used.

  --expression-cutoff FLOAT       Expression cutoff that is used for
                                  binarizing the gene expression and
                                  determining the fraction of cells expressing
                                  given genes. A gene is expressed only if the
                                  expression value is greater than this
                                  threshold.  [default: 0]

  --mean-only-expressed           If True, gene expression is averaged only
                                  over the cells expressing the given genes.
                                  [default: False]

  --color-map TEXT[,TEXT...]      String denoting matplotlib color map.
                                  [default: Reds]

  --dot-max FLOAT                 If none, the maximum dot size is set to the
                                  maximum fraction value found (e.g. 0.6). If
                                  given, the value should be a number between
                                  0 and 1. All fractions larger than dot_max
                                  are clipped to this value.

  --dot-min FLOAT                 If none, the minimum dot size is set to 0.
                                  If given, the value should be a number
                                  between 0 and 1. All fractions smaller than
                                  dot_min are clipped to this value.

  --smallest-dot FLOAT            If none, the smallest dot has size 0. All
                                  expression levels with dot_min are potted
                                  with smallest_dot dot size.  [default: 0]

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_plot_matrix

### Tool Description
Plot a heatmap of the mean expression values per cluster.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli plot matrix [OPTIONS] <input_obj> <output_fig>

  Plot a heatmap of the mean expression values per cluster.

  <input_obj>:   input file in format specfied by --input-format
  <output_fig>:  output figure in pdf or png format

Options:
  -f, --input-format [anndata|loom]
                                  Input object format.  [default: anndata]
  --fig-size INTEGER,INTEGER      Figure size.  [default: 7,7]
  --fig-dpi INTEGER               Figure DPI.  [default: 80]
  --fig-fontsize INTEGER          Figure font size.  [default: 15]
  --use-raw / --no-raw            Use expression values in `.raw` if present.
  --var-names TEXT[,TEXT...]      var_names should be a valid subset of
                                  adata.var_names.

  --groups TEXT[,TEXT...]         The groups for which to show the gene
                                  ranking.

  -n, --n-genes INTEGER           Number of genes to show.  [default: 10]
  --layer TEXT[,TEXT...]          Name of the AnnData object layer that wants
                                  to be plotted. By default adata.raw.X is
                                  plotted. If use_raw=False is set, then
                                  adata.X is plotted. If layer is set to a
                                  valid layer name, then the layer is plotted.
                                  layer takes precedence over use_raw.

  --rgg                           When set, use the rank_genes_groups_ form of
                                  the function, where gene lists are
                                  automatically selected.  [default: False]

  --groupby TEXT[,TEXT...]        The key of the observation grouping to
                                  consider.

  --log                           Plot on logarithmic axis.  [default: False]
  --num-categories INTEGER        Only used if groupby observation is not
                                  categorical. This value determines the
                                  number of groups into which the groupby
                                  observation should be subdivided.  [default:
                                  7]

  --dendrogram                    If True, a dendrogram based on the
                                  hierarchical clustering between the groupby
                                  categories is added. The dendrogram
                                  information is computed using
                                  scanpy.tl.dendrogram(). If tl.dendrogram has
                                  not been called previously the function is
                                  called with default parameters.

  --standard-scale [var|obs]      Whether or not to standardize that dimension
                                  between 0 and 1, meaning for each variable
                                  or group, subtract the minimum and divide
                                  each by its maximum.

  --gene-symbols TEXT[,TEXT...]   Column name in .var DataFrame that stores
                                  gene symbols. By default this is assumed to
                                  be the index column of the .var DataFrame.
                                  Setting this option allows alternative names
                                  to be used.

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_plot_heat

### Tool Description
Plot a heatmap of the expression values of genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli plot heat [OPTIONS] <input_obj> <output_fig>

  Plot a heatmap of the expression values of genes.

  <input_obj>:   input file in format specfied by --input-format
  <output_fig>:  output figure in pdf or png format

Options:
  -f, --input-format [anndata|loom]
                                  Input object format.  [default: anndata]
  --fig-size INTEGER,INTEGER      Figure size.  [default: 7,7]
  --fig-dpi INTEGER               Figure DPI.  [default: 80]
  --fig-fontsize INTEGER          Figure font size.  [default: 15]
  --use-raw / --no-raw            Use expression values in `.raw` if present.
  --var-names TEXT[,TEXT...]      var_names should be a valid subset of
                                  adata.var_names.

  --groups TEXT[,TEXT...]         The groups for which to show the gene
                                  ranking.

  -n, --n-genes INTEGER           Number of genes to show.  [default: 10]
  --layer TEXT[,TEXT...]          Name of the AnnData object layer that wants
                                  to be plotted. By default adata.raw.X is
                                  plotted. If use_raw=False is set, then
                                  adata.X is plotted. If layer is set to a
                                  valid layer name, then the layer is plotted.
                                  layer takes precedence over use_raw.

  --rgg                           When set, use the rank_genes_groups_ form of
                                  the function, where gene lists are
                                  automatically selected.  [default: False]

  --groupby TEXT[,TEXT...]        The key of the observation grouping to
                                  consider.

  --log                           Plot on logarithmic axis.  [default: False]
  --num-categories INTEGER        Only used if groupby observation is not
                                  categorical. This value determines the
                                  number of groups into which the groupby
                                  observation should be subdivided.  [default:
                                  7]

  --dendrogram                    If True, a dendrogram based on the
                                  hierarchical clustering between the groupby
                                  categories is added. The dendrogram
                                  information is computed using
                                  scanpy.tl.dendrogram(). If tl.dendrogram has
                                  not been called previously the function is
                                  called with default parameters.

  --standard-scale [var|obs]      Whether or not to standardize that dimension
                                  between 0 and 1, meaning for each variable
                                  or group, subtract the minimum and divide
                                  each by its maximum.

  --gene-symbols TEXT[,TEXT...]   Column name in .var DataFrame that stores
                                  gene symbols. By default this is assumed to
                                  be the index column of the .var DataFrame.
                                  Setting this option allows alternative names
                                  to be used.

  --show-gene-labels              By default gene labels are shown when there
                                  are 50 or less genes. Otherwise the labels
                                  are removed.

  --swap-axes                     By default, the x axis contains var_names
                                  (e.g. genes) and the y axis the groupby
                                  categories. By setting swap_axes then x are
                                  the groupby categories and y the var_names.
                                  When swapping axes var_group_positions are
                                  no longer used.  [default: False]

  --help                          Show this message and exit.
```

## scanpy-scripts_scanpy-cli_plot_scrublet

### Tool Description
Plot histogram of doublet scores for observed transcriptomes and simulated doublets..

### Metadata
- **Docker Image**: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scanpy-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scanpy-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scanpy-cli plot scrublet [OPTIONS] <input_obj> <output_fig>

  Plot histogram of doublet scores for observed transcriptomes and simulated
  doublets..

  <input_obj>:   input file in format specfied by --input-format
  <output_fig>:  output figure in pdf or png format

Options:
  -f, --input-format [anndata|loom]
                                  Input object format.  [default: anndata]
  --fig-size INTEGER,INTEGER      Figure size.  [default: 7,7]
  --fig-dpi INTEGER               Figure DPI.  [default: 80]
  --fig-fontsize INTEGER          Figure font size.  [default: 15]
  -b, --scale-hist-obs [linear|log|symlog|logit]
                                  Set y axis scale transformation in
                                  matplotlib for the plot of observed
                                  transcriptomes.  [default: log]

  -s, --scale-hist-sim [linear|log|symlog|logit]
                                  Set y axis scale transformation in
                                  matplotlib for the plot of observed
                                  transcriptomes.  [default: linear]

  --help                          Show this message and exit.
```

