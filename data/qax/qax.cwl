cwlVersion: v1.2
class: CommandLineTool
baseCommand: qax
label: qax
doc: "The provided text appears to be a log of a failed container build/execution
  rather than help text. No usage information or arguments were found.\n\nTool homepage:
  https://github.com/telatin/qax"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qax:0.9.8--h515fd9b_0
stdout: qax.out
