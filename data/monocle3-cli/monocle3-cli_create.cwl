cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - monocle3
  - create
label: monocle3-cli_create
doc: "Creation of Monocle 3 object from expression and metadata.\n\nTool homepage: https://github.com/ebi-gene-expression-group/monocle-scripts"
inputs:
  - id: output_object
    type: string
    doc: "Output object file name (cds3 as RDS). Only cds3 is supported currently."
    inputBinding:
      position: 1
  - id: output_object_format
    type:
      - 'null'
      - string
    doc: "Format of output object. [Default: cds3]"
    inputBinding:
      position: 103
      prefix: -F
  - id: introspective
    type:
      - 'null'
      - boolean
    doc: "Print introspective information of the output object."
    inputBinding:
      position: 103
      prefix: -I
  - id: expression_matrix
    type: File
    doc: "Expression matrix, genes as rows, cells as columns. Required input. Provide as TSV, CSV, RDS or MTX. In the case of MTX, requires both --cell-metadata and --gene-annotation."
    inputBinding:
      position: 103
      prefix: --expression-matrix
  - id: cell_metadata
    type:
      - 'null'
      - File
    doc: "Per-cell annotation, optional unless expression as MTX. Row names must match the column names of the expression matrix. Provide as TSV, CSV or RDS."
    inputBinding:
      position: 103
      prefix: --cell-metadata
  - id: gene_annotation
    type:
      - 'null'
      - File
    doc: "Per-gene annotation, optional unless expression as MTX. Row names must match the row names of the expression matrix. Provide as TSV, CSV or RDS."
    inputBinding:
      position: 103
      prefix: --gene-annotation
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Emit verbose output."
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: output_object
    type: File
    doc: "Output object"
    outputBinding:
      glob: $(inputs.output_object)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
