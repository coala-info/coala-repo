cwlVersion: v1.2
class: CommandLineTool
baseCommand: irescue
label: irescue
doc: "The provided text does not contain help information. It contains error messages
  related to a failed container image build (no space left on device).\n\nTool homepage:
  https://github.com/bodegalab/irescue"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irescue:1.2.0--pyhdfd78af_0
stdout: irescue.out
