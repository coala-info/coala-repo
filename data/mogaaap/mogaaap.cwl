cwlVersion: v1.2
class: CommandLineTool
baseCommand: mogaaap
label: mogaaap
doc: "Multi-Omics Genome-Agnostic Annotation and Analysis Pipeline (Note: The provided
  text is a system error log and does not contain usage instructions or argument definitions).\n
  \nTool homepage: https://github.com/dirkjanvw/MoGAAAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mogaaap:1.1.0--pyhdfd78af_0
stdout: mogaaap.out
