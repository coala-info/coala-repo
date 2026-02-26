cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafToSnpBed
label: ucsc-maftosnpbed_mafToSnpBed
doc: "finds SNPs in MAF and builds a bed with their functional consequence\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: database
    inputBinding:
      position: 1
  - id: input_maf
    type: File
    doc: input.maf
    inputBinding:
      position: 2
  - id: input_gp
    type: File
    doc: input.gp
    inputBinding:
      position: 3
  - id: xxx
    type:
      - 'null'
      - string
    inputBinding:
      position: 104
      prefix: -xxx
outputs:
  - id: output_bed
    type: File
    doc: output.bed
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maftosnpbed:482--h0b57e2e_0
