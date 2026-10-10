cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - monocle3
  - preprocess
label: monocle3-cli_preprocess
doc: "Normalisation, scaling, initial dimension reduction.\n\nTool homepage: https://github.com/ebi-gene-expression-group/monocle-scripts"
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
  - id: method
    type:
      - 'null'
      - string
    doc: "The initial dimension method to use, choose from {PCA, LSI}. [Default: PCA]"
    inputBinding:
      position: 103
      prefix: --method
  - id: num_dim
    type:
      - 'null'
      - int
    doc: "The dimensionality of the reduced space. [Default: 50]"
    inputBinding:
      position: 103
      prefix: --num-dim
  - id: norm_method
    type:
      - 'null'
      - string
    doc: "Determines how to transform expression values prior to reducing dimensionality, choose from {log, size_only}. [Default: log]"
    inputBinding:
      position: 103
      prefix: --norm-method
  - id: use_genes
    type:
      - 'null'
      - string
    doc: "Manually subset the gene pool to these genes for dimensionality reduction, NULL to skip. [Default: NULL]"
    inputBinding:
      position: 103
      prefix: --use-genes
  - id: residual_model_formula_str
    type:
      - 'null'
      - string
    doc: "A string model formula specifying effects to subtract from the data, NULL to skip. [Default: NULL]"
    inputBinding:
      position: 103
      prefix: --residual-model-formula-str
  - id: pseudo_count
    type:
      - 'null'
      - float
    doc: "Amount to increase expression values before dimensionality reduction. [Default: 1]"
    inputBinding:
      position: 103
      prefix: --pseudo-count
  - id: no_scaling
    type:
      - 'null'
      - boolean
    doc: "When this option is NOT set, scale each gene before running trajectory reconstruction."
    inputBinding:
      position: 103
      prefix: --no-scaling
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
