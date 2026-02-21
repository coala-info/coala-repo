cwlVersion: v1.2
class: CommandLineTool
baseCommand: epimetheus-py
label: epimetheus-py
doc: "A tool for processing or analyzing data (description not available in provided
  text)\n\nTool homepage: https://github.com/SebastianDall/epimetheus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epimetheus-py:0.7.7--py39hfa26904_0
stdout: epimetheus-py.out
