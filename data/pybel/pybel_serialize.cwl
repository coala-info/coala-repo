cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybel_serialize
label: pybel_serialize
doc: "Serialize a graph to a file.\n\nTool homepage: https://pybel.readthedocs.io"
inputs:
  - id: path
    type: File
    doc: Path to serialize the graph to
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybel:0.13.2--py_0
stdout: pybel_serialize.out
