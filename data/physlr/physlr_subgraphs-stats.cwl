cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, subgraphs-stats]
label: physlr_subgraphs-stats
doc: "Report the number of vertices, edges and the density of the neighbourhood subgraph of each barcode (or of the barcodes listed in a second file; this list is used only when more than one thread is used).\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: threads
    type: ['null', int]
    doc: "number of threads [16 or number of CPU]"
    inputBinding:
      position: 1
      prefix: -t
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 2
      prefix: -V
  - id: graph_file
    type: File
    doc: "Graph file in TSV format (header U, m and optional mol; then a blank line and the U, V, m edge table)"
    inputBinding:
      position: 100
  - id: vertices_file
    type: ['null', File]
    doc: "TSV file listing barcodes in the first column; statistics are computed for these barcodes only"
    inputBinding:
      position: 101
outputs:
  - id: result
    type: File
    doc: "Table with the columns Barcode, Nodes, Edges, Density"
    outputBinding:
      glob: physlr_subgraphs-stats.tsv
stdout: physlr_subgraphs-stats.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
