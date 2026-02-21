cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymvpa
label: pymvpa
doc: "PyMVPA (Multivariate Pattern Analysis in Python) is a Python package intended
  to ease statistical learning analyses of large datasets.\n\nTool homepage: http://www.pymvpa.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymvpa:2.6.5--py36h355e19c_0
stdout: pymvpa.out
