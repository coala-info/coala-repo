cwlVersion: v1.2
class: CommandLineTool
baseCommand: ac-diamond
label: ac-diamond
doc: "The provided text does not contain help information for ac-diamond; it is a
  log of a failed container image build due to insufficient disk space.\n\nTool homepage:
  https://github.com/Maihj/AC-DIAMOND"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ac-diamond:1.0--boost1.64_0
stdout: ac-diamond.out
