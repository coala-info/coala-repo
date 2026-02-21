cwlVersion: v1.2
class: CommandLineTool
baseCommand: nim-abif
label: nim-abif
doc: "The provided text does not contain help information or usage instructions for
  nim-abif. It contains container runtime log messages and a fatal error regarding
  disk space.\n\nTool homepage: https://github.com/quadram-institute-bioscience/nim-abif"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nim-abif:0.2.0--h7b50bb2_0
stdout: nim-abif.out
