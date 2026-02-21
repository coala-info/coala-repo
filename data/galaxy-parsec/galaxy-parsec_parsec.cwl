cwlVersion: v1.2
class: CommandLineTool
baseCommand: parsec
label: galaxy-parsec_parsec
doc: "A command-line interface for interacting with Galaxy APIs.\n\nTool homepage:
  https://github.com/galaxy-iuc/parsec"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-parsec:1.16.0--pyh5e36f6f_0
stdout: galaxy-parsec_parsec.out
