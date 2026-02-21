cwlVersion: v1.2
class: CommandLineTool
baseCommand: kinamine_y_shaker
label: kinamine_y_shaker
doc: "Kinamine Y Shaker (Note: The provided text is an error log and does not contain
  tool help information or usage instructions)\n\nTool homepage: https://github.com/LaurieParkerLab/KinamineY-shaker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kinamine_y_shaker:1.0.0--hdfd78af_1
stdout: kinamine_y_shaker.out
