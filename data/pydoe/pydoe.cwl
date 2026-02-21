cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydoe
label: pydoe
doc: "Design of Experiments for Python (pyDOE)\n\nTool homepage: https://github.com/pydoe/pydoe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydoe:0.3.8--py35_0
stdout: pydoe.out
