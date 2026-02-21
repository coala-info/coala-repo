cwlVersion: v1.2
class: CommandLineTool
baseCommand: hilive
label: hilive
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image building (no space
  left on device).\n\nTool homepage: https://github.com/wtv-filipa/AppHiLives"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hilive:v1.1-2-deb_cv1
stdout: hilive.out
