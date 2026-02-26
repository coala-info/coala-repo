cwlVersion: v1.2
class: CommandLineTool
baseCommand: samsifter
label: samsifter
doc: "samsifter: error: argument -h/--help: ignored explicit argument 'elp'"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: -d
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
stdout: samsifter.out
