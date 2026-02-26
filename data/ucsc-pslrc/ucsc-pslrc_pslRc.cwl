cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslRc
label: ucsc-pslrc_pslRc
doc: "reverse-complement psl\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: inPsl
    type: File
    doc: Input PSL file
    inputBinding:
      position: 1
outputs:
  - id: outPsl
    type: File
    doc: Output PSL file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslrc:482--h0b57e2e_0
