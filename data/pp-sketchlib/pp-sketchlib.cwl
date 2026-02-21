cwlVersion: v1.2
class: CommandLineTool
baseCommand: pp-sketchlib
label: pp-sketchlib
doc: "A library for sketching and calculating core and accessory distances between
  genomic sequences.\n\nTool homepage: https://github.com/johnlees/pp-sketchlib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pp-sketchlib:1.1.0--py37hcaab5c4_2
stdout: pp-sketchlib.out
