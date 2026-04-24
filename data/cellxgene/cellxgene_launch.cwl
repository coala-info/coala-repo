cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellxgene launch
label: cellxgene_launch
doc: "Launch the cellxgene data viewer. This web app lets you explore single-cell
  expression data. Data must be in a format that cellxgene expects. Read the \"getting
  started\" guide to learn more: https://github.com/chanzuckerberg/cellxgene- documentation/blob/main/README.md\n\
  \nTool homepage: https://chanzuckerberg.github.io/cellxgene/"
inputs:
  - id: data_file
    type: File
    doc: path to data file
    inputBinding:
      position: 1
  - id: X_approximate_distribution
    type:
      - 'null'
      - string
    doc: Specify the approximate distribution of X matrix values. 'auto' will 
      use a heuristic to determine the approximate distribution. Mode 'auto' is 
      incompatible with --backed.
    inputBinding:
      position: 102
      prefix: --X-approximate-distribution
  - id: about
    type:
      - 'null'
      - string
    doc: 'URL providing more information about the dataset (hint: must be a fully
      specified absolute URL).'
    inputBinding:
      position: 102
      prefix: --about
  - id: annotations_dir
    type:
      - 'null'
      - Directory
    doc: Directory of where to save output annotations; filename will be 
      specified in the application. Incompatible with --annotations-file and 
      --gene-sets-file.
    inputBinding:
      position: 102
      prefix: --annotations-dir
  - id: annotations_file
    type:
      - 'null'
      - File
    doc: CSV file to initialize editing of existing annotations; will be altered
      in-place. Incompatible with --user-generated-data-dir.
    inputBinding:
      position: 102
      prefix: --annotations-file
  - id: backed
    type:
      - 'null'
      - boolean
    doc: Load anndata in file-backed mode. This may save memory, but may result 
      in slower overall performance.
    inputBinding:
      position: 102
      prefix: --backed
  - id: config_file
    type:
      - 'null'
      - File
    doc: Location to yaml file with configuration settings
    inputBinding:
      position: 102
      prefix: --config-file
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Run in debug mode. This is helpful for cellxgene developers, or when 
      you want more information about an error condition.
    inputBinding:
      position: 102
      prefix: --debug
  - id: diffexp_lfc_cutoff
    type:
      - 'null'
      - float
    doc: Minimum log fold change threshold for differential expression.
    inputBinding:
      position: 102
      prefix: --diffexp-lfc-cutoff
  - id: disable_annotations
    type:
      - 'null'
      - boolean
    doc: Disable user annotation of data.
    inputBinding:
      position: 102
      prefix: --disable-annotations
  - id: disable_custom_colors
    type:
      - 'null'
      - boolean
    doc: Disable user-defined category-label colors drawn from source data file.
    inputBinding:
      position: 102
      prefix: --disable-custom-colors
  - id: disable_diffexp
    type:
      - 'null'
      - boolean
    doc: Disable on-demand differential expression.
    inputBinding:
      position: 102
      prefix: --disable-diffexp
  - id: disable_gene_sets_save
    type:
      - 'null'
      - boolean
    doc: Disable saving gene sets. If disabled, users will be able to make 
      changes to gene sets but all changes will be lost on browser refresh.
    inputBinding:
      position: 102
      prefix: --disable-gene-sets-save
  - id: dump_default_config
    type:
      - 'null'
      - boolean
    doc: Print default configuration settings and exit
    inputBinding:
      position: 102
      prefix: --dump-default-config
  - id: embedding
    type:
      - 'null'
      - type: array
        items: string
    doc: Embedding name, eg, 'umap'. Repeat option for multiple embeddings. 
      Defaults to all.
    inputBinding:
      position: 102
      prefix: --embedding
  - id: gene_sets_file
    type:
      - 'null'
      - File
    doc: CSV file to initialize editing of gene sets; will be altered in-place. 
      Incompatible with --user-generated-data-dir.
    inputBinding:
      position: 102
      prefix: --gene-sets-file
  - id: host
    type:
      - 'null'
      - string
    doc: Host IP address. By default cellxgene will use localhost (e.g. 
      127.0.0.1).
    inputBinding:
      position: 102
      prefix: --host
  - id: max_category_items
    type:
      - 'null'
      - int
    doc: Will not display categories with more distinct values than specified.
    inputBinding:
      position: 102
      prefix: --max-category-items
  - id: obs_names
    type:
      - 'null'
      - string
    doc: Name of annotation field to use for observations. If not specified 
      cellxgene will use the the obs index.
    inputBinding:
      position: 102
      prefix: --obs-names
  - id: open
    type:
      - 'null'
      - boolean
    doc: Open web browser after launch.
    inputBinding:
      position: 102
      prefix: --open
  - id: port
    type:
      - 'null'
      - int
    doc: Port to run server on. If not specified cellxgene will find an 
      available port.
    inputBinding:
      position: 102
      prefix: --port
  - id: scripts
    type:
      - 'null'
      - string
    doc: Additional script files to include in HTML page. If not specified, no 
      additional script files will be included.
    inputBinding:
      position: 102
      prefix: --scripts
  - id: title
    type:
      - 'null'
      - string
    doc: Title to display. If omitted will use file name.
    inputBinding:
      position: 102
      prefix: --title
  - id: user_generated_data_dir
    type:
      - 'null'
      - Directory
    doc: Directory of where to save output annotations; filename will be 
      specified in the application. Incompatible with --annotations-file and 
      --gene-sets-file.
    inputBinding:
      position: 102
      prefix: --user-generated-data-dir
  - id: var_names
    type:
      - 'null'
      - string
    doc: Name of annotation to use for variables. If not specified cellxgene 
      will use the the var index.
    inputBinding:
      position: 102
      prefix: --var-names
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Provide verbose output, including warnings and all server requests.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellxgene:1.3.0--pyhdfd78af_0
stdout: cellxgene_launch.out
