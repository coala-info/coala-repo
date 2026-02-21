cwlVersion: v1.2
class: CommandLineTool
baseCommand: staden
label: staden
doc: "The Staden Package is a fully developed set of DNA sequence assembly (Gap4 and
  Gap5), editing and analysis tools (Spin).\n\nTool homepage: https://github.com/oshikiri/staden-outliner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/staden:v2.0.0b11-4-deb_cv1
stdout: staden.out
