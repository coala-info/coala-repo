cwlVersion: v1.2
class: CommandLineTool
baseCommand: merfin
label: merfin
doc: "K-mer based variant filtering, polishing and evaluation tool\n\nTool homepage:
  https://github.com/arangrhie/merfin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merfin:1.0--h9948957_3
stdout: merfin.out
