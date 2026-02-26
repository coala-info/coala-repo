cwlVersion: v1.2
class: CommandLineTool
baseCommand: leviosam
label: leviosam_lift
doc: "lifting over alignments\n\nTool homepage: https://github.com/alshai/levioSAM"
inputs:
  - id: command
    type: string
    doc: Command to execute (index, lift, collate, bed, reconcile)
    inputBinding:
      position: 1
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: Verbose level
    default: 0
    inputBinding:
      position: 102
      prefix: -V
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviosam:5.2.1--h4ac6f70_2
stdout: leviosam_lift.out
