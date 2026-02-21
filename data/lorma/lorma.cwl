cwlVersion: v1.2
class: CommandLineTool
baseCommand: lorma
label: lorma
doc: "The provided text does not contain help information or a description of the
  tool. It contains system log messages and a fatal error regarding disk space during
  a container build process.\n\nTool homepage: https://www.cs.helsinki.fi/u/lmsalmel/LoRMA/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorma:0.4--2
stdout: lorma.out
