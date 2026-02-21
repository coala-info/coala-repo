cwlVersion: v1.2
class: CommandLineTool
baseCommand: relecov-tools
label: relecov-tools
doc: "The provided text does not contain help information for relecov-tools; it is
  a log of a failed container build process.\n\nTool homepage: https://github.com/BU-ISCIII/relecov-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
stdout: relecov-tools.out
