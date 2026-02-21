cwlVersion: v1.2
class: CommandLineTool
baseCommand: sigmut
label: sigmut
doc: "The provided text does not contain help or usage information; it is an error
  log from a container build process. No arguments could be extracted.\n\nTool homepage:
  https://github.com/lgpdv/sigmut"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sigmut:1.0--hdfd78af_2
stdout: sigmut.out
