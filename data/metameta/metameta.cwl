cwlVersion: v1.2
class: CommandLineTool
baseCommand: metameta
label: metameta
doc: "A tool for metagenomic analysis (Note: The provided text contains container
  runtime error logs rather than command-line help documentation).\n\nTool homepage:
  https://github.com/pirovc/metameta/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metameta:1.2.0--2
stdout: metameta.out
