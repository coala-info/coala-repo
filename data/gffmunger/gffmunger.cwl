cwlVersion: v1.2
class: CommandLineTool
baseCommand: gffmunger
label: gffmunger
doc: "A tool for processing or 'munging' GFF (General Feature Format) files.\n\nTool
  homepage: https://github.com/sanger-pathogens/gffmunger"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gffmunger:0.1.3--py_0
stdout: gffmunger.out
