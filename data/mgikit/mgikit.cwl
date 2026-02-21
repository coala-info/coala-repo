cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgikit
label: mgikit
doc: "MGI data processing toolkit (Note: The provided text is a system error message
  and does not contain tool-specific help information or arguments).\n\nTool homepage:
  https://sagc-bioinformatics.github.io/mgikit/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgikit:2.1.1--h3ab6199_0
stdout: mgikit.out
