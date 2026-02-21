cwlVersion: v1.2
class: CommandLineTool
baseCommand: dart_build
label: dart_build
doc: "The provided text appears to be an error log from a container build process
  (Apptainer/Singularity) rather than CLI help text. No usage information or arguments
  could be extracted.\n\nTool homepage: https://github.com/hsinnan75/Dart"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dart:1.4.6--h13024bc_7
stdout: dart_build.out
