cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybel insert
label: pybel_insert
doc: "Insert molecules into a database.\n\nTool homepage: https://pybel.readthedocs.io"
inputs:
  - id: path
    type: string
    doc: Path to the database file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybel:0.13.2--py_0
stdout: pybel_insert.out
