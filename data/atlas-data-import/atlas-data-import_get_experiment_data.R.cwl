cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/get_experiment_data.R
label: atlas-data-import_get_experiment_data.R
doc: "Downloads data from the ArrayExpress database.\n\nTool homepage: https://github.com/ebi-gene-expression-group/atlas-data-import"
inputs:
  - id: accession_code
    type: string
    doc: Accession code of the data set to be extracted.
    inputBinding:
      position: 101
      prefix: --accession-code
  - id: decorated_rows
    type:
      - 'null'
      - boolean
    doc: Should the decorated version of row names be downloaded?
    default: false
    inputBinding:
      position: 101
      prefix: --decorated-rows
  - id: exp_data_dir
    type:
      - 'null'
      - Directory
    doc: Output name for expression data directory
    inputBinding:
      position: 101
      prefix: --exp-data-dir
  - id: experiments_prefix
    type:
      - 'null'
      - string
    doc: URL prefix for scxa experiments.
    inputBinding:
      position: 101
      prefix: --experiments-prefix
  - id: get_condensed_sdrf
    type:
      - 'null'
      - boolean
    doc: Should condensed SDRF file(s) be downloaded?
    default: false
    inputBinding:
      position: 101
      prefix: --get-condensed-sdrf
  - id: get_exp_design
    type:
      - 'null'
      - boolean
    doc: Should experimental design file be downloaded?
    default: false
    inputBinding:
      position: 101
      prefix: --get-exp-design
  - id: get_expression_data
    type:
      - 'null'
      - boolean
    doc: Should expression data be downloaded?
    default: false
    inputBinding:
      position: 101
      prefix: --get-expression-data
  - id: get_idf
    type:
      - 'null'
      - boolean
    doc: Should IDF file(s) be downloaded?
    default: false
    inputBinding:
      position: 101
      prefix: --get-idf
  - id: get_marker_genes
    type:
      - 'null'
      - boolean
    doc: Should marker gene file(s) be downloaded?
    default: false
    inputBinding:
      position: 101
      prefix: --get-marker-genes
  - id: get_sdrf
    type:
      - 'null'
      - boolean
    doc: Should SDRF file(s) be downloaded?
    default: false
    inputBinding:
      position: 101
      prefix: --get-sdrf
  - id: markers_cell_grouping
    type:
      - 'null'
      - string
    doc: What type of cell grouping is used for marker gene file? By default, 
      markers for inferred cell types are downloaded. If supplying an integer 
      value, an automatically-derived marker gene file for a corresponding 
      number of clusters will be imported.
    inputBinding:
      position: 101
      prefix: --markers-cell-grouping
  - id: matrix_type
    type:
      - 'null'
      - string
    doc: Type of expression data to download. Must be one of 'raw', 'filtered', 
      'TPM' or 'CPM'
    inputBinding:
      position: 101
      prefix: --matrix-type
  - id: output_dir_name
    type:
      - 'null'
      - string
    doc: Name of the output directory containing study data. Default directory 
      name is the provided accession code
    inputBinding:
      position: 101
      prefix: --output-dir-name
  - id: use_default_expr_names
    type:
      - 'null'
      - boolean
    doc: Should default (non 10x-type) file names be used for expression data?
    default: false
    inputBinding:
      position: 101
      prefix: --use-default-expr-names
  - id: use_full_names
    type:
      - 'null'
      - boolean
    doc: Should non-expression data files be named with full file names?
    default: false
    inputBinding:
      position: 101
      prefix: --use-full-names
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas-data-import:0.1.1--hdfd78af_0
stdout: atlas-data-import_get_experiment_data.R.out
