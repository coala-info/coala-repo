cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafOrder
label: ucsc-maforder_mafOrder
doc: "order components within a maf file\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: maf_in
    type: File
    doc: Input MAF file
    inputBinding:
      position: 1
  - id: order_list
    type: File
    doc: File with one species per line specifying the order
    inputBinding:
      position: 2
outputs:
  - id: maf_out
    type: File
    doc: Output MAF file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maforder:482--h0b57e2e_0
