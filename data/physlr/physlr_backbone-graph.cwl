cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, backbone-graph]
label: physlr_backbone-graph
doc: "Determine the backbone-induced subgraph: remove poorly supported (chimeric) barcodes iteratively and write the subgraph of the backbone paths.\n\nTool homepage: https://github.com/BirolLab/physlr"
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
  - id: distance
    type: ['null', int]
    doc: "include vertices within this many edges away [0]"
    inputBinding:
      position: 4
      prefix: -d
  - id: support
    type: ['null', int]
    doc: "minimum number of barcodes required to support a position [3]"
    inputBinding:
      position: 5
      prefix: -s
  - id: min_path_size
    type: ['null', int]
    doc: "skip paths with fewer than this many barcodes [200]"
    inputBinding:
      position: 6
      prefix: --min-path-size
  - id: output_format
    type: ['null', string]
    doc: "the output graph file format [tsv]. Only tsv works in this image (gv needs pygraphviz, which is missing)"
    inputBinding:
      position: 7
      prefix: -O
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 8
      prefix: -V
  - id: chimera_table
    type: ['null', string]
    doc: "write a table of the support of each backbone position (columns Tname, Pos, U, V, W, Overlap, Depth, Support) to this file"
    inputBinding:
      position: 20
      prefix: -o
outputs:
  - id: result
    type: File
    doc: "Graph in TSV format"
    outputBinding:
      glob: physlr_backbone-graph.tsv
  - id: chimera_support_table
    type: ['null', File]
    doc: "Support table of the backbone positions, written when chimera_table is set"
    outputBinding:
      glob: $(inputs.chimera_table)
stdout: physlr_backbone-graph.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
