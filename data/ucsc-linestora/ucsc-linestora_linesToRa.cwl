cwlVersion: v1.2
class: CommandLineTool
baseCommand: linesToRa
label: ucsc-linestora_linesToRa
doc: "generate .ra format from lines with pipe-separated fields\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: input_file
    type: File
    doc: Input text file
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type: File
    doc: Output .ra file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-linestora:482--h0b57e2e_0
