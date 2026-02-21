cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycsg
label: pycsg
doc: "Constructive Solid Geometry (CSG) library for Python\n\nTool homepage: https://github.com/timknip/pycsg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycsg:0.3.12--py36_0
stdout: pycsg.out
