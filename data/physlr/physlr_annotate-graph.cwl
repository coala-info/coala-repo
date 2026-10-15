cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, annotate-graph]
label: physlr_annotate-graph
doc: "Annotate a graph with a BED or PAF file of mappings and write it in GraphViz format.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: min_score
    type: ['null', int]
    doc: "remove mappings with score less than this [0]"
    inputBinding:
      position: 1
      prefix: -n
  - id: min_component_size
    type: ['null', int]
    doc: "remove components with fewer than this many vertices [0]"
    inputBinding:
      position: 2
      prefix: --min-component-size
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 3
      prefix: -V
  - id: graph_file
    type: File
    doc: "Graph file in TSV format (header U, m and optional mol; then a blank line and the U, V, m edge table)"
    inputBinding:
      position: 100
  - id: path_file
    type: File
    doc: "Backbone paths of the physical map"
    inputBinding:
      position: 101
  - id: mapping_files
    type: File[]
    doc: "BED or PAF file(s) of mappings (physlr map output)"
    inputBinding:
      position: 102
outputs:
  - id: result
    type: File
    doc: "Annotated graph in GraphViz format"
    outputBinding:
      glob: physlr_annotate-graph.gv
stdout: physlr_annotate-graph.gv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
