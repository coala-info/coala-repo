cwlVersion: v1.2
class: CommandLineTool
baseCommand: frc_align
label: frc_align
doc: "The provided text does not contain help information or usage instructions; it
  consists of system log messages and a fatal error regarding container image retrieval
  and disk space.\n\nTool homepage: https://github.com/vezzi/FRC_align"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frc:5b3f53e--boost1.64_0
stdout: frc_align.out
