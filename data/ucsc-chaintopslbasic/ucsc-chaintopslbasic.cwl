cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainToPslBasic
label: ucsc-chaintopslbasic
doc: "Basic conversion of a chain file to psl format. If you need match and mismatch
  stats updated, pipe the output through pslRecalcMatch.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 1
  - id: out_psl
    type: string
    doc: Name of the output psl file
    inputBinding:
      position: 2
outputs:
  - id: output_psl
    type: File
    doc: Output psl file
    outputBinding:
      glob: $(inputs.out_psl)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chaintopslbasic:482--h0b57e2e_0
