cwlVersion: v1.2
class: CommandLineTool
baseCommand: sure
label: sure
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it contains log messages and a fatal error related to an OCI
  image build process.\n\nTool homepage: http://github.com/gabrielfalcao/sure"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sure:2.0.1--pyh7cba7a3_0
stdout: sure.out
