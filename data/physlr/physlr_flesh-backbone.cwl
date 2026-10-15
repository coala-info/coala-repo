cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, flesh-backbone]
label: physlr_flesh-backbone
doc: "Flesh out the barcodes in the backbone paths: add each neighbour of a backbone barcode to the path next to its best-supported backbone barcode.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: graph_file
    type: File
    doc: "Graph file in TSV format"
    inputBinding:
      position: 100
  - id: backbone_paths
    type: File
    doc: "Backbone path file: one path per line, barcodes separated by spaces"
    inputBinding:
      position: 101
  - id: min_component_size
    type: ['null', int]
    doc: "remove components with fewer than this many vertices [0]"
    inputBinding:
      position: 1
      prefix: --min-component-size
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 2
      prefix: -V
outputs:
  - id: result
    type: File
    doc: "Backbone paths with flesh barcodes in parentheses"
    outputBinding:
      glob: physlr_flesh-backbone.path
stdout: physlr_flesh-backbone.path
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
