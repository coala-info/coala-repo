cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwise
label: bwise
doc: "The provided text contains system error messages related to a container runtime
  (Singularity/Apptainer) and does not contain the help text or usage information
  for the tool 'bwise'.\n\nTool homepage: https://github.com/Malfoy/BWISE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwise:1.0.0--h8b12597_0
stdout: bwise.out
