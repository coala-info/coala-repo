cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdo
label: cdo
doc: "Climate Data Operators\n\nTool homepage: https://github.com/cxong/cdogs-sdl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdo:2.0.0
stdout: cdo.out
