cwlVersion: v1.2
class: CommandLineTool
baseCommand: dinamo
label: dinamo
doc: "A tool for DNA motif discovery (Note: The provided text contains container runtime
  errors and does not include the tool's help documentation).\n\nTool homepage: https://github.com/bonsai-team/DiNAMO/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dinamo:1.0--h9948957_8
stdout: dinamo.out
