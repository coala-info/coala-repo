cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pybel
  - summarize
label: pybel_summarize
doc: "Summarize a chemical file.\n\nTool homepage: https://pybel.readthedocs.io"
inputs:
  - id: path
    type: File
    doc: Path to the chemical file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybel:0.13.2--py_0
stdout: pybel_summarize.out
