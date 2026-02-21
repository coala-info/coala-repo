cwlVersion: v1.2
class: CommandLineTool
baseCommand: dart
label: dart
doc: "The provided text does not contain help information or usage instructions. It
  is a system error log indicating a failure to build or extract a container image
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/hsinnan75/Dart"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dart:1.4.6--h13024bc_7
stdout: dart.out
