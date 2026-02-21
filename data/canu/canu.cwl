cwlVersion: v1.2
class: CommandLineTool
baseCommand: canu
label: canu
doc: "A hierarchical assembler for single-molecule sequencing (no help text provided
  in input, text contains container runtime errors)\n\nTool homepage: https://github.com/marbl/canu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/canu:2.3--h3fb4750_2
stdout: canu.out
