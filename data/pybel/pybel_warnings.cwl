cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pybel
  - warnings
label: pybel_warnings
doc: "List warnings from a graph.\n\nTool homepage: https://pybel.readthedocs.io"
inputs:
  - id: path
    type: File
    doc: "Compiled graph pickle written by pybel compile (a BEL script path also works when its compiled pickle is beside it)"
    inputBinding:
      position: 1
outputs:
  - id: stdout_text
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybel:0.13.2--py_0
stdout: pybel_warnings.out
