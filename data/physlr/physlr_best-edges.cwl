cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, best-edges]
label: physlr_best-edges
doc: "Keep the best edges of each vertex of a graph.\n\nTool homepage: https://github.com/BirolLab/physlr"
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
  - id: best_edges
    type: ['null', int]
    doc: "keep the best m edges of each vertex [None]"
    inputBinding:
      position: 2
      prefix: --bestm
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
      glob: physlr_best-edges.tsv
stdout: physlr_best-edges.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
