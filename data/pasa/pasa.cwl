cwlVersion: v1.2
class: CommandLineTool
baseCommand: pasa
label: pasa
doc: "Program to Assemble Spliced Alignments (Note: The provided text contains system
  error messages regarding disk space and container image retrieval rather than tool
  help documentation).\n\nTool homepage: https://pasapipeline.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pasa:2.5.3--h9948957_2
stdout: pasa.out
