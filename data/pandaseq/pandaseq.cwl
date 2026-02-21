cwlVersion: v1.2
class: CommandLineTool
baseCommand: pandaseq
label: pandaseq
doc: "PAired-eND Assembler for DNA sequences (Note: The provided help text contains
  a runtime error regarding missing shared libraries and does not list available arguments.
  Arguments below are not available from the provided text.)\n\nTool homepage: https://github.com/neufeld/pandaseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pandaseq:2.11--1
stdout: pandaseq.out
