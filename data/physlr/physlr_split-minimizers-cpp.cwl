cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/src/physlr-split-minimizers]
label: physlr_split-minimizers-cpp
doc: "Given the molecule overlap graph, split the minimizers of each barcode into molecules (compiled version of physlr split-minimizers; vertices are named barcode_N).\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: threads
    type: ['null', int]
    doc: "number of threads"
    inputBinding:
      position: 1
      prefix: -t
  - id: graph_file
    type: File
    doc: "Molecule overlap graph in TSV format (as written by physlr molecules)"
    inputBinding:
      position: 100
  - id: minimizers_file
    type: File
    doc: "Barcode to minimizers table in TSV format"
    inputBinding:
      position: 101
outputs:
  - id: result
    type: File
    doc: "TSV table: molecule name, a tab, then the space-separated minimizers of that molecule"
    outputBinding:
      glob: physlr_split-minimizers-cpp.tsv
stdout: physlr_split-minimizers-cpp.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
