cwlVersion: v1.2
class: CommandLineTool
baseCommand: platypus-conquistador
label: platypus-conquistador
doc: "A tool for variant calling (Note: The provided text is an error log and does
  not contain usage information or argument descriptions).\n\nTool homepage: https://github.com/biocore/Platypus-Conquistador"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/platypus-conquistador:0.9.0--py27_0
stdout: platypus-conquistador.out
