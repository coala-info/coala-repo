cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, filter]
label: physlr_filter
doc: "Filter a graph: remove edges with few shared minimizers, barcodes with many molecules, and small components.\n\nTool homepage: https://github.com/BirolLab/physlr"
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
  - id: max_molecules
    type: ['null', int]
    doc: "remove barcodes with this many or more molecules [None]. Needs a graph whose vertices have a molecule count column"
    inputBinding:
      position: 2
      prefix: -M
  - id: min_component_size
    type: ['null', int]
    doc: "remove components with fewer than this many vertices [0]"
    inputBinding:
      position: 3
      prefix: --min-component-size
  - id: output_format
    type: ['null', string]
    doc: "the output graph file format [tsv]. Only tsv works in this image (gv needs pygraphviz, which is missing)"
    inputBinding:
      position: 4
      prefix: -O
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 5
      prefix: -V
outputs:
  - id: result
    type: File
    doc: "Graph in TSV format"
    outputBinding:
      glob: physlr_filter.tsv
stdout: physlr_filter.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
