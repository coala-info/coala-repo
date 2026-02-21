cwlVersion: v1.2
class: CommandLineTool
baseCommand: sercol
label: sercol
doc: "The provided text is an error log from a container build process and does not
  contain help information or a description for the tool 'sercol'.\n\nTool homepage:
  https://github.com/openvax/sercol"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sercol:1.0.0--pyh7cba7a3_0
stdout: sercol.out
