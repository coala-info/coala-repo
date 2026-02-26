cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cellxgene
  - annotate
label: cellxgene_annotate
doc: "Add predicted annotations to an H5AD file. Run `cellxgene annotate --help` for
  more information.\n\nTool homepage: https://chanzuckerberg.github.io/cellxgene/"
inputs:
  - id: input_h5ad_file
    type: File
    doc: path to H5AD input file
    inputBinding:
      position: 1
  - id: annotation_prefix
    type:
      - 'null'
      - string
    doc: 'An optional prefix used to form the names of: 1) new `obs` annotation columns
      that will store the predicted annotation values and confidence scores, 2) `obsm`
      embeddings (reference and umap embedding), and 3) `uns` metadata for the prediction
      operation'
    default: cxg
    inputBinding:
      position: 102
      prefix: --annotation-prefix
  - id: classifier
    type:
      - 'null'
      - string
    doc: For cell type annotation, the classifier level to use. The classifier 
      is model-dependent, so refer to documentation for the specified model for 
      valid values.
    inputBinding:
      position: 102
      prefix: --classifier
  - id: counts_layer
    type:
      - 'null'
      - string
    doc: If specified, raw counts will be read from the AnnData layer of the 
      specified name. If unspecified, raw counts will be read from `X` matrix, 
      unless 'raw.X' exists, in which case that will be used.
    inputBinding:
      position: 102
      prefix: --counts-layer
  - id: gene_column_name
    type:
      - 'null'
      - string
    doc: The name of the `var` column that contains gene names. The values in 
      this column will be used to match genes between the query and reference 
      datasets. If not specified, the gene names are expected to exist in 
      `var.index`.
    inputBinding:
      position: 102
      prefix: --gene-column-name
  - id: mlflow_env_manager
    type:
      - 'null'
      - string
    doc: Annotation model prediction will be installed and executed in the 
      specified type of environment. MacOS users on Apple Silicon (arm64, M1, 
      M2, etc.) are recommended to use 'conda' to avoid Python package 
      installation errors. If 'conda' is specified then cellxgene must also have
      been installed within a conda environment
    inputBinding:
      position: 102
      prefix: --mlflow-env-manager
  - id: model_cache_dir
    type:
      - 'null'
      - Directory
    doc: Local directory used to store model files that are retrieved from a 
      remote location. Model files will be read from this directory first, if 
      they exist, to avoid repeating large downloads.
    inputBinding:
      position: 102
      prefix: --model-cache-dir
  - id: model_url
    type: string
    doc: The URL of the model used to prediction annotated labels. May be a 
      local filesystem directory or S3 path (s3://)
    inputBinding:
      position: 102
      prefix: --model-url
  - id: no_use_gpu
    type:
      - 'null'
      - boolean
    doc: Whether to use a GPU for annotation operations (highly recommended, if 
      available).
    inputBinding:
      position: 102
      prefix: --no-use-gpu
  - id: no_use_model_cache
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-use-model-cache
  - id: organism
    type:
      - 'null'
      - string
    doc: For cell type annotation, the organism of the dataset. Used to 
      normalize gene names to HGLC conventions when an annotation model has been
      trained using data from different organism.
    inputBinding:
      position: 102
      prefix: --organism
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Allow overwriting of the specified H5AD output file, if it exists. For 
      safety, you must specify this flag if the specified output file already 
      exists or if the --output-h5ad-file option is not provided.
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: run_name
    type:
      - 'null'
      - string
    doc: An optional run name that will be used as a suffix to form the names of
      new `obs` annotation columns that will store the predicted annotation 
      values and confidence scores. This can be used to allow multiple 
      annotation predictions to be run on a single AnnData object.
    inputBinding:
      position: 102
      prefix: --run-name
  - id: use_gpu
    type:
      - 'null'
      - boolean
    doc: Whether to use a GPU for annotation operations (highly recommended, if 
      available).
    inputBinding:
      position: 102
      prefix: --use-gpu
  - id: use_model_cache
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --use-model-cache
outputs:
  - id: output_h5ad_file
    type:
      - 'null'
      - File
    doc: The output H5AD file that will contain the generated annotation values.
      If this option is not provided, the input file will be overwritten to 
      include the new annotations; in this case you must specify --overwrite.
    outputBinding:
      glob: $(inputs.output_h5ad_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellxgene:1.3.0--pyhdfd78af_0
