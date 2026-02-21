cwlVersion: v1.2
class: CommandLineTool
baseCommand: mehari
label: mehari
doc: "Mehari is a tool for variant effect prediction. (Note: The provided text contains
  container runtime error messages rather than tool help text, so no arguments could
  be extracted.)\n\nTool homepage: https://github.com/bihealth/mehari"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
stdout: mehari.out
