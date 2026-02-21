cwlVersion: v1.2
class: CommandLineTool
baseCommand: mummer
label: mummer
doc: "MUMmer is a system for rapidly aligning entire genomes. (Note: The provided
  help text contains only system error messages and no usage information.)\n\nTool
  homepage: https://github.com/mummer4/mummer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321h503566f_21
stdout: mummer.out
