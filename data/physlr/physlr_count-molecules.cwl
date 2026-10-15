cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, count-molecules]
label: physlr_count-molecules
doc: "Estimate the number of molecules per barcode (counts the biconnected components of at least 4 vertices in the neighbourhood subgraph of each barcode).\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: min_shared_minimizers
    type: ['null', int]
    doc: "remove edges with fewer than this many shared minimizers [0]"
    inputBinding:
      position: 1
      prefix: -m
  - id: output_format
    type: ['null', string]
    doc: "the output graph file format [tsv]. Only tsv works in this image (gv needs pygraphviz, which is missing)"
    inputBinding:
      position: 2
      prefix: -O
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 3
      prefix: -V
  - id: graph_files
    type: File[]
    doc: "Graph file in TSV format (header U, m and optional mol; then a blank line and the U, V, m edge table)"
    inputBinding:
      position: 100
outputs:
  - id: result
    type: File
    doc: "Graph in TSV format with an added mol column (estimated molecules per barcode)"
    outputBinding:
      glob: physlr_count-molecules.tsv
stdout: physlr_count-molecules.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
