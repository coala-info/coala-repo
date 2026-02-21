cwlVersion: v1.2
class: CommandLineTool
baseCommand: sidr
label: sidr
doc: "The provided text does not contain help information or a description for the
  tool 'sidr'. It appears to be an error log from a container build process.\n\nTool
  homepage: https://github.com/damurdock/SIDR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sidr:0.0.2a2--pyh3252c3a_0
stdout: sidr.out
