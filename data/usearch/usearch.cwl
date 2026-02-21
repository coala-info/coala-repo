cwlVersion: v1.2
class: CommandLineTool
baseCommand: usearch
label: usearch
doc: "The provided text is a container engine error log and does not contain CLI help
  information or usage instructions for the tool.\n\nTool homepage: https://github.com/rcedgar/usearch12"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/usearch:12.0_beta--h9ee0642_1
stdout: usearch.out
