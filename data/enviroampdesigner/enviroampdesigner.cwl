cwlVersion: v1.2
class: CommandLineTool
baseCommand: enviroampdesigner
label: enviroampdesigner
doc: "A tool for designing environmental DNA (eDNA) amplicons.\n\nTool homepage: https://github.com/AntonS-bio/EnviroAmpDesigner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enviroampdesigner:0.1.3--pyhdfd78af_0
stdout: enviroampdesigner.out
