cwlVersion: v1.2
class: CommandLineTool
baseCommand: list-products
label: gff3toddbj_list-products
doc: "List the products (product qualifiers) found in a GFF3 file.\n\nTool homepage: https://github.com/yamaton/gff3toddbj"
inputs:
  - id: gff3
    type: File
    doc: "Input GFF3 file"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: "Product list"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gff3toddbj:0.4.3--pyhdfd78af_0
stdout: gff3toddbj_list-products.out
