cwlVersion: v1.2
class: CommandLineTool
baseCommand: qacToQa
label: ucsc-qactoqa
doc: "Convert a .qac file to .qa format. (Note: The provided help text was incomplete
  due to a system error, but the tool is part of the UCSC Genome Browser utilities
  used for quality score file conversion.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_qac
    type: File
    doc: Input .qac file
    inputBinding:
      position: 1
outputs:
  - id: output_qa
    type: File
    doc: Output .qa file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-qactoqa:482--h0b57e2e_0
