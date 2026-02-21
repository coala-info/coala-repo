cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromGraphToBin
label: ucsc-chromgraphfrombin_chromGraphToBin
doc: "Convert chromGraph format to binary format. (Note: The provided help text contains
  only system error messages and no usage information; arguments were inferred from
  standard tool documentation).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: Input chromGraph file
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type: File
    doc: Output binary file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chromgraphfrombin:482--h0b57e2e_0
