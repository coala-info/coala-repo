cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymvpa2
label: pymvpa_pymvpa2
doc: "Multivariate Pattern Analysis in Python (PyMVPA). Note: The provided text contains
  container runtime logs and error messages rather than command-line help documentation.\n
  \nTool homepage: http://www.pymvpa.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymvpa:2.6.5--py36h355e19c_0
stdout: pymvpa_pymvpa2.out
