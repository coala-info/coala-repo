cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - treedist
label: treebest_treedist
doc: "Calculate the distance between two trees\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: tree1
    type: File
    doc: First tree file
    inputBinding:
      position: 1
  - id: tree2
    type: File
    doc: Second tree file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_treedist.out
