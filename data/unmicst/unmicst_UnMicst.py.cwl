cwlVersion: v1.2
class: CommandLineTool
baseCommand: unmicst_UnMicst.py
label: unmicst_UnMicst.py
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error logs.\n\nTool homepage: https://github.com/labsyspharm/UnMicst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unmicst:2.6.6--pyh7e72e81_0
stdout: unmicst_UnMicst.py.out
