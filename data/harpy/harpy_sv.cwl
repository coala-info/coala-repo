cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - sv
label: harpy_sv
doc: "Call inversions, deletions, and duplications from alignments using LEVIATHAN
  or NAIBR.\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs:
  - id: command
    type: string
    doc: The variant caller subcommand to use (leviathan or naibr)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
stdout: harpy_sv.out
