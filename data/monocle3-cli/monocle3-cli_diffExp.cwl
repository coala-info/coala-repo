cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - monocle3
  - diffExp
label: monocle3-cli_diffExp
doc: "Identify genes with varing expression along trajectories.\n\nTool homepage: https://github.com/ebi-gene-expression-group/monocle-scripts"
inputs:
  - id: input_object
    type: File
    doc: "Input object, CellDataSet V3 (cds3) as an RDS file. Only cds3 is supported currently."
    inputBinding:
      position: 1
  - id: output_table
    type: string
    doc: "Output table file name."
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
  - id: output_table_format
    type:
      - 'null'
      - string
    doc: "Format of output table, choose from {tsv, csv}. [Default: tsv]"
    inputBinding:
      position: 103
      prefix: -F
  - id: introspective
    type:
      - 'null'
      - boolean
    doc: "Print introspective information of the output table."
    inputBinding:
      position: 103
      prefix: -I
  - id: neighbor_graph
    type:
      - 'null'
      - string
    doc: "What neighbor graph to use, \"principal_graph\" recommended for trajectory analysis, choose from {principal_graph, knn}. [Default: knn]"
    inputBinding:
      position: 103
      prefix: --neighbor-graph
  - id: reduction_method
    type:
      - 'null'
      - string
    doc: "The dimensionality reduction to base the clustering on, choose from {UMAP}. [Default: UMAP]"
    inputBinding:
      position: 103
      prefix: --reduction-method
  - id: knn
    type:
      - 'null'
      - int
    doc: "Number of nearest neighbors used for building the kNN graph which is passed to knn2nb function during the Moran's I (Geary's C) test procedure."
    inputBinding:
      position: 103
      prefix: --knn
  - id: method
    type:
      - 'null'
      - string
    doc: "A character string specifying the method for detecting significant genes showing correlated expression along the principal graph embedded in the low dimensional space, choose from {Moran_I}. [Default: Moran_I]"
    inputBinding:
      position: 103
      prefix: --method
  - id: alternative
    type:
      - 'null'
      - string
    doc: "A character string specifying the alternative hypothesis, choose from {greater, less, two.sided}. [Default: greater]"
    inputBinding:
      position: 103
      prefix: --alternative
  - id: cores
    type:
      - 'null'
      - int
    doc: "The number of cores to be used while testing each gene for differential expression. [Default: 1]"
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
  - id: output_table
    type: File
    doc: "Output table"
    outputBinding:
      glob: $(inputs.output_table)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
