cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - monocle3
  - partition
label: monocle3-cli_partition
doc: "Partition cells into groups.\n\nTool homepage: https://github.com/ebi-gene-expression-group/monocle-scripts"
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
  - id: reduction_method
    type:
      - 'null'
      - string
    doc: "The dimensionality reduction to base the clustering on, choose from {UMAP, tSNE, PCA, LSI}. [Default: UMAP]"
    inputBinding:
      position: 103
      prefix: --reduction-method
  - id: knn
    type:
      - 'null'
      - int
    doc: "Number of nearest neighbours used for Louvain clustering. [Default: 20]"
    inputBinding:
      position: 103
      prefix: --knn
  - id: weight
    type:
      - 'null'
      - boolean
    doc: "When this option is set, calculate the weight for each edge in the kNN graph."
    inputBinding:
      position: 103
      prefix: --weight
  - id: louvain_iter
    type:
      - 'null'
      - int
    doc: "The number of iteration for Louvain clustering. [Default: 1]"
    inputBinding:
      position: 103
      prefix: --louvain-iter
  - id: resolution
    type:
      - 'null'
      - float
    doc: "Resolution of clustering result, specifying the granularity of clusters. Not used by default and the standard igraph louvain clustering algorithm will be used."
    inputBinding:
      position: 103
      prefix: --resolution
  - id: partition_qval
    type:
      - 'null'
      - float
    doc: "The q-value threshold used to determine the partition of cells. [Default: 0.05]"
    inputBinding:
      position: 103
      prefix: --partition-qval
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
