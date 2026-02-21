cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmlong2-lite
label: mmlong2-lite
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error indicating a failure to build the
  container image due to insufficient disk space.\n\nTool homepage: https://github.com/Serka-M/mmlong2-lite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmlong2-lite:1.2.1--hdfd78af_0
stdout: mmlong2-lite.out
