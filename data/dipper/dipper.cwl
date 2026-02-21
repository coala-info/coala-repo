cwlVersion: v1.2
class: CommandLineTool
baseCommand: dipper
label: dipper
doc: "A tool for generating RDF graphs from various biological data sources.\n\nTool
  homepage: https://github.com/TurakhiaLab/DIPPER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dipper:0.1.3--h6bb9b41_0
stdout: dipper.out
