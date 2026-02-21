cwlVersion: v1.2
class: CommandLineTool
baseCommand: hilinetojuicer
label: hilinetojuicer
doc: "The provided text is an error log from a container runtime and does not contain
  help information or usage instructions for the tool 'hilinetojuicer'.\n\nTool homepage:
  https://pypi.org/project/HiLineToJuicer/0.0.1/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hilinetojuicer:0.0.2--pyhdfd78af_0
stdout: hilinetojuicer.out
