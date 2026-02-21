cwlVersion: v1.2
class: CommandLineTool
baseCommand: primerforge
label: primerforge
doc: "The provided text does not contain help information for the tool 'primerforge'.
  It contains error messages related to a container image build process.\n\nTool homepage:
  https://github.com/dr-joe-wirth/primerForge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primerforge:1.5.3--pyhdfd78af_0
stdout: primerforge.out
