cwlVersion: v1.2
class: CommandLineTool
baseCommand: gargammel-slim
label: gargammel-slim
doc: "A tool for simulating ancient DNA fragments (Note: The provided text contains
  system error messages regarding container execution and does not include the standard
  help documentation or usage instructions).\n\nTool homepage: https://github.com/grenaud/gargammel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gargammel-slim:1.1.2--hf107e4d_6
stdout: gargammel-slim.out
