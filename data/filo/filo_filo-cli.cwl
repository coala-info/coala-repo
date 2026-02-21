cwlVersion: v1.2
class: CommandLineTool
baseCommand: filo
label: filo_filo-cli
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it contains system log messages and a fatal error regarding
  container image building.\n\nTool homepage: https://github.com/filodb/FiloDB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/filo:v1.1.0-3b1-deb_cv1
stdout: filo_filo-cli.out
