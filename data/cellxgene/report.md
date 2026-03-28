# cellxgene CWL Generation Report

## cellxgene_annotate

### Tool Description
Add predicted annotations to an H5AD file. Run `cellxgene annotate --help` for more information.

### Metadata
- **Docker Image**: quay.io/biocontainers/cellxgene:1.3.0--pyhdfd78af_0
- **Homepage**: https://chanzuckerberg.github.io/cellxgene/
- **Package**: https://anaconda.org/channels/bioconda/packages/cellxgene/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cellxgene/overview
- **Total Downloads**: 30.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: cellxgene annotate <options> <path to H5AD input file>

  Add predicted annotations to an H5AD file. Run `cellxgene annotate --help`
  for more information.

Options:
  -c, --annotation-prefix TEXT    An optional prefix used to form the names
                                  of: 1) new `obs` annotation columns that
                                  will store the predicted annotation values
                                  and confidence scores, 2) `obsm` embeddings
                                  (reference and umap embedding), and 3) `uns`
                                  metadata for the prediction operation
                                  [default: cxg]
  --classifier TEXT               For cell type annotation, the classifier
                                  level to use. The classifier is model-
                                  dependent, so refer to documentation for the
                                  specified model for valid values.
  -l, --counts-layer TEXT         If specified, raw counts will be read from
                                  the AnnData layer of the specified name. If
                                  unspecified, raw counts will be read from
                                  `X` matrix, unless 'raw.X' exists, in which
                                  case that will be used.
  -g, --gene-column-name TEXT     The name of the `var` column that contains
                                  gene names. The values in this column will
                                  be used to match genes between the query and
                                  reference datasets. If not specified, the
                                  gene names are expected to exist in
                                  `var.index`.
  -h, --help                      Show this message and exit.
  --mlflow-env-manager [virtualenv|conda|local]
                                  Annotation model prediction will be
                                  installed and executed in the specified type
                                  of environment. MacOS users on Apple Silicon
                                  (arm64, M1, M2, etc.) are recommended to use
                                  'conda' to avoid Python package installation
                                  errors. If 'conda' is specified then
                                  cellxgene must also have been installed
                                  within a conda environment
  --model-cache-dir TEXT          Local directory used to store model files
                                  that are retrieved from a remote location.
                                  Model files will be read from this directory
                                  first, if they exist, to avoid repeating
                                  large downloads.
  -m, --model-url TEXT            The URL of the model used to prediction
                                  annotated labels. May be a local filesystem
                                  directory or S3 path (s3://)  [required]
  --organism [Homo sapiens|Mus musculus]
                                  For cell type annotation, the organism of
                                  the dataset. Used to normalize gene names to
                                  HGLC conventions when an annotation model
                                  has been trained using data from different
                                  organism.
  -o, --output-h5ad-file <filename>
                                  The output H5AD file that will contain the
                                  generated annotation values. If this option
                                  is not provided, the input file will be
                                  overwritten to include the new annotations;
                                  in this case you must specify --overwrite.
  --overwrite                     Allow overwriting of the specified H5AD
                                  output file, if it exists. For safety, you
                                  must specify this flag if the specified
                                  output file already exists or if the
                                  --output-h5ad-file option is not provided.
  -n, --run-name TEXT             An optional run name that will be used as a
                                  suffix to form the names of new `obs`
                                  annotation columns that will store the
                                  predicted annotation values and confidence
                                  scores. This can be used to allow multiple
                                  annotation predictions to be run on a single
                                  AnnData object.
  --use-gpu / --no-use-gpu        Whether to use a GPU for annotation
                                  operations (highly recommended, if
                                  available).
  --use-model-cache / --no-use-model-cache
```


## cellxgene_launch

### Tool Description
Launch the cellxgene data viewer. This web app lets you explore single-cell expression data. Data must be in a format that cellxgene expects. Read the "getting started" guide to learn more: https://github.com/chanzuckerberg/cellxgene- documentation/blob/main/README.md

### Metadata
- **Docker Image**: quay.io/biocontainers/cellxgene:1.3.0--pyhdfd78af_0
- **Homepage**: https://chanzuckerberg.github.io/cellxgene/
- **Package**: https://anaconda.org/channels/bioconda/packages/cellxgene/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cellxgene launch <options> <path to data file>

  Launch the cellxgene data viewer. This web app lets you explore single-cell
  expression data. Data must be in a format that cellxgene expects. Read the
  "getting started" guide to learn more:
  https://github.com/chanzuckerberg/cellxgene-
  documentation/blob/main/README.md

  Examples:

  > cellxgene launch example-dataset/pbmc3k.h5ad --title pbmc3k

  > cellxgene launch <your data file> --title <your title>

  > cellxgene launch <url>

Options:
  --about <URL>                   URL providing more information about the
                                  dataset (hint: must be a fully specified
                                  absolute URL).
  --annotations-file <path>       CSV file to initialize editing of existing
                                  annotations; will be altered in-place.
                                  Incompatible with --user-generated-data-dir.
  -b, --backed                    Load anndata in file-backed mode. This may
                                  save memory, but may result in slower
                                  overall performance.
  -c, --config-file TEXT          Location to yaml file with configuration
                                  settings
  -d, --debug                     Run in debug mode. This is helpful for
                                  cellxgene developers, or when you want more
                                  information about an error condition.
  -de, --diffexp-lfc-cutoff <float>
                                  Minimum log fold change threshold for
                                  differential expression.  [default: 0.01]
  --disable-annotations           Disable user annotation of data.
  --disable-custom-colors         Disable user-defined category-label colors
                                  drawn from source data file.
  --disable-diffexp               Disable on-demand differential expression.
  --disable-gene-sets-save        Disable saving gene sets. If disabled, users
                                  will be able to make changes to gene sets
                                  but all changes will be lost on browser
                                  refresh.
  --dump-default-config           Print default configuration settings and
                                  exit
  -e, --embedding <text>          Embedding name, eg, 'umap'. Repeat option
                                  for multiple embeddings. Defaults to all.
  --gene-sets-file <path>         CSV file to initialize editing of gene sets;
                                  will be altered in-place. Incompatible with
                                  --user-generated-data-dir.
  -h, --help                      Show this message and exit.
  --host <IP address>             Host IP address. By default cellxgene will
                                  use localhost (e.g. 127.0.0.1).
  --max-category-items <integer>  Will not display categories with more
                                  distinct values than specified.  [default:
                                  1000]
  -obs, --obs-names <text>        Name of annotation field to use for
                                  observations. If not specified cellxgene
                                  will use the the obs index.
  -o, --open                      Open web browser after launch.
  -p, --port <port>               Port to run server on. If not specified
                                  cellxgene will find an available port.
  -s, --scripts <text>            Additional script files to include in HTML
                                  page. If not specified, no additional script
                                  files will be included.
  -t, --title <text>              Title to display. If omitted will use file
                                  name.
  --user-generated-data-dir, --annotations-dir <directory path>
                                  Directory of where to save output
                                  annotations; filename will be specified in
                                  the application. Incompatible with
                                  --annotations-file and --gene-sets-file.
  -var, --var-names <text>        Name of annotation to use for variables. If
                                  not specified cellxgene will use the the var
                                  index.
  -v, --verbose                   Provide verbose output, including warnings
                                  and all server requests.
  --X-approximate-distribution [auto|normal|count]
                                  Specify the approximate distribution of X
                                  matrix values. 'auto' will use a heuristic
                                  to determine the approximate distribution.
                                  Mode 'auto' is incompatible with --backed.
                                  [default: auto]
```


## cellxgene_for

### Tool Description
Command-line interface for cellxgene

### Metadata
- **Docker Image**: quay.io/biocontainers/cellxgene:1.3.0--pyhdfd78af_0
- **Homepage**: https://chanzuckerberg.github.io/cellxgene/
- **Package**: https://anaconda.org/channels/bioconda/packages/cellxgene/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cellxgene <options> COMMAND <args>

Error: No such command 'for'.
```


## cellxgene_prepare

### Tool Description
Preprocess data for use with cellxgene. This tool runs a series of scanpy
routines for preparing a dataset for use with cellxgene. It loads data from
different formats (h5ad, loom, or a 10x directory), runs dimensionality
reduction, computes nearest neighbors, computes an embedding, performs
clustering, and saves the results. Includes additional options for naming
annotations, ensuring sparsity, and plotting results.

### Metadata
- **Docker Image**: quay.io/biocontainers/cellxgene:1.3.0--pyhdfd78af_0
- **Homepage**: https://chanzuckerberg.github.io/cellxgene/
- **Package**: https://anaconda.org/channels/bioconda/packages/cellxgene/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cellxgene prepare <options> <path to data file>

  Preprocess data for use with cellxgene. This tool runs a series of scanpy
  routines for preparing a dataset for use with cellxgene. It loads data from
  different formats (h5ad, loom, or a 10x directory), runs dimensionality
  reduction, computes nearest neighbors, computes an embedding, performs
  clustering, and saves the results. Includes additional options for naming
  annotations, ensuring sparsity, and plotting results.

Options:
  -e, --embedding [umap|tsne]     Embedding algorithm(s). Repeat option for
                                  multiple embeddings.  [default: umap, tsne]
  -h, --help                      Show this message and exit.
  --make-obs-names-unique / --no-make-obs-names-unique
                                  Ensure obs index is unique.  [default: make-
                                  obs-names-unique]
  --make-var-names-unique / --no-make-var-names-unique
                                  Ensure var index is unique.  [default: make-
                                  var-names-unique]
  -o, --output <filename>         Save a new file to filename.
  --overwrite                     Allow file overwriting.
  -p, --plotting                  Generate plots.
  -r, --recipe [none|seurat|zheng17]
                                  [default: none]
  --set-obs-names <name>          Named field to set as index for obs.
  --set-var-names <name>          Named field to set as index for var.
  --skip-qc                       Do not run quality control metrics. By
                                  default cellxgene runs them (saved to
                                  adata.obs and adata.var; see
                                  scanpy.pp.calculate_qc_metrics for details).
  --sparse                        Force sparsity.
```


## Metadata
- **Skill**: generated
