cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainSort
label: ucsc-chainsort
doc: "Sort a chain file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_chain
    type: File
    doc: The input chain file to be sorted.
    inputBinding:
      position: 1
outputs:
  - id: output_chain
    type: File
    doc: The sorted output chain file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainsort:482--h0b57e2e_0
