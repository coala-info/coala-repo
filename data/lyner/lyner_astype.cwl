cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - astype
label: lyner_astype
doc: "Convert data to a specified type.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: type
    type: string
    doc: The target data type.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_astype.out
