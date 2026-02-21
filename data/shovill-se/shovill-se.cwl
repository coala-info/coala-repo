cwlVersion: v1.2
class: CommandLineTool
baseCommand: shovill-se
label: shovill-se
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error regarding a container build failure.\n
  \nTool homepage: https://github.com/rpetit3/shovill"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shovill-se:1.1.0se--hdfd78af_2
stdout: shovill-se.out
