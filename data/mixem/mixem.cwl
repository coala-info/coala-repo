cwlVersion: v1.2
class: CommandLineTool
baseCommand: mixem
label: mixem
doc: "Expectation-Maximization for Mixture Models. (Note: The provided help text contains
  system error messages and does not list specific command-line arguments.)\n\nTool
  homepage: https://github.com/sseemayer/mixem"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mixem:0.1.4--pyh5e36f6f_0
stdout: mixem.out
