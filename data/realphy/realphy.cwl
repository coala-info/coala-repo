cwlVersion: v1.2
class: CommandLineTool
baseCommand: realphy
label: realphy
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error related to a container build process.\n
  \nTool homepage: https://realphy.unibas.ch/fcgi/realphy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/realphy:1.13--hdfd78af_1
stdout: realphy.out
