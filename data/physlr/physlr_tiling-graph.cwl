cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, tiling-graph]
label: physlr_tiling-graph
doc: "Determine the minimum-tiling-path-induced subgraph.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: graph_files
    type: File[]
    doc: "Graph file(s) in TSV format (header U, m and optional mol; then a blank line and the U, V, m edge table)"
    inputBinding:
      position: 100
  - id: min_shared_minimizers
    type: ['null', int]
    doc: "remove edges with fewer than this many shared minimizers [0]"
    inputBinding:
      position: 1
      prefix: -m
  - id: prune_bridges
    type: ['null', int]
    doc: "size of the bridges to be pruned [0]. Set to 0 to skip bridge pruning"
    inputBinding:
      position: 2
      prefix: --prune-bridges
  - id: prune_branches
    type: ['null', int]
    doc: "size of the branches to be pruned [10]. Set to 0 to skip pruning"
    inputBinding:
      position: 3
      prefix: --prune-branches
  - id: prune_junctions
    type: ['null', int]
    doc: "split a backbone path when the alternative branch is longer than this [0]. Set to 0 to skip"
    inputBinding:
      position: 4
      prefix: --prune-junctions
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
      glob: physlr_tiling-graph.tsv
stdout: physlr_tiling-graph.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
