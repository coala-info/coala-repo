cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainAntiRepeat
label: ucsc-chainantirepeat
doc: "Remove chains that are primarily repeats.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: target_2bit
    type: File
    doc: Target sequence in 2bit format
    inputBinding:
      position: 1
  - id: query_2bit
    type: File
    doc: Query sequence in 2bit format
    inputBinding:
      position: 2
  - id: in_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 3
outputs:
  - id: out_chain
    type: File
    doc: Output chain file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainantirepeat:482--h0b57e2e_0
