cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslToChain
label: ucsc-psltochain
doc: "Convert psl format to chain format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_psl
    type: File
    doc: Input psl file
    inputBinding:
      position: 1
  - id: linear_gap
    type:
      - 'null'
      - File
    doc: Specify linear gap costs
    inputBinding:
      position: 102
      prefix: -linearGap
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbosity level
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: output_chain
    type: File
    doc: Output chain file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psltochain:482--h0b57e2e_0
