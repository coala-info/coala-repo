cwlVersion: v1.2
class: CommandLineTool
baseCommand: classpro
label: classpro
doc: "A tool for protein classification (Note: The provided text contains system error
  logs rather than help documentation; no arguments could be extracted).\n\nTool homepage:
  https://github.com/yoshihikosuzuki/ClassPro/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/classpro:1.0.2--hda11466_1
stdout: classpro.out
