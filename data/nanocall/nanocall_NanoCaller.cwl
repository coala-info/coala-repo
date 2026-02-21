cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanocall
label: nanocall_NanoCaller
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding container image acquisition
  (no space left on device).\n\nTool homepage: https://github.com/WGLab/NanoCaller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanocall:v0.7.4--0
stdout: nanocall_NanoCaller.out
