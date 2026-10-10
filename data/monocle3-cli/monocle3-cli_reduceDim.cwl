cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - monocle3
  - reduceDim
label: monocle3-cli_reduceDim
doc: "Reduce dimensionality by UMAP.\n\nTool homepage: https://github.com/ebi-gene-expression-group/monocle-scripts"
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
  - id: max_components
    type:
      - 'null'
      - int
    doc: "The dimensionality of the reduced space. [Default 2]"
    inputBinding:
      position: 103
      prefix: --max-components
  - id: reduction_method
    type:
      - 'null'
      - string
    doc: "The algorithm to use for dimensionality reduction, choose from {UMAP, tSNE, PCA, LSI}. [Default: UMAP]"
    inputBinding:
      position: 103
      prefix: --reduction-method
  - id: preprocess_method
    type:
      - 'null'
      - string
    doc: "The preprocessing method used on the data, choose from {PCA, LSI}. [Default: PCA]"
    inputBinding:
      position: 103
      prefix: --preprocess-method
  - id: cores
    type:
      - 'null'
      - int
    doc: "The number of cores to be used for dimensionality reduction. [Default: 1]"
    inputBinding:
      position: 103
      prefix: --cores
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
