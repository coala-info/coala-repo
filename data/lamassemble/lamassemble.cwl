cwlVersion: v1.2
class: CommandLineTool
baseCommand: lamassemble
label: lamassemble
doc: "The provided text does not contain help information or a description of the
  tool. It contains system log messages and a fatal error regarding a container build
  failure (no space left on device).\n\nTool homepage: https://gitlab.com/mcfrith/lamassemble"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lamassemble:1.7.2--pyh7cba7a3_0
stdout: lamassemble.out
