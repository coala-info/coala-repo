cwlVersion: v1.2
class: CommandLineTool
baseCommand: hivtrace
label: hivtrace
doc: "The provided text does not contain help information or usage instructions for
  hivtrace. It contains system log messages and a fatal error regarding a container
  build failure (no space left on device).\n\nTool homepage: https://github.com/veg/hivtrace"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hivtrace:1.5.0--py_0
stdout: hivtrace.out
