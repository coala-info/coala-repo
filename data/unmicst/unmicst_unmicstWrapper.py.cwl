cwlVersion: v1.2
class: CommandLineTool
baseCommand: unmicstWrapper.py
label: unmicst_unmicstWrapper.py
doc: "The provided text is a container engine error log and does not contain help
  information or argument definitions for the tool.\n\nTool homepage: https://github.com/labsyspharm/UnMicst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unmicst:2.6.6--pyh7e72e81_0
stdout: unmicst_unmicstWrapper.py.out
