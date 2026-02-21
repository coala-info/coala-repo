cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitgard
label: mitgard
doc: "The provided text does not contain help information or usage instructions; it
  consists of system log messages and a fatal error regarding disk space during a
  container image pull.\n\nTool homepage: https://github.com/pedronachtigall/MITGARD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitgard:1.1--hdfd78af_0
stdout: mitgard.out
