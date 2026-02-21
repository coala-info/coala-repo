cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoplotter
label: nanoplotter
doc: "A tool for plotting Oxford Nanopore data (Note: The provided input text contains
  container execution errors rather than the tool's help documentation).\n\nTool homepage:
  https://github.com/wdecoster/nanoplotter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoplotter:1.10.0--py_0
stdout: nanoplotter.out
