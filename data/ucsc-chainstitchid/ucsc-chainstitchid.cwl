cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainStitchId
label: ucsc-chainstitchid
doc: "Join chain fragments with the same chain ID into a single chain per ID. Chain
  fragments must be from same original chain but must not overlap. Chain fragment
  scores are summed.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 1
  - id: out_chain
    type: string
    doc: Name of the output chain file
    inputBinding:
      position: 2
outputs:
  - id: output_chain
    type: File
    doc: Output chain file with one chain per ID
    outputBinding:
      glob: $(inputs.out_chain)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainstitchid:482--h0b57e2e_0
