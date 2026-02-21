cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - trans
label: treebest_trans
doc: "Translate a nucleotide alignment\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: nucl_alignment
    type: File
    doc: Input nucleotide alignment file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_trans.out
