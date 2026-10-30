cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-filter-cells.R
label: seurat-scripts_seurat-filter-cells.R
doc: 'Filter cells of a Seurat object on gene, metadata or reduction values (Seurat subset).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: input_object_file
    type: File
    doc: File name in which a serialized R matrix object may be found.
    inputBinding:
      position: 1
      prefix: --input-object-file=
      separate: false
  - id: subset_names
    type: string
    doc: Parameters to subset on. Eg, the name of a gene, PC1, a column name in object@meta.data, etc. Any argument that can be retreived using FetchData.
    inputBinding:
      position: 2
      prefix: --subset-names=
      separate: false
  - id: output_object_file
    type: string
    doc: File name in which to store serialized R object of type 'Seurat'.'
    inputBinding:
      position: 3
      prefix: --output-object-file=
      separate: false
  - id: input_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the input format to read.
    inputBinding:
      position: 4
      prefix: --input-format=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the output format.
    inputBinding:
      position: 5
      prefix: --output-format=
      separate: false
  - id: low_thresholds
    type:
      - 'null'
      - string
    doc: Low cutoffs for the parameters (default is -Inf).
    inputBinding:
      position: 6
      prefix: --low-thresholds=
      separate: false
  - id: high_thresholds
    type:
      - 'null'
      - string
    doc: High cutoffs for the parameters (default is Inf).
    inputBinding:
      position: 7
      prefix: --high-thresholds=
      separate: false
  - id: cells_use
    type:
      - 'null'
      - string
      - File
    doc: Comma-separated list of cell names to use as a subset. Alternatively, text file with one cell per line.
    inputBinding:
      position: 8
      prefix: --cells-use=
      separate: false
  - id: idents
    type:
      - 'null'
      - string
    doc: Comma-separated list of identity classes to keep
    inputBinding:
      position: 9
      prefix: --idents=
      separate: false
  - id: features
    type:
      - 'null'
      - string
      - File
    doc: Comma-separated list or file path with features (normally genes) to keep
    inputBinding:
      position: 10
      prefix: --features=
      separate: false
outputs:
  - id: output_object_file
    type: File
    doc: File name in which to store serialized R object of type 'Seurat'.'
    outputBinding:
      glob: $(inputs.output_object_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
