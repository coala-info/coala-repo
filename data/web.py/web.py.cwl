cwlVersion: v1.2
class: CommandLineTool
baseCommand: web.py
label: web.py
doc: "A web framework for Python\n\nTool homepage: https://github.com/bottlepy/bottle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/web.py:0.37--py27_1
stdout: web.py.out
