cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, subgraph]
label: physlr_subgraph
doc: "Extract a vertex-induced subgraph.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: graph_files
    type: File[]
    doc: "Graph file(s) in TSV format (header U, m and optional mol; then a blank line and the U, V, m edge table)"
    inputBinding:
      position: 100
  - id: vertices
    type: string
    doc: "comma-separated list of vertices"
    inputBinding:
      position: 1
      prefix: -v
  - id: exclude_vertices
    type: ['null', string]
    doc: "comma-separated list of vertices to exclude"
    inputBinding:
      position: 2
      prefix: --exclude-vertices
  - id: distance
    type: ['null', int]
    doc: "include vertices within this many edges away [0]"
    inputBinding:
      position: 3
      prefix: -d
  - id: distance_max
    type: ['null', int]
    doc: "maximum acceptable value for --distance, to avoid slow runs [20]"
    inputBinding:
      position: 4
      prefix: --distance-max
  - id: output_format
    type: ['null', string]
    doc: "the output graph file format [tsv]. Only tsv works in this image (gv needs pygraphviz, which is missing)"
    inputBinding:
      position: 5
      prefix: -O
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 6
      prefix: -V
outputs:
  - id: result
    type: File
    doc: "Graph in TSV format"
    outputBinding:
      glob: physlr_subgraph.tsv
stdout: physlr_subgraph.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
