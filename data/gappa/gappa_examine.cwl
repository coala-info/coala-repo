cwlVersion: v1.2
class: CommandLineTool
baseCommand: gappa examine
label: gappa_examine
doc: "Commands for examining, visualizing, and tabulating information in placement
  data.\n\nTool homepage: https://github.com/lczech/gappa"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to run
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
stdout: gappa_examine.out
