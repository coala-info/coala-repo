cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafToPsl
label: ucsc-maftopsl
doc: "Convert MAF format to PSL format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_maf
    type: File
    doc: Input MAF file
    inputBinding:
      position: 1
outputs:
  - id: out_psl
    type: File
    doc: Output PSL file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maftopsl:482--h0b57e2e_0
