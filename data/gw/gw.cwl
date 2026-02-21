cwlVersion: v1.2
class: CommandLineTool
baseCommand: gw
label: gw
doc: "A tool for genomic visualization (Note: The provided text contains system error
  messages and does not include the tool's help documentation).\n\nTool homepage:
  https://github.com/kcleal/gw"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gw:1.2.6--hff18be8_0
stdout: gw.out
