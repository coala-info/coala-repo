cwlVersion: v1.2
class: CommandLineTool
baseCommand: filo_sbt
label: filo_sbt
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image building (no space left on device).\n\nTool homepage: https://github.com/filodb/FiloDB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/filo:v1.1.0-3b1-deb_cv1
stdout: filo_sbt.out
