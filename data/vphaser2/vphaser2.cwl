cwlVersion: v1.2
class: CommandLineTool
baseCommand: vphaser2
label: vphaser2
doc: 'V-Phaser 2 is a variant caller for viral populations. Note: The provided text
  contains system error logs rather than tool help documentation.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vphaser2:2.0--h2bd4fab_16
stdout: vphaser2.out
