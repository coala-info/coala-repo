cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - monocle3
  - orderCells
label: monocle3-cli_orderCells
doc: "Adjust the start of pseudo-time\n\nTool homepage: https://github.com/ebi-gene-expression-group/monocle-scripts"
inputs:
  - id: input_object
    type: File
    doc: "Input object, CellDataSet V3 (cds3) as an RDS file. Only cds3 is supported currently."
    inputBinding:
      position: 1
  - id: output_object
    type: string
    doc: "Output object file name (cds3 as RDS)."
    inputBinding:
      position: 2
  - id: input_object_format
    type:
      - 'null'
      - string
    doc: "Format of input object. [Default: cds3]"
    inputBinding:
      position: 103
      prefix: -f
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
  - id: root_pr_nodes
    type:
      - 'null'
      - string
    doc: "The starting principal points. We learn a principal graph that passes through the middle of the data points and use it to represent the developmental process. Exclusive with --root-cells."
    inputBinding:
      position: 103
      prefix: --root-pr-nodes
  - id: root_cells
    type:
      - 'null'
      - string
    doc: "The starting cells. Each cell corresponds to a principal point and multiple cells can correspond to the same principal point. Exclusive with --root-pr-nodes."
    inputBinding:
      position: 103
      prefix: --root-cells
  - id: cell_phenotype
    type:
      - 'null'
      - string
    doc: "The cell phenotype (column in pdata) used to identify root principal nodes."
    inputBinding:
      position: 103
      prefix: --cell-phenotype
  - id: root_type
    type:
      - 'null'
      - string
    doc: "The value of the phenotype specified by \"--cell-pheontype\" that defines cells root principal nodes."
    inputBinding:
      position: 103
      prefix: --root-type
  - id: reduction_method
    type:
      - 'null'
      - string
    doc: "The dimensionality reduction that was used for clustering, choose from {UMAP, tSNE, PCA, LSI}. [Default: UMAP]"
    inputBinding:
      position: 103
      prefix: --reduction-method
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
