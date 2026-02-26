cwlVersion: v1.2
class: CommandLineTool
baseCommand: netChainSubset
label: ucsc-chainswap_netChainSubset
doc: "Create a chain file from a net file and the original chains. This tool subsets
  a chain file based on the alignments that were kept in a corresponding net file.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_net
    type: File
    doc: Input net file
    inputBinding:
      position: 1
  - id: in_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 2
  - id: split_on_gap
    type:
      - 'null'
      - boolean
    doc: Split chain when a gap is encountered in the net
    inputBinding:
      position: 103
      prefix: -splitOnGap
outputs:
  - id: out_chain
    type: File
    doc: Output chain file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainswap:482--h0b57e2e_0
