cwlVersion: v1.2
class: CommandLineTool
baseCommand: prot-scriber
label: prot-scriber
doc: "A tool for protein-related processing (description unavailable from provided
  logs)\n\nTool homepage: https://github.com/usadellab/prot-scriber"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prot-scriber:0.1.6--hc1c3326_2
stdout: prot-scriber.out
