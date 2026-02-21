cwlVersion: v1.2
class: CommandLineTool
baseCommand: viromeqc_viromeQC.py
label: viromeqc_viromeQC.py
doc: "Virome Quality Control tool (Note: The provided text is a container execution
  error log and does not contain help information or argument definitions).\n\nTool
  homepage: https://github.com/SegataLab/viromeqc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viromeqc:1.0.2--py310h7cba7a3_0
stdout: viromeqc_viromeQC.py.out
