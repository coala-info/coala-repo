cwlVersion: v1.2
class: CommandLineTool
baseCommand: svd
label: bart_svd
doc: "Compute singular-value-decomposition (SVD).\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: input
    type: string
    doc: input
    inputBinding:
      position: 1
  - id: u
    type: string
    doc: U
    inputBinding:
      position: 2
  - id: s
    type: string
    doc: S
    inputBinding:
      position: 3
  - id: vh
    type: string
    doc: VH
    inputBinding:
      position: 4
  - id: econ
    type:
      - 'null'
      - boolean
    doc: econ
    inputBinding:
      position: 105
      prefix: -e
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_svd.out
