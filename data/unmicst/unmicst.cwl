cwlVersion: v1.2
class: CommandLineTool
baseCommand: unmicst
label: unmicst
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build/execution attempt.\n\nTool homepage:
  https://github.com/labsyspharm/UnMicst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unmicst:2.6.6--pyh7e72e81_0
stdout: unmicst.out
