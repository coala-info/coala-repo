cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/src/physlr-overlap]
label: physlr_overlap
doc: "Read a sketch of linked reads and find overlapping barcodes: write the graph of barcodes that share at least m minimizers.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: min_shared_minimizers
    type: ['null', int]
    doc: "remove edges with fewer than this many shared markers [10]"
    inputBinding:
      position: 1
      prefix: -m
  - id: threads
    type: ['null', int]
    doc: "number of threads [1]"
    inputBinding:
      position: 2
      prefix: -t
  - id: minimizers
    type: File
    doc: "Minimizer TSV file as written by physlr-indexlr"
    inputBinding:
      position: 100
outputs:
  - id: result
    type: File
    doc: "Graph in TSV format (header U, m with the number of minimizers per barcode; then a blank line and the U, V, m edge table)"
    outputBinding:
      glob: physlr_overlap.tsv
stdout: physlr_overlap.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
