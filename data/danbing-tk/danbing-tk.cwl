cwlVersion: v1.2
class: CommandLineTool
baseCommand: danbing-tk
label: danbing-tk
doc: "A toolkit for VNTR (Variable Number Tandem Repeat) genotyping. Note: The provided
  input text contains container runtime error logs rather than the tool's help documentation.\n
  \nTool homepage: https://github.com/ChaissonLab/danbing-tk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/danbing-tk:1.3.2.5--h9948957_0
stdout: danbing-tk.out
