cwlVersion: v1.2
class: CommandLineTool
baseCommand: papy
label: papy
doc: "No description available from the provided error logs.\n\nTool homepage: https://github.com/papyros/papyros-shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/papy:phenomenal-v2.0_cv1.0.28
stdout: papy.out
