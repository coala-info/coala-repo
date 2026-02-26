cwlVersion: v1.2
class: CommandLineTool
baseCommand: sketchy info
label: sketchy_info
doc: "List sketch genome order, sketch build parameters\n\nTool homepage: https://github.com/esteinig/sketchy"
inputs:
  - id: input
    type: File
    doc: 'Sketch file, format: Mash (.msh) or Finch (.fsh)'
    inputBinding:
      position: 101
      prefix: --input
  - id: params
    type:
      - 'null'
      - boolean
    doc: Display the sketch build parameters
    inputBinding:
      position: 101
      prefix: --params
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchy:0.6.0--h7b50bb2_3
stdout: sketchy_info.out
