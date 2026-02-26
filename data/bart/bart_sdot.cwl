cwlVersion: v1.2
class: CommandLineTool
baseCommand: sdot
label: bart_sdot
doc: "Compute dot product along selected dimensions.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: input1
    type: string
    doc: First input
    inputBinding:
      position: 1
  - id: input2
    type: string
    doc: Second input
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_sdot.out
