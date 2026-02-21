cwlVersion: v1.2
class: CommandLineTool
baseCommand: te-aid
label: te-aid
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process.\n\nTool homepage: https://github.com/clemgoub/TE-Aid/tree/v{version}"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/te-aid:1.0.0--hdfd78af_0
stdout: te-aid.out
