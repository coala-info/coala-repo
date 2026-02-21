cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - estlen
label: treebest_estlen
doc: "Estimate branch lengths for a tree given a distance matrix and a tag.\n\nTool
  homepage: https://github.com/lh3/treebest"
inputs:
  - id: tree
    type: File
    doc: Input tree file
    inputBinding:
      position: 1
  - id: matrix
    type: File
    doc: Distance matrix file
    inputBinding:
      position: 2
  - id: tag
    type: string
    doc: Tag identifier
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_estlen.out
