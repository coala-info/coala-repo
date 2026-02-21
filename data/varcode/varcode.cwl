cwlVersion: v1.2
class: CommandLineTool
baseCommand: varcode
label: varcode
doc: "The provided text does not contain help information or usage instructions for
  the tool 'varcode'. It contains system logs and a fatal error message related to
  a container build process.\n\nTool homepage: https://github.com/openvax/varcode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varcode:1.2.1--pyh7e72e81_0
stdout: varcode.out
