cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - /usr/local/bin/colord
  - info
label: colord_info
doc: "print archive informations\n\nTool homepage: https://github.com/refresh-bio/colord"
inputs:
  - id: input
    type: File
    doc: archive path
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/colord:1.1.0--h9ee0642_0
stdout: colord_info.out
