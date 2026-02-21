cwlVersion: v1.2
class: CommandLineTool
baseCommand: renano
label: renano
doc: "Reference-based compressor for Nanopore data (Note: The provided text is a container
  build log and does not contain help documentation or argument definitions).\n\n
  Tool homepage: https://github.com/guilledufort/RENANO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/renano:1.3--h077b44d_4
stdout: renano.out
