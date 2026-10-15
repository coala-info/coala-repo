cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, mst-troubleshoot]
label: physlr_mst-troubleshoot
doc: "Determine the pruned maximum spanning tree and write it with the length of the shorter branch of each edge as edge weight.\n\nTool homepage: https://github.com/BirolLab/physlr"
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
  - id: output_format
    type: ['null', string]
    doc: "the output graph file format [tsv]. Only tsv works in this image (gv needs pygraphviz, which is missing)"
    inputBinding:
      position: 3
      prefix: -O
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 4
      prefix: -V
outputs:
  - id: result
    type: File
    doc: "Graph in TSV format"
    outputBinding:
      glob: physlr_mst-troubleshoot.tsv
stdout: physlr_mst-troubleshoot.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
