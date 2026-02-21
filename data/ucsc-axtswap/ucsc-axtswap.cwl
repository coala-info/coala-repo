cwlVersion: v1.2
class: CommandLineTool
baseCommand: axtSwap
label: ucsc-axtswap
doc: "Swap target and query in axt file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_axt
    type: File
    doc: Input axt file to be swapped.
    inputBinding:
      position: 1
outputs:
  - id: output_axt
    type: File
    doc: Output axt file with target and query swapped.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-axtswap:482--h0b57e2e_0
