cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSwap
label: ucsc-pslswap
doc: "Swaps target and query in a PSL (Pattern Space Layout) file.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_psl
    type: File
    doc: Input PSL file to be swapped.
    inputBinding:
      position: 1
outputs:
  - id: output_psl
    type: File
    doc: Output PSL file where the swapped results will be written.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslswap:482--h0b57e2e_0
