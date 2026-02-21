cwlVersion: v1.2
class: CommandLineTool
baseCommand: escher-fluxomics
label: escher-fluxomics
doc: "A tool for fluxomics visualization using Escher. Note: The provided help text
  contains only system error messages regarding container image building and does
  not list specific command-line arguments.\n\nTool homepage: https://escher.github.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/escher-fluxomics:phenomenal-v1.6.0-beta.4_cv1.1.20
stdout: escher-fluxomics.out
