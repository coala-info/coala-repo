cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslMapPostChain
label: ucsc-pslmappostchain
doc: "Post-process pslMap output to chain together alignments.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: in_psl
    type: File
    doc: Input PSL file (output from pslMap).
    inputBinding:
      position: 1
outputs:
  - id: out_psl
    type: File
    doc: Output PSL file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslmappostchain:482--h0b57e2e_0
