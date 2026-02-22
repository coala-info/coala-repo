cwlVersion: v1.2
class: CommandLineTool
baseCommand: colormath
label: colormath
doc: "A python module that abstracts common color math operations.\n\nTool homepage:
  https://github.com/gtaylor/python-colormath"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/colormath:v3.0.0-1-deb-py3_cv1
stdout: colormath.out
