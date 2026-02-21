cwlVersion: v1.2
class: CommandLineTool
baseCommand: fusioncatcher-seqtk
label: fusioncatcher-seqtk
doc: "A tool for processing biological sequences (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  https://github.com/ndaniel/seqtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fusioncatcher-seqtk:1.2--h577a1d6_7
stdout: fusioncatcher-seqtk.out
