cwlVersion: v1.2
class: CommandLineTool
baseCommand: zexp
label: bart_zexp
doc: "Point-wise complex exponential.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: input
    type: string
    doc: input
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 2
  - id: imaginary
    type:
      - 'null'
      - boolean
    doc: imaginary
    inputBinding:
      position: 103
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_zexp.out
