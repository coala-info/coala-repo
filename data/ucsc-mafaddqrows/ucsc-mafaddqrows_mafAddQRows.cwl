cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafAddQRows
label: ucsc-mafaddqrows_mafAddQRows
doc: "Add quality data to a maf\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: species_lst
    type: File
    doc: 'species.lst file where each line contains two fields: 1) species name, 2)
      directory where the .qac and .qdx files are located'
    inputBinding:
      position: 1
  - id: in_maf
    type: File
    doc: Input MAF file
    inputBinding:
      position: 2
  - id: divisor
    type:
      - 'null'
      - float
    doc: value to divide Q value by
    inputBinding:
      position: 103
      prefix: --divisor
outputs:
  - id: out_maf
    type: File
    doc: Output MAF file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafaddqrows:482--h0b57e2e_0
