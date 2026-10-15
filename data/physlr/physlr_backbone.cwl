cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, backbone]
label: physlr_backbone
doc: "Determine the backbone paths of the graph and print one path per line.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: graph_files
    type: File[]
    doc: "Graph file(s) in TSV format (header U, m and optional mol; then a blank line and the U, V, m edge table)"
    inputBinding:
      position: 100
  - id: prune_bridges
    type: ['null', int]
    doc: "size of the bridges to be pruned [0]. Set to 0 to skip bridge pruning"
    inputBinding:
      position: 1
      prefix: --prune-bridges
  - id: prune_branches
    type: ['null', int]
    doc: "size of the branches to be pruned [10]. Set to 0 to skip pruning"
    inputBinding:
      position: 2
      prefix: --prune-branches
  - id: prune_junctions
    type: ['null', int]
    doc: "split a backbone path when the alternative branch is longer than this [0]. Set to 0 to skip"
    inputBinding:
      position: 3
      prefix: --prune-junctions
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 4
      prefix: -V
outputs:
  - id: result
    type: File
    doc: "Backbone paths, one path per line"
    outputBinding:
      glob: physlr_backbone.path
stdout: physlr_backbone.path
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
