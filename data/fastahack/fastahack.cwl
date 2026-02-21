cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastahack
label: fastahack
doc: "No description available in the provided text.\n\nTool homepage: https://github.com/ekg/fastahack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastahack:2016.07.2--0
stdout: fastahack.out
