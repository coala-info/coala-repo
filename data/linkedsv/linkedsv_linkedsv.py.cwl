cwlVersion: v1.2
class: CommandLineTool
baseCommand: linkedsv.py
label: linkedsv_linkedsv.py
doc: "LinkedSV is a tool for structural variant calling. (Note: The provided text
  contains system error messages and does not list command-line arguments.)\n\nTool
  homepage: https://github.com/WGLab/LinkedSV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/linkedsv:0.1.0--h077b44d_0
stdout: linkedsv_linkedsv.py.out
