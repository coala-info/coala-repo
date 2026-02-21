cwlVersion: v1.2
class: CommandLineTool
baseCommand: denovogear_dng
label: denovogear_dng
doc: "DeNovoGear: a software package for de novo mutation analysis.\n\nTool homepage:
  https://github.com/ultimatesource/denovogear"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/denovogear:1.1.1--boost1.60_0
stdout: denovogear_dng.out
