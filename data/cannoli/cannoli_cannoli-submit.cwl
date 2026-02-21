cwlVersion: v1.2
class: CommandLineTool
baseCommand: cannoli-submit
label: cannoli_cannoli-submit
doc: "A tool for submitting Cannoli jobs. (Note: The provided help text contains only
  system error logs and does not list specific command-line arguments.)\n\nTool homepage:
  https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_cannoli-submit.out
