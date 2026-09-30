cwlVersion: v1.2
class: CommandLineTool
baseCommand: qaToQac
label: ucsc-qatoqac_qaToQac
doc: "convert from uncompressed to compressed quality score format.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_qa
    type: File
    doc: Input uncompressed quality score file
    inputBinding:
      position: 1
  - id: out_qac
    type: string
    doc: Output compressed quality score file
    inputBinding:
      position: 2
outputs:
  - id: out_out_qac
    type: File
    doc: Output compressed quality score file
    outputBinding:
      glob: '$(inputs.out_qac)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-qatoqac:482--h0b57e2e_0
