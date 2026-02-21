cwlVersion: v1.2
class: CommandLineTool
baseCommand: vg
label: vg
doc: "Variation Graph toolset for working with genome graphs\n\nTool homepage: https://github.com/vgteam/vg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
stdout: vg.out
